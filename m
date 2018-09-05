From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 22/77] perf augmented_syscalls: Update the header comments
Date: Wed,  5 Sep 2018 19:03:45 -0300
Message-ID: <20180905220440.20256-23-acme@kernel.org>
References: <20180905220440.20256-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180905220440.20256-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Reflecting the fact that it now augments more than syscalls:sys_enter_SYSCALL
tracepoints that have filename strings as args. Also mention how the
extra data is handled by the by now modified 'perf trace' beautifiers,
that will use special "augmented" beautifiers when extra data is found
after the expected syscall enter/exit tracepoints.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-ybskanehmdilj5fs7080nz1g@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/examples/bpf/augmented_syscalls.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/tools/perf/examples/bpf/augmented_syscalls.c b/tools/perf/examples/bpf/augmented_syscalls.c
index be06d2c9e8c9..bfa28eaf27b3 100644
--- a/tools/perf/examples/bpf/augmented_syscalls.c
+++ b/tools/perf/examples/bpf/augmented_syscalls.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Augment the openat syscall with the contents of the filename pointer argument.
+ * Augment syscalls with the contents of the pointer arguments.
  *
  * Test it with:
  *
@@ -10,12 +10,10 @@
  * the last one should be the one for '/etc/passwd'.
  *
  * This matches what is marshalled into the raw_syscall:sys_enter payload
- * expected by the 'perf trace' beautifiers, and can be used by them unmodified,
- * which will be done as that feature is implemented in the next csets, for now
- * it will appear in a dump done by the default tracepoint handler in 'perf trace',
- * that uses bpf_output__fprintf() to just dump those contents, as done with
- * the bpf-output event associated with the __bpf_output__ map declared in
- * tools/perf/include/bpf/stdio.h.
+ * expected by the 'perf trace' beautifiers, and can be used by them, that will
+ * check if perf_sample->raw_data is more than what is expected for each
+ * syscalls:sys_{enter,exit}_SYSCALL tracepoint, uing the extra data as the
+ * contents of pointer arguments.
  */
 
 #include <stdio.h>
-- 
2.14.4
