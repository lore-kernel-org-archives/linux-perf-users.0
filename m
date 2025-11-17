Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67AD344050
	for <linux-perf-users@vger.kernel.org>; Mon, 17 Nov 2025 17:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763399058; cv=none; b=dT2FjHjYADiY6K7TM6yGTvb6vult5SYSdM/7pxUtinq0il4vo+AxOxR5/u3PH77Qvvlt6t1XFjTNoyy+ZQpb7vad/SxmTAVQQyn5c+yi9Inh7Maapxqb9seY/AEml14j5jncgrnTKEjoEwLEpV0Eh+3HDig0IWDtFmY9LYOeLtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763399058; c=relaxed/simple;
	bh=QiyDwr11Yp6i/7HpV1Lp1i9JzWfYSml5P3IlT+SaCo8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bzwp/NOknV08glDMVd1A0KmrwIoE1FxHSVD6+hUVEaDGu0fVBqkJ2TElBvYJflSnJbEGaxlKZv/CDCdqMqj0AJLQNAH2X4K5dENBrtN34R6nrNj6BY93bqLOX7L0L0dHANiK1Mj2RGr/BITo8XgfTymlU4c2eY7HiH06FkyeWzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Rmu4nxY4; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Rmu4nxY4"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-29852dafa7dso388085ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 17 Nov 2025 09:04:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763399056; x=1764003856; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ZVX+PNBpxNP+Gwp4ShZnDKz9OEI+BSqDeSt3BLuq80=;
        b=Rmu4nxY4+z7xT1CvgsjmGuemXxJUcLsvTn/80gnNFxtkscoL3apzjG9dNfXrrJpjo3
         QaP1Htr+vuwLURdtkKdux638YgfSYTTjO850R16fUBASTYvFK3SuIuJIqzjPd7uN/jL+
         egBhIrPxprFRfJCkyGRS7DeJeXDtS/sHs2e5tN/AEEeZTJXYzKirgIS35x4ppWbDeGdm
         x7hrO5Yny1pelKGi0eufZs5S6A6ET16hmqvvv062hyHPLHKDvZm72diPZ4j+mg1+3YJT
         PvFWJZnnnvND6XfjPUA9URtahMiB8tqTxOa4rP27XgMY8vZxFZoh/cK4A6LfYByCzIF5
         u8FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763399056; x=1764003856;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8ZVX+PNBpxNP+Gwp4ShZnDKz9OEI+BSqDeSt3BLuq80=;
        b=dsT2KkmAMI9yizg2VUiQWZCZW2qwHMd78ygQKOTSuOzq0nC5e8zQTexGK61hhviEpP
         dSjH7HiNEbQc94UH/mKha6r81UOHeJX336lRPoIrClHTsO3JjmurbpTdfiBtUDDl2m78
         pptxFQ2DbPX4ii/7ETJTPx5Vy7CD1D2SnbMOjO+wmWgsT7LOx/ZOngppys2bLwywRmlO
         KyZ4uQnTvNqFw9e1i5JllpC4woXuL4/nCdKI0Kt62dGf4TSrb9TUdMxnaNrETMoqeGrb
         iV4yHmJStSitAKLxEHifR7CC1w/C6HUonol9aOLzqn1tFLB/0hVSVGecpm6HhbaTzV6q
         Lkyg==
X-Forwarded-Encrypted: i=1; AJvYcCUqHMz/c0t4qHwcOVuKfA8SONPThHUJZ1s3ZgNomO7JlMdYkRQ3VX2KPjmEm+Mi3mfJ00AvFHSIXZofgCbXE2Jl@vger.kernel.org
X-Gm-Message-State: AOJu0YzQNvzU5Hse5uHvaIvBlFj/S2cM5hvtL5XUB6gZ3leGt2vMfZ50
	Klg0SVGIQX9OnYN6XtO3g02TiuVjSklYs2QRr9d5XE8YWlnpVE2nKyzMubxzQNAaWdF15tvaL9l
	TzbR33x4OOsGqLKajb0jU9juF0+g2rJvG4LetJOtQ
X-Gm-Gg: ASbGncvRLbtDA8PEAMucpiX2KrVQAMDJ4lgv25eWyPQsku/Fz6dxkqt8bA3CeCcwdX9
	XcoVL0uCtMHRkPW1xUHVFSLAu9YbVK9XpuzzlsKsC6gv7QhEUmKfVL9hfZe+utX9Sw4Kr/zdVy9
	oLK/6aoS517EK6VHjSE1RWo49t1Nz5SmaGcKXFZEoxCv54nntPKvYceTWqJtpr04GhfAwAQoemx
	EQ/nwdFP84i6KtRFejkMvpRRhw0aGAiPDuDksNiUQevMBn5bPwl4rwVPGnjpCCtSQwVOFWIc9yf
	gR6+7zo3CszhGR3sT+1ZPRz+Ww==
X-Google-Smtp-Source: AGHT+IHFbh/w5IFZlaVBD48qVGrzb28+GJwoXTSBvkMsctrLPHPwXkzmFVxcvV51MYV9R2y9tm3gcpi1YWW4BGkzsmM=
X-Received: by 2002:a05:7022:529:b0:119:e55a:8091 with SMTP id
 a92af1059eb24-11c723399d2mr8170c88.14.1763399055287; Mon, 17 Nov 2025
 09:04:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112080526.3971392-1-dapeng1.mi@linux.intel.com> <CAP-5=fUW2CdFnZ3sSOAnEHHqgDV3OB-p3FbfL+KKkvJJ6_smNg@mail.gmail.com>
In-Reply-To: <CAP-5=fUW2CdFnZ3sSOAnEHHqgDV3OB-p3FbfL+KKkvJJ6_smNg@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 17 Nov 2025 09:04:03 -0800
X-Gm-Features: AWmQ_bmW4p84ARMDNInenfZWPFScVmrE0S9tq-evPRSR7gHJ9aoccnXhihPEuw8
Message-ID: <CAP-5=fVCo=9f0_2pt=4mXZ4Zc0Ah4DPEVBH9dUTe+rOs5vnpkg@mail.gmail.com>
Subject: Re: [PATCH] perf: Fix 0 count issue of cpu-clock
To: Dapeng Mi <dapeng1.mi@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Eranian Stephane <eranian@google.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Dapeng Mi <dapeng1.mi@intel.com>, 
	Zide Chen <zide.chen@intel.com>, Falcon Thomas <thomas.falcon@intel.com>, 
	Xudong Hao <xudong.hao@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2025 at 8:42=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
te:
>
> On Wed, Nov 12, 2025 at 12:07=E2=80=AFAM Dapeng Mi <dapeng1.mi@linux.inte=
l.com> wrote:
> >
> > Currently cpu-clock event always returns 0 count, e.g.,
> >
> > perf stat -e cpu-clock -- sleep 1
> >
> >  Performance counter stats for 'sleep 1':
> >                  0      cpu-clock                        #    0.000 CPU=
s utilized
> >        1.002308394 seconds time elapsed
> >
> > The root cause is the commit 'bc4394e5e79c ("perf: Fix the throttle
> >  error of some clock events")' adds PERF_EF_UPDATE flag check before
> > calling cpu_clock_event_update() to update the count, however the
> > PERF_EF_UPDATE flag is never set when the cpu-clock event is stopped in
> > counting mode (pmu->dev() -> cpu_clock_event_del() ->
> > cpu_clock_event_stop()). This leads to the cpu-clock event count is
> > never updated.
> >
> > To fix this issue, force to set PERF_EF_UPDATE flag for cpu-clock event
> > just like what task-clock does. Besides, or flags with PERF_EF_UPDATE
> > for task-clock although currently the flags argument would always be 0.
> >
> > Fixes: bc4394e5e79c ("perf: Fix the throttle error of some clock events=
")
> > Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>
> Thanks Dapeng! This is a fairly major regression and I'm surprised my
> kernel picked it up so quickly. For those interested the relevant part
> of the breaking change is requiring PERF_EF_UPDATE:
>
> ```
> @@ -11829,7 +11834,8 @@ static void cpu_clock_event_start(struct
> perf_event *event, int flags)
>  static void cpu_clock_event_stop(struct perf_event *event, int flags)
>  {
>         perf_swevent_cancel_hrtimer(event);
> -       cpu_clock_event_update(event);
> +       if (flags & PERF_EF_UPDATE)
> +               cpu_clock_event_update(event);
>  }
>  ```
>
> Reviewed-by: Ian Rogers <irogers@google.com>
>
> Hopefully a maintainer can pick this up quickly. Thanks,
> Ian

Hi Peter and Ingo,

any update on picking this up? Having timer based software events
(task-clock, cpu-clock) broken is fairly major regression especially
in environments like hypervisors where PMU access is blocked.

Thanks,
Ian

> > ---
> >
> > With this change, both cpu-clock and task-clock can do counting and
> > samping correctly.
> >
> > 1. perf stat -e cpu-clock,task-clock -- true
> >
> >  Performance counter stats for 'true':
> >            240,636      cpu-clock                        #    0.358 CPU=
s utilized
> >            243,319      task-clock                       #    0.362 CPU=
s utilized
> >
> > 2. perf record -e cpu-clock -c 10000 -Iax,bx -- sleep 1
> > [ perf record: Woken up 2 times to write data ]
> > [ perf record: Captured and wrote 0.028 MB perf.data (36 samples) ]
> >
> > 3. perf record -e task-clock -c 10000 -Iax,bx -- sleep 1
> > [ perf record: Woken up 1 times to write data ]
> > [ perf record: Captured and wrote 0.029 MB perf.data (41 samples) ]
> >
> >  kernel/events/core.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > index f6a08c73f783..77d3af5959c1 100644
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -11964,7 +11964,7 @@ static int cpu_clock_event_add(struct perf_even=
t *event, int flags)
> >
> >  static void cpu_clock_event_del(struct perf_event *event, int flags)
> >  {
> > -       cpu_clock_event_stop(event, flags);
> > +       cpu_clock_event_stop(event, flags | PERF_EF_UPDATE);
> >  }
> >
> >  static void cpu_clock_event_read(struct perf_event *event)
> > @@ -12043,7 +12043,7 @@ static int task_clock_event_add(struct perf_eve=
nt *event, int flags)
> >
> >  static void task_clock_event_del(struct perf_event *event, int flags)
> >  {
> > -       task_clock_event_stop(event, PERF_EF_UPDATE);
> > +       task_clock_event_stop(event, flags | PERF_EF_UPDATE);
> >  }
> >
> >  static void task_clock_event_read(struct perf_event *event)
> >
> > base-commit: 2093d8cf80fa5552d1025a78a8f3a10bf3b6466e
> > prerequisite-patch-id: a15bcd62a8dcd219d17489eef88b66ea5488a2a0
> > prerequisite-patch-id: 2a0eefce67b21d1f30c272fd8115b0dc1aca3897
> > --
> > 2.34.1
> >
