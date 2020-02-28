From: Vijay Thakkar <vijaythakkar@me.com>
Subject: [PATCH v3 0/3] update to latest PMU events for zen1/zen2
Date: Fri, 28 Feb 2020 12:56:36 -0500
Message-ID: <20200228175639.39171-1-vijaythakkar@me.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Vijay Thakkar <vijaythakkar@me.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Kim Phillips <kim.phillips@amd.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, =?UTF-8?q?Martin=20Li=C5=A1ka?= <mliska@suse.cz>, Jon Grimm <jon.grimm@amd.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

This series of patches brings the PMU events for AMD family 17h series
of processors up to date with the latest versions of the AMD processor
programming reference manuals, all of which can be found at:
https://bugzilla.kernel.org/show_bug.cgi?id=206537

Change summary:
Patch 1: changes the pmu events mapfile to be more selective for
the model number rather than blanket detecting all f17h processors to
have the same events directory. This is required for the later patch
where we add events for zen2 based processors.

Patch 2: adds the PMU events for zen2.

Patch 3: updates the zen1 PMU events to be in accordance
with the latest PPR version and bumps up the events version to v2,
mainly adding some events that were previously missing, and
cleaning up some fpu counters.

Details of what changed between patch revisions is included within the
commits.

Vijay Thakkar (3):
  perf vendor events amd: restrict model detection for zen1 based
    processors
  perf vendor events amd: add Zen2 events
  perf vendor events amd: update Zen1 events to V2

 .../pmu-events/arch/x86/amdfam17h/branch.json |  12 -
 .../pmu-events/arch/x86/amdzen1/branch.json   |  23 ++
 .../x86/{amdfam17h => amdzen1}/cache.json     |   0
 .../arch/x86/{amdfam17h => amdzen1}/core.json |   5 -
 .../floating-point.json                       |  60 ++-
 .../x86/{amdfam17h => amdzen1}/memory.json    |  18 +
 .../x86/{amdfam17h => amdzen1}/other.json     |   0
 .../pmu-events/arch/x86/amdzen2/branch.json   |  52 +++
 .../pmu-events/arch/x86/amdzen2/cache.json    | 350 ++++++++++++++++++
 .../pmu-events/arch/x86/amdzen2/core.json     | 135 +++++++
 .../arch/x86/amdzen2/floating-point.json      | 128 +++++++
 .../pmu-events/arch/x86/amdzen2/memory.json   | 343 +++++++++++++++++
 .../pmu-events/arch/x86/amdzen2/other.json    | 129 +++++++
 tools/perf/pmu-events/arch/x86/mapfile.csv    |   3 +-
 14 files changed, 1238 insertions(+), 20 deletions(-)
 delete mode 100644 tools/perf/pmu-events/arch/x86/amdfam17h/branch.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen1/branch.json
 rename tools/perf/pmu-events/arch/x86/{amdfam17h => amdzen1}/cache.json (100%)
 rename tools/perf/pmu-events/arch/x86/{amdfam17h => amdzen1}/core.json (97%)
 rename tools/perf/pmu-events/arch/x86/{amdfam17h => amdzen1}/floating-point.json (62%)
 rename tools/perf/pmu-events/arch/x86/{amdfam17h => amdzen1}/memory.json (92%)
 rename tools/perf/pmu-events/arch/x86/{amdfam17h => amdzen1}/other.json (100%)
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen2/branch.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen2/cache.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen2/core.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen2/floating-point.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen2/memory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen2/other.json

-- 
2.25.1
