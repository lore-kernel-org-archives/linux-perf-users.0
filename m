Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9312D47E1;
	Tue, 27 Jan 2026 17:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769533676; cv=none; b=uvo7vyq/jmzZLMS9dsEF516Ciz3gXY9Q5udjsY9VUhOsZeS7V1CRjZETKBTQ5B7vw2gHATfyK+fGo4E/77jV85RDfTOHS4rb2SGftvl3O45uEQ18nDp8GNuFWde4LsFnlhQOTkDN419b87468EtDJ4C6MPTycIMU1m3Q+h0MC8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769533676; c=relaxed/simple;
	bh=eGnwa6PItKGn0e1o5BHdXl5sS8AxITUph3KQV8K1ZIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UJFTV9TwXLJtz9uEkUAhsskHioFWj+GabT1mdl1lJXh5sMyQkL0dlBEXsjRiFnOB/O06eWti6JJBj9rXsWj2k7sRyqUgxmHfUhYVXzjKrzS70PDOtpwsIWOODcY0nMtjYps9XiI2p6UveVW1FmGak1fJwLH27gIu9El4xBvEFkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NaK7Ij2n; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NaK7Ij2n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F293C116C6;
	Tue, 27 Jan 2026 17:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769533675;
	bh=eGnwa6PItKGn0e1o5BHdXl5sS8AxITUph3KQV8K1ZIM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NaK7Ij2n43fbhcTMtwNeEtkpB2If+q3ojhS3vd9gtcCIjIRw/tlFm0RzFgHT5yYCu
	 jxqM7L1VsnphmNw0MujvAPjdNNr2nbot2ab33hmWaIsnv4PeaVdjuMNeJ/ZgIPKUYA
	 uQskvNnG4R61GNVHjov90T1Mf984B4Mez1PGLCqXZz1nxVoYEMGh2I+JQGadpeSjwq
	 EaKKWY/rwd+nApeO3Z0kCVyN85ym/aUQy/e6YgPJSx3argC/hZ3h6UMCzB7NbD2tXM
	 jSW7Js5EN8mSFZZRdm//8TwkzRtntstNqkdgyJeFweyVKYQY+YT/q4sBv8HBrfSVGS
	 GOLYo73WWSWNQ==
Date: Tue, 27 Jan 2026 14:07:51 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Benjamin Gray <bgray@linux.ibm.com>,
	Caleb Biggers <caleb.biggers@intel.com>,
	Edward Baker <edward.baker@intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	James Clark <james.clark@linaro.org>,
	Jing Zhang <renyu.zj@linux.alibaba.com>,
	Jiri Olsa <jolsa@kernel.org>, John Garry <john.g.garry@oracle.com>,
	Leo Yan <leo.yan@arm.com>, Namhyung Kim <namhyung@kernel.org>,
	Perry Taylor <perry.taylor@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Samantha Alt <samantha.alt@intel.com>,
	Sandipan Das <sandipan.das@amd.com>,
	Thomas Falcon <thomas.falcon@intel.com>,
	Weilin Wang <weilin.wang@intel.com>, Xu Yang <xu.yang_2@nxp.com>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v10 00/35] AMD and Intel metric generation with Python
Message-ID: <aXjw5_4PW9M3ZFgD@x1>
References: <20260108191105.695131-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260108191105.695131-1-irogers@google.com>

On Thu, Jan 08, 2026 at 11:10:30AM -0800, Ian Rogers wrote:
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

Tried this one now:

Cover: ./v10_20260108_irogers_amd_and_intel_metric_generation_with_python.cover
 Link: https://lore.kernel.org/r/20260108191105.695131-1-irogers@google.com
 Base: not specified
       git am ./v10_20260108_irogers_amd_and_intel_metric_generation_with_python.mbx
⬢ [acme@toolbx perf-tools-next]$        git am ./v10_20260108_irogers_amd_and_intel_metric_generation_with_python.mbx
Applying: perf jevents: Build support for generating metrics from python
error: patch failed: tools/perf/pmu-events/Build:29
error: tools/perf/pmu-events/Build: patch does not apply
Patch failed at 0001 perf jevents: Build support for generating metrics from python
hint: Use 'git am --show-current-patch=diff' to see the failed patch
hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To restore the original branch and stop patching, run "git am --abort".
hint: Disable this message with "git config set advice.mergeConflict false"
⬢ [acme@toolbx perf-tools-next]$ git am --abort
⬢ [acme@toolbx perf-tools-next]$

Can you please take a look?

- Arnaldo
 
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
>      https://lore.kernel.org/lkml/cover.1767858676.git.sandipan.das@amd.com/
> 
> v9. Drop (for now) 4 AMD sets of metrics for additional follow up. Add
>     reviewed-by tags from Sandipan Das (AMD) and tested-by tags from
>     Thomas Falcon (Intel).
>     https://lore.kernel.org/lkml/20251202175043.623597-1-irogers@google.com/
> 
> v8. Combine the previous 4 series for clarity. Rebase on top of the
>     more recent legacy metric and event changes. Make the python more
>     pep8 and pylint compliant.
>     https://lore.kernel.org/lkml/20251113032040.1994090-1-irogers@google.com/
> 
> Foundations:
> v6. Fix issue with '\-' escape not being '\\-' (reported-by Sandipan
>     Das <sandidas@amd.com>) which didn't alter the generated json.
>     https://lore.kernel.org/lkml/20250904043208.995243-1-irogers@google.com/
> 
> v5. Rebase on top of legacy hardware/cache changes that now generate
>     events using python:
>     https://lore.kernel.org/lkml/20250828205930.4007284-1-irogers@google.com/
>     the v5 series is:
>     https://lore.kernel.org/lkml/20250829030727.4159703-1-irogers@google.com/
> 
> v4. Rebase and small Build/Makefile tweak
>     https://lore.kernel.org/lkml/20240926173554.404411-1-irogers@google.com/
> 
> v3. Some code tidying, make the input directory a command line
>     argument, but no other functional or output changes.
>     https://lore.kernel.org/lkml/20240314055051.1960527-1-irogers@google.com/
> 
> v2. Fixes two type issues in the python code but no functional or
>     output changes.
>     https://lore.kernel.org/lkml/20240302005950.2847058-1-irogers@google.com/
> 
> v1. https://lore.kernel.org/lkml/20240302005950.2847058-1-irogers@google.com/
> 
> AMD:
> v6. Fix issue with '\-' escape not being '\\-' (reported-by Sandipan
>     Das <sandidas@amd.com>) which didn't alter the generated json.
>     https://lore.kernel.org/lkml/20250904044047.999031-1-irogers@google.com/
> 
> v5. Rebase. Add uop cache hit/miss rates patch. Prefix all metric
>     names with lpm_ (short for Linux Perf Metric) so that python
>     generated metrics are clearly namespaced.
>     https://lore.kernel.org/lkml/20250829033138.4166591-1-irogers@google.com/
> 
> v4. Rebase.
>     https://lore.kernel.org/lkml/20240926174101.406874-1-irogers@google.com/
> 
> v3. Some minor code cleanup changes.
>     https://lore.kernel.org/lkml/20240314055839.1975063-1-irogers@google.com/
> 
> v2. Drop the cycles breakdown in favor of having it as a common
>     metric, suggested by Kan Liang <kan.liang@linux.intel.com>.
>     https://lore.kernel.org/lkml/20240301184737.2660108-1-irogers@google.com/
> 
> v1. https://lore.kernel.org/lkml/20240229001537.4158049-1-irogers@google.com/
> 
> Intel:
> v6. Fix issue with '\-' escape not being '\\-' (reported-by Sandipan
>     Das <sandidas@amd.com>) which didn't alter the generated json.
>     https://lore.kernel.org/lkml/20250904044653.1002362-1-irogers@google.com/
> 
> v5. Rebase. Fix description for smi metric (Kan). Prefix all metric
>     names with lpm_ (short for Linux Perf Metric) so that python
>     generated metrics are clearly namespaced. Kan requested a
>     namespace in his review:
>     https://lore.kernel.org/lkml/43548903-b7c8-47c4-b1da-0258293ecbd4@linux.intel.com/
>     The v5 series is:
>     https://lore.kernel.org/lkml/20250829041104.4186320-1-irogers@google.com/
> 
> v4. Experimental metric descriptions. Add mesh bandwidth metric. Rebase.
>     https://lore.kernel.org/lkml/20240926175035.408668-1-irogers@google.com/
> 
> v3. Swap tsx and CheckPMU patches that were in the wrong order. Some
>     minor code cleanup changes. Drop reference to merged fix for
>     umasks/occ_sel in PCU events and for cstate metrics.
>     https://lore.kernel.org/lkml/20240314055919.1979781-1-irogers@google.com/
> 
> v2. Drop the cycles breakdown in favor of having it as a common
>     metric, spelling and other improvements suggested by Kan Liang
>     <kan.liang@linux.intel.com>.
>     https://lore.kernel.org/lkml/20240301185559.2661241-1-irogers@google.com/
> 
> v1. https://lore.kernel.org/lkml/20240229001806.4158429-1-irogers@google.com/
> 
> ARM:
> 
> v7. Switch a use of cycles to cpu-cycles due to ARM having too many
>     cycles events.
>     https://lore.kernel.org/lkml/20250904194139.1540230-1-irogers@google.com/
> 
> v6. Fix issue with '\-' escape not being '\\-' (reported-by Sandipan
>     Das <sandidas@amd.com>) which didn't alter the generated json.
>     https://lore.kernel.org/lkml/20250904045253.1007052-1-irogers@google.com/
> 
> v5. Rebase. Address review comments from Leo Yan
>     <leo.yan@arm.com>. Prefix all metric names with lpm_ (short for
>     Linux Perf Metric) so that python generated metrics are clearly
>     namespaced. Use cpu-cycles rather than cycles legacy event for
>     cycles metrics to avoid confusion with ARM PMUs. Add patch that
>     checks events to ensure all possible event names are present in at
>     least one json file.
>     https://lore.kernel.org/lkml/20250829053235.21994-1-irogers@google.com/
> 
> v4. Tweak to build dependencies and rebase.
>     https://lore.kernel.org/lkml/20240926175709.410022-1-irogers@google.com/
> 
> v3. Some minor code cleanup changes.
>     https://lore.kernel.org/lkml/20240314055801.1973422-1-irogers@google.com/
> 
> v2. The cycles metrics are now made common and shared with AMD and
>     Intel, suggested by Kan Liang <kan.liang@linux.intel.com>. This
>     assumes these patches come after the AMD and Intel sets.
>     https://lore.kernel.org/lkml/20240301184942.2660478-1-irogers@google.com/
> 
> v1. https://lore.kernel.org/lkml/20240229001325.4157655-1-irogers@google.com/
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
> 
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
