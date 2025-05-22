Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA97B19ABD8;
	Thu, 22 May 2025 17:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747936609; cv=none; b=WczRD653UWykw7eeQ6gPF2acgAj3xkkxr7UQprKE9FlxBXcSmqWc3a90oWX+Mj85LvhQAp6ztEsZWFXE6uFeQbvBZAo9euOhJshoEOWu5zNDlHLvbYMP+9AXCSrMMZZW+pMxsHUeiyEsiGBWvbkMlHBmwCgrxTQZB/Gy+vHs2bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747936609; c=relaxed/simple;
	bh=4G7HKlnYzqOyqT3PwXNh3VoXc5qbeOTbfTuBuxgoag8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HaBMp8o27fQSWggnM4enbyU7F6nQ4tTMJcQmagAC3IIt2A7TPZoZPeNSG7+TySrmzoagGj05KSvRITPgmWwPHPViJI76chqsiWCR2Kxs/bjFv1eUXUWQKECFLx0+E20QuWVWNIJXMqurmhZaYe4lijWEF8DdMp+str5FtZn3yV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vOYgcR2u; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vOYgcR2u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA446C4CEE4;
	Thu, 22 May 2025 17:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747936609;
	bh=4G7HKlnYzqOyqT3PwXNh3VoXc5qbeOTbfTuBuxgoag8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vOYgcR2uqMGWHlPxFubBy3Zknpd6dOwCk43BoK9gVUvGgGWWzGLtvCU8laPmuM9xE
	 CDU0MSTE4Eh9Z1qIuKes6DVH+94bzwxpScySn2PZmF/oXvjFXmZtNmf7t0cTUjgTm1
	 +bwO2kpLSuM8EYiEtIGZcvKzpAfz5tN5mIYgvP003PTh6t1d97R4m6YY5QJCSy3NK0
	 m7ceeRoywSfv6GrUjyFl9iPX9cJ14ob9pH+xj3Ci6I1VUuBQovtBP9xBK/OKDUjAmC
	 MTsN5PoFAyjbqKDZcpGdrLeDXd7CHLwAJnEX4jjPkkVD12lR0cQbmo1eFZsuvgBFHJ
	 pXRAOowGvOm5Q==
Date: Thu, 22 May 2025 14:56:46 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Yuzhuo Jing <yuzhuo@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Liang Kan <kan.liang@linux.intel.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	James Clark <james.clark@linaro.org>,
	Tomas Glozar <tglozar@redhat.com>, Leo Yan <leo.yan@arm.com>,
	Guilherme Amadio <amadio@gentoo.org>,
	Yang Jihong <yangjihong@bytedance.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Adhemerval Zanella <adhemerval.zanella@linaro.org>,
	Wei Yang <richard.weiyang@gmail.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Kajol Jain <kjain@linux.ibm.com>,
	Aditya Gupta <adityag@linux.ibm.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	"Steinar H. Gunderson" <sesse@google.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v1 2/4] perf tools: Add sha1 utils
Message-ID: <aC9lXhPFcs5fkHWH@x1>
References: <20250521225307.743726-1-yuzhuo@google.com>
 <20250521225307.743726-3-yuzhuo@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250521225307.743726-3-yuzhuo@google.com>

On Wed, May 21, 2025 at 03:53:05PM -0700, Yuzhuo Jing wrote:
> Those new files are derived from the kernel tree, namely:
> 
>   tools/perf/util/sha1.c          from  lib/crypto/sha1.c
>   tools/perf/util/sha1.h          from  include/crypto/sha1.h
>   tools/perf/util/sha1_base.h     from  include/crypto/sha1_base.h
>   tools/perf/util/sha1_generic.c  from  crypto/sha1_generic.c
> 
> The reason that we are not syncing them with the kernel tree like other
> tools header files is because of the deep dependency in
> include/crypto/hash.h.  It's painful to import the whole kernel crypto
> driver infrastructure into tools.

This is failing:

⬢ [acme@toolbx perf-tools-next]$ git log --oneline -1 ; time make -C tools/perf build-test
<SNIP>
           make_no_scripts_O: cd . && make NO_LIBPYTHON=1 NO_LIBPERL=1 FEATURES_DUMP=/home/acme/git/perf-tools-next/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.aknNhb7DZp DESTDIR=/tmp/tmp.8qecgbhwKa
          make_extra_tests_O: cd . && make EXTRA_TESTS=1 FEATURES_DUMP=/home/acme/git/perf-tools-next/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.C1nM6OCHSS DESTDIR=/tmp/tmp.iWigrG5sDJ
                make_debug_O: cd . && make DEBUG=1 FEATURES_DUMP=/home/acme/git/perf-tools-next/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.z8p7Unts6E DESTDIR=/tmp/tmp.k9856UvMRF
cd . && make DEBUG=1 FEATURES_DUMP=/home/acme/git/perf-tools-next/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.z8p7Unts6E DESTDIR=/tmp/tmp.k9856UvMRF
  BUILD:   Doing 'make -j32' parallel build
Warning: Kernel ABI header differences:
  diff -u tools/arch/arm64/include/asm/cputype.h arch/arm64/include/asm/cputype.h
Makefile.config:955: No libllvm 13+ found, slower source file resolution, please install llvm-devel/llvm-dev
Makefile.config:1134: No openjdk development package found, please install JDK package, e.g. openjdk-8-jdk, java-1.8.0-openjdk-devel

  GEN     /tmp/tmp.z8p7Unts6E/common-cmds.h
  CC      /tmp/tmp.z8p7Unts6E/dlfilters/dlfilter-test-api-v0.o
  CC      /tmp/tmp.z8p7Unts6E/dlfilters/dlfilter-test-api-v2.o
<SNIP>
  CC      /tmp/tmp.z8p7Unts6E/util/strlist.o
  CC      /tmp/tmp.z8p7Unts6E/tests/demangle-java-test.o
  LD      /tmp/tmp.z8p7Unts6E/trace/beauty/tracepoints/perf-in.o
In file included from util/sha1_generic.c:18:
util/sha1_base.h: In function ‘sha1_base_do_finalize’:
util/sha1_base.h:77:21: error: comparison of integer expressions of different signedness: ‘unsigned int’ and ‘int’ [-Werror=sign-compare]
   77 |         if (partial > bit_offset) {
      |                     ^
cc1: all warnings being treated as errors
  CC      /tmp/tmp.z8p7Unts6E/tests/demangle-ocaml-test.o
  CC      /tmp/tmp.z8p7Unts6E/util/strfilter.o
make[6]: *** [/home/acme/git/perf-tools-next/tools/build/Makefile.build:86: /tmp/tmp.z8p7Unts6E/util/sha1_generic.o] Error 1
make[6]: *** Waiting for unfinished jobs....
  LD      /tmp/tmp.z8p7Unts6E/trace/beauty/perf-in.o
  CC      /tmp/tmp.z8p7Unts6E/tests/demangle-rust-v0-test.o
<SNIP>
  LD      /tmp/tmp.z8p7Unts6E/util/scripting-engines/perf-util-in.o
make[5]: *** [/home/acme/git/perf-tools-next/tools/build/Makefile.build:142: util] Error 2
make[4]: *** [Makefile.perf:795: /tmp/tmp.z8p7Unts6E/perf-util-in.o] Error 2
make[4]: *** Waiting for unfinished jobs....
  CC      /tmp/tmp.z8p7Unts6E/pmu-events/pmu-events.o
  LD      /tmp/tmp.z8p7Unts6E/pmu-events/pmu-events-in.o
make[3]: *** [Makefile.perf:287: sub-make] Error 2
make[2]: *** [Makefile:76: all] Error 2
make[1]: *** [tests/make:339: make_debug_O] Error 1
make: *** [Makefile:109: build-test] Error 2
make: Leaving directory '/home/acme/git/perf-tools-next/tools/perf'

real	2m10.250s
user	20m47.352s
sys	3m50.484s
⬢ [acme@toolbx perf-tools-next]$

Humm that part is the same as in the kernel...

⬢ [acme@toolbx perf-tools-next]$ line=$(ctags -x --c-kinds=f include/crypto/sha1_base.h | awk '$1 == "sha1_base_do_finalize" {print $3}')
⬢ [acme@toolbx perf-tools-next]$ sed -n $line,\$p include/crypto/sha1_base.h | awk '{print} /\{/ {c++} /\}/ {c--; if (c==0) exit}' > /tmp/original
⬢ [acme@toolbx perf-tools-next]$ line=$(ctags -x --c-kinds=f tools/perf/util/sha1_base.h | awk '$1 == "sha1_base_do_finalize" {print $3}')
⬢ [acme@toolbx perf-tools-next]$ sed -n $line,\$p include/crypto/sha1_base.h | awk '{print} /\{/ {c++} /\}/ {c--; if (c==0) exit}' > /tmp/copy
⬢ [acme@toolbx perf-tools-next]$ diff -u /tmp/original /tmp/copy
--- /tmp/original	2025-05-22 14:48:31.338406860 -0300
+++ /tmp/copy	2025-05-22 14:48:58.401603439 -0300
@@ -1,3 +1,7 @@
+
+	return 0;
+}
+
 static inline int sha1_base_do_finalize(struct shash_desc *desc,
 					sha1_block_fn *block_fn)
 {
@@ -13,10 +17,3 @@
 
 		block_fn(sctx, sctx->buffer, 1);
 	}
-
-	memset(sctx->buffer + partial, 0x0, bit_offset - partial);
-	*bits = cpu_to_be64(sctx->count << 3);
-	block_fn(sctx, sctx->buffer, 1);
-
-	return 0;
-}
⬢ [acme@toolbx perf-tools-next]$ 

If I try the quick fix:

⬢ [acme@toolbx perf-tools-next]$ git diff
diff --git a/tools/perf/util/sha1_base.h b/tools/perf/util/sha1_base.h
index cea22c5a49520998..5994c55748e40a79 100644
--- a/tools/perf/util/sha1_base.h
+++ b/tools/perf/util/sha1_base.h
@@ -71,7 +71,7 @@ static inline int sha1_base_do_finalize(struct sha1_state *sctx,
 {
        const int bit_offset = SHA1_BLOCK_SIZE - sizeof(__be64);
        __be64 *bits = (__be64 *)(sctx->buffer + bit_offset);
-       unsigned int partial = sctx->count % SHA1_BLOCK_SIZE;
+       int partial = sctx->count % SHA1_BLOCK_SIZE;
 
        sctx->buffer[partial++] = 0x80;
        if (partial > bit_offset) {
⬢ [acme@toolbx perf-tools-next]$

IT works, to test it quicker try, before the above:

$ make -C tools/perf -f tests/make make_debug
<SNIP>
 CC      util/bpf_map.o
In file included from util/sha1_generic.c:18:
util/sha1_base.h: In function ‘sha1_base_do_finalize’:
util/sha1_base.h:77:21: error: comparison of integer expressions of different signedness: ‘unsigned int’ and ‘int’ [-Werror=sign-compare]
   77 |         if (partial > bit_offset) {
      |                     ^
cc1: all warnings being treated as errors
<SNIP>

After the above patch:

⬢ [acme@toolbx perf-tools-next]$ rm -f tools/perf/make_debug tools/perf/make_debug_O
⬢ [acme@toolbx perf-tools-next]$ make -C tools/perf -f tests/make make_debug
make: Entering directory '/home/acme/git/perf-tools-next/tools/perf'
Testing Makefile
                  make_debug: cd . && make DEBUG=1   DESTDIR=/tmp/tmp.yfg6I4SlFY
make: Leaving directory '/home/acme/git/perf-tools-next/tools/perf'
⬢ [acme@toolbx perf-tools-next]$ 

- Arnaldo

 
> The derived files get rid of struct shash_desc definition, and directly
> operates on the struct sha1_state.
> 
> Signed-off-by: Yuzhuo Jing <yuzhuo@google.com>
> ---
>  tools/perf/util/Build          |   2 +
>  tools/perf/util/sha1.c         | 122 +++++++++++++++++++++++++++++++++
>  tools/perf/util/sha1.h         |  41 +++++++++++
>  tools/perf/util/sha1_base.h    | 103 ++++++++++++++++++++++++++++
>  tools/perf/util/sha1_generic.c |  49 +++++++++++++
>  5 files changed, 317 insertions(+)
>  create mode 100644 tools/perf/util/sha1.c
>  create mode 100644 tools/perf/util/sha1.h
>  create mode 100644 tools/perf/util/sha1_base.h
>  create mode 100644 tools/perf/util/sha1_generic.c
> 
> diff --git a/tools/perf/util/Build b/tools/perf/util/Build
> index 7910d908c814..ecee96b3f3fa 100644
> --- a/tools/perf/util/Build
> +++ b/tools/perf/util/Build
> @@ -41,6 +41,8 @@ perf-util-y += rbtree.o
>  perf-util-y += libstring.o
>  perf-util-y += bitmap.o
>  perf-util-y += hweight.o
> +perf-util-y += sha1.o
> +perf-util-y += sha1_generic.o
>  perf-util-y += smt.o
>  perf-util-y += strbuf.o
>  perf-util-y += string.o
> diff --git a/tools/perf/util/sha1.c b/tools/perf/util/sha1.c
> new file mode 100644
> index 000000000000..5ae658afb56b
> --- /dev/null
> +++ b/tools/perf/util/sha1.c
> @@ -0,0 +1,122 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * SHA1 routine optimized to do word accesses rather than byte accesses,
> + * and to avoid unnecessary copies into the context array.
> + *
> + * This was based on the git SHA1 implementation.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/bitops.h>
> +#include <linux/string.h>
> +#include <linux/unaligned.h>
> +
> +#include "sha1.h"
> +
> +/*
> + * If you have 32 registers or more, the compiler can (and should)
> + * try to change the array[] accesses into registers. However, on
> + * machines with less than ~25 registers, that won't really work,
> + * and at least gcc will make an unholy mess of it.
> + *
> + * So to avoid that mess which just slows things down, we force
> + * the stores to memory to actually happen (we might be better off
> + * with a 'W(t)=(val);asm("":"+m" (W(t))' there instead, as
> + * suggested by Artur Skawina - that will also make gcc unable to
> + * try to do the silly "optimize away loads" part because it won't
> + * see what the value will be).
> + *
> + * Ben Herrenschmidt reports that on PPC, the C version comes close
> + * to the optimized asm with this (ie on PPC you don't want that
> + * 'volatile', since there are lots of registers).
> + *
> + * On ARM we get the best code generation by forcing a full memory barrier
> + * between each SHA_ROUND, otherwise gcc happily get wild with spilling and
> + * the stack frame size simply explode and performance goes down the drain.
> + */
> +
> +#ifdef CONFIG_X86
> +  #define setW(x, val) (*(volatile __u32 *)&W(x) = (val))
> +#elif defined(CONFIG_ARM)
> +  #define setW(x, val) do { W(x) = (val); __asm__("":::"memory"); } while (0)
> +#else
> +  #define setW(x, val) (W(x) = (val))
> +#endif
> +
> +/* This "rolls" over the 512-bit array */
> +#define W(x) (array[(x)&15])
> +
> +/*
> + * Where do we get the source from? The first 16 iterations get it from
> + * the input data, the next mix it from the 512-bit array.
> + */
> +#define SHA_SRC(t) get_unaligned_be32((__u32 *)data + t)
> +#define SHA_MIX(t) rol32(W(t+13) ^ W(t+8) ^ W(t+2) ^ W(t), 1)
> +
> +#define SHA_ROUND(t, input, fn, constant, A, B, C, D, E) do { \
> +	__u32 TEMP = input(t); setW(t, TEMP); \
> +	E += TEMP + rol32(A,5) + (fn) + (constant); \
> +	B = ror32(B, 2); \
> +	TEMP = E; E = D; D = C; C = B; B = A; A = TEMP; } while (0)
> +
> +#define T_0_15(t, A, B, C, D, E)  SHA_ROUND(t, SHA_SRC, (((C^D)&B)^D) , 0x5a827999, A, B, C, D, E )
> +#define T_16_19(t, A, B, C, D, E) SHA_ROUND(t, SHA_MIX, (((C^D)&B)^D) , 0x5a827999, A, B, C, D, E )
> +#define T_20_39(t, A, B, C, D, E) SHA_ROUND(t, SHA_MIX, (B^C^D) , 0x6ed9eba1, A, B, C, D, E )
> +#define T_40_59(t, A, B, C, D, E) SHA_ROUND(t, SHA_MIX, ((B&C)+(D&(B^C))) , 0x8f1bbcdc, A, B, C, D, E )
> +#define T_60_79(t, A, B, C, D, E) SHA_ROUND(t, SHA_MIX, (B^C^D) ,  0xca62c1d6, A, B, C, D, E )
> +
> +/**
> + * sha1_transform - single block SHA1 transform (deprecated)
> + *
> + * @digest: 160 bit digest to update
> + * @data:   512 bits of data to hash
> + * @array:  16 words of workspace (see note)
> + *
> + * This function executes SHA-1's internal compression function.  It updates the
> + * 160-bit internal state (@digest) with a single 512-bit data block (@data).
> + *
> + * Don't use this function.  SHA-1 is no longer considered secure.  And even if
> + * you do have to use SHA-1, this isn't the correct way to hash something with
> + * SHA-1 as this doesn't handle padding and finalization.
> + *
> + * Note: If the hash is security sensitive, the caller should be sure
> + * to clear the workspace. This is left to the caller to avoid
> + * unnecessary clears between chained hashing operations.
> + */
> +void sha1_transform(__u32 *digest, const char *data, __u32 *array)
> +{
> +	__u32 A, B, C, D, E;
> +	unsigned int i = 0;
> +
> +	A = digest[0];
> +	B = digest[1];
> +	C = digest[2];
> +	D = digest[3];
> +	E = digest[4];
> +
> +	/* Round 1 - iterations 0-16 take their input from 'data' */
> +	for (; i < 16; ++i)
> +		T_0_15(i, A, B, C, D, E);
> +
> +	/* Round 1 - tail. Input from 512-bit mixing array */
> +	for (; i < 20; ++i)
> +		T_16_19(i, A, B, C, D, E);
> +
> +	/* Round 2 */
> +	for (; i < 40; ++i)
> +		T_20_39(i, A, B, C, D, E);
> +
> +	/* Round 3 */
> +	for (; i < 60; ++i)
> +		T_40_59(i, A, B, C, D, E);
> +
> +	/* Round 4 */
> +	for (; i < 80; ++i)
> +		T_60_79(i, A, B, C, D, E);
> +
> +	digest[0] += A;
> +	digest[1] += B;
> +	digest[2] += C;
> +	digest[3] += D;
> +	digest[4] += E;
> +}
> diff --git a/tools/perf/util/sha1.h b/tools/perf/util/sha1.h
> new file mode 100644
> index 000000000000..9da4ece49bc6
> --- /dev/null
> +++ b/tools/perf/util/sha1.h
> @@ -0,0 +1,41 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Common values for SHA-1 algorithms
> + */
> +
> +#ifndef _CRYPTO_SHA1_H
> +#define _CRYPTO_SHA1_H
> +
> +#include <linux/types.h>
> +
> +#define SHA1_DIGEST_SIZE        20
> +#define SHA1_BLOCK_SIZE         64
> +
> +#define SHA1_H0		0x67452301UL
> +#define SHA1_H1		0xefcdab89UL
> +#define SHA1_H2		0x98badcfeUL
> +#define SHA1_H3		0x10325476UL
> +#define SHA1_H4		0xc3d2e1f0UL
> +
> +struct sha1_state {
> +	u32 state[SHA1_DIGEST_SIZE / 4];
> +	u64 count;
> +	u8 buffer[SHA1_BLOCK_SIZE];
> +};
> +
> +extern int crypto_sha1_update(struct sha1_state *desc, const u8 *data,
> +			      unsigned int len);
> +
> +extern int crypto_sha1_finup(struct sha1_state *desc, const u8 *data,
> +			     unsigned int len, u8 *hash);
> +
> +/*
> + * An implementation of SHA-1's compression function.  Don't use in new code!
> + * You shouldn't be using SHA-1, and even if you *have* to use SHA-1, this isn't
> + * the correct way to hash something with SHA-1 (use crypto_shash instead).
> + */
> +#define SHA1_DIGEST_WORDS	(SHA1_DIGEST_SIZE / 4)
> +#define SHA1_WORKSPACE_WORDS	16
> +void sha1_transform(__u32 *digest, const char *data, __u32 *W);
> +
> +#endif /* _CRYPTO_SHA1_H */
> diff --git a/tools/perf/util/sha1_base.h b/tools/perf/util/sha1_base.h
> new file mode 100644
> index 000000000000..cea22c5a4952
> --- /dev/null
> +++ b/tools/perf/util/sha1_base.h
> @@ -0,0 +1,103 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * sha1_base.h - core logic for SHA-1 implementations
> + *
> + * Copyright (C) 2015 Linaro Ltd <ard.biesheuvel@linaro.org>
> + */
> +
> +#ifndef _CRYPTO_SHA1_BASE_H
> +#define _CRYPTO_SHA1_BASE_H
> +
> +#include <linux/string.h>
> +
> +#include <linux/kernel.h>
> +#include <linux/unaligned.h>
> +
> +#include "sha1.h"
> +
> +typedef void (sha1_block_fn)(struct sha1_state *sst, u8 const *src, int blocks);
> +
> +static inline int sha1_base_init(struct sha1_state *sctx)
> +{
> +	sctx->state[0] = SHA1_H0;
> +	sctx->state[1] = SHA1_H1;
> +	sctx->state[2] = SHA1_H2;
> +	sctx->state[3] = SHA1_H3;
> +	sctx->state[4] = SHA1_H4;
> +	sctx->count = 0;
> +
> +	return 0;
> +}
> +
> +static inline int sha1_base_do_update(struct sha1_state *sctx,
> +				      const u8 *data,
> +				      unsigned int len,
> +				      sha1_block_fn *block_fn)
> +{
> +	unsigned int partial = sctx->count % SHA1_BLOCK_SIZE;
> +
> +	sctx->count += len;
> +
> +	if (unlikely((partial + len) >= SHA1_BLOCK_SIZE)) {
> +		int blocks;
> +
> +		if (partial) {
> +			int p = SHA1_BLOCK_SIZE - partial;
> +
> +			memcpy(sctx->buffer + partial, data, p);
> +			data += p;
> +			len -= p;
> +
> +			block_fn(sctx, sctx->buffer, 1);
> +		}
> +
> +		blocks = len / SHA1_BLOCK_SIZE;
> +		len %= SHA1_BLOCK_SIZE;
> +
> +		if (blocks) {
> +			block_fn(sctx, data, blocks);
> +			data += blocks * SHA1_BLOCK_SIZE;
> +		}
> +		partial = 0;
> +	}
> +	if (len)
> +		memcpy(sctx->buffer + partial, data, len);
> +
> +	return 0;
> +}
> +
> +static inline int sha1_base_do_finalize(struct sha1_state *sctx,
> +					sha1_block_fn *block_fn)
> +{
> +	const int bit_offset = SHA1_BLOCK_SIZE - sizeof(__be64);
> +	__be64 *bits = (__be64 *)(sctx->buffer + bit_offset);
> +	unsigned int partial = sctx->count % SHA1_BLOCK_SIZE;
> +
> +	sctx->buffer[partial++] = 0x80;
> +	if (partial > bit_offset) {
> +		memset(sctx->buffer + partial, 0x0, SHA1_BLOCK_SIZE - partial);
> +		partial = 0;
> +
> +		block_fn(sctx, sctx->buffer, 1);
> +	}
> +
> +	memset(sctx->buffer + partial, 0x0, bit_offset - partial);
> +	*bits = cpu_to_be64(sctx->count << 3);
> +	block_fn(sctx, sctx->buffer, 1);
> +
> +	return 0;
> +}
> +
> +static inline int sha1_base_finish(struct sha1_state *sctx, u8 *out)
> +{
> +	__be32 *digest = (__be32 *)out;
> +	int i;
> +
> +	for (i = 0; i < SHA1_DIGEST_SIZE / (int)sizeof(__be32); i++)
> +		put_unaligned_be32(sctx->state[i], digest++);
> +
> +	memzero_explicit(sctx, sizeof(*sctx));
> +	return 0;
> +}
> +
> +#endif /* _CRYPTO_SHA1_BASE_H */
> diff --git a/tools/perf/util/sha1_generic.c b/tools/perf/util/sha1_generic.c
> new file mode 100644
> index 000000000000..b0a7af370d59
> --- /dev/null
> +++ b/tools/perf/util/sha1_generic.c
> @@ -0,0 +1,49 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Cryptographic API.
> + *
> + * SHA1 Secure Hash Algorithm.
> + *
> + * Derived from cryptoapi implementation, adapted for in-place
> + * scatterlist interface.
> + *
> + * Copyright (c) Alan Smithee.
> + * Copyright (c) Andrew McDonald <andrew@mcdonald.org.uk>
> + * Copyright (c) Jean-Francois Dive <jef@linuxbe.org>
> + */
> +#include <linux/types.h>
> +#include <linux/string.h>
> +#include <asm/byteorder.h>
> +
> +#include "sha1_base.h"
> +
> +static void sha1_generic_block_fn(struct sha1_state *sst, u8 const *src,
> +				  int blocks)
> +{
> +	u32 temp[SHA1_WORKSPACE_WORDS];
> +
> +	while (blocks--) {
> +		sha1_transform(sst->state, (const char *)src, temp);
> +		src += SHA1_BLOCK_SIZE;
> +	}
> +	memzero_explicit(temp, sizeof(temp));
> +}
> +
> +int crypto_sha1_update(struct sha1_state *desc, const u8 *data,
> +		       unsigned int len)
> +{
> +	return sha1_base_do_update(desc, data, len, sha1_generic_block_fn);
> +}
> +
> +static int sha1_final(struct sha1_state *desc, u8 *out)
> +{
> +	sha1_base_do_finalize(desc, sha1_generic_block_fn);
> +	return sha1_base_finish(desc, out);
> +}
> +
> +int crypto_sha1_finup(struct sha1_state *desc, const u8 *data,
> +		      unsigned int len, u8 *out)
> +{
> +	sha1_base_do_update(desc, data, len, sha1_generic_block_fn);
> +	return sha1_final(desc, out);
> +}
> -- 
> 2.49.0.1164.gab81da1b16-goog
