Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DECA4EB5E;
	Tue,  2 Jul 2024 04:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719893947; cv=none; b=JUJ3sPnS6KhQviKMODm+m+YWzKIOYUTEXd0XR2O/O9xcNNsmWY4Bm9xBVuh10YrpizZ7VQMACFIYiyvc3QvWIGj/7kHtMscv8fs0HwsAoZdo+ig6WskzYZcsIUF/K1bOLVi40mULZ5G3aCETlp8b+Z2GTLKjPYIy7pRUqXYgLlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719893947; c=relaxed/simple;
	bh=w9ZjZ6L6HAuWA2cmECtY8a56OvBAar0tLNwjPEqR870=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gdD9ZdXUOhJXW4kh1bIR+6rH/tea1EpH243ci68trlu+PclM/qQ2JlB91SVXhlpMhRxa4sWebHBecSx/g0NB/HIs40yiZfncs7/X1ALOTikwzwiD0D6NdBeFZS2XKKPuFYLBXaQMNnsqRN8OJy6v0JCVElwp02ZhQQ1fFkI6Hgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WCqL82fTqzZh3D;
	Tue,  2 Jul 2024 12:14:24 +0800 (CST)
Received: from kwepemd100011.china.huawei.com (unknown [7.221.188.204])
	by mail.maildlp.com (Postfix) with ESMTPS id 27F88180064;
	Tue,  2 Jul 2024 12:18:56 +0800 (CST)
Received: from M910t.huawei.com (10.110.54.157) by
 kwepemd100011.china.huawei.com (7.221.188.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 2 Jul 2024 12:18:54 +0800
From: Changbin Du <changbin.du@huawei.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>, Nathan Chancellor <nathan@kernel.org>
CC: Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Ian
 Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, "Liang,
 Kan" <kan.liang@linux.intel.com>, Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<llvm@lists.linux.dev>, Hui Wang <hw.huiwang@huawei.com>, Changbin Du
	<changbin.du@huawei.com>
Subject: [PATCH v5 1/8] perf: support specify vdso path in cmdline
Date: Tue, 2 Jul 2024 12:18:30 +0800
Message-ID: <20240702041837.5306-2-changbin.du@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240702041837.5306-1-changbin.du@huawei.com>
References: <20240702041837.5306-1-changbin.du@huawei.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemd100011.china.huawei.com (7.221.188.204)

The vdso dumped from process memory (in buildid-cache) lacks debugging
info. To annotate vdso symbols with source lines we need specify a
debugging version.

For x86, we can find them from your local build as
arch/x86/entry/vdso/vdso{32,64}.so.dbg. Or they may reside in
/lib/modules/<version>/vdso/vdso{32,64}.so on Ubuntu. But notice that
the buildid has to match.

$ sudo perf record -a
$ sudo perf report --objdump=llvm-objdump \
  --vdso arch/x86/entry/vdso/vdso64.so.dbg,arch/x86/entry/vdso/vdso32.so.dbg

Samples: 17K of event 'cycles:P', 4000 Hz, Event count (approx.): 1760
__vdso_clock_gettime  /work/linux-host/arch/x86/entry/vdso/vdso64.so.d
Percent│       movq    -48(%rbp),%rsi
       │       testq   %rax,%rax
       │     ;               return vread_hvclock();
       │       movq    %rax,%rdx
       │     ;               if (unlikely(!vdso_cycles_ok(cycles)))
       │     ↑ js      eb
       │     ↑ jmp     74
       │     ;               ts->tv_sec = vdso_ts->sec;
  0.02 │147:   leaq    2(%rbx),%rax
       │       shlq    $4, %rax
       │       addq    %r10,%rax
       │     ;               while ((seq = READ_ONCE(vd->seq)) & 1) {
  9.38 │152:   movl    (%r10),%ecx

When doing cross platform analysis, we also need specify the vdso path if
we are interested in its symbols.

v2: update documentation.

Signed-off-by: Changbin Du <changbin.du@huawei.com>
---
 tools/perf/Documentation/perf-annotate.txt |  3 +
 tools/perf/Documentation/perf-c2c.txt      |  3 +
 tools/perf/Documentation/perf-inject.txt   |  3 +
 tools/perf/Documentation/perf-report.txt   |  3 +
 tools/perf/Documentation/perf-script.txt   |  3 +
 tools/perf/Documentation/perf-top.txt      |  3 +
 tools/perf/builtin-annotate.c              |  2 +
 tools/perf/builtin-c2c.c                   |  2 +
 tools/perf/builtin-inject.c                |  2 +
 tools/perf/builtin-report.c                |  2 +
 tools/perf/builtin-script.c                |  2 +
 tools/perf/builtin-top.c                   |  2 +
 tools/perf/util/disasm.c                   |  7 +-
 tools/perf/util/symbol.c                   | 82 +++++++++++++++++++++-
 tools/perf/util/symbol_conf.h              |  5 ++
 15 files changed, 119 insertions(+), 5 deletions(-)

diff --git a/tools/perf/Documentation/perf-annotate.txt b/tools/perf/Documentation/perf-annotate.txt
index b95524bea021..4b6692f9a793 100644
--- a/tools/perf/Documentation/perf-annotate.txt
+++ b/tools/perf/Documentation/perf-annotate.txt
@@ -58,6 +58,9 @@ OPTIONS
 --ignore-vmlinux::
 	Ignore vmlinux files.
 
+--vdso=<vdso1[,vdso2]>::
+	Specify vdso pathnames. You can specify up to two for multiarch-support.
+
 --itrace::
 	Options for decoding instruction tracing data. The options are:
 
diff --git a/tools/perf/Documentation/perf-c2c.txt b/tools/perf/Documentation/perf-c2c.txt
index 856f0dfb8e5a..7c07efca7542 100644
--- a/tools/perf/Documentation/perf-c2c.txt
+++ b/tools/perf/Documentation/perf-c2c.txt
@@ -71,6 +71,9 @@ REPORT OPTIONS
 --vmlinux=<file>::
 	vmlinux pathname
 
+--vdso=<vdso1[,vdso2]>::
+	Specify vdso pathnames. You can specify up to two for multiarch-support.
+
 -v::
 --verbose::
 	Be more verbose (show counter open errors, etc).
diff --git a/tools/perf/Documentation/perf-inject.txt b/tools/perf/Documentation/perf-inject.txt
index c972032f4ca0..3c88967b4c7f 100644
--- a/tools/perf/Documentation/perf-inject.txt
+++ b/tools/perf/Documentation/perf-inject.txt
@@ -62,6 +62,9 @@ OPTIONS
 --kallsyms=<file>::
 	kallsyms pathname
 
+--vdso=<vdso1[,vdso2]>::
+	Specify vdso pathnames. You can specify up to two for multiarch-support.
+
 --itrace::
 	Decode Instruction Tracing data, replacing it with synthesized events.
 	Options are:
diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
index d2b1593ef700..8a3ba5f74cac 100644
--- a/tools/perf/Documentation/perf-report.txt
+++ b/tools/perf/Documentation/perf-report.txt
@@ -345,6 +345,9 @@ OPTIONS
         Load module symbols. WARNING: This should only be used with -k and
         a LIVE kernel.
 
+--vdso=<vdso1[,vdso2]>::
+	Specify vdso pathnames. You can specify up to two for multiarch-support.
+
 -f::
 --force::
         Don't do ownership validation.
diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
index ff086ef05a0c..48f9974ca4c5 100644
--- a/tools/perf/Documentation/perf-script.txt
+++ b/tools/perf/Documentation/perf-script.txt
@@ -296,6 +296,9 @@ OPTIONS
 --kallsyms=<file>::
         kallsyms pathname
 
+--vdso=<vdso1[,vdso2]>::
+	Specify vdso pathnames. You can specify up to two for multiarch-support.
+
 --symfs=<directory>::
         Look for files with symbols relative to this directory.
 
diff --git a/tools/perf/Documentation/perf-top.txt b/tools/perf/Documentation/perf-top.txt
index a754875fa5bb..1cf3ee16a0c1 100644
--- a/tools/perf/Documentation/perf-top.txt
+++ b/tools/perf/Documentation/perf-top.txt
@@ -76,6 +76,9 @@ Default is to monitor all CPUS.
 --kallsyms=<file>::
 	kallsyms pathname
 
+--vdso=<vdso1[,vdso2]>::
+	Specify vdso pathnames. You can specify up to two for multiarch-support.
+
 -m <pages>::
 --mmap-pages=<pages>::
 	Number of mmap data pages (must be a power of two) or size
diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 50d2fb222d48..ff466882065d 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -742,6 +742,8 @@ int cmd_annotate(int argc, const char **argv)
 		   "file", "vmlinux pathname"),
 	OPT_BOOLEAN('m', "modules", &symbol_conf.use_modules,
 		    "load module symbols - WARNING: use only with -k and LIVE kernel"),
+	OPT_CALLBACK(0, "vdso", NULL, "vdso1[,vdso2]", "vdso pathnames",
+		     parse_vdso_pathnames),
 	OPT_BOOLEAN('l', "print-line", &annotate_opts.print_lines,
 		    "print matching source lines (may be slow)"),
 	OPT_BOOLEAN('P', "full-paths", &annotate_opts.full_path,
diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index c157bd31f2e5..4764f9139661 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -3018,6 +3018,8 @@ static int perf_c2c__report(int argc, const char **argv)
 	const struct option options[] = {
 	OPT_STRING('k', "vmlinux", &symbol_conf.vmlinux_name,
 		   "file", "vmlinux pathname"),
+	OPT_CALLBACK(0, "vdso", NULL, "vdso1[,vdso2]", "vdso pathnames",
+		     parse_vdso_pathnames),
 	OPT_STRING('i', "input", &input_name, "file",
 		   "the input file to process"),
 	OPT_INCR('N', "node-info", &c2c.node_info,
diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index a212678d47be..e774e83d0a0f 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -2247,6 +2247,8 @@ int cmd_inject(int argc, const char **argv)
 			    "don't load vmlinux even if found"),
 		OPT_STRING(0, "kallsyms", &symbol_conf.kallsyms_name, "file",
 			   "kallsyms pathname"),
+		OPT_CALLBACK(0, "vdso", NULL, "vdso1[,vdso2]", "vdso pathnames",
+		     parse_vdso_pathnames),
 		OPT_BOOLEAN('f', "force", &data.force, "don't complain, do it"),
 		OPT_CALLBACK_OPTARG(0, "itrace", &inject.itrace_synth_opts,
 				    NULL, "opts", "Instruction Tracing options\n"
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 69618fb0110b..a64b48460dce 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -1324,6 +1324,8 @@ int cmd_report(int argc, const char **argv)
                     "don't load vmlinux even if found"),
 	OPT_STRING(0, "kallsyms", &symbol_conf.kallsyms_name,
 		   "file", "kallsyms pathname"),
+	OPT_CALLBACK(0, "vdso", NULL, "vdso1[,vdso2]", "vdso pathnames",
+		     parse_vdso_pathnames),
 	OPT_BOOLEAN('f', "force", &symbol_conf.force, "don't complain, do it"),
 	OPT_BOOLEAN('m', "modules", &symbol_conf.use_modules,
 		    "load module symbols - WARNING: use only with -k and LIVE kernel"),
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index c16224b1fef3..2e358922a8d1 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -3965,6 +3965,8 @@ int cmd_script(int argc, const char **argv)
 		   "file", "vmlinux pathname"),
 	OPT_STRING(0, "kallsyms", &symbol_conf.kallsyms_name,
 		   "file", "kallsyms pathname"),
+	OPT_CALLBACK(0, "vdso", NULL, "vdso1[,vdso2]", "vdso pathnames",
+		     parse_vdso_pathnames),
 	OPT_BOOLEAN('G', "hide-call-graph", &no_callchain,
 		    "When printing symbols do not display call chain"),
 	OPT_CALLBACK(0, "symfs", NULL, "directory",
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 1d6aef51c122..a3cce4e76eb9 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1479,6 +1479,8 @@ int cmd_top(int argc, const char **argv)
 		   "file", "kallsyms pathname"),
 	OPT_BOOLEAN('K', "hide_kernel_symbols", &top.hide_kernel_symbols,
 		    "hide kernel symbols"),
+	OPT_CALLBACK(0, "vdso", NULL, "vdso1[,vdso2]", "vdso pathnames",
+		     parse_vdso_pathnames),
 	OPT_CALLBACK('m', "mmap-pages", &opts->mmap_pages, "pages",
 		     "number of mmap data pages", evlist__parse_mmap_pages),
 	OPT_INTEGER('r', "realtime", &top.realtime_prio,
diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
index 72aec8f61b94..8d9d78d3150c 100644
--- a/tools/perf/util/disasm.c
+++ b/tools/perf/util/disasm.c
@@ -16,6 +16,7 @@
 #include "debug.h"
 #include "disasm.h"
 #include "dso.h"
+#include "vdso.h"
 #include "env.h"
 #include "evsel.h"
 #include "map.h"
@@ -1126,7 +1127,7 @@ static int dso__disassemble_filename(struct dso *dso, char *filename, size_t fil
 	if (pos && strlen(pos) < SBUILD_ID_SIZE - 2)
 		dirname(build_id_path);
 
-	if (dso__is_kcore(dso))
+	if (dso__is_kcore(dso) || dso__is_vdso(dso))
 		goto fallback;
 
 	len = readlink(build_id_path, linkname, sizeof(linkname) - 1);
@@ -1134,7 +1135,7 @@ static int dso__disassemble_filename(struct dso *dso, char *filename, size_t fil
 		goto fallback;
 
 	linkname[len] = '\0';
-	if (strstr(linkname, DSO__NAME_KALLSYMS) ||
+	if (strstr(linkname, DSO__NAME_KALLSYMS) || strstr(linkname, DSO__NAME_VDSO) ||
 		access(filename, R_OK)) {
 fallback:
 		/*
@@ -1142,7 +1143,7 @@ static int dso__disassemble_filename(struct dso *dso, char *filename, size_t fil
 		 * cache, or is just a kallsyms file, well, lets hope that this
 		 * DSO is the same as when 'perf record' ran.
 		 */
-		if (dso__kernel(dso) && dso__long_name(dso)[0] == '/')
+		if ((dso__kernel(dso) || dso__is_vdso(dso)) && dso__long_name(dso)[0] == '/')
 			snprintf(filename, filename_size, "%s", dso__long_name(dso));
 		else
 			__symbol__join_symfs(filename, filename_size, dso__long_name(dso));
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 9e5940b5bc59..a90c647d37e1 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -19,6 +19,7 @@
 #include "build-id.h"
 #include "cap.h"
 #include "dso.h"
+#include "vdso.h"
 #include "util.h" // lsdir()
 #include "debug.h"
 #include "event.h"
@@ -44,6 +45,7 @@
 
 static int dso__load_kernel_sym(struct dso *dso, struct map *map);
 static int dso__load_guest_kernel_sym(struct dso *dso, struct map *map);
+static int dso__load_vdso_sym(struct dso *dso, struct map *map);
 static bool symbol__is_idle(const char *name);
 
 int vmlinux_path__nr_entries;
@@ -1833,6 +1835,12 @@ int dso__load(struct dso *dso, struct map *map)
 		goto out;
 	}
 
+	if (dso__is_vdso(dso)) {
+		ret = dso__load_vdso_sym(dso, map);
+		if (ret > 0)
+			goto out;
+	}
+
 	dso__set_adjust_symbols(dso, false);
 
 	if (perfmap) {
@@ -2017,12 +2025,14 @@ int dso__load_vmlinux(struct dso *dso, struct map *map,
 		dso__set_binary_type(dso, DSO_BINARY_TYPE__VMLINUX);
 
 	err = dso__load_sym(dso, map, &ss, &ss, 0);
-	symsrc__destroy(&ss);
-
 	if (err > 0) {
 		dso__set_loaded(dso);
 		pr_debug("Using %s for symbols\n", symfs_vmlinux);
+
+		if (symsrc__has_symtab(&ss) && !dso__symsrc_filename(dso))
+			dso__set_symsrc_filename(dso, strdup(symfs_vmlinux));
 	}
+	symsrc__destroy(&ss);
 
 	return err;
 }
@@ -2349,6 +2359,74 @@ static int vmlinux_path__init(struct perf_env *env)
 	return -1;
 }
 
+int parse_vdso_pathnames(const struct option *opt __maybe_unused,
+			 const char *arg, int unset __maybe_unused)
+{
+	char *tmp, *tok, *str = strdup(arg);
+	unsigned int i = 0;
+
+	for (tok = strtok_r(str, ",", &tmp); tok && i < ARRAY_SIZE(symbol_conf.vdso_name);
+	     tok = strtok_r(NULL, ",", &tmp)) {
+		symbol_conf.vdso_name[i++] = strdup(tok);
+	}
+
+	free(str);
+	return 0;
+}
+
+static int dso__load_vdso(struct dso *dso, struct map *map,
+			  const char *vdso)
+{
+	int err = -1;
+	struct symsrc ss;
+	char symfs_vdso[PATH_MAX];
+
+	if (vdso[0] == '/')
+		snprintf(symfs_vdso, sizeof(symfs_vdso), "%s", vdso);
+	else
+		symbol__join_symfs(symfs_vdso, vdso);
+
+	if (symsrc__init(&ss, dso, symfs_vdso, DSO_BINARY_TYPE__SYSTEM_PATH_DSO))
+		return -1;
+
+	/*
+	 * dso__load_sym() may copy 'dso' which will result in the copies having
+	 * an incorrect long name unless we set it here first.
+	 */
+	dso__set_long_name(dso, vdso, false);
+	dso__set_binary_type(dso, DSO_BINARY_TYPE__SYSTEM_PATH_DSO);
+
+	err = dso__load_sym(dso, map, &ss, &ss, 0);
+	if (err > 0) {
+		dso__set_loaded(dso);
+		pr_debug("Using %s for %s symbols\n", symfs_vdso, dso__short_name(dso));
+
+		if (symsrc__has_symtab(&ss) && !dso__symsrc_filename(dso))
+			dso__set_symsrc_filename(dso, strdup(symfs_vdso));
+	}
+	symsrc__destroy(&ss);
+
+	return err;
+}
+
+static int dso__load_vdso_sym(struct dso *dso, struct map *map)
+{
+	int ret;
+
+	if (!dso__is_vdso(dso))
+		return -1;
+
+	for (unsigned int i = 0; i < ARRAY_SIZE(symbol_conf.vdso_name); i++) {
+		if (symbol_conf.vdso_name[i] != NULL) {
+			ret = dso__load_vdso(dso, map, symbol_conf.vdso_name[i]);
+			if (ret > 0)
+				return ret;
+		}
+	}
+
+	return -1;
+}
+
 int setup_list(struct strlist **list, const char *list_str,
 		      const char *list_name)
 {
diff --git a/tools/perf/util/symbol_conf.h b/tools/perf/util/symbol_conf.h
index c114bbceef40..108356e3c981 100644
--- a/tools/perf/util/symbol_conf.h
+++ b/tools/perf/util/symbol_conf.h
@@ -3,6 +3,7 @@
 #define __PERF_SYMBOL_CONF 1
 
 #include <stdbool.h>
+#include <subcmd/parse-options.h>
 
 struct strlist;
 struct intlist;
@@ -55,6 +56,7 @@ struct symbol_conf {
 	const char	*default_guest_vmlinux_name,
 			*default_guest_kallsyms,
 			*default_guest_modules;
+	const char	*vdso_name[2];
 	const char	*guestmount;
 	const char	*dso_list_str,
 			*comm_list_str,
@@ -85,4 +87,7 @@ struct symbol_conf {
 
 extern struct symbol_conf symbol_conf;
 
+int parse_vdso_pathnames(const struct option *opt __maybe_unused,
+			 const char *arg, int unset __maybe_unused);
+
 #endif // __PERF_SYMBOL_CONF
-- 
2.34.1

