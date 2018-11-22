From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 01/28] perf bpf: Add unistd.h to the headers accessible to bpf proggies
Date: Thu, 22 Nov 2018 00:35:44 -0300
Message-ID: <20181122033611.15890-2-acme@kernel.org>
References: <20181122033611.15890-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181122033611.15890-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Start with a getpid() function wrapping BPF_FUNC_get_current_pid_tgid,
idea is to mimic the system headers.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-zo8hv22onidep7tm785dzxfk@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/include/bpf/unistd.h | 10 ++++++++++
 1 file changed, 10 insertions(+)
 create mode 100644 tools/perf/include/bpf/unistd.h

diff --git a/tools/perf/include/bpf/unistd.h b/tools/perf/include/bpf/unistd.h
new file mode 100644
index 000000000000..ca7877f9a976
--- /dev/null
+++ b/tools/perf/include/bpf/unistd.h
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: LGPL-2.1
+
+#include <bpf.h>
+
+static int (*bpf_get_current_pid_tgid)(void) = (void *)BPF_FUNC_get_current_pid_tgid;
+
+static pid_t getpid(void)
+{
+	return bpf_get_current_pid_tgid();
+}
-- 
2.14.5
