From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 07/40] perf trace: Ditch __syscall__arg_val() variant, not needed anymore
Date: Wed, 26 Jul 2017 11:16:57 -0300
Message-ID: <20170726141730.30750-8-acme@kernel.org>
References: <20170726141730.30750-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170726141730.30750-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

All callers now can use syscall__arg_val(arg, idx), be it to iterate
thru the syscall arguments while taking into account alignment, or to
get values for other arguments that affect how the current argument
should be formatted (think of fcntl's 'cmd' and 'arg' arguments).

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/n/tip-wm5b156d8kro1r4y3b33eyta@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index fc4d33a6aa58..f8b7bfdf4ee7 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1336,20 +1336,15 @@ static int trace__validate_ev_qualifier(struct trace *trace)
  * variable to read it. Most notably this avoids extended load instructions
  * on unaligned addresses
  */
-static unsigned long __syscall_arg__val(unsigned char *args, u8 idx)
+unsigned long syscall_arg__val(struct syscall_arg *arg, u8 idx)
 {
 	unsigned long val;
-	unsigned char *p = args + sizeof(unsigned long) * idx;
+	unsigned char *p = arg->args + sizeof(unsigned long) * idx;
 
 	memcpy(&val, p, sizeof(val));
 	return val;
 }
 
-unsigned long syscall_arg__val(struct syscall_arg *arg, u8 idx)
-{
-	return __syscall_arg__val(arg->args, idx);
-}
-
 static size_t syscall__scnprintf_val(struct syscall *sc, char *bf, size_t size,
 				     struct syscall_arg *arg, unsigned long val)
 {
-- 
2.9.4
