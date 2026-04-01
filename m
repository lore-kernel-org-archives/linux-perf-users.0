Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4348332A3FE
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Apr 2026 06:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775023208; cv=pass; b=XpLsnl9kCzozOzraCcrx2iySzv0mLEtky3PjY5P2AsxEymtga4ALVrQJKYEThHn9YVvqz8FbC367ARPag4OzZT3yzJ85RMLJ1WZBX0dYfzeI0C4DfQsUG8U1GIykugPkhQ7LPirmb6CgD/ZcScgRYSMTRiFb2nATFBroaZQYPQ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775023208; c=relaxed/simple;
	bh=eBQgOKMB014WOAbiMVPumCPrRQE5sdSB1k4edSs+ShI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qrsWGa6F4Yo27fkp9leSMn6wFC3kkIPF018gcE93XfPGRNlkad7d86viE40cM7KleXBaCiU35ITzfc32w7yvVXMRWiSJOPEQMrCh9NEWL5tN2IH0Voo2V/VM70T12JpNdgevGEjWL+RTkdQyz9qD+tO8dUpSub8d7b8J06wSOUs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LPJvJFHB; arc=pass smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LPJvJFHB"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2b243198058so153825ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 31 Mar 2026 23:00:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775023205; cv=none;
        d=google.com; s=arc-20240605;
        b=TUrhi1dEtfUeP5OK5ZFZXMEkC16meAplUjhYamAVpH2f6FYbwfX/1/X3Pz6X8adsVw
         1Ph2e+0PFtIzk8vF4w2ViNHdmO+5A9MTbjnq+7aCcJJKFwvYjQxwJLVA8o3xqUcNc50I
         WppK7bvBlsLq/Uc6XlC8saINMP99IidwABj5KyuY8h5nBGCUSkQ8+kewpztr8CupV9wz
         AqErjIV9lygSva83LcL5kKlgmemCZFNS5h32q7H17M9pAtnNyJ3cyBMuOm25IytU7Kj4
         l237wbPGHKaGn+9ej3JytvcmzHsi4+TippnTB0LtGclRGkf/hLLAG+2vFumrnfdGdkp2
         S4XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qd7QVLtGT+CVNfMjKrfds+sJFjb5SxHwQKTjCd5vaoM=;
        fh=KsnKDeSmYrCSrwH5Y+B2NkHwww0eH2JwWFZYGlbqYpQ=;
        b=J03K3Q168wwLmqHNxEmYiHA0UVk5K6RhOR1eqMggxic6r/sI61TTV35pZLD1Lia94K
         bjXWS820cWQxGTWtR59VP/0ytEi/ap8EMWelE8Y2i0+DHPQLuwUvCFZUQ3eUAqcxWyVb
         HUZhxIeSQBxHuxHnHYkBXKpQPqzHBhJVRDslDyylJgjjGIIaVzhtAr7eup5IYlAuTSzx
         eqQ2XFhSi+CwtlP5l9g54HycNx5ppgnTvBnIKEYnibBCyCNxf0J7a5XFn7dcxdGDcY/6
         +FCywmFJj96kyYUTCtz1G8ssh0Ow8L+jER9Go/ToSVrESwc3ynqbdKPyCz7eOlZv/wwJ
         78Ow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775023205; x=1775628005; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qd7QVLtGT+CVNfMjKrfds+sJFjb5SxHwQKTjCd5vaoM=;
        b=LPJvJFHBygeWsXiAdmyj0rTVCwMhhMYd1V5HmebU7fe0CEN6iGyaQezZIQ5PJ+07kG
         50IWAFHJEYh6dGGRSoVaxJ0Qu3SJRL2EyhsqiLpchBuzjVAJqROS69q2m31NIUsNndp6
         x1Yo9YONoz06p4tD33pHBBdB4y20sq2AuAA89LzUjsZ1rG0QfHw8A0qGyWjiCAvgoaVR
         5joVXHPGbzUurr1JZIdxnHPwdfg2nZCOaEXRM4NgFDSqJy3ij9MxIgvrsFXYSQx59K3I
         XKYbLplyDP/vHwyuA5nW2THNG0pgmRVhCC28BSzQjjITGvrgJlvOoEV734LCTqE6LrOy
         vpPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775023205; x=1775628005;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qd7QVLtGT+CVNfMjKrfds+sJFjb5SxHwQKTjCd5vaoM=;
        b=LydhNHJjjhCXCZFtpd6DsNhZiMWwe/DQKEx2IOiv/4aIXLLAkqpkpnd72jgGzwl5/x
         /qPWqlQ3S7I7aVPrnBpHf5nIzTOjYWf4s4bKjrh/lx1EwljQPCAFiYL3Rn8BawhCDtr9
         h8ewF6abvVPhGesV4tcLR481gRCAjYO5lMnW7ind95jh3fng+gFWcU4Za5m+EhMe48QR
         zLPAm4yFJ5bcH5qB5JCto6aMzL8k8K6pVy2I4FlY/RjYafCyU+HJj7NETDQL4yE2+VRt
         O3MtcQNlqfIcrG+gwJYqkrIAh6BJQ7gzavSTsqQxdwSqZ6lS044qh9ynkL3CPNyUW7PK
         1Fsw==
X-Forwarded-Encrypted: i=1; AJvYcCVSRYjaQ76aFBSn7DaXKRWFI4eb0wqelKTKI9P49RmagsCVNKjcDdmnHDu4uHbsSt2B5ZR3jhGbtgMXC7ePrwig@vger.kernel.org
X-Gm-Message-State: AOJu0YxMZw/mLDMTuOVizMVInYu3zUUCmh48rbAG9iT7yRjFbPvVQoRf
	Ncr1RcTHbf9szYXhQMOEIL5Z/9zKKff0GOk7y3D4vMKgHaikSnf6s1oQTVsT0thN/oWIImn4zjG
	+FTpkhpDv1gdEuAd79fV6o3TV2FSNKvFhiiaPq5Pv
X-Gm-Gg: ATEYQzwLITffgJV1tgnM+kQbYjRSIrqEbT8YbXFwb8EQ+9KHj0T2/gPvdVdYZRnGpcT
	v3/27MrWiT3M4DI1zg0eM4wIt4ucSMLSqx3ex9tdOM6xIXQElRCbXAUV85PQsDKnmy+GfhpuO16
	ag65MjC//CPFvrSI8loWTeYNg+g5tCL9AQ63hPs/OA6URrrzG+rh2vTSNB+nQJG/EBAwsSFndGz
	sfcZwpzPA6M2vAU2Rbab+5bmyuz9g8aGCirm5bm6FpaAmP/nQccspHvqiBAnmMu35TFaDV5uy+K
	8tG8S7xE
X-Received: by 2002:a17:902:f54a:b0:2a7:d266:d84a with SMTP id
 d9443c01a7336-2b26b2a90cdmr1283615ad.17.1775023203976; Tue, 31 Mar 2026
 23:00:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260321061448.810525-1-irogers@google.com> <acW_IHQVZnxIETdd@google.com>
In-Reply-To: <acW_IHQVZnxIETdd@google.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 31 Mar 2026 22:59:52 -0700
X-Gm-Features: AQROBzB3hh6WVSh_r6TChXhy6hz_K3HG0_Prs53Yef8eFElcl9mRPPyXZcgDHjs
Message-ID: <CAP-5=fWh66OwPC0K4ZyedAWqwyXez0ya9Dz6hzbgY0AhoqMfdg@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] perf sched: Avoid segv if tp_handler not set
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Swapnil Sapkal <swapnil.sapkal@amd.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2026 at 4:20=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Fri, Mar 20, 2026 at 11:14:47PM -0700, Ian Rogers wrote:
> > Doing a `perf sched record` then `perf sched stats report` crashes as
> > the tp_handler isn't set. Add extra checks that tp_handler is set
> > before accessing through it.
>
> Oh.. unintended use case. :)  Probably better to add a dummy handler
> for `perf sched stats report`.

Perhaps. I'd prefer to land the simpler change as-is.

Thanks,
Ian

> Thanks,
> Namhyung
>
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/builtin-sched.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> > index d083e2bb7703..196f263ff667 100644
> > --- a/tools/perf/builtin-sched.c
> > +++ b/tools/perf/builtin-sched.c
> > @@ -1525,7 +1525,7 @@ static int process_sched_wakeup_event(const struc=
t perf_tool *tool,
> >  {
> >       struct perf_sched *sched =3D container_of(tool, struct perf_sched=
, tool);
> >
> > -     if (sched->tp_handler->wakeup_event)
> > +     if (sched->tp_handler && sched->tp_handler->wakeup_event)
> >               return sched->tp_handler->wakeup_event(sched, evsel, samp=
le, machine);
> >
> >       return 0;
> > @@ -1809,7 +1809,7 @@ static int process_sched_switch_event(const struc=
t perf_tool *tool,
> >                       sched->nr_context_switch_bugs++;
> >       }
> >
> > -     if (sched->tp_handler->switch_event)
> > +     if (sched->tp_handler && sched->tp_handler->switch_event)
> >               err =3D sched->tp_handler->switch_event(sched, evsel, sam=
ple, machine);
> >
> >       sched->curr_pid[this_cpu] =3D next_pid;
> > @@ -1823,7 +1823,7 @@ static int process_sched_runtime_event(const stru=
ct perf_tool *tool,
> >  {
> >       struct perf_sched *sched =3D container_of(tool, struct perf_sched=
, tool);
> >
> > -     if (sched->tp_handler->runtime_event)
> > +     if (sched->tp_handler && sched->tp_handler->runtime_event)
> >               return sched->tp_handler->runtime_event(sched, evsel, sam=
ple, machine);
> >
> >       return 0;
> > @@ -1840,7 +1840,7 @@ static int perf_sched__process_fork_event(const s=
truct perf_tool *tool,
> >       perf_event__process_fork(tool, event, sample, machine);
> >
> >       /* and then run additional processing needed for this command */
> > -     if (sched->tp_handler->fork_event)
> > +     if (sched->tp_handler && sched->tp_handler->fork_event)
> >               return sched->tp_handler->fork_event(sched, event, machin=
e);
> >
> >       return 0;
> > @@ -1853,7 +1853,7 @@ static int process_sched_migrate_task_event(const=
 struct perf_tool *tool,
> >  {
> >       struct perf_sched *sched =3D container_of(tool, struct perf_sched=
, tool);
> >
> > -     if (sched->tp_handler->migrate_task_event)
> > +     if (sched->tp_handler && sched->tp_handler->migrate_task_event)
> >               return sched->tp_handler->migrate_task_event(sched, evsel=
, sample, machine);
> >
> >       return 0;
> > --
> > 2.53.0.959.g497ff81fa9-goog
> >
