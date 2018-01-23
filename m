From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 05/43] perf bpf: Don't warn about unavailability of builtin clang, just fallback
Date: Tue, 23 Jan 2018 10:12:13 -0300
Message-ID: <20180123131251.28197-6-acme@kernel.org>
References: <20180123131251.28197-1-acme@kernel.org>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:46646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751933AbeAWNNN (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 23 Jan 2018 08:13:13 -0500
In-Reply-To: <20180123131251.28197-1-acme@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>

From: Arnaldo Carvalho de Melo <acme@redhat.com>

When clang is not linked with 'perf' we should just add a debug message
about that before doing the fallback to calling the external compiler.

I.e. just the "-95" warning below gets turned into a debug message:

  # cat sys_enter_open.c
  #include "bpf.h"

  SEC("syscalls:sys_enter_open")
  int func(void *ctx)
  {
	struct {
		char *ptr;
		char path[256];
	} filename = {
		.ptr = *((char **)(ctx + 16)),
	};
	int len = bpf_probe_read_str(filename.path, sizeof(filename.path), filename.ptr);
	if (len > 0) {
		if (len == 1)
			perf_event_output(ctx, &__bpf_stdout__, BPF_F_CURRENT_CPU, &filename, len + sizeof(filename.ptr));
		else if (len < 256)
			perf_event_output(ctx, &__bpf_stdout__, BPF_F_CURRENT_CPU, &filename, len + sizeof(filename.ptr));
        }
	return 0;
  }
  # trace -e open,sys_enter_open.c
  bpf: builtin compilation failed: -95, try external compiler
     0.000 (         ): __bpf_stdout__:@......./proc/self/task/11160/comm..)
     0.014 ( 0.116 ms): qemu-system-x8/6721 open(filename: /proc/self/task/11160/comm, flags: RDWR) = 91
  2335.411 (         ): __bpf_stdout__:FB..~.../etc/resolv.conf....)
  2335.421 ( 0.030 ms): chronyd/883 open(filename: /etc/resolv.conf, flags: CLOEXEC) = 5
^C#

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-z5aak9oay448ffj37giz94yr@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/bpf-loader.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/bpf-loader.c b/tools/perf/util/bpf-loader.c
index 72c107fcbc5a..ab2598af91eb 100644
--- a/tools/perf/util/bpf-loader.c
+++ b/tools/perf/util/bpf-loader.c
@@ -94,7 +94,7 @@ struct bpf_object *bpf__prepare_load(const char *filename, bool source)
 		err = perf_clang__compile_bpf(filename, &obj_buf, &obj_buf_sz);
 		perf_clang__cleanup();
 		if (err) {
-			pr_warning("bpf: builtin compilation failed: %d, try external compiler\n", err);
+			pr_debug("bpf: builtin compilation failed: %d, try external compiler\n", err);
 			err = llvm__compile_bpf(filename, &obj_buf, &obj_buf_sz);
 			if (err)
 				return ERR_PTR(-BPF_LOADER_ERRNO__COMPILE);
-- 
2.14.3
