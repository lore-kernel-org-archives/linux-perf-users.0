From: Kajol Jain <kjain@linux.ibm.com>
Subject: [PATCH v4 0/5] powerpc/perf: Add json file support for hv_24x7 core level events
Date: Mon, 20 Jul 2020 12:31:22 +0530
Message-ID: <20200720070127.109234-1-kjain@linux.ibm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: acme@kernel.org
Cc: peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, pc@us.ibm.com, jolsa@redhat.com, namhyung@kernel.org, ak@linux.intel.com, yao.jin@linux.intel.com, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, irogers@google.com, maddy@linux.ibm.com, ravi.bangoria@linux.ibm.com, anju@linux.vnet.ibm.com, kan.liang@linux.intel.com, nasastry@in.ibm.com, kjain@linux.ibm.com
List-Id: linux-perf-users.vger.kernel.org

Patchset enhance current runtime parameter support. It introduces new
fields like "PerChip" and "PerCore" similar to the field "PerPkg" which is
used to specify perpkg events. 

The "PerCore" and "PerChip" specifies whether its core or chip events.
Based on which we can decide which runtime parameter user want to
access. Now character  '?' can refers different parameter based on user
requirement.

Initially, every time we want to add new terms like chip, core, thread
etc, we need to create corrsponding fields in pmu_events and event
struct.
This patchset adds an enum called 'aggr_mode_class' which store all these
aggregation like perpkg/percore. It also adds new field 'AggregationMode'
to capture these terms.
Now, if user wants to add any new term, they just need to add it in
the enum defined. I try to test it with  my current setup.

I also need to replace PerPkg field to AggregationMode in all the
x86 uncore json files. It will great if Andi and team can test it
and let me know if they have any concerns.

Changelog:
v3 -> v4:
- Include pmu-events.h header file in jevents.c and remove
  redecalaration of enum aggr_mode_class as Suggested by Jiri.
- Add Acked-by tag.

v2 -> v3:
- Did some nits changes suggested by Jiri include correction of
  indentation, and making PerCore/PerChip values forward after
  PerPkg as 1 in the enum.
- Rebase the patchset on Arnaldo's tmp.perf/core branch.
- Change RFC tag

v1 -> v2:
- Rather then adding new field as PerCore/PerChip, created a new enum
  to get these fields. And new field as "AggregationMode" which can
  be used to capture these fields from json file.
  - Suggested By Ian Rogers


Kajol Jain (5):
  perf/pmu-events/jevents: Add enum to store aggregation like PerPkg
  pmu-events/x86/uncore: Replace PerPkg field to AggregationMode in x86
    json files
  perf jevents: Add support for parsing perchip/percore events
  perf/tools: Pass pmu_event structure as a parameter for
    arch_get_runtimeparam
  perf/tools/pmu_events/powerpc: Add hv_24x7 core level metric events

 tools/perf/arch/powerpc/util/header.c         |   7 +-
 .../arch/powerpc/power9/nest_metrics.json     |  27 +-
 .../arch/x86/broadwellde/uncore-cache.json    |  62 ++--
 .../arch/x86/broadwellde/uncore-memory.json   |  18 +-
 .../arch/x86/broadwellde/uncore-power.json    |  18 +-
 .../arch/x86/broadwellx/uncore-cache.json     |  62 ++--
 .../x86/broadwellx/uncore-interconnect.json   |   6 +-
 .../arch/x86/broadwellx/uncore-memory.json    |  18 +-
 .../arch/x86/broadwellx/uncore-power.json     |  18 +-
 .../arch/x86/cascadelakex/uncore-memory.json  |  64 ++--
 .../arch/x86/cascadelakex/uncore-other.json   | 332 +++++++++---------
 .../arch/x86/haswellx/uncore-cache.json       |  62 ++--
 .../x86/haswellx/uncore-interconnect.json     |   6 +-
 .../arch/x86/haswellx/uncore-memory.json      |  18 +-
 .../arch/x86/haswellx/uncore-power.json       |  18 +-
 .../arch/x86/ivytown/uncore-cache.json        |  62 ++--
 .../arch/x86/ivytown/uncore-interconnect.json |  10 +-
 .../arch/x86/ivytown/uncore-memory.json       |  16 +-
 .../arch/x86/ivytown/uncore-power.json        |  52 +--
 .../arch/x86/jaketown/uncore-cache.json       |  40 +--
 .../x86/jaketown/uncore-interconnect.json     |  10 +-
 .../arch/x86/jaketown/uncore-memory.json      |  18 +-
 .../arch/x86/jaketown/uncore-power.json       |  52 +--
 .../x86/knightslanding/uncore-memory.json     |   8 +-
 .../arch/x86/skylakex/uncore-memory.json      |  36 +-
 .../arch/x86/skylakex/uncore-other.json       | 220 ++++++------
 .../arch/x86/tremontx/uncore-memory.json      |  14 +-
 .../arch/x86/tremontx/uncore-other.json       |  70 ++--
 .../arch/x86/tremontx/uncore-power.json       |   2 +-
 tools/perf/pmu-events/jevents.c               |  40 ++-
 tools/perf/pmu-events/jevents.h               |   2 +-
 tools/perf/pmu-events/pmu-events.h            |   8 +-
 tools/perf/tests/pmu-events.c                 |   8 +-
 tools/perf/util/metricgroup.c                 |   5 +-
 tools/perf/util/metricgroup.h                 |   3 +-
 tools/perf/util/pmu.c                         |   6 +-
 36 files changed, 724 insertions(+), 694 deletions(-)

-- 
2.26.2
