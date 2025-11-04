Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCA527E1A1
	for <linux-perf-users@vger.kernel.org>; Tue,  4 Nov 2025 05:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762232968; cv=none; b=JusjBUldTZifRFZrOQdd8yyI8znKOWXEW37hf7ZQlJkdfIRiVAjTSsEXMJeovFeU1CwsTEN/Y4/7oqjrTv4uKyFA5oZMHXrI+Tj7BXiNwT5Qtisr+YyWl8+WDJ23HF+k5bU21CzuMcJSkufE+w1zxzLVbe/HIvgQKIJA3x+x13o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762232968; c=relaxed/simple;
	bh=7Rw7Mlw//N16pS2tJLbJ2s4N+2FAj8RHDvDLqq7eXr0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WjFW6cy4jcWFDCMvp+SyQ1N90EIg4gzoYnOgBYGXFmsyfJZMPnSJih4AQcDwDCtWQiKj4Z6fU9GdXdfnrzNmuraaFVZJ69LB6dUGo37CyrhGmx2Qp3mqgSjh6lkUoyMTPjPWiuzU2LpHj7uqljILz9GKXSWNxkxR0J8ZeEHpi5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G2VAMtqZ; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G2VAMtqZ"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-294f3105435so77685ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 03 Nov 2025 21:09:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762232966; x=1762837766; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1H7rP21zZn0qK0QNqH8RbWwYkKpPjn+ZW6EKqkMyinY=;
        b=G2VAMtqZbVQD2cSKLyuv9p5AEmLGI7+DPRsOj6Ois7NkR6rCWkLYLdKbRHCwJUkI07
         OvCITMfYUP4WjdxfvAxs4Rm+EXKVcoc1sP2nk8fVFEhQpTWTuP7qXuHf59wvVdl2qsH2
         oucuw0kXDGFv9oRfRE7RYoVPQjxestF+GqfPEHrrtiraKQxm6joLwEhulYLz8fOwT4+F
         zBc8RjzyFSlx/ICxJLAcPtEMfo88M66Ix+WSUDYbgT2+o6lbqwhhCfZnxHDMef4kFIVe
         RDNH12yl4p6DXbIVGomH+pUeXm8LtHH8fIRun8FI+XUt7iSNutAw16hlxapG1c1tV8DL
         mRTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762232966; x=1762837766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1H7rP21zZn0qK0QNqH8RbWwYkKpPjn+ZW6EKqkMyinY=;
        b=PduHm9cSKK1sz3Q3LYcGLnhDO44OFBR032sxl7SamOY5Zpocgd/DFIX8gQXe2kFKEQ
         3rqB2VNk8dDVE3JM3RfU+uUKwDQzeHD25B2MCriOwqOXGJVLVzHsYR+EJNIZPrOzgX0s
         fQFahr78Yjr44T7ntDpeoSPJmkay9f3HNu4JC6DIZT33WiMZGbFj6+J7EDg2MoEbTNCf
         XWkTtb4hIYaHSTKzPiYHGguxDIjFvCx0nu8q1ObVwenisv++C7vJJZwkkdcksbM08ODb
         WMawUB0M4o7TGcSyEnabBZlP3Xidwh8FfXIKP2AqB31xN3g4vF8BehicPyF/LcBdavFw
         +SlA==
X-Forwarded-Encrypted: i=1; AJvYcCXJsydHYVFb18j1M3IafthUZmjSyfVQ14AhtyXBXBAhXsRSgJSuo0B5KWw4a2FMpZhDnYOAOZ8RC0wdmct0HAKY@vger.kernel.org
X-Gm-Message-State: AOJu0Yyze4aeaNv3T9V5CZ2a8AlJXTvTbelHI6y0ZONp6qk4Dz2UUjDw
	kfZHCK2MxAZibzGmr3NeeJyscK1SiDVc8R06giHrOADdeBrw0Gc22PKFTcWbiIniwBqXSsCaAOl
	e7diokHt3XHQoWaKEdMvaa+BoKOUwXkJE6Y1z80R3
X-Gm-Gg: ASbGncsAtRpLEB1LchPIoPqZuNKhJZCSJA84OOaiGzXjUGStgO2BtXI6FVmrM2nkZzt
	oBVZnjgZKfFFZk1Qg9AmKq3scPHaytf96JCYUBwuLZt9SGGiDrTlCtM05ro5r/g0xA/ZmdlPa3Z
	4WNTRAl1HcHVpQIHGhMs//og0q//bJFSxkz/exooVwtk3zePNKUo0B6KRmevNIKzsoSZLdVNquB
	hl/0Sc3OAIp3cUmvvl5hchE89J2DSQeMTWVV2zkjgBIY8dxGAXliRCv0dHyRBZVV+NvdcY=
X-Google-Smtp-Source: AGHT+IEJW4qZVXTJVnwrrok47BFsLqodC41A3mt9PojgUB+uEjajtfHl3bARmhAFZurVRZAfr+aFsCAfZg/TRNI2jt4=
X-Received: by 2002:a17:902:da87:b0:295:28a4:f0f5 with SMTP id
 d9443c01a7336-29601dfad59mr2052405ad.5.1762232965661; Mon, 03 Nov 2025
 21:09:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251024175857.808401-1-irogers@google.com> <aQmFV7fqURMXQNHC@google.com>
In-Reply-To: <aQmFV7fqURMXQNHC@google.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 3 Nov 2025 21:09:14 -0800
X-Gm-Features: AWmQ_bkJadQtciCiQLhwfNPZXuNPfAf5iarrS7pL6fGgXssdwSV9IzDjETwaaYE
Message-ID: <CAP-5=fWv1JtKumMpX7Ck+K4ttXTKW-zDQZYen0MxzV1B7VizaQ@mail.gmail.com>
Subject: Re: [PATCH v1 00/22] Switch the default perf stat metrics to json
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Xu Yang <xu.yang_2@nxp.com>, 
	Chun-Tse Shao <ctshao@google.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Sumanth Korikkar <sumanthk@linux.ibm.com>, Collin Funk <collin.funk1@gmail.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Howard Chu <howardchu95@gmail.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Levi Yun <yeoreum.yun@arm.com>, 
	Yang Li <yang.lee@linux.alibaba.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 3, 2025 at 8:47=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> Hi Ian,
>
> On Fri, Oct 24, 2025 at 10:58:35AM -0700, Ian Rogers wrote:
> > Prior to this series stat-shadow would produce hard coded metrics if
> > certain events appeared in the evlist. This series produces equivalent
> > json metrics and cleans up the consequences in tests and display
> > output. A before and after of the default display output on a
> > tigerlake is:
> >
> > Before:
> > ```
> > $ perf stat -a sleep 1
> >
> >  Performance counter stats for 'system wide':
> >
> >     16,041,816,418      cpu-clock                        #   15.995 CPU=
s utilized
> >              5,749      context-switches                 #  358.376 /se=
c
> >                121      cpu-migrations                   #    7.543 /se=
c
> >              1,806      page-faults                      #  112.581 /se=
c
> >        825,965,204      instructions                     #    0.70  ins=
n per cycle
> >      1,180,799,101      cycles                           #    0.074 GHz
> >        168,945,109      branches                         #   10.532 M/s=
ec
> >          4,629,567      branch-misses                    #    2.74% of =
all branches
> >  #     30.2 %  tma_backend_bound
> >                                                   #      7.8 %  tma_bad=
_speculation
> >                                                   #     47.1 %  tma_fro=
ntend_bound
> >  #     14.9 %  tma_retiring
> > ```
> >
> > After:
> > ```
> > $ perf stat -a sleep 1
> >
> >  Performance counter stats for 'system wide':
> >
> >              2,890      context-switches                 #    179.9 cs/=
sec  cs_per_second
> >     16,061,923,339      cpu-clock                        #     16.0 CPU=
s  CPUs_utilized
> >                 43      cpu-migrations                   #      2.7 mig=
rations/sec  migrations_per_second
> >              5,645      page-faults                      #    351.5 fau=
lts/sec  page_faults_per_second
> >          5,708,413      branch-misses                    #      1.4 %  =
branch_miss_rate         (88.83%)
> >        429,978,120      branches                         #     26.8 K/s=
ec  branch_frequency     (88.85%)
> >      1,626,915,897      cpu-cycles                       #      0.1 GHz=
  cycles_frequency       (88.84%)
> >      2,556,805,534      instructions                     #      1.5 ins=
tructions  insn_per_cycle  (88.86%)
> >                         TopdownL1                 #     20.1 %  tma_bac=
kend_bound
> >                                                   #     40.5 %  tma_bad=
_speculation      (88.90%)
> >                                                   #     17.2 %  tma_fro=
ntend_bound       (78.05%)
> >                                                   #     22.2 %  tma_ret=
iring             (88.89%)
> >
> >        1.002994394 seconds time elapsed
> > ```
>
> While this looks nicer, I worry about the changes in the output.  And I'm
> curious why only the "After" output shows the multiplexing percent.
>
> >
> > Having the metrics in json brings greater uniformity, allows events to
> > be shared by metrics, and it also allows descriptions like:
> > ```
> > $ perf list cs_per_second
> > ...
> >   cs_per_second
> >        [Context switches per CPU second]
> > ```
> >
> > A thorn in the side of doing this work was that the hard coded metrics
> > were used by perf script with '-F metric'. This functionality didn't
> > work for me (I was testing `perf record -e instructions,cycles` and
> > then `perf script -F metric` but saw nothing but empty lines)
>
> The documentation says:
>
>         With the metric option perf script can compute metrics for
>         sampling periods, similar to perf stat. This requires
>         specifying a group with multiple events defining metrics with the=
 :S option
>         for perf record. perf will sample on the first event, and
>         print computed metrics for all the events in the group. Please no=
te
>         that the metric computed is averaged over the whole sampling
>         period (since the last sample), not just for the sample point.
>
> So I guess it should have 'S' modifiers in a group.

Thanks Namhyung. Yes, this is the silly behavior where leader sample
events are both treated as an event but then the constituent parts
turned into individual events with the period set to the leader sample
read counts. Most recently this behavior was disabled by struct
perf_tool's dont_split_sample_group in the case of perf inject as it
causes events to be processed multiple times. The perf script behavior
doesn't rely anywhere on the grouping of the leader sample events and
even with it the metric format option doesn't work either - I'll save
pasting a screen full of blank lines here.

> > but anyway I decided to fix it to the best of my ability in this
> > series. So the script side counters were removed and the regular ones
> > associated with the evsel used. The json metrics were all searched
> > looking for ones that have a subset of events matching those in the
> > perf script session, and all metrics are printed. This is kind of
> > weird as the counters are being set by the period of samples, but I
> > carried the behavior forward. I suspect there needs to be follow up
> > work to make this better, but what is in the series is superior to
> > what is currently in the tree. Follow up work could include finding
> > metrics for the machine in the perf.data rather than using the host,
> > allowing multiple metrics even if the metric ids of the events differ,
> > fixing pre-existing `perf stat record/report` issues, etc.
> >
> > There is a lot of stat tests that, for example, assume '-e
> > instructions,cycles' will produce an IPC metric. These things needed
> > tidying as now the metric must be explicitly asked for and when doing
> > this ones using software events were preferred to increase
> > compatibility. As the test updates were numerous they are distinct to
> > the patches updating the functionality causing periods in the series
> > where not all tests are passing. If this is undesirable the test fixes
> > can be squashed into the functionality updates.
>
> Hmm.. how many of them?  I think it'd better to have the test changes at
> the same time so that we can assure test success count after the change.
> Can the test changes be squashed into one or two commits?

So the patches are below. The first set are all clean up:

> > Ian Rogers (22):
> >   perf evsel: Remove unused metric_events variable
> >   perf metricgroup: Update comment on location of metric_event list
> >   perf metricgroup: Missed free on error path
> >   perf metricgroup: When copy metrics copy default information
> >   perf metricgroup: Add care to picking the evsel for displaying a
> >     metric
> >   perf jevents: Make all tables static

Then there is the addition of the legacy metrics as json:

> >   perf expr: Add #target_cpu literal
> >   perf jevents: Add set of common metrics based on default ones
> >   perf jevents: Add metric DefaultShowEvents
> >   perf stat: Add detail -d,-dd,-ddd metrics

Then there is the change to make perf script metric format work:

> >   perf script: Change metric format to use json metrics

Then there is a clean up patch:

> >   perf stat: Remove hard coded shadow metrics

Then there are fixes to perf stat's already broken output:

> >   perf stat: Fix default metricgroup display on hybrid
> >   perf stat: Sort default events/metrics
> >   perf stat: Remove "unit" workarounds for metric-only

Then there are 7 patches updating test expectations. Each patch deals
with a separate test to make the resolution clear.

> >   perf test stat+json: Improve metric-only testing
> >   perf test stat: Ignore failures in Default[234] metricgroups
> >   perf test stat: Update std_output testing metric expectations
> >   perf test metrics: Update all metrics for possibly failing default
> >     metrics
> >   perf test stat: Update shadow test to use metrics
> >   perf test stat: Update test expectations and events
> >   perf test stat csv: Update test expectations and events

The patch "perf jevents: Add set of common metrics based on default
ones" most impacts the output but we don't want to verify the default
stat output with the hardcoded metrics that are removed in "perf stat:
Remove hard coded shadow metrics". Having a test for both hard coded
and json metrics in an intermediate state makes little sense and the
default output is impacting by the 3 patches fixing it and removing
workarounds.

It is possible to squash things together but I think something is lost
in doing so, hence presenting it this way.

Thanks,
Ian
