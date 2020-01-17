From: Kajol Jain <kjain@linux.ibm.com>
Subject: [RFC 0/6] powerpc/perf: Add json file metric support for the hv_24x7 socket/chip level events
Date: Fri, 17 Jan 2020 18:16:14 +0530
Message-ID: <20200117124620.26094-1-kjain@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=a
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: acme@kernel.org, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, anju@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com, ravi.bangoria@linux.ibm.com, peterz@infradead.org, yao.jin@linux.intel.com, ak@linux.intel.com, jolsa@kernel.org, kan.liang@linux.intel.com, jmario@redhat.com, alexander.shishkin@linux.intel.com, mingo@kernel.org, paulus@ozlabs.org, namhyung@kernel.org, mpetlan@redhat.com, gregkh@linuxfoundation.org, kjain@linux.ibm.com, benh@kernel.crashing.org
List-Id: linux-perf-users.vger.kernel.org

MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The hv_24×7 feature in IBM® POWER9™ processor-based servers provide the
facility to continuously collect large numbers of hardware performance
metrics efficiently and accurately.

Patchset adds json file metric support for the hv_24x7 socket/chip level
events. "hv_24x7" pmu interface events needs system dependend parameter
like socket/chip/core. For example, hv_24x7 chip level events needs
specific chip-id to which the data is requested should be added as part
of pmu events.

So to enable JSON file support to "hv_24x7" interface, patchset expose
total number of sockets and chips per-socket details in sysfs
files (sockets, chips) under "/sys/devices/hv_24x7/interface/".

To get sockets and number of chips per sockets, patchset adds a rtas call
with token "PROCESSOR_MODULE_INFO" to get these details. Patchset also
handles partition migration case to re-init these system depended parameters
by adding proper calls in post_mobility_fixup() (mobility.c).

Patch 5 and 6 of the patchset handles perf tool plumbing needed to replace the "?"
character in the metric expression to proper value and hv_24x7 json metric file
for different Socket/chip resources.

Kajol Jain (6):
  powerpc/hv-24x7: Add rtas call in hv-24x7 driver to get processor
    details
  powerpc/hv-24x7: Add sysfs files inside hv-24x7 device to show
    processor details
  Documentation/ABI: Add ABI documentation for chips and sockets
  powerpc/hv-24x7: Handle migration case of lpar for proper system
    information in sysfs
  perf/tools: Enhance JSON/metric infrastructure to handle "?"
  perf/tools/pmu-events/powerpc: Add hv_24x7 socket/chip level metric
    events

 .../sysfs-bus-event_source-devices-hv_24x7    |  14 +++
 arch/powerpc/perf/hv-24x7.c                   |  90 ++++++++++++++
 arch/powerpc/platforms/pseries/mobility.c     |  12 ++
 arch/powerpc/platforms/pseries/pseries.h      |   3 +
 tools/perf/arch/powerpc/util/header.c         |  40 ++++++
 .../arch/powerpc/power9/hv_24x7_metrics.json  |  64 ++++++++++
 tools/perf/util/expr.h                        |   1 +
 tools/perf/util/expr.y                        |  17 ++-
 tools/perf/util/metricgroup.c                 | 117 +++++++++++-------
 tools/perf/util/metricgroup.h                 |   1 +
 tools/perf/util/stat-shadow.c                 |   5 +
 11 files changed, 321 insertions(+), 43 deletions(-)
 create mode 100644 tools/perf/pmu-events/arch/powerpc/power9/hv_24x7_metrics.json

-- 
2.18.1
