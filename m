Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9446D221FB5;
	Wed, 28 May 2025 22:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748469852; cv=none; b=D9pAed8TCmWWl44c86W6Y2WHYYSSIpiITIhC0oLm2I4p98MhmTQdw1orQw7xUsW6VrGVYVZ0LGh5EHfN38dofRIb3xkSH/mEISH2EMsNQYZ2+I6Uu4IAnp8C3a+Tdf5c6bey3GclDEDqbwB7tKQHNfxjlznqwPbkzXNKg9Pb1w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748469852; c=relaxed/simple;
	bh=XZ04ShYzZs7qqQzQ7gvel0qrFUQ7518RxyPLHTJ3FUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lF3VOo6KVYlqFCQJhpPJ3SbHd9Ofc+/GYywu++h8LQYKl4fIvnt2JhkGY8QevXKfTqBxCzDSZNad92P8WWper+vn9cwaFCqmH+eOuizACYAR83SN5IXrJ6tKVECNhLD56K5kI02ZCcKmWYQrKQdp0119XGcsaS3t5jc7fDtbT64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oW0NLSZj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oW0NLSZj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FE80C4CEE3;
	Wed, 28 May 2025 22:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748469852;
	bh=XZ04ShYzZs7qqQzQ7gvel0qrFUQ7518RxyPLHTJ3FUE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oW0NLSZjMs+/iHOQq0vJPPrINn0p+VVVIAzjEjpdGEXkmE8zLX79ZyHVrEsdyvKqq
	 lk5z+GuYb5NVsVhe6C57yBSer4o2oansI1ln0NZbI1Jz2OcOi1XmgvBotPwPYmq9Dy
	 QYksKf2GkVx94EBKF51qKj96ZyCsid3TerbfTPQCTNBWPbW+S9D+nEHAytXsmb5O59
	 WIUQ6+PnAEmLOs1MN1mEd6LEqpbr2YNOUBwo05fAUB0wQnwgZmVIrcOzsZf031MZ7b
	 o9lToo9+hpwMooNb4vJgyXLeLFZl2JwrlNreVYM1icJrAGNm2UNCEIKp8Y+mvObtgw
	 bdIVFh7+2Dysg==
Date: Wed, 28 May 2025 19:04:08 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	James Clark <james.clark@linaro.org>,
	Howard Chu <howardchu95@gmail.com>,
	Weilin Wang <weilin.wang@intel.com>,
	Stephen Brennan <stephen.s.brennan@oracle.com>,
	Andi Kleen <ak@linux.intel.com>, Dmitry Vyukov <dvyukov@google.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] perf symbol: Move demangling code out of symbol-elf.c
Message-ID: <aDeIWI8DH9MOTy1z@x1>
References: <20250528210858.499898-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250528210858.499898-1-irogers@google.com>

On Wed, May 28, 2025 at 02:08:58PM -0700, Ian Rogers wrote:
> symbol-elf.c is used when building with libelf, symbol-minimal is used
> otherwise. There is no reason the demangling code with no dependencies
> on libelf is part of symbol-elf.c so move to symbol.c. This allows
> demangling tests to pass with NO_LIBELF=1.
> 
> Structurally, while moving the functions rename demangle_sym to
> dso__demangle_sym which is already a function exposed in symbol.h and
> the only purpose of which in symbol-elf.c was to call
> demangle_sym. Change the calls to demangle_sym in symbol-elf.c to
> calls to dso__demangle_sym.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
> v3. Separate patch as most of v2 landed already. Fix issues with
>     libelf build while merging dso__demangle_sym and demangle_sym to
>     remove some unneeded complexity.
>     The thread comm_lock fix also isn't included:
> https://lore.kernel.org/lkml/20250528032637.198960-8-irogers@google.com/
>     as discussion on that has moved to a revert by Arnaldo:
> https://lore.kernel.org/lkml/aDcyVLVpZRui1ole@x1/



Thanks, applied to perf-tools-next,

- Arnaldo

> ---
>  tools/perf/util/demangle-cxx.h   |  2 +
>  tools/perf/util/symbol-elf.c     | 92 ++------------------------------
>  tools/perf/util/symbol-minimal.c |  7 ---
>  tools/perf/util/symbol.c         | 82 ++++++++++++++++++++++++++++
>  4 files changed, 87 insertions(+), 96 deletions(-)
> 
> diff --git a/tools/perf/util/demangle-cxx.h b/tools/perf/util/demangle-cxx.h
> index 26b5b66c0b4e..9359937a881a 100644
> --- a/tools/perf/util/demangle-cxx.h
> +++ b/tools/perf/util/demangle-cxx.h
> @@ -2,6 +2,8 @@
>  #ifndef __PERF_DEMANGLE_CXX
>  #define __PERF_DEMANGLE_CXX 1
>  
> +#include <stdbool.h>
> +
>  #ifdef __cplusplus
>  extern "C" {
>  #endif
> diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
> index 8734e8b6cf84..01818abd02df 100644
> --- a/tools/perf/util/symbol-elf.c
> +++ b/tools/perf/util/symbol-elf.c
> @@ -13,17 +13,12 @@
>  #include "maps.h"
>  #include "symbol.h"
>  #include "symsrc.h"
> -#include "demangle-cxx.h"
> -#include "demangle-ocaml.h"
> -#include "demangle-java.h"
> -#include "demangle-rust-v0.h"
>  #include "machine.h"
>  #include "vdso.h"
>  #include "debug.h"
>  #include "util/copyfile.h"
>  #include <linux/ctype.h>
>  #include <linux/kernel.h>
> -#include <linux/log2.h>
>  #include <linux/zalloc.h>
>  #include <linux/string.h>
>  #include <symbol/kallsyms.h>
> @@ -280,82 +275,6 @@ static int elf_read_program_header(Elf *elf, u64 vaddr, GElf_Phdr *phdr)
>  	return -1;
>  }
>  
> -static bool want_demangle(bool is_kernel_sym)
> -{
> -	return is_kernel_sym ? symbol_conf.demangle_kernel : symbol_conf.demangle;
> -}
> -
> -/*
> - * Demangle C++ function signature, typically replaced by demangle-cxx.cpp
> - * version.
> - */
> -#ifndef HAVE_CXA_DEMANGLE_SUPPORT
> -char *cxx_demangle_sym(const char *str __maybe_unused, bool params __maybe_unused,
> -		       bool modifiers __maybe_unused)
> -{
> -#ifdef HAVE_LIBBFD_SUPPORT
> -	int flags = (params ? DMGL_PARAMS : 0) | (modifiers ? DMGL_ANSI : 0);
> -
> -	return bfd_demangle(NULL, str, flags);
> -#elif defined(HAVE_CPLUS_DEMANGLE_SUPPORT)
> -	int flags = (params ? DMGL_PARAMS : 0) | (modifiers ? DMGL_ANSI : 0);
> -
> -	return cplus_demangle(str, flags);
> -#else
> -	return NULL;
> -#endif
> -}
> -#endif /* !HAVE_CXA_DEMANGLE_SUPPORT */
> -
> -static char *demangle_sym(struct dso *dso, int kmodule, const char *elf_name)
> -{
> -	struct demangle rust_demangle = {
> -		.style = DemangleStyleUnknown,
> -	};
> -	char *demangled = NULL;
> -
> -	/*
> -	 * We need to figure out if the object was created from C++ sources
> -	 * DWARF DW_compile_unit has this, but we don't always have access
> -	 * to it...
> -	 */
> -	if (!want_demangle((dso && dso__kernel(dso)) || kmodule))
> -		return demangled;
> -
> -	rust_demangle_demangle(elf_name, &rust_demangle);
> -	if (rust_demangle_is_known(&rust_demangle)) {
> -		/* A rust mangled name. */
> -		if (rust_demangle.mangled_len == 0)
> -			return demangled;
> -
> -		for (size_t buf_len = roundup_pow_of_two(rust_demangle.mangled_len * 2);
> -		     buf_len < 1024 * 1024; buf_len += 32) {
> -			char *tmp = realloc(demangled, buf_len);
> -
> -			if (!tmp) {
> -				/* Failure to grow output buffer, return what is there. */
> -				return demangled;
> -			}
> -			demangled = tmp;
> -			if (rust_demangle_display_demangle(&rust_demangle, demangled, buf_len,
> -							   /*alternate=*/true) == OverflowOk)
> -				return demangled;
> -		}
> -		/* Buffer exceeded sensible bounds, return what is there. */
> -		return demangled;
> -	}
> -
> -	demangled = cxx_demangle_sym(elf_name, verbose > 0, verbose > 0);
> -	if (demangled)
> -		return demangled;
> -
> -	demangled = ocaml_demangle_sym(elf_name);
> -	if (demangled)
> -		return demangled;
> -
> -	return java_demangle_sym(elf_name, JAVA_DEMANGLE_NORET);
> -}
> -
>  struct rel_info {
>  	u32		nr_entries;
>  	u32		*sorted;
> @@ -641,7 +560,7 @@ static bool get_plt_got_name(GElf_Shdr *shdr, size_t i,
>  	/* Get the associated symbol */
>  	gelf_getsym(di->dynsym_data, vr->sym_idx, &sym);
>  	sym_name = elf_sym__name(&sym, di->dynstr_data);
> -	demangled = demangle_sym(di->dso, 0, sym_name);
> +	demangled = dso__demangle_sym(di->dso, /*kmodule=*/0, sym_name);
>  	if (demangled != NULL)
>  		sym_name = demangled;
>  
> @@ -839,7 +758,7 @@ int dso__synthesize_plt_symbols(struct dso *dso, struct symsrc *ss)
>  		gelf_getsym(syms, get_rel_symidx(&ri, idx), &sym);
>  
>  		elf_name = elf_sym__name(&sym, symstrs);
> -		demangled = demangle_sym(dso, 0, elf_name);
> +		demangled = dso__demangle_sym(dso, /*kmodule=*/0, elf_name);
>  		if (demangled)
>  			elf_name = demangled;
>  		if (*elf_name)
> @@ -868,11 +787,6 @@ int dso__synthesize_plt_symbols(struct dso *dso, struct symsrc *ss)
>  	return 0;
>  }
>  
> -char *dso__demangle_sym(struct dso *dso, int kmodule, const char *elf_name)
> -{
> -	return demangle_sym(dso, kmodule, elf_name);
> -}
> -
>  /*
>   * Align offset to 4 bytes as needed for note name and descriptor data.
>   */
> @@ -1861,7 +1775,7 @@ dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *syms_ss,
>  			}
>  		}
>  
> -		demangled = demangle_sym(dso, kmodule, elf_name);
> +		demangled = dso__demangle_sym(dso, kmodule, elf_name);
>  		if (demangled != NULL)
>  			elf_name = demangled;
>  
> diff --git a/tools/perf/util/symbol-minimal.c b/tools/perf/util/symbol-minimal.c
> index 36c1d3090689..c73fe2e09fe9 100644
> --- a/tools/perf/util/symbol-minimal.c
> +++ b/tools/perf/util/symbol-minimal.c
> @@ -355,13 +355,6 @@ void symbol__elf_init(void)
>  {
>  }
>  
> -char *dso__demangle_sym(struct dso *dso __maybe_unused,
> -			int kmodule __maybe_unused,
> -			const char *elf_name __maybe_unused)
> -{
> -	return NULL;
> -}
> -
>  bool filename__has_section(const char *filename __maybe_unused, const char *sec __maybe_unused)
>  {
>  	return false;
> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index fe801880afea..8b30c6f16a9e 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -19,6 +19,11 @@
>  #include "build-id.h"
>  #include "cap.h"
>  #include "cpumap.h"
> +#include "debug.h"
> +#include "demangle-cxx.h"
> +#include "demangle-java.h"
> +#include "demangle-ocaml.h"
> +#include "demangle-rust-v0.h"
>  #include "dso.h"
>  #include "util.h" // lsdir()
>  #include "debug.h"
> @@ -36,6 +41,7 @@
>  #include "header.h"
>  #include "path.h"
>  #include <linux/ctype.h>
> +#include <linux/log2.h>
>  #include <linux/zalloc.h>
>  
>  #include <elf.h>
> @@ -2648,3 +2654,79 @@ int symbol__validate_sym_arguments(void)
>  	}
>  	return 0;
>  }
> +
> +static bool want_demangle(bool is_kernel_sym)
> +{
> +	return is_kernel_sym ? symbol_conf.demangle_kernel : symbol_conf.demangle;
> +}
> +
> +/*
> + * Demangle C++ function signature, typically replaced by demangle-cxx.cpp
> + * version.
> + */
> +#ifndef HAVE_CXA_DEMANGLE_SUPPORT
> +char *cxx_demangle_sym(const char *str __maybe_unused, bool params __maybe_unused,
> +		       bool modifiers __maybe_unused)
> +{
> +#ifdef HAVE_LIBBFD_SUPPORT
> +	int flags = (params ? DMGL_PARAMS : 0) | (modifiers ? DMGL_ANSI : 0);
> +
> +	return bfd_demangle(NULL, str, flags);
> +#elif defined(HAVE_CPLUS_DEMANGLE_SUPPORT)
> +	int flags = (params ? DMGL_PARAMS : 0) | (modifiers ? DMGL_ANSI : 0);
> +
> +	return cplus_demangle(str, flags);
> +#else
> +	return NULL;
> +#endif
> +}
> +#endif /* !HAVE_CXA_DEMANGLE_SUPPORT */
> +
> +char *dso__demangle_sym(struct dso *dso, int kmodule, const char *elf_name)
> +{
> +	struct demangle rust_demangle = {
> +		.style = DemangleStyleUnknown,
> +	};
> +	char *demangled = NULL;
> +
> +	/*
> +	 * We need to figure out if the object was created from C++ sources
> +	 * DWARF DW_compile_unit has this, but we don't always have access
> +	 * to it...
> +	 */
> +	if (!want_demangle((dso && dso__kernel(dso)) || kmodule))
> +		return demangled;
> +
> +	rust_demangle_demangle(elf_name, &rust_demangle);
> +	if (rust_demangle_is_known(&rust_demangle)) {
> +		/* A rust mangled name. */
> +		if (rust_demangle.mangled_len == 0)
> +			return demangled;
> +
> +		for (size_t buf_len = roundup_pow_of_two(rust_demangle.mangled_len * 2);
> +		     buf_len < 1024 * 1024; buf_len += 32) {
> +			char *tmp = realloc(demangled, buf_len);
> +
> +			if (!tmp) {
> +				/* Failure to grow output buffer, return what is there. */
> +				return demangled;
> +			}
> +			demangled = tmp;
> +			if (rust_demangle_display_demangle(&rust_demangle, demangled, buf_len,
> +							   /*alternate=*/true) == OverflowOk)
> +				return demangled;
> +		}
> +		/* Buffer exceeded sensible bounds, return what is there. */
> +		return demangled;
> +	}
> +
> +	demangled = cxx_demangle_sym(elf_name, verbose > 0, verbose > 0);
> +	if (demangled)
> +		return demangled;
> +
> +	demangled = ocaml_demangle_sym(elf_name);
> +	if (demangled)
> +		return demangled;
> +
> +	return java_demangle_sym(elf_name, JAVA_DEMANGLE_NORET);
> +}
> -- 
> 2.49.0.1204.g71687c7c1d-goog
> 
