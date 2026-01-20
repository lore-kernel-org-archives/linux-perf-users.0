Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDBC634D4CF
	for <linux-perf-users@vger.kernel.org>; Tue, 20 Jan 2026 05:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768886633; cv=pass; b=Ue8XodApzy0SJHkNYUMlBN1L4J6TZQ8OFvUS+L8J4R0Xyt7Brm/9gOUif7Tgw6UgJ31J3ESrUqV6F5HR2UJsomzLgsjbDwdYBBE9XBcOytsvWPFk98YzK2ttAcF79E4jWA7cqW4O7AQdRWKq5BslbJ+vh0C5x1zd7HeeUp/Dxnw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768886633; c=relaxed/simple;
	bh=t+QO6Uf0vw21Z0235/IHONzG9CvknqjvJrEkyuK5KfY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=Byy1FZhyDKqHWHXKv8gte9zX6frPZZsTKYbuLuW97CqXbLvVzFOvCB05U3XKC111019YNef+ffjqS+CkFWzk3i+QyGdqcPLcS2Mm+Onp/n60Ty6idS9HwG18M/C7iXewl70nIHX1qzfYIHYk1Yfrfwt7QydXt2lqSk3FytLLXWA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s8qbWvfu; arc=pass smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s8qbWvfu"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2a35ae38bdfso48765ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 19 Jan 2026 21:23:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768886630; cv=none;
        d=google.com; s=arc-20240605;
        b=cHJJtigh+NIhCLER16vKP8uL5mKoRWKwlZm/DdBu20JTElGeKcDPMTjFTjIfsgOGZf
         cX3OvbQKStEqI0Q/zKCi/0lSeWno4XKYEsbR03o9+5jJbgNtfE1vhB88iSvZ7vgDhYFS
         EYOFfySw1fDLg1gHv6NNoDrLM2c1mHof3TqSayuttw87Y+VKf0G22lSG8vqS/LQtRAXy
         rVmO7S01SkYtk17qJGQVnVtYZWNPj3iP407/fiAeu0tVek6tpdQU1eDAk0KacO8KZ9xj
         2fx4KM4snWQs61dwqQEGX+RJnbZEc04gOvquPMHqtPoemc7Pb9kcrZn7M48WDpB/cNxo
         MzDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KRzNoPiApX6P1udPDb/rm+9xMBNIENbaFqL06V1BrR0=;
        fh=4xdo2i0bGnWdNn7A/kFoVFRxChiGLreu5szNdZtTt/Q=;
        b=H3Cmg4YImlLbb4iV/26qSqfPgtF5IuRatX/QY+nvO5eDA6bxINOLkU/rqiH0Ag87C7
         DEorlD0HAMK7UiiP63tlwrhCmlz9ziu14IAMSh8LOAGL7/kuAbsewq7f+cCyTxtaGuxu
         P14q6hKZgd6WvTzGL0Dejc4fRQ9xCToXeMsKDucT7BKgbbyNdSU/kFWRsGt0b6XCLgyJ
         G03C400wKCxPVd3SdH0+D0WaYgr/CJZt0nESiSeGSixpJDXiRPBG6CXG2FmNdkiq3Inn
         jfwI3wGROdZHggGayOZguN8M8C0gXDohyV8AmPXUVY6dpJOHcpmGqMqtTVW4x7D3o41e
         IloQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768886630; x=1769491430; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KRzNoPiApX6P1udPDb/rm+9xMBNIENbaFqL06V1BrR0=;
        b=s8qbWvfuIU6V14G+JNTFSSwdt+Eq/6lC6HLm7Loya1/BbyzKy91RiRDYWvhJ7YrMp1
         oWAiBsXgGOYxVZ1tYCXItERRn8hvsvmmUwFuy9s8qu94nSKujgU8e+ZSY+71lesojFHD
         0GhZBMFSSUzJhpoRXS+vTBVWx7Mlvs7uzz/q+jkAAQbv4AFCUc6VHUuAhGSpeKsa+yq3
         YPBkj0nHZGHrSnDVeVVoTmvstifEk47GDpQHDqPtxavzVHaI7Zl0IptwdlQkf9kHiMYd
         cH+w0AT51bKKMisNlH9mxJlEYYDHvK8sJ5CQApEEzK5MFUSkdm6sJiRVoCU4K9JZuXio
         MZcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768886630; x=1769491430;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KRzNoPiApX6P1udPDb/rm+9xMBNIENbaFqL06V1BrR0=;
        b=DPdovL6g2rY3hnJC80XkIMTBINXOo20h1K5jM+jUHql4nifYVjgdCwZh2qHZsFKKFK
         +l/q6iHxR1xkinKizDgcaO3D2s/uRv5RrWh9ysvN8968XLigwxbdu67SpFjmHY0PdC8o
         9cXzoVBwppK1WSXOUMvBcMylCh3VfTqLjHoWnw93r95YK0mwrpbB5d4LQRwv/IGw2IUW
         cBS5n589lJxkrNMPvb2ah0Z58rdL1VzS7bJfkxRVYtlSc+Re9HWMIyBbUypWFnYspx7y
         deWtybS33q+4hwzBqRK6BC561ZCVWZNGrsg9tCZuv4DumFn8cFl0pxyf8P9ozwF9fsYk
         RWAg==
X-Forwarded-Encrypted: i=1; AJvYcCWT8z9v7REooRIqtXgY8FHoHcd4yVLCPipZLhBYNWAUNZrajyflFt8hUYUAEkwbzdFziSLDj+ODirVf1BrJKVei@vger.kernel.org
X-Gm-Message-State: AOJu0YyThHrH/UM7OcqOBFpN5nkgQHOA0BZk3UpHNIoV83CWDUXWC/1x
	XlrhXaVP9oPVCb+wExh3tb5xfsQCU347nU+8cRnWV/qkrH1wU9U0vxd+gl73iZSIJLFExcELQvv
	qRNlISisjhtMaDmDrhhY7n7YZE4mbgt5gS/uuM1MU
X-Gm-Gg: AZuq6aIXGraBDYEP/rzMUjIy7Gso6t2XiKdsULF9wNNBmUtgbJ3WlpglDYdDL/j5Q5E
	OOuYOKrjVo+YFfGfibHxA7/C4Y55zki3On1YuCtFB7+asdruuhUsVfSzLoiQhoiv9SFAzVccMdN
	HOo2vXh/YxTMKjTZPooreoSvisl9sEwwxMVqQlxrTczcsTkQ0RrU5x+g4neQUUFzQFNIHvuHXFN
	uXeVMw1Vs4cq95IYHqWoSnz9Iitc7BgIz6GpBd1mkv22UaJhfvL6p/EOsGDfxQx5J/9RZE3
X-Received: by 2002:a17:902:cf07:b0:294:ecba:c8e with SMTP id
 d9443c01a7336-2a72a63f165mr4325245ad.3.1768886629839; Mon, 19 Jan 2026
 21:23:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108191105.695131-1-irogers@google.com>
In-Reply-To: <20260108191105.695131-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 19 Jan 2026 21:23:38 -0800
X-Gm-Features: AZwV_QgacdTyRGqmbKSJOypUin1l4GanSZq-AHmIXpCOgwSf4tGsppwIpzrkKLc
Message-ID: <CAP-5=fV2vRhky59xt1_0oFEiM88k97m8Gx6DD4dO2YRsA96z1A@mail.gmail.com>
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

On Thu, Jan 8, 2026 at 11:11=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
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
> * The first 2 patches introduce infrastructure for the addition of
>   metrics written in python for Arm64, AMD Zen and Intel CPUs.
>
> * The next 9 patches generate additional metrics for AMD zen.  Rapl
>   and Idle metrics aren't specific to AMD but are placed here for ease
>   and convenience. Uncore L3 metrics are added along with the majority
>   of core metrics.
>
> * The next 22 patches add additional metrics for Intel. Rapl and Idle
>   metrics aren't specific to Intel but are placed here for ease and
>   convenience. Smi and tsx metrics are added so they can be dropped
>   from the per model json files. There are four uncore sets of metrics
>   and eleven core metrics. Add a CheckPmu function to metric to
>   simplify detecting the presence of hybrid PMUs in events. Metrics
>   with experimental events are flagged as experimental in their
>   description.
>
> * The next patch adds a cycles metrics based on perf event modifiers
>   for AMD, Intel and Arm64.
>
> * The final patch validates that all events provided to an Event
>   object exist in a json file somewhere. This is to avoid mistakes
>   like unfortunate typos.
>
> This series has benefitted from the input of Leo Yan
>  <leo.yan@arm.com>, Sandipan Das <sandidas@amd.com>, Thomas Falcon
>  <thomas.falcon@intel.com> and Perry Taylor <perry.taylor@intel.com>.
>
> v10. Drop already merged non-vendor patches (Namhyung). Drop "Add
>      collection of topdown like metrics for arm64" as requested by
>      James Clark. Update AMD metrics for changes to AMD Zen6 event
>      names from the series:
>      https://lore.kernel.org/lkml/cover.1767858676.git.sandipan.das@amd.c=
om/
>
> v9. Drop (for now) 4 AMD sets of metrics for additional follow up. Add
>     reviewed-by tags from Sandipan Das (AMD) and tested-by tags from
>     Thomas Falcon (Intel).
>     https://lore.kernel.org/lkml/20251202175043.623597-1-irogers@google.c=
om/
>
> v8. Combine the previous 4 series for clarity. Rebase on top of the
>     more recent legacy metric and event changes. Make the python more
>     pep8 and pylint compliant.
>     https://lore.kernel.org/lkml/20251113032040.1994090-1-irogers@google.=
com/
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
>
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
> Ian Rogers (35):
>   perf jevents: Build support for generating metrics from python
>   perf jevents: Add load event json to verify and allow fallbacks
>   perf jevents: Add RAPL event metric for AMD zen models
>   perf jevents: Add idle metric for AMD zen models
>   perf jevents: Add upc metric for uops per cycle for AMD
>   perf jevents: Add br metric group for branch statistics on AMD
>   perf jevents: Add itlb metric group for AMD
>   perf jevents: Add dtlb metric group for AMD
>   perf jevents: Add uncore l3 metric group for AMD
>   perf jevents: Add load store breakdown metrics ldst for AMD
>   perf jevents: Add context switch metrics for AMD
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
>   perf jevents: Add cycles breakdown metric for arm64/AMD/Intel
>   perf jevents: Validate that all names given an Event

Hi Arnaldo and Namhyung,

this patch series has carved out everything anybody has objected to
and every patch has tags. I'd appreciate it landing. The v1 series was
originally mailed in February 2024 :-)

Thanks,
Ian

>  tools/perf/.gitignore                   |    5 +
>  tools/perf/Makefile.perf                |    2 +
>  tools/perf/pmu-events/Build             |   51 +-
>  tools/perf/pmu-events/amd_metrics.py    |  492 ++++++++++
>  tools/perf/pmu-events/arm64_metrics.py  |   49 +
>  tools/perf/pmu-events/common_metrics.py |   19 +
>  tools/perf/pmu-events/intel_metrics.py  | 1129 +++++++++++++++++++++++
>  tools/perf/pmu-events/metric.py         |  171 +++-
>  8 files changed, 1914 insertions(+), 4 deletions(-)
>  create mode 100755 tools/perf/pmu-events/amd_metrics.py
>  create mode 100755 tools/perf/pmu-events/arm64_metrics.py
>  create mode 100644 tools/perf/pmu-events/common_metrics.py
>  create mode 100755 tools/perf/pmu-events/intel_metrics.py
>
> --
> 2.52.0.457.g6b5491de43-goog
>
