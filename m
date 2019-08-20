From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 07/17] tools lib traceevent: Fix "robust" test of do_generate_dynamic_list_file
Date: Tue, 20 Aug 2019 16:27:23 -0300
Message-ID: <20190820192733.19180-8-acme@kernel.org>
References: <20190820192733.19180-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190820192733.19180-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, "Steven Rostedt (VMware)" <rostedt@goodmis.org>, Tzvetomir Stoyanov <tstoyanov@vmware.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, David Carrillo-Cisneros <davidcc@google.com>, He Kuang <hekuang@huawei.com>, Michal rarek <mmarek@suse.com>, Paul Turner <pjt@google.com>, Peter Zijlstra <peterz@infradead.org>, Stephane Eranian <eranian@google.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Wang Nan <wangnan0@huawei.com>, stable@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

The tools/lib/traceevent/Makefile had a test added to it to detect a failure
of the "nm" when making the dynamic list file (whatever that is). The
problem is that the test sorts the values "U W w" and some versions of sort
will place "w" ahead of "W" (even though it has a higher ASCII value, and
break the test.

Add 'tr "w" "W"' to merge the two and not worry about the ordering.

Reported-by: Tzvetomir Stoyanov <tstoyanov@vmware.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Carrillo-Cisneros <davidcc@google.com>
Cc: He Kuang <hekuang@huawei.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Michal rarek <mmarek@suse.com>
Cc: Paul Turner <pjt@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Cc: Wang Nan <wangnan0@huawei.com>
Cc: stable@vger.kernel.org
Fixes: 6467753d61399 ("tools lib traceevent: Robustify do_generate_dynamic_list_file")
Link: http://lkml.kernel.org/r/20190805130150.25acfeb1@gandalf.local.home
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/traceevent/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/lib/traceevent/Makefile b/tools/lib/traceevent/Makefile
index 3292c290654f..8352d53dcb5a 100644
--- a/tools/lib/traceevent/Makefile
+++ b/tools/lib/traceevent/Makefile
@@ -266,8 +266,8 @@ endef
 
 define do_generate_dynamic_list_file
 	symbol_type=`$(NM) -u -D $1 | awk 'NF>1 {print $$1}' | \
-	xargs echo "U W w" | tr ' ' '\n' | sort -u | xargs echo`;\
-	if [ "$$symbol_type" = "U W w" ];then				\
+	xargs echo "U w W" | tr 'w ' 'W\n' | sort -u | xargs echo`;\
+	if [ "$$symbol_type" = "U W" ];then				\
 		(echo '{';						\
 		$(NM) -u -D $1 | awk 'NF>1 {print "\t"$$2";"}' | sort -u;\
 		echo '};';						\
-- 
2.21.0
