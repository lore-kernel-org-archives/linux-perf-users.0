From: Ian Rogers <irogers@google.com>
Subject: [RFC PATCH 12/12] perf pmu-events: Topdown parser tool
Date: Tue, 10 Nov 2020 02:03:46 -0800
Message-ID: <20201110100346.2527031-13-irogers@google.com>
References: <20201110100346.2527031-1-irogers@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: "irogers via sendgmr" <irogers@irogers.svl.corp.google.com>
In-Reply-To: <20201110100346.2527031-1-irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Jin Yao <yao.jin@linux.intel.com>, John Garry <john.garry@huawei.com>, Paul Clarke <pc@us.ibm.com>, kajoljain <kjain@linux.ibm.com>
Cc: Stephane Eranian <eranian@google.com>, Sandeep Dasgupta <sdasgup@google.com>, linux-perf-users@vger.kernel.org, Ian Rogers <irogers@google.com>
List-Id: linux-perf-users.vger.kernel.org

From: Sandeep Dasgupta <sdasgup@google.com>

A tool for processing Intel's TMA_Metrics.csv and from it generating
metrics encoded as json.

As an example, the build here is configured to wget TMA_Metrics.csv
from download.01.org/perfmon and then build the metric json using
events encoded in the pmu-events directory. As the TMA_Metrics.csv is
newer there are missing event encodings that will be warned about, in
particular icelake PERF_METRICS.*.

On a Skylakex this shows with 'perf list metricgroups' the new groups
of:
  Topdown_Group_Backend
  Topdown_Group_BadSpec
  Topdown_Group_BrMispredicts
  Topdown_Group_Cache_Misses
  Topdown_Group_DSB
  Topdown_Group_FLOPS
  Topdown_Group_Fetch_BW
  Topdown_Group_Fetch_Lat
  Topdown_Group_Frontend
  Topdown_Group_HPC
  Topdown_Group_IcMiss
  Topdown_Group_Machine_Clears
  Topdown_Group_Memory_BW
  Topdown_Group_Memory_Bound
  Topdown_Group_Memory_Lat
  Topdown_Group_MicroSeq
  Topdown_Group_Offcore
  Topdown_Group_Ports_Utilization
  Topdown_Group_Retire
  Topdown_Group_TLB
  Topdown_Group_TopDownL1
  Topdown_Group_TopDownL2

And the new metrics of:
  Topdown_Metric_Backend_Bound
  Topdown_Metric_Bad_Speculation
  Topdown_Metric_Branch_Mispredicts
  Topdown_Metric_Branch_Resteers
  Topdown_Metric_Core_Bound
  Topdown_Metric_DRAM_Bound
  Topdown_Metric_DSB
  Topdown_Metric_DSB_Switches
  Topdown_Metric_DTLB_Load
  Topdown_Metric_Divider
  Topdown_Metric_FB_Full
  Topdown_Metric_FP_Arith
  Topdown_Metric_FP_Scalar
  Topdown_Metric_FP_Vector
  Topdown_Metric_Fetch_Bandwidth
  Topdown_Metric_Fetch_Latency
  Topdown_Metric_Frontend_Bound
  Topdown_Metric_Heavy_Operations
  Topdown_Metric_ICache_Misses
  Topdown_Metric_ITLB_Misses
  Topdown_Metric_L1_Bound
  Topdown_Metric_L2_Bound
  Topdown_Metric_L3_Bound
  Topdown_Metric_Light_Operations
  Topdown_Metric_MEM_Bandwidth
  Topdown_Metric_MEM_Latency
  Topdown_Metric_MITE
  Topdown_Metric_MS_Switches
  Topdown_Metric_Machine_Clears
  Topdown_Metric_Memory_Bound
  Topdown_Metric_Microcode_Sequencer
  Topdown_Metric_Other
  Topdown_Metric_Ports_Utilization
  Topdown_Metric_Retiring
  Topdown_Metric_Serializing_Operation
  Topdown_Metric_Store_Bound

Using one of the metric groups shows:
$ perf stat -M Topdown_Group_TopDownL1 -a

 Performance counter stats for 'system wide':

    18,224,977,565      cpu/idq_uops_not_delivered.core,edge,any,inv/ #     0.38 Topdown_Metric_Frontend_Bound
                                                  #     0.44 Topdown_Metric_Backend_Bound  (57.11%)
       450,438,658      cpu/int_misc.recovery_cycles,edge,any,inv/ #     0.07 Topdown_Metric_Bad_Speculation  (57.11%)
    11,981,273,993      cpu/cpu_clk_unhalted.thread,edge,any,inv/ #     0.11 Topdown_Metric_Retiring  (57.13%)
     5,288,258,009      cpu/uops_retired.retire_slots,edge,any,inv/                                     (57.17%)
     6,808,261,153      cpu/uops_issued.any,edge,any,inv/                                     (57.19%)
       456,255,269      cpu/int_misc.recovery_cycles_any,edge,any,inv/                                     (57.17%)
    12,383,804,530      cpu/cpu_clk_unhalted.thread_any,edge,any,inv/                                     (57.12%)

      10.159307832 seconds time elapsed

Co-authored-by: Stephane Eranian <eranian@google.com>
Co-authored-by: Ian Rogers <irogers@google.com>
Signed-off-by: Ian Rogers <irogers@google.com>
Signed-off-by: Sandeep Dasgupta <sdasgup@google.com>
---
 tools/perf/Makefile.perf    | 13 +++++++++-
 tools/perf/pmu-events/Build | 50 ++++++++++++++++++++++++++++++++++---
 2 files changed, 58 insertions(+), 5 deletions(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 7ce3f2e8b9c7..b1f4145ca757 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -634,6 +634,11 @@ strip: $(PROGRAMS) $(OUTPUT)perf
 
 PERF_IN := $(OUTPUT)perf-in.o
 
+TOPDOWN_PARSER    := $(OUTPUT)pmu-events/topdown_parser
+TOPDOWN_PARSER_IN := $(OUTPUT)pmu-events/topdown_parser-in.o
+
+export TOPDOWN_PARSER
+
 JEVENTS       := $(OUTPUT)pmu-events/jevents
 JEVENTS_IN    := $(OUTPUT)pmu-events/jevents-in.o
 
@@ -646,13 +651,19 @@ build := -f $(srctree)/tools/build/Makefile.build dir=. obj
 $(PERF_IN): prepare FORCE
 	$(Q)$(MAKE) $(build)=perf
 
+$(TOPDOWN_PARSER_IN): FORCE
+	$(Q)$(MAKE) -f $(srctree)/tools/build/Makefile.build dir=pmu-events obj=topdown_parser
+
+$(TOPDOWN_PARSER): $(TOPDOWN_PARSER_IN)
+	$(QUIET_LINK)$(HOSTCC) $(TOPDOWN_PARSER_IN) -lstdc++ -o $@
+
 $(JEVENTS_IN): FORCE
 	$(Q)$(MAKE) -f $(srctree)/tools/build/Makefile.build dir=pmu-events obj=jevents
 
 $(JEVENTS): $(JEVENTS_IN)
 	$(QUIET_LINK)$(HOSTCC) $(JEVENTS_IN) -o $@
 
-$(PMU_EVENTS_IN): $(JEVENTS) FORCE
+$(PMU_EVENTS_IN): $(JEVENTS) $(TOPDOWN_PARSER) FORCE
 	$(Q)$(MAKE) -f $(srctree)/tools/build/Makefile.build dir=pmu-events obj=pmu-events
 
 $(OUTPUT)perf: $(PERFLIBS) $(PERF_IN) $(PMU_EVENTS_IN) $(LIBTRACEEVENT_DYNAMIC_LIST)
diff --git a/tools/perf/pmu-events/Build b/tools/perf/pmu-events/Build
index 215ba30b8534..d54bf9e8c224 100644
--- a/tools/perf/pmu-events/Build
+++ b/tools/perf/pmu-events/Build
@@ -1,15 +1,57 @@
-hostprogs := jevents
+hostprogs := jevents topdown_parser
 
 jevents-y	+= json.o jsmn.o jevents.o
 HOSTCFLAGS_jevents.o	= -I$(srctree)/tools/include
-pmu-events-y	+= pmu-events.o
+
+topdown_parser-y	+= topdown-parser/code_gen_target.o
+topdown_parser-y	+= topdown-parser/code_gen_target_perf_json.o
+topdown_parser-y	+= topdown-parser/configuration.o
+topdown_parser-y	+= topdown-parser/csvreader.o
+topdown_parser-y	+= topdown-parser/dependence_dag_utils.o
+topdown_parser-y	+= topdown-parser/event_info.o
+topdown_parser-y	+= topdown-parser/expr_parser-bison.o
+topdown_parser-y	+= topdown-parser/general_utils.o
+topdown_parser-y	+= topdown-parser/jsmn_extras.o
+topdown_parser-y	+= topdown-parser/topdown_parser_main.o
+topdown_parser-y	+= jsmn.o
+CXXFLAGS_topdown_parser += -I$(OUTPUT)pmu-events/topdown-parser
+
+$(OUTPUT)pmu-events/topdown-parser/expr_parser-bison.cpp $(OUTPUT)pmu-events/topdown-parser/expr_parser-bison.hpp: pmu-events/topdown-parser/expr_parser.y
+	$(call rule_mkdir)
+	$(Q)$(call echo-cmd,bison)$(BISON) -v $< -d $(PARSER_DEBUG_BISON) -o $@
+
+$(OUTPUT)pmu-events/topdown-parser/code_gen_target_perf_json.o: pmu-events/topdown-parser/code_gen_target_perf_json.cpp $(OUTPUT)pmu-events/topdown-parser/expr_parser-bison.hpp
+	$(call rule_mkdir)
+	$(call if_changed_dep,cxx_o_c)
+
+$(OUTPUT)pmu-events/topdown-parser/event_info.o: pmu-events/topdown-parser/event_info.cpp $(OUTPUT)pmu-events/topdown-parser/expr_parser-bison.hpp
+	$(call rule_mkdir)
+	$(call if_changed_dep,cxx_o_c)
+
+TMA_METRICS = $(OUTPUT)pmu-events/TMA_Metrics.csv
+
+$(TMA_METRICS):
+	$(call rule_mkdir)
+	wget -O $@ https://download.01.org/perfmon/TMA_Metrics.csv
+
 JDIR		=  pmu-events/arch/$(SRCARCH)
 JSON		=  $(shell [ -d $(JDIR) ] &&				\
 			find $(JDIR) -name '*.json' -o -name 'mapfile.csv')
 
+$(OUTPUT)pmu-events/arch: pmu-events/topdown-parser/configuration.json $(TOPDOWN_PARSER) $(TMA_METRICS) $(JSON)
+	mkdir -p $(OUTPUT)pmu-events/arch
+	cp -R pmu-events/arch $(OUTPUT)pmu-events/
+	$(TOPDOWN_PARSER) \
+	    --csv-file $(TMA_METRICS) \
+	    --events-data-dir pmu-events/arch/x86 \
+            --config-file $< \
+            --output-path $(OUTPUT)pmu-events/arch/x86
+
+pmu-events-y	+= pmu-events.o
+
 #
 # Locate/process JSON files in pmu-events/arch/
 # directory and create tables in pmu-events.c.
 #
-$(OUTPUT)pmu-events/pmu-events.c: $(JSON) $(JEVENTS)
-	$(Q)$(call echo-cmd,gen)$(JEVENTS) $(SRCARCH) pmu-events/arch $(OUTPUT)pmu-events/pmu-events.c $(V)
+$(OUTPUT)pmu-events/pmu-events.c: $(OUTPUT)pmu-events/arch $(JSON) $(JEVENTS)
+	$(Q)$(call echo-cmd,gen)$(JEVENTS) $(SRCARCH) $(OUTPUT)pmu-events/arch $(OUTPUT)pmu-events/pmu-events.c $(V)
-- 
2.29.2.222.g5d2a92d10f8-goog
