Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA3F1946C0
	for <linux-perf-users@vger.kernel.org>; Wed, 10 Jul 2024 17:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720634078; cv=none; b=SIcw39GH/odHuXTIO64dxbhRja9Hte/NCsMzxhlCTMMJnlhJO2FNKI+jfRxdpiRkMEFxphgIp34KHLgREocIHSYbgRX+hzLQKdbTUw1Hg9N1xC2dOatCdkB1Jo/A6tJwUgTX5fhAlG+0afJ6z4yB+DmuiQjZaNED+GwSD0tqL5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720634078; c=relaxed/simple;
	bh=ZjsNflWB9Z5qZ0spC1jxa5ghtseXGjGAnwqKwtcojhQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aB+QwMH2KJmZM1yeaRvDvmaebfRLlsU22M6oKDiEEJ8HujIx5KA6VKIRz8/Kw0hZ1Qn1RZHuaKRQaGJzW6usZO/h56gPrBC0kJg7JCllH2K5iHeHTl1G8Jbm5nlxyLb3fH7UpT18IJks4HnR5SXMmDsb+RlOaIuQUWgjvIKgI0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fW6Q55g+; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fW6Q55g+"
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-375fc24a746so8995ab.1
        for <linux-perf-users@vger.kernel.org>; Wed, 10 Jul 2024 10:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720634075; x=1721238875; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KmVBxcbeVErx9eYXuCL8/5Jp4OD7I2ZrFBAEmqKfUp8=;
        b=fW6Q55g+3RNmauxQyHr/1254+GI0GLvW+341qN5s9vFTwWszDiUDns9gm/8cwC+560
         poTL1KtUHITDGg2mzf/or9+OGLdH5YyZA9OS4azvrqh1UshRQzB67nf87V4NJqbWPYB2
         TtpQevILxQ8+Y8k4h2sTVQnRzdI72MzaSnr4/vgO+xI9PjS1p5pLrNAAwe/CK/MSYsAb
         q64y6FnfT7oPCf0Mz8CIIS6K2nXQlkHp2c7EhlAiXuDXTTKNC/sLBfiU4S716iKx9oBT
         uY3pHbBqtRoQo0qOHY3lK9DIi439cz4RWynG2faH5fucEd1cPmLF9Ggr9d+51nhwVjVy
         mPvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720634075; x=1721238875;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KmVBxcbeVErx9eYXuCL8/5Jp4OD7I2ZrFBAEmqKfUp8=;
        b=dvCTZ3/a+x0YJQ8Tjq+jKTYBboEC02SB+Riuhig5Tk483L7zPLHNutsCR0/a3Sk4Lv
         TwDq5GlMG6ybPthtlvTN8xjmwDl/g6x5A7aqRJbDyfdjc8kpyjM8+4554sLBvTNC/YC+
         ZRJTPuxWQwe8OBN55RpxZm/3dV9O4ACetZ6X9Mj4w2zv4vhAbRLo0SVJMxDgU3knwxt3
         R8eals6xdvIPpO6KwBxEYI0xTLIhAvaFxkxaLud2kg+NnUZXaUVYF8isAKmJdt43/1PQ
         jELC4DGRDBG2Gwll7sEY7+HxzvYQ7NFKP2b4MTCkFgK21/CtS4byLfxpk4Uj36WysDj+
         A9GA==
X-Forwarded-Encrypted: i=1; AJvYcCX4RduaRCtQgaT5uwkMILIJURsBI1SfPClsEvf6yRtN4l1hmty4ARiN+OfiyPpdFnHueaJuwJi3aiO5CU/8ZTKt0LRAPNak15ADyA7EjRBfjA==
X-Gm-Message-State: AOJu0Yyp7QP/D2CGTIIQsZAgOjK6GU46fQlLV2qc8ptyaFti/doL/sKK
	VNPTpnPhK66Gy4y8I6Z/00+PuyUO9MJxAFPYrWjKoJZlDtvi6JDgIpZGzO9xmhOoCYPAJ1pxeQs
	DGEbDOGovIU+yeS9zNlw3+RD/WrPzg6YktwGW
X-Google-Smtp-Source: AGHT+IEMika+iJj1Pwb12qjGxJQxfhdV6XvoexN6ravMRpHdsNu5c9Lklkmi4efMRPsxJQC/LmufLGZTlk01gIOfHhE=
X-Received: by 2002:a05:6e02:1a46:b0:38b:4342:79c8 with SMTP id
 e9e14a558f8ab-38d2ce67ab8mr2635ab.21.1720634075234; Wed, 10 Jul 2024 10:54:35
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240705094300.585156-1-howardchu95@gmail.com> <20240705094300.585156-3-howardchu95@gmail.com>
In-Reply-To: <20240705094300.585156-3-howardchu95@gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 10 Jul 2024 10:54:24 -0700
Message-ID: <CAP-5=fXyoLBmtftkYheLQTQeceK7ZBB8NLv4bFEdYOBUTO9yGw@mail.gmail.com>
Subject: Re: [PATCH v5 2/8] perf trace: BTF-based enum pretty printing for
 syscall args
To: Howard Chu <howardchu95@gmail.com>
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

On Fri, Jul 5, 2024 at 2:43=E2=80=AFAM Howard Chu <howardchu95@gmail.com> w=
rote:
>
> In this patch, BTF is used to turn enum value to the corresponding
> name. There is only one system call that uses enum value as its
> argument, that is `landlock_add_rule()`.
>
> The vmlinux btf is loaded lazily, when user decided to trace the
> `landlock_add_rule` syscall. But if one decide to run `perf trace`
> without any arguments, the behaviour is to trace `landlock_add_rule`,
> so vmlinux btf will be loaded by default.
>
> The laziest behaviour is to load vmlinux btf when a
> `landlock_add_rule` syscall hits. But I think you could lose some
> samples when loading vmlinux btf at run time, for it can delay the
> handling of other samples. I might need your precious opinions on
> this...
>
> before:
>
> ```
> perf $ ./perf trace -e landlock_add_rule
>      0.000 ( 0.008 ms): ldlck-test/438194 landlock_add_rule(rule_type: 2)=
 =3D -1 EBADFD (File descriptor in bad state)
>      0.010 ( 0.001 ms): ldlck-test/438194 landlock_add_rule(rule_type: 1)=
 =3D -1 EBADFD (File descriptor in bad state)
> ```
>
> after:
>
> ```
> perf $ ./perf trace -e landlock_add_rule
>      0.000 ( 0.029 ms): ldlck-test/438194 landlock_add_rule(rule_type: LA=
NDLOCK_RULE_NET_PORT)     =3D -1 EBADFD (File descriptor in bad state)
>      0.036 ( 0.004 ms): ldlck-test/438194 landlock_add_rule(rule_type: LA=
NDLOCK_RULE_PATH_BENEATH) =3D -1 EBADFD (File descriptor in bad state)
> ```
>
> Committer notes:
>
> Made it build with NO_LIBBPF=3D1, simplified btf_enum_fprintf(), see [1]
> for the discussion.
>
> Signed-off-by: Howard Chu <howardchu95@gmail.com>
> Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: G=C3=BCnther Noack <gnoack@google.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Kan Liang <kan.liang@linux.intel.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Link: https://lore.kernel.org/lkml/20240613022757.3589783-1-howardchu95@g=
mail.com
> Link: https://lore.kernel.org/lkml/ZnXAhFflUl_LV1QY@x1 # [1]
> Link: https://lore.kernel.org/r/20240624181345.124764-3-howardchu95@gmail=
.com
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/builtin-trace.c | 110 +++++++++++++++++++++++++++++++++++--
>  1 file changed, 106 insertions(+), 4 deletions(-)
>
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index 8449f2beb54d..1391564911d9 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -19,6 +19,7 @@
>  #ifdef HAVE_LIBBPF_SUPPORT
>  #include <bpf/bpf.h>
>  #include <bpf/libbpf.h>
> +#include <bpf/btf.h>
>  #ifdef HAVE_BPF_SKEL
>  #include "bpf_skel/augmented_raw_syscalls.skel.h"
>  #endif
> @@ -110,6 +111,10 @@ struct syscall_arg_fmt {
>         const char *name;
>         u16        nr_entries; // for arrays
>         bool       show_zero;
> +       bool       is_enum;
> +#ifdef HAVE_LIBBPF_SUPPORT
> +       const struct btf_type *type;
> +#endif
>  };
>
>  struct syscall_fmt {
> @@ -139,6 +144,9 @@ struct trace {
>         } syscalls;
>  #ifdef HAVE_BPF_SKEL
>         struct augmented_raw_syscalls_bpf *skel;
> +#endif
> +#ifdef HAVE_LIBBPF_SUPPORT
> +       struct btf              *btf;
>  #endif
>         struct record_opts      opts;
>         struct evlist   *evlist;
> @@ -204,6 +212,20 @@ struct trace {
>         } oe;
>  };
>
> +static void trace__load_vmlinux_btf(struct trace *trace __maybe_unused)
> +{
> +#ifdef HAVE_LIBBPF_SUPPORT
> +       if (trace->btf !=3D NULL)
> +               return;
> +
> +       trace->btf =3D btf__load_vmlinux_btf();
> +       if (verbose > 0) {
> +               fprintf(trace->output, trace->btf ? "vmlinux BTF loaded\n=
" :
> +                                                   "Failed to load vmlin=
ux BTF\n");
> +       }
> +#endif
> +}
> +
>  struct tp_field {
>         int offset;
>         union {
> @@ -887,6 +909,64 @@ static size_t syscall_arg__scnprintf_getrandom_flags=
(char *bf, size_t size,
>
>  #define SCA_GETRANDOM_FLAGS syscall_arg__scnprintf_getrandom_flags
>
> +#ifdef HAVE_LIBBPF_SUPPORT
> +static int syscall_arg_fmt__cache_btf_enum(struct syscall_arg_fmt *arg_f=
mt, struct btf *btf, char *type)
> +{
> +       int id;
> +
> +       // Already cached?

Hi Howard,

I'm on nit patrol again, just to note that most comments are /* */
style although we do have // comments - the ratio of /* */ to // is
about 10:1. The kernel is similar in this regard. There's no clear
guidance so we could ignore this, but fwiw I generally try to stick
with /* */ for consistency with the rest of the surrounding code.

Thanks,
Ian
> +       if (arg_fmt->type !=3D NULL)
> +               return 0;
> +
> +       type =3D strstr(type, "enum ");
> +       if (type =3D=3D NULL)
> +               return -1;
> +
> +       type +=3D 5; // skip "enum " to get the enumeration name
> +
> +       id =3D btf__find_by_name(btf, type);
> +       if (id < 0)
> +               return -1;
> +
> +       arg_fmt->type =3D btf__type_by_id(btf, id);
> +       return arg_fmt->type =3D=3D NULL ? -1 : 0;
> +}
> +
> +static size_t btf_enum_scnprintf(const struct btf_type *type, struct btf=
 *btf, char *bf, size_t size, int val)
> +{
> +       struct btf_enum *be =3D btf_enum(type);
> +       const int nr_entries =3D btf_vlen(type);
> +
> +       for (int i =3D 0; i < nr_entries; ++i, ++be) {
> +               if (be->val =3D=3D val) {
> +                       return scnprintf(bf, size, "%s",
> +                                        btf__name_by_offset(btf, be->nam=
e_off));
> +               }
> +       }
> +
> +       return 0;
> +}
> +
> +static size_t trace__btf_enum_scnprintf(struct trace *trace, struct sysc=
all_arg_fmt *arg_fmt, char *bf,
> +                                       size_t size, int val, char *type)
> +{
> +       if (trace->btf =3D=3D NULL)
> +               return 0;
> +
> +       if (syscall_arg_fmt__cache_btf_enum(arg_fmt, trace->btf, type) < =
0)
> +               return 0;
> +
> +       return btf_enum_scnprintf(arg_fmt->type, trace->btf, bf, size, va=
l);
> +}
> +#else // HAVE_LIBBPF_SUPPORT
> +static size_t trace__btf_enum_scnprintf(struct trace *trace __maybe_unus=
ed, struct syscall_arg_fmt *arg_fmt __maybe_unused,
> +                                       char *bf __maybe_unused, size_t s=
ize __maybe_unused, int val __maybe_unused,
> +                                       char *type __maybe_unused)
> +{
> +       return 0;
> +}
> +#endif // HAVE_LIBBPF_SUPPORT
> +
>  #define STRARRAY(name, array) \
>           { .scnprintf  =3D SCA_STRARRAY, \
>             .strtoul    =3D STUL_STRARRAY, \
> @@ -1238,6 +1318,7 @@ struct syscall {
>         bool                is_exit;
>         bool                is_open;
>         bool                nonexistent;
> +       bool                use_btf;
>         struct tep_format_field *args;
>         const char          *name;
>         const struct syscall_fmt  *fmt;
> @@ -1744,7 +1825,8 @@ static const struct syscall_arg_fmt *syscall_arg_fm=
t__find_by_name(const char *n
>  }
>
>  static struct tep_format_field *
> -syscall_arg_fmt__init_array(struct syscall_arg_fmt *arg, struct tep_form=
at_field *field)
> +syscall_arg_fmt__init_array(struct syscall_arg_fmt *arg, struct tep_form=
at_field *field,
> +                           bool *use_btf)
>  {
>         struct tep_format_field *last_field =3D NULL;
>         int len;
> @@ -1756,6 +1838,7 @@ syscall_arg_fmt__init_array(struct syscall_arg_fmt =
*arg, struct tep_format_field
>                         continue;
>
>                 len =3D strlen(field->name);
> +               arg->is_enum =3D false;
>
>                 if (strcmp(field->type, "const char *") =3D=3D 0 &&
>                     ((len >=3D 4 && strcmp(field->name + len - 4, "name")=
 =3D=3D 0) ||
> @@ -1782,6 +1865,8 @@ syscall_arg_fmt__init_array(struct syscall_arg_fmt =
*arg, struct tep_format_field
>                          * 7 unsigned long
>                          */
>                         arg->scnprintf =3D SCA_FD;
> +               } else if (strstr(field->type, "enum") && use_btf !=3D NU=
LL) {
> +                       *use_btf =3D arg->is_enum =3D true;
>                 } else {
>                         const struct syscall_arg_fmt *fmt =3D
>                                 syscall_arg_fmt__find_by_name(field->name=
);
> @@ -1798,7 +1883,8 @@ syscall_arg_fmt__init_array(struct syscall_arg_fmt =
*arg, struct tep_format_field
>
>  static int syscall__set_arg_fmts(struct syscall *sc)
>  {
> -       struct tep_format_field *last_field =3D syscall_arg_fmt__init_arr=
ay(sc->arg_fmt, sc->args);
> +       struct tep_format_field *last_field =3D syscall_arg_fmt__init_arr=
ay(sc->arg_fmt, sc->args,
> +                                                                        =
 &sc->use_btf);
>
>         if (last_field)
>                 sc->args_size =3D last_field->offset + last_field->size;
> @@ -1811,6 +1897,7 @@ static int trace__read_syscall_info(struct trace *t=
race, int id)
>         char tp_name[128];
>         struct syscall *sc;
>         const char *name =3D syscalltbl__name(trace->sctbl, id);
> +       int err;
>
>  #ifdef HAVE_SYSCALL_TABLE_SUPPORT
>         if (trace->syscalls.table =3D=3D NULL) {
> @@ -1883,7 +1970,13 @@ static int trace__read_syscall_info(struct trace *=
trace, int id)
>         sc->is_exit =3D !strcmp(name, "exit_group") || !strcmp(name, "exi=
t");
>         sc->is_open =3D !strcmp(name, "open") || !strcmp(name, "openat");
>
> -       return syscall__set_arg_fmts(sc);
> +       err =3D syscall__set_arg_fmts(sc);
> +
> +       /* after calling syscall__set_arg_fmts() we'll know whether use_b=
tf is true */
> +       if (sc->use_btf)
> +               trace__load_vmlinux_btf(trace);
> +
> +       return err;
>  }
>
>  static int evsel__init_tp_arg_scnprintf(struct evsel *evsel)
> @@ -1891,7 +1984,7 @@ static int evsel__init_tp_arg_scnprintf(struct evse=
l *evsel)
>         struct syscall_arg_fmt *fmt =3D evsel__syscall_arg_fmt(evsel);
>
>         if (fmt !=3D NULL) {
> -               syscall_arg_fmt__init_array(fmt, evsel->tp_format->format=
.fields);
> +               syscall_arg_fmt__init_array(fmt, evsel->tp_format->format=
.fields, NULL);
>                 return 0;
>         }
>
> @@ -2103,6 +2196,15 @@ static size_t syscall__scnprintf_args(struct sysca=
ll *sc, char *bf, size_t size,
>                         if (trace->show_arg_names)
>                                 printed +=3D scnprintf(bf + printed, size=
 - printed, "%s: ", field->name);
>
> +                       if (sc->arg_fmt[arg.idx].is_enum) {
> +                               size_t p =3D trace__btf_enum_scnprintf(tr=
ace, &sc->arg_fmt[arg.idx], bf + printed,
> +                                                                    size=
 - printed, val, field->type);
> +                               if (p) {
> +                                       printed +=3D p;
> +                                       continue;
> +                               }
> +                       }
> +
>                         printed +=3D syscall_arg_fmt__scnprintf_val(&sc->=
arg_fmt[arg.idx],
>                                                                   bf + pr=
inted, size - printed, &arg, val);
>                 }
> --
> 2.45.2
>
