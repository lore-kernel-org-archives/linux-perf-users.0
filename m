Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1397E765
	for <linux-perf-users@vger.kernel.org>; Wed,  9 Oct 2024 16:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728489766; cv=none; b=XRMZw+MvCJSza9lTOTA2HRbsRJ8VbIAsSuaHbTLpRN5b049PCo0VjERJtljT/n4f4spRNCN33s8M09C0X8xja9mCHoqDfxSjQE/F1vaTnBuizx1zXdVB1/nxPC+5pvWOKXibxDgD+CXuIRo1yY4D6PxVIluUxJGlxyBPPW0G3oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728489766; c=relaxed/simple;
	bh=H2fjKECbmvUHh/XYANeYWUUzfalul3ryifCtXo97f0Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LOBUkLQCmdTTPIicXyKB+vUkCJ90nOihI4MEnymlB6yhBDsek1xADprQz7JVqFLfbdW7/bU+qBtHd25WfgZ/MSeuZr6kYkUwIn87QbkTDFkJVNb5dOkC32xP0AIEXkl2ebizUxBDJOyBDNA8ND0PDoNax5LVCX9IhqVWhTGVurk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wWb4TGpU; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wWb4TGpU"
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3a0cb892c6aso337575ab.0
        for <linux-perf-users@vger.kernel.org>; Wed, 09 Oct 2024 09:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728489764; x=1729094564; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vQgQpcQj6lq4p4G3KBQUq7yvBT0GmBIXkTYaFzOz2+Y=;
        b=wWb4TGpU6/a8GEkcM7wm7sKVVpO114Dc8PpM80nlj2RgQly0uClULucHuZcx4N3DnV
         AWqqEwmOmQDeeaLI5iAmt6yNRWU6i6WbMrjls34pe2fDpbjNijmSlQ64zLlapl4cDsIn
         8gsK7sfjZ0VQkvBFshII8WX+Ii+qiLm/OT2Z6khcq2oJU7Wp7IWmlW0vQvABKjwl2x4l
         NeJf23UDdU53nU0gzHlO50KalPu5l+7FZtbVQXCbJTcS0td8N4na75PS+Z6vD/1XmCso
         xY8zOQZJ9JEwEgHLxrJ97A7qmpF1/bmgGD0DhvOzW/09vKT2lW6iV5PnBovvTkYeBvN5
         QSSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728489764; x=1729094564;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vQgQpcQj6lq4p4G3KBQUq7yvBT0GmBIXkTYaFzOz2+Y=;
        b=K/9+bxM81ukFCF5TCQX+pCAdXdyqOk2SzFtBhqebHAdjQees2sD/HyhUAoxLbU6iqQ
         CS/hySax/StufbXg05cWbYD8Hm5bv5o2dPZqswU0PiAYuWahJUGgg1h4bbvieOlfEau+
         +UNLlH4VpXmbFU8wDLzt5rfQqR1ZmbWsBYgS05Pm6p8K2PSx8ltmeZDcIB07rtnNikMF
         aAVRPcaP5LtjJG8mCw+kHkjs2mpI/z0j2me57ancAkEQc/wRuLkoAsMhjrqe1XYnM2RZ
         8plcY2aaa5IO+PRvkUKOS9TGPOm38iXyvCyu3TGzwEbAjTAuS0dbg7eUTw+1tljVFZ0c
         KH0w==
X-Forwarded-Encrypted: i=1; AJvYcCXf+ZI/J3SGNiY4yhAJnDt+e4rmy0Ed+gz0MOWPJCIZbzGSfNyT54gdTtBxeKWCybPlfWcD03VTH6yoZo3QDFfY@vger.kernel.org
X-Gm-Message-State: AOJu0YxFVsSPSNQVYLEjeC8CIYGUNkQ7SazS41eNmo1Wj3iRRX/nJSLY
	Go7fLa9nvlwimKWDe60YBTcsjgjW9Tv7eGAx23csrxrGr6kKHB2p/Ry67WE9eBB5BrJ3PjV/Y1k
	eybuGkBJhtNDKFg+QCcmAFugl/hSCvmve1iEV
X-Google-Smtp-Source: AGHT+IHuDrgRLs8WG6JehCy5Gk2XCY5JTbMR7IPLILrii8luyou3gTgDTJzEc2H7DyksBPPdTpdsAJ4O89ly4r5cqOg=
X-Received: by 2002:a05:6e02:214d:b0:39f:4828:7d7d with SMTP id
 e9e14a558f8ab-3a39808804emr3258245ab.15.1728489763309; Wed, 09 Oct 2024
 09:02:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240926175035.408668-1-irogers@google.com> <bbbd024c-d2df-47ea-9587-f68e5bc45962@linux.intel.com>
In-Reply-To: <bbbd024c-d2df-47ea-9587-f68e5bc45962@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 9 Oct 2024 09:02:28 -0700
Message-ID: <CAP-5=fVX5wypmAAhR8LsE4nSWp5BmN_qhGf9+WCh2bebNcGYTg@mail.gmail.com>
Subject: Re: [PATCH v4 00/22] Python generated Intel metrics
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Perry Taylor <perry.taylor@intel.com>, 
	Samantha Alt <samantha.alt@intel.com>, Caleb Biggers <caleb.biggers@intel.com>, 
	Weilin Wang <weilin.wang@intel.com>, Edward Baker <edward.baker@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 27, 2024 at 11:34=E2=80=AFAM Liang, Kan <kan.liang@linux.intel.=
com> wrote:
>
>
>
> On 2024-09-26 1:50 p.m., Ian Rogers wrote:
> > Generate twenty sets of additional metrics for Intel. Rapl and Idle
> > metrics aren't specific to Intel but are placed here for ease and
> > convenience. Smi and tsx metrics are added so they can be dropped from
> > the per model json files.
>
> Are Smi and tsx metrics the only two metrics who's duplicate metrics in
> the json files will be dropped?

Yes. These metrics with their runtime detection and use of sysfs event
names I feel more naturally fit here rather than in the Intel perfmon
github converter script.

> It sounds like there will be many duplicate metrics in perf list, right?

That's not the goal. There may be memory bandwidth computed in
different ways, like TMA and using uncore, but that seems okay as the
metrics are using different counters so may say different things. I
think there is an action to always watch the metrics and ensure
duplicates don't occur, but some duplication can be beneficial.

> Also, is it an attempt to define some architectural metrics for perf?

There are many advantages of using python to generate the metric json,
a few are:
1) we verify the metrics use events from the event json,
2) the error prone escaping of commas and slashes is handled by the python,
3) metric expressions can be spread over multiple lines and have comments.
It is also an advantage that we can avoid copy-pasting one metric from
one architectural metric json to another. This helps propagate fixes.

So, it's not so much a goal to have architectural metrics but its nice
that we avoid copy-paste. Somewhere where I've tried to set up common
events across all architectures is with making tool have its own PMU.
Rather than have the tool PMU describe events using custom code it
just reuses the existing PMU json support:
https://github.com/googleprodkernel/linux-perf/blob/google_tools_master/too=
ls/perf/pmu-events/arch/common/common/tool.json

> How do you decide which metrics should be added here?

The goal is to try to make open source metrics that Google has
internally. I've set up a git repo for this here:
https://github.com/googleprodkernel/linux-perf
Often the source of the metric is Intel's documentation on things like
uncore events, it's just such metrics aren't part of the perfmon
process and so we're adding them here. Were all these metrics on the
Intel github it'd be reasonable to remove them from here. If Intel
would like to work on or contribute some metrics here, that's also
fine. I think the main thing is to be giving users useful metrics.

Thanks,
Ian

> > There are four uncore sets of metrics and
> > eleven core metrics. Add a CheckPmu function to metric to simplify
> > detecting the presence of hybrid PMUs in events. Metrics with
> > experimental events are flagged as experimental in their description.
> >
> > The patches should be applied on top of:
> > https://lore.kernel.org/lkml/20240926174101.406874-1-irogers@google.com=
/
> >
> > v4. Experimental metric descriptions. Add mesh bandwidth metric. Rebase=
.
> > v3. Swap tsx and CheckPMU patches that were in the wrong order. Some
> >     minor code cleanup changes. Drop reference to merged fix for
> >     umasks/occ_sel in PCU events and for cstate metrics.
> > v2. Drop the cycles breakdown in favor of having it as a common
> >     metric, spelling and other improvements suggested by Kan Liang
> >     <kan.liang@linux.intel.com>.
> >
> > Ian Rogers (22):
> >   perf jevents: Add RAPL metrics for all Intel models
> >   perf jevents: Add idle metric for Intel models
> >   perf jevents: Add smi metric group for Intel models
> >   perf jevents: Add CheckPmu to see if a PMU is in loaded json events
> >   perf jevents: Mark metrics with experimental events as experimental
> >   perf jevents: Add tsx metric group for Intel models
> >   perf jevents: Add br metric group for branch statistics on Intel
> >   perf jevents: Add software prefetch (swpf) metric group for Intel
> >   perf jevents: Add ports metric group giving utilization on Intel
> >   perf jevents: Add L2 metrics for Intel
> >   perf jevents: Add load store breakdown metrics ldst for Intel
> >   perf jevents: Add ILP metrics for Intel
> >   perf jevents: Add context switch metrics for Intel
> >   perf jevents: Add FPU metrics for Intel
> >   perf jevents: Add Miss Level Parallelism (MLP) metric for Intel
> >   perf jevents: Add mem_bw metric for Intel
> >   perf jevents: Add local/remote "mem" breakdown metrics for Intel
> >   perf jevents: Add dir breakdown metrics for Intel
> >   perf jevents: Add C-State metrics from the PCU PMU for Intel
> >   perf jevents: Add local/remote miss latency metrics for Intel
> >   perf jevents: Add upi_bw metric for Intel
> >   perf jevents: Add mesh bandwidth saturation metric for Intel
> >
> >  tools/perf/pmu-events/intel_metrics.py | 1046 +++++++++++++++++++++++-
> >  tools/perf/pmu-events/metric.py        |   52 ++
> >  2 files changed, 1095 insertions(+), 3 deletions(-)
> >
