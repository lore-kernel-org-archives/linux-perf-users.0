From: Vijay Thakkar <vijaythakkar@me.com>
Subject: [PATCH v2 0/3] latest PMU events for zen1/zen2
Date: Tue, 25 Feb 2020 14:28:12 -0500
Message-ID: <20200225192815.50388-1-vijaythakkar@me.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Vijay Thakkar <vijaythakkar@me.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Kim Phillips <kim.phillips@amd.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, =?UTF-8?q?Martin=20Li=C5=A1ka?= <mliska@suse.cz>, Jon Grimm <jon.grimm@amd.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

This series of patches brings the PMU events for AMD family 17h series
of processors up to date with the latest versions of the AMD processor
programming reference manuals.

The first patch changes the pmu events mapfile to be more selective for
the model number rather than blanket detecting all f17h processors to
have the same events directory. This is required for the later patch
where we add events for zen2 based processors. In v2 of the patch, the
incorrect regex for model string was correct to include the range 0
through 2f.

The second patch adds the PMU events for zen2. In v2 ls_mab_alloc.loads
umask is corrected. No events from Zen1 have been removed.

Finally the third patch updates the zen1 PMU events to be in accordance
with the latest PPR version and bumps up the events version to v2. In v2
of the patch series, missing events (bp_dyn_ind_pred and bp_de_redirect)
were added and umasks were corrected for fpu_pipe_assignment.dual* and
ls_mab_alloc.loads.

Vijay Thakkar (3):
  perf vendor events amd: restrict model detection for zen1 based
    processors
  perf vendor events amd: add Zen2 events
  perf vendor events amd: update Zen1 events to V2

 .../pmu-events/arch/x86/amdfam17h/branch.json |  12 -
 .../pmu-events/arch/x86/amdzen1/branch.json   |  23 ++
 .../x86/{amdfam17h => amdzen1}/cache.json     |   0
 .../pmu-events/arch/x86/amdzen1/core.json     | 129 ++++++
 .../floating-point.json                       |  56 +++
 .../x86/{amdfam17h => amdzen1}/memory.json    |  18 +
 .../x86/{amdfam17h => amdzen1}/other.json     |   0
 .../pmu-events/arch/x86/amdzen2/branch.json   |  56 +++
 .../pmu-events/arch/x86/amdzen2/cache.json    | 375 ++++++++++++++++++
 .../arch/x86/{amdfam17h => amdzen2}/core.json |   0
 .../arch/x86/amdzen2/floating-point.json      | 128 ++++++
 .../pmu-events/arch/x86/amdzen2/memory.json   | 349 ++++++++++++++++
 .../pmu-events/arch/x86/amdzen2/other.json    | 137 +++++++
 tools/perf/pmu-events/arch/x86/mapfile.csv    |   3 +-
 14 files changed, 1273 insertions(+), 13 deletions(-)
 delete mode 100644 tools/perf/pmu-events/arch/x86/amdfam17h/branch.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen1/branch.json
 rename tools/perf/pmu-events/arch/x86/{amdfam17h => amdzen1}/cache.json (100%)
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen1/core.json
 rename tools/perf/pmu-events/arch/x86/{amdfam17h => amdzen1}/floating-point.json (63%)
 rename tools/perf/pmu-events/arch/x86/{amdfam17h => amdzen1}/memory.json (93%)
 rename tools/perf/pmu-events/arch/x86/{amdfam17h => amdzen1}/other.json (100%)
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen2/branch.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen2/cache.json
 rename tools/perf/pmu-events/arch/x86/{amdfam17h => amdzen2}/core.json (100%)
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen2/floating-point.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen2/memory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen2/other.json

-- 
2.25.1
