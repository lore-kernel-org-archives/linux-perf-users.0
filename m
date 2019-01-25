From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 27/29] perf trace: Fixup etcsnoop example
Date: Sat, 26 Jan 2019 00:18:41 +0100
Message-ID: <20190125231843.2895-28-acme@kernel.org>
References: <20190125231843.2895-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190125231843.2895-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>, =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= <lclaudio@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Where we don't have "raw_syscalls:sys_enter", so we need to look for a
"*syscalls:sys_enter*" to initialize the offsets for the
__augmented_syscalls__ evsel, which is the case with etcsnoop, that was
segfaulting, fixed:

  # trace -e /home/acme/git/perf/tools/perf/examples/bpf/etcsnoop.c
     0.000 (         ): gnome-shell/2105 openat(dfd: CWD, filename: "/etc/localtime")                       ...
   631.834 (         ): cat/6521 openat(dfd: CWD, filename: "/etc/ld.so.cache", flags: RDONLY|CLOEXEC) ...
   632.637 (         ): bash/6521 openat(dfd: CWD, filename: "/etc/passwd")                          ...
  ^C#

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Fixes: b9b6a2ea2baf ("perf trace: Do not hardcode the size of the tracepoint common_ fields")
Link: https://lkml.kernel.org/n/tip-0tjwcit8qitsmh4nyvf2b0jo@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index ed4583128b9c..1447993e1ee3 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -3854,7 +3854,8 @@ int cmd_trace(int argc, const char **argv)
 				goto init_augmented_syscall_tp;
 			}
 
-			if (strcmp(perf_evsel__name(evsel), "raw_syscalls:sys_enter") == 0) {
+			if (trace.syscalls.events.augmented->priv == NULL &&
+			    strstr(perf_evsel__name(evsel), "syscalls:sys_enter")) {
 				struct perf_evsel *augmented = trace.syscalls.events.augmented;
 				if (perf_evsel__init_augmented_syscall_tp(augmented, evsel) ||
 				    perf_evsel__init_augmented_syscall_tp_args(augmented))
-- 
2.20.1
