Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE721EB2B;
	Thu, 11 Jul 2024 15:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720710899; cv=none; b=H+B+R+UQGbfL7lrSKYRRmiaLjWCuo8WC8wODzUMvmrru2cTUqT2+huHmwsZk2lbpoXr4NF6NUnVZKfLsSjjyWCX9tG/iP/7h6MpyX59gGvgz6QqGQ+NoXEDlU2oxrwF5wtKeYWBf4OpuPDbq4X86C8XOPG+PJWheXf9wO9v40GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720710899; c=relaxed/simple;
	bh=iNzVCwJPE3qbwH7uA3RG5cOz4CzmI7k87jKzN7/pUNk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kzykrfi26HJ3JI6ta5uJTQ2m21qFkmENCRvu6npQmIIBgHd3WoS+uDA+imf6PpD+iedb7H3UjWk/LcJtD/tH7uSzUO9j3cq7ue9/wqo3twhv6lOrBDEGcZVt7BOGRR6A63VGmNkEcpags0oO2tNCoGfiRIMl/CV3L0M61/3foH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DdXoVUGg; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DdXoVUGg"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-65240d22f7cso9450127b3.0;
        Thu, 11 Jul 2024 08:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720710897; x=1721315697; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Rl+p9a4uPrxYad4JYK64XlH0M1QKJVTk5l6bonnpCc=;
        b=DdXoVUGgBd2L974AIl+VDGl0UqifCkZUKD7r9y4o3yS5fW7ybVcgVEpzkukJITs2bA
         xm6CFaoTHv3eoWgipAKsS1une1s7xgH9FfW4F+NT41gadcTBwpFGMHdrqa+6/yDJkQdy
         rdcPevtjMAsoHxLZHVdEBRm6HvMLN/wN/kpavnNkAqOhLapMjrReuLREbE1zcjh6HZrf
         sKQKBOamsFyBo+kag6LxAXUO0JCqvqs4PHWn4CV0P9GmpMMU2mEUVMafqSgMewlPXrv9
         CZqIi/yuwcgua/i2J+YJA/LCpE0bZgHBajzPHx7S7QT+wbr+ixm8O2t5EbT3rZA7vGeN
         mkaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720710897; x=1721315697;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Rl+p9a4uPrxYad4JYK64XlH0M1QKJVTk5l6bonnpCc=;
        b=OA+My0qDLf88cNply6jM6DV95SITl5PZniVhf+ds/hQ+eQNlEOZlJmbhKAEJmjkAmt
         OeLb8iuIWj5kqjdLsZ7iz6aPYm3QKV2i7Vu0wl1pt34IRMZfFJBL7U92MNEWPjw5Vr7F
         BGsAXTa48pkJxd8FiOF+2/8fwltOq5cXR8m2UWHcts0pJMWaolPqBOK3yhpN6R8fhHU+
         K7Url6XnShGNk/++ZvHcylnjmlebIAmvn1lRks/Igc5r8HF22jPGkTUFDx4KowNAl1dE
         3XXUdB15F/FhOkcyJc3ejQlgxHHwI1HRbjQX1ZXTFiTbmg98n1Fs7MZCSJJU7QJs7ExX
         yb3g==
X-Forwarded-Encrypted: i=1; AJvYcCVpt/XknbPynZdkO5STIGM/RrCuZxceOHgBKUouqfztfBUXd95IH6V9I+ufsihG0vjzyOa0OPCCbxFel4ZWdXoVopJXqyizsXRvOStEkrnfeOcaXFZRr3Cj7ELgBz5zTUEiLnYHnqg124hB+oATIQ==
X-Gm-Message-State: AOJu0YwdSXd3DzkRhvbfZdarjIO0lP6pCSa6oPfoC+lQ7dWxLU72QuIP
	pzGulx/pava7pvJHTvo4dLolnG+gLx8EXvTp7gCBE9RdrJ6wFfmQGdh9EI8yefonipMophu9FV/
	9jCLHN9DEmSLqqYD8yZMIy8daE5M=
X-Google-Smtp-Source: AGHT+IEVqk54K6q/6eZeyh3HU+yA73yQAvQ5uowUyNNrftYEy+J+qCrbWJXz/OlKI6KSfkVkC2m2TPw01v80NkR1lHI=
X-Received: by 2002:a25:aa66:0:b0:e03:5fee:66a with SMTP id
 3f1490d57ef6-e041b123aefmr10644080276.42.1720710896569; Thu, 11 Jul 2024
 08:14:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240705094300.585156-1-howardchu95@gmail.com>
 <20240705094300.585156-5-howardchu95@gmail.com> <CAP-5=fVhPDuvJ7=H=BggPbYcT7WrD8-yG=czPjnNiXWvt_Etmg@mail.gmail.com>
In-Reply-To: <CAP-5=fVhPDuvJ7=H=BggPbYcT7WrD8-yG=czPjnNiXWvt_Etmg@mail.gmail.com>
From: Howard Chu <howardchu95@gmail.com>
Date: Thu, 11 Jul 2024 23:14:47 +0800
Message-ID: <CAH0uvoi=KH_DC=kmzGMg7MxJJPqNdnizXEAitkcRYHErBUgQqQ@mail.gmail.com>
Subject: Re: [PATCH v5 4/8] perf trace: Filter enum arguments with enum names
To: Ian Rogers <irogers@google.com>
Cc: acme@kernel.org, adrian.hunter@intel.com, jolsa@kernel.org, 
	kan.liang@linux.intel.com, namhyung@kernel.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Arnaldo Carvalho de Melo <acme@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
	Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Ian,

On Thu, Jul 11, 2024 at 1:49=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
te:
>
> On Fri, Jul 5, 2024 at 2:43=E2=80=AFAM Howard Chu <howardchu95@gmail.com>=
 wrote:
> >
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
> > Committer testing:
> >
> >   root@x1:~# perf trace -e timer:hrtimer_start --filter=3D'mode !=3D HR=
TIMER_MODE_ABS' --max-events=3D2
> >        0.000 :0/0 timer:hrtimer_start(hrtimer: 0xffff8d4eff2a5050, func=
tion: 0xffffffff9e22ddd0, expires: 241502326000000, softexpires: 2415023260=
00000, mode: HRTIMER_MODE_ABS_PINNED_HARD)
> >   18446744073709.488 :0/0 timer:hrtimer_start(hrtimer: 0xffff8d4eff4250=
50, function: 0xffffffff9e22ddd0, expires: 241501814000000, softexpires: 24=
1501814000000, mode: HRTIMER_MODE_ABS_PINNED_HARD)
> >   root@x1:~# perf trace -e timer:hrtimer_start --filter=3D'mode !=3D HR=
TIMER_MODE_ABS && mode !=3D HRTIMER_MODE_ABS_PINNED_HARD' --max-events=3D2
> >        0.000 podman/510644 timer:hrtimer_start(hrtimer: 0xffffa2024f5f7=
dd0, function: 0xffffffff9e2170c0, expires: 241530497418194, softexpires: 2=
41530497368194, mode: HRTIMER_MODE_REL)
> >       40.251 gnome-shell/2484 timer:hrtimer_start(hrtimer: 0xffff8d48bd=
a17650, function: 0xffffffffc0661550, expires: 241550528619247, softexpires=
: 241550527619247, mode: HRTIMER_MODE_REL)
> >   root@x1:~# perf trace -v -e timer:hrtimer_start --filter=3D'mode !=3D=
 HRTIMER_MODE_ABS && mode !=3D HRTIMER_MODE_ABS_PINNED_HARD && mode !=3D HR=
TIMER_MODE_REL' --max-events=3D2
> >   Using CPUID GenuineIntel-6-BA-3
> >   vmlinux BTF loaded
> >   <SNIP>
> >   0
> >   0xa
> >   0x1
> >   New filter for timer:hrtimer_start: (mode !=3D 0 && mode !=3D 0xa && =
mode !=3D 0x1) && (common_pid !=3D 524049 && common_pid !=3D 4041)
> >   mmap size 528384B
> >   ^Croot@x1:~#
> >
> > Suggested-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> > Signed-off-by: Howard Chu <howardchu95@gmail.com>
> > Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > Cc: Adrian Hunter <adrian.hunter@intel.com>
> > Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> > Cc: Ian Rogers <irogers@google.com>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Jiri Olsa <jolsa@kernel.org>
> > Cc: Kan Liang <kan.liang@linux.intel.com>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Link: https://lore.kernel.org/lkml/ZnCcliuecJABD5FN@x1
> > Link: https://lore.kernel.org/r/20240624181345.124764-5-howardchu95@gma=
il.com
> > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > ---
> >  tools/perf/builtin-trace.c | 62 ++++++++++++++++++++++++++++++++++----
> >  1 file changed, 56 insertions(+), 6 deletions(-)
> >
> > diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> > index 5618feb7d01a..e664001d5ed7 100644
> > --- a/tools/perf/builtin-trace.c
> > +++ b/tools/perf/builtin-trace.c
> > @@ -932,6 +932,37 @@ static int syscall_arg_fmt__cache_btf_enum(struct =
syscall_arg_fmt *arg_fmt, stru
> >         return arg_fmt->type =3D=3D NULL ? -1 : 0;
> >  }
> >
> > +static bool syscall_arg__strtoul_btf_enum(char *bf, size_t size, struc=
t syscall_arg *arg, u64 *val)
> > +{
> > +       const struct btf_type *bt;
> > +       char *type =3D arg->parm;
> > +       struct btf_enum *be;
> > +       struct btf *btf;
> > +
> > +       trace__load_vmlinux_btf(arg->trace);
> > +
> > +       btf =3D arg->trace->btf;
> > +       if (btf =3D=3D NULL)
> > +               return false;
> > +
> > +       if (syscall_arg_fmt__cache_btf_enum(arg->fmt, btf, type) < 0)
> > +               return false;
> > +
> > +       bt =3D arg->fmt->type;
> > +       be =3D btf_enum(bt);
> > +       for (int i =3D 0; i < btf_vlen(bt); ++i, ++be) {
> > +               const char *name =3D btf__name_by_offset(btf, be->name_=
off);
> > +               int max_len =3D max(size, strlen(name));
> > +
> > +               if (strncmp(name, bf, max_len) =3D=3D 0) {
> > +                       *val =3D be->val;
> > +                       return true;
> > +               }
> > +       }
> > +
> > +       return false;
> > +}
> > +
> >  static size_t btf_enum_scnprintf(const struct btf_type *type, struct b=
tf *btf, char *bf, size_t size, int val)
> >  {
> >         struct btf_enum *be =3D btf_enum(type);
> > @@ -965,8 +996,16 @@ static size_t trace__btf_enum_scnprintf(struct tra=
ce *trace __maybe_unused, stru
> >  {
> >         return 0;
> >  }
> > +
> > +static bool syscall_arg__strtoul_btf_enum(char *bf __maybe_unused, siz=
e_t size __maybe_unused,
> > +                                         struct syscall_arg *arg __may=
be_unused, u64 *val __maybe_unused)
> > +{
> > +       return false;
> > +}
> >  #endif // HAVE_LIBBPF_SUPPORT
> >
> > +#define STUL_BTF_ENUM syscall_arg__strtoul_btf_enum
> > +
> >  #define STRARRAY(name, array) \
> >           { .scnprintf  =3D SCA_STRARRAY, \
> >             .strtoul    =3D STUL_STRARRAY, \
> > @@ -1867,6 +1906,7 @@ syscall_arg_fmt__init_array(struct syscall_arg_fm=
t *arg, struct tep_format_field
> >                         arg->scnprintf =3D SCA_FD;
> >                 } else if (strstr(field->type, "enum") && use_btf !=3D =
NULL) {
> >                         *use_btf =3D arg->is_enum =3D true;
> > +                       arg->strtoul =3D STUL_BTF_ENUM;
> >                 } else {
> >                         const struct syscall_arg_fmt *fmt =3D
> >                                 syscall_arg_fmt__find_by_name(field->na=
me);
> > @@ -3792,7 +3832,8 @@ static int ordered_events__deliver_event(struct o=
rdered_events *oe,
> >         return __trace__deliver_event(trace, event->event);
> >  }
> >
> > -static struct syscall_arg_fmt *evsel__find_syscall_arg_fmt_by_name(str=
uct evsel *evsel, char *arg)
> > +static struct syscall_arg_fmt *evsel__find_syscall_arg_fmt_by_name(str=
uct evsel *evsel, char *arg,
> > +                                                                  char=
 **type)
> >  {
> >         struct tep_format_field *field;
> >         struct syscall_arg_fmt *fmt =3D __evsel__syscall_arg_fmt(evsel)=
;
> > @@ -3801,13 +3842,15 @@ static struct syscall_arg_fmt *evsel__find_sysc=
all_arg_fmt_by_name(struct evsel
> >                 return NULL;
> >
> >         for (field =3D evsel->tp_format->format.fields; field; field =
=3D field->next, ++fmt)
> > -               if (strcmp(field->name, arg) =3D=3D 0)
> > +               if (strcmp(field->name, arg) =3D=3D 0) {
> > +                       *type =3D field->type;
> >                         return fmt;
> > +               }
> >
> >         return NULL;
> >  }
> >
> > -static int trace__expand_filter(struct trace *trace __maybe_unused, st=
ruct evsel *evsel)
> > +static int trace__expand_filter(struct trace *trace, struct evsel *evs=
el)
> >  {
> >         char *tok, *left =3D evsel->filter, *new_filter =3D evsel->filt=
er;
> >
> > @@ -3840,14 +3883,14 @@ static int trace__expand_filter(struct trace *t=
race __maybe_unused, struct evsel
> >                         struct syscall_arg_fmt *fmt;
> >                         int left_size =3D tok - left,
> >                             right_size =3D right_end - right;
> > -                       char arg[128];
> > +                       char arg[128], *type;
> >
> >                         while (isspace(left[left_size - 1]))
> >                                 --left_size;
> >
> >                         scnprintf(arg, sizeof(arg), "%.*s", left_size, =
left);
> >
> > -                       fmt =3D evsel__find_syscall_arg_fmt_by_name(evs=
el, arg);
> > +                       fmt =3D evsel__find_syscall_arg_fmt_by_name(evs=
el, arg, &type);
> >                         if (fmt =3D=3D NULL) {
> >                                 pr_err("\"%s\" not found in \"%s\", can=
't set filter \"%s\"\n",
> >                                        arg, evsel->name, evsel->filter)=
;
> > @@ -3860,9 +3903,16 @@ static int trace__expand_filter(struct trace *tr=
ace __maybe_unused, struct evsel
> >                         if (fmt->strtoul) {
> >                                 u64 val;
> >                                 struct syscall_arg syscall_arg =3D {
> > -                                       .parm =3D fmt->parm,
> > +                                       .trace =3D trace,
> > +                                       .fmt   =3D fmt,
> >                                 };
> >
> > +                               if (fmt->is_enum) {
> > +                                       syscall_arg.parm =3D type;
> > +                               } else {
> > +                                       syscall_arg.parm =3D fmt->parm;
> > +                               }
>
> Hi Howard,
>
> minor nit that cases like this shouldn't use curly braces as per:
> https://www.kernel.org/doc/html/v4.10/process/coding-style.html#placing-b=
races-and-spaces


Thanks for the review. I think these two lines are deleted from
Arnaldo's patch 'perf trace: Remove arg_fmt->is_enum, we can get that
from the BTF type
(b06414bc07f59ef0269ceb60a63126a01ab8018f)' that's done on top of this
patch, so I didn't pay too much attention to this, sorry for the
confusion. I will reorganize this patch series.

Thanks,
Howard
>
> Thanks,
> Ian
>
> > +
> >                                 if (fmt->strtoul(right, right_size, &sy=
scall_arg, &val)) {
> >                                         char *n, expansion[19];
> >                                         int expansion_lenght =3D scnpri=
ntf(expansion, sizeof(expansion), "%#" PRIx64, val);
> > --
> > 2.45.2
> >
