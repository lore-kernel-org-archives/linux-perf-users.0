From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 34/52] perf machine: Use machine__find_kernel_function() instead of open coded version
Date: Wed,  2 May 2018 12:19:24 -0300
Message-ID: <20180502151942.20542-35-acme@kernel.org>
References: <20180502151942.20542-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180502151942.20542-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

We have that equivalent, shorter helper, use it.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-1hcgu3k7vxdy4vknqf3kbtzt@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/machine.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 10364e829aba..a00e82b83e0a 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2367,7 +2367,7 @@ char *machine__resolve_kernel_addr(void *vmachine, unsigned long long *addrp, ch
 {
 	struct machine *machine = vmachine;
 	struct map *map;
-	struct symbol *sym = map_groups__find_symbol(&machine->kmaps, MAP__FUNCTION, *addrp, &map);
+	struct symbol *sym = machine__find_kernel_function(machine, *addrp, &map);
 
 	if (sym == NULL)
 		return NULL;
-- 
2.14.3
