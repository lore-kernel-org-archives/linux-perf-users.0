From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 44/44] perf vendor events intel: Update Silvermont to v14
Date: Tue,  2 Apr 2019 13:05:49 -0300
Message-ID: <20190402160549.13544-45-acme@kernel.org>
References: <20190402160549.13544-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190402160549.13544-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Kan Liang <kan.liang@intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Cc: Kan Liang <kan.liang@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Link: https://lkml.kernel.org/r/20190315165219.GA21223@tassilo.jf.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../pmu-events/arch/x86/silvermont/cache.json |  2 +-
 .../pmu-events/arch/x86/silvermont/other.json | 20 +++++++++++++++++++
 .../arch/x86/silvermont/pipeline.json         |  5 +----
 3 files changed, 22 insertions(+), 5 deletions(-)
 create mode 100644 tools/perf/pmu-events/arch/x86/silvermont/other.json

diff --git a/tools/perf/pmu-events/arch/x86/silvermont/cache.json b/tools/p=
erf/pmu-events/arch/x86/silvermont/cache.json
index 82be7d1b8b81..805ef1436539 100644
--- a/tools/perf/pmu-events/arch/x86/silvermont/cache.json
+++ b/tools/perf/pmu-events/arch/x86/silvermont/cache.json
@@ -36,7 +36,7 @@
         "BriefDescription": "L2 cache request misses"
     },
     {
-        "PublicDescription": "Counts cycles that fetch is stalled due to a=
n outstanding ICache miss. That is, the decoder queue is able to accept byt=
es, but the fetch unit is unable to provide bytes due to an ICache miss.  N=
ote: this event is not the same as the total number of cycles spent retriev=
ing instruction cache lines from the memory hierarchy.\r\nCounts cycles tha=
t fetch is stalled due to any reason. That is, the decoder queue is able to=
 accept bytes, but the fetch unit is unable to provide bytes.  This will in=
clude cycles due to an ITLB miss, ICache miss and other events. \r\n",
+        "PublicDescription": "Counts cycles that fetch is stalled due to a=
n outstanding ICache miss. That is, the decoder queue is able to accept byt=
es, but the fetch unit is unable to provide bytes due to an ICache miss.  N=
ote: this event is not the same as the total number of cycles spent retriev=
ing instruction cache lines from the memory hierarchy.\r\nCounts cycles tha=
t fetch is stalled due to any reason. That is, the decoder queue is able to=
 accept bytes, but the fetch unit is unable to provide bytes.  This will in=
clude cycles due to an ITLB miss, ICache miss and other events.",
         "EventCode": "0x86",
         "Counter": "0,1",
         "UMask": "0x4",
diff --git a/tools/perf/pmu-events/arch/x86/silvermont/other.json b/tools/p=
erf/pmu-events/arch/x86/silvermont/other.json
new file mode 100644
index 000000000000..47814046fa9d
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/silvermont/other.json
@@ -0,0 +1,20 @@
+[
+    {
+        "PublicDescription": "Counts cycles that fetch is stalled due to a=
n outstanding ITLB miss. That is, the decoder queue is able to accept bytes=
, but the fetch unit is unable to provide bytes due to an ITLB miss.  Note:=
 this event is not the same as page walk cycles to retrieve an instruction =
translation.",
+        "EventCode": "0x86",
+        "Counter": "0,1",
+        "UMask": "0x2",
+        "EventName": "FETCH_STALL.ITLB_FILL_PENDING_CYCLES",
+        "SampleAfterValue": "200003",
+        "BriefDescription": "Cycles code-fetch stalled due to an outstandi=
ng ITLB miss."
+    },
+    {
+        "PublicDescription": "Counts cycles that fetch is stalled due to a=
ny reason. That is, the decoder queue is able to accept bytes, but the fetc=
h unit is unable to provide bytes.  This will include cycles due to an ITLB=
 miss, ICache miss and other events.",
+        "EventCode": "0x86",
+        "Counter": "0,1",
+        "UMask": "0x3f",
+        "EventName": "FETCH_STALL.ALL",
+        "SampleAfterValue": "200003",
+        "BriefDescription": "Cycles code-fetch stalled due to any reason."
+    }
+]
\ No newline at end of file
diff --git a/tools/perf/pmu-events/arch/x86/silvermont/pipeline.json b/tool=
s/perf/pmu-events/arch/x86/silvermont/pipeline.json
index 7468af99190a..1ed62ad4cf77 100644
--- a/tools/perf/pmu-events/arch/x86/silvermont/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/silvermont/pipeline.json
@@ -210,7 +210,7 @@
         "UMask": "0x4",
         "EventName": "NO_ALLOC_CYCLES.MISPREDICTS",
         "SampleAfterValue": "200003",
-        "BriefDescription": "Counts the number of cycles when no uops are =
allocated and the alloc pipe is stalled waiting for a mispredicted jump to =
retire.  After the misprediction is detected, the front end will start imme=
diately but the allocate pipe stalls until the mispredicted "
+        "BriefDescription": "Counts the number of cycles when no uops are =
allocated and the alloc pipe is stalled waiting for a mispredicted jump to =
retire.  After the misprediction is detected, the front end will start imme=
diately but the allocate pipe stalls until the mispredicted"
     },
     {
         "EventCode": "0xCA",
@@ -275,7 +275,6 @@
     },
     {
         "PublicDescription": "This event counts the number of instructions=
 that retire.  For instructions that consist of multiple micro-ops, this ev=
ent counts exactly once, as the last micro-op of the instruction retires.  =
The event continues counting while instructions retire, including during in=
terrupt service routines caused by hardware interrupts, faults or traps.  B=
ackground: Modern microprocessors employ extensive pipelining and speculati=
ve techniques.  Since sometimes an instruction is started but never complet=
ed, the notion of \"retirement\" is introduced.  A retired instruction is o=
ne that commits its states. Or stated differently, an instruction might be =
abandoned at some point. No instruction is truly finished until it retires.=
  This counter measures the number of completed instructions.  The fixed ev=
ent is INST_RETIRED.ANY and the programmable event is INST_RETIRED.ANY_P.",
-        "EventCode": "0x00",
         "Counter": "Fixed counter 1",
         "UMask": "0x1",
         "EventName": "INST_RETIRED.ANY",
@@ -284,7 +283,6 @@
     },
     {
         "PublicDescription": "Counts the number of core cycles while the c=
ore is not in a halt state. The core enters the halt state when it is runni=
ng the HLT instruction. This event is a component in many key event ratios.=
  The core frequency may change from time to time. For this reason this eve=
nt may have a changing ratio with regards to time. In systems with a consta=
nt core frequency, this event can give you a measurement of the elapsed tim=
e while the core was not in halt state by dividing the event count by the c=
ore frequency. This event is architecturally defined and is a designated fi=
xed counter.  CPU_CLK_UNHALTED.CORE and CPU_CLK_UNHALTED.CORE_P use the cor=
e frequency which may change from time to time.  CPU_CLK_UNHALTE.REF_TSC an=
d CPU_CLK_UNHALTED.REF are not affected by core frequency changes but count=
s as if the core is running at the maximum frequency all the time.  The fix=
ed events are CPU_CLK_UNHALTED.CORE and CPU_CLK_UNHALTED.REF_TSC and the pr=
ogrammable events are CPU_CLK_UNHALTED.CORE_P and CPU_CLK_UNHALTED.REF.",
-        "EventCode": "0x00",
         "Counter": "Fixed counter 2",
         "UMask": "0x2",
         "EventName": "CPU_CLK_UNHALTED.CORE",
@@ -293,7 +291,6 @@
     },
     {
         "PublicDescription": "Counts the number of reference cycles while =
the core is not in a halt state. The core enters the halt state when it is =
running the HLT instruction. This event is a component in many key event ra=
tios.  The core frequency may change from time. This event is not affected =
by core frequency changes but counts as if the core is running at the maxim=
um frequency all the time.  Divide this event count by core frequency to de=
termine the elapsed time while the core was not in halt state.  Divide this=
 event count by core frequency to determine the elapsed time while the core=
 was not in halt state.  This event is architecturally defined and is a des=
ignated fixed counter.  CPU_CLK_UNHALTED.CORE and CPU_CLK_UNHALTED.CORE_P u=
se the core frequency which may change from time to time.  CPU_CLK_UNHALTE.=
REF_TSC and CPU_CLK_UNHALTED.REF are not affected by core frequency changes=
 but counts as if the core is running at the maximum frequency all the time=
.  The fixed events are CPU_CLK_UNHALTED.CORE and CPU_CLK_UNHALTED.REF_TSC =
and the programmable events are CPU_CLK_UNHALTED.CORE_P and CPU_CLK_UNHALTE=
D.REF.",
-        "EventCode": "0x00",
         "Counter": "Fixed counter 3",
         "UMask": "0x3",
         "EventName": "CPU_CLK_UNHALTED.REF_TSC",
--=20
2.20.1
