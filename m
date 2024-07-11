Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52EA2F46;
	Thu, 11 Jul 2024 15:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720710981; cv=none; b=WK2hB/h9oIOl+qjT+F9mQCaEUsNbAe8wPeAV5eiL4xUXujzYow0l5cxLxiC6iTwTsNFv49xIIbOl0oAuDj1mz6akEZLp8VVtfNzhafFIqG9VzRKjZZ3TogAW0b5tiF+Kvm5498l9jZWUoZVOEKlZ+cGmsOo+49tEXHt9n3mZOqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720710981; c=relaxed/simple;
	bh=ajNUAW5IuXe8j7RKzXo/N0pVMqNKE0IWeHhYD+OZ7No=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=obakNNcoK01nJAcRc7WficeJ+ifeaR/XrczfpeLF0Dk/IOqgnLeL/8R8/OLLLNpVQ4NqutavyDFzyYQF88RXHIXIFkJ2VlqdnMYSrQE9GgA9xQUt9C+UvPBN4QB5F5543v023B2rjQn3Dki225txxydS54oEO9+e5UdMj/tgB7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nOhPOgqB; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nOhPOgqB"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-65bceed88a2so9396367b3.1;
        Thu, 11 Jul 2024 08:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720710979; x=1721315779; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y7CxIT6M4EfCBkZHjNqvPWCpkdh2pL2ZDlFfoHjTUOs=;
        b=nOhPOgqBL0BjAwas8v7Jldl7YdqIf1w1b7ar4qAriM7PHqtSSxV+PCeevdXOrkSMze
         2NM30aXB6B6706xENIPYMbW2wbbNnaTJHPbfVLcfp67A7ggLzPbJ1NLFPhFwsEEpIfhs
         6vgoFsNuIXfbkz6nt/hO3WijKy66TAFqVokQvKa9xa1mb3qUX8N/qN1oW/5SSKl9f5Qp
         o9RGb1T2rLIEXiIt21pvqFUmAptd634cIGkhEwo/gK3d6jAD65TiumQ8rdEZKj9Emlf/
         hFWCcljQ+4DU9oPr4TAPyME2H/sR1nPDV9Vyj7jUNQqsnOFkczzBvfInhbzaYZLxqFHS
         aVjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720710979; x=1721315779;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y7CxIT6M4EfCBkZHjNqvPWCpkdh2pL2ZDlFfoHjTUOs=;
        b=t0rNdyxcGfwJrKP84Q3Gbvd+86WLpQLZLwC9EYjhyNr2UalW/Y59OSnD8O7FxmBuUi
         RYBkF974+62HOgrQs6iJOffGk0zI8O7qraDjwiO5Azfn34a+IVGcgUlsVuP35LNKtiJI
         qxLf2UOrvKPVXJptve/OwOwHasG9e3zo5BoEgZ7NpsIRf/7bgitanOZy65u2wwts8m6d
         TRX5d7v7xLS9BacZxahJYqLg3TjJeaZU3du5I4Zfmo+D6sSbAIiAjU0DxpN5FQrfXjQb
         L7CaXrxufWrDWqAgXXMW8NcdHaDDy8ygsvEjX3YluUX8VwvlM80LDOSz3Z8zaYGIT7jg
         WZ9w==
X-Forwarded-Encrypted: i=1; AJvYcCXwkv7r+ZbQD4qKVZUvbZDZb5XO8L6uIlZa5MuwVPWUa/DN4jDcJiKfhMRSrHC6V+26SXcv9rNetu2acmA2LC+DDsloCrkody7GtKRHPKicAlM9n231cCmczacAfzmVSiIhdlpVjN7ZrUBosMadeg==
X-Gm-Message-State: AOJu0YzaKVpdyVDqoBPQAMrrk8KfgMcyiAz9M3fk//JW0v1XnrbNn5fP
	HgUjpNNHgL6Ial6AexffPpWVlNjQgdSiwiWxmo3uZSxyj3AdoIWlqolOr9DwXPbavlcKN4i3eI9
	9ch8rrEjoxh22cncHdpIGqvfkWPT8McEj
X-Google-Smtp-Source: AGHT+IGTcwd0rebk4TsDDaZwXl52ozA5oJkqx6LAURv4hIEJz8GxAOYsrhakpWbqR64J05ggPCZgri/rFnLYslLdDLo=
X-Received: by 2002:a05:690c:6c88:b0:645:2b26:5f64 with SMTP id
 00721157ae682-658ebcacfe1mr106431267b3.0.1720710978532; Thu, 11 Jul 2024
 08:16:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240705094300.585156-1-howardchu95@gmail.com>
 <20240705094300.585156-3-howardchu95@gmail.com> <CAP-5=fXyoLBmtftkYheLQTQeceK7ZBB8NLv4bFEdYOBUTO9yGw@mail.gmail.com>
In-Reply-To: <CAP-5=fXyoLBmtftkYheLQTQeceK7ZBB8NLv4bFEdYOBUTO9yGw@mail.gmail.com>
From: Howard Chu <howardchu95@gmail.com>
Date: Thu, 11 Jul 2024 23:16:09 +0800
Message-ID: <CAH0uvohFMtQ+Cg_2PFnW=-pHkSsp-ciqFO6YO-nYJ91Dd1Aa8Q@mail.gmail.com>
Subject: Re: [PATCH v5 2/8] perf trace: BTF-based enum pretty printing for
 syscall args
To: Ian Rogers <irogers@google.com>
Cc: acme@kernel.org, adrian.hunter@intel.com, jolsa@kernel.org, 
	kan.liang@linux.intel.com, namhyung@kernel.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Arnaldo Carvalho de Melo <acme@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

Thank you for the advice! Although I am not the person who wrote this
comment, I think it's good to change it to /* */ instead.

Thanks,
Howard

On Thu, Jul 11, 2024 at 1:54=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
te:
>
> On Fri, Jul 5, 2024 at 2:43=E2=80=AFAM Howard Chu <howardchu95@gmail.com>=
 wrote:
> >
> > In this patch, BTF is used to turn enum value to the corresponding
> > name. There is only one system call that uses enum value as its
> > argument, that is `landlock_add_rule()`.
> >
> > The vmlinux btf is loaded lazily, when user decided to trace the
> > `landlock_add_rule` syscall. But if one decide to run `perf trace`
> > without any arguments, the behaviour is to trace `landlock_add_rule`,
> > so vmlinux btf will be loaded by default.
> >
> > The laziest behaviour is to load vmlinux btf when a
> > `landlock_add_rule` syscall hits. But I think you could lose some
> > samples when loading vmlinux btf at run time, for it can delay the
> > handling of other samples. I might need your precious opinions on
> > this...
> >
> > before:
> >
> > ```
> > perf $ ./perf trace -e landlock_add_rule
> >      0.000 ( 0.008 ms): ldlck-test/438194 landlock_add_rule(rule_type: =
2) =3D -1 EBADFD (File descriptor in bad state)
> >      0.010 ( 0.001 ms): ldlck-test/438194 landlock_add_rule(rule_type: =
1) =3D -1 EBADFD (File descriptor in bad state)
> > ```
> >
> > after:
> >
> > ```
> > perf $ ./perf trace -e landlock_add_rule
> >      0.000 ( 0.029 ms): ldlck-test/438194 landlock_add_rule(rule_type: =
LANDLOCK_RULE_NET_PORT)     =3D -1 EBADFD (File descriptor in bad state)
> >      0.036 ( 0.004 ms): ldlck-test/438194 landlock_add_rule(rule_type: =
LANDLOCK_RULE_PATH_BENEATH) =3D -1 EBADFD (File descriptor in bad state)
> > ```
> >
> > Committer notes:
> >
> > Made it build with NO_LIBBPF=3D1, simplified btf_enum_fprintf(), see [1=
]
> > for the discussion.
> >
> > Signed-off-by: Howard Chu <howardchu95@gmail.com>
> > Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > Cc: Adrian Hunter <adrian.hunter@intel.com>
> > Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> > Cc: G=C3=BCnther Noack <gnoack@google.com>
> > Cc: Ian Rogers <irogers@google.com>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Jiri Olsa <jolsa@kernel.org>
> > Cc: Kan Liang <kan.liang@linux.intel.com>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Link: https://lore.kernel.org/lkml/20240613022757.3589783-1-howardchu95=
@gmail.com
> > Link: https://lore.kernel.org/lkml/ZnXAhFflUl_LV1QY@x1 # [1]
> > Link: https://lore.kernel.org/r/20240624181345.124764-3-howardchu95@gma=
il.com
> > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > ---
> >  tools/perf/builtin-trace.c | 110 +++++++++++++++++++++++++++++++++++--
> >  1 file changed, 106 insertions(+), 4 deletions(-)
> >
> > diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> > index 8449f2beb54d..1391564911d9 100644
> > --- a/tools/perf/builtin-trace.c
> > +++ b/tools/perf/builtin-trace.c
> > @@ -19,6 +19,7 @@
> >  #ifdef HAVE_LIBBPF_SUPPORT
> >  #include <bpf/bpf.h>
> >  #include <bpf/libbpf.h>
> > +#include <bpf/btf.h>
> >  #ifdef HAVE_BPF_SKEL
> >  #include "bpf_skel/augmented_raw_syscalls.skel.h"
> >  #endif
> > @@ -110,6 +111,10 @@ struct syscall_arg_fmt {
> >         const char *name;
> >         u16        nr_entries; // for arrays
> >         bool       show_zero;
> > +       bool       is_enum;
> > +#ifdef HAVE_LIBBPF_SUPPORT
> > +       const struct btf_type *type;
> > +#endif
> >  };
> >
> >  struct syscall_fmt {
> > @@ -139,6 +144,9 @@ struct trace {
> >         } syscalls;
> >  #ifdef HAVE_BPF_SKEL
> >         struct augmented_raw_syscalls_bpf *skel;
> > +#endif
> > +#ifdef HAVE_LIBBPF_SUPPORT
> > +       struct btf              *btf;
> >  #endif
> >         struct record_opts      opts;
> >         struct evlist   *evlist;
> > @@ -204,6 +212,20 @@ struct trace {
> >         } oe;
> >  };
> >
> > +static void trace__load_vmlinux_btf(struct trace *trace __maybe_unused=
)
> > +{
> > +#ifdef HAVE_LIBBPF_SUPPORT
> > +       if (trace->btf !=3D NULL)
> > +               return;
> > +
> > +       trace->btf =3D btf__load_vmlinux_btf();
> > +       if (verbose > 0) {
> > +               fprintf(trace->output, trace->btf ? "vmlinux BTF loaded=
\n" :
> > +                                                   "Failed to load vml=
inux BTF\n");
> > +       }
> > +#endif
> > +}
> > +
> >  struct tp_field {
> >         int offset;
> >         union {
> > @@ -887,6 +909,64 @@ static size_t syscall_arg__scnprintf_getrandom_fla=
gs(char *bf, size_t size,
> >
> >  #define SCA_GETRANDOM_FLAGS syscall_arg__scnprintf_getrandom_flags
> >
> > +#ifdef HAVE_LIBBPF_SUPPORT
> > +static int syscall_arg_fmt__cache_btf_enum(struct syscall_arg_fmt *arg=
_fmt, struct btf *btf, char *type)
> > +{
> > +       int id;
> > +
> > +       // Already cached?
>
> Hi Howard,
>
> I'm on nit patrol again, just to note that most comments are /* */
> style although we do have // comments - the ratio of /* */ to // is
> about 10:1. The kernel is similar in this regard. There's no clear
> guidance so we could ignore this, but fwiw I generally try to stick
> with /* */ for consistency with the rest of the surrounding code.
>
> Thanks,
> Ian
> > +       if (arg_fmt->type !=3D NULL)
> > +               return 0;
> > +
> > +       type =3D strstr(type, "enum ");
> > +       if (type =3D=3D NULL)
> > +               return -1;
> > +
> > +       type +=3D 5; // skip "enum " to get the enumeration name
> > +
> > +       id =3D btf__find_by_name(btf, type);
> > +       if (id < 0)
> > +               return -1;
> > +
> > +       arg_fmt->type =3D btf__type_by_id(btf, id);
> > +       return arg_fmt->type =3D=3D NULL ? -1 : 0;
> > +}
> > +
> > +static size_t btf_enum_scnprintf(const struct btf_type *type, struct b=
tf *btf, char *bf, size_t size, int val)
> > +{
> > +       struct btf_enum *be =3D btf_enum(type);
> > +       const int nr_entries =3D btf_vlen(type);
> > +
> > +       for (int i =3D 0; i < nr_entries; ++i, ++be) {
> > +               if (be->val =3D=3D val) {
> > +                       return scnprintf(bf, size, "%s",
> > +                                        btf__name_by_offset(btf, be->n=
ame_off));
> > +               }
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +static size_t trace__btf_enum_scnprintf(struct trace *trace, struct sy=
scall_arg_fmt *arg_fmt, char *bf,
> > +                                       size_t size, int val, char *typ=
e)
> > +{
> > +       if (trace->btf =3D=3D NULL)
> > +               return 0;
> > +
> > +       if (syscall_arg_fmt__cache_btf_enum(arg_fmt, trace->btf, type) =
< 0)
> > +               return 0;
> > +
> > +       return btf_enum_scnprintf(arg_fmt->type, trace->btf, bf, size, =
val);
> > +}
> > +#else // HAVE_LIBBPF_SUPPORT
> > +static size_t trace__btf_enum_scnprintf(struct trace *trace __maybe_un=
used, struct syscall_arg_fmt *arg_fmt __maybe_unused,
> > +                                       char *bf __maybe_unused, size_t=
 size __maybe_unused, int val __maybe_unused,
> > +                                       char *type __maybe_unused)
> > +{
> > +       return 0;
> > +}
> > +#endif // HAVE_LIBBPF_SUPPORT
> > +
> >  #define STRARRAY(name, array) \
> >           { .scnprintf  =3D SCA_STRARRAY, \
> >             .strtoul    =3D STUL_STRARRAY, \
> > @@ -1238,6 +1318,7 @@ struct syscall {
> >         bool                is_exit;
> >         bool                is_open;
> >         bool                nonexistent;
> > +       bool                use_btf;
> >         struct tep_format_field *args;
> >         const char          *name;
> >         const struct syscall_fmt  *fmt;
> > @@ -1744,7 +1825,8 @@ static const struct syscall_arg_fmt *syscall_arg_=
fmt__find_by_name(const char *n
> >  }
> >
> >  static struct tep_format_field *
> > -syscall_arg_fmt__init_array(struct syscall_arg_fmt *arg, struct tep_fo=
rmat_field *field)
> > +syscall_arg_fmt__init_array(struct syscall_arg_fmt *arg, struct tep_fo=
rmat_field *field,
> > +                           bool *use_btf)
> >  {
> >         struct tep_format_field *last_field =3D NULL;
> >         int len;
> > @@ -1756,6 +1838,7 @@ syscall_arg_fmt__init_array(struct syscall_arg_fm=
t *arg, struct tep_format_field
> >                         continue;
> >
> >                 len =3D strlen(field->name);
> > +               arg->is_enum =3D false;
> >
> >                 if (strcmp(field->type, "const char *") =3D=3D 0 &&
> >                     ((len >=3D 4 && strcmp(field->name + len - 4, "name=
") =3D=3D 0) ||
> > @@ -1782,6 +1865,8 @@ syscall_arg_fmt__init_array(struct syscall_arg_fm=
t *arg, struct tep_format_field
> >                          * 7 unsigned long
> >                          */
> >                         arg->scnprintf =3D SCA_FD;
> > +               } else if (strstr(field->type, "enum") && use_btf !=3D =
NULL) {
> > +                       *use_btf =3D arg->is_enum =3D true;
> >                 } else {
> >                         const struct syscall_arg_fmt *fmt =3D
> >                                 syscall_arg_fmt__find_by_name(field->na=
me);
> > @@ -1798,7 +1883,8 @@ syscall_arg_fmt__init_array(struct syscall_arg_fm=
t *arg, struct tep_format_field
> >
> >  static int syscall__set_arg_fmts(struct syscall *sc)
> >  {
> > -       struct tep_format_field *last_field =3D syscall_arg_fmt__init_a=
rray(sc->arg_fmt, sc->args);
> > +       struct tep_format_field *last_field =3D syscall_arg_fmt__init_a=
rray(sc->arg_fmt, sc->args,
> > +                                                                      =
   &sc->use_btf);
> >
> >         if (last_field)
> >                 sc->args_size =3D last_field->offset + last_field->size=
;
> > @@ -1811,6 +1897,7 @@ static int trace__read_syscall_info(struct trace =
*trace, int id)
> >         char tp_name[128];
> >         struct syscall *sc;
> >         const char *name =3D syscalltbl__name(trace->sctbl, id);
> > +       int err;
> >
> >  #ifdef HAVE_SYSCALL_TABLE_SUPPORT
> >         if (trace->syscalls.table =3D=3D NULL) {
> > @@ -1883,7 +1970,13 @@ static int trace__read_syscall_info(struct trace=
 *trace, int id)
> >         sc->is_exit =3D !strcmp(name, "exit_group") || !strcmp(name, "e=
xit");
> >         sc->is_open =3D !strcmp(name, "open") || !strcmp(name, "openat"=
);
> >
> > -       return syscall__set_arg_fmts(sc);
> > +       err =3D syscall__set_arg_fmts(sc);
> > +
> > +       /* after calling syscall__set_arg_fmts() we'll know whether use=
_btf is true */
> > +       if (sc->use_btf)
> > +               trace__load_vmlinux_btf(trace);
> > +
> > +       return err;
> >  }
> >
> >  static int evsel__init_tp_arg_scnprintf(struct evsel *evsel)
> > @@ -1891,7 +1984,7 @@ static int evsel__init_tp_arg_scnprintf(struct ev=
sel *evsel)
> >         struct syscall_arg_fmt *fmt =3D evsel__syscall_arg_fmt(evsel);
> >
> >         if (fmt !=3D NULL) {
> > -               syscall_arg_fmt__init_array(fmt, evsel->tp_format->form=
at.fields);
> > +               syscall_arg_fmt__init_array(fmt, evsel->tp_format->form=
at.fields, NULL);
> >                 return 0;
> >         }
> >
> > @@ -2103,6 +2196,15 @@ static size_t syscall__scnprintf_args(struct sys=
call *sc, char *bf, size_t size,
> >                         if (trace->show_arg_names)
> >                                 printed +=3D scnprintf(bf + printed, si=
ze - printed, "%s: ", field->name);
> >
> > +                       if (sc->arg_fmt[arg.idx].is_enum) {
> > +                               size_t p =3D trace__btf_enum_scnprintf(=
trace, &sc->arg_fmt[arg.idx], bf + printed,
> > +                                                                    si=
ze - printed, val, field->type);
> > +                               if (p) {
> > +                                       printed +=3D p;
> > +                                       continue;
> > +                               }
> > +                       }
> > +
> >                         printed +=3D syscall_arg_fmt__scnprintf_val(&sc=
->arg_fmt[arg.idx],
> >                                                                   bf + =
printed, size - printed, &arg, val);
> >                 }
> > --
> > 2.45.2
> >
