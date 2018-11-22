From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 05/28] perf bpf: Add simple pid_filter class accessible to BPF proggies
Date: Thu, 22 Nov 2018 00:35:48 -0300
Message-ID: <20181122033611.15890-6-acme@kernel.org>
References: <20181122033611.15890-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181122033611.15890-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Will be used in the augmented_raw_syscalls.c to implement 'perf trace
--filter-pids'.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-9sybmz4vchlbpqwx2am13h9e@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/include/bpf/pid_filter.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 tools/perf/include/bpf/pid_filter.h

diff --git a/tools/perf/include/bpf/pid_filter.h b/tools/perf/include/bpf/pid_filter.h
new file mode 100644
index 000000000000..6e61c4bdf548
--- /dev/null
+++ b/tools/perf/include/bpf/pid_filter.h
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: LGPL-2.1
+
+#ifndef _PERF_BPF_PID_FILTER_
+#define _PERF_BPF_PID_FILTER_
+
+#include <bpf.h>
+
+#define pid_filter(name) pid_map(name, bool)
+
+static int pid_filter__add(struct bpf_map *pids, pid_t pid)
+{
+	bool value = true;
+	return bpf_map_update_elem(pids, &pid, &value, BPF_NOEXIST);
+}
+
+static bool pid_filter__has(struct bpf_map *pids, pid_t pid)
+{
+	return bpf_map_lookup_elem(pids, &pid) != NULL;
+}
+
+#endif // _PERF_BPF_PID_FILTER_
-- 
2.14.5
