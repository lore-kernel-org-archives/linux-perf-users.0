Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E1F320F;
	Wed, 19 Jun 2024 18:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718821143; cv=none; b=PypiJeWfnwOls9wxjtx7whNYSNTMp7x7EranRuaPZ//tTH5UgSGQB8UaS0yNpuHpB50Dg5kOzLvXuDsLRMd1YWvxlKa93VymZ+IKd8AwR51DYlhHF3C+rc22oyLxo0uVNprMzuF5xUKERg01zUE52jPidm3YUG6mib72YU88zL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718821143; c=relaxed/simple;
	bh=S+3Vqh5QpZi+T0ckYeETyCuU0PraOYcKQ8R5+e90PfM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SRfB9oPJ9CcQyRdUJpq8UT1+56mA1LiES/ODUk7WNmG30RkUOrhtws4C8qV8Ii3uxjiIWqaw5GfHqgSB7vCNtijxg94fPI/o5RSt69O0EfOhG4ZfsFN4zkt+QN2F81C1xwLn/LhgtMSLCXjtnXsTCXvaFqXy0f96ryrBjjdyM7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nh++6Q/u; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nh++6Q/u"
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e026a2238d8so68101276.0;
        Wed, 19 Jun 2024 11:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718821141; x=1719425941; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BEu13VmwcSkhfhpPbkBAnM2Q6uhPY+UHM/UDHukSj8A=;
        b=nh++6Q/usgTVd2A82Lufk1vyizvOZ5uE/eGjsv6uamPITlIluNKmo74mRBchGjiX6r
         iQJYv31Oil2P5Ipt9RHbtWRLgezL6n7xvb7njUNS2UsWfSdTlq/Keiln6S0SN9Yhnj4g
         eeOg5uMwZWJjd9bFcGkdg3ox0OW5hWESr+EtjYzitfL03BXou6P10dofK7IVo6SB0CZn
         LtKpkzW1MTL0yWcv9AJp4bxaE75eMWljF8XVKwG0qK+sfvyFNR0+9ge/XCJFlRO67WVV
         2BGuXewie4/Pj2iSWZC9IF01rBBhAdLtN5p2EYRF1cPbmq8Ez4OhcAkS/D0ZZId9iq2J
         MerQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718821141; x=1719425941;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BEu13VmwcSkhfhpPbkBAnM2Q6uhPY+UHM/UDHukSj8A=;
        b=SQydkvEPX7QrSjQot8VZWdIvYDgBY+e3YHVJ8z88BCxsWohJvS4k1pbUPIaabj6Dy0
         gomSNmOURG8rEy5atrYMKJXBYYzhclr/L1eRHCkt8ZqZcBMu4UFAv+bUi9EZOIVvo+jP
         JM7o9EXk2dayjdZBtX4Gr/EX50cfS1ZZGZnrKE3208ZQ1YDCb7/vJ/xO3BX/2yE9DF1D
         4rX6wlOdB6qsipRM03M06bErTkb2J8hYwmiiI15n0uxE2SvWSjh+jca87YDdJPtTWTDt
         gSJ/Qu4u8AHdQzUk8fnQnzGm1ejy1/lxjdKMCI13myNFdkyURHqGEBVGQP7JY2vixfFz
         jZxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvivDRyodxXBFXxIdDdM6OYyx5gA+Slx67NTwdezJeElm3eSWiTnvrucdEcU58jiF3GHm6TSWALKQFWH0uLF3MTvRhYvQ7QYLkvVkXm15qotupxsh7SzyRx3zklV7dRoEP9w47HnwIxaV4O2qb5w==
X-Gm-Message-State: AOJu0YzCfJnQ1EIBuCwPCZzPgXfv/EdczzZt1oLl1tH5aSF+Gdos71If
	iUMVd8DTkINvGjv+4H/hkhCKKm9rXKjFYNaG2Kx9FHYk4XOfZGgpm7zywKxJUCEYI3XMIwGbAWU
	VvAtwYOFTBKwHZno1QP/4AZlUQVSba/xPnpxiDGw6
X-Google-Smtp-Source: AGHT+IE2+h+HBJ/WO5HggIuHtfZercrlYGnR/xp47MaSNvxeZ9Prc8MjI9IKBWX6AqC+LuY1/Nnfwa2GLYVH152nZog=
X-Received: by 2002:a25:bc91:0:b0:dfb:97b:479a with SMTP id
 3f1490d57ef6-e02be20b8f8mr3711631276.50.1718821140691; Wed, 19 Jun 2024
 11:19:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240619082042.4173621-1-howardchu95@gmail.com>
 <20240619082042.4173621-5-howardchu95@gmail.com> <ZnLhwFuQvP59p1BJ@x1>
In-Reply-To: <ZnLhwFuQvP59p1BJ@x1>
From: Howard Chu <howardchu95@gmail.com>
Date: Thu, 20 Jun 2024 02:18:51 +0800
Message-ID: <CAH0uvoiUOQngNGPh+tK957vEdbyyzqyy8T4jJGpyqMD9PDKAbA@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] perf trace: Filter enum arguments with enum names
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

You are right! What a silly mistake, I duplicated a line of code.
Sorry about that.

On Wed, Jun 19, 2024 at 9:48=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Wed, Jun 19, 2024 at 04:20:41PM +0800, Howard Chu wrote:
> > Before:
> >
> > perf $ ./perf trace -e timer:hrtimer_start --filter=3D'mode!=3DHRTIMER_=
MODE_ABS_PINNED_HARD' --max-events=3D1
> > No resolver (strtoul) for "mode" in "timer:hrtimer_start", can't set fi=
lter "(mode!=3DHRTIMER_MODE_ABS_PINNED_HARD) && (common_pid !=3D 281988)"
> >
> > After:
> >
> > perf $ ./perf trace -e timer:hrtimer_start --filter=3D'mode!=3DHRTIMER_=
MODE_ABS_PINNED_HARD' --max-events=3D1
> >      0.000 :0/0 timer:hrtimer_start(hrtimer: 0xffff9498a6ca5f18, functi=
on: 0xffffffffa77a5be0, expires: 12351248764875, softexpires: 1235124876487=
5, mode: HRTIMER_MODE_ABS)
> >
> > && and ||:
> >
> > perf $ ./perf trace -e timer:hrtimer_start --filter=3D'mode !=3D HRTIME=
R_MODE_ABS_PINNED_HARD && mode !=3D HRTIMER_MODE_ABS' --max-events=3D1
> >      0.000 Hyprland/534 timer:hrtimer_start(hrtimer: 0xffff9497801a84d0=
, function: 0xffffffffc04cdbe0, expires: 12639434638458, softexpires: 12639=
433638458, mode: HRTIMER_MODE_REL)
> >
> > perf $ ./perf trace -e timer:hrtimer_start --filter=3D'mode =3D=3D HRTI=
MER_MODE_REL || mode =3D=3D HRTIMER_MODE_PINNED' --max-events=3D1
> >      0.000 ldlck-test/60639 timer:hrtimer_start(hrtimer: 0xffffb16404ee=
7bf8, function: 0xffffffffa7790420, expires: 12772614418016, softexpires: 1=
2772614368016, mode: HRTIMER_MODE_REL)
> >
> > Switching it up, using both enum name and integer value(--filter=3D'mod=
e =3D=3D HRTIMER_MODE_ABS_PINNED_HARD || mode =3D=3D 0'):
> >
> > perf $ ./perf trace -e timer:hrtimer_start --filter=3D'mode =3D=3D HRTI=
MER_MODE_ABS_PINNED_HARD || mode =3D=3D 0' --max-events=3D3
> >      0.000 :0/0 timer:hrtimer_start(hrtimer: 0xffff9498a6ca5f18, functi=
on: 0xffffffffa77a5be0, expires: 12601748739825, softexpires: 1260174873982=
5, mode: HRTIMER_MODE_ABS_PINNED_HARD)
> >      0.036 :0/0 timer:hrtimer_start(hrtimer: 0xffff9498a6ca5f18, functi=
on: 0xffffffffa77a5be0, expires: 12518758748124, softexpires: 1251875874812=
4, mode: HRTIMER_MODE_ABS_PINNED_HARD)
> >      0.172 tmux: server/41881 timer:hrtimer_start(hrtimer: 0xffffb16408=
1e7838, function: 0xffffffffa7790420, expires: 12518768255836, softexpires:=
 12518768205836, mode: HRTIMER_MODE_ABS)
> >
> > P.S.
> > perf $ pahole hrtimer_mode
> > enum hrtimer_mode {
> >         HRTIMER_MODE_ABS             =3D 0,
> >         HRTIMER_MODE_REL             =3D 1,
> >         HRTIMER_MODE_PINNED          =3D 2,
> >         HRTIMER_MODE_SOFT            =3D 4,
> >         HRTIMER_MODE_HARD            =3D 8,
> >         HRTIMER_MODE_ABS_PINNED      =3D 2,
> >         HRTIMER_MODE_REL_PINNED      =3D 3,
> >         HRTIMER_MODE_ABS_SOFT        =3D 4,
> >         HRTIMER_MODE_REL_SOFT        =3D 5,
> >         HRTIMER_MODE_ABS_PINNED_SOFT =3D 6,
> >         HRTIMER_MODE_REL_PINNED_SOFT =3D 7,
> >         HRTIMER_MODE_ABS_HARD        =3D 8,
> >         HRTIMER_MODE_REL_HARD        =3D 9,
> >         HRTIMER_MODE_ABS_PINNED_HARD =3D 10,
> >         HRTIMER_MODE_REL_PINNED_HARD =3D 11,
> > };
> >
> > Tested-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> > Suggested-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> > Reviewed-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> > Signed-off-by: Howard Chu <howardchu95@gmail.com>
> > ---
> >  tools/perf/builtin-trace.c | 89 ++++++++++++++++++++++++++++++++------
> >  1 file changed, 76 insertions(+), 13 deletions(-)
> >
> > diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> > index bd16679fb4c0..1148c3edee97 100644
> > --- a/tools/perf/builtin-trace.c
> > +++ b/tools/perf/builtin-trace.c
> > @@ -904,11 +904,36 @@ static size_t syscall_arg__scnprintf_getrandom_fl=
ags(char *bf, size_t size,
> >           .strtoul    =3D STUL_STRARRAY_FLAGS, \
> >           .parm       =3D &strarray__##array, }
> >
> > -static int btf_enum_find_entry(struct btf *btf, char *type, struct sys=
call_arg_fmt *arg_fmt)
> > +#define SCA_GETRANDOM_FLAGS syscall_arg__scnprintf_getrandom_flags
>
> The above seems unrelated? (The definition of SCA_GETRANDOM_FLAGS) as it
> is not used in any other place in this patch, right?
>
> - Arnaldo
>
> > +
> > +static const struct btf_type *btf_find_type(struct btf *btf, char *typ=
e)
> >  {
> >       const struct btf_type *bt;
> > +     int id =3D btf__find_by_name(btf, type);
> > +
> > +     if (id < 0)
> > +             return NULL;
> > +
> > +     bt =3D btf__type_by_id(btf, id);
> > +     if (bt =3D=3D NULL)
> > +             return NULL;
> > +
> > +     return bt;
> > +}
> > +
> > +struct btf_parm {
> > +     struct btf *btf;
> > +     char *type;
> > +};
> > +
> > +static bool syscall_arg__strtoul_btf_enum(char *bf, size_t size, struc=
t syscall_arg *arg, u64 *val)
> > +{
> > +     struct btf_parm *bparm =3D arg->parm;
> > +     struct btf *btf =3D bparm->btf;
> > +     char *type      =3D bparm->type;
> >       char enum_prefix[][16] =3D { "enum", "const enum" }, *ep;
> > -     int id;
> > +     struct btf_enum *be;
> > +     const struct btf_type *bt;
> >       size_t i;
> >
> >       for (i =3D 0; i < ARRAY_SIZE(enum_prefix); i++) {
> > @@ -917,11 +942,38 @@ static int btf_enum_find_entry(struct btf *btf, c=
har *type, struct syscall_arg_f
> >                       type +=3D strlen(ep) + 1;
> >       }
> >
> > -     id =3D btf__find_by_name(btf, type);
> > -     if (id < 0)
> > -             return -1;
> > +     bt =3D btf_find_type(btf, type);
> > +     if (bt =3D=3D NULL)
> > +             return false;
> >
> > -     bt =3D btf__type_by_id(btf, id);
> > +     for (be =3D btf_enum(bt), i =3D 0; i < btf_vlen(bt); ++i, ++be) {
> > +             const char *name =3D btf__name_by_offset(btf, be->name_of=
f);
> > +             int max_len =3D max(size, strlen(name));
> > +
> > +             if (strncmp(name, bf, max_len) =3D=3D 0) {
> > +                     *val =3D be->val;
> > +                     return true;
> > +             }
> > +     }
> > +
> > +     return false;
> > +}
> > +
> > +#define STUL_BTF_ENUM syscall_arg__strtoul_btf_enum
> > +
> > +static int btf_enum_find_entry(struct btf *btf, char *type, struct sys=
call_arg_fmt *arg_fmt)
> > +{
> > +     char enum_prefix[][16] =3D { "enum", "const enum" }, *ep;
> > +     const struct btf_type *bt;
> > +     size_t i;
> > +
> > +     for (i =3D 0; i < ARRAY_SIZE(enum_prefix); i++) {
> > +             ep =3D enum_prefix[i];
> > +             if (strlen(type) > strlen(ep) + 1 && strstarts(type, ep))
> > +                     type +=3D strlen(ep) + 1;
> > +     }
> > +
> > +     bt =3D btf_find_type(btf, type);
> >       if (bt =3D=3D NULL)
> >               return -1;
> >
> > @@ -1850,6 +1902,7 @@ syscall_arg_fmt__init_array(struct syscall_arg_fm=
t *arg, struct tep_format_field
> >                       arg->scnprintf =3D SCA_FD;
> >               } else if (strstr(field->type, "enum") && use_btf !=3D NU=
LL) {
> >                       *use_btf =3D arg->is_enum =3D true;
> > +                     arg->strtoul =3D STUL_BTF_ENUM;
> >               } else {
> >                       const struct syscall_arg_fmt *fmt =3D
> >                               syscall_arg_fmt__find_by_name(field->name=
);
> > @@ -3776,7 +3829,8 @@ static int ordered_events__deliver_event(struct o=
rdered_events *oe,
> >       return __trace__deliver_event(trace, event->event);
> >  }
> >
> > -static struct syscall_arg_fmt *evsel__find_syscall_arg_fmt_by_name(str=
uct evsel *evsel, char *arg)
> > +static struct syscall_arg_fmt *evsel__find_syscall_arg_fmt_by_name(str=
uct evsel *evsel, char *arg,
> > +                                                                char *=
*type)
> >  {
> >       struct tep_format_field *field;
> >       struct syscall_arg_fmt *fmt =3D __evsel__syscall_arg_fmt(evsel);
> > @@ -3785,8 +3839,10 @@ static struct syscall_arg_fmt *evsel__find_sysca=
ll_arg_fmt_by_name(struct evsel
> >               return NULL;
> >
> >       for (field =3D evsel->tp_format->format.fields; field; field =3D =
field->next, ++fmt)
> > -             if (strcmp(field->name, arg) =3D=3D 0)
> > +             if (strcmp(field->name, arg) =3D=3D 0) {
> > +                     *type =3D field->type;
> >                       return fmt;
> > +             }
> >
> >       return NULL;
> >  }
> > @@ -3824,14 +3880,14 @@ static int trace__expand_filter(struct trace *t=
race __maybe_unused, struct evsel
> >                       struct syscall_arg_fmt *fmt;
> >                       int left_size =3D tok - left,
> >                           right_size =3D right_end - right;
> > -                     char arg[128];
> > +                     char arg[128], *type;
> >
> >                       while (isspace(left[left_size - 1]))
> >                               --left_size;
> >
> >                       scnprintf(arg, sizeof(arg), "%.*s", left_size, le=
ft);
> >
> > -                     fmt =3D evsel__find_syscall_arg_fmt_by_name(evsel=
, arg);
> > +                     fmt =3D evsel__find_syscall_arg_fmt_by_name(evsel=
, arg, &type);
> >                       if (fmt =3D=3D NULL) {
> >                               pr_err("\"%s\" not found in \"%s\", can't=
 set filter \"%s\"\n",
> >                                      arg, evsel->name, evsel->filter);
> > @@ -3843,9 +3899,16 @@ static int trace__expand_filter(struct trace *tr=
ace __maybe_unused, struct evsel
> >
> >                       if (fmt->strtoul) {
> >                               u64 val;
> > -                             struct syscall_arg syscall_arg =3D {
> > -                                     .parm =3D fmt->parm,
> > -                             };
> > +                             struct syscall_arg syscall_arg;
> > +                             struct btf_parm bparm;
> > +
> > +                             if (fmt->is_enum) {
> > +                                     bparm.btf  =3D trace->btf;
> > +                                     bparm.type =3D type;
> > +                                     syscall_arg.parm =3D &bparm;
> > +                             } else {
> > +                                     syscall_arg.parm =3D fmt->parm;
> > +                             }
> >
> >                               if (fmt->strtoul(right, right_size, &sysc=
all_arg, &val)) {
> >                                       char *n, expansion[19];
> > --
> > 2.45.2
> >
