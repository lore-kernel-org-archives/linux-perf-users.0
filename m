Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685161E495;
	Thu, 23 May 2024 13:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716471509; cv=none; b=FNepPIFFectNRxgOBMWaYSei6tFbXKJ9epw+A3OXPKMEQ7QIHSWq0GAFqPa9D6jiLArlP5Pr+Z5W1zYG0VXymkxXkdqTxP+RL+mIArYOK42JISym1B++01tyMpSQnc596yW0lFsR3Qb3xDXKYJXBVTwm4Rf5GAuR+X/m0ZpLbZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716471509; c=relaxed/simple;
	bh=KbXQ31lc1mylRNtdrQTHFpPG+b44YpsJde68YblUsrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=us+Tcfw2/kfJbEpyr6vwna0ExwjgeJN62knypQei6bFO/0U84EXdyyf3EfaVy7I2uTtJtPaDjPtBfmZt9TbInzHVDm8Ur+rX3HKkIUzNYwBl/yi2vKJ7yOHsl8Dr19RyqOvjhbM9Lrf+pan2AWR/uX36SvxTcm4WiOJEPP8bUKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XJSGHC2B; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XJSGHC2B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6805FC3277B;
	Thu, 23 May 2024 13:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716471509;
	bh=KbXQ31lc1mylRNtdrQTHFpPG+b44YpsJde68YblUsrw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XJSGHC2BUw/VMuwrCvBV1ToLSorxc69/789aCOwWyGC0k6OZUnUu82ncSxNIkYQIL
	 YzLED3p0cILu0zjBI4rGmomqI98uOX2cw2FJsr81Kn6VZp69FFaN/VNQLmitr8kGhW
	 knHQWrJnutAl99JwX8xCgyhOHb2Q10uCzPekXd5V7q2hpCsWgmfGU9ShgPsNWad76b
	 324gqTFyb/dnIcVVFeMJM8wsujOmE3XaerrpIaEXDCNFf5/OfJ6VmokufUozpeR2Qi
	 UGMfxdlL70Hsc2+Ci+pN1TxnshnNz+3kjvZZoTNeEoeV9ByxBAa+QBIk3VcbVEgDA9
	 c6fIWm5Fr0Phg==
Date: Thu, 23 May 2024 10:38:19 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: "Steinar H. Gunderson" <sesse@google.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	irogers@google.com
Subject: Re: [PATCH v4 1/3] perf report: Support LLVM for addr2line()
Message-ID: <Zk9Gy7WRKchD0KWE@x1>
References: <20240520083048.322863-1-sesse@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240520083048.322863-1-sesse@google.com>

On Mon, May 20, 2024 at 10:30:46AM +0200, Steinar H. Gunderson wrote:
> In addition to the existing support for libbfd and calling out to
> an external addr2line command, add support for using libllvm directly.
> This is both faster than libbfd, and can be enabled in distro builds
> (the LLVM license has an explicit provision for GPLv2 compatibility).
> Thus, it is set as the primary choice if available.

That is great news! Thanks for contributing this.
 
> As an example, running perf report on a medium-size profile with
> DWARF-based backtraces took 58 seconds with LLVM, 78 seconds with
> libbfd, 153 seconds with external llvm-addr2line, and I got tired
> and aborted the test after waiting for 55 minutes with external
> bfd addr2line (which is the default for perf as compiled by distributions
> today). Evidently, for this case, the bfd addr2line process needs
> 18 seconds (on a 5.2 GHz Zen 3) to load the .debug ELF in question,
> hits the 1-second timeout and gets killed during initialization,
> getting restarted anew every time. Having an in-process addr2line
> makes this much more robust.
> 
> As future extensions, libllvm can be used in many other places where
> we currently use libbfd or other libraries:
> 
>  - Symbol enumeration (in particular, for PE binaries).
>  - Demangling (including non-Itanium demangling, e.g. Microsoft
>    or Rust).
>  - Disassembling (perf annotate).

All great news.
 
> However, these are much less pressing; most people don't profile
> PE binaries, and perf has non-bfd paths for ELF. The same with
> demangling; the default _cxa_demangle path works fine for most
> users. Disassembling is coming in a later patch in the series;
> however do note that while bfd objdump can be slow on large binaries,
> it is possible to use --objdump=llvm-objdump to get the speed benefits.
> (It appears LLVM-based demangling is very simple, should we want
> that.)
> 
> Tested with LLVM 14, 15, 16, 18 and 19. For some reason, LLVM 12 was not
> correctly detected using feature_check, and thus was not tested.

And here is an area that we need to have in mind when adding code like
this, that uses infrastructure that evolves over compiler versions and
in combination with the usage perf makes of it: We need to have 'perf
test' entries to compare the output of existing methods with the ones
from these new ones.

Its great having something we can enable by default so that distros pick
it, having the BFD one, we can keep it while it doesn't become too much
of a maintainance burden for us developers to test it against the
(new) default methods.

I'll try and test your patchkit, thanks again!

- Arnaldo
 
> Signed-off-by: Steinar H. Gunderson <sesse@google.com>
> ---
>  tools/build/Makefile.feature       |   1 +
>  tools/perf/Makefile.config         |  15 ++++
>  tools/perf/builtin-version.c       |   1 +
>  tools/perf/util/Build              |   1 +
>  tools/perf/util/llvm-c-helpers.cpp | 130 +++++++++++++++++++++++++++++
>  tools/perf/util/llvm-c-helpers.h   |  47 +++++++++++
>  tools/perf/util/srcline.c          |  57 ++++++++++++-
>  7 files changed, 251 insertions(+), 1 deletion(-)
>  create mode 100644 tools/perf/util/llvm-c-helpers.cpp
>  create mode 100644 tools/perf/util/llvm-c-helpers.h
> 
> diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
> index 1e2ab148d5db..278b26216254 100644
> --- a/tools/build/Makefile.feature
> +++ b/tools/build/Makefile.feature
> @@ -136,6 +136,7 @@ FEATURE_DISPLAY ?=              \
>           libunwind              \
>           libdw-dwarf-unwind     \
>           libcapstone            \
> +         llvm                   \
>           zlib                   \
>           lzma                   \
>           get_cpuid              \
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index 7f1e016a9253..414a37f712bd 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -969,6 +969,21 @@ ifdef BUILD_NONDISTRO
>    endif
>  endif
>  
> +ifndef NO_LLVM
> +  $(call feature_check,llvm)
> +  ifeq ($(feature-llvm), 1)
> +    CFLAGS += -DHAVE_LLVM_SUPPORT
> +    CXXFLAGS += -DHAVE_LLVM_SUPPORT
> +    CXXFLAGS += $(shell $(LLVM_CONFIG) --cxxflags)
> +    LIBLLVM = $(shell $(LLVM_CONFIG) --libs all) $(shell $(LLVM_CONFIG) --system-libs)
> +    EXTLIBS += -L$(shell $(LLVM_CONFIG) --libdir) $(LIBLLVM)
> +    $(call detected,CONFIG_LLVM)
> +  else
> +    $(warning No libllvm found, slower source file resolution, please install llvm-devel/llvm-dev)
> +    NO_LLVM := 1
> +  endif
> +endif
> +
>  ifndef NO_DEMANGLE
>    $(call feature_check,cxa-demangle)
>    ifeq ($(feature-cxa-demangle), 1)
> diff --git a/tools/perf/builtin-version.c b/tools/perf/builtin-version.c
> index 398aa53e9e2e..94d8e13a688f 100644
> --- a/tools/perf/builtin-version.c
> +++ b/tools/perf/builtin-version.c
> @@ -65,6 +65,7 @@ static void library_status(void)
>  	STATUS(HAVE_LIBBFD_SUPPORT, libbfd);
>  	STATUS(HAVE_DEBUGINFOD_SUPPORT, debuginfod);
>  	STATUS(HAVE_LIBELF_SUPPORT, libelf);
> +	STATUS(HAVE_LLVM_SUPPORT, libllvm);
>  	STATUS(HAVE_LIBNUMA_SUPPORT, libnuma);
>  	STATUS(HAVE_LIBNUMA_SUPPORT, numa_num_possible_cpus);
>  	STATUS(HAVE_LIBPERL_SUPPORT, libperl);
> diff --git a/tools/perf/util/Build b/tools/perf/util/Build
> index da64efd8718f..32c4e5e634ed 100644
> --- a/tools/perf/util/Build
> +++ b/tools/perf/util/Build
> @@ -226,6 +226,7 @@ perf-$(CONFIG_CXX_DEMANGLE) += demangle-cxx.o
>  perf-y += demangle-ocaml.o
>  perf-y += demangle-java.o
>  perf-y += demangle-rust.o
> +perf-$(CONFIG_LLVM) += llvm-c-helpers.o
>  
>  ifdef CONFIG_JITDUMP
>  perf-$(CONFIG_LIBELF) += jitdump.o
> diff --git a/tools/perf/util/llvm-c-helpers.cpp b/tools/perf/util/llvm-c-helpers.cpp
> new file mode 100644
> index 000000000000..cde3f1f03af0
> --- /dev/null
> +++ b/tools/perf/util/llvm-c-helpers.cpp
> @@ -0,0 +1,130 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * Must come before the linux/compiler.h include, which defines several
> + * macros (e.g. noinline) that conflict with compiler builtins used
> + * by LLVM.
> + */
> +#pragma GCC diagnostic push
> +#pragma GCC diagnostic ignored "-Wunused-parameter"  /* Needed for LLVM <= 15 */
> +#include <llvm/DebugInfo/Symbolize/Symbolize.h>
> +#pragma GCC diagnostic pop
> +
> +#include <stdio.h>
> +#include <sys/types.h>
> +#include <linux/compiler.h>
> +#include "symbol_conf.h"
> +#include "llvm-c-helpers.h"
> +
> +using namespace llvm;
> +using llvm::symbolize::LLVMSymbolizer;
> +
> +/*
> + * Allocate a static LLVMSymbolizer, which will live to the end of the program.
> + * Unlike the bfd paths, LLVMSymbolizer has its own cache, so we do not need
> + * to store anything in the dso struct.
> + */
> +static LLVMSymbolizer *get_symbolizer()
> +{
> +	static LLVMSymbolizer *instance = nullptr;
> +	if (instance == nullptr) {
> +		LLVMSymbolizer::Options opts;
> +		/*
> +		 * LLVM sometimes demangles slightly different from the rest
> +		 * of the code, and this mismatch can cause new_inline_sym()
> +		 * to get confused and mark non-inline symbol as inlined
> +		 * (since the name does not properly match up with base_sym).
> +		 * Thus, disable the demangling and let the rest of the code
> +		 * handle it.
> +		 */
> +		opts.Demangle = false;
> +		instance = new LLVMSymbolizer(opts);
> +	}
> +	return instance;
> +}
> +
> +/* Returns 0 on error, 1 on success. */
> +static int extract_file_and_line(const DILineInfo& line_info, char **file,
> +				 unsigned int *line)
> +{
> +	if (file) {
> +		if (line_info.FileName == "<invalid>") {
> +			/* Match the convention of libbfd. */
> +			*file = nullptr;
> +		} else {
> +			/* The caller expects to get something it can free(). */
> +			*file = strdup(line_info.FileName.c_str());
> +			if (*file == nullptr)
> +				return 0;
> +		}
> +	}
> +	if (line)
> +		*line = line_info.Line;
> +	return 1;
> +}
> +
> +extern "C"
> +int llvm_addr2line(const char *dso_name, u64 addr,
> +		   char **file, unsigned int *line,
> +		   bool unwind_inlines,
> +		   llvm_a2l_frame** inline_frames)
> +{
> +	LLVMSymbolizer *symbolizer = get_symbolizer();
> +	object::SectionedAddress sectioned_addr = {
> +		addr,
> +		object::SectionedAddress::UndefSection
> +	};
> +
> +	if (unwind_inlines) {
> +		Expected<DIInliningInfo> res_or_err =
> +			symbolizer->symbolizeInlinedCode(dso_name,
> +							 sectioned_addr);
> +		if (!res_or_err)
> +			return 0;
> +		unsigned num_frames = res_or_err->getNumberOfFrames();
> +		if (num_frames == 0)
> +			return 0;
> +
> +		if (extract_file_and_line(
> +			res_or_err->getFrame(0), file, line) == 0)
> +			return 0;
> +
> +		*inline_frames = (llvm_a2l_frame*)malloc(
> +			sizeof(**inline_frames) * num_frames);
> +		if (*inline_frames == nullptr)
> +			return 0;
> +
> +		for (unsigned i = 0; i < num_frames; ++i) {
> +			const DILineInfo& src = res_or_err->getFrame(i);
> +			llvm_a2l_frame& dst = (*inline_frames)[i];
> +			if (src.FileName == "<invalid>")
> +				/* Match the convention of libbfd. */
> +				dst.filename = nullptr;
> +			else
> +				dst.filename = strdup(src.FileName.c_str());
> +			dst.funcname = strdup(src.FunctionName.c_str());
> +			dst.line = src.Line;
> +
> +			if (dst.filename == nullptr ||
> +			    dst.funcname == nullptr) {
> +				for (unsigned j = 0; j <= i; ++j) {
> +					free((*inline_frames)[j].filename);
> +					free((*inline_frames)[j].funcname);
> +				}
> +				free(*inline_frames);
> +				return 0;
> +			}
> +		}
> +
> +		return num_frames;
> +	} else {
> +		if (inline_frames)
> +			*inline_frames = nullptr;
> +
> +		Expected<DILineInfo> res_or_err =
> +			symbolizer->symbolizeCode(dso_name, sectioned_addr);
> +		if (!res_or_err)
> +			return 0;
> +		return extract_file_and_line(*res_or_err, file, line);
> +	}
> +}
> diff --git a/tools/perf/util/llvm-c-helpers.h b/tools/perf/util/llvm-c-helpers.h
> new file mode 100644
> index 000000000000..1b28cdc9f9b7
> --- /dev/null
> +++ b/tools/perf/util/llvm-c-helpers.h
> @@ -0,0 +1,47 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __PERF_LLVM_C_HELPERS
> +#define __PERF_LLVM_C_HELPERS 1
> +
> +/*
> + * Helpers to call into LLVM C++ code from C, for the parts that do not have
> + * C APIs.
> + */
> +
> +#ifdef __cplusplus
> +extern "C" {
> +#endif
> +
> +struct llvm_a2l_frame {
> +	char *filename;
> +	char *funcname;
> +	unsigned int line;
> +};
> +
> +/*
> + * Implement addr2line() using libLLVM. LLVM is a C++ API, and
> + * many of the linux/ headers cannot be included in a C++ compile unit,
> + * so we need to make a little bridge code here. llvm_addr2line() will
> + * convert the inline frame information from LLVM's internal structures
> + * and put them into a flat array given in inline_frames. The caller
> + * is then responsible for taking that array and convert it into perf's
> + * regular inline frame structures (which depend on e.g. struct list_head).
> + *
> + * If the address could not be resolved, or an error occurred (e.g. OOM),
> + * returns 0. Otherwise, returns the number of inline frames (which means 1
> + * if the address was not part of an inlined function). If unwind_inlines
> + * is set and the return code is nonzero, inline_frames will be set to
> + * a newly allocated array with that length. The caller is then responsible
> + * for freeing both the strings and the array itself.
> + */
> +int llvm_addr2line(const char *dso_name,
> +		   u64 addr,
> +		   char **file,
> +		   unsigned int *line,
> +		   bool unwind_inlines,
> +		   struct llvm_a2l_frame **inline_frames);
> +
> +#ifdef __cplusplus
> +}
> +#endif
> +
> +#endif /* __PERF_LLVM_C_HELPERS */
> diff --git a/tools/perf/util/srcline.c b/tools/perf/util/srcline.c
> index 9d670d8c1c08..0505b4c16608 100644
> --- a/tools/perf/util/srcline.c
> +++ b/tools/perf/util/srcline.c
> @@ -16,6 +16,9 @@
>  #include "util/debug.h"
>  #include "util/callchain.h"
>  #include "util/symbol_conf.h"
> +#ifdef HAVE_LLVM_SUPPORT
> +#include "util/llvm-c-helpers.h"
> +#endif
>  #include "srcline.h"
>  #include "string2.h"
>  #include "symbol.h"
> @@ -130,7 +133,59 @@ static struct symbol *new_inline_sym(struct dso *dso,
>  
>  #define MAX_INLINE_NEST 1024
>  
> -#ifdef HAVE_LIBBFD_SUPPORT
> +#ifdef HAVE_LLVM_SUPPORT
> +
> +static void free_llvm_inline_frames(struct llvm_a2l_frame *inline_frames,
> +				    int num_frames)
> +{
> +	if (inline_frames != NULL) {
> +		for (int i = 0; i < num_frames; ++i) {
> +			free(inline_frames[i].filename);
> +			free(inline_frames[i].funcname);
> +		}
> +		free(inline_frames);
> +	}
> +}
> +
> +static int addr2line(const char *dso_name, u64 addr,
> +		     char **file, unsigned int *line, struct dso *dso,
> +		     bool unwind_inlines, struct inline_node *node,
> +		     struct symbol *sym)
> +{
> +	struct llvm_a2l_frame *inline_frames = NULL;
> +	int num_frames = llvm_addr2line(dso_name, addr, file, line,
> +					node && unwind_inlines, &inline_frames);
> +
> +	if (num_frames == 0 || !inline_frames) {
> +		/* Error, or we didn't want inlines. */
> +		return num_frames;
> +	}
> +
> +	for (int i = 0; i < num_frames; ++i) {
> +		struct symbol *inline_sym =
> +			new_inline_sym(dso, sym, inline_frames[i].funcname);
> +		char *srcline = NULL;
> +
> +		if (inline_frames[i].filename)
> +			srcline = srcline_from_fileline(
> +				inline_frames[i].filename,
> +				inline_frames[i].line);
> +		if (inline_list__append(inline_sym, srcline, node) != 0) {
> +			free_llvm_inline_frames(inline_frames, num_frames);
> +			return 0;
> +		}
> +	}
> +	free_llvm_inline_frames(inline_frames, num_frames);
> +
> +	return num_frames;
> +}
> +
> +void dso__free_a2l(struct dso *)
> +{
> +	/* Nothing to free. */
> +}
> +
> +#elif defined(HAVE_LIBBFD_SUPPORT)
>  
>  /*
>   * Implement addr2line using libbfd.
> -- 
> 2.43.0
