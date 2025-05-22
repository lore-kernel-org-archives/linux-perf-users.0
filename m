Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D0319ADA2;
	Thu, 22 May 2025 17:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747935003; cv=none; b=GUAGRbdLvOhxJXIVmbWhpr0zQrQ2VJ+FELqKKKS2dt7B85mfVGSWKin/q1se+t5kV3ZLnzHueJDkmaX2LWYqoaSGqQ5LM/0nj5yi0+Bkb1ShyisHSTQe8PCII3TlqD/HvNjiJ9h54BWFMtpcBg6/jfAzmPXWb3RWf4cCrSaf6ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747935003; c=relaxed/simple;
	bh=JwPQWMT8jn6Zv25lJj2JKvKxkW2xWQiBVrIple5TRdc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=niWE+6fQrgQJqJ6qT8+lolQk2ttSR2Zyb46tHfALdvNFiGnQrTRehjN6HWOurVgjzxZl4N00+hvdz9M/WIVJd/t84+dPEE4e26inDoKf5VU5ilRg3lp4y8MmcDPpdySiU/iojYJfvQlOxXa4/2UJl8HgF0aUnKZlYCUwNPTR4jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DoLEJXx1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DoLEJXx1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53EFFC4CEE4;
	Thu, 22 May 2025 17:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747935002;
	bh=JwPQWMT8jn6Zv25lJj2JKvKxkW2xWQiBVrIple5TRdc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DoLEJXx16Z11gb6uuqLSZi2LbLaG+PLMfcYwrSQk9HmFLwojtcVRRDXsUSPZOLrqo
	 HaP054K/PCis6rVSa4oMGNee3wpCUfXBg7NnEfME/AqPIPKCBuLKcO0OXYUT1epdtd
	 Dv2Z59ifSu8Mj1QTkTy1C8TEPoo5Bfaf9oiIJximUlqQDVqGIrbVcLKt6RVHBzAyqT
	 jSHKVMwdsvEAh9Gv+rdhCQzjnOR9cxpZOUJwfVkw0utHqgyf6DDkvcFyPtCjvkz6jE
	 KS7N1R5CXO5oc4wJyU78v0XvUPAPkQvuQuM236v8AC8QLmg3IuAeM18nAAepv9ynf9
	 upKdTQ267NPZQ==
Date: Thu, 22 May 2025 14:30:00 -0300
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
Subject: Re: [PATCH v1 4/4] tools: Remove libcrypto dependency
Message-ID: <aC9fGPZ2qb2dje0x@x1>
References: <20250521225307.743726-1-yuzhuo@google.com>
 <20250521225307.743726-5-yuzhuo@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250521225307.743726-5-yuzhuo@google.com>

On Wed, May 21, 2025 at 03:53:07PM -0700, Yuzhuo Jing wrote:
> Remove all occurrence of libcrypto in the build system.

and that was so far used only by tools/perf, good:

⬢ [acme@toolbx perf-tools-next]$ git grep -w feature-libcrypto tools/

As there are some other features that are tested/used by other tools/
living code.

⬢ [acme@toolbx perf-tools-next]$ git grep -w feature-libbfd tools/
tools/bpf/bpftool/Makefile:  ifeq ($(feature-libbfd),1)
tools/bpf/bpftool/Makefile:  else ifeq ($(feature-libbfd-liberty),1)
tools/bpf/bpftool/Makefile:  else ifeq ($(feature-libbfd-liberty-z),1)
tools/perf/Makefile.config:  ifeq ($(feature-libbfd), 1)
tools/perf/Makefile.config:    ifeq ($(feature-libbfd-liberty), 1)
tools/perf/Makefile.config:      ifeq ($(feature-libbfd-liberty-z), 1)
tools/perf/Makefile.config:  ifeq ($(feature-libbfd-buildid), 1)
⬢ [acme@toolbx perf-tools-next]$

- Arnaldo
 
> Signed-off-by: Yuzhuo Jing <yuzhuo@google.com>
> ---
>  tools/build/Makefile.feature            |  2 --
>  tools/build/feature/Makefile            |  4 ----
>  tools/build/feature/test-all.c          |  5 -----
>  tools/build/feature/test-libcrypto.c    | 25 -------------------------
>  tools/perf/Documentation/perf-check.txt |  1 -
>  tools/perf/Makefile.config              | 13 -------------
>  tools/perf/Makefile.perf                |  3 ---
>  tools/perf/builtin-check.c              |  1 -
>  tools/perf/tests/make                   |  4 +---
>  9 files changed, 1 insertion(+), 57 deletions(-)
>  delete mode 100644 tools/build/feature/test-libcrypto.c
> 
> diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
> index 57bd995ce6af..bbadfb5568eb 100644
> --- a/tools/build/Makefile.feature
> +++ b/tools/build/Makefile.feature
> @@ -86,7 +86,6 @@ FEATURE_TESTS_BASIC :=                  \
>          libtraceevent                   \
>          libtracefs                      \
>          libcpupower                     \
> -        libcrypto                       \
>          pthread-attr-setaffinity-np     \
>          pthread-barrier     		\
>          reallocarray                    \
> @@ -152,7 +151,6 @@ FEATURE_DISPLAY ?=              \
>           numa_num_possible_cpus \
>           libperl                \
>           libpython              \
> -         libcrypto              \
>           libcapstone            \
>           llvm-perf              \
>           zlib                   \
> diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
> index b8b5fb183dd4..04a4aa0341aa 100644
> --- a/tools/build/feature/Makefile
> +++ b/tools/build/feature/Makefile
> @@ -38,7 +38,6 @@ FILES=                                          \
>           test-libtraceevent.bin                 \
>           test-libcpupower.bin                   \
>           test-libtracefs.bin                    \
> -         test-libcrypto.bin                     \
>           test-libunwind.bin                     \
>           test-libunwind-debug-frame.bin         \
>           test-libunwind-x86.bin                 \
> @@ -246,9 +245,6 @@ $(OUTPUT)test-libcpupower.bin:
>  $(OUTPUT)test-libtracefs.bin:
>  	 $(BUILD) $(shell $(PKG_CONFIG) --cflags libtracefs 2>/dev/null) -ltracefs
>  
> -$(OUTPUT)test-libcrypto.bin:
> -	$(BUILD) -lcrypto
> -
>  $(OUTPUT)test-gtk2.bin:
>  	$(BUILD) $(shell $(PKG_CONFIG) --libs --cflags gtk+-2.0 2>/dev/null) -Wno-deprecated-declarations
>  
> diff --git a/tools/build/feature/test-all.c b/tools/build/feature/test-all.c
> index 03ddaac6f4c4..ce72e2061ac0 100644
> --- a/tools/build/feature/test-all.c
> +++ b/tools/build/feature/test-all.c
> @@ -138,10 +138,6 @@
>  # include "test-bpf.c"
>  #undef main
>  
> -#define main main_test_libcrypto
> -# include "test-libcrypto.c"
> -#undef main
> -
>  #define main main_test_sdt
>  # include "test-sdt.c"
>  #undef main
> @@ -206,7 +202,6 @@ int main(int argc, char *argv[])
>  	main_test_lzma();
>  	main_test_get_cpuid();
>  	main_test_bpf();
> -	main_test_libcrypto();
>  	main_test_scandirat();
>  	main_test_sched_getcpu();
>  	main_test_sdt();
> diff --git a/tools/build/feature/test-libcrypto.c b/tools/build/feature/test-libcrypto.c
> deleted file mode 100644
> index bc34a5bbb504..000000000000
> --- a/tools/build/feature/test-libcrypto.c
> +++ /dev/null
> @@ -1,25 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -#include <openssl/evp.h>
> -#include <openssl/sha.h>
> -#include <openssl/md5.h>
> -
> -int main(void)
> -{
> -	EVP_MD_CTX *mdctx;
> -	unsigned char md[MD5_DIGEST_LENGTH + SHA_DIGEST_LENGTH];
> -	unsigned char dat[] = "12345";
> -	unsigned int digest_len;
> -
> -	mdctx = EVP_MD_CTX_new();
> -	if (!mdctx)
> -		return 0;
> -
> -	EVP_DigestInit_ex(mdctx, EVP_md5(), NULL);
> -	EVP_DigestUpdate(mdctx, &dat[0], sizeof(dat));
> -	EVP_DigestFinal_ex(mdctx, &md[0], &digest_len);
> -	EVP_MD_CTX_free(mdctx);
> -
> -	SHA1(&dat[0], sizeof(dat), &md[0]);
> -
> -	return 0;
> -}
> diff --git a/tools/perf/Documentation/perf-check.txt b/tools/perf/Documentation/perf-check.txt
> index a764a4629220..2b96cb578658 100644
> --- a/tools/perf/Documentation/perf-check.txt
> +++ b/tools/perf/Documentation/perf-check.txt
> @@ -53,7 +53,6 @@ feature::
>                  auxtrace                /  HAVE_AUXTRACE_SUPPORT
>                  libbfd                  /  HAVE_LIBBFD_SUPPORT
>                  libcapstone             /  HAVE_LIBCAPSTONE_SUPPORT
> -                libcrypto               /  HAVE_LIBCRYPTO_SUPPORT
>                  libdw-dwarf-unwind      /  HAVE_LIBDW_SUPPORT
>                  libelf                  /  HAVE_LIBELF_SUPPORT
>                  libnuma                 /  HAVE_LIBNUMA_SUPPORT
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index d1ea7bf44964..d19d1f132726 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -130,8 +130,6 @@ ifndef NO_LIBUNWIND
>    FEATURE_CHECK_LDFLAGS-libunwind-x86_64 += -lunwind -llzma -lunwind-x86_64
>  endif
>  
> -FEATURE_CHECK_LDFLAGS-libcrypto = -lcrypto
> -
>  ifdef CSINCLUDES
>    LIBOPENCSD_CFLAGS := -I$(CSINCLUDES)
>  endif
> @@ -772,17 +770,6 @@ ifneq ($(NO_LIBTRACEEVENT),1)
>    $(call detected,CONFIG_TRACE)
>  endif
>  
> -ifndef NO_LIBCRYPTO
> -  ifneq ($(feature-libcrypto), 1)
> -    $(warning No libcrypto.h found, disables jitted code injection, please install openssl-devel or libssl-dev)
> -    NO_LIBCRYPTO := 1
> -  else
> -    CFLAGS += -DHAVE_LIBCRYPTO_SUPPORT
> -    EXTLIBS += -lcrypto
> -    $(call detected,CONFIG_CRYPTO)
> -  endif
> -endif
> -
>  ifndef NO_SLANG
>    ifneq ($(feature-libslang), 1)
>      ifneq ($(feature-libslang-include-subdir), 1)
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index d4c7031b01a7..9246c94656e0 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -61,9 +61,6 @@ include ../scripts/utilities.mak
>  #
>  # Define NO_LIBBIONIC if you do not want bionic support
>  #
> -# Define NO_LIBCRYPTO if you do not want libcrypto (openssl) support
> -# used for generating build-ids for ELFs generated by jitdump.
> -#
>  # Define NO_LIBDW_DWARF_UNWIND if you do not want libdw support
>  # for dwarf backtrace post unwind.
>  #
> diff --git a/tools/perf/builtin-check.c b/tools/perf/builtin-check.c
> index 9a509cb3bb9a..ad49f2564aae 100644
> --- a/tools/perf/builtin-check.c
> +++ b/tools/perf/builtin-check.c
> @@ -44,7 +44,6 @@ struct feature_status supported_features[] = {
>  	FEATURE_STATUS("auxtrace", HAVE_AUXTRACE_SUPPORT),
>  	FEATURE_STATUS_TIP("libbfd", HAVE_LIBBFD_SUPPORT, "Deprecated, license incompatibility, use BUILD_NONDISTRO=1 and install binutils-dev[el]"),
>  	FEATURE_STATUS("libcapstone", HAVE_LIBCAPSTONE_SUPPORT),
> -	FEATURE_STATUS("libcrypto", HAVE_LIBCRYPTO_SUPPORT),
>  	FEATURE_STATUS("libdw-dwarf-unwind", HAVE_LIBDW_SUPPORT),
>  	FEATURE_STATUS("libelf", HAVE_LIBELF_SUPPORT),
>  	FEATURE_STATUS("libnuma", HAVE_LIBNUMA_SUPPORT),
> diff --git a/tools/perf/tests/make b/tools/perf/tests/make
> index 0ee94caf9ec1..e3651e5b195a 100644
> --- a/tools/perf/tests/make
> +++ b/tools/perf/tests/make
> @@ -91,7 +91,6 @@ make_no_auxtrace    := NO_AUXTRACE=1
>  make_no_libbpf	    := NO_LIBBPF=1
>  make_libbpf_dynamic := LIBBPF_DYNAMIC=1
>  make_no_libbpf_DEBUG := NO_LIBBPF=1 DEBUG=1
> -make_no_libcrypto   := NO_LIBCRYPTO=1
>  make_no_libllvm     := NO_LIBLLVM=1
>  make_with_babeltrace:= LIBBABELTRACE=1
>  make_with_coresight := CORESIGHT=1
> @@ -122,7 +121,7 @@ make_minimal        := NO_LIBPERL=1 NO_LIBPYTHON=1 NO_GTK2=1
>  make_minimal        += NO_DEMANGLE=1 NO_LIBELF=1 NO_BACKTRACE=1
>  make_minimal        += NO_LIBNUMA=1 NO_LIBBIONIC=1
>  make_minimal        += NO_LIBDW_DWARF_UNWIND=1 NO_AUXTRACE=1 NO_LIBBPF=1
> -make_minimal        += NO_LIBCRYPTO=1 NO_SDT=1 NO_JVMTI=1 NO_LIBZSTD=1
> +make_minimal        += NO_SDT=1 NO_JVMTI=1 NO_LIBZSTD=1
>  make_minimal        += NO_LIBCAP=1 NO_CAPSTONE=1
>  
>  # $(run) contains all available tests
> @@ -160,7 +159,6 @@ run += make_no_libbionic
>  run += make_no_auxtrace
>  run += make_no_libbpf
>  run += make_no_libbpf_DEBUG
> -run += make_no_libcrypto
>  run += make_no_libllvm
>  run += make_no_sdt
>  run += make_no_syscall_tbl
> -- 
> 2.49.0.1164.gab81da1b16-goog
