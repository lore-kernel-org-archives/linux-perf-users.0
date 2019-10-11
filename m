From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 05/69] perf trace: Separate 'struct syscall_fmt' definition from syscall_fmts variable
Date: Fri, 11 Oct 2019 17:04:55 -0300
Message-ID: <20191011200559.7156-6-acme@kernel.org>
References: <20191011200559.7156-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191011200559.7156-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= <lclaudio@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

As this has all the things needed to format tracepoints events, not just
syscalls, that, after all, are just tracepoints with a set in stone ABI,
i.e. order and number of parameters.

For tracepoints we'll create a

  static struct syscall_fmt tracepoint_fmts[]

array and will fill the ->arg[] entries with the beautifier for each
positional argument and record the name, then, when we need it, we'll
just check that the position has the same name, maybe even type, so that
we can do some check that the tracepoint hasn't changed, if it has, we
can even reorder things.

Keep calling it syscall_fmt but use it as well for tracepoints, do it
this way to minimize changes and reuse what is in place for syscalls,
we'll see.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-2x1jgiev13zt4njaanlnne0d@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index ee330f50b450..cb853434d761 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -702,7 +702,7 @@ struct syscall_arg_fmt {
 	bool	   show_zero;
 };
 
-static struct syscall_fmt {
+struct syscall_fmt {
 	const char *name;
 	const char *alias;
 	struct {
@@ -714,7 +714,9 @@ static struct syscall_fmt {
 	bool	   errpid;
 	bool	   timeout;
 	bool	   hexret;
-} syscall_fmts[] = {
+};
+
+static struct syscall_fmt syscall_fmts[] = {
 	{ .name	    = "access",
 	  .arg = { [1] = { .scnprintf = SCA_ACCMODE,  /* mode */ }, }, },
 	{ .name	    = "arch_prctl",
-- 
2.21.0
