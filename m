From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 64/91] perf doc: Pass ASCIIDOC_EXTRA as an argument
Date: Wed,  6 May 2020 12:22:07 -0300
Message-ID: <20200506152234.21977-65-acme@kernel.org>
References: <20200506152234.21977-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200506152234.21977-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Alexei Starovoitov <ast@kernel.org>, Alexey Budankov <alexey.budankov@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Andrii Nakryiko <andriin@fb.com>, Daniel Borkmann <daniel@iogearbox.net>, Florian Fainelli <f.fainelli@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Igor Lubashev <ilubashe@akamai.com>, Jin Yao <yao.jin@linux.intel.com>, Jiwei Sun <jiwei.sun@windriver.com>, John Garry <john.garry@huawei.com>K
List-Id: linux-perf-users.vger.kernel.org

From: Ian Rogers <irogers@google.com>

commit e9cfa47e687d ("perf doc: allow ASCIIDOC_EXTRA to be an argument")
allowed ASCIIDOC_EXTRA to be passed as an option to the Documentation
Makefile. This change passes ASCIIDOC_EXTRA, set by detected features or
command line options, prior to doing a Documentation build. This is
necessary to allow conditional compilation, based on configuration
variables, in asciidoc code.

Signed-off-by: Ian Rogers <irogers@google.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Andrii Nakryiko <andriin@fb.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Igor Lubashev <ilubashe@akamai.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiwei Sun <jiwei.sun@windriver.com>
Cc: John Garry <john.garry@huawei.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Martin KaFai Lau <kafai@fb.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Yonghong Song <yhs@fb.com>
Cc: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org
Cc: yuzhoujian <yuzhoujian@didichuxing.com>
Link: http://lore.kernel.org/lkml/20200429231443.207201-2-irogers@google.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.perf | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index d15a311408f1..94a495594e99 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -188,7 +188,7 @@ AWK     = awk
 # non-config cases
 config := 1
 
-NON_CONFIG_TARGETS := clean python-clean TAGS tags cscope help install-doc install-man install-html install-info install-pdf doc man html info pdf
+NON_CONFIG_TARGETS := clean python-clean TAGS tags cscope help
 
 ifdef MAKECMDGOALS
 ifeq ($(filter-out $(NON_CONFIG_TARGETS),$(MAKECMDGOALS)),)
@@ -832,7 +832,7 @@ INSTALL_DOC_TARGETS += quick-install-doc quick-install-man quick-install-html
 
 # 'make doc' should call 'make -C Documentation all'
 $(DOC_TARGETS):
-	$(Q)$(MAKE) -C $(DOC_DIR) O=$(OUTPUT) $(@:doc=all)
+	$(Q)$(MAKE) -C $(DOC_DIR) O=$(OUTPUT) $(@:doc=all) ASCIIDOC_EXTRA=$(ASCIIDOC_EXTRA)
 
 TAG_FOLDERS= . ../lib ../include
 TAG_FILES= ../../include/uapi/linux/perf_event.h
@@ -959,7 +959,7 @@ install-python_ext:
 
 # 'make install-doc' should call 'make -C Documentation install'
 $(INSTALL_DOC_TARGETS):
-	$(Q)$(MAKE) -C $(DOC_DIR) O=$(OUTPUT) $(@:-doc=)
+	$(Q)$(MAKE) -C $(DOC_DIR) O=$(OUTPUT) $(@:-doc=) ASCIIDOC_EXTRA=$(ASCIIDOC_EXTRA)
 
 ### Cleaning rules
 
-- 
2.21.1
