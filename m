From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 03/21] perf mmap: Recalculate size for overwrite mode
Date: Tue,  6 Feb 2018 13:53:32 -0300
Message-ID: <20180206165350.2570-4-acme@kernel.org>
References: <20180206165350.2570-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180206165350.2570-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Kan Liang <kan.liang@intel.com>, Andi Kleen <ak@linux.intel.com>, Jin Yao <yao.jin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Wang Nan <wangnan0@huawei.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Kan Liang <kan.liang@intel.com>

In perf_mmap__push(), the 'size' need to be recalculated, otherwise the
invalid data might be pushed to the record in overwrite mode.

The issue is introduced by commit 7fb4b407a124 ("perf mmap: Don't
discard prev in backward mode").

When the ring buffer is full in overwrite mode, backward_rb_find_range()
will be called to recalculate the 'start' and 'end'. The 'size' needs to
be recalculated accordingly.

Unconditionally recalculate the 'size', not just for full ring buffer in
overwrite mode. Because:

- There is no harmful to recalculate the 'size' for other cases.
- The code of calculating 'start' and 'end' will be factored out later.
  The new function does not need to return 'size'.

Signed-off-by: Kan Liang <kan.liang@intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Wang Nan <wangnan0@huawei.com>
Fixes: 7fb4b407a124 ("perf mmap: Don't discard prev in backward mode")
Link: http://lkml.kernel.org/r/1516310792-208685-3-git-send-email-kan.liang@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/mmap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index 05076e683938..97cf4fab564b 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -302,6 +302,8 @@ int perf_mmap__push(struct perf_mmap *md, bool overwrite,
 			return -1;
 	}
 
+	size = end - start;
+
 	if ((start & md->mask) + size != (end & md->mask)) {
 		buf = &data[start & md->mask];
 		size = md->mask + 1 - (start & md->mask);
-- 
2.14.3
