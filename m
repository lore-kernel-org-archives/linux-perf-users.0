Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5AA3054CE
	for <linux-perf-users@vger.kernel.org>; Thu, 27 Nov 2025 19:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764272839; cv=none; b=rxb/uzEB3koWDt1mAkk1DL7aQtcO5H6kcVSsviy6HW2O/q2ygdsLs1B1XIqYyukVubgZ3x44qJpxQaAfxmPSHmVU9ZOsBgbnF654wkmS/rbuocJw5YdLFz4cB2j8fs0FAS70qudNskCB+es7zZF8HlFiMhrZbCBz+mCJi+fJIew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764272839; c=relaxed/simple;
	bh=2gKqlhL+oKpJqL+2Gh4lp6gQ4shm2W4/SGjbhO8D7wM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kW2AriqjlU9bk5vEVJvhOcpzFtYrkZ5FR0B3Z1KJOQabLZhtn6U9Z46g5yYC6qaOgSPDn0n+3VsOVhYYGEOLfxscDEjCSPfJB1JQnb4jhWdxYqlK0Hml9IWidqkxGVBXtmqIEAkL7HT5al90hyPfTWYC4LbECUcr86n6ugO+taI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OShfYNn6; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OShfYNn6"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-882399d60baso9167606d6.0
        for <linux-perf-users@vger.kernel.org>; Thu, 27 Nov 2025 11:47:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764272836; x=1764877636; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sg7KjYOVvlr3oMio3mP5WmftnJuXV+fdf8Itchjh2g0=;
        b=OShfYNn6p5PvQ0ZRRTZlErYttJb3vzFgtMbBaHcB+9WbAAgNCN0Z/nHJRZvylX5SdX
         cfpHylGeDRKv+OdR15rDo+I7Zf+nqIGrIHcJFVPahH9yQI+K7ik3wxJLlBFwl3ibRKqn
         Wblcboh6klVHbPxv7NIb709dfNZvdoKE8xAqoLeJIH9RAUy8q8HxbmiGgzaZbwBWh7hf
         XT6WJrMHP8bHjIJVs8K2E/0FtiwteF/POrIGeQolTucsVx+sG70gc+EI5FUnWabel1lR
         KX+iamwIwtXhU2UQThLZQ3cqonJLudsGg4AZ3rMDojKU31J8blrxZtCGoUYfYdepZlf3
         kQpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764272836; x=1764877636;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sg7KjYOVvlr3oMio3mP5WmftnJuXV+fdf8Itchjh2g0=;
        b=ijFcU1YLoTZxMY6KFU/l4/RLtyw0fHq4zaGMc+PJ7egfx7kQPaL0VBf9090EUA1hSW
         x4hCM9UXWlHodjo/mbh2hbVVwfhSk27yxPgtkw0URfPRgoTnejbSdAE9X2yC/VJ6yK0K
         gVlwqADRR7aD/5mu8FeTLWB5PMbMFIP384RK3T4JqVguEjWmcIlDZxh4PiXa+9agaMyC
         p9NoXZVQaOMKKO5zaokovMLrBl2ug/OYX2mzhOXsKcvp7JZdmwklP3qUe2rwPXGZ0oOP
         4pInYmzrAht3JoXQJr3UsarkdT9lqNcffWLmFMIoaHVD7ebrGfBfWlrLiJgjQ3uvy38n
         7X3A==
X-Forwarded-Encrypted: i=1; AJvYcCVyVJFaY5Yu4maRPKRB2s2GivtUHjXDi0QO/mT2nM13c2PBkR/fD1cjbivDIQP3UG3GI4loPOWOGz6YrUfqEe0n@vger.kernel.org
X-Gm-Message-State: AOJu0YzVsy4r6NBsdxSZ5W6BtesQNaiH4Ad7184LdbmwYGjIdWplK4fO
	Un6t9m8fcDgERXgmIApdZ17Xb23XjhcX9g8HRcqRWWEjicpjRg8qflf9LwvlWblqMhWJtAH1p8a
	PtljYgxUn3gs+YnTMWR/w4fPJjEmJuNs=
X-Gm-Gg: ASbGncsMvLW3+1T8aAdJihQHLy6akxcJ/ePy65qHunPzFgbN5EoPqBCWRiup/a6c1XE
	f9WoVPqdp6H4DFg3UTtPL+7BaBlBWtekJTRxAk5vp0yUePWFuyWasVIbOHI7DTmbxtNKZtnHG9c
	TAf8ryZQuipoDoPP0WlnrHEBygyOlIi3QC6vd9TENymaTcM/CecSUEJaHHXDcW85w4Rhr/HOtWL
	/DEB5kYOMyUE/U0jf8f++93RHL9tN9CvjALWLv2pL/2tKNt6hW2cRi/UIhCCioZ/QnX81Zotnec
	F+UVXw==
X-Google-Smtp-Source: AGHT+IHhedJqOLHL4tv6NDiKT6GRxooDIeIovbGByeiy9JsALYqRg0YDvyfrmn8g977WSkSPmgHucbwkqba4hjw2GZo=
X-Received: by 2002:a05:6214:3188:b0:882:483b:978d with SMTP id
 6a1803df08f44-8863aff3cc9mr228020196d6.59.1764272836250; Thu, 27 Nov 2025
 11:47:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251127044418.677379-1-namhyung@kernel.org> <ea6ca6ea-13ca-4e92-a7c5-b48611f3f1e8@linux.ibm.com>
In-Reply-To: <ea6ca6ea-13ca-4e92-a7c5-b48611f3f1e8@linux.ibm.com>
From: Howard Chu <howardchu95@gmail.com>
Date: Thu, 27 Nov 2025 11:47:05 -0800
X-Gm-Features: AWmQ_bmA08fFZrSGsvf5EqhBm0lrNaq0BaTq8bZBrCr4evBCIYCDlXxAYO7NqYk
Message-ID: <CAH0uvogPnKbH=_8NBrcVTWpKO75BK10R232YcHhXT2muJPy_kw@mail.gmail.com>
Subject: Re: [PATCH] perf trace: Skip internal syscall arguments
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Ian Rogers <irogers@google.com>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, 
	Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Namhyung,

On Wed, Nov 26, 2025 at 11:10=E2=80=AFPM Thomas Richter <tmricht@linux.ibm.=
com> wrote:
>
> On 11/27/25 05:44, Namhyung Kim wrote:
> > Recent changes in the linux-next kernel will add new field for syscalls
> > to have contents in the userspace like below.
> >
> >   # cat /sys/kernel/tracing/events/syscalls/sys_enter_write/format
> >   name: sys_enter_write
> >   ID: 758
> >   format:
> >           field:unsigned short common_type;       offset:0;       size:=
2; signed:0;
> >           field:unsigned char common_flags;       offset:2;       size:=
1; signed:0;
> >           field:unsigned char common_preempt_count;       offset:3;    =
   size:1; signed:0;
> >           field:int common_pid;   offset:4;       size:4; signed:1;
> >
> >           field:int __syscall_nr; offset:8;       size:4; signed:1;
> >           field:unsigned int fd;  offset:16;      size:8; signed:0;
> >           field:const char * buf; offset:24;      size:8; signed:0;
> >           field:size_t count;     offset:32;      size:8; signed:0;
> >           field:__data_loc char[] __buf_val;      offset:40;      size:=
4; signed:0;
> >
> >   print fmt: "fd: 0x%08lx, buf: 0x%08lx (%s), count: 0x%08lx", ((unsign=
ed long)(REC->fd)),
> >              ((unsigned long)(REC->buf)), __print_dynamic_array(__buf_v=
al, 1),
> >              ((unsigned long)(REC->count))
> >
> > We have a different way to handle those arguments and this change
> > confuses perf trace then make some tests failing.  Fix it by skipping
> > the new fields that have "__data_loc char[]" type.
> >
> > Maybe we can switch to this instead of the BPF augmentation later.
> >
> > Reported-by: Thomas Richter <tmricht@linux.ibm.com>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Cc: Howard Chu <howardchu95@gmail.com>
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>

LGTM.

Reviewed-by: Howard Chu <howardchu95@gmail.com>

Thanks,
Howard

> > ---
> >  tools/perf/builtin-trace.c | 21 +++++++++++++++++++++
> >  1 file changed, 21 insertions(+)
> >
> > diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> > index a743bda294bd3400..baee1f6956001d86 100644
> > --- a/tools/perf/builtin-trace.c
> > +++ b/tools/perf/builtin-trace.c
> > @@ -2069,6 +2069,15 @@ static const struct syscall_arg_fmt *syscall_arg=
_fmt__find_by_name(const char *n
> >         return __syscall_arg_fmt__find_by_name(syscall_arg_fmts__by_nam=
e, nmemb, name);
> >  }
> >
> > +/*
> > + * v6.19 kernel added new fields to read userspace memory for event tr=
acing.
> > + * But it's not used by perf and confuses the syscall parameters.
> > + */
> > +static bool is_internal_field(struct tep_format_field *field)
> > +{
> > +     return !strcmp(field->type, "__data_loc char[]");
> > +}
> > +
> >  static struct tep_format_field *
> >  syscall_arg_fmt__init_array(struct syscall_arg_fmt *arg, struct tep_fo=
rmat_field *field,
> >                           bool *use_btf)
> > @@ -2077,6 +2086,10 @@ syscall_arg_fmt__init_array(struct syscall_arg_f=
mt *arg, struct tep_format_field
> >       int len;
> >
> >       for (; field; field =3D field->next, ++arg) {
> > +             /* assume it's the last argument */
> > +             if (is_internal_field(field))
> > +                     continue;
> > +
> >               last_field =3D field;
> >
> >               if (arg->scnprintf)
> > @@ -2145,6 +2158,7 @@ static int syscall__read_info(struct syscall *sc,=
 struct trace *trace)
> >  {
> >       char tp_name[128];
> >       const char *name;
> > +     struct tep_format_field *field;
> >       int err;
> >
> >       if (sc->nonexistent)
> > @@ -2201,6 +2215,13 @@ static int syscall__read_info(struct syscall *sc=
, struct trace *trace)
> >               --sc->nr_args;
> >       }
> >
> > +     field =3D sc->args;
> > +     while (field) {
> > +             if (is_internal_field(field))
> > +                     --sc->nr_args;
> > +             field =3D field->next;
> > +     }
> > +
> >       sc->is_exit =3D !strcmp(name, "exit_group") || !strcmp(name, "exi=
t");
> >       sc->is_open =3D !strcmp(name, "open") || !strcmp(name, "openat");
> >
>
> With the patch it succeeds again:
> =E2=9D=AF ./perf test -F 'perf trace BTF general tests'
> Checking if vmlinux BTF exists
> Testing perf trace's string augmentation
> Testing perf trace's buffer augmentation
> Testing perf trace's struct augmentation
> 110: perf trace BTF general tests                                    : Ok
> >
>
> Tested-by: Thomas Richter <tmricht@linux.ibm.com>
> --
> Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, German=
y
> --
> IBM Deutschland Research & Development GmbH
>
> Vorsitzender des Aufsichtsrats: Wolfgang Wendt
>
> Gesch=C3=A4ftsf=C3=BChrung: David Faller
>
> Sitz der Gesellschaft: B=C3=B6blingen / Registergericht: Amtsgericht Stut=
tgart, HRB 243294
