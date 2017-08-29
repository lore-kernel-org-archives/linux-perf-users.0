From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 17/18] perf probe: Fix kprobe blacklist checking condition
Date: Tue, 29 Aug 2017 16:42:53 -0300
Message-ID: <20170829194254.1338-18-acme@kernel.org>
References: <20170829194254.1338-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170829194254.1338-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Li Bin <huawei.libin@huawei.com>, Masami Hiramatsu <mhiramat@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Wang Nan <wangnan0@huawei.com>, zhangmengting@huawei.com, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Li Bin <huawei.libin@huawei.com>

The commit 9aaf5a5f479b ("perf probe: Check kprobes blacklist when
adding new events"), 'perf probe' supports checking the blacklist of the
fuctions which can not be probed.  But the checking condition is wrong,
that the end_addr of the symbol which is the start_addr of the next
symbol can't be included.

Committer notes:

IOW make it match its kernel counterpart in kernel/kprobes.c:

  bool within_kprobe_blacklist(unsigned long addr)

Each entry have as its end address not its end address, but the first
address _outside_ that symbol, which for related functions, is the first
address of the next symbol, like these from kernel/trace/trace_probe.c:

0xffffffffbd198df0-0xffffffffbd198e40	print_type_u8
0xffffffffbd198e40-0xffffffffbd198e90	print_type_u16
0xffffffffbd198e90-0xffffffffbd198ee0	print_type_u32
0xffffffffbd198ee0-0xffffffffbd198f30	print_type_u64
0xffffffffbd198f30-0xffffffffbd198f80	print_type_s8
0xffffffffbd198f80-0xffffffffbd198fd0	print_type_s16
0xffffffffbd198fd0-0xffffffffbd199020	print_type_s32
0xffffffffbd199020-0xffffffffbd199070	print_type_s64
0xffffffffbd199070-0xffffffffbd1990c0	print_type_x8
0xffffffffbd1990c0-0xffffffffbd199110	print_type_x16
0xffffffffbd199110-0xffffffffbd199160	print_type_x32
0xffffffffbd199160-0xffffffffbd1991b0	print_type_x64

But not always:

0xffffffffbd1997b0-0xffffffffbd1997c0	fetch_kernel_stack_address (kernel/trace/trace_probe.c)
0xffffffffbd1c57f0-0xffffffffbd1c58b0	__context_tracking_enter   (kernel/context_tracking.c)

Signed-off-by: Li Bin <huawei.libin@huawei.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Wang Nan <wangnan0@huawei.com>
Cc: zhangmengting@huawei.com
Fixes: 9aaf5a5f479b ("perf probe: Check kprobes blacklist when adding new events")
Link: http://lkml.kernel.org/r/1504011443-7269-1-git-send-email-huawei.libin@huawei.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/probe-event.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index d7cd1142f4c6..b7aaf9b2294d 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -2395,7 +2395,7 @@ kprobe_blacklist__find_by_address(struct list_head *blacklist,
 	struct kprobe_blacklist_node *node;
 
 	list_for_each_entry(node, blacklist, list) {
-		if (node->start <= address && address <= node->end)
+		if (node->start <= address && address < node->end)
 			return node;
 	}
 
-- 
2.13.5
