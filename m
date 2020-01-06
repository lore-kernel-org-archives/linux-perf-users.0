From: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Subject: Re: [PATCH 0/3] perf vendor events amd: latest PMU events for
 zen1/zen2
Date: Mon, 6 Jan 2020 19:17:54 -0300
Message-ID: <20200106221754.GB16851@kernel.org>
References: <20191227125536.1091387-1-vijaythakkar@me.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191227125536.1091387-1-vijaythakkar@me.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vijay Thakkar <vijaythakkar@me.com>, Borislav Petkov <bp@alien8.de>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Kim Phillips <kim.phillips@amd.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Martin =?utf-8?B?TGnFoWth?= <mliska@suse.cz>, Jon Grimm <jon.grimm@amd.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

Em Fri, Dec 27, 2019 at 07:55:33AM -0500, Vijay Thakkar escreveu:
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

Borislav, can you ack these, or point to someone who can double check
this and the other 2 patches?

Thanks,

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
>  .../x86/{amdfam17h => amdzen1}/branch.json    |   0
>  .../x86/{amdfam17h => amdzen1}/cache.json     |   0
>  .../pmu-events/arch/x86/amdzen1/core.json     | 129 ++++++
>  .../floating-point.json                       |  56 +++
>  .../x86/{amdfam17h => amdzen1}/memory.json    |  18 +
>  .../x86/{amdfam17h => amdzen1}/other.json     |   0
>  .../pmu-events/arch/x86/amdzen2/branch.json   |  56 +++
>  .../pmu-events/arch/x86/amdzen2/cache.json    | 375 ++++++++++++++++++
>  .../arch/x86/{amdfam17h => amdzen2}/core.json |   0
>  .../arch/x86/amdzen2/floating-point.json      | 128 ++++++
>  .../pmu-events/arch/x86/amdzen2/memory.json   | 349 ++++++++++++++++
>  .../pmu-events/arch/x86/amdzen2/other.json    | 137 +++++++
>  tools/perf/pmu-events/arch/x86/mapfile.csv    |   4 +-
>  13 files changed, 1251 insertions(+), 1 deletion(-)
>  rename tools/perf/pmu-events/arch/x86/{amdfam17h => amdzen1}/branch.json (100%)
>  rename tools/perf/pmu-events/arch/x86/{amdfam17h => amdzen1}/cache.json (100%)
>  create mode 100644 tools/perf/pmu-events/arch/x86/amdzen1/core.json
>  rename tools/perf/pmu-events/arch/x86/{amdfam17h => amdzen1}/floating-point.json (63%)
>  rename tools/perf/pmu-events/arch/x86/{amdfam17h => amdzen1}/memory.json (93%)
>  rename tools/perf/pmu-events/arch/x86/{amdfam17h => amdzen1}/other.json (100%)
>  create mode 100644 tools/perf/pmu-events/arch/x86/amdzen2/branch.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/amdzen2/cache.json
>  rename tools/perf/pmu-events/arch/x86/{amdfam17h => amdzen2}/core.json (100%)
>  create mode 100644 tools/perf/pmu-events/arch/x86/amdzen2/floating-point.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/amdzen2/memory.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/amdzen2/other.json
> 
> -- 
> 2.24.1

-- 

- Arnaldo
