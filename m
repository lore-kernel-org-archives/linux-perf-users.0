Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2643410A39;
	Fri, 21 Jun 2024 16:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718986704; cv=none; b=ifpfeQYDxpsQ5ZTQKUzpMMYuf5A0Na9KWQsViDADTj0DLXZBlUn5j/HtInaX7jLwcd5my/DGFUhdn7094XrBtMZemfbhFp33+5UNR+bimlXi6pG6dHVsTxbPHb0nP757mFk7k7ZQmGzSfsVPETvBAJpfZ/gzDFqRg54IqvIW3yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718986704; c=relaxed/simple;
	bh=ECiUXphAxtqbLuLNyW+ZM4+raMN1lbVOoa9ZXbnBjqo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kt99iiA27opsyyY7oqq9ixnCdIZV2uPxSBHfJaKzwJ3ygk9JofXCL2LBkNghZCUqRSj/WkvR6winNiuKsFOgSIieXUkU1/zKQzuT18OGob9AsnE7MVJ8W55pM+bx6oYeB/BLbDIr7MvWb9Fyppw+uIlkNXO70frMqBtgwGHPXRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SASNqQs2; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SASNqQs2"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dfef5980a69so2180009276.3;
        Fri, 21 Jun 2024 09:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718986701; x=1719591501; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rrnRcElXbt9r3tXJnobEbIghuKOwhtgrYBihiA+b0sM=;
        b=SASNqQs2J+0OPBs5+P4/5FIXO9izazZ/krDSvd6iJLfxjF30+/RpbowQJiCnMQIf/9
         1UjMEqMWH19d6aRdo2Xvhaz8Y3RJSRShN/pkU8ItmaAibtTcDlbJpeYISh1LM/lqE6Ab
         Tumr7MNFiXMrRhhUs1SiSoIsLvI51R+/Imh7A6NbR9jXdTL7iJVzCMr0NoaCDEAreZRU
         vnjYSLfQBmxzsOkg5CJ3cw6a2b9okG6jY0fNiMENMgAvna0ibbu66hBeEjUlCn5jtXmS
         6mfRdL7Aww4aWCEnfc3MLd/IZxyy/rXXB2iX/mBplu8Lub1ov1WaZCQ6KLMShZ5JOMhN
         tgyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718986701; x=1719591501;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rrnRcElXbt9r3tXJnobEbIghuKOwhtgrYBihiA+b0sM=;
        b=gKIAz4hmbNA4biMUH3eZ4hSO/jn5wZlbpn17NBKc//0vYfomsp+xuGgGhKqHYnnopT
         wRTCuG3S/9g4mNF6o7cXqAl0NWYU4+5W+EclUD+zmwSjy+5/7xt3uumHfboJ6HuVhhx6
         i8kc2faDmWyrbhiOo9DTmmTxfWjQHcOQXUaQGd9va1r7dSi6OAOD0uAezg8nqSmN6YhD
         4M164XL7CD9f6b+mLc6niQUP76LzZxEoHWRjdSZ/EtCKIUlKfDuijpvlZtDLcPA+zb7Y
         EM+L1q1H3YKnVMVBzt+5fSA4/kJQxHxUmS++f7gnM4fLhjoNyW5s+fFZhhXZjARx9idw
         B3VQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3Nh7Gz3h1FtVFHhonSOS7P9QvDGtHyn6wfze9KfPjSnSMfeLTIWMKREr5i5bsMzILLixJEQ4C7zpqHP3tNRMwoJo0GGyVtplInSyLFDSj13139F/Tvy3zKzXOqJ6bNlvbjvz231csyVXpoNzlNw==
X-Gm-Message-State: AOJu0YyBvqgOx+7OWBIubVe7M26TbrJ26FLDPs8Wt/LDmwuCVrv1W5GB
	gcgTYPnnfBtRk7z4g9z0rJzfhoTl4Ax9u+tnkmE7EM0s1LXo29f7GuUrdkFRRDChua8W9sAK4f/
	DOk1TNlb5/ZjpsvskKpQMOkk9l4nMoOz+0t4=
X-Google-Smtp-Source: AGHT+IH1KyskxAeEluLbFx+MSnKUnvzDe008vl7BfInaBPctKSNEqlxFeLbMBnFqjNeN6KefT0b5EwR6dQ9HMX41JsY=
X-Received: by 2002:a25:ad0c:0:b0:dfe:5a00:df5c with SMTP id
 3f1490d57ef6-e02be138c72mr9739838276.18.1718986700830; Fri, 21 Jun 2024
 09:18:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240619082042.4173621-1-howardchu95@gmail.com>
 <20240619082042.4173621-3-howardchu95@gmail.com> <ZnLgstTgrFRYu0aD@x1>
 <CAH0uvohKGrfwApZXfJZaWx4LQgPXct+uQ_N7snmqSo4VeCxVUA@mail.gmail.com>
 <CAH0uvohxZ16MFCG2g3my48yUtp9AHAiAZCPAmkT5bDtNM6sGhg@mail.gmail.com>
 <CAH0uvohe2WssHZGYNyMCq=xpasXOYxaznRsGPe49iYQBME8_QQ@mail.gmail.com> <ZnWCxgeFClpo2k3M@x1>
In-Reply-To: <ZnWCxgeFClpo2k3M@x1>
From: Howard Chu <howardchu95@gmail.com>
Date: Sat, 22 Jun 2024 00:18:10 +0800
Message-ID: <CAH0uvohMLkgRBF48evgU=-CMFsHsGZxKs3nA6bWSS_Vv-tqM=g@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] perf trace: Augment enum syscall arguments with BTF
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Arnaldo,

I think I need to add some explanations here, for the all-in-one patch
that I have on the tree.

Firstly, no use_btf is passed when constructing syscall argument
format. We just write is_enum when the type is enum. This is because
we don't load btf when we are constructing the formats, we load
vmlinux when a tracepoint hits.

before:

} else if (strstr(field->type, "enum") && use_btf !=3D NULL) {
*use_btf =3D arg->is_enum =3D true;

after:

} else if (strstr(field->type, "enum")) {
arg->is_enum =3D true;

Another confusing place is when we do the filtering. When a user
passes an enum name, say --filter=3D"mode=3D=3DHRTIMER_MODE_ABS", we do not
know what 'HRTIMER_MODE_ABS' means. For this case, we have to load the
vmlinux BTF, and match the strings to get a value, not delaying till a
tracepoint hits.

Next thing is, for this section in trace__expand_filter():

```
struct btf_parm bparm;

if (fmt->is_enum) {
    if (trace->btf =3D=3D NULL)
        trace__load_vmlinux_btf(trace);

    /* btf could be NULL */
    bparm.btf  =3D trace->btf;
    bparm.type =3D type;
    syscall_arg.parm =3D &bparm;
}
```

I don't handle the return value of trace__load_vmlinux_btf(), because
I want to make the latter " if (fmt->strtoul(right, right_size,
&syscall_arg, &val)) {
" evaluated to be false, so that we can fall into the else block,
therefore prints the pr_err of no resolver. This could be confusing.

pr_err("No resolver (strtoul) for \"%s\" in \"%s\", can't set filter \"%s\"=
\n",
       arg, evsel->name, evsel->filter);
return -1;

And another confusing part is, originally we discard 0 value for enum
arguments, now with enum aug, printed a 0-value enum makes sense,
therefore these lines:

if (val =3D=3D 0 && !trace->show_zeros &&
    !(sc->arg_fmt && sc->arg_fmt[arg.idx].show_zero))
#ifdef HAVE_LIBBPF_SUPPORT
        if (!(sc->arg_fmt && sc->arg_fmt[arg.idx].is_enum))
#endif
        continue;

It suits as an &&, I don't know if it's the best way to do it.

That's it for all, thank you for finding time in your busy schedule to
review my code. I'll develop my skills to do self-checks in the
future,

Thanks,
Howard

On Fri, Jun 21, 2024 at 9:40=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Fri, Jun 21, 2024 at 03:16:26AM +0800, Howard Chu wrote:
> > Hello,
> >
> > The fixes are on the perf-tools-next branch at:
> > https://github.com/Sberm/linux.git
> >
> > please use
> > ```
> > git pull https://github.com/Sberm/linux.git perf-tools-next
> > ```
> >
> > I'm no git expert so please tell me if something is wrong.
>
> So, you combined everything into just one patch and there is no commit
> log message, I'll see if I can redo it from the last broken out patch
> series you submitted.
>
> - Arnaldo
>
> > P.S. not my proudest patch, changed too many things, might be buggy.
> > If there're bugs please let me know.
> >
> > On Fri, Jun 21, 2024 at 12:34=E2=80=AFAM Howard Chu <howardchu95@gmail.=
com> wrote:
> > >
> > > Hello Arnaldo,
> > >
> > > Thanks for the review, the code is refined based on your comments.
> > > There is just a little thing:
> > >
> > > On Thu, Jun 20, 2024 at 1:59=E2=80=AFAM Howard Chu <howardchu95@gmail=
.com> wrote:
> > > >
> > > > Hello,
> > > >
> > > > Thanks for the in-depth review.
> > > >
> > > > On Wed, Jun 19, 2024 at 9:44=E2=80=AFPM Arnaldo Carvalho de Melo
> > > > <acme@kernel.org> wrote:
> > > > >
> > > > > On Wed, Jun 19, 2024 at 04:20:39PM +0800, Howard Chu wrote:
> > > > > > This is a feature implemented on the basis of the previous bug =
fix
> > > > > > https://lore.kernel.org/linux-perf-users/d18a9606-ac9f-4ca7-afa=
f-fcf4c951cb90@web.de/T/#t
> > > > > >
> > > > > > In this patch, BTF is used to turn enum value to the correspond=
ing
> > > > > > enum variable name. There is only one system call that uses enu=
m value
> > > > > > as its argument, that is `landlock_add_rule()`.
> > > > > >
> > > > > > The vmlinux btf is loaded lazily, when user decided to trace th=
e
> > > > > > `landlock_add_rule` syscall. But if one decides to run `perf tr=
ace`
> > > > > > without any arguments, the behaviour is to trace `landlock_add_=
rule`,
> > > > > > so vmlinux btf will be loaded by default.
> > > > > >
> > > > > > before:
> > > > > >
> > > > > > ```
> > > > > > perf $ ./perf trace -e landlock_add_rule
> > > > > >      0.000 ( 0.008 ms): ldlck-test/438194 landlock_add_rule(rul=
e_type: 2)                                       =3D -1 EBADFD (File descri=
ptor in bad state)
> > > > > >      0.010 ( 0.001 ms): ldlck-test/438194 landlock_add_rule(rul=
e_type: 1)                                       =3D -1 EBADFD (File descri=
ptor in bad state)
> > > > > > ```
> > > > > >
> > > > > > after:
> > > > > >
> > > > > > ```
> > > > > > perf $ ./perf trace -e landlock_add_rule
> > > > > >      0.000 ( 0.029 ms): ldlck-test/438194 landlock_add_rule(rul=
e_type: LANDLOCK_RULE_NET_PORT)                  =3D -1 EBADFD (File descri=
ptor in bad state)
> > > > > >      0.036 ( 0.004 ms): ldlck-test/438194 landlock_add_rule(rul=
e_type: LANDLOCK_RULE_PATH_BENEATH)              =3D -1 EBADFD (File descri=
ptor in bad state)
> > > > > > ```
> > > > > > Tested-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> > > > > > Suggested-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> > > > > > Reviewed-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> > > > > > Signed-off-by: Howard Chu <howardchu95@gmail.com>
> > > > > > ---
> > > > > >  tools/perf/builtin-trace.c | 96 ++++++++++++++++++++++++++++++=
++++++--
> > > > > >  1 file changed, 91 insertions(+), 5 deletions(-)
> > > > > >
> > > > > > diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-tr=
ace.c
> > > > > > index c4fa8191253d..d93f34e9af74 100644
> > > > > > --- a/tools/perf/builtin-trace.c
> > > > > > +++ b/tools/perf/builtin-trace.c
> > > > > > @@ -19,6 +19,7 @@
> > > > > >  #ifdef HAVE_LIBBPF_SUPPORT
> > > > > >  #include <bpf/bpf.h>
> > > > > >  #include <bpf/libbpf.h>
> > > > > > +#include <bpf/btf.h>
> > > > > >  #ifdef HAVE_BPF_SKEL
> > > > > >  #include "bpf_skel/augmented_raw_syscalls.skel.h"
> > > > > >  #endif
> > > > > > @@ -110,6 +111,11 @@ struct syscall_arg_fmt {
> > > > > >       const char *name;
> > > > > >       u16        nr_entries; // for arrays
> > > > > >       bool       show_zero;
> > > > > > +     bool       is_enum;
> > > > > > +     struct {
> > > > > > +             void    *entries;
> > > > > > +             u16     nr_entries;
> > > > > > +     }          btf_entry;
> > > > > >  };
> > > > > >
> > > > > >  struct syscall_fmt {
> > > > > > @@ -140,6 +146,7 @@ struct trace {
> > > > > >  #ifdef HAVE_BPF_SKEL
> > > > > >       struct augmented_raw_syscalls_bpf *skel;
> > > > > >  #endif
> > > > > > +     struct btf              *btf;
> > > > > >       struct record_opts      opts;
> > > > > >       struct evlist   *evlist;
> > > > > >       struct machine          *host;
> > > > > > @@ -897,6 +904,56 @@ static size_t syscall_arg__scnprintf_getra=
ndom_flags(char *bf, size_t size,
> > > > > >           .strtoul    =3D STUL_STRARRAY_FLAGS, \
> > > > > >           .parm       =3D &strarray__##array, }
> > > > > >
> > > > > > +static int btf_enum_find_entry(struct btf *btf, char *type, st=
ruct syscall_arg_fmt *arg_fmt)
> > > > > > +{
> > > > > > +     const struct btf_type *bt;
> > > > > > +     char enum_prefix[][16] =3D { "enum", "const enum" }, *ep;
> > > > > > +     int id;
> > > > > > +     size_t i;
> > > > > > +
> > > > > > +     for (i =3D 0; i < ARRAY_SIZE(enum_prefix); i++) {
> > > > > > +             ep =3D enum_prefix[i];
> > > > > > +             if (strlen(type) > strlen(ep) + 1 && strstarts(ty=
pe, ep))
> > > > >
> > > > > No need for the strlen test? I.e. plain using strstarts() should =
be
> > > > > enough?
> > > >
> > > > Agree. Thanks for pointing that out. Although if string 'type' is
> > > > 'enum' and prefix is 'enum', strstarts() will be true, but to do 't=
ype
> > > > +=3D strlen(ep) + 1', and then access 'type', might give us an
> > > > out-of-range access, but I don't think 'type' will ever be just 'en=
um'
> > > > or 'const enum', so I'll delete it then.
> > > >
> > > > >
> > > > > > +                     type +=3D strlen(ep) + 1;
> > > > > > +     }
> > > > > > +
> > > > > > +     id =3D btf__find_by_name(btf, type);
> > > > > > +     if (id < 0)
> > > > > > +             return -1;
> > > > > > +
> > > > > > +     bt =3D btf__type_by_id(btf, id);
> > > > > > +     if (bt =3D=3D NULL)
> > > > >
> > > > > a pr_debug() stating that something that tracefs says should be i=
n BTF
> > > > > and isn't found there seems to be of value here.
> > > >
> > > > Sure.
> > > >
> > > > >
> > > > > > +             return -1;
> > > > > > +
> > > > > > +     arg_fmt->btf_entry.entries    =3D btf_enum(bt);
> > > > > > +     arg_fmt->btf_entry.nr_entries =3D btf_vlen(bt);
> > > > > > +
> > > > > > +     return 0;
> > > > > > +}
> > > > > > +
> > > > > > +static size_t btf_enum_scnprintf(char *bf, size_t size, int va=
l, struct btf *btf, char *type,
> > > > > > +                              struct syscall_arg_fmt *arg_fmt)
> > > > > > +{
> > > > > > +     struct btf_enum *be;
> > > > > > +     int i;
> > > > > > +
> > > > > > +     /* if btf_entry is NULL, find and save it to arg_fmt */
> > > > > > +     if (arg_fmt->btf_entry.entries =3D=3D NULL)
> > > > > > +             if (btf_enum_find_entry(btf, type, arg_fmt))
> > > > > > +                     return 0;
> > > > > > +
> > > > > > +     be =3D (struct btf_enum *)arg_fmt->btf_entry.entries;
> > > > >
> > > > >         struct btf_enum *be =3D (struct btf_enum *)arg_fmt->btf_e=
ntry.entries;
> > > > >
> > > > >  arg_fmt->btf_entry.entries is (void *), so we don't need the (st=
ruct
> > > > > btf_enum *) cast here, removing it makes the code more compact. A=
nd
> > > > > since we move the declaration to the same line, the info about it=
s type
> > > > > is there as well.
> > > >
> > > > Sure, thanks.
> > > >
> > > > >
> > > > > > +
> > > > > > +     for (i =3D 0; i < arg_fmt->btf_entry.nr_entries; ++i, ++b=
e) {
> > > > >
> > > > >
> > > > >         for (int i =3D 0; i < arg_fmt->btf_entry.nr_entries; ++i,=
 ++be) {
> > >
> > > I did this, it's all good. But here:
> > >
> > > for (i =3D 0, be =3D arg_fmt->btf_entry.entries; i <
> > > arg_fmt->btf_entry.nr_entries; ++i, ++be) {
> > >
> > > I can't do
> > >
> > > for (int i =3D 0, struct btf_enum *be =3D arg_fmt->btf_entry.entries;=
 i <
> > > arg_fmt->btf_entry.nr_entries; ++i, ++be) {
> > >
> > > The compiler will show errors:
> > >
> > > builtin-trace.c: In function =E2=80=98btf_enum_scnprintf=E2=80=99:
> > > builtin-trace.c:996:25: error: expected identifier or =E2=80=98(=E2=
=80=99 before =E2=80=98struct=E2=80=99
> > >   996 |         for (int i =3D 0, struct btf_enum *be =3D
> > > arg_fmt->btf_entry.entries; i < arg_fmt->btf_entry.nr_entries; ++i,
> > > ++be) {
> > >       |                         ^~~~~~
> > > builtin-trace.c:996:117: error: =E2=80=98be=E2=80=99 undeclared (firs=
t use in this
> > > function); did you mean =E2=80=98bf=E2=80=99?
> > >   996 |         for (int i =3D 0, struct btf_enum *be =3D
> > > arg_fmt->btf_entry.entries; i < arg_fmt->btf_entry.nr_entries; ++i,
> > > ++be) {
> > >       |
> > >                                                      ^~
> > >       |
> > >                                                      bf
> > > builtin-trace.c:996:117: note: each undeclared identifier is reported
> > > only once for each function it appears in
> > >
> > > This is not good either:
> > >
> > > for (int i =3D 0, be =3D arg_fmt->btf_entry.entries; i <
> > > arg_fmt->btf_entry.nr_entries; ++i, ++be) {
> > >
> > > builtin-trace.c: In function =E2=80=98btf_enum_scnprintf=E2=80=99:
> > > builtin-trace.c:998:25: error: declaration of =E2=80=98be=E2=80=99 sh=
adows a previous
> > > local [-Werror=3Dshadow]
> > >   998 |         for (int i =3D 0, be =3D arg_fmt->btf_entry.entries; =
i <
> > > arg_fmt->btf_entry.nr_entries; ++i, ++be) {
> > >       |                         ^~
> > > builtin-trace.c:991:26: note: shadowed declaration is here
> > >   991 |         struct btf_enum *be;
> > >       |                          ^~
> > > builtin-trace.c:998:30: error: initialization of =E2=80=98int=E2=80=
=99 from =E2=80=98void *=E2=80=99
> > > makes integer from pointer without a cast [-Wint-conversion]
> > >   998 |         for (int i =3D 0, be =3D arg_fmt->btf_entry.entries; =
i <
> > > arg_fmt->btf_entry.nr_entries; ++i, ++be) {
> > >       |                              ^~~~~~~
> > >
> > > But I can do:
> > >
> > > ```
> > > be =3D arg_fmt->btf_entry.entries;
> > >
> > > for (int i =3D 0; i < arg_fmt->btf_entry.nr_entries; ++i, ++be) {
> > > ```
> > >
> > > Thanks,
> > > Howard
> > >
> > >
> > > > >
> > > > > =E2=AC=A2[acme@toolbox perf-tools-next]$ git grep 'for (int ' too=
ls/perf/ | wc -l
> > > > > 99
> > > > > =E2=AC=A2[acme@toolbox perf-tools-next]$
> > > > >
> > > > > Doing it this way makes the code more compact and is allowed even=
 in
> > > > > kernel code since some time ago:
> > > >
> > > > Sure.
> > > >
> > > > >
> > > > > =E2=AC=A2[acme@toolbox perf-tools-next]$ git grep 'for (int ' dri=
vers/ | wc -l
> > > > > 294
> > > > > =E2=AC=A2[acme@toolbox perf-tools-next]$ git grep 'for (int ' ker=
nel/ | wc -l
> > > > > 12
> > > > > =E2=AC=A2[acme@toolbox perf-tools-next]$ git grep 'for (int ' net=
/ | wc -l
> > > > > 3
> > > > > =E2=AC=A2[acme@toolbox perf-tools-next]$ git grep 'for (int ' mm/=
 | wc -l
> > > > > 21
> > > > > =E2=AC=A2[acme@toolbox perf-tools-next]$
> > > > >
> > > > > > +             if (be->val =3D=3D val) {
> > > > > > +                     return scnprintf(bf, size, "%s",
> > > > > > +                                      btf__name_by_offset(btf,=
 be->name_off));
> > > > > > +             }
> > > > > > +     }
> > > > > > +
> > > > > > +     return 0;
> > > > > > +}
> > > > > > +
> > > > > >  #include "trace/beauty/arch_errno_names.c"
> > > > > >  #include "trace/beauty/eventfd.c"
> > > > > >  #include "trace/beauty/futex_op.c"
> > > > > > @@ -1699,6 +1756,15 @@ static void trace__symbols__exit(struct =
trace *trace)
> > > > > >       symbol__exit();
> > > > > >  }
> > > > > >
> > > > > > +static void trace__load_vmlinux_btf(struct trace *trace)
> > > > > > +{
> > > > > > +     trace->btf =3D btf__load_vmlinux_btf();
> > > > > > +     if (verbose > 0) {
> > > > > > +             fprintf(trace->output, trace->btf ? "vmlinux BTF =
loaded\n" :
> > > > > > +                                                 "Failed to lo=
ad vmlinux BTF\n");
> > > > > > +     }
> > > > > > +}
> > > > > > +
> > > > > >  static int syscall__alloc_arg_fmts(struct syscall *sc, int nr_=
args)
> > > > > >  {
> > > > > >       int idx;
> > > > > > @@ -1744,7 +1810,7 @@ static const struct syscall_arg_fmt *sysc=
all_arg_fmt__find_by_name(const char *n
> > > > > >  }
> > > > > >
> > > > > >  static struct tep_format_field *
> > > > > > -syscall_arg_fmt__init_array(struct syscall_arg_fmt *arg, struc=
t tep_format_field *field)
> > > > > > +syscall_arg_fmt__init_array(struct syscall_arg_fmt *arg, struc=
t tep_format_field *field, bool *use_btf)
> > > > > >  {
> > > > > >       struct tep_format_field *last_field =3D NULL;
> > > > > >       int len;
> > > > > > @@ -1782,6 +1848,8 @@ syscall_arg_fmt__init_array(struct syscal=
l_arg_fmt *arg, struct tep_format_field
> > > > > >                        * 7 unsigned long
> > > > > >                        */
> > > > > >                       arg->scnprintf =3D SCA_FD;
> > > > > > +             } else if (strstr(field->type, "enum") && use_btf=
 !=3D NULL) {
> > > > > > +                     *use_btf =3D arg->is_enum =3D true;
> > > > >
> > > > > Here you have to check if use_btf is NULL, as you, in this patch,=
 later
> > > > > call syscall_arg_fmt__init_array(arg, field, NULL) in
> > > > > evsel__init_tp_arg_scnprintf(), probably you tested it all at the=
 end of
> > > > > the patch series, we have to make sure that it works after each p=
atch,
> > > > > so that we keep the codebase bisectable.
> > > >
> > > > I'm sorry, could you enlighten me on this? I thought:
> > > > ```
> > > > else if (strstr(field->type, "enum") && use_btf !=3D NULL) {
> > > > ```
> > > > is doing the NULL checking. If you mean making sure the NULL checki=
ng
> > > > appears in all patches, I thought this is where we should introduce
> > > > the checking. Tiny reminder, the [1/5] patch is your syscalltbl
> > > > traversal bug fix.
> > > >
> > > > >
> > > > > >               } else {
> > > > > >                       const struct syscall_arg_fmt *fmt =3D
> > > > > >                               syscall_arg_fmt__find_by_name(fie=
ld->name);
> > > > > > @@ -1796,9 +1864,10 @@ syscall_arg_fmt__init_array(struct sysca=
ll_arg_fmt *arg, struct tep_format_field
> > > > > >       return last_field;
> > > > > >  }
> > > > > >
> > > > > > -static int syscall__set_arg_fmts(struct syscall *sc)
> > > > > > +static int syscall__set_arg_fmts(struct syscall *sc, bool *use=
_btf)
> > > > > >  {
> > > > > > -     struct tep_format_field *last_field =3D syscall_arg_fmt__=
init_array(sc->arg_fmt, sc->args);
> > > > > > +     struct tep_format_field *last_field =3D syscall_arg_fmt__=
init_array(sc->arg_fmt, sc->args,
> > > > > > +                                                              =
         use_btf);
> > > > > >
> > > > > >       if (last_field)
> > > > > >               sc->args_size =3D last_field->offset + last_field=
->size;
> > > > > > @@ -1810,7 +1879,9 @@ static int trace__read_syscall_info(struc=
t trace *trace, int id)
> > > > > >  {
> > > > > >       char tp_name[128];
> > > > > >       struct syscall *sc;
> > > > > > +     int err;
> > > > > >       const char *name =3D syscalltbl__name(trace->sctbl, id);
> > > > > > +     bool use_btf =3D false;
> > > > > >
> > > > > >  #ifdef HAVE_SYSCALL_TABLE_SUPPORT
> > > > > >       if (trace->syscalls.table =3D=3D NULL) {
> > > > > > @@ -1883,7 +1954,12 @@ static int trace__read_syscall_info(stru=
ct trace *trace, int id)
> > > > > >       sc->is_exit =3D !strcmp(name, "exit_group") || !strcmp(na=
me, "exit");
> > > > > >       sc->is_open =3D !strcmp(name, "open") || !strcmp(name, "o=
penat");
> > > > > >
> > > > > > -     return syscall__set_arg_fmts(sc);
> > > > > > +     err =3D syscall__set_arg_fmts(sc, &use_btf);
> > > > > > +
> > > > > > +     if (use_btf && trace->btf =3D=3D NULL)
> > > > > > +             trace__load_vmlinux_btf(trace);
> > > > > > +
> > > > > > +     return err;
> > > > > >  }
> > > > > >
> > > > > >  static int evsel__init_tp_arg_scnprintf(struct evsel *evsel)
> > > > > > @@ -1891,7 +1967,7 @@ static int evsel__init_tp_arg_scnprintf(s=
truct evsel *evsel)
> > > > > >       struct syscall_arg_fmt *fmt =3D evsel__syscall_arg_fmt(ev=
sel);
> > > > > >
> > > > > >       if (fmt !=3D NULL) {
> > > > > > -             syscall_arg_fmt__init_array(fmt, evsel->tp_format=
->format.fields);
> > > > > > +             syscall_arg_fmt__init_array(fmt, evsel->tp_format=
->format.fields, NULL);
> > > > > >               return 0;
> > > > > >       }
> > > > > >
> > > > > > @@ -2103,6 +2179,16 @@ static size_t syscall__scnprintf_args(st=
ruct syscall *sc, char *bf, size_t size,
> > > > > >                       if (trace->show_arg_names)
> > > > > >                               printed +=3D scnprintf(bf + print=
ed, size - printed, "%s: ", field->name);
> > > > > >
> > > > > > +                     if (sc->arg_fmt[arg.idx].is_enum && trace=
->btf) {
> > > > > > +                             size_t p =3D btf_enum_scnprintf(b=
f + printed, size - printed, val,
> > > > > > +                                                           tra=
ce->btf, field->type,
> > > > > > +                                                           &sc=
->arg_fmt[arg.idx]);
> > > > > > +                             if (p) {
> > > > > > +                                     printed +=3D p;
> > > > > > +                                     continue;
> > > > > > +                             }
> > > > > > +                     }
> > > > > > +
> > > > > >                       printed +=3D syscall_arg_fmt__scnprintf_v=
al(&sc->arg_fmt[arg.idx],
> > > > > >                                                                =
 bf + printed, size - printed, &arg, val);
> > > > > >               }
> > > > > > --
> > > > > > 2.45.2
> > > > > >
> > > >
> > > > Thanks,
> > > > Howard
