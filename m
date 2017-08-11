From: Wang Nan <wangnan0@huawei.com>
Subject: [PATCH] perf test llvm: Fix f_mode endianness problem
Date: Fri, 11 Aug 2017 05:44:46 +0000 (UTC)
Message-ID: <20170812134901.30237-1-wangnan0__11794.7936327711$1502430286$gmane$org@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Date: Sat, 12 Aug 2017 13:49:01 +0000
Sender: linux-kernel-owner@vger.kernel.org
To: acme@kernel.org, tmricht@linux.vnet.ibm.com
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, Wang Nan <wangnan0@huawei.com>, Alexei Starovoitov <alexei.starovoitov@gmail.com>, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, Li Zefan <lizefan@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

Perf BPF prologue generator unconditionally fetches 8 bytes for function
parameters. On big endian machine, a casting is resquired if the parameter
is not u64.

Signed-off-by: Wang Nan <wangnan0@huawei.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Thomas Richter <tmricht@linux.vnet.ibm.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Cc: Li Zefan <lizefan@huawei.com>
---
 tools/perf/tests/bpf-script-test-prologue.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/bpf-script-test-prologue.c b/tools/perf/tests/bpf-script-test-prologue.c
index b4ebc75..43f1e16 100644
--- a/tools/perf/tests/bpf-script-test-prologue.c
+++ b/tools/perf/tests/bpf-script-test-prologue.c
@@ -26,9 +26,11 @@ static void (*bpf_trace_printk)(const char *fmt, int fmt_size, ...) =
 	(void *) 6;
 
 SEC("func=null_lseek file->f_mode offset orig")
-int bpf_func__null_lseek(void *ctx, int err, unsigned long f_mode,
+int bpf_func__null_lseek(void *ctx, int err, unsigned long _f_mode,
 			 unsigned long offset, unsigned long orig)
 {
+	fmode_t f_mode = (fmode_t)_f_mode;
+
 	if (err)
 		return 0;
 	if (f_mode & FMODE_WRITE)
-- 
2.10.1
