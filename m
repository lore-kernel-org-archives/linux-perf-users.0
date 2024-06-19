Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F6955884;
	Wed, 19 Jun 2024 17:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718819990; cv=none; b=lmDZg+YBwDdd7TME/XoV73OQPoE/svS26ZpN8DlujtiiRFWRAHLsR9XhMqDivoAf2S9TBopIBPYZyJmXo1zmkbi6fH04aqjJUPYZv+ChKee0JExVXmZAJFWHeQx3EgLsQQZSKiDtfi8wvAtURUzP4EUiXS8fZsPZc3BQrR7ShDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718819990; c=relaxed/simple;
	bh=MRxQH7jc60bamFYUV1mnjkSvceoQHvZzsjcbBvOTmg8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KSYJxtAAIeUgHba2j149mfMhBc33c19jlo4/MWAIm1wwvI+K1TIcgUKhShq79K5c+8WaihX8tV2iIATGSZz1X1pA38ZLMdAVpoN1CzxlYfYXCvq394IawOLkTVbaR6u8M+231joRRSjdA+/H5Vq9OkFVgJIhXAZLq9Z3nZCvh5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TUjqocRl; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TUjqocRl"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dfe41f7852cso37265276.1;
        Wed, 19 Jun 2024 10:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718819987; x=1719424787; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yh6SELLxS74xotWhYGb10CwkHQAzhtYrWYT84oO1EEo=;
        b=TUjqocRlci2yLZ7cG15PCCj6j5WL1FoAIe8PC9wS50Wiu5HB4nf/8/x72x2dLGO+vw
         E8IdKoRHIJyjlpOw5uVw1tjzxVeuw1GonJgNWdFemEZ5VGArV6U6VDqYN+SACC2gXOSD
         enQ7DBMRoLbz1mtMX4HM4aAMNLzbD9Ff1JeJ5BXPoYoKxjU5BTk7zH/bZ7Uh0iRiC80A
         qphSB/gzkl76/8+9542rQ17T/fXqCBqZ8ohwTCYALLn5qbLE6N1vgOtmbxZiq/1zYVmw
         pbBv1gU26AI51AOIt0B35h6HcAbWT7b17QiXYGUuUOxqLWPgn8K+0um1oCuURXRY+kkB
         bPXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718819987; x=1719424787;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yh6SELLxS74xotWhYGb10CwkHQAzhtYrWYT84oO1EEo=;
        b=B7keYysvWfJ2fLLUI6CdtAr1WNHC/erME/45nQRziFOlz95VxJqLPTEdFwbDChvtjn
         WKqzaFKyriRqVgyOoQMqtKk/FVLbCjEaG5OhXr0LJdWRUPmnQh/gG4wa9/7n3mJZKqi2
         MuDduRW36STFyG0/SoMNg7TNtI/lazd6XuQSCSu4//fqmxpjn8p7oZa65HTdPsXEm/hd
         wIdlb93rFltZKbCb/iy7fRoz+cF8X/sxQVoDm5dDpLf6Sds7HnHkhZXSbjxgWHqLgbCK
         jr+biQUCXyDgD42nBpIbNz26T/kJsglRh8FEv8ftAgXwiAa1ZkoR4jIdAcmCXtHMSG71
         kMjA==
X-Forwarded-Encrypted: i=1; AJvYcCUuRgtjlxDnqqOU+uAPqChNRGiWarO0AGWEu4P9cJXs12lIoYxtLlYQN53mvVerIF1WSPQrc8FWH8SkpYON1cYSaFuK9w/P0LyX0JyCxPfRclA/1SVL+spDn5AJk2eKGt8VdAkjE7PC7XXxKhwqHA==
X-Gm-Message-State: AOJu0YzyAHAG8A2+DQIz/6eJ6569cuEdujjt89aksBTlaNJ0UtsW2Do/
	mmZBhqab2jmzIZEJunSx956TjJrNWqqQPHA5psTb1eJBxc08Q+kVKp8gmXGm1GXd+SgT/2HfzPA
	LAG4bbDJ7EkGo8g/VX5gdnInRPpo=
X-Google-Smtp-Source: AGHT+IH7X5VOgYS74U+X51Cbr9w88gzD41wpkrgOOxN9gZ6gaqX623RqnjMRxIH4QKZuTj8+9UYU6NG/AcP4zjAsYl8=
X-Received: by 2002:a5b:60c:0:b0:e02:b910:cb52 with SMTP id
 3f1490d57ef6-e02be2475d0mr3273276276.65.1718819986952; Wed, 19 Jun 2024
 10:59:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240619082042.4173621-1-howardchu95@gmail.com>
 <20240619082042.4173621-3-howardchu95@gmail.com> <ZnLgstTgrFRYu0aD@x1>
In-Reply-To: <ZnLgstTgrFRYu0aD@x1>
From: Howard Chu <howardchu95@gmail.com>
Date: Thu, 20 Jun 2024 01:59:37 +0800
Message-ID: <CAH0uvohKGrfwApZXfJZaWx4LQgPXct+uQ_N7snmqSo4VeCxVUA@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] perf trace: Augment enum syscall arguments with BTF
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

Thanks for the in-depth review.

On Wed, Jun 19, 2024 at 9:44=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Wed, Jun 19, 2024 at 04:20:39PM +0800, Howard Chu wrote:
> > This is a feature implemented on the basis of the previous bug fix
> > https://lore.kernel.org/linux-perf-users/d18a9606-ac9f-4ca7-afaf-fcf4c9=
51cb90@web.de/T/#t
> >
> > In this patch, BTF is used to turn enum value to the corresponding
> > enum variable name. There is only one system call that uses enum value
> > as its argument, that is `landlock_add_rule()`.
> >
> > The vmlinux btf is loaded lazily, when user decided to trace the
> > `landlock_add_rule` syscall. But if one decides to run `perf trace`
> > without any arguments, the behaviour is to trace `landlock_add_rule`,
> > so vmlinux btf will be loaded by default.
> >
> > before:
> >
> > ```
> > perf $ ./perf trace -e landlock_add_rule
> >      0.000 ( 0.008 ms): ldlck-test/438194 landlock_add_rule(rule_type: =
2)                                       =3D -1 EBADFD (File descriptor in =
bad state)
> >      0.010 ( 0.001 ms): ldlck-test/438194 landlock_add_rule(rule_type: =
1)                                       =3D -1 EBADFD (File descriptor in =
bad state)
> > ```
> >
> > after:
> >
> > ```
> > perf $ ./perf trace -e landlock_add_rule
> >      0.000 ( 0.029 ms): ldlck-test/438194 landlock_add_rule(rule_type: =
LANDLOCK_RULE_NET_PORT)                  =3D -1 EBADFD (File descriptor in =
bad state)
> >      0.036 ( 0.004 ms): ldlck-test/438194 landlock_add_rule(rule_type: =
LANDLOCK_RULE_PATH_BENEATH)              =3D -1 EBADFD (File descriptor in =
bad state)
> > ```
> > Tested-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> > Suggested-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> > Reviewed-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> > Signed-off-by: Howard Chu <howardchu95@gmail.com>
> > ---
> >  tools/perf/builtin-trace.c | 96 ++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 91 insertions(+), 5 deletions(-)
> >
> > diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> > index c4fa8191253d..d93f34e9af74 100644
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
> > @@ -110,6 +111,11 @@ struct syscall_arg_fmt {
> >       const char *name;
> >       u16        nr_entries; // for arrays
> >       bool       show_zero;
> > +     bool       is_enum;
> > +     struct {
> > +             void    *entries;
> > +             u16     nr_entries;
> > +     }          btf_entry;
> >  };
> >
> >  struct syscall_fmt {
> > @@ -140,6 +146,7 @@ struct trace {
> >  #ifdef HAVE_BPF_SKEL
> >       struct augmented_raw_syscalls_bpf *skel;
> >  #endif
> > +     struct btf              *btf;
> >       struct record_opts      opts;
> >       struct evlist   *evlist;
> >       struct machine          *host;
> > @@ -897,6 +904,56 @@ static size_t syscall_arg__scnprintf_getrandom_fla=
gs(char *bf, size_t size,
> >           .strtoul    =3D STUL_STRARRAY_FLAGS, \
> >           .parm       =3D &strarray__##array, }
> >
> > +static int btf_enum_find_entry(struct btf *btf, char *type, struct sys=
call_arg_fmt *arg_fmt)
> > +{
> > +     const struct btf_type *bt;
> > +     char enum_prefix[][16] =3D { "enum", "const enum" }, *ep;
> > +     int id;
> > +     size_t i;
> > +
> > +     for (i =3D 0; i < ARRAY_SIZE(enum_prefix); i++) {
> > +             ep =3D enum_prefix[i];
> > +             if (strlen(type) > strlen(ep) + 1 && strstarts(type, ep))
>
> No need for the strlen test? I.e. plain using strstarts() should be
> enough?

Agree. Thanks for pointing that out. Although if string 'type' is
'enum' and prefix is 'enum', strstarts() will be true, but to do 'type
+=3D strlen(ep) + 1', and then access 'type', might give us an
out-of-range access, but I don't think 'type' will ever be just 'enum'
or 'const enum', so I'll delete it then.

>
> > +                     type +=3D strlen(ep) + 1;
> > +     }
> > +
> > +     id =3D btf__find_by_name(btf, type);
> > +     if (id < 0)
> > +             return -1;
> > +
> > +     bt =3D btf__type_by_id(btf, id);
> > +     if (bt =3D=3D NULL)
>
> a pr_debug() stating that something that tracefs says should be in BTF
> and isn't found there seems to be of value here.

Sure.

>
> > +             return -1;
> > +
> > +     arg_fmt->btf_entry.entries    =3D btf_enum(bt);
> > +     arg_fmt->btf_entry.nr_entries =3D btf_vlen(bt);
> > +
> > +     return 0;
> > +}
> > +
> > +static size_t btf_enum_scnprintf(char *bf, size_t size, int val, struc=
t btf *btf, char *type,
> > +                              struct syscall_arg_fmt *arg_fmt)
> > +{
> > +     struct btf_enum *be;
> > +     int i;
> > +
> > +     /* if btf_entry is NULL, find and save it to arg_fmt */
> > +     if (arg_fmt->btf_entry.entries =3D=3D NULL)
> > +             if (btf_enum_find_entry(btf, type, arg_fmt))
> > +                     return 0;
> > +
> > +     be =3D (struct btf_enum *)arg_fmt->btf_entry.entries;
>
>         struct btf_enum *be =3D (struct btf_enum *)arg_fmt->btf_entry.ent=
ries;
>
>  arg_fmt->btf_entry.entries is (void *), so we don't need the (struct
> btf_enum *) cast here, removing it makes the code more compact. And
> since we move the declaration to the same line, the info about its type
> is there as well.

Sure, thanks.

>
> > +
> > +     for (i =3D 0; i < arg_fmt->btf_entry.nr_entries; ++i, ++be) {
>
>
>         for (int i =3D 0; i < arg_fmt->btf_entry.nr_entries; ++i, ++be) {
>
> =E2=AC=A2[acme@toolbox perf-tools-next]$ git grep 'for (int ' tools/perf/=
 | wc -l
> 99
> =E2=AC=A2[acme@toolbox perf-tools-next]$
>
> Doing it this way makes the code more compact and is allowed even in
> kernel code since some time ago:

Sure.

>
> =E2=AC=A2[acme@toolbox perf-tools-next]$ git grep 'for (int ' drivers/ | =
wc -l
> 294
> =E2=AC=A2[acme@toolbox perf-tools-next]$ git grep 'for (int ' kernel/ | w=
c -l
> 12
> =E2=AC=A2[acme@toolbox perf-tools-next]$ git grep 'for (int ' net/ | wc -=
l
> 3
> =E2=AC=A2[acme@toolbox perf-tools-next]$ git grep 'for (int ' mm/ | wc -l
> 21
> =E2=AC=A2[acme@toolbox perf-tools-next]$
>
> > +             if (be->val =3D=3D val) {
> > +                     return scnprintf(bf, size, "%s",
> > +                                      btf__name_by_offset(btf, be->nam=
e_off));
> > +             }
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> >  #include "trace/beauty/arch_errno_names.c"
> >  #include "trace/beauty/eventfd.c"
> >  #include "trace/beauty/futex_op.c"
> > @@ -1699,6 +1756,15 @@ static void trace__symbols__exit(struct trace *t=
race)
> >       symbol__exit();
> >  }
> >
> > +static void trace__load_vmlinux_btf(struct trace *trace)
> > +{
> > +     trace->btf =3D btf__load_vmlinux_btf();
> > +     if (verbose > 0) {
> > +             fprintf(trace->output, trace->btf ? "vmlinux BTF loaded\n=
" :
> > +                                                 "Failed to load vmlin=
ux BTF\n");
> > +     }
> > +}
> > +
> >  static int syscall__alloc_arg_fmts(struct syscall *sc, int nr_args)
> >  {
> >       int idx;
> > @@ -1744,7 +1810,7 @@ static const struct syscall_arg_fmt *syscall_arg_=
fmt__find_by_name(const char *n
> >  }
> >
> >  static struct tep_format_field *
> > -syscall_arg_fmt__init_array(struct syscall_arg_fmt *arg, struct tep_fo=
rmat_field *field)
> > +syscall_arg_fmt__init_array(struct syscall_arg_fmt *arg, struct tep_fo=
rmat_field *field, bool *use_btf)
> >  {
> >       struct tep_format_field *last_field =3D NULL;
> >       int len;
> > @@ -1782,6 +1848,8 @@ syscall_arg_fmt__init_array(struct syscall_arg_fm=
t *arg, struct tep_format_field
> >                        * 7 unsigned long
> >                        */
> >                       arg->scnprintf =3D SCA_FD;
> > +             } else if (strstr(field->type, "enum") && use_btf !=3D NU=
LL) {
> > +                     *use_btf =3D arg->is_enum =3D true;
>
> Here you have to check if use_btf is NULL, as you, in this patch, later
> call syscall_arg_fmt__init_array(arg, field, NULL) in
> evsel__init_tp_arg_scnprintf(), probably you tested it all at the end of
> the patch series, we have to make sure that it works after each patch,
> so that we keep the codebase bisectable.

I'm sorry, could you enlighten me on this? I thought:
```
else if (strstr(field->type, "enum") && use_btf !=3D NULL) {
```
is doing the NULL checking. If you mean making sure the NULL checking
appears in all patches, I thought this is where we should introduce
the checking. Tiny reminder, the [1/5] patch is your syscalltbl
traversal bug fix.

>
> >               } else {
> >                       const struct syscall_arg_fmt *fmt =3D
> >                               syscall_arg_fmt__find_by_name(field->name=
);
> > @@ -1796,9 +1864,10 @@ syscall_arg_fmt__init_array(struct syscall_arg_f=
mt *arg, struct tep_format_field
> >       return last_field;
> >  }
> >
> > -static int syscall__set_arg_fmts(struct syscall *sc)
> > +static int syscall__set_arg_fmts(struct syscall *sc, bool *use_btf)
> >  {
> > -     struct tep_format_field *last_field =3D syscall_arg_fmt__init_arr=
ay(sc->arg_fmt, sc->args);
> > +     struct tep_format_field *last_field =3D syscall_arg_fmt__init_arr=
ay(sc->arg_fmt, sc->args,
> > +                                                                      =
 use_btf);
> >
> >       if (last_field)
> >               sc->args_size =3D last_field->offset + last_field->size;
> > @@ -1810,7 +1879,9 @@ static int trace__read_syscall_info(struct trace =
*trace, int id)
> >  {
> >       char tp_name[128];
> >       struct syscall *sc;
> > +     int err;
> >       const char *name =3D syscalltbl__name(trace->sctbl, id);
> > +     bool use_btf =3D false;
> >
> >  #ifdef HAVE_SYSCALL_TABLE_SUPPORT
> >       if (trace->syscalls.table =3D=3D NULL) {
> > @@ -1883,7 +1954,12 @@ static int trace__read_syscall_info(struct trace=
 *trace, int id)
> >       sc->is_exit =3D !strcmp(name, "exit_group") || !strcmp(name, "exi=
t");
> >       sc->is_open =3D !strcmp(name, "open") || !strcmp(name, "openat");
> >
> > -     return syscall__set_arg_fmts(sc);
> > +     err =3D syscall__set_arg_fmts(sc, &use_btf);
> > +
> > +     if (use_btf && trace->btf =3D=3D NULL)
> > +             trace__load_vmlinux_btf(trace);
> > +
> > +     return err;
> >  }
> >
> >  static int evsel__init_tp_arg_scnprintf(struct evsel *evsel)
> > @@ -1891,7 +1967,7 @@ static int evsel__init_tp_arg_scnprintf(struct ev=
sel *evsel)
> >       struct syscall_arg_fmt *fmt =3D evsel__syscall_arg_fmt(evsel);
> >
> >       if (fmt !=3D NULL) {
> > -             syscall_arg_fmt__init_array(fmt, evsel->tp_format->format=
.fields);
> > +             syscall_arg_fmt__init_array(fmt, evsel->tp_format->format=
.fields, NULL);
> >               return 0;
> >       }
> >
> > @@ -2103,6 +2179,16 @@ static size_t syscall__scnprintf_args(struct sys=
call *sc, char *bf, size_t size,
> >                       if (trace->show_arg_names)
> >                               printed +=3D scnprintf(bf + printed, size=
 - printed, "%s: ", field->name);
> >
> > +                     if (sc->arg_fmt[arg.idx].is_enum && trace->btf) {
> > +                             size_t p =3D btf_enum_scnprintf(bf + prin=
ted, size - printed, val,
> > +                                                           trace->btf,=
 field->type,
> > +                                                           &sc->arg_fm=
t[arg.idx]);
> > +                             if (p) {
> > +                                     printed +=3D p;
> > +                                     continue;
> > +                             }
> > +                     }
> > +
> >                       printed +=3D syscall_arg_fmt__scnprintf_val(&sc->=
arg_fmt[arg.idx],
> >                                                                 bf + pr=
inted, size - printed, &arg, val);
> >               }
> > --
> > 2.45.2
> >

Thanks,
Howard
