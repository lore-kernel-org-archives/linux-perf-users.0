From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 08/40] perf trace: Allow specifying number of syscall args for tracepointless syscalls
Date: Wed, 26 Jul 2017 11:16:58 -0300
Message-ID: <20170726141730.30750-9-acme@kernel.org>
References: <20170726141730.30750-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170726141730.30750-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

When we don't have syscalls:sys_{enter,exit}_NAME, we had to resort to
dumping all the 6 syscall arguments, fix it by providing that info for
such syscalls, like 'clone'.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/n/tip-dfq1jtrxj8dqvqoeqqpr3slu@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index f8b7bfdf4ee7..e1988d08911d 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -611,6 +611,7 @@ static struct syscall_fmt {
 	const char *name;
 	const char *alias;
 	struct syscall_arg_fmt arg[6];
+	u8	   nr_args;
 	bool	   errpid;
 	bool	   timeout;
 	bool	   hexret;
@@ -1169,6 +1170,9 @@ static int syscall__alloc_arg_fmts(struct syscall *sc, int nr_args)
 {
 	int idx;
 
+	if (nr_args == 6 && sc->fmt && sc->fmt->nr_args != 0)
+		nr_args = sc->fmt->nr_args;
+
 	sc->arg_fmt = calloc(nr_args, sizeof(*sc->arg_fmt));
 	if (sc->arg_fmt == NULL)
 		return -1;
@@ -1413,7 +1417,7 @@ static size_t syscall__scnprintf_args(struct syscall *sc, char *bf, size_t size,
 		 * may end up not having any args, like with gettid(), so only
 		 * print the raw args when we didn't manage to read it.
 		 */
-		while (arg.idx < 6) {
+		while (arg.idx < sc->nr_args) {
 			if (arg.mask & bit)
 				goto next_arg;
 			val = syscall_arg__val(&arg, arg.idx);
-- 
2.9.4
