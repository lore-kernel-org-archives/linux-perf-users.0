From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 03/27] perf test bpf: Hook on epoll_pwait()
Date: Wed, 10 Jan 2018 18:28:20 -0300
Message-ID: <20180110212844.12441-4-acme@kernel.org>
References: <20180110212844.12441-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180110212844.12441-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

The 'perf test bpf' was hooking a eBPF program on the SyS_epoll_wait()
kernel function, that was what the epoll_wait() glibc function ended up
calling, but since at least glibc 2.26, the one that comes with, for
instance, Fedora 27, glibc ends up calling SyS_epoll_pwait() when
epoll_wait() is used, causing this 'perf test' entry to fail.

So switch to using epoll_pwait() and hook the eBPF program to the
SyS_epoll_pwait() kernel function to make it work on a wider range of
glibc and kernel versions.

Tested-by: Wang Nan <wangnan0@huawei.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-zynvquy63er8s5mrgsz65pto@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/bpf-script-example.c | 4 ++--
 tools/perf/tests/bpf.c                | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/perf/tests/bpf-script-example.c b/tools/perf/tests/bpf-script-example.c
index 268e5f8e4aa2..e4123c1b0e88 100644
--- a/tools/perf/tests/bpf-script-example.c
+++ b/tools/perf/tests/bpf-script-example.c
@@ -31,8 +31,8 @@ struct bpf_map_def SEC("maps") flip_table = {
 	.max_entries = 1,
 };
 
-SEC("func=SyS_epoll_wait")
-int bpf_func__SyS_epoll_wait(void *ctx)
+SEC("func=SyS_epoll_pwait")
+int bpf_func__SyS_epoll_pwait(void *ctx)
 {
 	int ind =0;
 	int *flag = bpf_map_lookup_elem(&flip_table, &ind);
diff --git a/tools/perf/tests/bpf.c b/tools/perf/tests/bpf.c
index 0512f1b5bfdb..8e709c9d512c 100644
--- a/tools/perf/tests/bpf.c
+++ b/tools/perf/tests/bpf.c
@@ -19,13 +19,13 @@
 
 #ifdef HAVE_LIBBPF_SUPPORT
 
-static int epoll_wait_loop(void)
+static int epoll_pwait_loop(void)
 {
 	int i;
 
 	/* Should fail NR_ITERS times */
 	for (i = 0; i < NR_ITERS; i++)
-		epoll_wait(-(i + 1), NULL, 0, 0);
+		epoll_pwait(-(i + 1), NULL, 0, 0, NULL);
 	return 0;
 }
 
@@ -68,7 +68,7 @@ static struct {
 		.name		  = "[basic_bpf_test]",
 		.msg_compile_fail = "fix 'perf test LLVM' first",
 		.msg_load_fail	  = "load bpf object failed",
-		.target_func	  = &epoll_wait_loop,
+		.target_func	  = &epoll_pwait_loop,
 		.expect_result	  = (NR_ITERS + 1) / 2,
 	},
 	{
@@ -77,7 +77,7 @@ static struct {
 		.name		  = "[bpf_pinning]",
 		.msg_compile_fail = "fix kbuild first",
 		.msg_load_fail	  = "check your vmlinux setting?",
-		.target_func	  = &epoll_wait_loop,
+		.target_func	  = &epoll_pwait_loop,
 		.expect_result	  = (NR_ITERS + 1) / 2,
 		.pin 		  = true,
 	},
-- 
2.14.3
