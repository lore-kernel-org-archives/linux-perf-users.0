From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 13/15] perf: Fix documentation for sysctls perf_event_paranoid and perf_event_mlock_kb
Date: Wed, 23 Aug 2017 16:36:12 -0300
Message-ID: <20170823193614.20394-14-acme@kernel.org>
References: <20170823193614.20394-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170823193614.20394-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Konstantin Khlebnikov <khlebnikov@yandex-team.ru>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>

Fix misprint CAP_IOC_LOCK -> CAP_IPC_LOCK. This capability have nothing
to do with raw tracepoints. This part is about bypassing mlock limits.

Sysctl kernel.perf_event_paranoid = -1 allows raw and ftrace function
tracepoints without CAP_SYS_ADMIN.

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/150322916080.129746.11285255474738558340.stgit@buzz
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 Documentation/sysctl/kernel.txt | 13 ++++++++++++-
 tools/perf/util/evsel.c         |  4 +++-
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/Documentation/sysctl/kernel.txt b/Documentation/sysctl/kernel.txt
index bac23c198360..ce61d1fe08ca 100644
--- a/Documentation/sysctl/kernel.txt
+++ b/Documentation/sysctl/kernel.txt
@@ -61,6 +61,7 @@ show up in /proc/sys/kernel:
 - perf_cpu_time_max_percent
 - perf_event_paranoid
 - perf_event_max_stack
+- perf_event_mlock_kb
 - perf_event_max_contexts_per_stack
 - pid_max
 - powersave-nap               [ PPC only ]
@@ -654,7 +655,9 @@ Controls use of the performance events system by unprivileged
 users (without CAP_SYS_ADMIN).  The default value is 2.
 
  -1: Allow use of (almost) all events by all users
->=0: Disallow raw tracepoint access by users without CAP_IOC_LOCK
+     Ignore mlock limit after perf_event_mlock_kb without CAP_IPC_LOCK
+>=0: Disallow ftrace function tracepoint by users without CAP_SYS_ADMIN
+     Disallow raw tracepoint access by users without CAP_SYS_ADMIN
 >=1: Disallow CPU event access by users without CAP_SYS_ADMIN
 >=2: Disallow kernel profiling by users without CAP_SYS_ADMIN
 
@@ -673,6 +676,14 @@ The default value is 127.
 
 ==============================================================
 
+perf_event_mlock_kb:
+
+Control size of per-cpu ring buffer not counted agains mlock limit.
+
+The default value is 512 + 1 page
+
+==============================================================
+
 perf_event_max_contexts_per_stack:
 
 Controls maximum number of stack frame context entries for
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 5dfb8bc4db89..a5888c704e01 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2674,7 +2674,9 @@ int perf_evsel__open_strerror(struct perf_evsel *evsel, struct target *target,
 		 "unprivileged users (without CAP_SYS_ADMIN).\n\n"
 		 "The current value is %d:\n\n"
 		 "  -1: Allow use of (almost) all events by all users\n"
-		 ">= 0: Disallow raw tracepoint access by users without CAP_IOC_LOCK\n"
+		 "      Ignore mlock limit after perf_event_mlock_kb without CAP_IPC_LOCK\n"
+		 ">= 0: Disallow ftrace function tracepoint by users without CAP_SYS_ADMIN\n"
+		 "      Disallow raw tracepoint access by users without CAP_SYS_ADMIN\n"
 		 ">= 1: Disallow CPU event access by users without CAP_SYS_ADMIN\n"
 		 ">= 2: Disallow kernel profiling by users without CAP_SYS_ADMIN\n\n"
 		 "To make this setting permanent, edit /etc/sysctl.conf too, e.g.:\n\n"
-- 
2.13.5
