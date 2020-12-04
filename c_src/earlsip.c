#include <erl_nif.h>
#include <stdint.h>
#include "SipHash/siphash.c"

ERL_NIF_TERM badarg;

static int load(ErlNifEnv* env, void** priv_data, ERL_NIF_TERM load_info)
{
    badarg = enif_make_badarg(env);
    return 0;
}

static ERL_NIF_TERM siphash_c(ErlNifEnv *env, int argc, const ERL_NIF_TERM argv[])
{
    ErlNifBinary key;
    ErlNifBinary message;
    ErlNifBinary hash;

    if (argc != 2) {
        return enif_make_badarg(env);
    }

    if (enif_inspect_binary(env, argv[0], &key) == 0 ||
        key.size != 16U) {
        return enif_make_badarg(env);
    }
    if (enif_inspect_binary(env, argv[1], &message) == 0 ||
        message.size == 0U) {
        return enif_make_badarg(env);
    }

    enif_alloc_binary(8, &hash);

    siphash(message.data, message.size, key.data, hash.data, hash.size);
    return enif_make_binary(env, &hash);
}

static ErlNifFunc nifs[] = {
    {"siphash", 2, siphash_c},
};

ERL_NIF_INIT(earlsip_nif, nifs, load, NULL, NULL, NULL);
