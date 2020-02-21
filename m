From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 1/8] perf bpf: Remove bpf/ subdir from bpf.h headers used to build bpf events
Date: Thu, 20 Feb 2020 22:53:03 -0300
Message-ID: <20200221015310.16914-2-acme@kernel.org>
References: <20200221015310.16914-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200221015310.16914-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

The bpf.h file needed gets installed in /usr/lib/include/perf/bpf/bpf.h,
and /usr/lib/include/perf/ is added to the include path passed to clang
to build the eBPF bytecode, so just remove "bpf/", its directly in the
path passed already. This was working by accident, fix it.

I.e. now this is back working:

  # cat /home/acme/git/perf/tools/perf/examples/bpf/hello.c
  #include <stdio.h>

  int syscall_enter(openat)(void *args)
  {
  	puts("Hello, world\n");
  	return 0;
  }

  license(GPL);
  # perf trace -e /home/acme/git/perf/tools/perf/examples/bpf/hello.c
       0.000 pickup/21493 __bpf_stdout__(Hello, world)
      56.462 sh/13539 __bpf_stdout__(Hello, world)
      56.536 sh/13539 __bpf_stdout__(Hello, world)
      56.673 sh/13539 __bpf_stdout__(Hello, world)
      56.781 sh/13539 __bpf_stdout__(Hello, world)
      56.707 perf/13182 __bpf_stdout__(Hello, world)
      56.849 perf/13182 __bpf_stdout__(Hello, world)
  ^C
  #

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-d9myswhgo8gfi3vmehdqpxa7@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/include/bpf/pid_filter.h | 2 +-
 tools/perf/include/bpf/stdio.h      | 2 +-
 tools/perf/include/bpf/unistd.h     | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/include/bpf/pid_filter.h b/tools/perf/include/bpf/pid_filter.h
index 607189a315b2..6e61c4bdf548 100644
--- a/tools/perf/include/bpf/pid_filter.h
+++ b/tools/perf/include/bpf/pid_filter.h
@@ -3,7 +3,7 @@
 #ifndef _PERF_BPF_PID_FILTER_
 #define _PERF_BPF_PID_FILTER_
 
-#include <bpf/bpf.h>
+#include <bpf.h>
 
 #define pid_filter(name) pid_map(name, bool)
 
diff --git a/tools/perf/include/bpf/stdio.h b/tools/perf/include/bpf/stdio.h
index 7ca6fa5463ee..316af5b2ff35 100644
--- a/tools/perf/include/bpf/stdio.h
+++ b/tools/perf/include/bpf/stdio.h
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 
-#include <bpf/bpf.h>
+#include <bpf.h>
 
 struct bpf_map SEC("maps") __bpf_stdout__ = {
        .type = BPF_MAP_TYPE_PERF_EVENT_ARRAY,
diff --git a/tools/perf/include/bpf/unistd.h b/tools/perf/include/bpf/unistd.h
index d1a35b6c649d..ca7877f9a976 100644
--- a/tools/perf/include/bpf/unistd.h
+++ b/tools/perf/include/bpf/unistd.h
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: LGPL-2.1
 
-#include <bpf/bpf.h>
+#include <bpf.h>
 
 static int (*bpf_get_current_pid_tgid)(void) = (void *)BPF_FUNC_get_current_pid_tgid;
 
-- 
2.21.1
