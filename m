Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA2730F7F5
	for <linux-perf-users@vger.kernel.org>; Wed, 19 Nov 2025 18:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763577038; cv=none; b=qy8W6N+E9Jp0wzQHTI3ZnkK5Qokfgv34rz8fwzDhlJOcaItygc3gHfS8A3A7he02m8Zl/ZXfN4YdOHMO7b1/kGlpfhyjPMejSN6pVgjdF95xeLPovFG8ddZ+SwwDGA1Xywj497scj7wuLwWRefJCyVuoSxDRtMkyGdGYVUrWkn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763577038; c=relaxed/simple;
	bh=cG/QXdb2yDgDv5HACyHe6eY050zexJLBHvlvsoi6uoc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=C5DHS2oO4hqeddb79JqMjXKmowXresxjr6/hGcRcq8/NIuznQsEhUWPJ0V+WU0GNfy8T/qOmX6woYrVo39MTtI4HiXATBb/GLP5hnSfjtV98iNHiFokFJsEs/2mB/c9bjEfFFhVwjVIil3qFr4Kt673j+iLJyZE2v0/BSU/TgUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TOjRrDsq; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TOjRrDsq"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-297e13bf404so11675ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 19 Nov 2025 10:30:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763577029; x=1764181829; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iQT82guLpIAKIGtGT+Cfrl0wPNaltewZYg1YgypIuPM=;
        b=TOjRrDsqlEH0MsQeESXdjpC81QHZS28UCWsb79+AiYKWrFJ55C5+X3x1SzkJhp8dK5
         SumU1GuHAJpxSFFykH3WCrXm4qmiA/h/1JTF+T0SSj4e8iy1xEKVdPMtrwJp1BEPHWHc
         Iz7ODgk+69WQ0qBQI/r3H5Bh3TJR2Vru+glG85s7mVt8RiIWSdJVR9UIrxkfCt5Rd/Lr
         pTqwDGCKPC9FAClXGSq81IuL6QjSkQM33p5pAvkHYGRemmnrDwKdfgN1sPlgzJpPaRyQ
         UsbkticCXRav50iVMRqv5P2ORYlsbiC0L7gYzO8h85mgGNakTgjkG//Dd44M3RRV2cPP
         w87w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763577029; x=1764181829;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iQT82guLpIAKIGtGT+Cfrl0wPNaltewZYg1YgypIuPM=;
        b=C6tpy/nZFh+dC5gDXNb86owcWMKmqXX4pyl1A7t/I0kTOF4v0rypqtxp3m3J2D/BKf
         o6PXh8jizumLB5Ot05HT5dj6K2no7GFhHsWMuV3zhSn68HUw5pii7mjwKrzfvsGKqLdg
         hpbyT+6/bXSN7/Iy0aWd6P+fJ59kfpqU0XGIOlW+dc2U2p5yshzP7wLIYtCE6j9TG4aW
         8DjBMzG8CPrrnrc2VF9yWNRKDeIpG+i+SeZNhDYc8hhdZ6vEchmzFIswm2W5OfNnMy4A
         spxM7W/eAID89DVWSsMef+WTSnq1rPQymQaA9wyXGN87ejj+Z4Evnfnx8CirUEHs5XHF
         l9cQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXevE5UZ42vb8nZpP2d/9QFxzPls7u303f7XGMKHKe/EB12LYCne3RE34fjCMYFyBOdXNSXbsTiAqfvQnoYTO9@vger.kernel.org
X-Gm-Message-State: AOJu0YwyPSLlUqoJtu9cFwCe9r4COBB0fUQY31+fKTHNyi7hU6Sv02+G
	yiuNDdiFcpFh/9SFN2XG/IrUCUVQwNBD/Ejq8P97zKLDGy7kDDbuX5aswkX2ky7x+dVks4uvWzC
	u8l30W3ZYPvc2hY6QiJCJS/CTi12o5nAI3jeAgPW2
X-Gm-Gg: ASbGncu7oINZjDQeE4q/bJI6eaRaqQeQB1HAeMeVNvJD0/xhA+STLDorD/hQZ7howPw
	r0HSPssOcf1DXViFt2SyqjDw4YMEdLOfxqotz038HqPhqeUw0SESqTIN2jk/jVns5Ez+KBT8xqC
	gcs91q5ZbQjkSAeF4odHDDkTgeLoKsGWSt9KgFIVBNpzn8ZMJAcRq6xkfPuwyZKa/rXQF/WKDee
	Bjq9Hrws2jeBPJjuyUVGaOtpmzzRAsy4HwMC9VSuMiN29xiOOeYm49gPDxXuMIQyj9zKcE3SNgd
	lDPGUed/nuiLs7tXe+hg7jB7yIzBeSYek3MM
X-Google-Smtp-Source: AGHT+IGWAuJ9WLyoyLZ2qz2N1g2Fo4cuXfrY96XSYkEeWz6Q/BBPwLPdr4OGMPzONq2syrKa6f0McpHwK3J2z3P5/sE=
X-Received: by 2002:a17:902:f54c:b0:299:c367:9e03 with SMTP id
 d9443c01a7336-29b5c578062mr84505ad.18.1763577028679; Wed, 19 Nov 2025
 10:30:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251113032040.1994090-1-irogers@google.com>
In-Reply-To: <20251113032040.1994090-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 19 Nov 2025 10:30:17 -0800
X-Gm-Features: AWmQ_blipZBvo-BWJZAic_R7M2qQYu8qVVI5hKFxoe4mIO8D0qf0tziYZzD9TlQ
Message-ID: <CAP-5=fVw7bQVTK5FA4LXbPgh0gOaVk+zsF4XDx2hU4mRr+mSNA@mail.gmail.com>
Subject: Re: [PATCH v8 00/52] AMD, ARM, Intel metric generation with Python
To: Adrian Hunter <adrian.hunter@intel.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Benjamin Gray <bgray@linux.ibm.com>, 
	Caleb Biggers <caleb.biggers@intel.com>, Edward Baker <edward.baker@intel.com>, 
	Ian Rogers <irogers@google.com>, Ingo Molnar <mingo@redhat.com>, 
	James Clark <james.clark@linaro.org>, Jing Zhang <renyu.zj@linux.alibaba.com>, 
	Jiri Olsa <jolsa@kernel.org>, John Garry <john.g.garry@oracle.com>, Leo Yan <leo.yan@arm.com>, 
	Namhyung Kim <namhyung@kernel.org>, Perry Taylor <perry.taylor@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Samantha Alt <samantha.alt@intel.com>, 
	Sandipan Das <sandipan.das@amd.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Weilin Wang <weilin.wang@intel.com>, Xu Yang <xu.yang_2@nxp.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2025 at 7:20=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> Metrics in the perf tool come in via json. Json doesn't allow
> comments, line breaks, etc. making it an inconvenient way to write
> metrics. Further, it is useful to detect when writing a metric that
> the event specified is supported within the event json for a
> model. From the metric python code Event(s) are used, with fallback
> events provided, if no event is found then an exception is thrown and
> that can either indicate a failure or an unsupported model. To avoid
> confusion all the metrics and their metricgroups are prefixed with
> 'lpm_', where LPM is an abbreviation of Linux Perf Metric. While extra
> characters aren't ideal, this separates the metrics from other vendor
> provided metrics.
>
> * The first 14 patches introduce infrastructure and fixes for the
>   addition of metrics written in python for Arm64, AMD Zen and Intel
>   CPUs. The ilist.py and perf python module are fixed to work better
>   with metrics on hybrid architectures.
>
> * The next 13 patches generate additional metrics for AMD zen.  Rapl
>   and Idle metrics aren't specific to AMD but are placed here for ease
>   and convenience. Uncore L3 metrics are added along with the majority
>   of core metrics.
>
> * The next 20 patches add additional metrics for Intel. Rapl and Idle
>   metrics aren't specific to Intel but are placed here for ease and
>   convenience. Smi and tsx metrics are added so they can be dropped
>   from the per model json files. There are four uncore sets of metrics
>   and eleven core metrics. Add a CheckPmu function to metric to
>   simplify detecting the presence of hybrid PMUs in events. Metrics
>   with experimental events are flagged as experimental in their
>   description.
>
> * The next 2 patches add additional metrics for Arm64, where the
>   topdown set decomposes yet further. The metrcs primarily use json
>   events, where the json contains architecture standard events. Not
>   all events are in the json, such as for a53 where the events are in
>   sysfs. Workaround this by adding the sysfs events to the metrics but
>   longer-term such events should be added to the json.
>
> * The final patch validates that all events provided to an Event
>   object exist in a json file somewhere. This is to avoid mistakes
>   like unfortunate typos.
>
> This series has benefitted from the input of Leo Yan
>  <leo.yan@arm.com>, Sandipan Das <sandidas@amd.com>, Thomas Falcon
>  <thomas.falcon@intel.com> and Perry Taylor <perry.taylor@intel.com>.

Thanks for helping push this forward. Other than forgetting to
add/copy tags I'm unaware of anything missing in this series and I'd
be happy to stop rebasing it by having it land.

> v8. Combine the previous 4 series for clarity. Rebase on top of the
>     more recent legacy metric and event changes. Make the python more
>     pep8 and pylint compliant.
>
> Foundations:
> v6. Fix issue with '\-' escape not being '\\-' (reported-by Sandipan
>     Das <sandidas@amd.com>) which didn't alter the generated json.
>     https://lore.kernel.org/lkml/20250904043208.995243-1-irogers@google.c=
om/
>
> v5. Rebase on top of legacy hardware/cache changes that now generate
>     events using python:
>     https://lore.kernel.org/lkml/20250828205930.4007284-1-irogers@google.=
com/
>     the v5 series is:
>     https://lore.kernel.org/lkml/20250829030727.4159703-1-irogers@google.=
com/
>
> v4. Rebase and small Build/Makefile tweak
>     https://lore.kernel.org/lkml/20240926173554.404411-1-irogers@google.c=
om/
>
> v3. Some code tidying, make the input directory a command line
>     argument, but no other functional or output changes.
>     https://lore.kernel.org/lkml/20240314055051.1960527-1-irogers@google.=
com/
>
> v2. Fixes two type issues in the python code but no functional or
>     output changes.
>     https://lore.kernel.org/lkml/20240302005950.2847058-1-irogers@google.=
com/
>
> v1. https://lore.kernel.org/lkml/20240302005950.2847058-1-irogers@google.=
com/
>
> AMD:
> v6. Fix issue with '\-' escape not being '\\-' (reported-by Sandipan
>     Das <sandidas@amd.com>) which didn't alter the generated json.
>     https://lore.kernel.org/lkml/20250904044047.999031-1-irogers@google.c=
om/
>
> v5. Rebase. Add uop cache hit/miss rates patch. Prefix all metric
>     names with lpm_ (short for Linux Perf Metric) so that python
>     generated metrics are clearly namespaced.
>     https://lore.kernel.org/lkml/20250829033138.4166591-1-irogers@google.=
com/
>
> v4. Rebase.
>     https://lore.kernel.org/lkml/20240926174101.406874-1-irogers@google.c=
om/
>
> v3. Some minor code cleanup changes.
>     https://lore.kernel.org/lkml/20240314055839.1975063-1-irogers@google.=
com/
>
> v2. Drop the cycles breakdown in favor of having it as a common
>     metric, suggested by Kan Liang <kan.liang@linux.intel.com>.
>     https://lore.kernel.org/lkml/20240301184737.2660108-1-irogers@google.=
com/
>
> v1. https://lore.kernel.org/lkml/20240229001537.4158049-1-irogers@google.=
com/
>
> Intel:
> v6. Fix issue with '\-' escape not being '\\-' (reported-by Sandipan
>     Das <sandidas@amd.com>) which didn't alter the generated json.
>     https://lore.kernel.org/lkml/20250904044653.1002362-1-irogers@google.=
com/
>
> v5. Rebase. Fix description for smi metric (Kan). Prefix all metric
>     names with lpm_ (short for Linux Perf Metric) so that python
>     generated metrics are clearly namespaced. Kan requested a
>     namespace in his review:
>     https://lore.kernel.org/lkml/43548903-b7c8-47c4-b1da-0258293ecbd4@lin=
ux.intel.com/
>     The v5 series is:
>     https://lore.kernel.org/lkml/20250829041104.4186320-1-irogers@google.=
com/
>
> v4. Experimental metric descriptions. Add mesh bandwidth metric. Rebase.
>     https://lore.kernel.org/lkml/20240926175035.408668-1-irogers@google.c=
om/
>
> v3. Swap tsx and CheckPMU patches that were in the wrong order. Some
>     minor code cleanup changes. Drop reference to merged fix for
>     umasks/occ_sel in PCU events and for cstate metrics.
>     https://lore.kernel.org/lkml/20240314055919.1979781-1-irogers@google.=
com/
>
> v2. Drop the cycles breakdown in favor of having it as a common
>     metric, spelling and other improvements suggested by Kan Liang
>     <kan.liang@linux.intel.com>.
>     https://lore.kernel.org/lkml/20240301185559.2661241-1-irogers@google.=
com/
>
> v1. https://lore.kernel.org/lkml/20240229001806.4158429-1-irogers@google.=
com/
>
> ARM:
> v7. Switch a use of cycles to cpu-cycles due to ARM having too many
>     cycles events.
>     https://lore.kernel.org/lkml/20250904194139.1540230-1-irogers@google.=
com/
>
> v6. Fix issue with '\-' escape not being '\\-' (reported-by Sandipan
>     Das <sandidas@amd.com>) which didn't alter the generated json.
>     https://lore.kernel.org/lkml/20250904045253.1007052-1-irogers@google.=
com/
>
> v5. Rebase. Address review comments from Leo Yan
>     <leo.yan@arm.com>. Prefix all metric names with lpm_ (short for
>     Linux Perf Metric) so that python generated metrics are clearly
>     namespaced. Use cpu-cycles rather than cycles legacy event for
>     cycles metrics to avoid confusion with ARM PMUs. Add patch that
>     checks events to ensure all possible event names are present in at
>     least one json file.
>     https://lore.kernel.org/lkml/20250829053235.21994-1-irogers@google.co=
m/
>
> v4. Tweak to build dependencies and rebase.
>     https://lore.kernel.org/lkml/20240926175709.410022-1-irogers@google.c=
om/
>
> v3. Some minor code cleanup changes.
>     https://lore.kernel.org/lkml/20240314055801.1973422-1-irogers@google.=
com/
>
> v2. The cycles metrics are now made common and shared with AMD and
>     Intel, suggested by Kan Liang <kan.liang@linux.intel.com>. This
>     assumes these patches come after the AMD and Intel sets.
>     https://lore.kernel.org/lkml/20240301184942.2660478-1-irogers@google.=
com/
>
> v1. https://lore.kernel.org/lkml/20240229001325.4157655-1-irogers@google.=
com/
>
> Ian Rogers (52):
>   perf python: Correct copying of metric_leader in an evsel
>   perf ilist: Be tolerant of reading a metric on the wrong CPU
>   perf jevents: Allow multiple metricgroups.json files
>   perf jevents: Update metric constraint support
>   perf jevents: Add descriptions to metricgroup abstraction
>   perf jevents: Allow metric groups not to be named
>   perf jevents: Support parsing negative exponents
>   perf jevents: Term list fix in event parsing
>   perf jevents: Add threshold expressions to Metric
>   perf jevents: Move json encoding to its own functions
>   perf jevents: Drop duplicate pending metrics
>   perf jevents: Skip optional metrics in metric group list
>   perf jevents: Build support for generating metrics from python
>   perf jevents: Add load event json to verify and allow fallbacks
>   perf jevents: Add RAPL event metric for AMD zen models
>   perf jevents: Add idle metric for AMD zen models
>   perf jevents: Add upc metric for uops per cycle for AMD
>   perf jevents: Add br metric group for branch statistics on AMD
>   perf jevents: Add software prefetch (swpf) metric group for AMD
>   perf jevents: Add hardware prefetch (hwpf) metric group for AMD
>   perf jevents: Add itlb metric group for AMD
>   perf jevents: Add dtlb metric group for AMD
>   perf jevents: Add uncore l3 metric group for AMD
>   perf jevents: Add load store breakdown metrics ldst for AMD
>   perf jevents: Add ILP metrics for AMD
>   perf jevents: Add context switch metrics for AMD
>   perf jevents: Add uop cache hit/miss rates for AMD

Starting here:

>   perf jevents: Add RAPL metrics for all Intel models
>   perf jevents: Add idle metric for Intel models
>   perf jevents: Add CheckPmu to see if a PMU is in loaded json events
>   perf jevents: Add smi metric group for Intel models
>   perf jevents: Mark metrics with experimental events as experimental
>   perf jevents: Add tsx metric group for Intel models
>   perf jevents: Add br metric group for branch statistics on Intel
>   perf jevents: Add software prefetch (swpf) metric group for Intel
>   perf jevents: Add ports metric group giving utilization on Intel
>   perf jevents: Add L2 metrics for Intel
>   perf jevents: Add load store breakdown metrics ldst for Intel
>   perf jevents: Add ILP metrics for Intel
>   perf jevents: Add context switch metrics for Intel
>   perf jevents: Add FPU metrics for Intel
>   perf jevents: Add Miss Level Parallelism (MLP) metric for Intel
>   perf jevents: Add mem_bw metric for Intel
>   perf jevents: Add local/remote "mem" breakdown metrics for Intel
>   perf jevents: Add dir breakdown metrics for Intel
>   perf jevents: Add C-State metrics from the PCU PMU for Intel
>   perf jevents: Add local/remote miss latency metrics for Intel
>   perf jevents: Add upi_bw metric for Intel
>   perf jevents: Add mesh bandwidth saturation metric for Intel

to here, I missed adding Thomas' Tested-by tag:
https://lore.kernel.org/lkml/8630f8dd4ff3ef050b3517b86ffa9fcae695e675.camel=
@intel.com/

>   perf jevents: Add collection of topdown like metrics for arm64
>   perf jevents: Add cycles breakdown metric for arm64/AMD/Intel

Leo had an lgtm comment for an earlier version of this patch here:
https://lore.kernel.org/lkml/e9c77ce7-0bfb-41cf-9034-2d96359a30a8@arm.com/

>   perf jevents: Validate that all names given an Event

Thanks,
Ian

>  tools/perf/.gitignore                   |    5 +
>  tools/perf/Makefile.perf                |    2 +
>  tools/perf/pmu-events/Build             |   51 +-
>  tools/perf/pmu-events/amd_metrics.py    |  711 ++++++++++++++
>  tools/perf/pmu-events/arm64_metrics.py  |  187 ++++
>  tools/perf/pmu-events/common_metrics.py |   19 +
>  tools/perf/pmu-events/intel_metrics.py  | 1129 +++++++++++++++++++++++
>  tools/perf/pmu-events/jevents.py        |    7 +-
>  tools/perf/pmu-events/metric.py         |  256 ++++-
>  tools/perf/pmu-events/metric_test.py    |    4 +
>  tools/perf/python/ilist.py              |    8 +-
>  tools/perf/util/evsel.c                 |    1 +
>  tools/perf/util/python.c                |   82 +-
>  13 files changed, 2408 insertions(+), 54 deletions(-)
>  create mode 100755 tools/perf/pmu-events/amd_metrics.py
>  create mode 100755 tools/perf/pmu-events/arm64_metrics.py
>  create mode 100644 tools/perf/pmu-events/common_metrics.py
>  create mode 100755 tools/perf/pmu-events/intel_metrics.py
>
> --
> 2.51.2.1041.gc1ab5b90ca-goog
>
