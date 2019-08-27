From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 10/33] perf augmented_raw_syscalls: Postpone tmp map lookup to after pid_filter
Date: Mon, 26 Aug 2019 22:36:11 -0300
Message-ID: <20190827013634.3173-11-acme@kernel.org>
References: <20190827013634.3173-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190827013634.3173-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

No sense in doing that lookup before figuring out if it will be used,
i.e. if the pid is being filtered that tmp space lookup will be useless.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-o74yggieorucfg4j74tb6rta@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/examples/bpf/augmented_raw_syscalls.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/examples/bpf/augmented_raw_syscalls.c b/tools/perf/examples/bpf/augmented_raw_syscalls.c
index b85b177c6726..0a8d217d65c7 100644
--- a/tools/perf/examples/bpf/augmented_raw_syscalls.c
+++ b/tools/perf/examples/bpf/augmented_raw_syscalls.c
@@ -250,13 +250,13 @@ int sys_enter(struct syscall_enter_args *args)
 	struct syscall *syscall;
 	int key = 0;
 
+	if (pid_filter__has(&pids_filtered, getpid()))
+		return 0;
+
         augmented_args = bpf_map_lookup_elem(&augmented_args_tmp, &key);
         if (augmented_args == NULL)
                 return 1;
 
-	if (pid_filter__has(&pids_filtered, getpid()))
-		return 0;
-
 	probe_read(&augmented_args->args, sizeof(augmented_args->args), args);
 
 	/*
-- 
2.21.0
