Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="omMusQW1"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAC26A7
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Nov 2023 13:34:49 -0800 (PST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AGLRFvs020278;
	Thu, 16 Nov 2023 21:34:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=cyFeW+R3Tn/VWkzRqdkOmm+WrTRoO+UohbvE0V+tMiM=;
 b=omMusQW19LqyJ50sD8SGUNAs1BRXCPWWwf/dQKqpX9ZTWVEgG49n381XkTe9VoMI8dUb
 DQ+jf9v2vKTMprmPZKa3mJvWPkHJHgQyxT58DH3uYDj8k2fB2d8A40KOhErE4+2ut6ub
 kXhVQEfY/sjNX+yTWWQEJdaj85mx/WU16f5FHtF8gHDn6iX8qOuLAl2dk+cM8+CbPiVn
 EFsWnMFhUs28D27/Yj/TDTdIX0Mmcy7+HG9oseKZSV8AlK/pS1tkh0zpr8zxxKwL84ST
 p7HVnZCV4F/sciFVZCIpHw8gQGq5NcRmILefusH6gMCchZokTKfNDvtd1adiV+5wioGm bQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3udu0ng8m7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Nov 2023 21:34:46 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AGLRSa3021324;
	Thu, 16 Nov 2023 21:34:46 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3udu0ng8kv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Nov 2023 21:34:46 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AGKmsYG002041;
	Thu, 16 Nov 2023 21:34:45 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3uap5kh2vb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Nov 2023 21:34:45 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AGLYg7q4522750
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Nov 2023 21:34:42 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B91F820049;
	Thu, 16 Nov 2023 21:34:42 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 48E9B20040;
	Thu, 16 Nov 2023 21:34:40 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com.com (unknown [9.179.27.153])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 16 Nov 2023 21:34:40 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, maddy@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com,
        disgoel@linux.vnet.ibm.com
Subject: [PATCH v7 1/4] perf check: introduce check subcommand
Date: Fri, 17 Nov 2023 03:04:32 +0530
Message-ID: <20231116213435.382484-2-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231116213435.382484-1-adityag@linux.ibm.com>
References: <20231116213435.382484-1-adityag@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ZO5JXmA7u3x_n6rwsqifSG2cxnwJsFKx
X-Proofpoint-ORIG-GUID: 4JMNUraIGDeJfrLY1_MRLzYGUwkxtd4j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-16_23,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 clxscore=1015 bulkscore=0 malwarescore=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 priorityscore=1501 spamscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311160168

Currently the presence of a feature is checked with a combination of
perf version --build-options and greps, such as:

    perf version --build-options | grep " on .* HAVE_FEATURE"

Instead of this, introduce a subcommand "perf check --feature", with which
scripts can test for presence of a feature, such as:

    perf check --feature HAVE_FEATURE

'perf check --feature' command is expected to have exit status of 0 if
feature is built-in, and 1 if it's not built-in or if feature is not known.

Multiple features can also be passed as a comma-separated list, in which
case the exit status will be 1 only if all of the passed features are
built-in. For example, with below command, it will have exit status of 1 only
if both libtraceevent and libbpf_support are enabled, else 0 in all other cases

    perf check --feature libtraceevent,libbpf_support

An array 'supported_features' has also been introduced that can be used by
other commands like 'perf version --build-options', so that new features
can be added in one place, with the array

Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
---
 tools/perf/Build                        |   1 +
 tools/perf/Documentation/perf-check.txt |  65 +++++++++++
 tools/perf/builtin-check.c              | 146 ++++++++++++++++++++++++
 tools/perf/builtin.h                    |  18 +++
 tools/perf/perf.c                       |   1 +
 5 files changed, 231 insertions(+)
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
index 000000000000..dfb1dddd0ac3
--- /dev/null
+++ b/tools/perf/Documentation/perf-check.txt
@@ -0,0 +1,65 @@
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
+        Print whether feature(s) is compiled-in or not. A feature name/macro is
+        required to be passed after this flag
+
+        Multiple features can also be passed as a comma-separated list, in which
+        case the exit status will be 1 only if all of the passed features are
+        compiled-in.
+
+        Example Usage:
+                perf check --feature libtraceevent
+                perf check --feature HAVE_LIBTRACEEVENT
+                perf check --feature libtraceevent,libbpf_support
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
index 000000000000..25373f055121
--- /dev/null
+++ b/tools/perf/builtin-check.c
@@ -0,0 +1,146 @@
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
+	OPT_STRING(0, "feature", &check.feature, NULL, "check if feature(s) is built in"),
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
+	FEATURE_SUPPORT("bpf_skeletons", HAVE_BPF_SKEL),
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
+		color_fprintf(stdout, PERF_COLOR_RED, "Feature not known: '%s'\n", feature);
+
+	return 0;
+}
+
+int cmd_check(int argc, const char **argv)
+{
+	char *feature_list;
+	char *feature_name;
+	int feature_enabled;
+
+	argc = parse_options(argc, argv, check_options, check_usage,
+			     PARSE_OPT_STOP_AT_NON_OPTION);
+
+	if (check.feature) {
+		/* check.feature can be a single feature name, or a comma-separated list
+		 * of feature names.
+		 * eg. check.feature can be "libtraceevent" or
+		 * "libtraceevent,libbpf_support" etc
+		 *
+		 * In case of a comma-separated list, feature_enabled will be 1, only if
+		 * all features passed in the string are supported
+		 * Note that check.feature will get modified due to strtok and str_trim
+		 */
+		feature_enabled = 1;
+		feature_list = malloc((strlen(check.feature)+1) * sizeof(char));
+		strncpy(feature_list, check.feature, strlen(check.feature)+1);
+		feature_name = strtok(feature_list, ",");
+
+		while (feature_name) {
+			feature_enabled &= has_support(feature_name);
+			feature_name = strtok(NULL, ",");
+		}
+
+		free(feature_list);
+
+		return !feature_enabled;
+	}
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

