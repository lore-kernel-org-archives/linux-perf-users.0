Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC5C8BE8;
	Tue, 30 Jul 2024 16:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722355642; cv=none; b=ook4JrX06MZwqaZ1+U+qMlFABh01qMwteDvuPNANeS2XVsQgdKKGZwb6f024QFtitL26/HERJzupqeDnuJccMlSS3R7ZMUhO/CuB+0/gBqXVAORMLr1O6La+vLixjWMgjoz19ORwdacuAUB5pERbco2cdhNGYHS6AHiVWkQtc7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722355642; c=relaxed/simple;
	bh=dhqY0KClrOHz9Bgs+eQ2QG+9Gbo3M6x3sJdvXwUVOr4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FxXU1EvCKqOYhlNcA3YZPtgTtFrDmEJEqxvYhdcF0YkRjmJMJ2M6LheIPb7WFX+UY38+akkouBERae4sp1UxZUn4fzJkdN2mSAluRQ/4r06AUJAOLABQ8hdeU/9aJIyRhDfWg7lPxdxwlUbMBV1Hm4b/OThOYWZ9FuvbITuFdG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-70eaf5874ddso3392786b3a.3;
        Tue, 30 Jul 2024 09:07:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722355640; x=1722960440;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zY3A3bjMwl/xakhQKOWczIT8h4RUzVdcokU/Gw/k280=;
        b=okQZqLJ3o0XIlFfhdCKD2BvDWQnHepkH9/PVJq8his+2xpi1D8mXaWdVIcctFAiqEN
         5Z3JgsN8ZUMrL+G710DlnF5vZpwGCkgj6jaWn79RS4ZIRcfxC53DWLVNnLb/a57aG1KS
         PanQgo1YNM7PRumzfcOqLrtlhnFqRW4ZspiAYJKc/9ijCR6a4ChDrCiFbDEZ9JXQchgD
         IVbqy2vv2Vx2MLtEqI4muPVQ9H8kbjN7Z5yF0Slnq/bZchkIXFArGwMN+4hzec8j3xbx
         L6YSpT5549OaOt/opYf2RMptw6N1qURVc+lwnj4Z3dE6PPpGhXQiDpABotSOTBCZi93x
         EhNA==
X-Forwarded-Encrypted: i=1; AJvYcCUnZ1ZGVtctM5eUKH+mKABFP23fFQpjC11OMyUq+lrV+n2SC1JOHNdNKYc/an6GISLNWsrMmqHxgWUidoC14tQixW1YecFLYZfmhAOF8jdUhWLvwYxw5a7mX/Bf5QViQhfrfINocaAkbUoF72Fo7g==
X-Gm-Message-State: AOJu0Yw2yiZ/yHhM+K9WC+POKXHFWYnjEzLqiAQiUA0SPBE7BexyMG/o
	yzH4BGmJavwuxEHFqUVkSzQhFvLOMPmVs+XGh5zxftuwJpkCp1K1wBqVJneMk6eS/vmm25xO4KQ
	nDy2GzUP4Y6PIME2YoqQes1v/DeR3gw==
X-Google-Smtp-Source: AGHT+IFPOpPr/lLGepmjmsk410a7eDGyhM24Ao+ihf6Y/9ftMuf69cTw69sQa2yrWT6jh3ZJIl69fWenHJzPaVWRY1s=
X-Received: by 2002:a17:90a:cf83:b0:2c9:8380:e97b with SMTP id
 98e67ed59e1d1-2cf7e1b861emr10029427a91.4.1722355640335; Tue, 30 Jul 2024
 09:07:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240729004127.238611-1-namhyung@kernel.org> <20240729004127.238611-3-namhyung@kernel.org>
 <CAP-5=fVt_k=MzGUhMQzS7YRXQ7xzKEFa9+E4kV0D4BPHCNabGw@mail.gmail.com>
In-Reply-To: <CAP-5=fVt_k=MzGUhMQzS7YRXQ7xzKEFa9+E4kV0D4BPHCNabGw@mail.gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Tue, 30 Jul 2024 09:07:08 -0700
Message-ID: <CAM9d7chf5LDQPbNuCwgO-3U_onvqPtj=Oqhu4ZBB6q_UtQANow@mail.gmail.com>
Subject: Re: [PATCH 2/4] perf ftrace: Factor out check_ftrace_capable()
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, 
	Steven Rostedt <rostedt@goodmis.org>, Changbin Du <changbin.du@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ian,

On Mon, Jul 29, 2024 at 11:23=E2=80=AFAM Ian Rogers <irogers@google.com> wr=
ote:
>
> On Sun, Jul 28, 2024 at 5:41=E2=80=AFPM Namhyung Kim <namhyung@kernel.org=
> wrote:
> >
> > The check is a common part of the ftrace commands, let's move it out.
> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
>
> The whole ifdefs and perf_cap__capable seemed wrong, not least as we'd
> like the error message to be accurate not just when libcap is present,
> so I sent out;
> https://lore.kernel.org/lkml/20240729181931.2870851-1-irogers@google.com/
> which I think can supersede this.

Thanks for the change!  I'll reply to the patch.
Namhyung

>
> > ---
> >  tools/perf/builtin-ftrace.c | 44 +++++++++++++++++--------------------
> >  1 file changed, 20 insertions(+), 24 deletions(-)
> >
> > diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
> > index 33c52ebda2fd..978608ecd89c 100644
> > --- a/tools/perf/builtin-ftrace.c
> > +++ b/tools/perf/builtin-ftrace.c
> > @@ -59,6 +59,22 @@ static void ftrace__workload_exec_failed_signal(int =
signo __maybe_unused,
> >         done =3D true;
> >  }
> >
> > +static int check_ftrace_capable(void)
> > +{
> > +       if (!(perf_cap__capable(CAP_PERFMON) ||
> > +             perf_cap__capable(CAP_SYS_ADMIN))) {
> > +               pr_err("ftrace only works for %s!\n",
> > +#ifdef HAVE_LIBCAP_SUPPORT
> > +               "users with the CAP_PERFMON or CAP_SYS_ADMIN capability=
"
> > +#else
> > +               "root"
> > +#endif
> > +               );
> > +               return -1;
> > +       }
> > +       return 0;
> > +}
> > +
> >  static int __write_tracing_file(const char *name, const char *val, boo=
l append)
> >  {
> >         char *file;
> > @@ -586,18 +602,6 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace=
)
> >                 .events =3D POLLIN,
> >         };
> >
> > -       if (!(perf_cap__capable(CAP_PERFMON) ||
> > -             perf_cap__capable(CAP_SYS_ADMIN))) {
> > -               pr_err("ftrace only works for %s!\n",
> > -#ifdef HAVE_LIBCAP_SUPPORT
> > -               "users with the CAP_PERFMON or CAP_SYS_ADMIN capability=
"
> > -#else
> > -               "root"
> > -#endif
> > -               );
> > -               return -1;
> > -       }
> > -
> >         select_tracer(ftrace);
> >
> >         if (reset_tracing_files(ftrace) < 0) {
> > @@ -902,18 +906,6 @@ static int __cmd_latency(struct perf_ftrace *ftrac=
e)
> >         };
> >         int buckets[NUM_BUCKET] =3D { };
> >
> > -       if (!(perf_cap__capable(CAP_PERFMON) ||
> > -             perf_cap__capable(CAP_SYS_ADMIN))) {
> > -               pr_err("ftrace only works for %s!\n",
> > -#ifdef HAVE_LIBCAP_SUPPORT
> > -               "users with the CAP_PERFMON or CAP_SYS_ADMIN capability=
"
> > -#else
> > -               "root"
> > -#endif
> > -               );
> > -               return -1;
> > -       }
> > -
> >         trace_fd =3D prepare_func_latency(ftrace);
> >         if (trace_fd < 0)
> >                 goto out;
> > @@ -1220,6 +1212,10 @@ int cmd_ftrace(int argc, const char **argv)
> >         signal(SIGCHLD, sig_handler);
> >         signal(SIGPIPE, sig_handler);
> >
> > +       ret =3D check_ftrace_capable();
> > +       if (ret < 0)
> > +               return -1;
> > +
> >         ret =3D perf_config(perf_ftrace_config, &ftrace);
> >         if (ret < 0)
> >                 return -1;
> > --
> > 2.46.0.rc1.232.g9752f9e123-goog
> >
