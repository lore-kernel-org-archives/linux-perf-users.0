From: Kajol Jain <kjain@linux.ibm.com>
Subject: [PATCH 0/8] powerpc/perf: Add json file metric support for the hv_24x7 socket/chip level events
Date: Fri, 14 Feb 2020 16:33:27 +0530
Message-ID: <20200214110335.31483-1-kjain@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: acme@kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, anju@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com, ravi.bangoria@linux.ibm.com, peterz@infradead.org, yao.jin@linux.intel.com, ak@linux.intel.com, jolsa@kernel.org, kan.liang@linux.intel.com, jmario@redhat.com, alexander.shishkin@linux.intel.com, mingo@kernel.org, paulus@ozlabs.org, namhyung@kernel.org, mpetlan@redhat.com, gregkh@linuxfoundation.org, benh@kernel.crashing.org, kjain@linux.ibm.com
List-Id: linux-perf-users.vger.kernel.org

The hv_24×7 feature in IBM® POWER9™ processor-based servers provide the
facility to continuously collect large numbers of hardware performance
metrics efficiently and accurately.

First patch of the patchset fix inconsistent results we are getting when
we run multiple 24x7 events.

Patchset adds json file metric support for the hv_24x7 socket/chip level
events. "hv_24x7" pmu interface events needs system dependent parameter
like socket/chip/core. For example, hv_24x7 chip level events needs
specific chip-id to which the data is requested should be added as part
of pmu events.

So to enable JSON file support to "hv_24x7" interface, patchset expose
total number of sockets and chips per-socket details in sysfs
files (sockets, chips) under "/sys/devices/hv_24x7/interface/".

To get sockets and number of chips per sockets, patchset adds a rtas call
with token "PROCESSOR_MODULE_INFO" to get these details. Patchset also
handles partition migration case to re-init these system depended
parameters by adding proper calls in post_mobility_fixup() (mobility.c).

Patch 6 & 8 of the patchset handles perf tool plumbing needed to replace
the "?" character in the metric expression to proper value and hv_24x7
json metric file for different Socket/chip resources.

Patch set also enable Hz/hz prinitg for --metric-only option to print
metric data for bus frequency.

Kajol Jain (8):
  powerpc/perf/hv-24x7: Fix inconsistent output values incase multiple
    hv-24x7 events run
  powerpc/hv-24x7: Add rtas call in hv-24x7 driver to get processor
    details
  powerpc/hv-24x7: Add sysfs files inside hv-24x7 device to show
    processor details
  Documentation/ABI: Add ABI documentation for chips and sockets
  powerpc/hv-24x7: Update post_mobility_fixup() to handle migration
  perf/tools: Enhance JSON/metric infrastructure to handle "?"
  tools/perf: Enable Hz/hz prinitg for --metric-only option
  perf/tools/pmu-events/powerpc: Add hv_24x7 socket/chip level metric
    events

 .../sysfs-bus-event_source-devices-hv_24x7    |  14 +++
 arch/powerpc/perf/hv-24x7.c                   |  96 ++++++++++++++-
 arch/powerpc/platforms/pseries/mobility.c     |  12 ++
 arch/powerpc/platforms/pseries/pseries.h      |   3 +
 tools/perf/arch/powerpc/util/header.c         |  40 +++++++
 .../arch/powerpc/power9/hv_24x7_metrics.json  |  19 +++
 tools/perf/util/expr.h                        |   1 +
 tools/perf/util/expr.y                        |  17 ++-
 tools/perf/util/metricgroup.c                 | 112 +++++++++++-------
 tools/perf/util/metricgroup.h                 |   1 +
 tools/perf/util/stat-display.c                |   2 -
 tools/perf/util/stat-shadow.c                 |   5 +
 12 files changed, 277 insertions(+), 45 deletions(-)
 create mode 100644 tools/perf/pmu-events/arch/powerpc/power9/hv_24x7_metrics.json

-- 
2.18.1
