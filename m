From: Kajol Jain <kjain@linux.ibm.com>
Subject: [RFC 0/3] powerpc/perf: Add json file support for hv_24x7 core level events
Date: Thu, 25 Jun 2020 17:17:15 +0530
Message-ID: <20200625114718.229911-1-kjain@linux.ibm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: acme@kernel.org
Cc: peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, pc@us.ibm.com, jolsa@redhat.com, namhyung@kernel.org, ak@linux.intel.com, yao.jin@linux.intel.com, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, irogers@google.com, maddy@linux.ibm.com, ravi.bangoria@linux.ibm.com, anju@linux.vnet.ibm.com, kan.liang@linux.intel.com, kjain@linux.ibm.com
List-Id: linux-perf-users.vger.kernel.org

Patchset enhance current runtime parameter support. It introduces new
fields like "PerChip" and "PerCore" similar to the field "PerPkg" which is
used to specify perpkg events. 

The "PerCore" and "PerChip" specifies whether its core or chip events.
Based on which we can decide which runtime parameter user want to
access. Now character  '?' can refers different parameter based on user
requirement.

Kajol Jain (3):
  perf jevents: Add support for parsing perchip/percore events
  perf/tools: Pass pmu_event structure as a parameter for
    arch_get_runtimeparam
  perf/tools/pmu_events/powerpc: Add hv_24x7 core level metric events

 tools/perf/arch/powerpc/util/header.c         |  7 ++--
 .../arch/powerpc/power9/nest_metrics.json     | 15 ++++++--
 tools/perf/pmu-events/jevents.c               | 34 +++++++++++++++----
 tools/perf/pmu-events/jevents.h               |  3 +-
 tools/perf/pmu-events/pmu-events.h            |  2 ++
 tools/perf/util/metricgroup.c                 |  5 ++-
 tools/perf/util/metricgroup.h                 |  3 +-
 7 files changed, 53 insertions(+), 16 deletions(-)

-- 
2.26.2
