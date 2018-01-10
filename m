From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 02/27] perf test bpf: Use designated struct field initializers
Date: Wed, 10 Jan 2018 18:28:19 -0300
Message-ID: <20180110212844.12441-3-acme@kernel.org>
References: <20180110212844.12441-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180110212844.12441-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To follow standard practice in the kernel sources, documenting the
initialization better and helping quickly finding the value for some
field in a struct with many entries.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-syn3hz9hz7ukxlxbx5x6hv20@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/bpf.c | 59 +++++++++++++++++++++++---------------------------
 1 file changed, 27 insertions(+), 32 deletions(-)

diff --git a/tools/perf/tests/bpf.c b/tools/perf/tests/bpf.c
index 057c6b8fdb53..0512f1b5bfdb 100644
--- a/tools/perf/tests/bpf.c
+++ b/tools/perf/tests/bpf.c
@@ -63,46 +63,41 @@ static struct {
 	bool	pin;
 } bpf_testcase_table[] = {
 	{
-		LLVM_TESTCASE_BASE,
-		"Basic BPF filtering",
-		"[basic_bpf_test]",
-		"fix 'perf test LLVM' first",
-		"load bpf object failed",
-		&epoll_wait_loop,
-		(NR_ITERS + 1) / 2,
-		false,
+		.prog_id	  = LLVM_TESTCASE_BASE,
+		.desc		  = "Basic BPF filtering",
+		.name		  = "[basic_bpf_test]",
+		.msg_compile_fail = "fix 'perf test LLVM' first",
+		.msg_load_fail	  = "load bpf object failed",
+		.target_func	  = &epoll_wait_loop,
+		.expect_result	  = (NR_ITERS + 1) / 2,
 	},
 	{
-		LLVM_TESTCASE_BASE,
-		"BPF pinning",
-		"[bpf_pinning]",
-		"fix kbuild first",
-		"check your vmlinux setting?",
-		&epoll_wait_loop,
-		(NR_ITERS + 1) / 2,
-		true,
+		.prog_id	  = LLVM_TESTCASE_BASE,
+		.desc		  = "BPF pinning",
+		.name		  = "[bpf_pinning]",
+		.msg_compile_fail = "fix kbuild first",
+		.msg_load_fail	  = "check your vmlinux setting?",
+		.target_func	  = &epoll_wait_loop,
+		.expect_result	  = (NR_ITERS + 1) / 2,
+		.pin 		  = true,
 	},
 #ifdef HAVE_BPF_PROLOGUE
 	{
-		LLVM_TESTCASE_BPF_PROLOGUE,
-		"BPF prologue generation",
-		"[bpf_prologue_test]",
-		"fix kbuild first",
-		"check your vmlinux setting?",
-		&llseek_loop,
-		(NR_ITERS + 1) / 4,
-		false,
+		.prog_id	  = LLVM_TESTCASE_BPF_PROLOGUE,
+		.desc		  = "BPF prologue generation",
+		.name		  = "[bpf_prologue_test]",
+		.msg_compile_fail = "fix kbuild first",
+		.msg_load_fail	  = "check your vmlinux setting?",
+		.target_func	  = &llseek_loop,
+		.expect_result	  = (NR_ITERS + 1) / 4,
 	},
 #endif
 	{
-		LLVM_TESTCASE_BPF_RELOCATION,
-		"BPF relocation checker",
-		"[bpf_relocation_test]",
-		"fix 'perf test LLVM' first",
-		"libbpf error when dealing with relocation",
-		NULL,
-		0,
-		false,
+		.prog_id	  = LLVM_TESTCASE_BPF_RELOCATION,
+		.desc		  = "BPF relocation checker",
+		.name		  = "[bpf_relocation_test]",
+		.msg_compile_fail = "fix 'perf test LLVM' first",
+		.msg_load_fail	  = "libbpf error when dealing with relocation",
 	},
 };
 
-- 
2.14.3
