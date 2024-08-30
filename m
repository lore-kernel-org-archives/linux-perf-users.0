Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6691C20EB;
	Fri, 30 Aug 2024 00:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724977013; cv=none; b=EhoDFW6vJH0cPski8vSGohRlGel1xmsUq3J4kL+FgvzjLMwR9k02gN/BSQQuqYr49njLHdivnNIrmGsijfVpOZ1teNtx1Cf22JC9j4aRyuk3kcDRpsoRFSJuDmfgV2QqlsgwA+DC5+4iE6Hm8ifwXYHq1hndnLbYsgqxYtU3FAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724977013; c=relaxed/simple;
	bh=S+ri91NE+DeUYQBjI/wlkUKCdCt8pWPVyZOrY9R+2Wc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eySO9heN53v705VfIJULuZMn/QTAkJXvqLtd0jxuheNc0yHUqe+u5lg1SVNTgb6dMuSRKzfCrwxKN7Tq/yB4ZI+YOfMpsZHmMKUZ17Hv1SfU71Ybta1SW17QTeiblRChOIaj/UrHaZZJOjYLgUVnpjwFBPiv0kp1BZJ6bqup9ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OLjgGJK2; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OLjgGJK2"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6c3f1939d12so11220527b3.2;
        Thu, 29 Aug 2024 17:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724977010; x=1725581810; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=81h24Vz6SwXgNZYntZW9aXa7arlYWDl8F7qYhB9Bieg=;
        b=OLjgGJK2bZWo7qlR4Te4BF6qEIBTCUxBUJq/u2sY6XaOhJDTdkw1brcmD8srVtBnZi
         g/7n67d7zqVxB8xXOUzUKM0BreTnsReNVv5kT/Q54jj6fsSRLEgvIZKkAFcMDeeHVhJ5
         2aRxwQctD9TCbDe1bffKVm+F1SUzIGKdR7vh5KVuNo9tX61latXdimlE494P4mFJEhaV
         bd20nvad7R27i1jwUI/cOYqQQyMK28b1bBk4fjP3KdX9+r+MdzY5NAw5+mfzWRhu/HVp
         C3kSQx6uvTRjbz3pmBXMEbN0s991DhRemX8cMfQNvVh1TRXLkn9b+3SUckCPMCc5ZVtC
         9H+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724977010; x=1725581810;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=81h24Vz6SwXgNZYntZW9aXa7arlYWDl8F7qYhB9Bieg=;
        b=dg/j1urva+yz4n4fNZQ9OxqKmLsCoxp9H86n+rVYz0J5E2wrHJcUcxPuRXrQcda4kl
         F+vgUED6WvF/hWfm1vgcYU6EfZOoHYZYonSyjdwb3d2vKQfFixYLjtHmwKaEJRTex2Tv
         0oEsfs57MyuV5qmQC2wLdefkxztFdrCU97Zk03xWvmBeGl7cMTnxS/KxiuxMuALGraxs
         LyqBd310yB3eamj7Sx9YswJgNC61uJU9pktq12Mz1FlLqb/h1RCkzwJerSVEqKiaijvk
         V4Lrtklg3PqUdVdliwVGPz6lZDppPuq0vo3pIjKD2izmQ3uL9wtR4gF4R/rAu1Bhpfwj
         y0Qg==
X-Forwarded-Encrypted: i=1; AJvYcCUx/HRb6wbrZEG3NyJEAWzbQMyaliSRzU15oGK0NdJNdXqQXsR+evv9NJ+lfG4GN+VI9rP90stxNnSydTMLeF6YGw==@vger.kernel.org, AJvYcCXOYNnyzN/u7hvO1I/yZTGjKHhyRdqvBRm71/YYLE1ScLPKAJTi1DokgCD7zkOGWPH1BSvQj1SNV9xypEc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRn52TyZvMFmo00Ryu+RvRz8Az5+f0pQi8V5WGkC299TY5Pe2Z
	ydcTaNfueVuS3JuJsz+TBbu1QXgkSiYpscLJ95Axz/7xumV2ISScm29aCTMjqT4OmKmbvQ4xTP+
	djmufq23wit7JmyL8hzULgNdmsgc=
X-Google-Smtp-Source: AGHT+IEhqC3HPP4OLM6F3Eq8vwyj/LeJg+kb7TipnsQrcuT/kDi5W8fmtxbveFJb29nSThyKPOFJa324RqmfOOaL2mE=
X-Received: by 2002:a05:690c:610c:b0:664:8646:4d02 with SMTP id
 00721157ae682-6d40dd720bdmr4130547b3.12.1724977010197; Thu, 29 Aug 2024
 17:16:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240824163322.60796-1-howardchu95@gmail.com> <20240824163322.60796-5-howardchu95@gmail.com>
 <Zs-Q-ZyZKd_NzsIv@x1>
In-Reply-To: <Zs-Q-ZyZKd_NzsIv@x1>
From: Howard Chu <howardchu95@gmail.com>
Date: Fri, 30 Aug 2024 08:16:38 +0800
Message-ID: <CAH0uvoge5QUsioZ-j8OS+VoxJAXuP9CyXOJbBkJPwUXWhEryMg@mail.gmail.com>
Subject: Re: [PATCH v3 4/8] perf trace: Pretty print struct data
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: adrian.hunter@intel.com, irogers@google.com, jolsa@kernel.org, 
	kan.liang@linux.intel.com, namhyung@kernel.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Arnaldo,

On Thu, Aug 29, 2024 at 5:05=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Sun, Aug 25, 2024 at 12:33:18AM +0800, Howard Chu wrote:
> > Change the arg->augmented.args to arg->augmented.args->value to skip th=
e
> > header for customized pretty printers, since we collect data in BPF
> > using the general augment_sys_enter(), which always adds the header.
> >
> > Use btf_dump API to pretty print augmented struct pointer.
> >
> > Prefer existed pretty-printer than btf general pretty-printer.
> >
> > set compact =3D true and skip_names =3D true, so that no newline charac=
ter
> > and argument name are printed.
> >
> > Committer notes:
> >
> > Simplified the btf_dump_snprintf callback to avoid using multiple
> > buffers, as discussed in the thread accessible via the Link tag below.
> >
> > Signed-off-by: Howard Chu <howardchu95@gmail.com>
> > Cc: Adrian Hunter <adrian.hunter@intel.com>
> > Cc: Ian Rogers <irogers@google.com>
> > Cc: Jiri Olsa <jolsa@kernel.org>
> > Cc: Kan Liang <kan.liang@linux.intel.com>
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > Link: https://lore.kernel.org/r/20240815013626.935097-7-howardchu95@gma=
il.com
> > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > ---
> >  tools/perf/builtin-trace.c                | 65 +++++++++++++++++++++--
> >  tools/perf/trace/beauty/perf_event_open.c |  2 +-
> >  tools/perf/trace/beauty/sockaddr.c        |  2 +-
> >  tools/perf/trace/beauty/timespec.c        |  2 +-
> >  4 files changed, 63 insertions(+), 8 deletions(-)
> >
> > diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> > index 43b1f63415b4..048bcb92624c 100644
> > --- a/tools/perf/builtin-trace.c
> > +++ b/tools/perf/builtin-trace.c
> > @@ -990,6 +990,54 @@ static size_t btf_enum_scnprintf(const struct btf_=
type *type, struct btf *btf, c
> >       return 0;
> >  }
> >
> > +struct trace_btf_dump_snprintf_ctx {
> > +     char   *bf;
> > +     size_t printed, size;
> > +};
> > +
> > +static void trace__btf_dump_snprintf(void *vctx, const char *fmt, va_l=
ist args)
> > +{
> > +     struct trace_btf_dump_snprintf_ctx *ctx =3D vctx;
> > +
> > +     ctx->printed +=3D vscnprintf(ctx->bf + ctx->printed, ctx->size - =
ctx->printed, fmt, args);
> > +}
> > +
> > +static size_t btf_struct_scnprintf(const struct btf_type *type, struct=
 btf *btf, char *bf, size_t size, struct syscall_arg *arg)
> > +{
> > +     struct trace_btf_dump_snprintf_ctx ctx =3D {
> > +             .bf   =3D bf,
> > +             .size =3D size,
> > +     };
> > +     struct augmented_arg *augmented_arg =3D arg->augmented.args;
> > +     int type_id =3D arg->fmt->type_id, consumed;
> > +     struct btf_dump *btf_dump;
> > +
> > +     LIBBPF_OPTS(btf_dump_opts, dump_opts);
> > +     LIBBPF_OPTS(btf_dump_type_data_opts, dump_data_opts);
> > +
> > +     if (arg =3D=3D NULL || arg->augmented.args =3D=3D NULL)
> > +             return 0;
> > +
> > +     dump_data_opts.compact     =3D true;
> > +     dump_data_opts.skip_names  =3D true;
> > +
> > +     btf_dump =3D btf_dump__new(btf, trace__btf_dump_snprintf, &ctx, &=
dump_opts);
> > +     if (btf_dump =3D=3D NULL)
> > +             return 0;
> > +
> > +     /* pretty print the struct data here */
> > +     if (btf_dump__dump_type_data(btf_dump, type_id, arg->augmented.ar=
gs->value, type->size, &dump_data_opts) =3D=3D 0)
> > +             return 0;
> > +
> > +     consumed =3D sizeof(*augmented_arg) + augmented_arg->size;
> > +     arg->augmented.args =3D ((void *)arg->augmented.args) + consumed;
> > +     arg->augmented.size -=3D consumed;
> > +
> > +     btf_dump__free(btf_dump);
> > +
> > +     return ctx.printed;
> > +}
> > +
> >  static size_t trace__btf_scnprintf(struct trace *trace, struct syscall=
_arg *arg, char *bf,
> >                                  size_t size, int val, char *type)
> >  {
> > @@ -1009,6 +1057,8 @@ static size_t trace__btf_scnprintf(struct trace *=
trace, struct syscall_arg *arg,
> >
> >       if (btf_is_enum(arg_fmt->type))
> >               return btf_enum_scnprintf(arg_fmt->type, trace->btf, bf, =
size, val);
> > +     else if (btf_is_struct(arg_fmt->type))
> > +             return btf_struct_scnprintf(arg_fmt->type, trace->btf, bf=
, size, arg);
> >
> >       return 0;
> >  }
> > @@ -2222,6 +2272,7 @@ static size_t syscall__scnprintf_args(struct sysc=
all *sc, char *bf, size_t size,
> >               .show_string_prefix =3D trace->show_string_prefix,
> >       };
> >       struct thread_trace *ttrace =3D thread__priv(thread);
> > +     void *default_scnprintf;
> >
> >       /*
> >        * Things like fcntl will set this in its 'cmd' formatter to pick=
 the
> > @@ -2263,11 +2314,15 @@ static size_t syscall__scnprintf_args(struct sy=
scall *sc, char *bf, size_t size,
> >                       if (trace->show_arg_names)
> >                               printed +=3D scnprintf(bf + printed, size=
 - printed, "%s: ", field->name);
> >
> > -                     btf_printed =3D trace__btf_scnprintf(trace, &arg,=
 bf + printed,
> > -                                                        size - printed=
, val, field->type);
> > -                     if (btf_printed) {
> > -                             printed +=3D btf_printed;
> > -                             continue;
> > +                     default_scnprintf =3D sc->arg_fmt[arg.idx].scnpri=
ntf;
> > +
> > +                     if (default_scnprintf =3D=3D NULL || default_scnp=
rintf =3D=3D SCA_PTR) {
> > +                             btf_printed =3D trace__btf_scnprintf(trac=
e, &arg, bf + printed,
> > +                                                                size -=
 printed, val, field->type);
> > +                             if (btf_printed) {
> > +                                     printed +=3D btf_printed;
> > +                                     continue;
> > +                             }
>
> Ok, we agreed on this one, and you noted that that in this cset comment,
> good.
>
> Next time make a note after the cset commit log message and before the
> actual patch, something like:
>
> vN: prefer pre-existing userspace scnprintf if explicitely specified,
> only fallbacking to the generic BTF one when none is specified.
>
> >                       }
> >
> >                       printed +=3D syscall_arg_fmt__scnprintf_val(&sc->=
arg_fmt[arg.idx],
> > diff --git a/tools/perf/trace/beauty/perf_event_open.c b/tools/perf/tra=
ce/beauty/perf_event_open.c
> > index 01ee15fe9d0c..632237128640 100644
> > --- a/tools/perf/trace/beauty/perf_event_open.c
> > +++ b/tools/perf/trace/beauty/perf_event_open.c
> > @@ -76,7 +76,7 @@ static size_t perf_event_attr___scnprintf(struct perf=
_event_attr *attr, char *bf
>
> But this part will work if we use the old collectors in the BPF skel?
>

You are right, it won't. The one scenario is that when a vmlinux file
is presented, the general collector (the new one, based on BTF) will
fallback to the old collectors, and now we have new
consumers(ptr->value). This will break.

> I.e. isn't this a change in the protocol of the BPF colector with the
> userpace augmented snprintf routines?
>
> If I remember we discussed that first you make this change in the
> protocol, test it with the pre-existing BPF collector, it works. Ok, now
> we have a new protocol and we then use it in the generic BTF-based BPF
> collector. This way that option of using the BTF-based collector or the
> preexisting BPF collector works.
>
> I'll try to do this.

Thank you so much.

Thanks,
Howard
>
> - Arnaldo
>
> >  static size_t syscall_arg__scnprintf_augmented_perf_event_attr(struct =
syscall_arg *arg, char *bf, size_t size)
> >  {
> > -     return perf_event_attr___scnprintf((void *)arg->augmented.args, b=
f, size, arg->trace->show_zeros);
> > +     return perf_event_attr___scnprintf((void *)arg->augmented.args->v=
alue, bf, size, arg->trace->show_zeros);
> >  }
> >
> >  static size_t syscall_arg__scnprintf_perf_event_attr(char *bf, size_t =
size, struct syscall_arg *arg)
> > diff --git a/tools/perf/trace/beauty/sockaddr.c b/tools/perf/trace/beau=
ty/sockaddr.c
> > index 2e0e867c0c1b..6ecebf776899 100644
> > --- a/tools/perf/trace/beauty/sockaddr.c
> > +++ b/tools/perf/trace/beauty/sockaddr.c
> > @@ -47,7 +47,7 @@ static size_t (*af_scnprintfs[])(struct sockaddr *sa,=
 char *bf, size_t size) =3D {
> >
> >  static size_t syscall_arg__scnprintf_augmented_sockaddr(struct syscall=
_arg *arg, char *bf, size_t size)
> >  {
> > -     struct sockaddr *sa =3D (struct sockaddr *)arg->augmented.args;
> > +     struct sockaddr *sa =3D (struct sockaddr *)arg->augmented.args->v=
alue;
> >       char family[32];
> >       size_t printed;
> >
> > diff --git a/tools/perf/trace/beauty/timespec.c b/tools/perf/trace/beau=
ty/timespec.c
> > index e1a61f092aad..b14ab72a2738 100644
> > --- a/tools/perf/trace/beauty/timespec.c
> > +++ b/tools/perf/trace/beauty/timespec.c
> > @@ -7,7 +7,7 @@
> >
> >  static size_t syscall_arg__scnprintf_augmented_timespec(struct syscall=
_arg *arg, char *bf, size_t size)
> >  {
> > -     struct timespec *ts =3D (struct timespec *)arg->augmented.args;
> > +     struct timespec *ts =3D (struct timespec *)arg->augmented.args->v=
alue;
> >
> >       return scnprintf(bf, size, "{ .tv_sec: %" PRIu64 ", .tv_nsec: %" =
PRIu64 " }", ts->tv_sec, ts->tv_nsec);
> >  }
> > --
> > 2.45.2
