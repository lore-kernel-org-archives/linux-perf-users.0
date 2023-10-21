Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC773182A3
	for <linux-perf-users@vger.kernel.org>; Sat, 21 Oct 2023 15:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="X5ibS/0R"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78A2019E
	for <linux-perf-users@vger.kernel.org>; Sat, 21 Oct 2023 08:05:42 -0700 (PDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39LEoAX9017162;
	Sat, 21 Oct 2023 15:05:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=vwIlP/zjT0MUzGYSdOuVhxWxd8S2VXW3mSnsi1tlbNA=;
 b=X5ibS/0RvYaFWJTXfAb1NQg3IE5xZI0Fcvm2pEm3SrunbCOZ2uQ9PQE+B4nC+zBT3yoz
 H6RVnSzRYz8JyQYqn79w0zYc//px7yMF3O/GLMPxBXVEvnIJdtIqHVXpPP1cLSswUqWp
 Ur2daaVTKHI5mPyAaFQXsBYt/31TrzY1J2vGexCnE3z/licsB0hCP091NvH1tuJcoI20
 0fgFmkUb8U2C/0FNa/U1B2scIcCnbx4t4McRaavcG4/NfcNfDDOjfoLdHL0BE2u3Z9ik
 tXq8S7LAKAwhSwTTJZaAICfrCWAGFbroYef3PL9r/OXlp8nnuq7e4NWsLvhN1/6xQIrl 5Q== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tvgreg8g4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 21 Oct 2023 15:05:38 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39LF0On9006974;
	Sat, 21 Oct 2023 15:05:38 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tvgreg8g0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 21 Oct 2023 15:05:38 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39LCxIIa024169;
	Sat, 21 Oct 2023 15:05:37 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tuc29bthe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 21 Oct 2023 15:05:37 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39LF5YA038142362
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 21 Oct 2023 15:05:34 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1C29320043;
	Sat, 21 Oct 2023 15:05:34 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E8C7820040;
	Sat, 21 Oct 2023 15:05:31 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com.com (unknown [9.179.5.156])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 21 Oct 2023 15:05:31 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, maddy@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com,
        disgoel@linux.vnet.ibm.com
Subject: [PATCH v6 1/4] perf check: introduce check subcommand
Date: Sat, 21 Oct 2023 20:35:23 +0530
Message-ID: <20231021150526.2231803-2-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231021150526.2231803-1-adityag@linux.ibm.com>
References: <20231021150526.2231803-1-adityag@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 8oldAWTmwVVYSnJk7N4ScvrtnI1RPNlU
X-Proofpoint-ORIG-GUID: rCr6eAOiMt9xlbmphlVbrfMjyF1xvyvL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-21_07,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 bulkscore=0 mlxscore=0 clxscore=1015 spamscore=0
 suspectscore=0 lowpriorityscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2310170001 definitions=main-2310210138

Currently the presence of a feature is checked with a combination of
perf version --build-options and greps, such as:

    perf version --build-options | grep " on .* HAVE_FEATURE"

Instead of this, introduce a subcommand "perf check --feature", with which
scripts can test for presence of a feature, such as:

    perf check --feature HAVE_FEATURE

'perf check --feature' command is expected to have exit status of 0 if
feature is built-in, and 1 if it's not built-in or if feature is not known.

An array 'supported_features' has also been introduced that can be used by
other commands like 'perf version --build-options', so that new features
can be added in one place, with the array

Acked-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
---
 tools/perf/Build                        |   1 +
 tools/perf/Documentation/perf-check.txt |  60 ++++++++++++
 tools/perf/builtin-check.c              | 123 ++++++++++++++++++++++++
 tools/perf/builtin.h                    |  18 ++++
 tools/perf/perf.c                       |   1 +
 5 files changed, 203 insertions(+)
 create mode 100644 tools/perf/Documentation/perf-check.txt
 create mode 100644 tools/perf/builtin-check.c

diff --git a/tools/perf/Build b/tools/perf/Build
index aa7623622834..a55a797c1b5f 100644
--- a/tools/perf/Build
+++ b/tools/perf/Build
@@ -1,5 +1,6 @@
 perf-y += builtin-bench.o
 perf-y += builtin-annotate.o
+perf-y += builtin-check.o
 perf-y += builtin-config.o
 perf-y += builtin-diff.o
 perf-y += builtin-evlist.o
diff --git a/tools/perf/Documentation/perf-check.txt b/tools/perf/Documentation/perf-check.txt
new file mode 100644
index 000000000000..b7f2902928e7
--- /dev/null
+++ b/tools/perf/Documentation/perf-check.txt
@@ -0,0 +1,60 @@
+perf-check(1)
+===============
+
+NAME
+----
+perf-check - check features in perf
+
+SYNOPSIS
+--------
+'perf check' [<options>]
+
+DESCRIPTION
+-----------
+With no options given, the 'perf check' just prints the perf version
+on the standard output.
+
+If the option '--feature' is given, then status of feature is printed
+on the standard output (unless '-q' is also passed), ie. whether it is
+compiled-in/built-in or not.
+Also, 'perf check --feature' returns with exit status 0 if the feature
+is built-in, otherwise returns with exit status 1.
+
+OPTIONS
+-------
+-q::
+		Do not print any messages or warnings
+
+--feature::
+        Print whether a feature is compiled-in or not. A feature name/macro is
+        required to be passed after this flag
+
+        Example Usage:
+                perf check --feature libtraceevent
+                perf check --feature HAVE_LIBTRACEEVENT
+
+        Supported feature names/macro:
+                dwarf      /  HAVE_DWARF_SUPPORT
+                dwarf_getlocations  /  HAVE_DWARF_GETLOCATIONS_SUPPORT
+                libaudit   /  HAVE_LIBAUDIT_SUPPORT
+                syscall_table       /  HAVE_SYSCALL_TABLE_SUPPORT
+                libbfd     /  HAVE_LIBBFD_SUPPORT
+                debuginfod /  HAVE_DEBUGINFOD_SUPPORT
+                libelf     /  HAVE_LIBELF_SUPPORT
+                libnuma    /  HAVE_LIBNUMA_SUPPORT
+                numa_num_possible_cpus  /  HAVE_LIBNUMA_SUPPORT
+                libperl    /  HAVE_LIBPERL_SUPPORT
+                libpython  /  HAVE_LIBPYTHON_SUPPORT
+                libslang   /  HAVE_SLANG_SUPPORT
+                libcrypto  /  HAVE_LIBCRYPTO_SUPPORT
+                libunwind  /  HAVE_LIBUNWIND_SUPPORT
+                libdw-dwarf-unwind  /  HAVE_DWARF_SUPPORT
+                zlib       /  HAVE_ZLIB_SUPPORT
+                lzma       /  HAVE_LZMA_SUPPORT
+                get_cpuid  /  HAVE_AUXTRACE_SUPPORT
+                bpf        /  HAVE_LIBBPF_SUPPORT
+                aio        /  HAVE_AIO_SUPPORT
+                zstd       /  HAVE_ZSTD_SUPPORT
+                libpfm4    /  HAVE_LIBPFM
+                libtraceevent      /  HAVE_LIBTRACEEVENT
+                bpf_skeletons      /  HAVE_BPF_SKEL
diff --git a/tools/perf/builtin-check.c b/tools/perf/builtin-check.c
new file mode 100644
index 000000000000..1183983e4352
--- /dev/null
+++ b/tools/perf/builtin-check.c
@@ -0,0 +1,123 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "builtin.h"
+#include "color.h"
+#include "util/debug.h"
+#include "util/header.h"
+#include <tools/config.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <string.h>
+#include <subcmd/parse-options.h>
+
+struct check {
+	const char *feature;
+};
+
+static struct check check;
+
+static struct option check_options[] = {
+	OPT_STRING(0, "feature", &check.feature, NULL, "check if a feature is built in"),
+	OPT_BOOLEAN('q', "quiet", &quiet, "do not show any warnings or messages"),
+	OPT_END(),
+};
+
+static const char * const check_usage[] = {
+	"perf check [<options>]",
+	NULL
+};
+
+struct feature_support supported_features[] = {
+	FEATURE_SUPPORT("dwarf", HAVE_DWARF_SUPPORT),
+	FEATURE_SUPPORT("dwarf_getlocations", HAVE_DWARF_GETLOCATIONS_SUPPORT),
+	FEATURE_SUPPORT("libaudit", HAVE_LIBAUDIT_SUPPORT),
+	FEATURE_SUPPORT("syscall_table", HAVE_SYSCALL_TABLE_SUPPORT),
+	FEATURE_SUPPORT("libbfd", HAVE_LIBBFD_SUPPORT),
+	FEATURE_SUPPORT("debuginfod", HAVE_DEBUGINFOD_SUPPORT),
+	FEATURE_SUPPORT("libelf", HAVE_LIBELF_SUPPORT),
+	FEATURE_SUPPORT("libnuma", HAVE_LIBNUMA_SUPPORT),
+	FEATURE_SUPPORT("numa_num_possible_cpus", HAVE_LIBNUMA_SUPPORT),
+	FEATURE_SUPPORT("libperl", HAVE_LIBPERL_SUPPORT),
+	FEATURE_SUPPORT("libpython", HAVE_LIBPYTHON_SUPPORT),
+	FEATURE_SUPPORT("libslang", HAVE_SLANG_SUPPORT),
+	FEATURE_SUPPORT("libcrypto", HAVE_LIBCRYPTO_SUPPORT),
+	FEATURE_SUPPORT("libunwind", HAVE_LIBUNWIND_SUPPORT),
+	FEATURE_SUPPORT("libdw-dwarf-unwind", HAVE_DWARF_SUPPORT),
+	FEATURE_SUPPORT("zlib", HAVE_ZLIB_SUPPORT),
+	FEATURE_SUPPORT("lzma", HAVE_LZMA_SUPPORT),
+	FEATURE_SUPPORT("get_cpuid", HAVE_AUXTRACE_SUPPORT),
+	FEATURE_SUPPORT("bpf", HAVE_LIBBPF_SUPPORT),
+	FEATURE_SUPPORT("aio", HAVE_AIO_SUPPORT),
+	FEATURE_SUPPORT("zstd", HAVE_ZSTD_SUPPORT),
+	FEATURE_SUPPORT("libpfm4", HAVE_LIBPFM),
+	FEATURE_SUPPORT("libtraceevent", HAVE_LIBTRACEEVENT),
+	FEATURE_SUPPORT("bpf_skeletons", HAVE_BPF_SKEL);
+
+	/* this should remain at end, to know the array end */
+	FEATURE_SUPPORT(NULL, _)
+};
+
+static void on_off_print(const char *status)
+{
+	printf("[ ");
+
+	if (!strcmp(status, "OFF"))
+		color_fprintf(stdout, PERF_COLOR_RED, "%-3s", status);
+	else
+		color_fprintf(stdout, PERF_COLOR_GREEN, "%-3s", status);
+
+	printf(" ]");
+}
+
+static void status_print(const char *name, const char *macro,
+			 const char *status)
+{
+	printf("%22s: ", name);
+	on_off_print(status);
+	printf("  # %s\n", macro);
+}
+
+#define STATUS(feature)                                   \
+do {                                                      \
+	if (feature.is_builtin)                               \
+		status_print(feature.name, feature.macro, "on");  \
+	else                                                  \
+		status_print(feature.name, feature.macro, "OFF"); \
+} while (0)
+
+/**
+ * check whether "feature" is built-in with perf
+ *
+ * returns:
+ *    0: NOT built-in or Feature not known
+ *    1: Built-in
+ */
+static int has_support(const char *feature)
+{
+	for (int i = 0; supported_features[i].name; ++i) {
+		if ((strcmp(feature, supported_features[i].name) == 0) ||
+		    (strcmp(feature, supported_features[i].macro) == 0)) {
+			if (!quiet)
+				STATUS(supported_features[i]);
+			return supported_features[i].is_builtin;
+		}
+	}
+
+	if (!quiet)
+		color_fprintf(stdout, PERF_COLOR_RED, "Feature not known: %s", feature);
+
+	return 0;
+}
+
+int cmd_check(int argc, const char **argv)
+{
+	argc = parse_options(argc, argv, check_options, check_usage,
+			     PARSE_OPT_STOP_AT_NON_OPTION);
+
+	if (!quiet)
+		printf("perf check %s\n", perf_version_string);
+
+	if (check.feature)
+		return !has_support(check.feature);
+
+	return 0;
+}
diff --git a/tools/perf/builtin.h b/tools/perf/builtin.h
index f2ab5bae2150..9f895981bc9e 100644
--- a/tools/perf/builtin.h
+++ b/tools/perf/builtin.h
@@ -2,6 +2,23 @@
 #ifndef BUILTIN_H
 #define BUILTIN_H
 
+#include <stddef.h>
+#include <linux/compiler.h>
+#include <tools/config.h>
+
+struct feature_support {
+	const char *name;
+	const char *macro;
+	int is_builtin;
+};
+
+#define FEATURE_SUPPORT(name_, macro_) { \
+	.name = name_,                       \
+	.macro = #macro_,                    \
+	.is_builtin = IS_BUILTIN(macro_) }
+
+extern struct feature_support supported_features[];
+
 void list_common_cmds_help(void);
 const char *help_unknown_cmd(const char *cmd);
 
@@ -9,6 +26,7 @@ int cmd_annotate(int argc, const char **argv);
 int cmd_bench(int argc, const char **argv);
 int cmd_buildid_cache(int argc, const char **argv);
 int cmd_buildid_list(int argc, const char **argv);
+int cmd_check(int argc, const char **argv);
 int cmd_config(int argc, const char **argv);
 int cmd_c2c(int argc, const char **argv);
 int cmd_diff(int argc, const char **argv);
diff --git a/tools/perf/perf.c b/tools/perf/perf.c
index d3fc8090413c..6514f4121c49 100644
--- a/tools/perf/perf.c
+++ b/tools/perf/perf.c
@@ -50,6 +50,7 @@ static struct cmd_struct commands[] = {
 	{ "archive",	NULL,	0 },
 	{ "buildid-cache", cmd_buildid_cache, 0 },
 	{ "buildid-list", cmd_buildid_list, 0 },
+	{ "check",	cmd_check,	0 },
 	{ "config",	cmd_config,	0 },
 	{ "c2c",	cmd_c2c,	0 },
 	{ "diff",	cmd_diff,	0 },
-- 
2.41.0

