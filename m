From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 61/83] perf report: Ignore kptr_restrict when not sampling the kernel
Date: Fri, 17 Nov 2017 17:15:39 -0300
Message-ID: <20171117201601.24110-62-acme@kernel.org>
References: <20171117201601.24110-1-acme@kernel.org>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:58816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759926AbdKQUTe (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 17 Nov 2017 15:19:34 -0500
In-Reply-To: <20171117201601.24110-1-acme@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>

From: Arnaldo Carvalho de Melo <acme@redhat.com>

If none of the evsels has attr.exclude_kernel set to zero, no kernel
samples, so no point in warning the user about problems in processing
kernel samples, as there will be none.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/n/tip-7dn926v3at8txxkky92aesz2@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-report.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 1394cd8d96f7..af5dd038195e 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -441,6 +441,9 @@ static void report__warn_kptr_restrict(const struct report *rep)
 	struct map *kernel_map = machine__kernel_map(&rep->session->machines.host);
 	struct kmap *kernel_kmap = kernel_map ? map__kmap(kernel_map) : NULL;
 
+	if (perf_evlist__exclude_kernel(rep->session->evlist))
+		return;
+
 	if (kernel_map == NULL ||
 	    (kernel_map->dso->hit &&
 	     (kernel_kmap->ref_reloc_sym == NULL ||
-- 
2.13.6
