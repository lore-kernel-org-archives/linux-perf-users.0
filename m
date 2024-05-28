Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A847176FBD
	for <linux-perf-users@vger.kernel.org>; Tue, 28 May 2024 19:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716925911; cv=none; b=e9ig7k6Jhr0bgLIxOwr3fKlQAgLUbGMvIvvcvIwPXGWgTAnNS1QKzl3DWucsZVa/AE3d16XKWmBKzqxLlZg6Dr8skaldJ6zr3q7+1GVhiopYmfY0sHufeYMrDMw8a2EzQDNd2p1yyDi4zvKfoW3OftNy63iR4nVmJ8nj2XS2Mog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716925911; c=relaxed/simple;
	bh=HM/62gjuE2bbsMwNJlLbJFt0oSriuYMd4jtJOYaq9mc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cFfHwFgroUIP3wKSojDlgykf1ip3By0epM59y/qNDqzNs7zi/hN08RPlO54BiTndJbJt2JXtKfOBt1MYTAdjA9w5Bw5o6pG8l7/o6aMiTsORyzXmRBsXhlUVsaneG7wmKF83oZJq2sWwNlyYTn7906rMdhpK+41maLhz0rtozuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OJX9UL9X; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OJX9UL9X"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-43f87dd6866so91781cf.0
        for <linux-perf-users@vger.kernel.org>; Tue, 28 May 2024 12:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716925909; x=1717530709; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9TMTcoUocvE/NbqECARFUZ+u82wBWW35aaQbNOD16pM=;
        b=OJX9UL9XZ2dbtp/keUse+W0HOMxuSvr9NT9SFPncvdzcj6Efz6wfAwJqif/tphjQyp
         iFQ7zDko5U9YCMuVJCjCxnaC3mqGX8j0G6HJZ2YisHr9DEwE7LYivqns0wntdNs7d/G4
         1XvbKZ1PgD+KJmQ2WTgO8CmWGt+/Hb3mNmw4rQLZiyOYNQAkebk9HBVX8b2zHHzUJNGG
         Y5c7lIGSA1Q4newURkOw6TZg4jhisfn1Iukxc5PoeqTDgPgaD9rzqQnPSHMLHKZDm+JQ
         T63uQx+Hy6nlSHVc99no9ieUhvqOwMfnpJ8i2a1g3ojgsLY4ElJ5NNlwTLQ/nfrx9JN4
         2Ilg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716925909; x=1717530709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9TMTcoUocvE/NbqECARFUZ+u82wBWW35aaQbNOD16pM=;
        b=HMZL23yPNZ0BldOH1k6fXQXW8uk9HzHgOmC5toZ3VDvcfp5opLCEjG9q10taDouuWE
         GKvpNMjtyeKI5HUz+7EpdaEdsB8XNA3OPopXWznUB/Fmyzh6Ig5fS1tTijFIEwtFpsfj
         uWzCHy/83GhSrDn425V9MkXU36qyQ86dnLVC6KUPBAxOsY9M5DNb7ka6yU58fl3mFx5r
         oWQnT7WXygKweQoFrwPKZ3XFMpGqM65LEuUK88sPuPf/JjpY4+UwVvGFfXChID4K4/0c
         o1oyyQrtbdzp8THI/j1g4Kl0mt0Z9v9TYzMXKD/yBElLIOrkAcusR6S5oL4o8pDHcKPF
         ANqg==
X-Forwarded-Encrypted: i=1; AJvYcCWGiNFmzQp0EK7XfkzDAAvlC0f09Va1fq5q1rMKXJGNOq/he16+iAJXFlBqT9giUgRc0BeVAPgoaL9KGu9Q4JYoB3oGC9RXQD4vc7dABAf88A==
X-Gm-Message-State: AOJu0YyPQ+s3tPvkFiBFcc5YPxd54y/eDxn1GR8Gz7cxmbMb0U9kNdZ7
	tU6xbirDOLiqyPXv/blmwg9gvti+Na6/PuI2EnQs58jl9EXvxpYKWgbXECx+aQH6mCycjf+Q99f
	GlugVJ9PaTFcT/J8XMDA5ycIpL90G3UNPHau4
X-Google-Smtp-Source: AGHT+IF7zxSL9uj0wlnWrBCrivYDsLhE+1YoXfGptC8d6TIhtiMz+CunBUfqvgoC3P/zdG2GTVq59lLRadKctHTBtwI=
X-Received: by 2002:a05:622a:4203:b0:43d:a002:b with SMTP id
 d75a77b69052e-43fe10d6413mr134101cf.9.1716925908895; Tue, 28 May 2024
 12:51:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240525152927.665498-1-irogers@google.com> <CAHk-=wgYxi_+Q1OpZKg2F9=eem7VQjYnoqN6sA1+uUt-0JqQKQ@mail.gmail.com>
 <CAHk-=wi5Ri=yR2jBVk-4HzTzpoAWOgstr1LEvg_-OXtJvXXJOA@mail.gmail.com>
 <20240527105842.GB33806@debian-dev> <CAP-5=fXfidyF_e=yMNi26ScgY-VbJPfxN8M7OiK9ELa3qTfXPQ@mail.gmail.com>
 <ZlY0F_lmB37g10OK@x1>
In-Reply-To: <ZlY0F_lmB37g10OK@x1>
From: Ian Rogers <irogers@google.com>
Date: Tue, 28 May 2024 12:51:36 -0700
Message-ID: <CAP-5=fWM8LxrcR4Nf+e2jRtJ-jC0Sa-HYPf56pU5GW8ySdX1CQ@mail.gmail.com>
Subject: Re: [PATCH v1] perf evlist: Force adding default events only to core PMUs
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Leo Yan <leo.yan@linux.dev>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@arm.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 28, 2024 at 12:44=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Mon, May 27, 2024 at 10:36:45PM -0700, Ian Rogers wrote:
> > On Mon, May 27, 2024 at 3:58=E2=80=AFAM Leo Yan <leo.yan@linux.dev> wro=
te:
> > > On Sat, May 25, 2024 at 02:14:26PM -0700, Linus Torvalds wrote:
> > > > On Sat, 25 May 2024 at 09:43, Linus Torvalds <torvalds@linux-founda=
tion.org> wrote:
>
> > > > > This makes 'perf record' work for me again.
>
> > > > Oh, wait, no it doesn't.
>
> > > > It makes just the plain "perf record" without any arguments work,
> > > > which was what I was testing because I was lazy.
>
> > > > So now
>
> > > >     $ perf record sleep 1
>
> > > > works fine. But
>
> > > >     $ perf record -e cycles:pp sleep 1
>
> > > > is still completely broken (with or without ":p" and ":pp").
>
> > > Seems to me that this patch fails to check if a PMU is a core-attache=
d
> > > PMU that can support common hardware events. Therefore, we should
> > > consider adding the following check.
>
> > > +++ b/tools/perf/util/parse-events.c
> > > @@ -1594,6 +1594,9 @@ int parse_events_multi_pmu_add(struct parse_eve=
nts_state *parse_state,
> > >         while ((pmu =3D perf_pmus__scan(pmu)) !=3D NULL) {
> > >                 bool auto_merge_stats;
> > >
> > > +               if (hw_config !=3D PERF_COUNT_HW_MAX && !pmu->is_core=
)
> > > +                       continue;
> > > +
> > >                 if (parse_events__filter_pmu(parse_state, pmu))
> > >                         continue;
>
> > > To be clear, I only compiled this change but I have no chance to test
> > > it. @Ian, could you confirm this?
>
> > Hi Leo,
>
> > so the code is working as intended. I believe it also agrees with what
> > Arnaldo thinks.
>
> > If you do:
>
> > $ perf stat -e cycles ...
>
> > and you have
>
> > /sys/devices/pmu1/events/cycles
> > /sys/devices/pmu2/events/cycles
>
> > The output of perf stat should contain counts for pmu1 and pmu2. Were
> > the event 'data_read' or 'inst_retired.any' we wouldn't be having the
>
> Sure, what is being asked is to count events and if those two events in
> those two PMUs can count, then do what the user asked.
>
> For 'perf record' we're asking for sampling, if the event has the name
> specified and can't be sampled, skip it, warn the user and even so
> only if verbose mode is asked, something like:
>
>   root@x1:~# perf record -e cycles -a sleep 1
>   [ perf record: Woken up 1 times to write data ]
>   [ perf record: Captured and wrote 1.998 MB perf.data (4472 samples) ]
>   root@x1:~# perf evlist
>   cpu_atom/cycles/
>   cpu_core/cycles/
>   dummy:u
>   root@x1:~#
>
> Cool, there are two 'cycles' events, one in a PMU named 'cpu_atom',
> another in a 'cpu_core' one, both can be sampled, my workload may
> run/use resources on then, I'm interested, sample both.
>
> But if we had some other PMU, to use a name Jiri uses in tests/fake
> PMUs, the 'krava' PMU and it has a 'cycles' event, so 'krava/cycles/'
> and for some reason it doesn't support sampling, skip it, then the
> result should be the same as above.
>
> If the user finds it strange after looking at sysfs that 'krava/cycles/'
> isn't being sampled, the usual workflow is to ask perf for more
> verbosity, using -v (or multiple 'v' letters to get increasing levels of
> verbosity), in which case the user would see:
>
>   root@x1:~# perf record -v -e cycles -a sleep 1
>   WARNING: skipping 'krava/cycles/' event, it doesn't support sampling.
>   [ perf record: Woken up 1 times to write data ]
>   [ perf record: Captured and wrote 1.998 MB perf.data (4472 samples) ]
>   root@x1:~# perf evlist

The problem here is that we're hiding a problem rather than reporting
it. Typically we report the issue and more than that we ask the user
to work around the issue. That would be analogous to wanting the user
to specify what PMU they want the event to apply to, which has always
been perf's behavior.

Thanks,
Ian

> - Arnaldo
