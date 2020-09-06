From: Kajol Jain <kjain@linux.ibm.com>
Subject: [PATCH v8 0/5] powerpc/perf: Add json file support for hv_24x7 core level events
Date: Sun,  6 Sep 2020 16:49:59 +0530
Message-ID: <20200906112004.49574-1-kjain@linux.ibm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: acme@kernel.org
Cc: peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, pc@us.ibm.com, jolsa@redhat.com, namhyung@kernel.org, ak@linux.intel.com, yao.jin@linux.intel.com, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, irogers@google.com, maddy@linux.ibm.com, ravi.bangoria@linux.ibm.com, john.garry@huawei.com, kjain@linux.ibm.com
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
aggregation like perchip/percore. It also adds new field 'AggregationMode'
to capture these terms.
Now, if user wants to add any new term, they just need to add it in
the enum defined.

This patchset also adds  changes of adding new structure
called 'json_event' inside jevents.c
file to improve the callback prototype inside jevent file.
Initially, whenever user want to add new field, they need to update
in all function callback which makes it more and more complex with
increased number of parmeters.
With this change, we just need to add it in new structure 'json_event'.
link to the RFC patch: https://lkml.org/lkml/2020/8/25/217

Changelog:
v7 -> v8
- Change commit typo from jevents.h to jevents.c
- Make json_events function static in first patch.

v6 -> v7
- Remove min and get_cpu_str functions from jevents.c
- Make json_events function static to solve warning part [John Garry].
- Add event attribute in json_events function to remove strcpy from
  real_event function, as suggested by Jiri Olsa.
- Add warning while checking aggr_mode value [Jiri Olsa].

Kajol Jain (5):
  perf/jevents: Remove jevents.h file
  perf/jevents: Add new structure to pass json fields.
  perf jevents: Add support for parsing perchip/percore events
  perf/tools: Pass pmu_event structure as a parameter for
    arch_get_runtimeparam
  perf/tools/pmu_events/powerpc: Add hv_24x7 core level metric events

 tools/perf/arch/powerpc/util/header.c         |   7 +-
 .../arch/powerpc/power9/nest_metrics.json     |  35 ++-
 tools/perf/pmu-events/jevents.c               | 234 +++++++++---------
 tools/perf/pmu-events/jevents.h               |  23 --
 tools/perf/pmu-events/pmu-events.h            |   6 +
 tools/perf/util/metricgroup.c                 |   5 +-
 tools/perf/util/metricgroup.h                 |   3 +-
 7 files changed, 154 insertions(+), 159 deletions(-)
 delete mode 100644 tools/perf/pmu-events/jevents.h

-- 
2.26.2
