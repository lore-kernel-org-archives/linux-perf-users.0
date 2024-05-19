Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDABC69D3C
	for <linux-perf-users@vger.kernel.org>; Sun, 19 May 2024 18:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716143041; cv=none; b=cunkUwAg/JLLjq7CDuYhqGLQOe04WtXwqISHzcNQ3eSkWD7l5pfiJ8+77LHwzh/vcdHm+CaTob9MfCdpWill9EjvmaqEHLZX9Ggah9HYcCiJholuR/e+X0CedLQPrbcDATn2/Gr/VYn7xbIoR/lFeNBLrnmnLwq8eYx94XO4OwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716143041; c=relaxed/simple;
	bh=mr+eZUx5FBxznYNvPO60v1qdYd5RLgJiv+DwL4EVqMg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=diDst/48obfQbeBusminzd2q30jsg+5A/sKodMPh06WDsv+uIeBEbccOMCeUBcjgMcTRjYOyl/4Sswt6KVfIb6eZwZGwHsn3bLOHHLyyXnFQmTBD1A2ygxMxweNIqhw4w+bC1XredLPAM3EokFwoCdnUV1n8rtwknG5I2TLjGXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0u6+hFNo; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0u6+hFNo"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1ee0ccf9c2fso105725ad.0
        for <linux-perf-users@vger.kernel.org>; Sun, 19 May 2024 11:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716143039; x=1716747839; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=584NAcSuuyFaCL2QspW175GCA9CrQzEbq4x1MVwYU38=;
        b=0u6+hFNoueDEk9SlIVS2wgWg+V8jCyKe28Hs1/7ngaB3AJAOYAJ0mOYuGFVT4t/zRo
         oY+fNHO4lYZhlbcZncPwyb3Wjc2uenreiomQr08IHY4P32kOA5wxqPyb5i3/BOpQqwgI
         FwGwyGsP3Gqr1lVc1JBQRJ+OkAvfHqAXw0c1ijbzq3o4eqn5fxnRGulIUeuTwLoDQMH7
         l+5fntUtTyfL7HMXv77ms2DLhEJhuUN15XvWJxJLz27oeaQ3F9G/6wQdRvUYflVdHhMH
         /XdGBG66CsxsoeUM1R9on3l0nGKzUyjIo/I/BA2D0z8DSsYULJmb5/MyUWzAWTYstU/Y
         gHYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716143039; x=1716747839;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=584NAcSuuyFaCL2QspW175GCA9CrQzEbq4x1MVwYU38=;
        b=B0t6V8zErqNuUOH77e2CUChGjKhjCtMr5lbcS6krF8x48kP4eNE61OYeUmUbW7H6lp
         JdjshsjvFC3yVMjAfC3mWN1uXuURQWYc7nrtPXSaxZS4+apv7TpMwfUgqxdwOoDaVaku
         CD3Ju93t1pReokRu4nWuxWU3M3v4NSCRgRV+waZxFsGCMycqbUwmpQMRKSIdvLFJOUK2
         WjH0vcG1lt3sIN5u088txvHl74tciBLbMhmQvyJQfDWzhUkMkktzdS6gXGeccPzKxUks
         ioNBYS3MdGGuBogSpYEVs3jsC7z8XfBpZRwZQv/Fdj4Ke1fJlF7gTJCCxSd0/KGIm5yr
         j1xg==
X-Forwarded-Encrypted: i=1; AJvYcCVg5UaaX9Bmq2d0dQM7PEKOd3ZRqG31i2a810vuJkXM6AqJrjsaOiDvlWGI96ymlGfYosxTV665kwuWLaRwvXocBfiwjZxDZqK2Q/mck910aQ==
X-Gm-Message-State: AOJu0Yy1xfhNNCxIoFL5t3kRuLvcj3wTkLEMQS3coLnaBo8XbCkcg0lg
	kWgL+zS4iz6xwvpDf8sT1JyUnLm5PMt1nj6tSP33/4IaP22hoZfPAmMAt0/KuMMu6UTPprgQSoA
	rDpboeGoH5e5LPnGZF/3pHjcppuQKykwlntoSFHQLKkQ6+Ko2mhaq
X-Google-Smtp-Source: AGHT+IFGa3TRrHFWXG089zv7Usk2n79qOfJh5NPpBOfYtDGrj8M+ee+KIAmVxjIR9m3H3SRWsseLsZpqk2tbjuqjsRI=
X-Received: by 2002:a17:902:a381:b0:1e0:f525:a831 with SMTP id
 d9443c01a7336-1f2ecc4f308mr2330515ad.28.1716143038434; Sun, 19 May 2024
 11:23:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240518165335.3963530-1-sesse@google.com>
In-Reply-To: <20240518165335.3963530-1-sesse@google.com>
From: Ian Rogers <irogers@google.com>
Date: Sun, 19 May 2024 11:23:26 -0700
Message-ID: <CAP-5=fW5YtzYz0R-9ZkgfdAFjkUDHu_Z1Sexs+2SmN0RwhrADw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] perf report: Support LLVM for addr2line()
To: "Steinar H. Gunderson" <sesse@google.com>
Cc: acme@kernel.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 18, 2024 at 9:53=E2=80=AFAM Steinar H. Gunderson <sesse@google.=
com> wrote:
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
> Tested with LLVM 14, 16, 18 and 19. For some reason, LLVM 12 was not
> correctly detected using feature_check, and thus was not tested.
>
> Signed-off-by: Steinar H. Gunderson <sesse@google.com>
> ---
>  tools/perf/Makefile.config         |  15 ++++
>  tools/perf/builtin-version.c       |   1 +
>  tools/perf/util/Build              |   1 +
>  tools/perf/util/llvm-c-helpers.cpp | 129 +++++++++++++++++++++++++++++
>  tools/perf/util/llvm-c-helpers.h   |  47 +++++++++++
>  tools/perf/util/srcline.c          |  57 ++++++++++++-
>  6 files changed, 249 insertions(+), 1 deletion(-)
>  create mode 100644 tools/perf/util/llvm-c-helpers.cpp
>  create mode 100644 tools/perf/util/llvm-c-helpers.h
>
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
> +    CFLAGS +=3D -DHAVE_LLVM_SUPPORT
> +    CXXFLAGS +=3D -DHAVE_LLVM_SUPPORT
> +    CXXFLAGS +=3D $(shell $(LLVM_CONFIG) --cxxflags)
> +    LIBLLVM =3D $(shell $(LLVM_CONFIG) --libs all) $(shell $(LLVM_CONFIG=
) --system-libs)
> +    EXTLIBS +=3D -L$(shell $(LLVM_CONFIG) --libdir) $(LIBLLVM)
> +    $(call detected,CONFIG_LLVM)

I think we might want to display this in the feature list during the build:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/build/Makefile.feature?h=3Dperf-tools-next#n123

> +  else
> +    $(warning No libllvm found, slower source file resolution, please in=
stall llvm-devel/llvm-dev)
> +    NO_LLVM :=3D 1
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

s/HAVE_LIBLLVM_SUPPORT/HAVE_LLVM_SUPPORT/

>         STATUS(HAVE_LIBNUMA_SUPPORT, libnuma);
>         STATUS(HAVE_LIBNUMA_SUPPORT, numa_num_possible_cpus);
>         STATUS(HAVE_LIBPERL_SUPPORT, libperl);
> diff --git a/tools/perf/util/Build b/tools/perf/util/Build
> index da64efd8718f..32c4e5e634ed 100644
> --- a/tools/perf/util/Build
> +++ b/tools/perf/util/Build
> @@ -226,6 +226,7 @@ perf-$(CONFIG_CXX_DEMANGLE) +=3D demangle-cxx.o
>  perf-y +=3D demangle-ocaml.o
>  perf-y +=3D demangle-java.o
>  perf-y +=3D demangle-rust.o
> +perf-$(CONFIG_LLVM) +=3D llvm-c-helpers.o
>
>  ifdef CONFIG_JITDUMP
>  perf-$(CONFIG_LIBELF) +=3D jitdump.o
> diff --git a/tools/perf/util/llvm-c-helpers.cpp b/tools/perf/util/llvm-c-=
helpers.cpp
> new file mode 100644
> index 000000000000..2dafaaa86234
> --- /dev/null
> +++ b/tools/perf/util/llvm-c-helpers.cpp
> @@ -0,0 +1,129 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * Must come before the linux/compiler.h include, which defines several
> + * macros (e.g. noinline) that conflict with compiler builtins used
> + * by LLVM. */
> +#pragma GCC diagnostic push
> +#pragma GCC diagnostic ignored "-Wunused-parameter"  /* Needed for LLVM =
14. */

nit: pehaps disabling this should be conditional:
#if LLVM_VERSION_MAJOR =3D=3D 14

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
> +static int extract_file_and_line(const DILineInfo& line_info, char **fil=
e,
> +                                unsigned int *line)
> +{
> +       if (file) {
> +               if (line_info.FileName =3D=3D "<invalid>") {
> +                       /* Match the convention of libbfd. */
> +                       *file =3D nullptr;

Should "*file" be cleared if "!file" so the caller can reliably free it?

I did some testing and everything looks good.

Thanks,
Ian

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
> +                  llvm_a2l_frame** inline_frames)
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
> +               if (extract_file_and_line(
> +                       res_or_err->getFrame(0), file, line) =3D=3D 0)
> +                       return 0;
> +
> +               *inline_frames =3D (llvm_a2l_frame*)malloc(
> +                       sizeof(**inline_frames) * num_frames);
> +               if (*inline_frames =3D=3D nullptr)
> +                       return 0;
> +
> +               for (unsigned i =3D 0; i < num_frames; ++i) {
> +                       const DILineInfo& src =3D res_or_err->getFrame(i)=
;
> +                       llvm_a2l_frame& dst =3D (*inline_frames)[i];
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
> +                                       free((*inline_frames)[j].filename=
);
> +                                       free((*inline_frames)[j].funcname=
);
> +                               }
> +                               free(*inline_frames);
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
> index 000000000000..f295aa2bcf2d
> --- /dev/null
> +++ b/tools/perf/util/llvm-c-helpers.h
> @@ -0,0 +1,47 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __PERF_LLVM_ADDR2LINE
> +#define __PERF_LLVM_ADDR2LINE 1
> +
> +/*
> + * Helpers to call into LLVM C++ code from C, for the parts that do not =
have
> + * C APIs.
> + */
> +
> +#ifdef __cplusplus
> +extern "C" {
> +#endif
> +
> +struct llvm_a2l_frame {
> +       char *filename;
> +       char *funcname;
> +       unsigned int line;
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
> +int llvm_addr2line(const char *dso_name,
> +                  u64 addr,
> +                  char **file,
> +                  unsigned int *line,
> +                  bool unwind_inlines,
> +                  struct llvm_a2l_frame **inline_frames);
> +
> +#ifdef __cplusplus
> +}
> +#endif
> +
> +#endif /* __PERF_LLVM_ADDR2LINE */
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
> @@ -130,7 +133,59 @@ static struct symbol *new_inline_sym(struct dso *dso=
,
>
>  #define MAX_INLINE_NEST 1024
>
> -#ifdef HAVE_LIBBFD_SUPPORT
> +#ifdef HAVE_LLVM_SUPPORT
> +
> +static void free_llvm_inline_frames(struct llvm_a2l_frame *inline_frames=
,
> +                                   int num_frames)
> +{
> +       if (inline_frames !=3D NULL) {
> +               for (int i =3D 0; i < num_frames; ++i) {
> +                       free(inline_frames[i].filename);
> +                       free(inline_frames[i].funcname);
> +               }
> +               free(inline_frames);
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
>
>  /*
>   * Implement addr2line using libbfd.
> --
> 2.43.0
>
