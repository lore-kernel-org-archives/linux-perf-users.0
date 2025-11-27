Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73DC315D30
	for <linux-perf-users@vger.kernel.org>; Thu, 27 Nov 2025 11:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764243835; cv=none; b=BfI5hz8Bl6Zg4lknqhw6NBOrZLoh86LPlS2lgxTVKAG5Ul9nCY+rIG8rwAiQVXcSY3hIu+NowpPGyVIv/uhKe/fZLYLRWUXSglO1wUev7nmsJRH5t+CqRu0UwfZYuY5BkbOWnazZmpLeg47QMhfnj1JJSFa1nzW8yAHtcD3mczo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764243835; c=relaxed/simple;
	bh=W9xmP1iEBq6YkXwOsYf2ioBJfR0tUwAI1CCZh+dNQ80=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zmusx+5asGsLjUf0rixNvJEIq3exTsAQZJ0/pXboLtWRmb3KhP2TWAmnQafbl8zyKfZV11bci6n8JiOdMkBMIPOTw9ooU7QUCrxviC/DWKlY9Xok4aCYDrfapJKr7o0AuHOkoTFa6aTkr0jtFXKXcvHQL+AOZEGiSeQ0iCD3xrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tUGrKeEt; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tUGrKeEt"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-297e13bf404so157925ad.0
        for <linux-perf-users@vger.kernel.org>; Thu, 27 Nov 2025 03:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764243828; x=1764848628; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BAWzRIWVp88I0dHlPsoKuKQq1cPy4odnb54ToF57744=;
        b=tUGrKeEt4UTPKQRzN6XX++lA1+um0gmwzOOsvLP5Mt3c0rG+Oo16GNBu/t/tdX8Ucs
         pvsd48qfxiCKwNcPFHaKOY844cuGera8kben314g2YyBS+d1U7EB4N2RgfUfRViUbtvS
         ueVxyyQlvM1Gye5BXcY54M002ElupQgrdm5uxl/ikDCbTWePQTfT+9Xwk8jFM3gZmomx
         HyWHZXdMXODwv20X04R5X+i3Dveh4PtyYT3mr1w93iY6dSga4LxftsseTKs6zCWQGQeO
         j9FNSrQM2S1iNgtLJTKoDzoJVFDGbAxY4QKba+RTCGpa+C6jhhLMy0/elaJVNoPN4f6z
         JMMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764243828; x=1764848628;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BAWzRIWVp88I0dHlPsoKuKQq1cPy4odnb54ToF57744=;
        b=Xcw6/jfeuhRnSfIgITTxm0dkitE2dktBxCfNPLpBFMwUctla1BJbg49CgDfYOLXMlE
         vIuaKbAd+hPMcE0VkENYXnvfVo8yvaFE3Ufj2DCBwPaXhsgylNR1FBSxXhfE/CixPlft
         FS5v8N2D1dufcWfFF7h8hm2SvbwHVph7SgO+YmYCMJXWaPPv3yAPqZd7T5ipCgVS+L/e
         AktkvLuqpYs3RPaCpZPsImW5kMb9NQ56YTZoTPTHxtkhvss1+TnAMH0LCFseSsC1tdGx
         NNsGz9dZcqtCltzrUjQ58F9FuLv3ft87gfPUw7z4TJHqcaDWqr2ZkrVOGLaW5LDENxCC
         IGjw==
X-Forwarded-Encrypted: i=1; AJvYcCVVBbMkZw9ksaxNU2qHJApRtK7IiY27zqZ+dDOw/OLa/EHv2LnrIoYIqrRUTPvN02tcF4t9y11ILpE0D2jQzzDz@vger.kernel.org
X-Gm-Message-State: AOJu0YyJWYqav5hIPeaHi7j+fJBfd2Zgag3Mn7GhlWNElsx4FGVNc97z
	qENLZe0+UjhA4b8MEPr6dTs3WZJSYoMu7VAVxqOfDY33x/oCF3j/qysLNrmSx5vdBttLNuuMifo
	yH6LhIO/VvC9FgxeVqGq4Uw14fY/noSXS57ImDeFv
X-Gm-Gg: ASbGncstCxmTBgZHosxLnYlJ0lQbhBpVDRmBt/CBgBlvB/QKnJyDrG/uNZJk8PW2ZNA
	H7WBMx+3gv1QBEGIoMQmUZuQv8KH5ZiW2up7s/16IwJCzN3I+892Xm2a9KGcTKyEe70RuArpzxt
	ueRcq50eydEReOaZI5AvQqWuKnKM2igabSRBSLFDz/kOAwNsz9pdm6R/b2bkfdLOZy2PYW3KOo0
	XwAgLnACanVfQ2+3PbDV6A+MgFNr4M0IG3srD7q0kx5K4fJpTo0FOBEzofYC05hFn0MOXuD7rHt
	2ks3KD4=
X-Google-Smtp-Source: AGHT+IF+prPaBXcisQxg/JvMx631jaj8ZLTbZHc3ZSec3Xcv/9acc52sndzy2BWRNaqa45sqgHEGilQUPA+i9TJ9vLQ=
X-Received: by 2002:a17:902:d4c6:b0:297:fe6f:a26e with SMTP id
 d9443c01a7336-29bc92a22b1mr1963515ad.14.1764243827690; Thu, 27 Nov 2025
 03:43:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251122093934.94971-1-irogers@google.com> <aSdGq2K6TRMyG009@google.com>
In-Reply-To: <aSdGq2K6TRMyG009@google.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 27 Nov 2025 03:43:34 -0800
X-Gm-Features: AWmQ_bmTUAtmZBXw8kZUmT5Hh8KvutMX9VH7HAyAWzoXO4K-f4_7jlgYocOGN3Q
Message-ID: <CAP-5=fULHMCw=b0PuN07r=aAjoamb+MNSNrHM3nyHPYM2DGkow@mail.gmail.com>
Subject: Re: [PATCH v1] perf addr2line: Add a libdw implementation
To: Namhyung Kim <namhyung@kernel.org>
Cc: Tony Jones <tonyj@suse.de>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Howard Chu <howardchu95@gmail.com>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 26, 2025 at 10:27=E2=80=AFAM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> On Sat, Nov 22, 2025 at 01:39:34AM -0800, Ian Rogers wrote:
> > Add an implementation of addr2line that uses libdw. Other addr2line
> > implementations or, in the case of forking addr2line, slow. Add an
> > implementation that caches the libdw information in the dso and uses
> > it to find the file and line number information.

Thanks James and Namhyung for the reviews! I agree with James' comment
about a typo in the commit message.

> My concern is the limit in the open file descriptors in case the data
> touched a lot of different libraries.  The DSO code has some logic to
> deal with it but I'm not sure if we can share that since libdw seems to
> want to own the FD.

The code opens the FD:

+               fd =3D open(dso_name, O_RDONLY);
+               if (fd < 0)
+                       return 0;
+
+               dwfl =3D dwfl_begin(&offline_callbacks);
+               if (!dwfl) {
+                       close(fd);
+                       return 0;
+               }

It then uses the FD and closes it (the close is hidden in libdw itself):

+               /*
+                * If the report is successful, the file descriptor fd
is consumed
+                * and closed by the Dwfl. If not, it is not closed.
+                */
+               mod =3D dwfl_report_offline(dwfl, dso_name, dso_name, fd);

So it is possible we exhaust all the file descriptors if there are
multiple concurrent calls to libdw__addr2line and every dso has
missing libdw dwfl data... but because the open/close are close
together and that 1 FD is say small to the FDs needed for the
cmd__addr2line, I don't think it is a problem we need to specifically
handle. Were the FD kept open until the dso was deleted, I'd agree
with you.

> Also, have you checked if this generates the exactly same output with
> other implementations?

So the code passes `perf test` and I was checking functionality with
perf annotate, top, etc. What I saw looked good, but it may not have
been exhaustive. I didn't specifically create a test that compares the
output of the different addr2line implementations. Such a test would
be possible, it's not something we've done elsewhere.

Thanks,
Ian

> Thanks,
> Namhyung
>
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/Build     |   1 +
> >  tools/perf/util/dso.c     |   2 +
> >  tools/perf/util/dso.h     |  11 +++
> >  tools/perf/util/libdw.c   | 136 ++++++++++++++++++++++++++++++++++++++
> >  tools/perf/util/libdw.h   |  60 +++++++++++++++++
> >  tools/perf/util/srcline.c |   5 ++
> >  6 files changed, 215 insertions(+)
> >  create mode 100644 tools/perf/util/libdw.c
> >  create mode 100644 tools/perf/util/libdw.h
> >
> > diff --git a/tools/perf/util/Build b/tools/perf/util/Build
> > index 1c2a43e1dc68..2bed6274e248 100644
> > --- a/tools/perf/util/Build
> > +++ b/tools/perf/util/Build
> > @@ -224,6 +224,7 @@ perf-util-$(CONFIG_LIBDW) +=3D dwarf-regs-powerpc.o
> >  perf-util-$(CONFIG_LIBDW) +=3D dwarf-regs-x86.o
> >  perf-util-$(CONFIG_LIBDW) +=3D debuginfo.o
> >  perf-util-$(CONFIG_LIBDW) +=3D annotate-data.o
> > +perf-util-$(CONFIG_LIBDW) +=3D libdw.o
> >
> >  perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) +=3D unwind-libdw.o
> >  perf-util-$(CONFIG_LOCAL_LIBUNWIND)    +=3D unwind-libunwind-local.o
> > diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
> > index 344e689567ee..06980844c014 100644
> > --- a/tools/perf/util/dso.c
> > +++ b/tools/perf/util/dso.c
> > @@ -32,6 +32,7 @@
> >  #include "string2.h"
> >  #include "vdso.h"
> >  #include "annotate-data.h"
> > +#include "libdw.h"
> >
> >  static const char * const debuglink_paths[] =3D {
> >       "%.0s%s",
> > @@ -1605,6 +1606,7 @@ void dso__delete(struct dso *dso)
> >       auxtrace_cache__free(RC_CHK_ACCESS(dso)->auxtrace_cache);
> >       dso_cache__free(dso);
> >       dso__free_a2l(dso);
> > +     dso__free_a2l_libdw(dso);
> >       dso__free_symsrc_filename(dso);
> >       nsinfo__zput(RC_CHK_ACCESS(dso)->nsinfo);
> >       mutex_destroy(dso__lock(dso));
> > diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
> > index f8ccb9816b89..4aee23775054 100644
> > --- a/tools/perf/util/dso.h
> > +++ b/tools/perf/util/dso.h
> > @@ -268,6 +268,7 @@ DECLARE_RC_STRUCT(dso) {
> >       const char       *short_name;
> >       const char       *long_name;
> >       void             *a2l;
> > +     void             *a2l_libdw;
> >       char             *symsrc_filename;
> >  #if defined(__powerpc__)
> >       void            *dwfl;                  /* DWARF debug info */
> > @@ -334,6 +335,16 @@ static inline void dso__set_a2l(struct dso *dso, v=
oid *val)
> >       RC_CHK_ACCESS(dso)->a2l =3D val;
> >  }
> >
> > +static inline void *dso__a2l_libdw(const struct dso *dso)
> > +{
> > +     return RC_CHK_ACCESS(dso)->a2l_libdw;
> > +}
> > +
> > +static inline void dso__set_a2l_libdw(struct dso *dso, void *val)
> > +{
> > +     RC_CHK_ACCESS(dso)->a2l_libdw =3D val;
> > +}
> > +
> >  static inline unsigned int dso__a2l_fails(const struct dso *dso)
> >  {
> >       return RC_CHK_ACCESS(dso)->a2l_fails;
> > diff --git a/tools/perf/util/libdw.c b/tools/perf/util/libdw.c
> > new file mode 100644
> > index 000000000000..c4331fa8e1a3
> > --- /dev/null
> > +++ b/tools/perf/util/libdw.c
> > @@ -0,0 +1,136 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +#include "dso.h"
> > +#include "libdw.h"
> > +#include "srcline.h"
> > +#include "symbol.h"
> > +#include "dwarf-aux.h"
> > +#include <fcntl.h>
> > +#include <unistd.h>
> > +#include <elfutils/libdwfl.h>
> > +
> > +void dso__free_a2l_libdw(struct dso *dso)
> > +{
> > +     Dwfl *dwfl =3D dso__a2l_libdw(dso);
> > +
> > +     if (dwfl) {
> > +             dwfl_end(dwfl);
> > +             dso__set_a2l_libdw(dso, NULL);
> > +     }
> > +}
> > +
> > +int libdw__addr2line(const char *dso_name, u64 addr,
> > +                  char **file, unsigned int *line_nr,
> > +                  struct dso *dso, bool unwind_inlines,
> > +                  struct inline_node *node, struct symbol *sym)
> > +{
> > +     static const Dwfl_Callbacks offline_callbacks =3D {
> > +             .find_debuginfo =3D dwfl_standard_find_debuginfo,
> > +             .section_address =3D dwfl_offline_section_address,
> > +             .find_elf =3D dwfl_build_id_find_elf,
> > +     };
> > +     Dwfl *dwfl =3D dso__a2l_libdw(dso);
> > +     Dwfl_Module *mod;
> > +     Dwfl_Line *dwline;
> > +     Dwarf_Addr bias;
> > +     const char *src;
> > +     int lineno;
> > +
> > +     if (!dwfl) {
> > +             /*
> > +              * Initialize Dwfl session.
> > +              * We need to open the DSO file to report it to libdw.
> > +              */
> > +             int fd;
> > +
> > +             fd =3D open(dso_name, O_RDONLY);
> > +             if (fd < 0)
> > +                     return 0;
> > +
> > +             dwfl =3D dwfl_begin(&offline_callbacks);
> > +             if (!dwfl) {
> > +                     close(fd);
> > +                     return 0;
> > +             }
> > +
> > +             /*
> > +              * If the report is successful, the file descriptor fd is=
 consumed
> > +              * and closed by the Dwfl. If not, it is not closed.
> > +              */
> > +             mod =3D dwfl_report_offline(dwfl, dso_name, dso_name, fd)=
;
> > +             if (!mod) {
> > +                     dwfl_end(dwfl);
> > +                     close(fd);
> > +                     return 0;
> > +             }
> > +
> > +             dwfl_report_end(dwfl, /*removed=3D*/NULL, /*arg=3D*/NULL)=
;
> > +             dso__set_a2l_libdw(dso, dwfl);
> > +     } else {
> > +             /* Dwfl session already initialized, get module for addre=
ss. */
> > +             mod =3D dwfl_addrmodule(dwfl, addr);
> > +     }
> > +
> > +     if (!mod)
> > +             return 0;
> > +
> > +     /* Find source line information for the address. */
> > +     dwline =3D dwfl_module_getsrc(mod, addr);
> > +     if (!dwline)
> > +             return 0;
> > +
> > +     /* Get line information. */
> > +     src =3D dwfl_lineinfo(dwline, &addr, &lineno, /*col=3D*/NULL, /*m=
time=3D*/NULL, /*length=3D*/NULL);
> > +
> > +     if (file)
> > +             *file =3D src ? strdup(src) : NULL;
> > +     if (line_nr)
> > +             *line_nr =3D lineno;
> > +
> > +     /* Optionally unwind inline function call chain. */
> > +     if (unwind_inlines && node && src) {
> > +             Dwarf_Die *cudie =3D dwfl_module_addrdie(mod, addr, &bias=
);
> > +             Dwarf_Die *scopes =3D NULL;
> > +             int nscopes;
> > +
> > +             if (!cudie)
> > +                     return 1;
> > +
> > +             nscopes =3D die_get_scopes(cudie, addr, &scopes);
> > +             if (nscopes > 0) {
> > +                     int i;
> > +                     const char *call_file =3D src;
> > +                     unsigned int call_line =3D lineno;
> > +
> > +                     for (i =3D 0; i < nscopes; i++) {
> > +                             Dwarf_Die *die =3D &scopes[i];
> > +                             struct symbol *inline_sym;
> > +                             char *srcline =3D NULL;
> > +                             int tag =3D dwarf_tag(die);
> > +
> > +                             /* We are interested in inlined subroutin=
es. */
> > +                             if (tag !=3D DW_TAG_inlined_subroutine &&
> > +                                 tag !=3D DW_TAG_subprogram)
> > +                                     continue;
> > +
> > +                             inline_sym =3D new_inline_sym(dso, sym, d=
warf_diename(die));
> > +
> > +                             if (call_file)
> > +                                     srcline =3D srcline_from_fileline=
(call_file, call_line);
> > +
> > +                             inline_list__append(inline_sym, srcline, =
node);
> > +
> > +                             /* Update call site for next level. */
> > +                             if (tag =3D=3D DW_TAG_inlined_subroutine)=
 {
> > +                                     call_file =3D die_get_call_file(d=
ie);
> > +                                     call_line =3D die_get_call_lineno=
(die);
> > +                             } else {
> > +                                     /* Reached the root subprogram. *=
/
> > +                                     break;
> > +                             }
> > +                     }
> > +                     free(scopes);
> > +             }
> > +     }
> > +
> > +     return 1;
> > +}
> > diff --git a/tools/perf/util/libdw.h b/tools/perf/util/libdw.h
> > new file mode 100644
> > index 000000000000..0f8d7b4a11a5
> > --- /dev/null
> > +++ b/tools/perf/util/libdw.h
> > @@ -0,0 +1,60 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef PERF_LIBDW_H
> > +#define PERF_LIBDW_H
> > +
> > +#include <linux/types.h>
> > +
> > +struct dso;
> > +struct inline_node;
> > +struct symbol;
> > +
> > +#ifdef HAVE_LIBDW_SUPPORT
> > +/*
> > + * libdw__addr2line - Convert address to source location using libdw
> > + * @dso_name: Name of the DSO
> > + * @addr: Address to resolve
> > + * @file: Pointer to return filename (caller must free)
> > + * @line_nr: Pointer to return line number
> > + * @dso: The dso struct
> > + * @unwind_inlines: Whether to unwind inline function calls
> > + * @node: Inline node list to append to
> > + * @sym: The symbol associated with the address
> > + *
> > + * This function initializes a Dwfl context for the DSO if not already=
 present,
> > + * finds the source line information for the given address, and option=
ally
> > + * resolves inline function call chains.
> > + *
> > + * Returns 1 on success (found), 0 on failure (not found).
> > + */
> > +int libdw__addr2line(const char *dso_name, u64 addr, char **file,
> > +                  unsigned int *line_nr, struct dso *dso,
> > +                  bool unwind_inlines, struct inline_node *node,
> > +                  struct symbol *sym);
> > +
> > +/*
> > + * dso__free_a2l_libdw - Free libdw resources associated with the DSO
> > + * @dso: The dso to free resources for
> > + *
> > + * This function cleans up the Dwfl context used for addr2line lookups=
.
> > + */
> > +void dso__free_a2l_libdw(struct dso *dso);
> > +
> > +#else /* HAVE_LIBDW_SUPPORT */
> > +
> > +static inline int libdw__addr2line(const char *dso_name __maybe_unused=
,
> > +                                u64 addr __maybe_unused, char **file _=
_maybe_unused,
> > +                                unsigned int *line_nr __maybe_unused,
> > +                                struct dso *dso __maybe_unused,
> > +                                bool unwind_inlines __maybe_unused,
> > +                                struct inline_node *node __maybe_unuse=
d,
> > +                                struct symbol *sym __maybe_unused)
> > +{
> > +     return 0;
> > +}
> > +
> > +static inline void dso__free_a2l_libdw(struct dso *dso __maybe_unused)
> > +{
> > +}
> > +#endif /* HAVE_LIBDW_SUPPORT */
> > +
> > +#endif /* PERF_LIBDW_H */
> > diff --git a/tools/perf/util/srcline.c b/tools/perf/util/srcline.c
> > index 27c0966611ab..4b456c4d4138 100644
> > --- a/tools/perf/util/srcline.c
> > +++ b/tools/perf/util/srcline.c
> > @@ -6,6 +6,7 @@
> >  #include "libbfd.h"
> >  #include "llvm.h"
> >  #include "symbol.h"
> > +#include "libdw.h"
> >
> >  #include <inttypes.h>
> >  #include <string.h>
> > @@ -120,6 +121,10 @@ static int addr2line(const char *dso_name, u64 add=
r, char **file, unsigned int *
> >  {
> >       int ret;
> >
> > +     ret =3D libdw__addr2line(dso_name, addr, file, line_nr, dso, unwi=
nd_inlines, node, sym);
> > +     if (ret > 0)
> > +             return ret;
> > +
> >       ret =3D llvm__addr2line(dso_name, addr, file, line_nr, dso, unwin=
d_inlines, node, sym);
> >       if (ret > 0)
> >               return ret;
> > --
> > 2.52.0.rc2.455.g230fcf2819-goog
> >
