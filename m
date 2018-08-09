From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 01/44] perf trace: Associate vfs_getname()'ed pathname with fd returned from 'openat'
Date: Thu,  9 Aug 2018 11:57:39 -0300
Message-ID: <20180809145822.21391-2-acme@kernel.org>
References: <20180809145822.21391-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180809145822.21391-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

When the vfs_getname() wannabe tracepoint is in place:

  # perf probe -l
    probe:vfs_getname    (on getname_flags:73@acme/git/linux/fs/namei.c with pathname)
  #

'perf trace' will use it to get the pathname when it is copied from
userspace to the kernel, right after syscalls:sys_enter_open, copied
in the 'probe:vfs_getname', stash it somewhere and then, at
syscalls:sys_exit_open time, if the 'open' return is not -1, i.e. a
successfull open syscall, associate that pathname to this return, i.e.
the fd.

We were not doing this for the 'openat' syscall, which would cause 'perf
trace' to fallback to using /proc to get the fd, change it so that we
use what we got from probe:vfs_getname, reducing the 'openat'
beautification process cost, ditching the syscalls performed to read
procfs state and avoiding some possible races in the process.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-xnp44ao3bkb6ejeczxfnjwsh@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 88561eed7950..2a85f5198da0 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -121,7 +121,6 @@ struct trace {
 	bool			force;
 	bool			vfs_getname;
 	int			trace_pgfaults;
-	int			open_id;
 };
 
 struct tp_field {
@@ -805,12 +804,17 @@ static struct syscall_fmt *syscall_fmt__find(const char *name)
 	return bsearch(name, syscall_fmts, nmemb, sizeof(struct syscall_fmt), syscall_fmt__cmp);
 }
 
+/*
+ * is_exit: is this "exit" or "exit_group"?
+ * is_open: is this "open" or "openat"? To associate the fd returned in sys_exit with the pathname in sys_enter.
+ */
 struct syscall {
 	struct event_format *tp_format;
 	int		    nr_args;
+	bool		    is_exit;
+	bool		    is_open;
 	struct format_field *args;
 	const char	    *name;
-	bool		    is_exit;
 	struct syscall_fmt  *fmt;
 	struct syscall_arg_fmt *arg_fmt;
 };
@@ -1299,6 +1303,7 @@ static int trace__read_syscall_info(struct trace *trace, int id)
 	}
 
 	sc->is_exit = !strcmp(name, "exit_group") || !strcmp(name, "exit");
+	sc->is_open = !strcmp(name, "open") || !strcmp(name, "openat");
 
 	return syscall__set_arg_fmts(sc);
 }
@@ -1722,7 +1727,7 @@ static int trace__sys_exit(struct trace *trace, struct perf_evsel *evsel,
 
 	ret = perf_evsel__sc_tp_uint(evsel, ret, sample);
 
-	if (id == trace->open_id && ret >= 0 && ttrace->filename.pending_open) {
+	if (sc->is_open && ret >= 0 && ttrace->filename.pending_open) {
 		trace__set_fd_pathname(thread, ret, ttrace->filename.name);
 		ttrace->filename.pending_open = false;
 		++trace->stats.vfs_getname;
@@ -3205,8 +3210,6 @@ int cmd_trace(int argc, const char **argv)
 		}
 	}
 
-	trace.open_id = syscalltbl__id(trace.sctbl, "open");
-
 	err = target__validate(&trace.opts.target);
 	if (err) {
 		target__strerror(&trace.opts.target, err, bf, sizeof(bf));
-- 
2.14.4
