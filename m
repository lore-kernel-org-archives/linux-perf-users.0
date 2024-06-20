Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9561AC76D;
	Thu, 20 Jun 2024 16:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718901287; cv=none; b=r9Tr7lXoEptTricmv/JrJkcCUCp+pGvCknDOAv0sI9qHH4muDOtPNNBsNSXcfZ8rCw5RYFfaoGzWKH7NYBJgH+JMS3y9vpR2ePpnO1WZ6E2cittmRa3HUPBaSUWHDX+A3ORUwfTo4A/hs4KUCR5U46fqcfA+6GiPznh3LYto7sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718901287; c=relaxed/simple;
	bh=6BXARhlq0h8PZJc4neadCchzVlJSwe40jD5UxERVdy4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IaWVyj5pjakE8m3jKLyDDkmKPhdJU581+wSIg+J0QeKVdvb8LY87UdaMVj8EVV8CUwLC8kwdyYcuBlTtQqgYZsAJO/aAVwY3o+aoBL9FsYB06L2Q/iznJTCWWg5pdSM4Ttw/9avYf8NVEWoSbJ0im4Um96uNlXpbVOWdhg6Nf54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W05ZSeTs; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W05ZSeTs"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dfef5980a69so1072367276.3;
        Thu, 20 Jun 2024 09:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718901284; x=1719506084; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FH80GX0KSFGrFzGPBEeZHu4/673HxQil9KzDRyxMzyI=;
        b=W05ZSeTsA+lCVQ1LrULXOFWrevy+l/bsDDsGsnV9GklG1z5DY8bbXYSWZlhh0iNASz
         fMFwz3CVrPTOF86RSWINTnXPt7s9GA2Rtgt06uOeo6DoaAyq1te862X0V4yWKm2ogJm2
         rPHYP9s2uEq6rfYFnr5cV6fnKZ0Z8sZLkgynP1Fd6NszcCUP3iUCVMNAr2IU6HClY0Do
         Hnf77kkMLMzpi2zSRYXcLRzQBGH66+N8mMV8A2ANLfUPoAeV2bqyYXF1Kc0X3jtCBkn9
         uYOqQtdRqLj60SuhDuP3RAI4Y0XBUaS0wIEhMCxN3N6hdnzOOaXfnBdP6LtVKuQxLZKq
         2g1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718901284; x=1719506084;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FH80GX0KSFGrFzGPBEeZHu4/673HxQil9KzDRyxMzyI=;
        b=aY8s2jIuciVOKM2Xuptwi8Och9S1jyHjEgfaCL2Bt7DzY90lItTE1k4YICY59c98/X
         n1m2XJS9chRCMujT+iAlSzIK3mC0tSpJC1zYv2j8cjrkwmhDwi5gABcdFlonouC2i1hJ
         QAynT+DUAHI9lpdB0EWMZ7lAMuT69kDd7z/abVyQrwdmL2+W7fhBPOnmGzf/gKVMHjvU
         +5uS758pa5DOiJSAi09wzmn3O5WIZaHD4AAH9M17cdX2VgY7+TrVo/RdC8fHXKTpL/S5
         rN+avcXh0PxYllJA08UDg6YUYobYvN7oz3J1DyvKk6rQ5IMfR4xKD+xZA8Vu6oDCoson
         sjWg==
X-Forwarded-Encrypted: i=1; AJvYcCWM3G33O11AJStSWA7C30Wy7iwkTOwRpcryj3e0r/+OfnIWXXfa0ybgrYaKEgymR78it7unKMVQEQjdZG72Bb1sgpWWOi+FQfwYmoJKs7bhdCdLg0bzR3Uc7mHFW6R8UMTf6lBmMqA3UAxYYactaw==
X-Gm-Message-State: AOJu0Yw5ymE8ayFaOWL+4MQwc4+osALIDJVQD72QZU0wmkjlmUi01x4a
	1GjjAX2t1enK8G6MQCSQCAnscxAHiiPlJb0ut5iAuW92yuXrPAnC1gmT6x9qYZCWtLNlJOTrFKG
	7TKoqIlD4fTJty+B6edqjVjRuirE=
X-Google-Smtp-Source: AGHT+IHM88JfCF5OIv9nhhkFYY85dL/Z+GRUlENl7+dJQivQRuOE4qBucQA1fQ66ENLtt2YXNzPA9fqJZF/cleQTF28=
X-Received: by 2002:a25:c5c9:0:b0:dfa:7791:7132 with SMTP id
 3f1490d57ef6-e02be229325mr5963031276.65.1718901283779; Thu, 20 Jun 2024
 09:34:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240619082042.4173621-1-howardchu95@gmail.com>
 <20240619082042.4173621-3-howardchu95@gmail.com> <ZnLgstTgrFRYu0aD@x1> <CAH0uvohKGrfwApZXfJZaWx4LQgPXct+uQ_N7snmqSo4VeCxVUA@mail.gmail.com>
In-Reply-To: <CAH0uvohKGrfwApZXfJZaWx4LQgPXct+uQ_N7snmqSo4VeCxVUA@mail.gmail.com>
From: Howard Chu <howardchu95@gmail.com>
Date: Fri, 21 Jun 2024 00:34:35 +0800
Message-ID: <CAH0uvohxZ16MFCG2g3my48yUtp9AHAiAZCPAmkT5bDtNM6sGhg@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] perf trace: Augment enum syscall arguments with BTF
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Arnaldo,

Thanks for the review, the code is refined based on your comments.
There is just a little thing:

On Thu, Jun 20, 2024 at 1:59=E2=80=AFAM Howard Chu <howardchu95@gmail.com> =
wrote:
>
> Hello,
>
> Thanks for the in-depth review.
>
> On Wed, Jun 19, 2024 at 9:44=E2=80=AFPM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > On Wed, Jun 19, 2024 at 04:20:39PM +0800, Howard Chu wrote:
> > > This is a feature implemented on the basis of the previous bug fix
> > > https://lore.kernel.org/linux-perf-users/d18a9606-ac9f-4ca7-afaf-fcf4=
c951cb90@web.de/T/#t
> > >
> > > In this patch, BTF is used to turn enum value to the corresponding
> > > enum variable name. There is only one system call that uses enum valu=
e
> > > as its argument, that is `landlock_add_rule()`.
> > >
> > > The vmlinux btf is loaded lazily, when user decided to trace the
> > > `landlock_add_rule` syscall. But if one decides to run `perf trace`
> > > without any arguments, the behaviour is to trace `landlock_add_rule`,
> > > so vmlinux btf will be loaded by default.
> > >
> > > before:
> > >
> > > ```
> > > perf $ ./perf trace -e landlock_add_rule
> > >      0.000 ( 0.008 ms): ldlck-test/438194 landlock_add_rule(rule_type=
: 2)                                       =3D -1 EBADFD (File descriptor i=
n bad state)
> > >      0.010 ( 0.001 ms): ldlck-test/438194 landlock_add_rule(rule_type=
: 1)                                       =3D -1 EBADFD (File descriptor i=
n bad state)
> > > ```
> > >
> > > after:
> > >
> > > ```
> > > perf $ ./perf trace -e landlock_add_rule
> > >      0.000 ( 0.029 ms): ldlck-test/438194 landlock_add_rule(rule_type=
: LANDLOCK_RULE_NET_PORT)                  =3D -1 EBADFD (File descriptor i=
n bad state)
> > >      0.036 ( 0.004 ms): ldlck-test/438194 landlock_add_rule(rule_type=
: LANDLOCK_RULE_PATH_BENEATH)              =3D -1 EBADFD (File descriptor i=
n bad state)
> > > ```
> > > Tested-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> > > Suggested-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> > > Reviewed-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> > > Signed-off-by: Howard Chu <howardchu95@gmail.com>
> > > ---
> > >  tools/perf/builtin-trace.c | 96 ++++++++++++++++++++++++++++++++++++=
--
> > >  1 file changed, 91 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> > > index c4fa8191253d..d93f34e9af74 100644
> > > --- a/tools/perf/builtin-trace.c
> > > +++ b/tools/perf/builtin-trace.c
> > > @@ -19,6 +19,7 @@
> > >  #ifdef HAVE_LIBBPF_SUPPORT
> > >  #include <bpf/bpf.h>
> > >  #include <bpf/libbpf.h>
> > > +#include <bpf/btf.h>
> > >  #ifdef HAVE_BPF_SKEL
> > >  #include "bpf_skel/augmented_raw_syscalls.skel.h"
> > >  #endif
> > > @@ -110,6 +111,11 @@ struct syscall_arg_fmt {
> > >       const char *name;
> > >       u16        nr_entries; // for arrays
> > >       bool       show_zero;
> > > +     bool       is_enum;
> > > +     struct {
> > > +             void    *entries;
> > > +             u16     nr_entries;
> > > +     }          btf_entry;
> > >  };
> > >
> > >  struct syscall_fmt {
> > > @@ -140,6 +146,7 @@ struct trace {
> > >  #ifdef HAVE_BPF_SKEL
> > >       struct augmented_raw_syscalls_bpf *skel;
> > >  #endif
> > > +     struct btf              *btf;
> > >       struct record_opts      opts;
> > >       struct evlist   *evlist;
> > >       struct machine          *host;
> > > @@ -897,6 +904,56 @@ static size_t syscall_arg__scnprintf_getrandom_f=
lags(char *bf, size_t size,
> > >           .strtoul    =3D STUL_STRARRAY_FLAGS, \
> > >           .parm       =3D &strarray__##array, }
> > >
> > > +static int btf_enum_find_entry(struct btf *btf, char *type, struct s=
yscall_arg_fmt *arg_fmt)
> > > +{
> > > +     const struct btf_type *bt;
> > > +     char enum_prefix[][16] =3D { "enum", "const enum" }, *ep;
> > > +     int id;
> > > +     size_t i;
> > > +
> > > +     for (i =3D 0; i < ARRAY_SIZE(enum_prefix); i++) {
> > > +             ep =3D enum_prefix[i];
> > > +             if (strlen(type) > strlen(ep) + 1 && strstarts(type, ep=
))
> >
> > No need for the strlen test? I.e. plain using strstarts() should be
> > enough?
>
> Agree. Thanks for pointing that out. Although if string 'type' is
> 'enum' and prefix is 'enum', strstarts() will be true, but to do 'type
> +=3D strlen(ep) + 1', and then access 'type', might give us an
> out-of-range access, but I don't think 'type' will ever be just 'enum'
> or 'const enum', so I'll delete it then.
>
> >
> > > +                     type +=3D strlen(ep) + 1;
> > > +     }
> > > +
> > > +     id =3D btf__find_by_name(btf, type);
> > > +     if (id < 0)
> > > +             return -1;
> > > +
> > > +     bt =3D btf__type_by_id(btf, id);
> > > +     if (bt =3D=3D NULL)
> >
> > a pr_debug() stating that something that tracefs says should be in BTF
> > and isn't found there seems to be of value here.
>
> Sure.
>
> >
> > > +             return -1;
> > > +
> > > +     arg_fmt->btf_entry.entries    =3D btf_enum(bt);
> > > +     arg_fmt->btf_entry.nr_entries =3D btf_vlen(bt);
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +static size_t btf_enum_scnprintf(char *bf, size_t size, int val, str=
uct btf *btf, char *type,
> > > +                              struct syscall_arg_fmt *arg_fmt)
> > > +{
> > > +     struct btf_enum *be;
> > > +     int i;
> > > +
> > > +     /* if btf_entry is NULL, find and save it to arg_fmt */
> > > +     if (arg_fmt->btf_entry.entries =3D=3D NULL)
> > > +             if (btf_enum_find_entry(btf, type, arg_fmt))
> > > +                     return 0;
> > > +
> > > +     be =3D (struct btf_enum *)arg_fmt->btf_entry.entries;
> >
> >         struct btf_enum *be =3D (struct btf_enum *)arg_fmt->btf_entry.e=
ntries;
> >
> >  arg_fmt->btf_entry.entries is (void *), so we don't need the (struct
> > btf_enum *) cast here, removing it makes the code more compact. And
> > since we move the declaration to the same line, the info about its type
> > is there as well.
>
> Sure, thanks.
>
> >
> > > +
> > > +     for (i =3D 0; i < arg_fmt->btf_entry.nr_entries; ++i, ++be) {
> >
> >
> >         for (int i =3D 0; i < arg_fmt->btf_entry.nr_entries; ++i, ++be)=
 {

I did this, it's all good. But here:

for (i =3D 0, be =3D arg_fmt->btf_entry.entries; i <
arg_fmt->btf_entry.nr_entries; ++i, ++be) {

I can't do

for (int i =3D 0, struct btf_enum *be =3D arg_fmt->btf_entry.entries; i <
arg_fmt->btf_entry.nr_entries; ++i, ++be) {

The compiler will show errors:

builtin-trace.c: In function =E2=80=98btf_enum_scnprintf=E2=80=99:
builtin-trace.c:996:25: error: expected identifier or =E2=80=98(=E2=80=99 b=
efore =E2=80=98struct=E2=80=99
  996 |         for (int i =3D 0, struct btf_enum *be =3D
arg_fmt->btf_entry.entries; i < arg_fmt->btf_entry.nr_entries; ++i,
++be) {
      |                         ^~~~~~
builtin-trace.c:996:117: error: =E2=80=98be=E2=80=99 undeclared (first use =
in this
function); did you mean =E2=80=98bf=E2=80=99?
  996 |         for (int i =3D 0, struct btf_enum *be =3D
arg_fmt->btf_entry.entries; i < arg_fmt->btf_entry.nr_entries; ++i,
++be) {
      |
                                                     ^~
      |
                                                     bf
builtin-trace.c:996:117: note: each undeclared identifier is reported
only once for each function it appears in

This is not good either:

for (int i =3D 0, be =3D arg_fmt->btf_entry.entries; i <
arg_fmt->btf_entry.nr_entries; ++i, ++be) {

builtin-trace.c: In function =E2=80=98btf_enum_scnprintf=E2=80=99:
builtin-trace.c:998:25: error: declaration of =E2=80=98be=E2=80=99 shadows =
a previous
local [-Werror=3Dshadow]
  998 |         for (int i =3D 0, be =3D arg_fmt->btf_entry.entries; i <
arg_fmt->btf_entry.nr_entries; ++i, ++be) {
      |                         ^~
builtin-trace.c:991:26: note: shadowed declaration is here
  991 |         struct btf_enum *be;
      |                          ^~
builtin-trace.c:998:30: error: initialization of =E2=80=98int=E2=80=99 from=
 =E2=80=98void *=E2=80=99
makes integer from pointer without a cast [-Wint-conversion]
  998 |         for (int i =3D 0, be =3D arg_fmt->btf_entry.entries; i <
arg_fmt->btf_entry.nr_entries; ++i, ++be) {
      |                              ^~~~~~~

But I can do:

```
be =3D arg_fmt->btf_entry.entries;

for (int i =3D 0; i < arg_fmt->btf_entry.nr_entries; ++i, ++be) {
```

Thanks,
Howard


> >
> > =E2=AC=A2[acme@toolbox perf-tools-next]$ git grep 'for (int ' tools/per=
f/ | wc -l
> > 99
> > =E2=AC=A2[acme@toolbox perf-tools-next]$
> >
> > Doing it this way makes the code more compact and is allowed even in
> > kernel code since some time ago:
>
> Sure.
>
> >
> > =E2=AC=A2[acme@toolbox perf-tools-next]$ git grep 'for (int ' drivers/ =
| wc -l
> > 294
> > =E2=AC=A2[acme@toolbox perf-tools-next]$ git grep 'for (int ' kernel/ |=
 wc -l
> > 12
> > =E2=AC=A2[acme@toolbox perf-tools-next]$ git grep 'for (int ' net/ | wc=
 -l
> > 3
> > =E2=AC=A2[acme@toolbox perf-tools-next]$ git grep 'for (int ' mm/ | wc =
-l
> > 21
> > =E2=AC=A2[acme@toolbox perf-tools-next]$
> >
> > > +             if (be->val =3D=3D val) {
> > > +                     return scnprintf(bf, size, "%s",
> > > +                                      btf__name_by_offset(btf, be->n=
ame_off));
> > > +             }
> > > +     }
> > > +
> > > +     return 0;
> > > +}
> > > +
> > >  #include "trace/beauty/arch_errno_names.c"
> > >  #include "trace/beauty/eventfd.c"
> > >  #include "trace/beauty/futex_op.c"
> > > @@ -1699,6 +1756,15 @@ static void trace__symbols__exit(struct trace =
*trace)
> > >       symbol__exit();
> > >  }
> > >
> > > +static void trace__load_vmlinux_btf(struct trace *trace)
> > > +{
> > > +     trace->btf =3D btf__load_vmlinux_btf();
> > > +     if (verbose > 0) {
> > > +             fprintf(trace->output, trace->btf ? "vmlinux BTF loaded=
\n" :
> > > +                                                 "Failed to load vml=
inux BTF\n");
> > > +     }
> > > +}
> > > +
> > >  static int syscall__alloc_arg_fmts(struct syscall *sc, int nr_args)
> > >  {
> > >       int idx;
> > > @@ -1744,7 +1810,7 @@ static const struct syscall_arg_fmt *syscall_ar=
g_fmt__find_by_name(const char *n
> > >  }
> > >
> > >  static struct tep_format_field *
> > > -syscall_arg_fmt__init_array(struct syscall_arg_fmt *arg, struct tep_=
format_field *field)
> > > +syscall_arg_fmt__init_array(struct syscall_arg_fmt *arg, struct tep_=
format_field *field, bool *use_btf)
> > >  {
> > >       struct tep_format_field *last_field =3D NULL;
> > >       int len;
> > > @@ -1782,6 +1848,8 @@ syscall_arg_fmt__init_array(struct syscall_arg_=
fmt *arg, struct tep_format_field
> > >                        * 7 unsigned long
> > >                        */
> > >                       arg->scnprintf =3D SCA_FD;
> > > +             } else if (strstr(field->type, "enum") && use_btf !=3D =
NULL) {
> > > +                     *use_btf =3D arg->is_enum =3D true;
> >
> > Here you have to check if use_btf is NULL, as you, in this patch, later
> > call syscall_arg_fmt__init_array(arg, field, NULL) in
> > evsel__init_tp_arg_scnprintf(), probably you tested it all at the end o=
f
> > the patch series, we have to make sure that it works after each patch,
> > so that we keep the codebase bisectable.
>
> I'm sorry, could you enlighten me on this? I thought:
> ```
> else if (strstr(field->type, "enum") && use_btf !=3D NULL) {
> ```
> is doing the NULL checking. If you mean making sure the NULL checking
> appears in all patches, I thought this is where we should introduce
> the checking. Tiny reminder, the [1/5] patch is your syscalltbl
> traversal bug fix.
>
> >
> > >               } else {
> > >                       const struct syscall_arg_fmt *fmt =3D
> > >                               syscall_arg_fmt__find_by_name(field->na=
me);
> > > @@ -1796,9 +1864,10 @@ syscall_arg_fmt__init_array(struct syscall_arg=
_fmt *arg, struct tep_format_field
> > >       return last_field;
> > >  }
> > >
> > > -static int syscall__set_arg_fmts(struct syscall *sc)
> > > +static int syscall__set_arg_fmts(struct syscall *sc, bool *use_btf)
> > >  {
> > > -     struct tep_format_field *last_field =3D syscall_arg_fmt__init_a=
rray(sc->arg_fmt, sc->args);
> > > +     struct tep_format_field *last_field =3D syscall_arg_fmt__init_a=
rray(sc->arg_fmt, sc->args,
> > > +                                                                    =
   use_btf);
> > >
> > >       if (last_field)
> > >               sc->args_size =3D last_field->offset + last_field->size=
;
> > > @@ -1810,7 +1879,9 @@ static int trace__read_syscall_info(struct trac=
e *trace, int id)
> > >  {
> > >       char tp_name[128];
> > >       struct syscall *sc;
> > > +     int err;
> > >       const char *name =3D syscalltbl__name(trace->sctbl, id);
> > > +     bool use_btf =3D false;
> > >
> > >  #ifdef HAVE_SYSCALL_TABLE_SUPPORT
> > >       if (trace->syscalls.table =3D=3D NULL) {
> > > @@ -1883,7 +1954,12 @@ static int trace__read_syscall_info(struct tra=
ce *trace, int id)
> > >       sc->is_exit =3D !strcmp(name, "exit_group") || !strcmp(name, "e=
xit");
> > >       sc->is_open =3D !strcmp(name, "open") || !strcmp(name, "openat"=
);
> > >
> > > -     return syscall__set_arg_fmts(sc);
> > > +     err =3D syscall__set_arg_fmts(sc, &use_btf);
> > > +
> > > +     if (use_btf && trace->btf =3D=3D NULL)
> > > +             trace__load_vmlinux_btf(trace);
> > > +
> > > +     return err;
> > >  }
> > >
> > >  static int evsel__init_tp_arg_scnprintf(struct evsel *evsel)
> > > @@ -1891,7 +1967,7 @@ static int evsel__init_tp_arg_scnprintf(struct =
evsel *evsel)
> > >       struct syscall_arg_fmt *fmt =3D evsel__syscall_arg_fmt(evsel);
> > >
> > >       if (fmt !=3D NULL) {
> > > -             syscall_arg_fmt__init_array(fmt, evsel->tp_format->form=
at.fields);
> > > +             syscall_arg_fmt__init_array(fmt, evsel->tp_format->form=
at.fields, NULL);
> > >               return 0;
> > >       }
> > >
> > > @@ -2103,6 +2179,16 @@ static size_t syscall__scnprintf_args(struct s=
yscall *sc, char *bf, size_t size,
> > >                       if (trace->show_arg_names)
> > >                               printed +=3D scnprintf(bf + printed, si=
ze - printed, "%s: ", field->name);
> > >
> > > +                     if (sc->arg_fmt[arg.idx].is_enum && trace->btf)=
 {
> > > +                             size_t p =3D btf_enum_scnprintf(bf + pr=
inted, size - printed, val,
> > > +                                                           trace->bt=
f, field->type,
> > > +                                                           &sc->arg_=
fmt[arg.idx]);
> > > +                             if (p) {
> > > +                                     printed +=3D p;
> > > +                                     continue;
> > > +                             }
> > > +                     }
> > > +
> > >                       printed +=3D syscall_arg_fmt__scnprintf_val(&sc=
->arg_fmt[arg.idx],
> > >                                                                 bf + =
printed, size - printed, &arg, val);
> > >               }
> > > --
> > > 2.45.2
> > >
>
> Thanks,
> Howard
