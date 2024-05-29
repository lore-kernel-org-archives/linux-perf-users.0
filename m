Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A16C2B2CF;
	Wed, 29 May 2024 03:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716955021; cv=none; b=T4ShsCL8rYivrOAE6n63OM2KRhTmFY3TaBTMcAUuULPZHJSQGv/rZKOxRZwQ5r2oVSHrcvrfA4GwFmon3G2RZhjId7VBU/pLCe1erYoFWi8lNRooE3fiiW4QnDXQBngmdWQ9MPZdx3+3aZm9VwjsIDOe1QKGIqdRUJc3HqI34Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716955021; c=relaxed/simple;
	bh=keNMOVfP1TK9oagnpDtxlxMYmo8DonPgF5e3uiIyRhg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SMmZPYCMibZ1wpk2gRvSu2aPorrOCfbclLEm2KY2gXre6qumG91o+InmVJRjJt2RvgVmVZDjqGT7cXMnrBGdLFqdqDWlB78Tof6UnMszG9lshJBtuJebcfTNqxH+I/l2W6SDYnGOxdQEeX98JDsJxYlNQFnJU8vKjyZEN4f3mRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-681a4427816so1261981a12.3;
        Tue, 28 May 2024 20:56:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716955019; x=1717559819;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oQifBxt0wAI7sVP0FJgdPRFaeqi3UguaMLT3yU/AMp0=;
        b=OWSNGtTBJvPPG7y2Dc3PkUSzRIh/i82lrwwlHQfgnoDoyHnyb9fZl53M+wt9HFAHdp
         Tyjf0nKy3vuzktGYcN0o95mgllfcOdy3STTvCs8sbGLkAJqgzep503RJtAy4x5Z6xFQM
         ZP1/wQ5ER4roVxpiCek2bI0Huu6/wWIDfJlsO87Zuz/4GJM1XmtaQWmIqhub0yw7Pmq/
         Zp2M0mGhUCSza6StUhrphOjxKihf4KX1eRWARCcOw/Qb0mC1vzSl2D2ryWEqVqAYX2Qj
         4O4pbwswMy6b5lhcy9W0jBStSmnLE5L1Gpb6AINuTqyr6ayH/Qz/yd6vAzO3Qw3JRKPf
         LKHQ==
X-Forwarded-Encrypted: i=1; AJvYcCXpwI5t4aNWzT3VU3MYPqqV3GVHfpjvyOX4wifz/sA6NxPGjvVXuy38b2Fh55N9BbMZTulv27utJKm5lWGmGPc5Ff0WWl6wSuTJ8/Eqqd4vo4BaBrYCX4Q/3odT931LYpfHZws9eLuAqkHdecmS8w==
X-Gm-Message-State: AOJu0Yzl5RfNf3UKfbl8FMNazgZnqJ8ahdrNmHhZmvp/BTPYk/T2/FFn
	FjQAzJKU2xJpX5flRcvbPTLbeLzOgp6rYZ9HAQpdyxCsPaZIvTIrHmFrgPnMp0ddl7UCPJfuKt9
	gmZZCOg2FQi7Nd3CUg0gcTvWYl1Jbow==
X-Google-Smtp-Source: AGHT+IFXRC635TfpXJm4sG0gxK/0mhN+aNLTv4T/xAvUz0z8WZEcUgC9HbmWv062lJQB5lMSMiB/rEB5AhRHiA4bdlk=
X-Received: by 2002:a05:6a20:7285:b0:1b0:259e:c8e0 with SMTP id
 adf61e73a8af0-1b212e575d8mr15823811637.59.1716955019183; Tue, 28 May 2024
 20:56:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240526182212.544525-1-sesse@google.com>
In-Reply-To: <20240526182212.544525-1-sesse@google.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Tue, 28 May 2024 20:56:47 -0700
Message-ID: <CAM9d7chY7CzMx9sSYeagDK81PsE=soGmn4AUxXAE7rHp=jmx3Q@mail.gmail.com>
Subject: Re: [PATCH v7 1/4] perf report: Support LLVM for addr2line()
To: "Steinar H. Gunderson" <sesse@google.com>
Cc: acme@kernel.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, irogers@google.com, 
	Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Sun, May 26, 2024 at 11:22=E2=80=AFAM Steinar H. Gunderson <sesse@google=
.com> wrote:
>
> In addition to the existing support for libbfd and calling out to
> an external addr2line command, add support for using libllvm directly.
> This is both faster than libbfd, and can be enabled in distro builds
> (the LLVM license has an explicit provision for GPLv2 compatibility).
> Thus, it is set as the primary choice if available.
>
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
>
> However, these are much less pressing; most people don't profile
> PE binaries, and perf has non-bfd paths for ELF. The same with
> demangling; the default _cxa_demangle path works fine for most
> users. Disassembling is coming in a later patch in the series;
> however do note that while bfd objdump can be slow on large binaries,
> it is possible to use --objdump=3Dllvm-objdump to get the speed benefits.
> (It appears LLVM-based demangling is very simple, should we want
> that.)
>
> Tested with LLVM 14, 15, 16, 18 and 19. For some reason, LLVM 12 was not
> correctly detected using feature_check, and thus was not tested.
>
> Signed-off-by: Steinar H. Gunderson <sesse@google.com>
> Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/build/Makefile.feature       |   1 +
>  tools/perf/Makefile.config         |  15 ++++
>  tools/perf/builtin-version.c       |   1 +
>  tools/perf/util/Build              |   1 +
>  tools/perf/util/llvm-c-helpers.cpp | 134 +++++++++++++++++++++++++++++
>  tools/perf/util/llvm-c-helpers.h   |  49 +++++++++++
>  tools/perf/util/srcline.c          |  57 +++++++++++-
>  7 files changed, 257 insertions(+), 1 deletion(-)
>  create mode 100644 tools/perf/util/llvm-c-helpers.cpp
>  create mode 100644 tools/perf/util/llvm-c-helpers.h
>
> diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
> index 1e2ab148d5db..278b26216254 100644
> --- a/tools/build/Makefile.feature
> +++ b/tools/build/Makefile.feature
> @@ -136,6 +136,7 @@ FEATURE_DISPLAY ?=3D              \
>           libunwind              \
>           libdw-dwarf-unwind     \
>           libcapstone            \
> +         llvm                   \
>           zlib                   \
>           lzma                   \
>           get_cpuid              \
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index 7f1e016a9253..42f5ad89c0ca 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -969,6 +969,21 @@ ifdef BUILD_NONDISTRO
>    endif
>  endif
>
> +ifndef NO_LIBLLVM
> +  $(call feature_check,llvm)
> +  ifeq ($(feature-llvm), 1)
> +    CFLAGS +=3D -DHAVE_LIBLLVM_SUPPORT
> +    CXXFLAGS +=3D -DHAVE_LIBLLVM_SUPPORT
> +    CXXFLAGS +=3D $(shell $(LLVM_CONFIG) --cxxflags)
> +    LIBLLVM =3D $(shell $(LLVM_CONFIG) --libs all) $(shell $(LLVM_CONFIG=
) --system-libs)
> +    EXTLIBS +=3D -L$(shell $(LLVM_CONFIG) --libdir) $(LIBLLVM)
> +    $(call detected,CONFIG_LIBLLVM)
> +  else
> +    $(warning No libllvm found, slower source file resolution, please in=
stall llvm-devel/llvm-dev)
> +    NO_LIBLLVM :=3D 1
> +  endif
> +endif
> +
>  ifndef NO_DEMANGLE
>    $(call feature_check,cxa-demangle)
>    ifeq ($(feature-cxa-demangle), 1)
> diff --git a/tools/perf/builtin-version.c b/tools/perf/builtin-version.c
> index 398aa53e9e2e..4b252196de12 100644
> --- a/tools/perf/builtin-version.c
> +++ b/tools/perf/builtin-version.c
> @@ -65,6 +65,7 @@ static void library_status(void)
>         STATUS(HAVE_LIBBFD_SUPPORT, libbfd);
>         STATUS(HAVE_DEBUGINFOD_SUPPORT, debuginfod);
>         STATUS(HAVE_LIBELF_SUPPORT, libelf);
> +       STATUS(HAVE_LIBLLVM_SUPPORT, libllvm);
>         STATUS(HAVE_LIBNUMA_SUPPORT, libnuma);
>         STATUS(HAVE_LIBNUMA_SUPPORT, numa_num_possible_cpus);
>         STATUS(HAVE_LIBPERL_SUPPORT, libperl);
> diff --git a/tools/perf/util/Build b/tools/perf/util/Build
> index da64efd8718f..6a1fd8f1a488 100644
> --- a/tools/perf/util/Build
> +++ b/tools/perf/util/Build
> @@ -226,6 +226,7 @@ perf-$(CONFIG_CXX_DEMANGLE) +=3D demangle-cxx.o
>  perf-y +=3D demangle-ocaml.o
>  perf-y +=3D demangle-java.o
>  perf-y +=3D demangle-rust.o
> +perf-$(CONFIG_LIBLLVM) +=3D llvm-c-helpers.o
>
>  ifdef CONFIG_JITDUMP
>  perf-$(CONFIG_LIBELF) +=3D jitdump.o
> diff --git a/tools/perf/util/llvm-c-helpers.cpp b/tools/perf/util/llvm-c-=
helpers.cpp
> new file mode 100644
> index 000000000000..3cc967ec6f28
> --- /dev/null
> +++ b/tools/perf/util/llvm-c-helpers.cpp
> @@ -0,0 +1,134 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * Must come before the linux/compiler.h include, which defines several
> + * macros (e.g. noinline) that conflict with compiler builtins used
> + * by LLVM.
> + */
> +#pragma GCC diagnostic push
> +#pragma GCC diagnostic ignored "-Wunused-parameter"  /* Needed for LLVM =
<=3D 15 */
> +#include <llvm/DebugInfo/Symbolize/Symbolize.h>
> +#pragma GCC diagnostic pop
> +
> +#include <stdio.h>
> +#include <sys/types.h>
> +#include <linux/compiler.h>
> +extern "C" {
> +#include <linux/zalloc.h>
> +}
> +#include "symbol_conf.h"
> +#include "llvm-c-helpers.h"
> +
> +using namespace llvm;
> +using llvm::symbolize::LLVMSymbolizer;
> +
> +/*
> + * Allocate a static LLVMSymbolizer, which will live to the end of the p=
rogram.
> + * Unlike the bfd paths, LLVMSymbolizer has its own cache, so we do not =
need
> + * to store anything in the dso struct.
> + */
> +static LLVMSymbolizer *get_symbolizer()
> +{
> +       static LLVMSymbolizer *instance =3D nullptr;
> +       if (instance =3D=3D nullptr) {
> +               LLVMSymbolizer::Options opts;
> +               /*
> +                * LLVM sometimes demangles slightly different from the r=
est
> +                * of the code, and this mismatch can cause new_inline_sy=
m()
> +                * to get confused and mark non-inline symbol as inlined
> +                * (since the name does not properly match up with base_s=
ym).
> +                * Thus, disable the demangling and let the rest of the c=
ode
> +                * handle it.
> +                */
> +               opts.Demangle =3D false;
> +               instance =3D new LLVMSymbolizer(opts);
> +       }
> +       return instance;
> +}
> +
> +/* Returns 0 on error, 1 on success. */
> +static int extract_file_and_line(const DILineInfo &line_info, char **fil=
e,
> +                                unsigned int *line)
> +{
> +       if (file) {
> +               if (line_info.FileName =3D=3D "<invalid>") {
> +                       /* Match the convention of libbfd. */
> +                       *file =3D nullptr;
> +               } else {
> +                       /* The caller expects to get something it can fre=
e(). */
> +                       *file =3D strdup(line_info.FileName.c_str());
> +                       if (*file =3D=3D nullptr)
> +                               return 0;
> +               }
> +       }
> +       if (line)
> +               *line =3D line_info.Line;
> +       return 1;
> +}
> +
> +extern "C"
> +int llvm_addr2line(const char *dso_name, u64 addr,
> +                  char **file, unsigned int *line,
> +                  bool unwind_inlines,
> +                  llvm_a2l_frame **inline_frames)
> +{
> +       LLVMSymbolizer *symbolizer =3D get_symbolizer();
> +       object::SectionedAddress sectioned_addr =3D {
> +               addr,
> +               object::SectionedAddress::UndefSection
> +       };
> +
> +       if (unwind_inlines) {
> +               Expected<DIInliningInfo> res_or_err =3D
> +                       symbolizer->symbolizeInlinedCode(dso_name,
> +                                                        sectioned_addr);
> +               if (!res_or_err)
> +                       return 0;
> +               unsigned num_frames =3D res_or_err->getNumberOfFrames();
> +               if (num_frames =3D=3D 0)
> +                       return 0;
> +
> +               if (extract_file_and_line(res_or_err->getFrame(0),
> +                                         file, line) =3D=3D 0)
> +                       return 0;
> +
> +               *inline_frames =3D (llvm_a2l_frame *)calloc(
> +                       num_frames, sizeof(**inline_frames));
> +               if (*inline_frames =3D=3D nullptr)
> +                       return 0;
> +
> +               for (unsigned i =3D 0; i < num_frames; ++i) {
> +                       const DILineInfo &src =3D res_or_err->getFrame(i)=
;
> +
> +                       llvm_a2l_frame &dst =3D (*inline_frames)[i];
> +                       if (src.FileName =3D=3D "<invalid>")
> +                               /* Match the convention of libbfd. */
> +                               dst.filename =3D nullptr;
> +                       else
> +                               dst.filename =3D strdup(src.FileName.c_st=
r());
> +                       dst.funcname =3D strdup(src.FunctionName.c_str())=
;
> +                       dst.line =3D src.Line;
> +
> +                       if (dst.filename =3D=3D nullptr ||
> +                           dst.funcname =3D=3D nullptr) {
> +                               for (unsigned j =3D 0; j <=3D i; ++j) {
> +                                       zfree(&(*inline_frames)[j].filena=
me);
> +                                       zfree(&(*inline_frames)[j].funcna=
me);
> +                               }
> +                               zfree(inline_frames);
> +                               return 0;
> +                       }
> +               }
> +
> +               return num_frames;
> +       } else {
> +               if (inline_frames)
> +                       *inline_frames =3D nullptr;
> +
> +               Expected<DILineInfo> res_or_err =3D
> +                       symbolizer->symbolizeCode(dso_name, sectioned_add=
r);
> +               if (!res_or_err)
> +                       return 0;
> +               return extract_file_and_line(*res_or_err, file, line);
> +       }
> +}
> diff --git a/tools/perf/util/llvm-c-helpers.h b/tools/perf/util/llvm-c-he=
lpers.h
> new file mode 100644
> index 000000000000..19332dd98e14
> --- /dev/null
> +++ b/tools/perf/util/llvm-c-helpers.h
> @@ -0,0 +1,49 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __PERF_LLVM_C_HELPERS
> +#define __PERF_LLVM_C_HELPERS 1
> +
> +/*
> + * Helpers to call into LLVM C++ code from C, for the parts that do not =
have
> + * C APIs.
> + */
> +
> +#include <linux/compiler.h>
> +
> +#ifdef __cplusplus
> +extern "C" {
> +#endif
> +
> +struct llvm_a2l_frame {
> +  char* filename;
> +  char* funcname;
> +  unsigned int line;
> +};
> +
> +/*
> + * Implement addr2line() using libLLVM. LLVM is a C++ API, and
> + * many of the linux/ headers cannot be included in a C++ compile unit,
> + * so we need to make a little bridge code here. llvm_addr2line() will
> + * convert the inline frame information from LLVM's internal structures
> + * and put them into a flat array given in inline_frames. The caller
> + * is then responsible for taking that array and convert it into perf's
> + * regular inline frame structures (which depend on e.g. struct list_hea=
d).
> + *
> + * If the address could not be resolved, or an error occurred (e.g. OOM)=
,
> + * returns 0. Otherwise, returns the number of inline frames (which mean=
s 1
> + * if the address was not part of an inlined function). If unwind_inline=
s
> + * is set and the return code is nonzero, inline_frames will be set to
> + * a newly allocated array with that length. The caller is then responsi=
ble
> + * for freeing both the strings and the array itself.
> + */
> +int llvm_addr2line(const char* dso_name,
> +                   u64 addr,
> +                   char** file,
> +                   unsigned int* line,
> +                   bool unwind_inlines,
> +                   struct llvm_a2l_frame** inline_frames);
> +
> +#ifdef __cplusplus
> +}
> +#endif
> +
> +#endif /* __PERF_LLVM_C_HELPERS */
> diff --git a/tools/perf/util/srcline.c b/tools/perf/util/srcline.c
> index 9d670d8c1c08..74091ecc21df 100644
> --- a/tools/perf/util/srcline.c
> +++ b/tools/perf/util/srcline.c
> @@ -16,6 +16,9 @@
>  #include "util/debug.h"
>  #include "util/callchain.h"
>  #include "util/symbol_conf.h"
> +#ifdef HAVE_LIBLLVM_SUPPORT
> +#include "util/llvm-c-helpers.h"
> +#endif
>  #include "srcline.h"
>  #include "string2.h"
>  #include "symbol.h"
> @@ -130,7 +133,59 @@ static struct symbol *new_inline_sym(struct dso *dso=
,
>
>  #define MAX_INLINE_NEST 1024
>
> -#ifdef HAVE_LIBBFD_SUPPORT
> +#ifdef HAVE_LIBLLVM_SUPPORT
> +
> +static void free_llvm_inline_frames(struct llvm_a2l_frame *inline_frames=
,
> +                                   int num_frames)
> +{
> +       if (inline_frames !=3D NULL) {
> +               for (int i =3D 0; i < num_frames; ++i) {
> +                       zfree(&inline_frames[i].filename);
> +                       zfree(&inline_frames[i].funcname);
> +               }
> +               zfree(&inline_frames);
> +       }
> +}
> +
> +static int addr2line(const char *dso_name, u64 addr,
> +                    char **file, unsigned int *line, struct dso *dso,
> +                    bool unwind_inlines, struct inline_node *node,
> +                    struct symbol *sym)
> +{
> +       struct llvm_a2l_frame *inline_frames =3D NULL;
> +       int num_frames =3D llvm_addr2line(dso_name, addr, file, line,
> +                                       node && unwind_inlines, &inline_f=
rames);
> +
> +       if (num_frames =3D=3D 0 || !inline_frames) {
> +               /* Error, or we didn't want inlines. */
> +               return num_frames;
> +       }
> +
> +       for (int i =3D 0; i < num_frames; ++i) {
> +               struct symbol *inline_sym =3D
> +                       new_inline_sym(dso, sym, inline_frames[i].funcnam=
e);
> +               char *srcline =3D NULL;
> +
> +               if (inline_frames[i].filename)
> +                       srcline =3D srcline_from_fileline(
> +                               inline_frames[i].filename,
> +                               inline_frames[i].line);
> +               if (inline_list__append(inline_sym, srcline, node) !=3D 0=
) {
> +                       free_llvm_inline_frames(inline_frames, num_frames=
);
> +                       return 0;
> +               }
> +       }
> +       free_llvm_inline_frames(inline_frames, num_frames);
> +
> +       return num_frames;
> +}
> +
> +void dso__free_a2l(struct dso *)
> +{
> +       /* Nothing to free. */
> +}
> +
> +#elif defined(HAVE_LIBBFD_SUPPORT)

Hmm.. it's unfortunate that we have only one addr2line
implementation at a time.  Maybe we can do the same thing
like in annotate with objdump so that it can fallback to another
method when failing.  But it'd require more changes beyond
this work and I'm not sure if it's really worth it.

Thanks,
Namhyung

>
>  /*
>   * Implement addr2line using libbfd.
> --
> 2.45.1
>
>
