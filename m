Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3164657D6
	for <linux-perf-users@vger.kernel.org>; Tue, 31 Mar 2026 21:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774992082; cv=pass; b=gJF5IS2+1rGhHPrhMkDwsdMli1LSWYKRvtiWvOroifhB9o4uBx3mLklLjpgPBTWlUnSnTWFU7xQAZwkHqkCpf2BK0JbrGTje6LiYMsCi+iuWsYQ8YRom3mWp35V7vI4twLv0Au1LroB4iSOjs+rd6j+53ug1L9iWxumy5Fvi12M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774992082; c=relaxed/simple;
	bh=qdhkIHtGt3V2Z17vqCUDdDKZkTjfg7jUaO1z1Hm54IU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hyjip5om0HpzdmwJvSJvqMYI3Wp97psF80bWWF3gY6c8hEvNkLERvYSPhReVi77gpqK+RkkJaRaZfXMXEv1kXln4LgeW9ngpZeZyhuJnh6Az035zimXPNmTWt5lkVl0/nXfRQNKiZoIcnwafBBBCy77FTtPi53+OwDWueKH/FFw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c4BHjYj0; arc=pass smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c4BHjYj0"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2b0c12be0ecso156625ad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 31 Mar 2026 14:21:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774992078; cv=none;
        d=google.com; s=arc-20240605;
        b=WEP0XaHYgVmQfblCVkIFi9JsPbbsCSKpCzFztvx/pN4VZpLTUvzxcLUYnSZD4RyzkR
         9atuAX/N1PA4nxADOUROeTIiRbEaZeqjKmLKmXAKEmpW6pFGUtLRd4mtrn6W+dbvug7S
         GFy1Xa9sHRvP/ayMz9uwpVRqjix7HfI4/BdhVNm48AJq/82rlCVdzpiSd+ZHS3wur6/t
         v0qfmBITGEeu0FRf14PpIY0DMfk17ZTgYy7NMHrDBNyWb2RKQSfx6Ov8bS5tgqQCRWRV
         FeCC+0AiyVwjyMi7YPETDwzAcZlcFPN7fxlV2prgZcYabcyjwvZGW3T3KADuVCGE0u4f
         VzJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GnS75n7UJaS2ddyRBNP9q5l7UtTm6b8DgT2o9RDojQ4=;
        fh=Fe/LxDJ9W3y9mAr9lDIyGy5qjWTV/WNohNOcQ10knTY=;
        b=R8wFZmkiKIUxyBDy7vMzL3/tRx8Vjq5J0WyuN0977IIQGSAgMRzyfDKdogFjuDZUTx
         3Bqo4kVqCA6pSFCgs1lBfDfy2uzsc/khvqWBAl4bLrxCcHey2vNXLDSxt2DNNou7q+sh
         VizzjOX6awBM/SshcXwvk0E4koIsOzsvLzrbLH/e/AvrDCjxCGsjRkNsvhYZGjESIBnB
         MnRZpvtkBdrm8Br9080o1HVgwlTyw3FEBMTSfe9GGcWmfdfHttRaQiTTig6jmU8sjXz0
         rJzTxshOoVQvl0bhVBDFPf6cX6qCZ8Doj0fdmoQWcZt4mKgXi+2g8pgLOt/WhY7YgM1m
         uBfQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774992078; x=1775596878; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GnS75n7UJaS2ddyRBNP9q5l7UtTm6b8DgT2o9RDojQ4=;
        b=c4BHjYj0zNoU4XcDxdn9inaPYdSdODFqvSZ95hXBymYp9UIbt8nNU4TCwoUD9SqrwT
         qsIP8G/qEEZ7bsO6h9RC46lxCYg6cvb7qcIr6naODIzD1nj2qO6KO1PoLOkSnr/I71ZB
         zdR9LEL1AUwd7V8CqQJhopcYxUhBkYQH/EP1l0VkrntKGV/bMFTs56TuwVxWDEROHQU/
         Z7Lnu39wAFfgDicRcIfxnAUyNuuyWXrr2TVh/kFT5P2LNTRFYyBPIpUWvgBvNyEXLbqz
         uemZZUND8JXFbAbWB2vGCI8pkeP9LcK2vQjlA4alSG7Pq/I9JPL2loApopltOLX3WBNQ
         bnQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774992078; x=1775596878;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GnS75n7UJaS2ddyRBNP9q5l7UtTm6b8DgT2o9RDojQ4=;
        b=c+0gLxdZOVdQNnz8qxZOI/HBmZ1/pkqoHl8es8zI+ik+jgCUBclpN3QCi9Vw8SsNmL
         LE8FOuumMD1fKXUtLp6Cj6zI+bDGgIQ5s4TdY6uQ96QqsTifO1l+6mNxzX1Reja0Gkoq
         Tjz7ktNwB9r1dGraIgwz0Z0//4D4wP+2In4cjStYCOrg9WC5/9Ee5zumSreebgt8Z2Go
         0jsz2UkIfL5wCtbuVXw9kQeqRnmRlO1D7JhimtYxl5UFwk0KQNnhs5nT1/OjYTesrmrJ
         5irnxQNN6042xU+N2Autc9I5vCBz5m79vZ77cgIXf5KdbAcW1c5LZN1Nui3kUoxXVm5x
         lw2w==
X-Forwarded-Encrypted: i=1; AJvYcCX/r1uIEcSVdjviT8i+gX4vyo92gYZ3QzjYCLDjrWhAueQ6/ONn1oT5gOQeAOHgADGNLKMxT9m8UUy3Se6eQYof@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1iAmC4lpRd3mqInPz6VdI42u0bHdjfcAdPrPR+dhJuFjm+vIO
	sogX/ydgITi72Mn3Ss4ykLvl5KT9OQNGJBVQgn8C2t4D3e75tYsOFMgteBRKVMZXTRVdaV59P9g
	3vH5wfmxeAZe1GDgMsGkdlBJa8AuU713DjrExEKadiYIeidXNN42AY09w
X-Gm-Gg: ATEYQzzpqBAIMcY/1m/rKt1fts6GX7gQ2FCFciKHkJTFnjAfLIapBXtK5pul1ry441h
	kM5rNNG+848zvL+kKt+Z99VVJzh+HQEzmOEEyruUCWw+1vqOWEERqPho1x4o30cTuBFFDZEgfwJ
	l6ifqsHl4hWjRk9VANLQZAeX4YVqnRjkQ1mURUjq5aQOK0zk1G7kud1dZlODJT8teF9u596+n01
	FMNNkbDJQpayddcIj3HYU5b/Jdx4TshmD6FUYtY+wIeFNj5SWfb9Z2iE+jWLKCH3CXf5ZwWihU5
	psSnICBkfXdjnlS6gT5gyB293F1mkWvjEweomA==
X-Received: by 2002:a17:903:b0b:b0:2a7:6c4e:5914 with SMTP id
 d9443c01a7336-2b26b19268amr164775ad.6.1774992078005; Tue, 31 Mar 2026
 14:21:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP-5=fWVU3ktkGAnZQrjQJf+Z5AtQo73BVUhj-nr3H95GdcEJQ@mail.gmail.com>
 <20260305221927.3237145-1-irogers@google.com> <20260305221927.3237145-2-irogers@google.com>
 <acwxuPAo8g6C867R@x1>
In-Reply-To: <acwxuPAo8g6C867R@x1>
From: Ian Rogers <irogers@google.com>
Date: Tue, 31 Mar 2026 14:21:06 -0700
X-Gm-Features: AQROBzDbOw0ON8Mz97jk-SmsyhRJF1m_3_IhoXpTax6bYQx2IUJMMWJYWTEZhQA
Message-ID: <CAP-5=fXHfCqdgSWh4o8uqwwJ1BvKiDm5dY38cgu87G8AaDHudQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] perf unwind: Refactor get_entries to allow dynamic
 libdw/libunwind selection
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: 9erthalion6@gmail.com, adrian.hunter@intel.com, alex@ghiti.fr, 
	alexander.shishkin@linux.intel.com, andrew.jones@oss.qualcomm.com, 
	aou@eecs.berkeley.edu, atrajeev@linux.ibm.com, blakejones@google.com, 
	ctshao@google.com, dapeng1.mi@linux.intel.com, howardchu95@gmail.com, 
	james.clark@linaro.org, john.g.garry@oracle.com, jolsa@kernel.org, 
	leo.yan@linux.dev, libunwind-devel@nongnu.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org, 
	mingo@redhat.com, namhyung@kernel.org, palmer@dabbelt.com, 
	peterz@infradead.org, pjw@kernel.org, shimin.guo@skydio.com, 
	tglozar@redhat.com, tmricht@linux.ibm.com, will@kernel.org, yuzhuo@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 31, 2026 at 1:42=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Thu, Mar 05, 2026 at 02:19:20PM -0800, Ian Rogers wrote:
> > Currently, both libdw and libunwind define 'unwind__get_entries'. This
> > causes a duplicate symbol build failure when both are compiled into
> > perf.
> >
> > This commit refactors the DWARF unwind post-processing to be
> > configurable at runtime via the .perfconfig file option
> > 'unwind.style', or using the argument '--unwind-style' in the commands
> > 'perf report', 'perf script' and 'perf inject', in a similar manner to
> > the addr2line or the disassembler style.
> >
> > The file 'tools/perf/util/unwind.c' adds the top-level dispatch
> > function 'unwind__get_entries'. The backend implementations are
> > renamed to 'libdw__get_entries' and 'libunwind__get_entries'. Both are
> > attempted as fallbacks if not configured, or if the primary backend
> > fails.
> >
> > Fixes: 2e9191573a69 ("perf build: Remove NO_LIBDW_DWARF_UNWIND option")
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/builtin-inject.c        |   4 ++
> >  tools/perf/builtin-report.c        |   4 ++
> >  tools/perf/builtin-script.c        |   4 ++
> >  tools/perf/util/Build              |   1 +
> >  tools/perf/util/symbol_conf.h      |  15 +++++
> >  tools/perf/util/unwind-libdw.c     |   2 +-
> >  tools/perf/util/unwind-libunwind.c |   2 +-
> >  tools/perf/util/unwind.c           | 102 +++++++++++++++++++++++++++++
> >  tools/perf/util/unwind.h           |  40 +++++------
> >  9 files changed, 149 insertions(+), 25 deletions(-)
> >  create mode 100644 tools/perf/util/unwind.c
> >
> > diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
> > index 5b29f4296861..9ad681b3c0dc 100644
> > --- a/tools/perf/builtin-inject.c
> > +++ b/tools/perf/builtin-inject.c
> > @@ -26,6 +26,7 @@
> >  #include "util/synthetic-events.h"
> >  #include "util/thread.h"
> >  #include "util/namespaces.h"
> > +#include "util/unwind.h"
> >  #include "util/util.h"
> >  #include "util/tsc.h"
> >
> > @@ -2539,6 +2540,9 @@ int cmd_inject(int argc, const char **argv)
> >               OPT_STRING(0, "guestmount", &symbol_conf.guestmount, "dir=
ectory",
> >                          "guest mount directory under which every guest=
 os"
> >                          " instance has a subdir"),
> > +             OPT_CALLBACK(0, "unwind-style", NULL, "unwind style",
> > +                          "unwind styles (libdw,libunwind)",
> > +                          unwind__option),
> >               OPT_BOOLEAN(0, "convert-callchain", &inject.convert_callc=
hain,
> >                           "Generate callchains using DWARF and drop reg=
ister/stack data"),
> >               OPT_END()
> > diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
> > index 3b81f4b3dc49..ae20c0679990 100644
> > --- a/tools/perf/builtin-report.c
> > +++ b/tools/perf/builtin-report.c
> > @@ -48,6 +48,7 @@
> >  #include "util/time-utils.h"
> >  #include "util/auxtrace.h"
> >  #include "util/units.h"
> > +#include "util/unwind.h"
> >  #include "util/util.h" // perf_tip()
> >  #include "ui/ui.h"
> >  #include "ui/progress.h"
> > @@ -1455,6 +1456,9 @@ int cmd_report(int argc, const char **argv)
> >       OPT_CALLBACK(0, "addr2line-style", NULL, "addr2line style",
> >                    "addr2line styles (libdw,llvm,libbfd,addr2line)",
> >                    report_parse_addr2line_config),
> > +     OPT_CALLBACK(0, "unwind-style", NULL, "unwind style",
> > +                  "unwind styles (libdw,libunwind)",
> > +                  unwind__option),
> >       OPT_BOOLEAN(0, "demangle", &symbol_conf.demangle,
> >                   "Symbol demangling. Enabled by default, use --no-dema=
ngle to disable."),
> >       OPT_BOOLEAN(0, "demangle-kernel", &symbol_conf.demangle_kernel,
> > diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> > index 9f8b0fd27a0a..b6c7c164d02d 100644
> > --- a/tools/perf/builtin-script.c
> > +++ b/tools/perf/builtin-script.c
> > @@ -63,6 +63,7 @@
> >  #include <linux/err.h>
> >  #include "util/dlfilter.h"
> >  #include "util/record.h"
> > +#include "util/unwind.h"
> >  #include "util/util.h"
> >  #include "util/cgroup.h"
> >  #include "util/annotate.h"
> > @@ -4164,6 +4165,9 @@ int cmd_script(int argc, const char **argv)
> >                       "Enable symbol demangling"),
> >       OPT_BOOLEAN(0, "demangle-kernel", &symbol_conf.demangle_kernel,
> >                       "Enable kernel symbol demangling"),
> > +     OPT_CALLBACK(0, "unwind-style", NULL, "unwind style",
> > +                  "unwind styles (libdw,libunwind)",
> > +                  unwind__option),
> >       OPT_STRING(0, "addr2line", &symbol_conf.addr2line_path, "path",
> >                       "addr2line binary to use for line numbers"),
> >       OPT_STRING(0, "time", &script.time_str, "str",
> > diff --git a/tools/perf/util/Build b/tools/perf/util/Build
> > index bcccad7487a9..6190a8f5b0fa 100644
> > --- a/tools/perf/util/Build
> > +++ b/tools/perf/util/Build
> > @@ -218,6 +218,7 @@ ifndef CONFIG_SETNS
> >  perf-util-y +=3D setns.o
> >  endif
> >
> > +perf-util-y +=3D unwind.o
> >  perf-util-$(CONFIG_LIBDW) +=3D probe-finder.o
> >  perf-util-$(CONFIG_LIBDW) +=3D dwarf-aux.o
> >  perf-util-$(CONFIG_LIBDW) +=3D dwarf-regs.o
> > diff --git a/tools/perf/util/symbol_conf.h b/tools/perf/util/symbol_con=
f.h
> > index 71bb17372a6c..25d92bbbfee7 100644
> > --- a/tools/perf/util/symbol_conf.h
> > +++ b/tools/perf/util/symbol_conf.h
> > @@ -9,6 +9,19 @@
> >  struct strlist;
> >  struct intlist;
> >
> > +enum unwind_style {
> > +
> > +     UNWIND_STYLE_UNKNOWN =3D 0,
> > +
> > +     UNWIND_STYLE_LIBDW,
> > +
> > +     UNWIND_STYLE_LIBUNWIND,
> > +
> > +};

I'll remove the blank lines in the next version.

> > +
> > +#define MAX_UNWIND_STYLE (UNWIND_STYLE_LIBUNWIND + 1)
> > +
> > +
> >  enum a2l_style {
> >       A2L_STYLE_UNKNOWN =3D 0,
> >       A2L_STYLE_LIBDW,
> > @@ -80,6 +93,7 @@ struct symbol_conf {
> >                       *bt_stop_list_str;
> >       const char              *addr2line_path;
> >       enum a2l_style  addr2line_style[MAX_A2L_STYLE];
> > +     enum unwind_style unwind_style[MAX_UNWIND_STYLE];
> >       unsigned long   time_quantum;
> >         struct strlist        *dso_list,
> >                       *comm_list,
> > @@ -103,3 +117,4 @@ struct symbol_conf {
> >  extern struct symbol_conf symbol_conf;
> >
> >  #endif // __PERF_SYMBOL_CONF
> > +
> > diff --git a/tools/perf/util/unwind-libdw.c b/tools/perf/util/unwind-li=
bdw.c
> > index 05e8e68bd49c..d8a5b7d54192 100644
> > --- a/tools/perf/util/unwind-libdw.c
> > +++ b/tools/perf/util/unwind-libdw.c
> > @@ -339,7 +339,7 @@ frame_callback(Dwfl_Frame *state, void *arg)
> >              DWARF_CB_ABORT : DWARF_CB_OK;
> >  }
> >
> > -int unwind__get_entries(unwind_entry_cb_t cb, void *arg,
> > +int libdw__get_entries(unwind_entry_cb_t cb, void *arg,
> >                       struct thread *thread,
> >                       struct perf_sample *data,
> >                       int max_stack,
> > diff --git a/tools/perf/util/unwind-libunwind.c b/tools/perf/util/unwin=
d-libunwind.c
> > index cb8be6acfb6f..a0016b897dae 100644
> > --- a/tools/perf/util/unwind-libunwind.c
> > +++ b/tools/perf/util/unwind-libunwind.c
> > @@ -79,7 +79,7 @@ void unwind__finish_access(struct maps *maps)
> >               ops->finish_access(maps);
> >  }
> >
> > -int unwind__get_entries(unwind_entry_cb_t cb, void *arg,
> > +int libunwind__get_entries(unwind_entry_cb_t cb, void *arg,
> >                        struct thread *thread,
> >                        struct perf_sample *data, int max_stack,
> >                        bool best_effort)
> > diff --git a/tools/perf/util/unwind.c b/tools/perf/util/unwind.c
> > new file mode 100644
> > index 000000000000..9ae7d5ad246d
> > --- /dev/null
> > +++ b/tools/perf/util/unwind.c
> > @@ -0,0 +1,102 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +#include "debug.h"
> > +#include "symbol_conf.h"
> > +#include "unwind.h"
> > +#include <linux/string.h>
> > +#include <string.h>
> > +#include <stdlib.h>
> > +
> > +int unwind__get_entries(unwind_entry_cb_t cb __maybe_unused, void *arg=
 __maybe_unused,
> > +                     struct thread *thread __maybe_unused,
> > +                     struct perf_sample *data __maybe_unused,
> > +                     int max_stack __maybe_unused,
> > +                     bool best_effort __maybe_unused)
> > +{
> > +     int ret =3D 0;
> > +
> > +#if defined(HAVE_LIBDW_SUPPORT) || defined(HAVE_LIBUNWIND_SUPPORT)
> > +     if (symbol_conf.unwind_style[0] =3D=3D UNWIND_STYLE_UNKNOWN) {
> > +             int i =3D 0;
> > +#ifdef HAVE_LIBDW_SUPPORT
> > +             symbol_conf.unwind_style[i++] =3D UNWIND_STYLE_LIBDW;
> > +#endif
> > +#ifdef HAVE_LIBUNWIND_SUPPORT
> > +             symbol_conf.unwind_style[i++] =3D UNWIND_STYLE_LIBUNWIND;
> > +#endif
> > +     }
> > +#endif //defined(HAVE_LIBDW_SUPPORT) || defined(HAVE_LIBUNWIND_SUPPORT=
)
> > +
> > +     for (size_t i =3D 0; i < ARRAY_SIZE(symbol_conf.unwind_style); i+=
+) {
> > +             switch (symbol_conf.unwind_style[i]) {
> > +             case UNWIND_STYLE_LIBDW:
> > +#ifdef HAVE_LIBDW_SUPPORT
> > +                     ret =3D libdw__get_entries(cb, arg, thread, data,=
 max_stack, best_effort);
> > +#endif
> > +                     break;
> > +             case UNWIND_STYLE_LIBUNWIND:
> > +#ifdef HAVE_LIBUNWIND_SUPPORT
> > +                     ret =3D libunwind__get_entries(cb, arg, thread, d=
ata, max_stack, best_effort);
> > +#endif
> > +                     break;
>
>
> What if the user asks for one of the unwinders, symbol_conf.unwind_style
> will be populated with the user's choices, but then here in
> unwind__get_entries() we end up returning 0 because the user choice is
> not built-in?
>
> Also no warning will be emitted that what was asked for is not
> available?
>
> Maybe remove the ifdefs here and have a dummy libdw__get_entries() when
> HAVE_LIBDW_SUPPORT ins't defined that emits the warning and returns -1?
> Ditto for UNWIND_STYLE_LIBUNWIND?

Makes sense, I'll add it to the next version. Since the later patches
are larger I'll wait to address review feedback there before sending
out the next version - this will avoid unnecessary mailing list churn.

Thanks,
Ian

> - Arnaldo
>
> > +             case UNWIND_STYLE_UNKNOWN:
> > +             default:
> > +#if !defined(HAVE_LIBDW_SUPPORT) && !defined(HAVE_LIBUNWIND_SUPPORT)
> > +                     pr_warning_once(
> > +                             "Error: dwarf unwinding not supported, bu=
ild perf with libdw or libunwind.\n");
> > +#endif
> > +                     ret =3D -1;
> > +                     break;
> > +             }
> > +             if (ret =3D=3D 0)
> > +                     break;
> > +     }
> > +     return ret;
> > +}
> > +
> > +int unwind__configure(const char *var, const char *value, void *cb __m=
aybe_unused)
> > +{
> > +     static const char * const unwind_style_names[] =3D {
> > +             [UNWIND_STYLE_LIBDW] =3D "libdw",
> > +             [UNWIND_STYLE_LIBUNWIND] =3D "libunwind",
> > +             NULL
> > +     };
> > +     char *s, *p, *saveptr;
> > +     size_t i =3D 0;
> > +
> > +     if (strcmp(var, "unwind.style"))
> > +             return 0;
> > +
> > +     if (!value)
> > +             return -1;
> > +
> > +     s =3D strdup(value);
> > +     if (!s)
> > +             return -1;
> > +
> > +     p =3D strtok_r(s, ",", &saveptr);
> > +     while (p && i < ARRAY_SIZE(symbol_conf.unwind_style)) {
> > +             bool found =3D false;
> > +             char *q =3D strim(p);
> > +
> > +             for (size_t j =3D UNWIND_STYLE_LIBDW; j < MAX_UNWIND_STYL=
E; j++) {
> > +                     if (!strcasecmp(q, unwind_style_names[j])) {
> > +                             symbol_conf.unwind_style[i++] =3D j;
> > +                             found =3D true;
> > +                             break;
> > +                     }
> > +             }
> > +             if (!found)
> > +                     pr_warning("Unknown unwind style: %s\n", q);
> > +             p =3D strtok_r(NULL, ",", &saveptr);
> > +     }
> > +
> > +     free(s);
> > +     return 0;
> > +}
> > +
> > +int unwind__option(const struct option *opt __maybe_unused,
> > +                const char *arg,
> > +                int unset __maybe_unused)
> > +{
> > +     return unwind__configure("unwind.style", arg, NULL);
> > +}
> > diff --git a/tools/perf/util/unwind.h b/tools/perf/util/unwind.h
> > index 9f7164c6d9aa..581d042e170a 100644
> > --- a/tools/perf/util/unwind.h
> > +++ b/tools/perf/util/unwind.h
> > @@ -7,6 +7,7 @@
> >  #include "util/map_symbol.h"
> >
> >  struct maps;
> > +struct option;
> >  struct perf_sample;
> >  struct thread;
> >
> > @@ -26,7 +27,9 @@ struct unwind_libunwind_ops {
> >                          struct perf_sample *data, int max_stack, bool =
best_effort);
> >  };
> >
> > -#ifdef HAVE_DWARF_UNWIND_SUPPORT
> > +int unwind__configure(const char *var, const char *value, void *cb);
> > +int unwind__option(const struct option *opt, const char *arg, int unse=
t);
> > +
> >  /*
> >   * When best_effort is set, don't report errors and fail silently. Thi=
s could
> >   * be expanded in the future to be more permissive about things other =
than
> > @@ -36,8 +39,20 @@ int unwind__get_entries(unwind_entry_cb_t cb, void *=
arg,
> >                       struct thread *thread,
> >                       struct perf_sample *data, int max_stack,
> >                       bool best_effort);
> > -/* libunwind specific */
> > +
> > +#ifdef HAVE_LIBDW_SUPPORT
> > +int libdw__get_entries(unwind_entry_cb_t cb, void *arg,
> > +                    struct thread *thread,
> > +                    struct perf_sample *data, int max_stack,
> > +                    bool best_effort);
> > +#endif
> > +
> >  #ifdef HAVE_LIBUNWIND_SUPPORT
> > +/* libunwind specific */
> > +int libunwind__get_entries(unwind_entry_cb_t cb, void *arg,
> > +                        struct thread *thread,
> > +                        struct perf_sample *data, int max_stack,
> > +                        bool best_effort);
> >  #ifndef LIBUNWIND__ARCH_REG_ID
> >  #define LIBUNWIND__ARCH_REG_ID(regnum) libunwind__arch_reg_id(regnum)
> >  #endif
> > @@ -57,26 +72,5 @@ static inline int unwind__prepare_access(struct maps=
 *maps __maybe_unused,
> >  static inline void unwind__flush_access(struct maps *maps __maybe_unus=
ed) {}
> >  static inline void unwind__finish_access(struct maps *maps __maybe_unu=
sed) {}
> >  #endif
> > -#else
> > -static inline int
> > -unwind__get_entries(unwind_entry_cb_t cb __maybe_unused,
> > -                 void *arg __maybe_unused,
> > -                 struct thread *thread __maybe_unused,
> > -                 struct perf_sample *data __maybe_unused,
> > -                 int max_stack __maybe_unused,
> > -                 bool best_effort __maybe_unused)
> > -{
> > -     return 0;
> > -}
> > -
> > -static inline int unwind__prepare_access(struct maps *maps __maybe_unu=
sed,
> > -                                      struct map *map __maybe_unused,
> > -                                      bool *initialized __maybe_unused=
)
> > -{
> > -     return 0;
> > -}
> >
> > -static inline void unwind__flush_access(struct maps *maps __maybe_unus=
ed) {}
> > -static inline void unwind__finish_access(struct maps *maps __maybe_unu=
sed) {}
> > -#endif /* HAVE_DWARF_UNWIND_SUPPORT */
> >  #endif /* __UNWIND_H */
> > --
> > 2.53.0.473.g4a7958ca14-goog
