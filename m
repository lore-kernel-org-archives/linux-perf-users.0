Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC8222F75E
	for <linux-perf-users@vger.kernel.org>; Fri, 23 Jan 2026 17:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769188355; cv=pass; b=Aev/vuAFnRo2RaONPR6ECnvyzJi4Jn2LKp5ow0c5f9AavCoST8zEsGVtJpm4bvk3OujGs8NCwDtIULzNiSvCIdMNype0rYeq0FydEmdni0oFX9xy+Fb1CSr6y8+ldgOGaRXfJWKA1amsurpA9Ho8dRkjnFKPsYQ8qiLxK+iTmGE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769188355; c=relaxed/simple;
	bh=J8xt/tcDVEY/Bjj7Gzp3T2jcQxfq/9WQTgZnyOOZFD8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=JQrq/yVB3PUPjjFRkHHl0wGIH8mFM2uPmKkrC0jgh+ihehevr4vnHPub2ViDUjLxIXorUR1Ftl9g9NTXouH+/E2ooXlKDlog6awsLbAHrUhtTN/nNsSvY+fflB0WG/5lUDSKGu3tZhjtFhiolG8Q31/BGJPyHeNEjbMPZ0H/poI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jqyjwxYR; arc=pass smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jqyjwxYR"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2a0d06cfa93so116045ad.1
        for <linux-perf-users@vger.kernel.org>; Fri, 23 Jan 2026 09:12:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769188353; cv=none;
        d=google.com; s=arc-20240605;
        b=UeqDdaghPMHGScXSgFwDjxQsBaKhw9XmsfdC1IOS1QdeKwAWOhyxfkVC3Fx0jQJuRG
         QRfOYyR2xXkZTyack8QjhkMAaMXSUu/AUdqyHyQdDuZqMztdvWgYQ3KLXbcILJMcBGaB
         ZTOIyyN2Esq7dGshDNIgmwKE6jXXjhHxVYEbzSByle9E22CmbewtqfnPxxU/7FIj4RO4
         YNoBCBVJKMcyKPqAYJk2Mo2CD1Cpl8CUB7FdtZUzVeh6+DjBSDitKv4OeDA3jKO3tzp8
         Nufg3Fwg7t7CVUzsB3rn67p0DEHahI3o4BOWtB6CITGj4xzPHfG30p1XP6Dl3w9UYEFo
         yerA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=is8hMYVpZzyQZHWCdB8onKHAzRWHHRdy90a5BDb+wRE=;
        fh=BYDxIfl+emrZb9BJUv7WZ/ypB5gqcDuy9TajQNWm6RY=;
        b=WJ/NvytS6XMJ9bjsbpcX27rT85G+2aNbc2Qfivsn9d/bOzWq/MFLAS4ZECUxir6dKS
         uO2TtvmDwUfczjpyPPm0pvaeKxTV6ISLKmkFGooMxhsB8V4Ra6Frsz8u1ASCHTszwFsE
         bIpcDz8mV2vtZToSQiw8kbwsKsImE0+3a34ovJQMMg48Zzjs8CzVPCNXTPzhDt98pkzg
         NhpKXuNsuQlq1B44+kIq9LrNpvIvUaYkLvz3I4yqA2i0zcadIaxIqfZYDyaB6GenJTcG
         0leSpFpuWh80ZO4WO/Bg8cNa/u95Jw3VfsSA6bWbtTHaabpNRMcKkfb+sBrxX6uxCL0l
         fl9g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769188353; x=1769793153; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=is8hMYVpZzyQZHWCdB8onKHAzRWHHRdy90a5BDb+wRE=;
        b=jqyjwxYRdiimNh+VDGBMDBZnyxsFioEMHRQ+w7r5mVYKl3UhoWBMhWC0+CtTYFavuD
         cSd3VU432pX0ypLKeM8rGeL+GHqHSYVKntxrxfTf4tUtieVGP57XEn5EFWSEMDtAwujH
         p/JVfkkDCkM+sR5c45nJB8o1oNKdz70gLSz7YuO+LtlcxkE/ANGbxZS+SfJshgScSHMV
         god+1w1Oq4bTUPCLYSdHTwMBUaanJo6u+EjqFrn5IsQob9RlVwoM0hMDbFjVwskvjhD8
         74L6k1UuhWQGBBFbrgVqGfvA+ue9+xPvFoKEeTd4oDf8iy5bUmleHv9Tm9Pibngt8nOy
         XtIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769188353; x=1769793153;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=is8hMYVpZzyQZHWCdB8onKHAzRWHHRdy90a5BDb+wRE=;
        b=ZxFy2d7XVKAekA372IzR+q5BAZ/2Un2gY5SrL9HMg9MZcUC+T16y4pJSCb1WsBn8gn
         owKNQFSP7wZJsmmLNLfSgVqoJ0zFGa/i+TCantYgMTN68YNPme3ewFBZTlMv1LgLCeHu
         UYXAvc+FpkPdlY/X/VptcfyNhxDXs2OeItDDebxeDFhwcQZOjtu/b+2rL6MYF+K8Z1UI
         g/YpZI3bzZvw1xBjOXHtx2XiFH/hqcBxRbPqtYrr4nLa1eMGHRpLFYTUTsN8BqJxk5Lb
         g7zvcF7C1hlVF7cEBSPDnxOqe3YIKxgFYsO/cz9KSUPFI084MPmG2DuNNF9OOsk5i/2K
         bRhA==
X-Forwarded-Encrypted: i=1; AJvYcCUP282rIyxgKKgDXI0zi6XpJH6Q/bPJ6vr6cfOq/xVybRvXTt7nnQlV5nITSyIjKJZGCZi7nUgERP8jUEDKpYRJ@vger.kernel.org
X-Gm-Message-State: AOJu0YyTauG77kk6UnSyRttejHrjNJcFxOpbY1NpwPJ2dPoPrqbBhUu/
	0HCyKpMYliQgeNuG2O4ZEYmZZRJmEwiIBeg+JXrESvjjaB+vHu5GjNpmwQzPBu9Dgm4k8G6cjM7
	K2X2gTp5JIrC8PHbUQH9YhaFYAvRD2dytu85JnPLD
X-Gm-Gg: AZuq6aJ4HlPCBTcjtwTWok/ENHKLWCMUoxIYf1MCxnsC/N6fsM+JPTTRk+SZTGfnIPJ
	Xg4IASsilfTbeOssRkn13l3B1ZD9nwfVRbDqk6taAVjzTso5OLTD0PJvKXpIW/SeWgKAFkdAiqR
	bX9LqBOeMz2b0ZMBnO0zzYtDF4K2prUurUzIc0We5WvonWgMuaAOP7TDHjpBxOtSNfOQpizf9sv
	C5LztA+5NbcJnCk5dFP5nc+Wj9TzoffP4IMdUXPVz1AKzwjtBwfgtp2qzIUFMh8IlKMEuWMnaiV
	1ACqYPEs18kQ9lcp9w1HWKcJRQ==
X-Received: by 2002:a17:903:3d06:b0:2a1:3cdc:7720 with SMTP id
 d9443c01a7336-2a805d41103mr2703105ad.21.1769188352396; Fri, 23 Jan 2026
 09:12:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108191105.695131-1-irogers@google.com> <CAP-5=fV2vRhky59xt1_0oFEiM88k97m8Gx6DD4dO2YRsA96z1A@mail.gmail.com>
In-Reply-To: <CAP-5=fV2vRhky59xt1_0oFEiM88k97m8Gx6DD4dO2YRsA96z1A@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 23 Jan 2026 09:12:20 -0800
X-Gm-Features: AZwV_QiuSmQgDjN1u5pm7HQMhhQJVdcwxk7enhnwyR4dBv0AYyI2Qoa6c1eGMKY
Message-ID: <CAP-5=fUY2DZJ=6DDig-zHQ+G6CU0K4EGVSAsx6E5XLbdc40tLw@mail.gmail.com>
Subject: Re: [PATCH v10 00/35] AMD and Intel metric generation with Python
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

On Mon, Jan 19, 2026 at 9:23=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> On Thu, Jan 8, 2026 at 11:11=E2=80=AFAM Ian Rogers <irogers@google.com> w=
rote:
> >
> > Metrics in the perf tool come in via json. Json doesn't allow
> > comments, line breaks, etc. making it an inconvenient way to write
> > metrics. Further, it is useful to detect when writing a metric that
> > the event specified is supported within the event json for a
> > model. From the metric python code Event(s) are used, with fallback
> > events provided, if no event is found then an exception is thrown and
> > that can either indicate a failure or an unsupported model. To avoid
> > confusion all the metrics and their metricgroups are prefixed with
> > 'lpm_', where LPM is an abbreviation of Linux Perf Metric. While extra
> > characters aren't ideal, this separates the metrics from other vendor
> > provided metrics.
> >
> > * The first 2 patches introduce infrastructure for the addition of
> >   metrics written in python for Arm64, AMD Zen and Intel CPUs.
> >
> > * The next 9 patches generate additional metrics for AMD zen.  Rapl
> >   and Idle metrics aren't specific to AMD but are placed here for ease
> >   and convenience. Uncore L3 metrics are added along with the majority
> >   of core metrics.
> >
> > * The next 22 patches add additional metrics for Intel. Rapl and Idle
> >   metrics aren't specific to Intel but are placed here for ease and
> >   convenience. Smi and tsx metrics are added so they can be dropped
> >   from the per model json files. There are four uncore sets of metrics
> >   and eleven core metrics. Add a CheckPmu function to metric to
> >   simplify detecting the presence of hybrid PMUs in events. Metrics
> >   with experimental events are flagged as experimental in their
> >   description.
> >
> > * The next patch adds a cycles metrics based on perf event modifiers
> >   for AMD, Intel and Arm64.
> >
> > * The final patch validates that all events provided to an Event
> >   object exist in a json file somewhere. This is to avoid mistakes
> >   like unfortunate typos.
> >
> > This series has benefitted from the input of Leo Yan
> >  <leo.yan@arm.com>, Sandipan Das <sandidas@amd.com>, Thomas Falcon
> >  <thomas.falcon@intel.com> and Perry Taylor <perry.taylor@intel.com>.
> >
> > v10. Drop already merged non-vendor patches (Namhyung). Drop "Add
> >      collection of topdown like metrics for arm64" as requested by
> >      James Clark. Update AMD metrics for changes to AMD Zen6 event
> >      names from the series:
> >      https://lore.kernel.org/lkml/cover.1767858676.git.sandipan.das@amd=
.com/
> >
> > v9. Drop (for now) 4 AMD sets of metrics for additional follow up. Add
> >     reviewed-by tags from Sandipan Das (AMD) and tested-by tags from
> >     Thomas Falcon (Intel).
> >     https://lore.kernel.org/lkml/20251202175043.623597-1-irogers@google=
.com/
> >
> > v8. Combine the previous 4 series for clarity. Rebase on top of the
> >     more recent legacy metric and event changes. Make the python more
> >     pep8 and pylint compliant.
> >     https://lore.kernel.org/lkml/20251113032040.1994090-1-irogers@googl=
e.com/
> >
> > Foundations:
> > v6. Fix issue with '\-' escape not being '\\-' (reported-by Sandipan
> >     Das <sandidas@amd.com>) which didn't alter the generated json.
> >     https://lore.kernel.org/lkml/20250904043208.995243-1-irogers@google=
.com/
> >
> > v5. Rebase on top of legacy hardware/cache changes that now generate
> >     events using python:
> >     https://lore.kernel.org/lkml/20250828205930.4007284-1-irogers@googl=
e.com/
> >     the v5 series is:
> >     https://lore.kernel.org/lkml/20250829030727.4159703-1-irogers@googl=
e.com/
> >
> > v4. Rebase and small Build/Makefile tweak
> >     https://lore.kernel.org/lkml/20240926173554.404411-1-irogers@google=
.com/
> >
> > v3. Some code tidying, make the input directory a command line
> >     argument, but no other functional or output changes.
> >     https://lore.kernel.org/lkml/20240314055051.1960527-1-irogers@googl=
e.com/
> >
> > v2. Fixes two type issues in the python code but no functional or
> >     output changes.
> >     https://lore.kernel.org/lkml/20240302005950.2847058-1-irogers@googl=
e.com/
> >
> > v1. https://lore.kernel.org/lkml/20240302005950.2847058-1-irogers@googl=
e.com/
> >
> > AMD:
> > v6. Fix issue with '\-' escape not being '\\-' (reported-by Sandipan
> >     Das <sandidas@amd.com>) which didn't alter the generated json.
> >     https://lore.kernel.org/lkml/20250904044047.999031-1-irogers@google=
.com/
> >
> > v5. Rebase. Add uop cache hit/miss rates patch. Prefix all metric
> >     names with lpm_ (short for Linux Perf Metric) so that python
> >     generated metrics are clearly namespaced.
> >     https://lore.kernel.org/lkml/20250829033138.4166591-1-irogers@googl=
e.com/
> >
> > v4. Rebase.
> >     https://lore.kernel.org/lkml/20240926174101.406874-1-irogers@google=
.com/
> >
> > v3. Some minor code cleanup changes.
> >     https://lore.kernel.org/lkml/20240314055839.1975063-1-irogers@googl=
e.com/
> >
> > v2. Drop the cycles breakdown in favor of having it as a common
> >     metric, suggested by Kan Liang <kan.liang@linux.intel.com>.
> >     https://lore.kernel.org/lkml/20240301184737.2660108-1-irogers@googl=
e.com/
> >
> > v1. https://lore.kernel.org/lkml/20240229001537.4158049-1-irogers@googl=
e.com/
> >
> > Intel:
> > v6. Fix issue with '\-' escape not being '\\-' (reported-by Sandipan
> >     Das <sandidas@amd.com>) which didn't alter the generated json.
> >     https://lore.kernel.org/lkml/20250904044653.1002362-1-irogers@googl=
e.com/
> >
> > v5. Rebase. Fix description for smi metric (Kan). Prefix all metric
> >     names with lpm_ (short for Linux Perf Metric) so that python
> >     generated metrics are clearly namespaced. Kan requested a
> >     namespace in his review:
> >     https://lore.kernel.org/lkml/43548903-b7c8-47c4-b1da-0258293ecbd4@l=
inux.intel.com/
> >     The v5 series is:
> >     https://lore.kernel.org/lkml/20250829041104.4186320-1-irogers@googl=
e.com/
> >
> > v4. Experimental metric descriptions. Add mesh bandwidth metric. Rebase=
.
> >     https://lore.kernel.org/lkml/20240926175035.408668-1-irogers@google=
.com/
> >
> > v3. Swap tsx and CheckPMU patches that were in the wrong order. Some
> >     minor code cleanup changes. Drop reference to merged fix for
> >     umasks/occ_sel in PCU events and for cstate metrics.
> >     https://lore.kernel.org/lkml/20240314055919.1979781-1-irogers@googl=
e.com/
> >
> > v2. Drop the cycles breakdown in favor of having it as a common
> >     metric, spelling and other improvements suggested by Kan Liang
> >     <kan.liang@linux.intel.com>.
> >     https://lore.kernel.org/lkml/20240301185559.2661241-1-irogers@googl=
e.com/
> >
> > v1. https://lore.kernel.org/lkml/20240229001806.4158429-1-irogers@googl=
e.com/
> >
> > ARM:
> >
> > v7. Switch a use of cycles to cpu-cycles due to ARM having too many
> >     cycles events.
> >     https://lore.kernel.org/lkml/20250904194139.1540230-1-irogers@googl=
e.com/
> >
> > v6. Fix issue with '\-' escape not being '\\-' (reported-by Sandipan
> >     Das <sandidas@amd.com>) which didn't alter the generated json.
> >     https://lore.kernel.org/lkml/20250904045253.1007052-1-irogers@googl=
e.com/
> >
> > v5. Rebase. Address review comments from Leo Yan
> >     <leo.yan@arm.com>. Prefix all metric names with lpm_ (short for
> >     Linux Perf Metric) so that python generated metrics are clearly
> >     namespaced. Use cpu-cycles rather than cycles legacy event for
> >     cycles metrics to avoid confusion with ARM PMUs. Add patch that
> >     checks events to ensure all possible event names are present in at
> >     least one json file.
> >     https://lore.kernel.org/lkml/20250829053235.21994-1-irogers@google.=
com/
> >
> > v4. Tweak to build dependencies and rebase.
> >     https://lore.kernel.org/lkml/20240926175709.410022-1-irogers@google=
.com/
> >
> > v3. Some minor code cleanup changes.
> >     https://lore.kernel.org/lkml/20240314055801.1973422-1-irogers@googl=
e.com/
> >
> > v2. The cycles metrics are now made common and shared with AMD and
> >     Intel, suggested by Kan Liang <kan.liang@linux.intel.com>. This
> >     assumes these patches come after the AMD and Intel sets.
> >     https://lore.kernel.org/lkml/20240301184942.2660478-1-irogers@googl=
e.com/
> >
> > v1. https://lore.kernel.org/lkml/20240229001325.4157655-1-irogers@googl=
e.com/
> >
> > Ian Rogers (35):
> >   perf jevents: Build support for generating metrics from python
> >   perf jevents: Add load event json to verify and allow fallbacks
> >   perf jevents: Add RAPL event metric for AMD zen models
> >   perf jevents: Add idle metric for AMD zen models
> >   perf jevents: Add upc metric for uops per cycle for AMD
> >   perf jevents: Add br metric group for branch statistics on AMD
> >   perf jevents: Add itlb metric group for AMD
> >   perf jevents: Add dtlb metric group for AMD
> >   perf jevents: Add uncore l3 metric group for AMD
> >   perf jevents: Add load store breakdown metrics ldst for AMD
> >   perf jevents: Add context switch metrics for AMD
> >   perf jevents: Add RAPL metrics for all Intel models
> >   perf jevents: Add idle metric for Intel models
> >   perf jevents: Add CheckPmu to see if a PMU is in loaded json events
> >   perf jevents: Add smi metric group for Intel models
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
> >   perf jevents: Add cycles breakdown metric for arm64/AMD/Intel
> >   perf jevents: Validate that all names given an Event
>
> Hi Arnaldo and Namhyung,
>
> this patch series has carved out everything anybody has objected to
> and every patch has tags. I'd appreciate it landing. The v1 series was
> originally mailed in February 2024 :-)

Ping.

Thanks,
Ian

> Thanks,
> Ian
>
> >  tools/perf/.gitignore                   |    5 +
> >  tools/perf/Makefile.perf                |    2 +
> >  tools/perf/pmu-events/Build             |   51 +-
> >  tools/perf/pmu-events/amd_metrics.py    |  492 ++++++++++
> >  tools/perf/pmu-events/arm64_metrics.py  |   49 +
> >  tools/perf/pmu-events/common_metrics.py |   19 +
> >  tools/perf/pmu-events/intel_metrics.py  | 1129 +++++++++++++++++++++++
> >  tools/perf/pmu-events/metric.py         |  171 +++-
> >  8 files changed, 1914 insertions(+), 4 deletions(-)
> >  create mode 100755 tools/perf/pmu-events/amd_metrics.py
> >  create mode 100755 tools/perf/pmu-events/arm64_metrics.py
> >  create mode 100644 tools/perf/pmu-events/common_metrics.py
> >  create mode 100755 tools/perf/pmu-events/intel_metrics.py
> >
> > --
> > 2.52.0.457.g6b5491de43-goog
> >
