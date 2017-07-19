From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 63/86] perf report: Enable finding kernel inline functions
Date: Wed, 19 Jul 2017 11:29:27 -0300
Message-ID: <20170719142950.3747-64-acme@kernel.org>
References: <20170719142950.3747-1-acme@kernel.org>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:51636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932219AbdGSOf5 (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 19 Jul 2017 10:35:57 -0400
In-Reply-To: <20170719142950.3747-1-acme@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jin Yao <yao.jin@linux.intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@intel.com>, Milian Wolff <milian.wolff@kdab.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>

From: Jin Yao <yao.jin@linux.intel.com>

Currently perf supports a mode to query inline stack. It works well for
finding user space inline functions but it doesn't work for kernel ones,
due to some unnecessary check.

This patch removes these unnecessary checks. Now kernel inline functions
can be reported.

For example:

  perf report --inline -g func --stdio

  |--46.19%--do_huge_pmd_anonymous_page
  |          do_huge_pmd_anonymous_page (inline)
  |          __do_huge_pmd_anonymous_page (inline)
  |          __SetPageUptodate (inline)
  |          __set_bit (inline)

  The result is compared with the output of addr2line. They match.

Signed-off-by: Yao Jin <yao.jin@linux.intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@intel.com>
Cc: Milian Wolff <milian.wolff@kdab.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1500409892-15904-1-git-send-email-yao.jin@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/hists.c | 3 ---
 tools/perf/ui/stdio/hist.c     | 3 ---
 2 files changed, 6 deletions(-)

diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index 69f4570bd4f9..f4bc2462bc2c 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -166,9 +166,6 @@ static struct inline_node *inline_node__create(struct map *map, u64 ip)
 	if (dso == NULL)
 		return NULL;
 
-	if (dso->kernel != DSO_TYPE_USER)
-		return NULL;
-
 	node = dso__parse_addr_inlines(dso,
 				       map__rip_2objdump(map, ip));
 
diff --git a/tools/perf/ui/stdio/hist.c b/tools/perf/ui/stdio/hist.c
index 42e432bd2eb4..2df8eb1ed3c0 100644
--- a/tools/perf/ui/stdio/hist.c
+++ b/tools/perf/ui/stdio/hist.c
@@ -35,9 +35,6 @@ static size_t inline__fprintf(struct map *map, u64 ip, int left_margin,
 	if (dso == NULL)
 		return 0;
 
-	if (dso->kernel != DSO_TYPE_USER)
-		return 0;
-
 	node = dso__parse_addr_inlines(dso,
 				       map__rip_2objdump(map, ip));
 	if (node == NULL)
-- 
2.9.4
