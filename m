Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8022417B508
	for <linux-perf-users@vger.kernel.org>; Mon, 17 Jun 2024 06:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718607061; cv=none; b=MDPgglp/q9A7i6hUzc6XTS6+TNUvTmMRY0t1ps84QuIYc/LDUPV/Ih4ej4UptyYoc7ICEqNz0SpOo4JfNOLnd/U5XTpV0oKmYN74kPEnVNGhZjr9+abXFAmMYTShzc0yNnNLymUJIh1pKpbGmXeW5d3qD8FiPEzxIpPAxd8b68w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718607061; c=relaxed/simple;
	bh=4CIarMOyAaww2bVsRwOGJpeK68teqLedVxD+BSTVgnU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DA9GHnuvWXDZHl39i45gOiGNtqjIokQovWMwNwWw0oYnzX1pYZNfcMzV3Opkfrvm7Hm98Ri8i6/IYfz/q8h+3Kpvqodt8s3QHf5hIfc1kRaI9Phwv/j1dREMhW+EvJUtHZogOXJ8ejJJR2JT6rSl6twspkJ+3W58XzZqBebER3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XsWS6iiF; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XsWS6iiF"
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45H6RZuh018193;
	Mon, 17 Jun 2024 06:50:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=T7ergsFSjAzHu
	8FOUFX2PW7VvsVb0y/LIfyNIi4A830=; b=XsWS6iiFeIwVJEy98DVYaNCLzhRtD
	Pbg7Rr1k5bXictSgKgk1K7aCZVRDL9YN/3EJIiDW7E/8b8BI7vmjci9pCdFpeN7q
	F0wRCeRKXkCURIUDObH1vmYmDPWu8Y2hkUnlI8pehjo8U78OROehZVLdnarMGxGt
	h23HJxPM+fWD14P+rGfF7w9cYiZHoINsl9ejLs/D1D19aW0Sa9yzj27Fumq+JNDB
	pQwZYeKPRhRUDozUuQHQBzrhYI8u+UM0G5jBjjaYIWE1gmCtn3O2TKsAh5HoZyLA
	qlPPzcaHTknkr9RBweLvqAHYRfDj2yi0NGjsOg/CJ1grDxtv0prQY4A7g==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ytd96rb32-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Jun 2024 06:50:49 +0000 (GMT)
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45H6omI6019196;
	Mon, 17 Jun 2024 06:50:48 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ytd96rb30-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Jun 2024 06:50:48 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45H4PJF2019506;
	Mon, 17 Jun 2024 06:50:48 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ysnp0qt6v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Jun 2024 06:50:47 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45H6ogeQ55050552
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Jun 2024 06:50:44 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 25E3C2004F;
	Mon, 17 Jun 2024 06:50:42 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E6DCD20043;
	Mon, 17 Jun 2024 06:50:39 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.in.ibm.com (unknown [9.109.199.72])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 17 Jun 2024 06:50:39 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, maddy@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com,
        disgoel@linux.vnet.ibm.com
Subject: [PATCH v9 1/4] perf check: introduce check subcommand
Date: Mon, 17 Jun 2024 12:20:33 +0530
Message-ID: <20240617065036.1194041-2-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240617065036.1194041-1-adityag@linux.ibm.com>
References: <20240617065036.1194041-1-adityag@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Yrm1n62OJmk5mgHzZm-sak6B9ZvZgYfa
X-Proofpoint-GUID: VZ84dxWbTlRJQfYFI3YieKIt_tNs_EZO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-17_05,2024-06-14_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 mlxscore=0
 clxscore=1015 phishscore=0 adultscore=0 mlxlogscore=999 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406170047

Currently the presence of a feature is checked with a combination of
perf version --build-options and greps, such as:

    perf version --build-options | grep " on .* HAVE_FEATURE"

Instead of this, introduce a subcommand "perf check feature", with which
scripts can test for presence of a feature, such as:

    perf check feature HAVE_FEATURE

'perf check feature' command is expected to have exit status of 0 if
feature is built-in, and 1 if it's not built-in or if feature is not known.

Multiple features can also be passed as a comma-separated list, in which
case the exit status will be 1 only if all of the passed features are
built-in. For example, with below command, it will have exit status of 0 only
if both libtraceevent and bpf are enabled, else 1 in all other cases

    perf check feature libtraceevent,bpf

The arguments are case-insensitive.
An array 'supported_features' has also been introduced that can be used by
other commands like 'perf version --build-options', so that new features
can be added in one place, with the array

Reviewed-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>

---
The entries in 'supported_features' array is just sorted list of
features mentioned in 'library_status' function in builtin-version.c
---
---
 tools/perf/Build                        |   1 +
 tools/perf/Documentation/perf-check.txt |  79 +++++++++++
 tools/perf/builtin-check.c              | 178 ++++++++++++++++++++++++
 tools/perf/builtin.h                    |  17 +++
 tools/perf/perf.c                       |   1 +
 5 files changed, 276 insertions(+)
 create mode 100644 tools/perf/Documentation/perf-check.txt
 create mode 100644 tools/perf/builtin-check.c

diff --git a/tools/perf/Build b/tools/perf/Build
index b0cb7ad8e6ac..7635cc823565 100644
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
index 000000000000..896bc2ed67a5
--- /dev/null
+++ b/tools/perf/Documentation/perf-check.txt
@@ -0,0 +1,79 @@
+perf-check(1)
+===============
+
+NAME
+----
+perf-check - check features in perf
+
+SYNOPSIS
+--------
+[verse]
+'perf check' [<options>]
+'perf check' {feature <feature_list>} [<options>]
+
+DESCRIPTION
+-----------
+With no options given, the 'perf check' just prints the perf version
+on the standard output.
+
+If the subcommand 'feature' is used, then status of feature is printed
+on the standard output (unless '-q' is also passed), ie. whether it is
+compiled-in/built-in or not.
+Also, 'perf check feature' returns with exit status 0 if the feature
+is built-in, otherwise returns with exit status 1.
+
+SUBCOMMANDS
+-----------
+
+feature::
+
+        Print whether feature(s) is compiled-in or not, and also returns with an
+        exit status of 0, if passed feature(s) are compiled-in, else 1.
+
+        It expects a feature list as an argument. There can be a single feature
+        name/macro, or multiple features can also be passed as a comma-separated
+        list, in which case the exit status will be 0 only if all of the passed
+        features are compiled-in.
+
+        The feature names/macros are case-insensitive.
+
+        Example Usage:
+                perf check feature libtraceevent
+                perf check feature HAVE_LIBTRACEEVENT
+                perf check feature libtraceevent,bpf
+
+        Supported feature names/macro:
+                aio                     /  HAVE_AIO_SUPPORT
+                bpf                     /  HAVE_LIBBPF_SUPPORT
+                bpf_skeletons           /  HAVE_BPF_SKEL
+                debuginfod              /  HAVE_DEBUGINFOD_SUPPORT
+                dwarf                   /  HAVE_DWARF_SUPPORT
+                dwarf_getlocations      /  HAVE_DWARF_GETLOCATIONS_SUPPORT
+                get_cpuid               /  HAVE_AUXTRACE_SUPPORT
+                numa_num_possible_cpus  /  HAVE_LIBNUMA_SUPPORT
+                libaudit                /  HAVE_LIBAUDIT_SUPPORT
+                libbfd                  /  HAVE_LIBBFD_SUPPORT
+                libelf                  /  HAVE_LIBELF_SUPPORT
+                libcrypto               /  HAVE_LIBCRYPTO_SUPPORT
+                libdw-dwarf-unwind      /  HAVE_DWARF_SUPPORT
+                libnuma                 /  HAVE_LIBNUMA_SUPPORT
+                libperl                 /  HAVE_LIBPERL_SUPPORT
+                libpfm4                 /  HAVE_LIBPFM
+                libpython               /  HAVE_LIBPYTHON_SUPPORT
+                libslang                /  HAVE_SLANG_SUPPORT
+                libtraceevent           /  HAVE_LIBTRACEEVENT
+                libunwind               /  HAVE_LIBUNWIND_SUPPORT
+                lzma                    /  HAVE_LZMA_SUPPORT
+                syscall_table           /  HAVE_SYSCALL_TABLE_SUPPORT
+                zlib                    /  HAVE_ZLIB_SUPPORT
+                zstd                    /  HAVE_ZSTD_SUPPORT
+
+OPTIONS
+-------
+-q::
+        Do not print any messages or warnings
+
+        This can be used along with subcommands such as 'perf check feature'
+        to hide unnecessary output in test scripts, eg.
+        'perf check feature --quiet libtraceevent'
+
diff --git a/tools/perf/builtin-check.c b/tools/perf/builtin-check.c
new file mode 100644
index 000000000000..c5f75f159191
--- /dev/null
+++ b/tools/perf/builtin-check.c
@@ -0,0 +1,178 @@
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
+static const char * const check_subcommands[] = { "feature", NULL };
+static struct option check_options[] = {
+	OPT_BOOLEAN('q', "quiet", &quiet, "do not show any warnings or messages"),
+	OPT_END()
+};
+static struct option check_feature_options[] = { OPT_END() };
+
+static const char *check_usage[] = { NULL };
+static const char *check_feature_usage[] = {
+	"perf check feature <feature_list>",
+	NULL
+};
+
+struct feature_status supported_features[] = {
+	FEATURE_STATUS("aio", HAVE_AIO_SUPPORT),
+	FEATURE_STATUS("bpf", HAVE_LIBBPF_SUPPORT),
+	FEATURE_STATUS("bpf_skeletons", HAVE_BPF_SKEL),
+	FEATURE_STATUS("debuginfod", HAVE_DEBUGINFOD_SUPPORT),
+	FEATURE_STATUS("dwarf", HAVE_DWARF_SUPPORT),
+	FEATURE_STATUS("dwarf_getlocations", HAVE_DWARF_GETLOCATIONS_SUPPORT),
+	FEATURE_STATUS("dwarf-unwind-support", HAVE_DWARF_UNWIND_SUPPORT),
+	FEATURE_STATUS("get_cpuid", HAVE_AUXTRACE_SUPPORT),
+	FEATURE_STATUS("libaudit", HAVE_LIBAUDIT_SUPPORT),
+	FEATURE_STATUS("libbfd", HAVE_LIBBFD_SUPPORT),
+	FEATURE_STATUS("libcapstone", HAVE_LIBCAPSTONE_SUPPORT),
+	FEATURE_STATUS("libcrypto", HAVE_LIBCRYPTO_SUPPORT),
+	FEATURE_STATUS("libdw-dwarf-unwind", HAVE_DWARF_SUPPORT),
+	FEATURE_STATUS("libelf", HAVE_LIBELF_SUPPORT),
+	FEATURE_STATUS("libnuma", HAVE_LIBNUMA_SUPPORT),
+	FEATURE_STATUS("libopencsd", HAVE_CSTRACE_SUPPORT),
+	FEATURE_STATUS("libperl", HAVE_LIBPERL_SUPPORT),
+	FEATURE_STATUS("libpfm4", HAVE_LIBPFM),
+	FEATURE_STATUS("libpython", HAVE_LIBPYTHON_SUPPORT),
+	FEATURE_STATUS("libslang", HAVE_SLANG_SUPPORT),
+	FEATURE_STATUS("libtraceevent", HAVE_LIBTRACEEVENT),
+	FEATURE_STATUS("libunwind", HAVE_LIBUNWIND_SUPPORT),
+	FEATURE_STATUS("lzma", HAVE_LZMA_SUPPORT),
+	FEATURE_STATUS("numa_num_possible_cpus", HAVE_LIBNUMA_SUPPORT),
+	FEATURE_STATUS("syscall_table", HAVE_SYSCALL_TABLE_SUPPORT),
+	FEATURE_STATUS("zlib", HAVE_ZLIB_SUPPORT),
+	FEATURE_STATUS("zstd", HAVE_ZSTD_SUPPORT),
+
+	/* this should remain at end, to know the array end */
+	FEATURE_STATUS(NULL, _)
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
+/* Helper function to print status of a feature along with name/macro */
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
+		if ((strcasecmp(feature, supported_features[i].name) == 0) ||
+		    (strcasecmp(feature, supported_features[i].macro) == 0)) {
+			if (!quiet)
+				STATUS(supported_features[i]);
+			return supported_features[i].is_builtin;
+		}
+	}
+
+	if (!quiet)
+		pr_err("Feature not known: '%s'\n", feature);
+
+	return 0;
+}
+
+
+/**
+ * Usage: 'perf check feature <feature_list>'
+ *
+ * <feature_list> can be a single feature name/macro, or a comma-separated list
+ * of feature names/macros
+ * eg. argument can be "libtraceevent" or "libtraceevent,bpf" etc
+ *
+ * In case of a comma-separated list, feature_enabled will be 1, only if
+ * all features passed in the string are supported
+ *
+ * Note that argv will get modified
+ */
+static int subcommand_feature(int argc, const char **argv)
+{
+	char *feature_list;
+	char *feature_name;
+	int feature_enabled;
+	int buf_len;
+
+	argc = parse_options(argc, argv, check_feature_options,
+			check_feature_usage, 0);
+
+	if (!argc)
+		usage_with_options(check_feature_usage, check_feature_options);
+
+	if (argc > 1) {
+		pr_err("Too many arguments passed to 'perf check feature'\n");
+		return -1;
+	}
+
+	feature_enabled = 1;
+	buf_len = strlen(argv[0]) + 1;
+	/* feature_list is a non-const copy of 'argv[1]' */
+	feature_list = malloc(buf_len * sizeof(char));
+	if (!feature_list) {
+		pr_err("ERROR: failed to allocate memory for feature list\n");
+		return -1;
+	}
+
+	memcpy(feature_list, argv[0], buf_len);
+	feature_name = strtok(feature_list, ",");
+
+	while (feature_name) {
+		feature_enabled &= has_support(feature_name);
+		feature_name = strtok(NULL, ",");
+	}
+
+	free(feature_list);
+
+	return !feature_enabled;
+}
+
+int cmd_check(int argc, const char **argv)
+{
+	argc = parse_options_subcommand(argc, argv, check_options,
+			check_subcommands, check_usage, 0);
+
+	if (!argc)
+		usage_with_options(check_usage, check_options);
+
+	if (strcmp(argv[0], "feature") == 0)
+		return subcommand_feature(argc, argv);
+
+	/* If no subcommand matched above, print usage help */
+	usage_with_options(check_usage, check_options);
+	return 0;
+}
diff --git a/tools/perf/builtin.h b/tools/perf/builtin.h
index f4375deabfa3..0cdb11b9efec 100644
--- a/tools/perf/builtin.h
+++ b/tools/perf/builtin.h
@@ -2,6 +2,22 @@
 #ifndef BUILTIN_H
 #define BUILTIN_H
 
+#include <stddef.h>
+#include <linux/compiler.h>
+#include <tools/config.h>
+
+struct feature_status {
+	const char *name;
+	const char *macro;
+	int is_builtin;
+};
+
+#define FEATURE_STATUS(name_, macro_) { \
+	.name = name_,                       \
+	.macro = #macro_,                    \
+	.is_builtin = IS_BUILTIN(macro_) }
+
+extern struct feature_status supported_features[];
 struct cmdnames;
 
 void list_common_cmds_help(void);
@@ -11,6 +27,7 @@ int cmd_annotate(int argc, const char **argv);
 int cmd_bench(int argc, const char **argv);
 int cmd_buildid_cache(int argc, const char **argv);
 int cmd_buildid_list(int argc, const char **argv);
+int cmd_check(int argc, const char **argv);
 int cmd_config(int argc, const char **argv);
 int cmd_c2c(int argc, const char **argv);
 int cmd_diff(int argc, const char **argv);
diff --git a/tools/perf/perf.c b/tools/perf/perf.c
index bd3f80b5bb46..4def800f4089 100644
--- a/tools/perf/perf.c
+++ b/tools/perf/perf.c
@@ -52,6 +52,7 @@ static struct cmd_struct commands[] = {
 	{ "archive",	NULL,	0 },
 	{ "buildid-cache", cmd_buildid_cache, 0 },
 	{ "buildid-list", cmd_buildid_list, 0 },
+	{ "check",	cmd_check,	0 },
 	{ "config",	cmd_config,	0 },
 	{ "c2c",	cmd_c2c,	0 },
 	{ "diff",	cmd_diff,	0 },
-- 
2.45.2

