From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 06/10] perf tools: Fix a typo in a variable name in the Documentation Makefile
Date: Thu,  8 Aug 2019 15:53:54 -0300
Message-ID: <20190808185358.20125-7-acme@kernel.org>
References: <20190808185358.20125-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190808185358.20125-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Masanari Iida <standby24x7@gmail.com>, Mukesh Ojha <mojha@codeaurora.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Masanari Iida <standby24x7@gmail.com>

This patch fix a spelling typo in a variable name in the Documentation Makefile.

Signed-off-by: Masanari Iida <standby24x7@gmail.com>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190801032812.25018-1-standby24x7@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/Makefile b/tools/perf/Documentation/Makefile
index 6d148a40551c..adc5a7e44b98 100644
--- a/tools/perf/Documentation/Makefile
+++ b/tools/perf/Documentation/Makefile
@@ -242,7 +242,7 @@ $(OUTPUT)doc.dep : $(wildcard *.txt) build-docdep.perl
 	$(PERL_PATH) ./build-docdep.perl >$@+ $(QUIET_STDERR) && \
 	mv $@+ $@
 
--include $(OUPTUT)doc.dep
+-include $(OUTPUT)doc.dep
 
 _cmds_txt = cmds-ancillaryinterrogators.txt \
 	cmds-ancillarymanipulators.txt \
-- 
2.21.0
