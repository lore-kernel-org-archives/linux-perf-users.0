From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 3/8] perf test attr: Fix ignored test case result
Date: Tue,  3 Oct 2017 09:55:35 -0300
Message-ID: <20171003125540.331-4-acme@kernel.org>
References: <20171003125540.331-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171003125540.331-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Thomas Richter <tmricht@linux.vnet.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Thomas Richter <tmricht@linux.vnet.ibm.com>

Command perf test -v 16 (Setup struct perf_event_attr test) always
reports success even if the test case fails.  It works correctly if you
also specify -F (for don't fork).

   root@s35lp76 perf]# ./perf test -v 16
   15: Setup struct perf_event_attr               :
   --- start ---
   running './tests/attr/test-record-no-delay'
   [ perf record: Woken up 1 times to write data ]
   [ perf record: Captured and wrote 0.002 MB /tmp/tmp4E1h7R/perf.data
     (1 samples) ]
   expected task=0, got 1
   expected precise_ip=0, got 3
   expected wakeup_events=1, got 0
   FAILED './tests/attr/test-record-no-delay' - match failure
   test child finished with 0
   ---- end ----
   Setup struct perf_event_attr: Ok

The reason for the wrong error reporting is the return value of the
system() library call. It is called in run_dir() file tests/attr.c and
returns the exit status, in above case 0xff00.

This value is given as parameter to the exit() function which can only
handle values 0-0xff.

The child process terminates with exit value of 0 and the parent does
not detect any error.

This patch corrects the error reporting and prints the correct test
result.

Signed-off-by: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>
LPU-Reference: 20170913081209.39570-2-tmricht@linux.vnet.ibm.com
Link: http://lkml.kernel.org/n/tip-rdube6rfcjsr1nzue72c7lqn@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/attr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/attr.c b/tools/perf/tests/attr.c
index c9aafed7da15..25ede4472465 100644
--- a/tools/perf/tests/attr.c
+++ b/tools/perf/tests/attr.c
@@ -166,7 +166,7 @@ static int run_dir(const char *d, const char *perf)
 	snprintf(cmd, 3*PATH_MAX, PYTHON " %s/attr.py -d %s/attr/ -p %s %.*s",
 		 d, d, perf, vcnt, v);
 
-	return system(cmd);
+	return system(cmd) ? TEST_FAIL : TEST_OK;
 }
 
 int test__attr(struct test *test __maybe_unused, int subtest __maybe_unused)
-- 
2.13.6
