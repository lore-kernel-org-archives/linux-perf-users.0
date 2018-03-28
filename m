From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 2/8] perf mmap: Fix accessing unmapped mmap in perf_mmap__read_done()
Date: Wed, 28 Mar 2018 15:49:13 -0300
Message-ID: <20180328184919.32287-3-acme@kernel.org>
References: <20180328184919.32287-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180328184919.32287-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

There is a segmentation fault when running 'perf trace'. For example:

  [root@jouet e]# perf trace -e *chdir -o /tmp/bla perf report --ignore-vmlinux -i ../perf.data

The perf_mmap__consume() could unmap the mmap. It needs to check the
refcnt in perf_mmap__read_done().

Reported-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Fixes: ee023de05f35 ("perf mmap: Introduce perf_mmap__read_done()")
Link: http://lkml.kernel.org/r/1522071729-16776-1-git-send-email-kan.liang@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/mmap.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index 38ca3ffb9d61..f6cfc52ff1fe 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -317,5 +317,11 @@ int perf_mmap__push(struct perf_mmap *md, void *to,
  */
 void perf_mmap__read_done(struct perf_mmap *map)
 {
+	/*
+	 * Check if event was unmapped due to a POLLHUP/POLLERR.
+	 */
+	if (!refcount_read(&map->refcnt))
+		return;
+
 	map->prev = perf_mmap__read_head(map);
 }
-- 
2.14.3
