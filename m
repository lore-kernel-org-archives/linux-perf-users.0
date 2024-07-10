Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459DE848E
	for <linux-perf-users@vger.kernel.org>; Wed, 10 Jul 2024 17:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720633751; cv=none; b=nsbYbX1blZ98ocsTZXY/qLLFwVyvuoKYdvDkzMjOMzan8GJAQ2Cj4c4Vb0yn7o9y626Odlz2KemrrFsE6SH2Eijc+tmxCYc+UoMt0sNtjJVH587pNcX96TMsBO+IyRcQuQ11v50IRchmSTkuPfq4L9Jf5h0JvnEvxD9jCjyk6mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720633751; c=relaxed/simple;
	bh=Sfdc4NZvv/cBXpR3ob8R/UA36Z4F3Mx19Dbq3aeE5+c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JB/C8+pkmeP+/n/eUQ1Cn4o3ihxXROTCzq3PjVCvPOjQtGF4O67A5olS37TrrOz/p3tNmsRA3YaNVC1qmRMENEEshwyt+qO4Y20FA33e53u2VpcbvfL4HvDMEZAxREUheP4kNi3GUaAnIzKe87vM6hZ2z89/3IfVZHJVxMfILuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Xv9z/j3T; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xv9z/j3T"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1fb67f59805so14385ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 10 Jul 2024 10:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720633748; x=1721238548; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eopy7nJGqtMwtA6DCPPNfhPiypGuunPXZItDdpFX038=;
        b=Xv9z/j3TKf9VnAaqtpC4UKCXdilsLyEagMlkTjOI8VoaZjfutTOeXeyJdmCKuyA5fz
         iX7EgF44IaZjLmLwEAFVJB03uFl/yRM0ompVstoPmTTZqjqf5OLTo3RJWPE9jcPklZby
         pa9jXp/jA5TqMWQopJwuhjpMQrdy3CfuRNrlAMuMx7kEqPkL1yp9sOmtWa1AMluBxNzs
         VvrdkLGSDLiIa/yIcNAo/MurTVvLom2XfM8HpsPxr5vJm+4O1qe08H05IOopdkuBNHTk
         ZQ3kib8FY+bNsqKk0Q0G3n/wZinGYEISE5O3JHG2NzSwvKgWELcB7cLIyd5V1IJOiogp
         d3ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720633748; x=1721238548;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eopy7nJGqtMwtA6DCPPNfhPiypGuunPXZItDdpFX038=;
        b=KpN8shfP3fbbxOtxfxD0JAqL3DIyHEOj5F8SYtZANRZjTpIS965AAfVHg//bdxZtYQ
         fH4CEF20f58fUFp0b4Jga89c5gi++5iR+tDke/5+5piykrdD2VtJZ8hVEkOErqlQV9WB
         m4s6FRVLsCT+b1fd+zH7/pGliNyjFXCQWNwvgwd61+4lIU/ZXcKjCG+Q2qmzP/NI+3pi
         qFhGNM6RwADqiLJRis+5RddZVhAPE6JQTgcqdVmvzo+pO7vmdaHEGVb86OkvH9aLZQO1
         ACw0TUwHIgbjnPkluBC1GRxz2hGKeyxd58LKDpump6Z7cWAEqV9X0WYybKHd9j0XdzSY
         x1Rg==
X-Forwarded-Encrypted: i=1; AJvYcCVbWnKy474YZK5wjhRnA5TY6QJoJCxweHalV8JYlNSF3jBrLbOQvDJuOyXiyM6TMDwM28xzChW7xeDYp1eGYj2hDTukBCd9vmuzZMqRt3HCeg==
X-Gm-Message-State: AOJu0Yx796w2v7eQpon78oIYpXCoNe7hI0Sk8H0Grzx9B88Wk7S5qnhR
	O1Mgm4QAZ/afFh/4MVcgl3AaRbTShQYUFkZTgyL3ZwjLRdAa7+En+wuRpOp+8x2mAyNI5aKOq5i
	zaryhB9GKHuN2g9TC/PLgMjVF1UTlYutwxwvm
X-Google-Smtp-Source: AGHT+IG3ZGQl5ynCGjnZfBOtJ7/ejx7/me9AyQez3px1M6JZ5uXwt8rP1BeZK6BBBpN6CjGXZOVunjjPCK1s7JQ2HwM=
X-Received: by 2002:a17:902:7b89:b0:1f9:bc99:d94a with SMTP id
 d9443c01a7336-1fbdd4d6bc6mr18305ad.5.1720633748102; Wed, 10 Jul 2024 10:49:08
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240705094300.585156-1-howardchu95@gmail.com> <20240705094300.585156-5-howardchu95@gmail.com>
In-Reply-To: <20240705094300.585156-5-howardchu95@gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 10 Jul 2024 10:48:56 -0700
Message-ID: <CAP-5=fVhPDuvJ7=H=BggPbYcT7WrD8-yG=czPjnNiXWvt_Etmg@mail.gmail.com>
Subject: Re: [PATCH v5 4/8] perf trace: Filter enum arguments with enum names
To: Howard Chu <howardchu95@gmail.com>
Cc: acme@kernel.org, adrian.hunter@intel.com, jolsa@kernel.org, 
	kan.liang@linux.intel.com, namhyung@kernel.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Arnaldo Carvalho de Melo <acme@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
	Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 5, 2024 at 2:43=E2=80=AFAM Howard Chu <howardchu95@gmail.com> w=
rote:
>
> Before:
>
> perf $ ./perf trace -e timer:hrtimer_start --filter=3D'mode!=3DHRTIMER_MO=
DE_ABS_PINNED_HARD' --max-events=3D1
> No resolver (strtoul) for "mode" in "timer:hrtimer_start", can't set filt=
er "(mode!=3DHRTIMER_MODE_ABS_PINNED_HARD) && (common_pid !=3D 281988)"
>
> After:
>
> perf $ ./perf trace -e timer:hrtimer_start --filter=3D'mode!=3DHRTIMER_MO=
DE_ABS_PINNED_HARD' --max-events=3D1
>      0.000 :0/0 timer:hrtimer_start(hrtimer: 0xffff9498a6ca5f18, function=
: 0xffffffffa77a5be0, expires: 12351248764875, softexpires: 12351248764875,=
 mode: HRTIMER_MODE_ABS)
>
> && and ||:
>
> perf $ ./perf trace -e timer:hrtimer_start --filter=3D'mode !=3D HRTIMER_=
MODE_ABS_PINNED_HARD && mode !=3D HRTIMER_MODE_ABS' --max-events=3D1
>      0.000 Hyprland/534 timer:hrtimer_start(hrtimer: 0xffff9497801a84d0, =
function: 0xffffffffc04cdbe0, expires: 12639434638458, softexpires: 1263943=
3638458, mode: HRTIMER_MODE_REL)
>
> perf $ ./perf trace -e timer:hrtimer_start --filter=3D'mode =3D=3D HRTIME=
R_MODE_REL || mode =3D=3D HRTIMER_MODE_PINNED' --max-events=3D1
>      0.000 ldlck-test/60639 timer:hrtimer_start(hrtimer: 0xffffb16404ee7b=
f8, function: 0xffffffffa7790420, expires: 12772614418016, softexpires: 127=
72614368016, mode: HRTIMER_MODE_REL)
>
> Switching it up, using both enum name and integer value(--filter=3D'mode =
=3D=3D HRTIMER_MODE_ABS_PINNED_HARD || mode =3D=3D 0'):
>
> perf $ ./perf trace -e timer:hrtimer_start --filter=3D'mode =3D=3D HRTIME=
R_MODE_ABS_PINNED_HARD || mode =3D=3D 0' --max-events=3D3
>      0.000 :0/0 timer:hrtimer_start(hrtimer: 0xffff9498a6ca5f18, function=
: 0xffffffffa77a5be0, expires: 12601748739825, softexpires: 12601748739825,=
 mode: HRTIMER_MODE_ABS_PINNED_HARD)
>      0.036 :0/0 timer:hrtimer_start(hrtimer: 0xffff9498a6ca5f18, function=
: 0xffffffffa77a5be0, expires: 12518758748124, softexpires: 12518758748124,=
 mode: HRTIMER_MODE_ABS_PINNED_HARD)
>      0.172 tmux: server/41881 timer:hrtimer_start(hrtimer: 0xffffb164081e=
7838, function: 0xffffffffa7790420, expires: 12518768255836, softexpires: 1=
2518768205836, mode: HRTIMER_MODE_ABS)
>
> P.S.
> perf $ pahole hrtimer_mode
> enum hrtimer_mode {
>         HRTIMER_MODE_ABS             =3D 0,
>         HRTIMER_MODE_REL             =3D 1,
>         HRTIMER_MODE_PINNED          =3D 2,
>         HRTIMER_MODE_SOFT            =3D 4,
>         HRTIMER_MODE_HARD            =3D 8,
>         HRTIMER_MODE_ABS_PINNED      =3D 2,
>         HRTIMER_MODE_REL_PINNED      =3D 3,
>         HRTIMER_MODE_ABS_SOFT        =3D 4,
>         HRTIMER_MODE_REL_SOFT        =3D 5,
>         HRTIMER_MODE_ABS_PINNED_SOFT =3D 6,
>         HRTIMER_MODE_REL_PINNED_SOFT =3D 7,
>         HRTIMER_MODE_ABS_HARD        =3D 8,
>         HRTIMER_MODE_REL_HARD        =3D 9,
>         HRTIMER_MODE_ABS_PINNED_HARD =3D 10,
>         HRTIMER_MODE_REL_PINNED_HARD =3D 11,
> };
>
> Committer testing:
>
>   root@x1:~# perf trace -e timer:hrtimer_start --filter=3D'mode !=3D HRTI=
MER_MODE_ABS' --max-events=3D2
>        0.000 :0/0 timer:hrtimer_start(hrtimer: 0xffff8d4eff2a5050, functi=
on: 0xffffffff9e22ddd0, expires: 241502326000000, softexpires: 241502326000=
000, mode: HRTIMER_MODE_ABS_PINNED_HARD)
>   18446744073709.488 :0/0 timer:hrtimer_start(hrtimer: 0xffff8d4eff425050=
, function: 0xffffffff9e22ddd0, expires: 241501814000000, softexpires: 2415=
01814000000, mode: HRTIMER_MODE_ABS_PINNED_HARD)
>   root@x1:~# perf trace -e timer:hrtimer_start --filter=3D'mode !=3D HRTI=
MER_MODE_ABS && mode !=3D HRTIMER_MODE_ABS_PINNED_HARD' --max-events=3D2
>        0.000 podman/510644 timer:hrtimer_start(hrtimer: 0xffffa2024f5f7dd=
0, function: 0xffffffff9e2170c0, expires: 241530497418194, softexpires: 241=
530497368194, mode: HRTIMER_MODE_REL)
>       40.251 gnome-shell/2484 timer:hrtimer_start(hrtimer: 0xffff8d48bda1=
7650, function: 0xffffffffc0661550, expires: 241550528619247, softexpires: =
241550527619247, mode: HRTIMER_MODE_REL)
>   root@x1:~# perf trace -v -e timer:hrtimer_start --filter=3D'mode !=3D H=
RTIMER_MODE_ABS && mode !=3D HRTIMER_MODE_ABS_PINNED_HARD && mode !=3D HRTI=
MER_MODE_REL' --max-events=3D2
>   Using CPUID GenuineIntel-6-BA-3
>   vmlinux BTF loaded
>   <SNIP>
>   0
>   0xa
>   0x1
>   New filter for timer:hrtimer_start: (mode !=3D 0 && mode !=3D 0xa && mo=
de !=3D 0x1) && (common_pid !=3D 524049 && common_pid !=3D 4041)
>   mmap size 528384B
>   ^Croot@x1:~#
>
> Suggested-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> Signed-off-by: Howard Chu <howardchu95@gmail.com>
> Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Kan Liang <kan.liang@linux.intel.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Link: https://lore.kernel.org/lkml/ZnCcliuecJABD5FN@x1
> Link: https://lore.kernel.org/r/20240624181345.124764-5-howardchu95@gmail=
.com
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/builtin-trace.c | 62 ++++++++++++++++++++++++++++++++++----
>  1 file changed, 56 insertions(+), 6 deletions(-)
>
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index 5618feb7d01a..e664001d5ed7 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -932,6 +932,37 @@ static int syscall_arg_fmt__cache_btf_enum(struct sy=
scall_arg_fmt *arg_fmt, stru
>         return arg_fmt->type =3D=3D NULL ? -1 : 0;
>  }
>
> +static bool syscall_arg__strtoul_btf_enum(char *bf, size_t size, struct =
syscall_arg *arg, u64 *val)
> +{
> +       const struct btf_type *bt;
> +       char *type =3D arg->parm;
> +       struct btf_enum *be;
> +       struct btf *btf;
> +
> +       trace__load_vmlinux_btf(arg->trace);
> +
> +       btf =3D arg->trace->btf;
> +       if (btf =3D=3D NULL)
> +               return false;
> +
> +       if (syscall_arg_fmt__cache_btf_enum(arg->fmt, btf, type) < 0)
> +               return false;
> +
> +       bt =3D arg->fmt->type;
> +       be =3D btf_enum(bt);
> +       for (int i =3D 0; i < btf_vlen(bt); ++i, ++be) {
> +               const char *name =3D btf__name_by_offset(btf, be->name_of=
f);
> +               int max_len =3D max(size, strlen(name));
> +
> +               if (strncmp(name, bf, max_len) =3D=3D 0) {
> +                       *val =3D be->val;
> +                       return true;
> +               }
> +       }
> +
> +       return false;
> +}
> +
>  static size_t btf_enum_scnprintf(const struct btf_type *type, struct btf=
 *btf, char *bf, size_t size, int val)
>  {
>         struct btf_enum *be =3D btf_enum(type);
> @@ -965,8 +996,16 @@ static size_t trace__btf_enum_scnprintf(struct trace=
 *trace __maybe_unused, stru
>  {
>         return 0;
>  }
> +
> +static bool syscall_arg__strtoul_btf_enum(char *bf __maybe_unused, size_=
t size __maybe_unused,
> +                                         struct syscall_arg *arg __maybe=
_unused, u64 *val __maybe_unused)
> +{
> +       return false;
> +}
>  #endif // HAVE_LIBBPF_SUPPORT
>
> +#define STUL_BTF_ENUM syscall_arg__strtoul_btf_enum
> +
>  #define STRARRAY(name, array) \
>           { .scnprintf  =3D SCA_STRARRAY, \
>             .strtoul    =3D STUL_STRARRAY, \
> @@ -1867,6 +1906,7 @@ syscall_arg_fmt__init_array(struct syscall_arg_fmt =
*arg, struct tep_format_field
>                         arg->scnprintf =3D SCA_FD;
>                 } else if (strstr(field->type, "enum") && use_btf !=3D NU=
LL) {
>                         *use_btf =3D arg->is_enum =3D true;
> +                       arg->strtoul =3D STUL_BTF_ENUM;
>                 } else {
>                         const struct syscall_arg_fmt *fmt =3D
>                                 syscall_arg_fmt__find_by_name(field->name=
);
> @@ -3792,7 +3832,8 @@ static int ordered_events__deliver_event(struct ord=
ered_events *oe,
>         return __trace__deliver_event(trace, event->event);
>  }
>
> -static struct syscall_arg_fmt *evsel__find_syscall_arg_fmt_by_name(struc=
t evsel *evsel, char *arg)
> +static struct syscall_arg_fmt *evsel__find_syscall_arg_fmt_by_name(struc=
t evsel *evsel, char *arg,
> +                                                                  char *=
*type)
>  {
>         struct tep_format_field *field;
>         struct syscall_arg_fmt *fmt =3D __evsel__syscall_arg_fmt(evsel);
> @@ -3801,13 +3842,15 @@ static struct syscall_arg_fmt *evsel__find_syscal=
l_arg_fmt_by_name(struct evsel
>                 return NULL;
>
>         for (field =3D evsel->tp_format->format.fields; field; field =3D =
field->next, ++fmt)
> -               if (strcmp(field->name, arg) =3D=3D 0)
> +               if (strcmp(field->name, arg) =3D=3D 0) {
> +                       *type =3D field->type;
>                         return fmt;
> +               }
>
>         return NULL;
>  }
>
> -static int trace__expand_filter(struct trace *trace __maybe_unused, stru=
ct evsel *evsel)
> +static int trace__expand_filter(struct trace *trace, struct evsel *evsel=
)
>  {
>         char *tok, *left =3D evsel->filter, *new_filter =3D evsel->filter=
;
>
> @@ -3840,14 +3883,14 @@ static int trace__expand_filter(struct trace *tra=
ce __maybe_unused, struct evsel
>                         struct syscall_arg_fmt *fmt;
>                         int left_size =3D tok - left,
>                             right_size =3D right_end - right;
> -                       char arg[128];
> +                       char arg[128], *type;
>
>                         while (isspace(left[left_size - 1]))
>                                 --left_size;
>
>                         scnprintf(arg, sizeof(arg), "%.*s", left_size, le=
ft);
>
> -                       fmt =3D evsel__find_syscall_arg_fmt_by_name(evsel=
, arg);
> +                       fmt =3D evsel__find_syscall_arg_fmt_by_name(evsel=
, arg, &type);
>                         if (fmt =3D=3D NULL) {
>                                 pr_err("\"%s\" not found in \"%s\", can't=
 set filter \"%s\"\n",
>                                        arg, evsel->name, evsel->filter);
> @@ -3860,9 +3903,16 @@ static int trace__expand_filter(struct trace *trac=
e __maybe_unused, struct evsel
>                         if (fmt->strtoul) {
>                                 u64 val;
>                                 struct syscall_arg syscall_arg =3D {
> -                                       .parm =3D fmt->parm,
> +                                       .trace =3D trace,
> +                                       .fmt   =3D fmt,
>                                 };
>
> +                               if (fmt->is_enum) {
> +                                       syscall_arg.parm =3D type;
> +                               } else {
> +                                       syscall_arg.parm =3D fmt->parm;
> +                               }

Hi Howard,

minor nit that cases like this shouldn't use curly braces as per:
https://www.kernel.org/doc/html/v4.10/process/coding-style.html#placing-bra=
ces-and-spaces

Thanks,
Ian

> +
>                                 if (fmt->strtoul(right, right_size, &sysc=
all_arg, &val)) {
>                                         char *n, expansion[19];
>                                         int expansion_lenght =3D scnprint=
f(expansion, sizeof(expansion), "%#" PRIx64, val);
> --
> 2.45.2
>
