Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0780221540
	for <linux-perf-users@vger.kernel.org>; Tue, 27 Jan 2026 18:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769537410; cv=pass; b=u2OQ8ofE4/lj816JHxEh0rAT+VtCaApLuCBmJks44LMg6tgE5N3SobI+50lecaAvz4dw0+nucjvFVCskxoLkcCXHS2D+YWAlgKoPGWoG6zv5uL4SRziK8Mfn/03rb5ss8SJ8eDMIEizufu8mTjpBVLgTvRGTIR4npmmSZZASjek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769537410; c=relaxed/simple;
	bh=yZz7uYr3N4e4HMSERx54eiKSLEx49EmDbnPC5u7lWu4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BWuKWxQuWNb3P73swY+VwIe3m2CVBp0ijQW6XGlBDleAF6KbM9s7QQV/P5cjvSkmF1D3GGTP0Eha1xzRqBXvYwUcuwExa+OG8eLBvqsFu+0f1sDJRW6i5/cA4c1NsTAkXTiVMyF6n5BmDvZzME+qokTfKYuxLrxqY8u3+fn+ZEs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WXwEDEI5; arc=pass smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WXwEDEI5"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2a885af8ee7so2485ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 27 Jan 2026 10:10:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769537408; cv=none;
        d=google.com; s=arc-20240605;
        b=ilnrA+kVBbkUrsHpSBGoTOH/yL+nbZ6jAN7h7HvgvNVE8Lj5Af/wp+OvOSQ7FCHKbh
         JS2r45kjzjO4fz0/YsMapAtvdC4YdJJuMBLXlSn6PKISSv4SA2z5m2DXSSSTJVqplBP5
         MRPMIhR3XizFO3R/9LbiMk04pkCIJK1lN0LACAwMyod5IfQBMx5lsOdymLR8qz4ZCZvO
         F47N2wrSRS9wKWU78h0w79tpXzcFoSl1fG4f+uy53K5T0W7+qTLrCYRtFiwTwwcAF9WQ
         8W80rK8zN1116kEXbgXKkP8TJ0IGvGf93T7l3AI4CRNStBr6Usx2vFIOaonzCwFognZS
         q7Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Zmak+1BmQDxTR2OQzqepyVNIrUdOMUHxY6Q3uTl8rWs=;
        fh=aYRhEkWsTznpJBCTseJE9NLWyT6G+YS9xYwdNDfzzJA=;
        b=cevRIOFPDo9Pj6RObd9B7N6ZjMWVH7DGKqmNwZ4TE0JcZwyIMPNeTQ5TWs5s/Nds8n
         yrmDDueXu18d/2hW5M7+MT8XdKaaezyD6Itr+zGmsicd0t6nQGmEIaUit1QvGzaOAGGi
         gbs5W4EgcuuPbyRcIJfFd4+wfosFKsYTCGJ+lgjWUNCIQZTZjOyizSviYTcMu02GJDck
         Tye0h3EDLDzkQPOxrmY2L8jGBPejNvvGgugk+LxIGd+feSabTWw7xr91g+56sOgTOp5g
         h/TYL2fERV32GLP9uS47Q/piBMmpz4fyiyddzYHAm+uyfzCLQHHMx0CU4rHRnXSEFAM9
         ur6Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769537408; x=1770142208; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zmak+1BmQDxTR2OQzqepyVNIrUdOMUHxY6Q3uTl8rWs=;
        b=WXwEDEI54Tdqzhl7IONpqHPWCufmLaDIg4WJzy88gSbB+laHip20r5iRxK9a0BD3hM
         dKYQXofXVcaEAvgcgli06kmcQfHwMZ9wpAbWVUFvZBHB/sqP86BqXzSeQjgfjBIHlPoo
         PZXNrmi9zJMnDoDiVYvaDu+eZOsPCq3jlWJLoJ1UFrO0mhIuCMI61t5dwVI/B2uwdi2Y
         JcNx18HGgq6JDAVLos4Bc+wC3pvRuA4WqTnr0twNh9tf/xXtomlV5QNEW7+765ec80Ju
         MuS/Wzz2x4WES3AoiL7lQoyS/oSw3LKgeeXMEoeeXB8WnFb+3lwButQK3BUnSClDZMAY
         QuGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769537408; x=1770142208;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Zmak+1BmQDxTR2OQzqepyVNIrUdOMUHxY6Q3uTl8rWs=;
        b=cAEc5wni/TiUyohAwP7v7OOTNJ70sAJxyxhXEnwgWvN86eamDt8YddMY6UlWR7xqtv
         Tuc3A2oI7jcmCbVnzyCww7ls3XoswypOcAEHZ8WO0YCrSGC1zcIgDmC+wXye4vIroz8y
         cpyOouAYnEbJrQwkN4LlDin5umYewFrWjlORH2a2uVz3pJiO6Sa9QB4q9Y61aYtVM3zY
         zBeJS4XwVpPna3dVLvQaNqmaciGKujFFqdVIj+4mwpmCXshLv/xLPsEHPhuORIt6qK16
         Erl3jriAGQ244hpB1vWhcCkBo/4C1Xn7f0KawRCFH3T09S9EdIA2GnXFcgyXOlGUxBE3
         kc7A==
X-Forwarded-Encrypted: i=1; AJvYcCV0tdMMy6rJTtCt+xld8jPKE6VCRQUXicaLHwJ9CGaO8ICIojB7KiPiKUZHRSxt5Rxx/ka98foCfrDlDrCWn0Mk@vger.kernel.org
X-Gm-Message-State: AOJu0YxwxFdv4oiediNqfHq+P394J64lxn/1NyqF7BQbDp72F1gPf+Mj
	qCPWZMDJN+UIfSrkaW+DdtMRO24GUriddwWM5N2WbbaM9ulhTz1IyYQlyP4gpR1jiyQZKUhY+zy
	ADt9EUgETD0VHLnSRHre8WqPAUOYmSxCJ0rMuIUiB
X-Gm-Gg: AZuq6aJ9I2Yn2Wc1ocK2872JtDoZnEyWnpzfVuIcn2k0s0c+YRA+cJVk6IwrlBO7ysA
	rkp9XqcKMroNfUSpX7e3Fqos8BxKoq/Hi/0UALqWtFuKdDcShimFEvb8NdytucCLApROkFBhv9o
	aUWjRqRBOQfeoAs93W0w5QXNSLABHgFvXYdbKZKAiKn8FsmplhTbkFCxQK58MPRFV8aci8ONPUH
	BxsWxeFJOXhGNHWUQBMB2ZGEE4N4vW/VI/mqgnaQQjTbWpcEsg1XkYapjxRLUjdHbob16wkIq6I
	dpGJrako4hbOIUGkwb59vQbt
X-Received: by 2002:a17:903:1a8e:b0:2a0:89b0:71d7 with SMTP id
 d9443c01a7336-2a870a28f66mr2336275ad.13.1769537407538; Tue, 27 Jan 2026
 10:10:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108191105.695131-1-irogers@google.com> <aXjw5_4PW9M3ZFgD@x1>
In-Reply-To: <aXjw5_4PW9M3ZFgD@x1>
From: Ian Rogers <irogers@google.com>
Date: Tue, 27 Jan 2026 10:09:56 -0800
X-Gm-Features: AZwV_QjwxnroOASOK2UQgoY9TfhLY4GVQcX6ePWEDZ2wSFmp1FMXHGwMshuE6bI
Message-ID: <CAP-5=fWPCh0i=_OiL8f3RDeuKqZLPtFuzO1nbLynoOXOzYuXzQ@mail.gmail.com>
Subject: Re: [PATCH v10 00/35] AMD and Intel metric generation with Python
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Benjamin Gray <bgray@linux.ibm.com>, 
	Caleb Biggers <caleb.biggers@intel.com>, Edward Baker <edward.baker@intel.com>, 
	Ingo Molnar <mingo@redhat.com>, James Clark <james.clark@linaro.org>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Jiri Olsa <jolsa@kernel.org>, 
	John Garry <john.g.garry@oracle.com>, Leo Yan <leo.yan@arm.com>, 
	Namhyung Kim <namhyung@kernel.org>, Perry Taylor <perry.taylor@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Samantha Alt <samantha.alt@intel.com>, 
	Sandipan Das <sandipan.das@amd.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Weilin Wang <weilin.wang@intel.com>, Xu Yang <xu.yang_2@nxp.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 27, 2026 at 9:07=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Thu, Jan 08, 2026 at 11:10:30AM -0800, Ian Rogers wrote:
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
>
> Tried this one now:
>
> Cover: ./v10_20260108_irogers_amd_and_intel_metric_generation_with_python=
.cover
>  Link: https://lore.kernel.org/r/20260108191105.695131-1-irogers@google.c=
om
>  Base: not specified
>        git am ./v10_20260108_irogers_amd_and_intel_metric_generation_with=
_python.mbx
> =E2=AC=A2 [acme@toolbx perf-tools-next]$        git am ./v10_20260108_iro=
gers_amd_and_intel_metric_generation_with_python.mbx
> Applying: perf jevents: Build support for generating metrics from python
> error: patch failed: tools/perf/pmu-events/Build:29
> error: tools/perf/pmu-events/Build: patch does not apply
> Patch failed at 0001 perf jevents: Build support for generating metrics f=
rom python
> hint: Use 'git am --show-current-patch=3Ddiff' to see the failed patch
> hint: When you have resolved this problem, run "git am --continue".
> hint: If you prefer to skip this patch, run "git am --skip" instead.
> hint: To restore the original branch and stop patching, run "git am --abo=
rt".
> hint: Disable this message with "git config set advice.mergeConflict fals=
e"
> =E2=AC=A2 [acme@toolbx perf-tools-next]$ git am --abort
> =E2=AC=A2 [acme@toolbx perf-tools-next]$
>
> Can you please take a look?

I'll rebase and resend. My local rebases hadn't been having issues,
largely as the changes are on added files, and I'd wanted to minimize
mailing list noise.

Thanks,
Ian

> - Arnaldo
>
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
> >
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
