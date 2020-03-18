From: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Subject: Re: [PATCH v6 0/3] perf vendor events amd: latest PMU events for
 zen1/zen2
Date: Wed, 18 Mar 2020 17:04:43 -0300
Message-ID: <20200318200443.GA29668@kernel.org>
References: <20200318190002.307290-1-vijaythakkar@me.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200318190002.307290-1-vijaythakkar@me.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vijay Thakkar <vijaythakkar@me.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Kim Phillips <kim.phillips@amd.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Martin =?utf-8?B?TGnFoWth?= <mliska@suse.cz>, Jon Grimm <jon.grimm@amd.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

Em Wed, Mar 18, 2020 at 02:59:59PM -0400, Vijay Thakkar escreveu:
> This series of patches brings the PMU events for AMD family 17h series
> of processors up to date with the latest versions of the AMD processor
> programming reference manuals.
> 
> The first patch changes the pmu events mapfile to be more selective for
> the model number rather than blanket detecting all f17h processors to
> have the same events directory. This is required for the later patch
> where we add events for zen2 based processors.
> 
> The second patch adds the PMU events for zen2.

Thanks, re-tested and applied.

- Arnaldo
 
> Finally the third patch updates the zen1 PMU events to be in accordance
> with the latest PPR version and bumps up the events version to v2.
> 
> Vijay Thakkar (3):
>   perf vendor events amd: restrict model detection for zen1 based
>     processors
>   perf vendor events amd: add Zen2 events
>   perf vendor events amd: update Zen1 events to V2
> 
>  .../pmu-events/arch/x86/amdfam17h/branch.json |  12 -
>  .../pmu-events/arch/x86/amdfam17h/cache.json  | 329 -----------------
>  .../pmu-events/arch/x86/amdfam17h/other.json  |  65 ----
>  .../pmu-events/arch/x86/amdzen1/branch.json   |  23 ++
>  .../pmu-events/arch/x86/amdzen1/cache.json    | 294 +++++++++++++++
>  .../arch/x86/{amdfam17h => amdzen1}/core.json |  15 +-
>  .../floating-point.json                       |  64 +++-
>  .../x86/{amdfam17h => amdzen1}/memory.json    |  82 +++--
>  .../pmu-events/arch/x86/amdzen1/other.json    |  56 +++
>  .../pmu-events/arch/x86/amdzen2/branch.json   |  52 +++
>  .../pmu-events/arch/x86/amdzen2/cache.json    | 338 +++++++++++++++++
>  .../pmu-events/arch/x86/amdzen2/core.json     | 130 +++++++
>  .../arch/x86/amdzen2/floating-point.json      | 140 +++++++
>  .../pmu-events/arch/x86/amdzen2/memory.json   | 341 ++++++++++++++++++
>  .../pmu-events/arch/x86/amdzen2/other.json    | 115 ++++++
>  tools/perf/pmu-events/arch/x86/mapfile.csv    |   3 +-
>  16 files changed, 1606 insertions(+), 453 deletions(-)
>  delete mode 100644 tools/perf/pmu-events/arch/x86/amdfam17h/branch.json
>  delete mode 100644 tools/perf/pmu-events/arch/x86/amdfam17h/cache.json
>  delete mode 100644 tools/perf/pmu-events/arch/x86/amdfam17h/other.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/amdzen1/branch.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/amdzen1/cache.json
>  rename tools/perf/pmu-events/arch/x86/{amdfam17h => amdzen1}/core.json (87%)
>  rename tools/perf/pmu-events/arch/x86/{amdfam17h => amdzen1}/floating-point.json (61%)
>  rename tools/perf/pmu-events/arch/x86/{amdfam17h => amdzen1}/memory.json (63%)
>  create mode 100644 tools/perf/pmu-events/arch/x86/amdzen1/other.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/amdzen2/branch.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/amdzen2/cache.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/amdzen2/core.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/amdzen2/floating-point.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/amdzen2/memory.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/amdzen2/other.json
> 
> -- 
> 2.25.2
> 

-- 

- Arnaldo
