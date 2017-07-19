From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 43/86] perf tests attr: Do not store failed events
Date: Wed, 19 Jul 2017 11:29:07 -0300
Message-ID: <20170719142950.3747-44-acme@kernel.org>
References: <20170719142950.3747-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170719142950.3747-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Thomas Richter <tmricht@linux.vnet.ibm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Do not mess up our temp space with files we don't
need - failed event open attempts.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Thomas Richter <tmricht@linux.vnet.ibm.com>
Link: http://lkml.kernel.org/r/20170703145030.12903-3-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/attr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/attr.c b/tools/perf/tests/attr.c
index 0e77b2cf61ec..08b1d5ce9020 100644
--- a/tools/perf/tests/attr.c
+++ b/tools/perf/tests/attr.c
@@ -136,7 +136,7 @@ void test_attr__open(struct perf_event_attr *attr, pid_t pid, int cpu,
 {
 	int errno_saved = errno;
 
-	if (store_event(attr, pid, cpu, fd, group_fd, flags)) {
+	if ((fd != -1) && store_event(attr, pid, cpu, fd, group_fd, flags)) {
 		pr_err("test attr FAILED");
 		exit(128);
 	}
-- 
2.9.4
