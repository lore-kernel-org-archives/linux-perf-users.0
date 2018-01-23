From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 42/43] perf evlist: Remove fcntl.h from evlist.h
Date: Tue, 23 Jan 2018 10:12:50 -0300
Message-ID: <20180123131251.28197-43-acme@kernel.org>
References: <20180123131251.28197-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180123131251.28197-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Not needed there, fixup the places where it is needed and was getting
only by luck via evlist.h.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-yxjpetn64z8vjuguu84gr6x6@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-kvm.c                    | 3 +++
 tools/perf/builtin-script.c                 | 1 +
 tools/perf/builtin-trace.c                  | 1 +
 tools/perf/tests/bpf.c                      | 1 +
 tools/perf/tests/openat-syscall-tp-fields.c | 3 +++
 tools/perf/util/cgroup.c                    | 3 +++
 tools/perf/util/evlist.c                    | 1 +
 tools/perf/util/evlist.h                    | 1 -
 tools/perf/util/parse-events.c              | 3 +++
 9 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index 98853162eae9..55d919dc5bc6 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -26,6 +26,9 @@
 #include <sys/timerfd.h>
 #endif
 #include <sys/time.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
 
 #include <linux/kernel.h>
 #include <linux/time64.h>
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 3499d68e1d70..ab19a6ee4093 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -42,6 +42,7 @@
 #include <sys/param.h>
 #include <sys/types.h>
 #include <sys/stat.h>
+#include <fcntl.h>
 #include <unistd.h>
 
 #include "sane_ctype.h"
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 46d3ff09440c..868306ccd8b8 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -56,6 +56,7 @@
 #include <linux/random.h>
 #include <linux/stringify.h>
 #include <linux/time64.h>
+#include <fcntl.h>
 
 #include "sane_ctype.h"
 
diff --git a/tools/perf/tests/bpf.c b/tools/perf/tests/bpf.c
index 8e709c9d512c..e8399beca62b 100644
--- a/tools/perf/tests/bpf.c
+++ b/tools/perf/tests/bpf.c
@@ -3,6 +3,7 @@
 #include <sys/epoll.h>
 #include <sys/types.h>
 #include <sys/stat.h>
+#include <fcntl.h>
 #include <util/util.h>
 #include <util/bpf-loader.h>
 #include <util/evlist.h>
diff --git a/tools/perf/tests/openat-syscall-tp-fields.c b/tools/perf/tests/openat-syscall-tp-fields.c
index 97c9407d02a0..43519267b93b 100644
--- a/tools/perf/tests/openat-syscall-tp-fields.c
+++ b/tools/perf/tests/openat-syscall-tp-fields.c
@@ -1,5 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/err.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
 #include "perf.h"
 #include "evlist.h"
 #include "evsel.h"
diff --git a/tools/perf/util/cgroup.c b/tools/perf/util/cgroup.c
index d9ffc1e6eb39..984f69144f87 100644
--- a/tools/perf/util/cgroup.c
+++ b/tools/perf/util/cgroup.c
@@ -6,6 +6,9 @@
 #include "cgroup.h"
 #include "evlist.h"
 #include <linux/stringify.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
 
 int nr_cgroups;
 
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 120efd85f2c8..ac35cd214feb 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -25,6 +25,7 @@
 #include "parse-events.h"
 #include <subcmd/parse-options.h>
 
+#include <fcntl.h>
 #include <sys/ioctl.h>
 #include <sys/mman.h>
 
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index e7fbca69cbac..75f8e0ad5d76 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -7,7 +7,6 @@
 #include <linux/refcount.h>
 #include <linux/list.h>
 #include <api/fd/array.h>
-#include <fcntl.h>
 #include <stdio.h>
 #include "../perf.h"
 #include "event.h"
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 170316795a18..34589c427e52 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -4,6 +4,9 @@
 #include <dirent.h>
 #include <errno.h>
 #include <sys/ioctl.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
 #include <sys/param.h>
 #include "term.h"
 #include "../perf.h"
-- 
2.14.3
