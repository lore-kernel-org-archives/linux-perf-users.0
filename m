Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029B722EED;
	Thu, 20 Jun 2024 19:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718910996; cv=none; b=TPdl11KllJniHS5XALGfLE59Sd5ndB3bqYh8pSfuMNI65BrxpSYAdKacrQb5BiBA8HHdYeibQGknQJiQrIzttbG+47HOhHuT2LEyDOHJ+0AsWm86KJ9ecMHhP+sAQWs5K+K40BYxcP9sE66D7fWDm4DaqXCvRwoRCzieCCNXRMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718910996; c=relaxed/simple;
	bh=Ee9sO8Ts4aPgQELZnqYbm9bnz15/vNvFT5AQVPaxUL8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZnuXY/UKf0UQ65+SeJ+O1HgKs2k2nykSYHb8NMielWmt3Y2ZpyWN6lSqtr2EOrQQros6d9oYeSYR/EsS37iowZOL8ybnxwsyelD2FMS0wEQLsBOD1EYdAGVQh80MBth0NkygzEA4xy8XYyqrekZcRhLfzy2xmnWB0VIIWiTvv+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FmPJ/H0y; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FmPJ/H0y"
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e02bda4aba3so1305096276.3;
        Thu, 20 Jun 2024 12:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718910994; x=1719515794; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hef9HMsJiF2nFnsQV69+m/7DUDlVbouH7UuFqkzKHiI=;
        b=FmPJ/H0ylOsKxA08y0776EKS8sfh+2hJzwMjN9Szmo254a3jqu9jrSYynxJ8wYzzRN
         7pzMix+oAEun83xXZGySlwADeKJcFPTT9UCAHpnxbqo4l05Pa9aRRs618utnkv8zETl1
         TcGoLHwmyoQo7qw7ZyVgULQsotlOZcdp+hdZ2xbWnlOIC930obp62GTX1CF6PqD3zrrF
         +eZ/4TS8rZLXi+Ja8VjRrnlVBt6unqhZmWmCCYhTcSFczQhiLU/fgfLRxGFF0IAMl4Me
         xepHaKdl7OqUmGbaZOi1qRFa1/WRAZK9cNGzUYceNOgHfjwQC+tqUt/wcf//ZhrLauGk
         LMeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718910994; x=1719515794;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hef9HMsJiF2nFnsQV69+m/7DUDlVbouH7UuFqkzKHiI=;
        b=wQEJjB26rOIhog44K8TgtkJaFrFHn6I3zTXOYmRX//YiavrPCaDadStdqqJne8y7cV
         loiog2oO4rjNfqmaW5X4Ybhs5Be4OOybyDlfka0xgn7AxUKuhaCKytHeU96dfq2vIPhw
         X4xTizUC19VpIhNvcpetUzlTIhC70f20heUWt1+HUAKoQ3vg+NNI1V+owoAv/3NN4tCL
         /h2KqSVhkhM2IH06Zjbaz8FnFh0OQEn/oBJGVKrib3IFA8ZRlIYKLr8Odl5Hngicvftk
         wRZLongju0RBWliRH1f/+jxX0SXo1vcid4MCcJndVZ98URitoMm/q6Sz8DGrPHmUQytR
         aY9w==
X-Forwarded-Encrypted: i=1; AJvYcCVrUwpe4OGLlpeQqMEZt6VzG4ZF6ljhHmMkeIIn4aWKmhjYjTo30GQYq7huEDLJcKj2Ef+LUW3lgr6+NBf90GnjRiimYEXMO8EVKmxdil0YUQNU2wEjC0uqYRNNK/HX4eENN5ctr2ZY+5DSREGf+w==
X-Gm-Message-State: AOJu0YyZhRys4rb7H8ExgPlAWZbg/V3BsoOyhdTc3Y1LrwOCtj+qW2XR
	dFZBUJ1VOceSf6IENrtI6oWm7hIYz4mZS/miujQ/W2NwsDCrtai3N6vVgDTDvM25lhq4iOSrXwG
	I3MfvhqzcwnPfn5ntSl4Q6k5Y0Ww=
X-Google-Smtp-Source: AGHT+IFyUuHO4ADzgPj7Mkl8wqCmPgJx2jmoOCcoAjrN8FV04QBviOUGxIDgkfJauRy1EB7tG/ZfnI52/JKO8wdRBak=
X-Received: by 2002:a25:ce84:0:b0:dfb:c16:9e95 with SMTP id
 3f1490d57ef6-e02be10beeamr6999825276.7.1718910993667; Thu, 20 Jun 2024
 12:16:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240619082042.4173621-1-howardchu95@gmail.com>
 <20240619082042.4173621-3-howardchu95@gmail.com> <ZnLgstTgrFRYu0aD@x1>
 <CAH0uvohKGrfwApZXfJZaWx4LQgPXct+uQ_N7snmqSo4VeCxVUA@mail.gmail.com> <CAH0uvohxZ16MFCG2g3my48yUtp9AHAiAZCPAmkT5bDtNM6sGhg@mail.gmail.com>
In-Reply-To: <CAH0uvohxZ16MFCG2g3my48yUtp9AHAiAZCPAmkT5bDtNM6sGhg@mail.gmail.com>
From: Howard Chu <howardchu95@gmail.com>
Date: Fri, 21 Jun 2024 03:16:26 +0800
Message-ID: <CAH0uvohe2WssHZGYNyMCq=xpasXOYxaznRsGPe49iYQBME8_QQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] perf trace: Augment enum syscall arguments with BTF
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

The fixes are on the perf-tools-next branch at:
https://github.com/Sberm/linux.git

please use
```
git pull https://github.com/Sberm/linux.git perf-tools-next
```

I'm no git expert so please tell me if something is wrong.

P.S. not my proudest patch, changed too many things, might be buggy.
If there're bugs please let me know.

On Fri, Jun 21, 2024 at 12:34=E2=80=AFAM Howard Chu <howardchu95@gmail.com>=
 wrote:
>
> Hello Arnaldo,
>
> Thanks for the review, the code is refined based on your comments.
> There is just a little thing:
>
> On Thu, Jun 20, 2024 at 1:59=E2=80=AFAM Howard Chu <howardchu95@gmail.com=
> wrote:
> >
> > Hello,
> >
> > Thanks for the in-depth review.
> >
> > On Wed, Jun 19, 2024 at 9:44=E2=80=AFPM Arnaldo Carvalho de Melo
> > <acme@kernel.org> wrote:
> > >
> > > On Wed, Jun 19, 2024 at 04:20:39PM +0800, Howard Chu wrote:
> > > > This is a feature implemented on the basis of the previous bug fix
> > > > https://lore.kernel.org/linux-perf-users/d18a9606-ac9f-4ca7-afaf-fc=
f4c951cb90@web.de/T/#t
> > > >
> > > > In this patch, BTF is used to turn enum value to the corresponding
> > > > enum variable name. There is only one system call that uses enum va=
lue
> > > > as its argument, that is `landlock_add_rule()`.
> > > >
> > > > The vmlinux btf is loaded lazily, when user decided to trace the
> > > > `landlock_add_rule` syscall. But if one decides to run `perf trace`
> > > > without any arguments, the behaviour is to trace `landlock_add_rule=
`,
> > > > so vmlinux btf will be loaded by default.
> > > >
> > > > before:
> > > >
> > > > ```
> > > > perf $ ./perf trace -e landlock_add_rule
> > > >      0.000 ( 0.008 ms): ldlck-test/438194 landlock_add_rule(rule_ty=
pe: 2)                                       =3D -1 EBADFD (File descriptor=
 in bad state)
> > > >      0.010 ( 0.001 ms): ldlck-test/438194 landlock_add_rule(rule_ty=
pe: 1)                                       =3D -1 EBADFD (File descriptor=
 in bad state)
> > > > ```
> > > >
> > > > after:
> > > >
> > > > ```
> > > > perf $ ./perf trace -e landlock_add_rule
> > > >      0.000 ( 0.029 ms): ldlck-test/438194 landlock_add_rule(rule_ty=
pe: LANDLOCK_RULE_NET_PORT)                  =3D -1 EBADFD (File descriptor=
 in bad state)
> > > >      0.036 ( 0.004 ms): ldlck-test/438194 landlock_add_rule(rule_ty=
pe: LANDLOCK_RULE_PATH_BENEATH)              =3D -1 EBADFD (File descriptor=
 in bad state)
> > > > ```
> > > > Tested-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> > > > Suggested-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> > > > Reviewed-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> > > > Signed-off-by: Howard Chu <howardchu95@gmail.com>
> > > > ---
> > > >  tools/perf/builtin-trace.c | 96 ++++++++++++++++++++++++++++++++++=
++--
> > > >  1 file changed, 91 insertions(+), 5 deletions(-)
> > > >
> > > > diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.=
c
> > > > index c4fa8191253d..d93f34e9af74 100644
> > > > --- a/tools/perf/builtin-trace.c
> > > > +++ b/tools/perf/builtin-trace.c
> > > > @@ -19,6 +19,7 @@
> > > >  #ifdef HAVE_LIBBPF_SUPPORT
> > > >  #include <bpf/bpf.h>
> > > >  #include <bpf/libbpf.h>
> > > > +#include <bpf/btf.h>
> > > >  #ifdef HAVE_BPF_SKEL
> > > >  #include "bpf_skel/augmented_raw_syscalls.skel.h"
> > > >  #endif
> > > > @@ -110,6 +111,11 @@ struct syscall_arg_fmt {
> > > >       const char *name;
> > > >       u16        nr_entries; // for arrays
> > > >       bool       show_zero;
> > > > +     bool       is_enum;
> > > > +     struct {
> > > > +             void    *entries;
> > > > +             u16     nr_entries;
> > > > +     }          btf_entry;
> > > >  };
> > > >
> > > >  struct syscall_fmt {
> > > > @@ -140,6 +146,7 @@ struct trace {
> > > >  #ifdef HAVE_BPF_SKEL
> > > >       struct augmented_raw_syscalls_bpf *skel;
> > > >  #endif
> > > > +     struct btf              *btf;
> > > >       struct record_opts      opts;
> > > >       struct evlist   *evlist;
> > > >       struct machine          *host;
> > > > @@ -897,6 +904,56 @@ static size_t syscall_arg__scnprintf_getrandom=
_flags(char *bf, size_t size,
> > > >           .strtoul    =3D STUL_STRARRAY_FLAGS, \
> > > >           .parm       =3D &strarray__##array, }
> > > >
> > > > +static int btf_enum_find_entry(struct btf *btf, char *type, struct=
 syscall_arg_fmt *arg_fmt)
> > > > +{
> > > > +     const struct btf_type *bt;
> > > > +     char enum_prefix[][16] =3D { "enum", "const enum" }, *ep;
> > > > +     int id;
> > > > +     size_t i;
> > > > +
> > > > +     for (i =3D 0; i < ARRAY_SIZE(enum_prefix); i++) {
> > > > +             ep =3D enum_prefix[i];
> > > > +             if (strlen(type) > strlen(ep) + 1 && strstarts(type, =
ep))
> > >
> > > No need for the strlen test? I.e. plain using strstarts() should be
> > > enough?
> >
> > Agree. Thanks for pointing that out. Although if string 'type' is
> > 'enum' and prefix is 'enum', strstarts() will be true, but to do 'type
> > +=3D strlen(ep) + 1', and then access 'type', might give us an
> > out-of-range access, but I don't think 'type' will ever be just 'enum'
> > or 'const enum', so I'll delete it then.
> >
> > >
> > > > +                     type +=3D strlen(ep) + 1;
> > > > +     }
> > > > +
> > > > +     id =3D btf__find_by_name(btf, type);
> > > > +     if (id < 0)
> > > > +             return -1;
> > > > +
> > > > +     bt =3D btf__type_by_id(btf, id);
> > > > +     if (bt =3D=3D NULL)
> > >
> > > a pr_debug() stating that something that tracefs says should be in BT=
F
> > > and isn't found there seems to be of value here.
> >
> > Sure.
> >
> > >
> > > > +             return -1;
> > > > +
> > > > +     arg_fmt->btf_entry.entries    =3D btf_enum(bt);
> > > > +     arg_fmt->btf_entry.nr_entries =3D btf_vlen(bt);
> > > > +
> > > > +     return 0;
> > > > +}
> > > > +
> > > > +static size_t btf_enum_scnprintf(char *bf, size_t size, int val, s=
truct btf *btf, char *type,
> > > > +                              struct syscall_arg_fmt *arg_fmt)
> > > > +{
> > > > +     struct btf_enum *be;
> > > > +     int i;
> > > > +
> > > > +     /* if btf_entry is NULL, find and save it to arg_fmt */
> > > > +     if (arg_fmt->btf_entry.entries =3D=3D NULL)
> > > > +             if (btf_enum_find_entry(btf, type, arg_fmt))
> > > > +                     return 0;
> > > > +
> > > > +     be =3D (struct btf_enum *)arg_fmt->btf_entry.entries;
> > >
> > >         struct btf_enum *be =3D (struct btf_enum *)arg_fmt->btf_entry=
.entries;
> > >
> > >  arg_fmt->btf_entry.entries is (void *), so we don't need the (struct
> > > btf_enum *) cast here, removing it makes the code more compact. And
> > > since we move the declaration to the same line, the info about its ty=
pe
> > > is there as well.
> >
> > Sure, thanks.
> >
> > >
> > > > +
> > > > +     for (i =3D 0; i < arg_fmt->btf_entry.nr_entries; ++i, ++be) {
> > >
> > >
> > >         for (int i =3D 0; i < arg_fmt->btf_entry.nr_entries; ++i, ++b=
e) {
>
> I did this, it's all good. But here:
>
> for (i =3D 0, be =3D arg_fmt->btf_entry.entries; i <
> arg_fmt->btf_entry.nr_entries; ++i, ++be) {
>
> I can't do
>
> for (int i =3D 0, struct btf_enum *be =3D arg_fmt->btf_entry.entries; i <
> arg_fmt->btf_entry.nr_entries; ++i, ++be) {
>
> The compiler will show errors:
>
> builtin-trace.c: In function =E2=80=98btf_enum_scnprintf=E2=80=99:
> builtin-trace.c:996:25: error: expected identifier or =E2=80=98(=E2=80=99=
 before =E2=80=98struct=E2=80=99
>   996 |         for (int i =3D 0, struct btf_enum *be =3D
> arg_fmt->btf_entry.entries; i < arg_fmt->btf_entry.nr_entries; ++i,
> ++be) {
>       |                         ^~~~~~
> builtin-trace.c:996:117: error: =E2=80=98be=E2=80=99 undeclared (first us=
e in this
> function); did you mean =E2=80=98bf=E2=80=99?
>   996 |         for (int i =3D 0, struct btf_enum *be =3D
> arg_fmt->btf_entry.entries; i < arg_fmt->btf_entry.nr_entries; ++i,
> ++be) {
>       |
>                                                      ^~
>       |
>                                                      bf
> builtin-trace.c:996:117: note: each undeclared identifier is reported
> only once for each function it appears in
>
> This is not good either:
>
> for (int i =3D 0, be =3D arg_fmt->btf_entry.entries; i <
> arg_fmt->btf_entry.nr_entries; ++i, ++be) {
>
> builtin-trace.c: In function =E2=80=98btf_enum_scnprintf=E2=80=99:
> builtin-trace.c:998:25: error: declaration of =E2=80=98be=E2=80=99 shadow=
s a previous
> local [-Werror=3Dshadow]
>   998 |         for (int i =3D 0, be =3D arg_fmt->btf_entry.entries; i <
> arg_fmt->btf_entry.nr_entries; ++i, ++be) {
>       |                         ^~
> builtin-trace.c:991:26: note: shadowed declaration is here
>   991 |         struct btf_enum *be;
>       |                          ^~
> builtin-trace.c:998:30: error: initialization of =E2=80=98int=E2=80=99 fr=
om =E2=80=98void *=E2=80=99
> makes integer from pointer without a cast [-Wint-conversion]
>   998 |         for (int i =3D 0, be =3D arg_fmt->btf_entry.entries; i <
> arg_fmt->btf_entry.nr_entries; ++i, ++be) {
>       |                              ^~~~~~~
>
> But I can do:
>
> ```
> be =3D arg_fmt->btf_entry.entries;
>
> for (int i =3D 0; i < arg_fmt->btf_entry.nr_entries; ++i, ++be) {
> ```
>
> Thanks,
> Howard
>
>
> > >
> > > =E2=AC=A2[acme@toolbox perf-tools-next]$ git grep 'for (int ' tools/p=
erf/ | wc -l
> > > 99
> > > =E2=AC=A2[acme@toolbox perf-tools-next]$
> > >
> > > Doing it this way makes the code more compact and is allowed even in
> > > kernel code since some time ago:
> >
> > Sure.
> >
> > >
> > > =E2=AC=A2[acme@toolbox perf-tools-next]$ git grep 'for (int ' drivers=
/ | wc -l
> > > 294
> > > =E2=AC=A2[acme@toolbox perf-tools-next]$ git grep 'for (int ' kernel/=
 | wc -l
> > > 12
> > > =E2=AC=A2[acme@toolbox perf-tools-next]$ git grep 'for (int ' net/ | =
wc -l
> > > 3
> > > =E2=AC=A2[acme@toolbox perf-tools-next]$ git grep 'for (int ' mm/ | w=
c -l
> > > 21
> > > =E2=AC=A2[acme@toolbox perf-tools-next]$
> > >
> > > > +             if (be->val =3D=3D val) {
> > > > +                     return scnprintf(bf, size, "%s",
> > > > +                                      btf__name_by_offset(btf, be-=
>name_off));
> > > > +             }
> > > > +     }
> > > > +
> > > > +     return 0;
> > > > +}
> > > > +
> > > >  #include "trace/beauty/arch_errno_names.c"
> > > >  #include "trace/beauty/eventfd.c"
> > > >  #include "trace/beauty/futex_op.c"
> > > > @@ -1699,6 +1756,15 @@ static void trace__symbols__exit(struct trac=
e *trace)
> > > >       symbol__exit();
> > > >  }
> > > >
> > > > +static void trace__load_vmlinux_btf(struct trace *trace)
> > > > +{
> > > > +     trace->btf =3D btf__load_vmlinux_btf();
> > > > +     if (verbose > 0) {
> > > > +             fprintf(trace->output, trace->btf ? "vmlinux BTF load=
ed\n" :
> > > > +                                                 "Failed to load v=
mlinux BTF\n");
> > > > +     }
> > > > +}
> > > > +
> > > >  static int syscall__alloc_arg_fmts(struct syscall *sc, int nr_args=
)
> > > >  {
> > > >       int idx;
> > > > @@ -1744,7 +1810,7 @@ static const struct syscall_arg_fmt *syscall_=
arg_fmt__find_by_name(const char *n
> > > >  }
> > > >
> > > >  static struct tep_format_field *
> > > > -syscall_arg_fmt__init_array(struct syscall_arg_fmt *arg, struct te=
p_format_field *field)
> > > > +syscall_arg_fmt__init_array(struct syscall_arg_fmt *arg, struct te=
p_format_field *field, bool *use_btf)
> > > >  {
> > > >       struct tep_format_field *last_field =3D NULL;
> > > >       int len;
> > > > @@ -1782,6 +1848,8 @@ syscall_arg_fmt__init_array(struct syscall_ar=
g_fmt *arg, struct tep_format_field
> > > >                        * 7 unsigned long
> > > >                        */
> > > >                       arg->scnprintf =3D SCA_FD;
> > > > +             } else if (strstr(field->type, "enum") && use_btf !=
=3D NULL) {
> > > > +                     *use_btf =3D arg->is_enum =3D true;
> > >
> > > Here you have to check if use_btf is NULL, as you, in this patch, lat=
er
> > > call syscall_arg_fmt__init_array(arg, field, NULL) in
> > > evsel__init_tp_arg_scnprintf(), probably you tested it all at the end=
 of
> > > the patch series, we have to make sure that it works after each patch=
,
> > > so that we keep the codebase bisectable.
> >
> > I'm sorry, could you enlighten me on this? I thought:
> > ```
> > else if (strstr(field->type, "enum") && use_btf !=3D NULL) {
> > ```
> > is doing the NULL checking. If you mean making sure the NULL checking
> > appears in all patches, I thought this is where we should introduce
> > the checking. Tiny reminder, the [1/5] patch is your syscalltbl
> > traversal bug fix.
> >
> > >
> > > >               } else {
> > > >                       const struct syscall_arg_fmt *fmt =3D
> > > >                               syscall_arg_fmt__find_by_name(field->=
name);
> > > > @@ -1796,9 +1864,10 @@ syscall_arg_fmt__init_array(struct syscall_a=
rg_fmt *arg, struct tep_format_field
> > > >       return last_field;
> > > >  }
> > > >
> > > > -static int syscall__set_arg_fmts(struct syscall *sc)
> > > > +static int syscall__set_arg_fmts(struct syscall *sc, bool *use_btf=
)
> > > >  {
> > > > -     struct tep_format_field *last_field =3D syscall_arg_fmt__init=
_array(sc->arg_fmt, sc->args);
> > > > +     struct tep_format_field *last_field =3D syscall_arg_fmt__init=
_array(sc->arg_fmt, sc->args,
> > > > +                                                                  =
     use_btf);
> > > >
> > > >       if (last_field)
> > > >               sc->args_size =3D last_field->offset + last_field->si=
ze;
> > > > @@ -1810,7 +1879,9 @@ static int trace__read_syscall_info(struct tr=
ace *trace, int id)
> > > >  {
> > > >       char tp_name[128];
> > > >       struct syscall *sc;
> > > > +     int err;
> > > >       const char *name =3D syscalltbl__name(trace->sctbl, id);
> > > > +     bool use_btf =3D false;
> > > >
> > > >  #ifdef HAVE_SYSCALL_TABLE_SUPPORT
> > > >       if (trace->syscalls.table =3D=3D NULL) {
> > > > @@ -1883,7 +1954,12 @@ static int trace__read_syscall_info(struct t=
race *trace, int id)
> > > >       sc->is_exit =3D !strcmp(name, "exit_group") || !strcmp(name, =
"exit");
> > > >       sc->is_open =3D !strcmp(name, "open") || !strcmp(name, "opena=
t");
> > > >
> > > > -     return syscall__set_arg_fmts(sc);
> > > > +     err =3D syscall__set_arg_fmts(sc, &use_btf);
> > > > +
> > > > +     if (use_btf && trace->btf =3D=3D NULL)
> > > > +             trace__load_vmlinux_btf(trace);
> > > > +
> > > > +     return err;
> > > >  }
> > > >
> > > >  static int evsel__init_tp_arg_scnprintf(struct evsel *evsel)
> > > > @@ -1891,7 +1967,7 @@ static int evsel__init_tp_arg_scnprintf(struc=
t evsel *evsel)
> > > >       struct syscall_arg_fmt *fmt =3D evsel__syscall_arg_fmt(evsel)=
;
> > > >
> > > >       if (fmt !=3D NULL) {
> > > > -             syscall_arg_fmt__init_array(fmt, evsel->tp_format->fo=
rmat.fields);
> > > > +             syscall_arg_fmt__init_array(fmt, evsel->tp_format->fo=
rmat.fields, NULL);
> > > >               return 0;
> > > >       }
> > > >
> > > > @@ -2103,6 +2179,16 @@ static size_t syscall__scnprintf_args(struct=
 syscall *sc, char *bf, size_t size,
> > > >                       if (trace->show_arg_names)
> > > >                               printed +=3D scnprintf(bf + printed, =
size - printed, "%s: ", field->name);
> > > >
> > > > +                     if (sc->arg_fmt[arg.idx].is_enum && trace->bt=
f) {
> > > > +                             size_t p =3D btf_enum_scnprintf(bf + =
printed, size - printed, val,
> > > > +                                                           trace->=
btf, field->type,
> > > > +                                                           &sc->ar=
g_fmt[arg.idx]);
> > > > +                             if (p) {
> > > > +                                     printed +=3D p;
> > > > +                                     continue;
> > > > +                             }
> > > > +                     }
> > > > +
> > > >                       printed +=3D syscall_arg_fmt__scnprintf_val(&=
sc->arg_fmt[arg.idx],
> > > >                                                                 bf =
+ printed, size - printed, &arg, val);
> > > >               }
> > > > --
> > > > 2.45.2
> > > >
> >
> > Thanks,
> > Howard
