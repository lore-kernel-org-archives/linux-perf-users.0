From: Kajol Jain <kjain@linux.ibm.com>
Subject: [PATCH v2 0/8] powerpc/perf: Add json file metric support for the
 hv_24x7 socket/chip level events
Date: Fri, 21 Feb 2020 11:40:14 +0530
Message-ID: <20200221061022.3047-1-kjain@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane-mx.org@lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane-mx.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane-mx.org@lists.ozlabs.org>
To: acme@kernel.org, linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, suka@us.ibm.com
Cc: mark.rutland@arm.com, ravi.bangoria@linux.ibm.com, maddy@linux.vnet.ibm.com, tglx@linutronix.de, jmario@redhat.com, peterz@infradead.org, gregkh@linuxfoundation.org, mpetlan@redhat.com, alexander.shishkin@linux.intel.com, linux-perf-users@vger.kernel.org, ak@linux.intel.com, yao.jin@linux.intel.com, anju@linux.vnet.ibm.com, mamatha4@linux.vnet.ibm.com, kjain@linux.ibm.com, jolsa@kernel.org, namhyung@kernel.org, mingo@kernel.org, kan.liang@linux.intel.com
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

Changelog:

v1 -> v2
- Rename hv-24x7 metric json file as nest_metrics.json

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
 .../arch/powerpc/power9/nest_metrics.json     |  19 +++
 tools/perf/util/expr.h                        |   1 +
 tools/perf/util/expr.y                        |  17 ++-
 tools/perf/util/metricgroup.c                 | 112 +++++++++++-------
 tools/perf/util/metricgroup.h                 |   1 +
 tools/perf/util/stat-display.c                |   2 -
 tools/perf/util/stat-shadow.c                 |   5 +
 12 files changed, 277 insertions(+), 45 deletions(-)
 create mode 100644 tools/perf/pmu-events/arch/powerpc/power9/nest_metrics.json

-- 
2.18.1
