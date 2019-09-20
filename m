From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 02/31] perf tests: Add libperf automated test for 'make -C tools/perf build-test'
Date: Fri, 20 Sep 2019 11:25:13 -0300
Message-ID: <20190920142542.12047-3-acme@kernel.org>
References: <20190920142542.12047-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190920142542.12047-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Michael Petlan <mpetlan@redhat.com>, Peter Zijlstra <peterz@infradead.org>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Add a libperf build test, that is triggered when one does:

  $ make -C tools/perf build-test

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20190901124822.10132-4-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/make | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/make b/tools/perf/tests/make
index 70c48475896d..6b3afed5d910 100644
--- a/tools/perf/tests/make
+++ b/tools/perf/tests/make
@@ -327,6 +327,10 @@ make_kernelsrc_tools:
 	(make -C ../../tools $(PARALLEL_OPT) $(K_O_OPT) perf) > $@ 2>&1 && \
 	test -x $(KERNEL_O)/tools/perf/perf && rm -f $@ || (cat $@ ; false)
 
+make_libperf:
+	@echo "- make -C lib";
+	make -C lib clean >$@ 2>&1; make -C lib >>$@ 2>&1 && rm $@
+
 FEATURES_DUMP_FILE := $(FULL_O)/BUILD_TEST_FEATURE_DUMP
 FEATURES_DUMP_FILE_STATIC := $(FULL_O)/BUILD_TEST_FEATURE_DUMP_STATIC
 
@@ -365,5 +369,5 @@ $(foreach t,$(run),$(if $(findstring make_static,$(t)),\
 			$(eval $(t) := $($(t)) FEATURES_DUMP=$(FEATURES_DUMP_FILE))))
 endif
 
-.PHONY: all $(run) $(run_O) tarpkg clean make_kernelsrc make_kernelsrc_tools
+.PHONY: all $(run) $(run_O) tarpkg clean make_kernelsrc make_kernelsrc_tools make_libperf
 endif # ifndef MK
-- 
2.21.0
