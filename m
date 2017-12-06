From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 27/36] perf evlist: Remove evlist->overwrite
Date: Wed,  6 Dec 2017 11:41:06 -0300
Message-ID: <20171206144115.15097-28-acme@kernel.org>
References: <20171206144115.15097-1-acme@kernel.org>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:58380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752872AbdLFOnS (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 6 Dec 2017 09:43:18 -0500
In-Reply-To: <20171206144115.15097-1-acme@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Wang Nan <wangnan0@huawei.com>, Jiri Olsa <jolsa@redhat.com>, Kan Liang <kan.liang@intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>

From: Wang Nan <wangnan0@huawei.com>

evlist->overwrite is set to false in all users. It can be removed.

Signed-off-by: Wang Nan <wangnan0@huawei.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Kan Liang <kan.liang@intel.com>
Link: http://lkml.kernel.org/r/20171203020044.81680-4-wangnan0@huawei.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-record.c | 2 +-
 tools/perf/util/evlist.c    | 5 ++---
 tools/perf/util/evlist.h    | 1 -
 3 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 08070f87d489..3bc6ceeae1f9 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -500,7 +500,7 @@ static int record__mmap_read_evlist(struct record *rec, struct perf_evlist *evli
 		struct auxtrace_mmap *mm = &maps[i].auxtrace_mmap;
 
 		if (maps[i].base) {
-			if (perf_mmap__push(&maps[i], evlist->overwrite, backward, rec, record__pushfn) != 0) {
+			if (perf_mmap__push(&maps[i], false, backward, rec, record__pushfn) != 0) {
 				rc = -1;
 				goto out;
 			}
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 93272d932407..a59134fb141f 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -711,7 +711,7 @@ union perf_event *perf_evlist__mmap_read_forward(struct perf_evlist *evlist, int
 	 * No need for read-write ring buffer: kernel stop outputting when
 	 * it hit md->prev (perf_mmap__consume()).
 	 */
-	return perf_mmap__read_forward(md, evlist->overwrite);
+	return perf_mmap__read_forward(md, false);
 }
 
 union perf_event *perf_evlist__mmap_read_backward(struct perf_evlist *evlist, int idx)
@@ -738,7 +738,7 @@ void perf_evlist__mmap_read_catchup(struct perf_evlist *evlist, int idx)
 
 void perf_evlist__mmap_consume(struct perf_evlist *evlist, int idx)
 {
-	perf_mmap__consume(&evlist->mmap[idx], evlist->overwrite);
+	perf_mmap__consume(&evlist->mmap[idx], false);
 }
 
 static void perf_evlist__munmap_nofree(struct perf_evlist *evlist)
@@ -1070,7 +1070,6 @@ int perf_evlist__mmap_ex(struct perf_evlist *evlist, unsigned int pages,
 	if (evlist->pollfd.entries == NULL && perf_evlist__alloc_pollfd(evlist) < 0)
 		return -ENOMEM;
 
-	evlist->overwrite = false;
 	evlist->mmap_len = perf_evlist__mmap_size(pages);
 	pr_debug("mmap size %zuB\n", evlist->mmap_len);
 	mp.mask = evlist->mmap_len - page_size - 1;
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 424a3d6015af..eec33770b8e6 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -31,7 +31,6 @@ struct perf_evlist {
 	int		 nr_entries;
 	int		 nr_groups;
 	int		 nr_mmaps;
-	bool		 overwrite;
 	bool		 enabled;
 	bool		 has_user_cpus;
 	size_t		 mmap_len;
-- 
2.13.6
