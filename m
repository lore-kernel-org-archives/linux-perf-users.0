From: Wang Nan <wangnan0@huawei.com>
Subject: [PATCH] perf test llvm: Fix f_mode endianness problem
Date: Fri, 11 Aug 2017 05:44:44 +0000 (UTC)
Message-ID: <20170812134901.30237-1-wangnan0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from szxga04-in.huawei.com ([45.249.212.190]:3508 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752208AbdHKFon (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 11 Aug 2017 01:44:43 -0400
Date: Sat, 12 Aug 2017 13:49:01 +0000
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: acme@kernel.org, tmricht@linux.vnet.ibm.com
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, Wang Nan <wangnan0@huawei.com>, Alexei Starovoitov <alexei.starovoitov@gmail.com>, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, Li Zefan <lizefan@huawei.com>

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
