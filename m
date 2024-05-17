Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9572A140E2E
	for <linux-perf-users@vger.kernel.org>; Fri, 17 May 2024 21:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715981285; cv=none; b=s+KLeQPvf/npZYn8/fKy2ePV+cAP54kvUZ7N2Es7PzyBhiTbLNjHPKj638I6cQH3sV8Wv7jDMgS7y0KMnNnyQmmNA5psmuSRYU6uhlbMZL3he6MNyeSVBlQaNLIYXFVW0Ah5hrm6xuqzAsgJlEB8DLcAfUekkzCP7kPOFMkeQkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715981285; c=relaxed/simple;
	bh=nYRxh2Q+q3cqguhmRUch78jpUNA0fQH5is4E5/PKs1c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TpFjMfq3hPFrU9m3TF1GrsPNsUClh6Mtg8X1dSCXbGy2nBAXUctnRKGy88PWZvTGA0/CsZMGOOvQIRrSchSLQYI+rV3OnHaDyzMMY2yZnc3U4LiYq9+mXqez6Nv6FA4HoxlOzwZHHDwTYXdHODjJV016LvQJTIwYNX0jdyfdTlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3kBpYWO5; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3kBpYWO5"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1eed90a926fso2695ad.0
        for <linux-perf-users@vger.kernel.org>; Fri, 17 May 2024 14:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715981283; x=1716586083; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EMCi46yjsN43GFngNPm4/ODnDsAz9BYhQBiK5gkFRTI=;
        b=3kBpYWO5/X03dxg0hl7MXQERgeJLPeUFJsezI54G1E9rqWT4dlEB3uxIAtAprq/r01
         cwrfBuOc2xHVJh0UjvsBvA4fIy19dJP/nP1+xW++r0OXqmgGZCIl7/a9fw4KEDM8F/YJ
         gY2GGvGhBCADxYCcpOGlIsTTQa30v6C5GeapNYEtpM2YGx82K54Mgn1ulUpItOkj69Ze
         T7O25zq2pwMaYy11eu9XENbF6vpwu7nPu9/aNkqIVr7AOSOFwa6em3Kpr4t4Ypm+9YE0
         msqDCaxz9gk+F0TOgqwMntYNKL+4IRzWGWNM03y/W0LgGiSqJ1f01guZBJbjIQcNEUlc
         jYCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715981283; x=1716586083;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EMCi46yjsN43GFngNPm4/ODnDsAz9BYhQBiK5gkFRTI=;
        b=fsgIwg9ej+h9/VtZF2toJy//TYwfPHBXOvqIpOohvECSJhbZh7Sil01yoC5Cg1v9aZ
         Y8r4dMAR2L9/rLSAOmJA1viGSZwmRESZcc1Yo572Szj9Az/hMhJi9EMo91wOINJVc1AE
         AplN0Y95rMxk2oYRGyr42EeoB6yyUgicYQOdcUFsls6Q4xi6i1n+ljWTvZE808mQi9Ew
         2T8yFYQU+R8hhUoJqbOtRByVi0Wj3OL8BodnAt6Y24uUmAn1XjEWG7tzIUyM6Gi4IdzJ
         S8xoBzk3Y9L6rWZLLFT+sphJ0iLsAWo+OE4JkalUYqvOnqbxVnm1XAoPD0Y5myHGpNY9
         nakA==
X-Forwarded-Encrypted: i=1; AJvYcCVZgMK/HGVJjMbmYWtmzik8R7rhCdM4rHroufUf3IubgZJUZLEphZsEcKjEwe8sbQrdc3sZYpy/Mnaco22c/CHAobOzWBO5ffocwhAWn81Tuw==
X-Gm-Message-State: AOJu0YztJ+O4unIp/jAE808EFA3VnA/ZEoT7WpPQyJNXsiPkbRCDtVPw
	BoeUI46qxTcmijdooauz7gW0OHITDSHzcM9BrnWqtfkN0PCtTieuvzTfyVbJRrSH7jHMpcg/xOM
	Pc+986tXo/GG9JJbLYNGFO/MCeQ0r0yiFnh6O
X-Google-Smtp-Source: AGHT+IEYDU0SlpfpVOdGw0xaqu9bkITQY67RFxuq5fPC06hKAsrji0/Tmbz+eYP1QhifwBHSA8nfRhLSbJa/276Qn4w=
X-Received: by 2002:a17:902:bb94:b0:1ea:2b8:2761 with SMTP id
 d9443c01a7336-1f2ecbc3fecmr580585ad.20.1715981282455; Fri, 17 May 2024
 14:28:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240517185426.3659651-1-sesse@google.com>
In-Reply-To: <20240517185426.3659651-1-sesse@google.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 17 May 2024 14:27:43 -0700
Message-ID: <CAP-5=fVYvT5EmPDu8gYUPSB+GjHF=K0dvTq2wwwHKOg58LStcw@mail.gmail.com>
Subject: Re: [PATCH] perf report: Support LLVM for addr2line()
To: "Steinar H. Gunderson" <sesse@google.com>, Namhyung Kim <namhyung@kernel.org>
Cc: acme@kernel.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 17, 2024 at 11:54=E2=80=AFAM Steinar H. Gunderson <sesse@google=
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

This is great! There has been talk about the code being slow and I
think libelf may have been another alternative for this (maybe also
capstone). We should probably build a `perf bench` for this given the
variety of choice.

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
> users. And for disassembling, external objdump works fairly well;
> bfd objdump can be slow on large binaries, but it is possible
> to use --objdump=3Dllvm-objdump to get the speed benefits.
> (It appears LLVM-based demangling is very simple, and that LLVM-based
> disassembling is somewhat more involved.)
>
> Tested with LLVM 14, 16, 18 and 19. For some reason, LLVM 12 was not
> correctly detected using feature_check, and thus was not tested.
>
> Signed-off-by: Steinar H. Gunderson <sesse@google.com>
> ---
>  tools/perf/Makefile.config         |  15 ++++
>  tools/perf/builtin-version.c       |   1 +
>  tools/perf/util/Build              |   1 +
>  tools/perf/util/llvm-addr2line.cpp | 134 +++++++++++++++++++++++++++++
>  tools/perf/util/llvm-addr2line.h   |  42 +++++++++
>  tools/perf/util/srcline.c          |  55 +++++++++++-
>  6 files changed, 247 insertions(+), 1 deletion(-)
>  create mode 100644 tools/perf/util/llvm-addr2line.cpp
>  create mode 100644 tools/perf/util/llvm-addr2line.h
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
>         STATUS(HAVE_LIBNUMA_SUPPORT, libnuma);
>         STATUS(HAVE_LIBNUMA_SUPPORT, numa_num_possible_cpus);
>         STATUS(HAVE_LIBPERL_SUPPORT, libperl);
> diff --git a/tools/perf/util/Build b/tools/perf/util/Build
> index da64efd8718f..1cf17afd51f4 100644
> --- a/tools/perf/util/Build
> +++ b/tools/perf/util/Build
> @@ -226,6 +226,7 @@ perf-$(CONFIG_CXX_DEMANGLE) +=3D demangle-cxx.o
>  perf-y +=3D demangle-ocaml.o
>  perf-y +=3D demangle-java.o
>  perf-y +=3D demangle-rust.o
> +perf-$(CONFIG_LLVM) +=3D llvm-addr2line.o
>
>  ifdef CONFIG_JITDUMP
>  perf-$(CONFIG_LIBELF) +=3D jitdump.o
> diff --git a/tools/perf/util/llvm-addr2line.cpp b/tools/perf/util/llvm-ad=
dr2line.cpp
> new file mode 100644
> index 000000000000..145488ed1346
> --- /dev/null
> +++ b/tools/perf/util/llvm-addr2line.cpp
> @@ -0,0 +1,134 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/* Must come before the linux/compiler.h include, which defines several
> + * macros (e.g. noinline) that conflict with compiler builtins used by L=
LVM. */
> +#pragma GCC diagnostic push
> +#pragma GCC diagnostic ignored "-Wunused-parameter"  /* Needed for LLVM =
14. */
> +#include <llvm/DebugInfo/Symbolize/Symbolize.h>
> +#pragma GCC diagnostic pop
> +
> +#include <stdio.h>
> +#include <sys/types.h>
> +#include <linux/compiler.h>
> +#include "symbol_conf.h"
> +#include "llvm-addr2line.h"
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
> +static LLVMSymbolizer *GetSymbolizer()
> +{
> +       static LLVMSymbolizer *instance =3D nullptr;
> +       if (instance =3D=3D nullptr) {
> +               LLVMSymbolizer::Options Opts;
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
> +               Opts.Demangle =3D false;
> +               instance =3D new LLVMSymbolizer(Opts);
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
> +               } else {
> +                       /* The caller expects to get something it can fre=
e(). */
> +                       *file =3D strdup(line_info.FileName.c_str());
> +                       if (*file =3D=3D nullptr) {
> +                               return 0;
> +                       }
> +               }
> +       }
> +       if (line) {
> +               *line =3D line_info.Line;
> +       }

nit: kernel style is no curly braces for a single line. If there are
curlies for the if or the else then curlies should be on both sides.
./scripts/checkpatch.pl should be able to catch things like this, but
it may ignore C++ files.

> +       return 1;
> +}
> +
> +extern "C"
> +int llvm_addr2line(const char *dso_name, u64 addr,
> +                  char **file, unsigned int *line,
> +                  bool unwind_inlines,
> +                  llvm_a2l_frame** inline_frames)
> +{
> +       LLVMSymbolizer *symbolizer =3D GetSymbolizer();
> +       object::SectionedAddress sectioned_addr =3D {
> +               addr,
> +               object::SectionedAddress::UndefSection
> +       };
> +
> +       if (unwind_inlines) {
> +               Expected<DIInliningInfo> res_or_err =3D
> +                       symbolizer->symbolizeInlinedCode(dso_name,
> +                                                        sectioned_addr);

nit: this may fit on a line as we wrap at 100 characters

> +               if (!res_or_err) {
> +                       return 0;
> +               }

nit: curlies

> +               unsigned num_frames =3D res_or_err->getNumberOfFrames();
> +               if (num_frames =3D=3D 0) {
> +                       return 0;
> +               }

nit: curlies.

> +
> +               if (extract_file_and_line(
> +                       res_or_err->getFrame(0), file, line) =3D=3D 0) {
> +                       return 0;
> +               }
> +
> +               *inline_frames =3D (llvm_a2l_frame*)malloc(
> +                       sizeof(**inline_frames) * num_frames);
> +               if (*inline_frames =3D=3D nullptr) {
> +                       return 0;
> +               }

nit: curlies

> +
> +               for (unsigned i =3D 0; i < num_frames; ++i) {
> +                       const DILineInfo& src =3D res_or_err->getFrame(i)=
;
> +                       llvm_a2l_frame& dst =3D (*inline_frames)[i];
> +                       if (src.FileName =3D=3D "<invalid>") {
> +                               /* Match the convention of libbfd. */
> +                               dst.filename =3D nullptr;
> +                       } else {
> +                               dst.filename =3D strdup(src.FileName.c_st=
r());
> +                       }
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
> +               *inline_frames =3D nullptr;
> +
> +               Expected<DILineInfo> res_or_err =3D
> +                       symbolizer->symbolizeCode(dso_name, sectioned_add=
r);
> +               if (!res_or_err) {
> +                       return 0;
> +               }

nit: curlies

Thanks,
Ian

> +               return extract_file_and_line(*res_or_err, file, line);
> +       }
> +}
> diff --git a/tools/perf/util/llvm-addr2line.h b/tools/perf/util/llvm-addr=
2line.h
> new file mode 100644
> index 000000000000..2de4fe79a3d0
> --- /dev/null
> +++ b/tools/perf/util/llvm-addr2line.h
> @@ -0,0 +1,42 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __PERF_LLVM_ADDR2LINE
> +#define __PERF_LLVM_ADDR2LINE 1
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
> index 9d670d8c1c08..f69ad21a18d4 100644
> --- a/tools/perf/util/srcline.c
> +++ b/tools/perf/util/srcline.c
> @@ -16,6 +16,7 @@
>  #include "util/debug.h"
>  #include "util/callchain.h"
>  #include "util/symbol_conf.h"
> +#include "util/llvm-addr2line.h"
>  #include "srcline.h"
>  #include "string2.h"
>  #include "symbol.h"
> @@ -130,7 +131,59 @@ static struct symbol *new_inline_sym(struct dso *dso=
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
