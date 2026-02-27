Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9204D2FFFB7;
	Fri, 27 Feb 2026 02:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772161140; cv=none; b=E3YHYiGl5TRuMA5pop6NR3v1CY2G5ga06AGlMW0G+URSg+aZI6oEBAIxydgK/Lw8t+7ccd3FslKE1aLPh7EGckXLpir/WQPgi4AT5GHGHoMgmYOpZhyN1fhW0HsN+RO7AJ2vNHUgjMBSXMhcXvfiUzMA5KOXn+YrKJAe2xJZVVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772161140; c=relaxed/simple;
	bh=1AE1oNBcxtGZFgPnjTirTLuvuB1ZNYC5qLZyvnk6AX0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XEqhQAQRza7Bl7JlOmds5IQI5E+81BaXeZIZMkxxmxq7WM/4Qlx7NXLw/MZM4K3GbK6aY7BqG1bqhuRwcxqF+U7JzMHc3uqKA02UKzncVDzzPffl7DznVXYdu3KrpSqKRP/aMLaT4OXrKdppfx7nQAmryzO6GRr82fdjJTk8o3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=HNmVjLZo; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="HNmVjLZo"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=aX/Dd/Tcmhp0SrNFBS9hGktyCv+DL6hd+Wd/RorFEGg=;
	b=HNmVjLZoLGkK43X6/QDg6/jC1RbrThHEjXWZ/QcGei6J7OR1ZKvhrypy8feCy12E/Eiix6ac4
	0Id0yU5uD7ewWwbzdoZNFzz3g5xFG+H0VbJwyzxcgkTZzLH99H29Fv1d96vA4crxtaDiIhUCoMp
	HQxj4scqt0eYxS7fc7XCjVw=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4fMXwJ2GK9z1K98w;
	Fri, 27 Feb 2026 10:54:08 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id E24444048B;
	Fri, 27 Feb 2026 10:58:53 +0800 (CST)
Received: from kwepemq200002.china.huawei.com (7.202.195.90) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 27 Feb 2026 10:58:53 +0800
Received: from 78cdaf434391.CHINA.huawei.com (10.113.189.214) by
 kwepemq200002.china.huawei.com (7.202.195.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 27 Feb 2026 10:58:52 +0800
From: Changbin Du <changbin.du@huawei.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>
CC: Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, "Ian
 Rogers" <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, "James
 Clark" <james.clark@linaro.org>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Changbin Du <changbin.du@huawei.com>
Subject: [PATCH] perf: Add match_mode support for --symfs option
Date: Fri, 27 Feb 2026 11:13:40 +0000
Message-ID: <20260227111340.1019144-1-changbin.du@huawei.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemq200002.china.huawei.com (7.202.195.90)

Add support for parsing an optional match_mode parameter in the --symfs
command line option. The format is:

  --symfs <directory[,match_mode]>

Where match_mode can be:
  - 'path': matches full path (default)
  - 'basename': only matches base name

When debugging symbol files from a copy of the filesystem (e.g., from a
container or remote machine), the debug files are often stored in a
flat directory structure with only filenames, not the full original
paths. In this case, using 'basename' mode allows perf to find debug
symbols by matching only the filename rather than the full path.

For example, given a binary path like:
  /build/output/lib/foo.so

With
$ perf report --symfs /debug/files,basename

perf will look for:
  /debug/files/foo.so

Instead of:
  /debug/files/build/output/lib/foo.so

This is particularly useful when:
- Extracting debug files from containers with different directory layouts
- Using pre-processed debug file collections (e.g., debugfgs)
- Working with build systems that flatten directory structures

Changes:
- Add symfs_match_basename field to symbol_conf struct.
- Parse optional match_mode in symbol__config_symfs().
- Modify __symbol__join_symfs() to use basename() when match_mode
  is 'basename'.
- Update documentation in Documentation/ folder.

Signed-off-by: Changbin Du <changbin.du@huawei.com>
---
 tools/perf/Documentation/perf-annotate.txt  |  7 +++--
 tools/perf/Documentation/perf-diff.txt      |  7 +++--
 tools/perf/Documentation/perf-kwork.txt     |  7 +++--
 tools/perf/Documentation/perf-probe.txt     |  6 ++++
 tools/perf/Documentation/perf-report.txt    |  7 +++--
 tools/perf/Documentation/perf-sched.txt     |  7 +++--
 tools/perf/Documentation/perf-script.txt    |  7 +++--
 tools/perf/Documentation/perf-timechart.txt |  7 +++--
 tools/perf/Documentation/tips.txt           |  3 +-
 tools/perf/builtin-annotate.c               |  3 +-
 tools/perf/builtin-diff.c                   |  3 +-
 tools/perf/builtin-kwork.c                  |  4 +--
 tools/perf/builtin-probe.c                  |  4 +--
 tools/perf/builtin-report.c                 |  3 +-
 tools/perf/builtin-sched.c                  |  4 +--
 tools/perf/builtin-script.c                 |  3 +-
 tools/perf/builtin-timechart.c              |  3 +-
 tools/perf/util/symbol.c                    | 34 ++++++++++++++++++---
 tools/perf/util/symbol.h                    | 18 +++++++++++
 tools/perf/util/symbol_conf.h               |  1 +
 20 files changed, 103 insertions(+), 35 deletions(-)

diff --git a/tools/perf/Documentation/perf-annotate.txt b/tools/perf/Documentation/perf-annotate.txt
index 547f1a268018..f064cab431db 100644
--- a/tools/perf/Documentation/perf-annotate.txt
+++ b/tools/perf/Documentation/perf-annotate.txt
@@ -110,8 +110,11 @@ include::itrace.txt[]
 	Interleave source code with assembly code. Enabled by default,
 	disable with --no-source.
 
---symfs=<directory>::
-        Look for files with symbols relative to this directory.
+--symfs=<directory[,match_mode]>::
+        Look for files with symbols relative to this directory. The optional
+        match_mode can be 'path' (default, matches full path) or 'basename'
+        (only matches base name). This is useful when debug files are stored
+        in a flat directory structure.
 
 -M::
 --disassembler-style=:: Set disassembler style for objdump.
diff --git a/tools/perf/Documentation/perf-diff.txt b/tools/perf/Documentation/perf-diff.txt
index 58efab72d2e5..5a46f97e2688 100644
--- a/tools/perf/Documentation/perf-diff.txt
+++ b/tools/perf/Documentation/perf-diff.txt
@@ -81,8 +81,11 @@ OPTIONS
 --force::
         Don't do ownership validation.
 
---symfs=<directory>::
-        Look for files with symbols relative to this directory.
+--symfs=<directory[,match_mode]>::
+        Look for files with symbols relative to this directory. The optional
+        match_mode can be 'path' (default, matches full path) or 'basename'
+        (only matches base name). This is useful when debug files are stored
+        in a flat directory structure.
 
 -b::
 --baseline-only::
diff --git a/tools/perf/Documentation/perf-kwork.txt b/tools/perf/Documentation/perf-kwork.txt
index 21e607669d78..3b7a8adf4b74 100644
--- a/tools/perf/Documentation/perf-kwork.txt
+++ b/tools/perf/Documentation/perf-kwork.txt
@@ -169,8 +169,11 @@ OPTIONS for 'perf kwork timehist'
 --max-stack::
 	Maximum number of functions to display in backtrace, default 5.
 
---symfs=<directory>::
-    Look for files with symbols relative to this directory.
+--symfs=<directory[,match_mode]>::
+        Look for files with symbols relative to this directory. The optional
+        match_mode can be 'path' (default, matches full path) or 'basename'
+        (only matches base name). This is useful when debug files are stored
+        in a flat directory structure.
 
 --time::
 	Only analyze samples within given time window: <start>,<stop>. Times
diff --git a/tools/perf/Documentation/perf-probe.txt b/tools/perf/Documentation/perf-probe.txt
index 5c43a6edc0e5..1d754c2a5736 100644
--- a/tools/perf/Documentation/perf-probe.txt
+++ b/tools/perf/Documentation/perf-probe.txt
@@ -50,6 +50,12 @@ OPTIONS
 --source=PATH::
 	Specify path to kernel source.
 
+--symfs=<directory[,match_mode]>::
+	Look for files with symbols relative to this directory. The optional
+	match_mode can be 'path' (default, matches full path) or 'basename'
+	(only matches base name). This is useful when debug files are stored
+	in a flat directory structure.
+
 -v::
 --verbose::
         Be more verbose (show parsed arguments, etc).
diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
index acef3ff4178e..ff5ec9a15040 100644
--- a/tools/perf/Documentation/perf-report.txt
+++ b/tools/perf/Documentation/perf-report.txt
@@ -368,8 +368,11 @@ OPTIONS
 --force::
         Don't do ownership validation.
 
---symfs=<directory>::
-        Look for files with symbols relative to this directory.
+--symfs=<directory[,match_mode]}::
+        Look for files with symbols relative to this directory. The optional
+        match_mode can be 'path' (default, matches full path) or 'basename'
+        (only matches base name). This is useful when debug files are stored
+        in a flat directory structure.
 
 -C::
 --cpu:: Only report samples for the list of CPUs provided. Multiple CPUs can
diff --git a/tools/perf/Documentation/perf-sched.txt b/tools/perf/Documentation/perf-sched.txt
index 4d9981609c04..5c17bc11556e 100644
--- a/tools/perf/Documentation/perf-sched.txt
+++ b/tools/perf/Documentation/perf-sched.txt
@@ -437,8 +437,11 @@ OPTIONS for 'perf sched timehist'
     Show all scheduling events followed by a summary by thread with min,
     max, and average run times (in sec) and relative stddev.
 
---symfs=<directory>::
-    Look for files with symbols relative to this directory.
+--symfs=<directory[,match_mode]>::
+        Look for files with symbols relative to this directory. The optional
+        match_mode can be 'path' (default, matches full path) or 'basename'
+        (only matches base name). This is useful when debug files are stored
+        in a flat directory structure.
 
 -V::
 --cpu-visual::
diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
index ddf92f9c7821..be5b1835330f 100644
--- a/tools/perf/Documentation/perf-script.txt
+++ b/tools/perf/Documentation/perf-script.txt
@@ -307,8 +307,11 @@ OPTIONS
 --kallsyms=<file>::
         kallsyms pathname
 
---symfs=<directory>::
-        Look for files with symbols relative to this directory.
+--symfs=<directory[,match_mode]>::
+        Look for files with symbols relative to this directory. The optional
+        match_mode can be 'path' (default, matches full path) or 'basename'
+        (only matches base name). This is useful when debug files are stored
+        in a flat directory structure.
 
 -G::
 --hide-call-graph::
diff --git a/tools/perf/Documentation/perf-timechart.txt b/tools/perf/Documentation/perf-timechart.txt
index ef2281c56743..bb1e9325638e 100644
--- a/tools/perf/Documentation/perf-timechart.txt
+++ b/tools/perf/Documentation/perf-timechart.txt
@@ -53,8 +53,11 @@ TIMECHART OPTIONS
 -f::
 --force::
 	Don't complain, do it.
---symfs=<directory>::
-        Look for files with symbols relative to this directory.
+--symfs=<directory[,match_mode]>::
+        Look for files with symbols relative to this directory. The optional
+        match_mode can be 'path' (default, matches full path) or 'basename'
+        (only matches base name). This is useful when debug files are stored
+        in a flat directory structure.
 -n::
 --proc-num::
         Print task info for at least given number of tasks.
diff --git a/tools/perf/Documentation/tips.txt b/tools/perf/Documentation/tips.txt
index 3fee9b2a88ea..268316596ba0 100644
--- a/tools/perf/Documentation/tips.txt
+++ b/tools/perf/Documentation/tips.txt
@@ -11,7 +11,8 @@ Search options using a keyword: perf report -h <keyword>
 Use parent filter to see specific call path: perf report -p <regex>
 List events using substring match: perf list <keyword>
 To see list of saved events and attributes: perf evlist -v
-Use --symfs <dir> if your symbol files are in non-standard locations
+Use --symfs <dir>[,basename] if your symbol files are in non-standard locations.
+ Use ',basename' when debug files are in a flat directory structure.
 To see callchains in a more compact form: perf report -g folded
 To see call chains by final symbol taking CPU time (bottom up) use perf report -G
 Show individual samples with: perf script
diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 9c27bb30b708..f4ce70998423 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -744,8 +744,7 @@ int cmd_annotate(int argc, const char **argv)
 			&annotate.group_set,
 			"Show event group information together"),
 	OPT_STRING('C', "cpu", &annotate.cpu_list, "cpu", "list of cpus to profile"),
-	OPT_CALLBACK(0, "symfs", NULL, "directory",
-		     "Look for files with symbols relative to this directory",
+	OPT_CALLBACK(0, "symfs", NULL, "directory[,match_mode]", SYMFS_HELP,
 		     symbol__config_symfs),
 	OPT_BOOLEAN(0, "source", &annotate_opts.annotate_src,
 		    "Interleave source code with assembly code (default)"),
diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
index 59bf1f72d12e..7b7cc3c80dfd 100644
--- a/tools/perf/builtin-diff.c
+++ b/tools/perf/builtin-diff.c
@@ -1280,8 +1280,7 @@ static const struct option options[] = {
 	OPT_STRING_NOEMPTY('t', "field-separator", &symbol_conf.field_sep, "separator",
 		   "separator for columns, no spaces will be added between "
 		   "columns '.' is reserved."),
-	OPT_CALLBACK(0, "symfs", NULL, "directory",
-		     "Look for files with symbols relative to this directory",
+	OPT_CALLBACK(0, "symfs", NULL, "directory[,match_mode]", SYMFS_HELP,
 		     symbol__config_symfs),
 	OPT_UINTEGER('o', "order", &sort_compute, "Specify compute sorting."),
 	OPT_CALLBACK(0, "percentage", NULL, "relative|absolute",
diff --git a/tools/perf/builtin-kwork.c b/tools/perf/builtin-kwork.c
index 7f3068264568..838471edb9e5 100644
--- a/tools/perf/builtin-kwork.c
+++ b/tools/perf/builtin-kwork.c
@@ -2423,8 +2423,8 @@ int cmd_kwork(int argc, const char **argv)
 		    "Display call chains if present"),
 	OPT_UINTEGER(0, "max-stack", &kwork.max_stack,
 		   "Maximum number of functions to display backtrace."),
-	OPT_STRING(0, "symfs", &symbol_conf.symfs, "directory",
-		    "Look for files with symbols relative to this directory"),
+	OPT_CALLBACK(0, "symfs", NULL, "directory[,match_mode]", SYMFS_HELP,
+		     symbol__config_symfs),
 	OPT_STRING(0, "time", &kwork.time_str, "str",
 		   "Time span for analysis (start,stop)"),
 	OPT_STRING('C', "cpu", &kwork.cpu_list, "cpu",
diff --git a/tools/perf/builtin-probe.c b/tools/perf/builtin-probe.c
index 1b4ba85ee019..e2912217153a 100644
--- a/tools/perf/builtin-probe.c
+++ b/tools/perf/builtin-probe.c
@@ -597,8 +597,8 @@ __cmd_probe(int argc, const char **argv)
 	OPT_BOOLEAN(0, "demangle-kernel", &symbol_conf.demangle_kernel,
 		    "Enable kernel symbol demangling"),
 	OPT_BOOLEAN(0, "cache", &probe_conf.cache, "Manipulate probe cache"),
-	OPT_STRING(0, "symfs", &symbol_conf.symfs, "directory",
-		   "Look for files with symbols relative to this directory"),
+	OPT_CALLBACK(0, "symfs", NULL, "directory[,match_mode]", SYMFS_HELP,
+		     symbol__config_symfs),
 	OPT_CALLBACK(0, "target-ns", NULL, "pid",
 		     "target pid for namespace contexts", opt_set_target_ns),
 	OPT_BOOLEAN(0, "bootconfig", &probe_conf.bootconfig,
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 3b81f4b3dc49..e0d81a8cc3bb 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -1416,8 +1416,7 @@ int cmd_report(int argc, const char **argv)
 		   "columns '.' is reserved."),
 	OPT_BOOLEAN('U', "hide-unresolved", &symbol_conf.hide_unresolved,
 		    "Only display entries resolved to a symbol"),
-	OPT_CALLBACK(0, "symfs", NULL, "directory",
-		     "Look for files with symbols relative to this directory",
+	OPT_CALLBACK(0, "symfs", NULL, "directory[,match_mode]", SYMFS_HELP,
 		     symbol__config_symfs),
 	OPT_STRING('C', "cpu", &report.cpu_list, "cpu",
 		   "list of cpus to profile"),
diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 3f509cfdd58c..741e9894490c 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -4879,8 +4879,8 @@ int cmd_sched(int argc, const char **argv)
 		    "Display call chains if present (default on)"),
 	OPT_UINTEGER(0, "max-stack", &sched.max_stack,
 		   "Maximum number of functions to display backtrace."),
-	OPT_STRING(0, "symfs", &symbol_conf.symfs, "directory",
-		    "Look for files with symbols relative to this directory"),
+	OPT_CALLBACK(0, "symfs", NULL, "directory[,match_mode]", SYMFS_HELP,
+		     symbol__config_symfs),
 	OPT_BOOLEAN('s', "summary", &sched.summary_only,
 		    "Show only syscall summary with statistics"),
 	OPT_BOOLEAN('S', "with-summary", &sched.summary,
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 7c743a303507..4fe79971c97f 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -4074,8 +4074,7 @@ int cmd_script(int argc, const char **argv)
 		   "file", "kallsyms pathname"),
 	OPT_BOOLEAN('G', "hide-call-graph", &no_callchain,
 		    "When printing symbols do not display call chain"),
-	OPT_CALLBACK(0, "symfs", NULL, "directory",
-		     "Look for files with symbols relative to this directory",
+	OPT_CALLBACK(0, "symfs", NULL, "directory[,match_mode]", SYMFS_HELP,
 		     symbol__config_symfs),
 	OPT_CALLBACK('F', "fields", NULL, "str",
 		     "comma separated output fields prepend with 'type:'. "
diff --git a/tools/perf/builtin-timechart.c b/tools/perf/builtin-timechart.c
index f8b49d69e9a5..b071c66b8dc4 100644
--- a/tools/perf/builtin-timechart.c
+++ b/tools/perf/builtin-timechart.c
@@ -1951,8 +1951,7 @@ int cmd_timechart(int argc, const char **argv)
 	OPT_CALLBACK('p', "process", NULL, "process",
 		      "process selector. Pass a pid or process name.",
 		       parse_process),
-	OPT_CALLBACK(0, "symfs", NULL, "directory",
-		     "Look for files with symbols relative to this directory",
+	OPT_CALLBACK(0, "symfs", NULL, "directory[,match_mode]", SYMFS_HELP,
 		     symbol__config_symfs),
 	OPT_INTEGER('n', "proc-num", &tchart.proc_num,
 		    "min. number of tasks to print"),
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 8662001e1e25..0cafa6e630e8 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -66,6 +66,7 @@ struct symbol_conf symbol_conf = {
 	.time_quantum		= 100 * NSEC_PER_MSEC, /* 100ms */
 	.show_hist_headers	= true,
 	.symfs			= "",
+	.symfs_match_basename	= false,
 	.event_group		= true,
 	.inline_name		= true,
 	.res_sample		= 0,
@@ -2491,16 +2492,41 @@ int symbol__config_symfs(const struct option *opt __maybe_unused,
 			 const char *dir, int unset __maybe_unused)
 {
 	char *bf = NULL;
+	char *match_mode_str;
 	int ret;
 
-	symbol_conf.symfs = strdup(dir);
-	if (symbol_conf.symfs == NULL)
-		return -ENOMEM;
+	match_mode_str = strchr(dir, ',');
+	if (match_mode_str) {
+		size_t dir_len = match_mode_str - dir;
+		char *dir_copy = strndup(dir, dir_len);
+
+		if (dir_copy == NULL)
+			return -ENOMEM;
+
+		symbol_conf.symfs = dir_copy;
+
+		match_mode_str++;
+		if (!strcmp(match_mode_str, "basename"))
+			symbol_conf.symfs_match_basename = true;
+		else if (!strcmp(match_mode_str, "path"))
+			symbol_conf.symfs_match_basename = false;
+		else {
+			pr_err("Invalid match_mode: '%s', use 'path' or 'basename'\n",
+			       match_mode_str);
+			free(dir_copy);
+			return -EINVAL;
+		}
+	} else {
+		symbol_conf.symfs = strdup(dir);
+		if (symbol_conf.symfs == NULL)
+			return -ENOMEM;
+		symbol_conf.symfs_match_basename = false;
+	}
 
 	/* skip the locally configured cache if a symfs is given, and
 	 * config buildid dir to symfs/.debug
 	 */
-	ret = asprintf(&bf, "%s/%s", dir, ".debug");
+	ret = asprintf(&bf, "%s/%s", symbol_conf.symfs, ".debug");
 	if (ret < 0)
 		return -ENOMEM;
 
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index 3fb5d146d9b1..5afac63d5e06 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -9,6 +9,7 @@
 #include <linux/list.h>
 #include <linux/rbtree.h>
 #include <stdio.h>
+#include <errno.h>
 #include "addr_location.h"
 #include "path.h"
 #include "symbol_conf.h"
@@ -96,6 +97,18 @@ struct intlist;
 
 static inline int __symbol__join_symfs(char *bf, size_t size, const char *path)
 {
+	if (symbol_conf.symfs_match_basename) {
+		char *path_copy = strdup(path);
+		char *base;
+		int ret;
+
+		if (!path_copy)
+			return -ENOMEM;
+		base = basename(path_copy);
+		ret = path__join(bf, size, symbol_conf.symfs, base);
+		free(path_copy);
+		return ret;
+	}
 	return path__join(bf, size, symbol_conf.symfs, path);
 }
 
@@ -169,6 +182,11 @@ size_t symbol__fprintf_symname(const struct symbol *sym, FILE *fp);
 size_t symbol__fprintf(struct symbol *sym, FILE *fp);
 bool symbol__restricted_filename(const char *filename,
 				 const char *restricted_filename);
+
+#define SYMFS_HELP "setup root directory which contains debug files:\n" \
+	"\t\t\t\t" "directory:\tLook for files with symbols relative to this directory.\n" \
+	"\t\t\t\t" "match_mode:\tMode to match files, 'path' matches full path (default), 'basename' only matches base name.\n"
+
 int symbol__config_symfs(const struct option *opt __maybe_unused,
 			 const char *dir, int unset __maybe_unused);
 
diff --git a/tools/perf/util/symbol_conf.h b/tools/perf/util/symbol_conf.h
index 71bb17372a6c..39c4425d51ea 100644
--- a/tools/perf/util/symbol_conf.h
+++ b/tools/perf/util/symbol_conf.h
@@ -93,6 +93,7 @@ struct symbol_conf {
 			*tid_list,
 			*addr_list;
 	const char	*symfs;
+	bool		symfs_match_basename;
 	int		res_sample;
 	int		pad_output_len_dso;
 	int		group_sort_idx;
-- 
2.43.0

