From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 23/37] perf trace beauty: Disable fd->pathname when close() not enabled
Date: Mon, 22 Jul 2019 14:38:25 -0300
Message-ID: <20190722173839.22898-24-acme@kernel.org>
References: <20190722173839.22898-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190722173839.22898-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= <lclaudio@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

As we invalidate the fd->pathname table in the SCA_CLOSE_FD beautifier,
if we don't have it we may end up keeping an fd->pathname association
that then gets misprinted.

The previous behaviour continues when the close() syscall is enabled,
which may still be a a problem if we lose records (i.e. we may lose a
'close' record and then get that fd reused by socket()) but then the
tool will notify that records are being lost and the user will be warned
that some of the heuristics will fall apart.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-b7t6h8sq9lebemvfy2zh3qq1@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 123d7efc12e8..94c33bb573c1 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -127,6 +127,7 @@ struct trace {
 	unsigned int		min_stack;
 	int			raw_augmented_syscalls_args_size;
 	bool			raw_augmented_syscalls;
+	bool			fd_path_disabled;
 	bool			sort_events;
 	bool			not_ev_qualifier;
 	bool			live;
@@ -1178,7 +1179,7 @@ static const char *thread__fd_path(struct thread *thread, int fd,
 {
 	struct thread_trace *ttrace = thread__priv(thread);
 
-	if (ttrace == NULL)
+	if (ttrace == NULL || trace->fd_path_disabled)
 		return NULL;
 
 	if (fd < 0)
@@ -2097,7 +2098,7 @@ static int trace__sys_exit(struct trace *trace, struct perf_evsel *evsel,
 
 	ret = perf_evsel__sc_tp_uint(evsel, ret, sample);
 
-	if (sc->is_open && ret >= 0 && ttrace->filename.pending_open) {
+	if (!trace->fd_path_disabled && sc->is_open && ret >= 0 && ttrace->filename.pending_open) {
 		trace__set_fd_pathname(thread, ret, ttrace->filename.name);
 		ttrace->filename.pending_open = false;
 		++trace->stats.vfs_getname;
@@ -3206,7 +3207,6 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 	if (trace->syscalls.prog_array.sys_enter)
 		trace__init_syscalls_bpf_prog_array_maps(trace);
 
-
 	if (trace->ev_qualifier_ids.nr > 0) {
 		err = trace__set_ev_qualifier_filter(trace);
 		if (err < 0)
@@ -3218,6 +3218,19 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 		}
 	}
 
+	/*
+	 * If the "close" syscall is not traced, then we will not have the
+	 * opportunity to, in syscall_arg__scnprintf_close_fd() invalidate the
+	 * fd->pathname table and were ending up showing the last value set by
+	 * syscalls opening a pathname and associating it with a descriptor or
+	 * reading it from /proc/pid/fd/ in cases where that doesn't make
+	 * sense.
+	 *
+	 *  So just disable this beautifier (SCA_FD, SCA_FDAT) when 'close' is
+	 *  not in use.
+	 */
+	trace->fd_path_disabled = !trace__syscall_enabled(trace, syscalltbl__id(trace->sctbl, "close"));
+
 	err = perf_evlist__apply_filters(evlist, &evsel);
 	if (err < 0)
 		goto out_error_apply_filters;
-- 
2.21.0
