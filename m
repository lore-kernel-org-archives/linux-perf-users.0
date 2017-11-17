From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 63/83] perf top: Ignore kptr_restrict when not sampling the kernel
Date: Fri, 17 Nov 2017 17:15:41 -0300
Message-ID: <20171117201601.24110-64-acme@kernel.org>
References: <20171117201601.24110-1-acme@kernel.org>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:58960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1760105AbdKQUTl (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 17 Nov 2017 15:19:41 -0500
In-Reply-To: <20171117201601.24110-1-acme@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>

From: Arnaldo Carvalho de Melo <acme@redhat.com>

If all events have attr.exclude_kernel set, no need to look at
kptr_restrict.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/n/tip-yegpzg5bf2im69g0tfizqaqz@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-top.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 68320ac5e9b0..865191281591 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -735,14 +735,16 @@ static void perf_event__process_sample(struct perf_tool *tool,
 	if (!machine->kptr_restrict_warned &&
 	    symbol_conf.kptr_restrict &&
 	    al.cpumode == PERF_RECORD_MISC_KERNEL) {
-		ui__warning(
+		if (!perf_evlist__exclude_kernel(top->session->evlist)) {
+			ui__warning(
 "Kernel address maps (/proc/{kallsyms,modules}) are restricted.\n\n"
 "Check /proc/sys/kernel/kptr_restrict.\n\n"
 "Kernel%s samples will not be resolved.\n",
 			  al.map && !RB_EMPTY_ROOT(&al.map->dso->symbols[MAP__FUNCTION]) ?
 			  " modules" : "");
-		if (use_browser <= 0)
-			sleep(5);
+			if (use_browser <= 0)
+				sleep(5);
+		}
 		machine->kptr_restrict_warned = true;
 	}
 
-- 
2.13.6
