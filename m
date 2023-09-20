Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46B1AC04FEE
	for <linux-perf-users@archiver.kernel.org>; Wed, 20 Sep 2023 19:36:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229441AbjITTg3 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 20 Sep 2023 15:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbjITT3W (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 20 Sep 2023 15:29:22 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3AEECD4
        for <linux-perf-users@vger.kernel.org>; Wed, 20 Sep 2023 12:29:02 -0700 (PDT)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38KIbdmv002701;
        Wed, 20 Sep 2023 19:28:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=F/SffJdMkgw9W1a0dbn0BtHZjNXiYVQPCJWN4TZqYOM=;
 b=UZrTdb67EDCe0oD3GYh5LC1d4Jy3ua/qrn7KmMCoAFruld2Ej4afmIxlBE1fkQB7xq3K
 Fjl6bWNuFfDZNZvRmPUdtIB8jt0bSctQ1YVn2TIixVHIa5Iz65DldQg9sAicy9yO7Wxo
 Pd9MCSkvKuqOEIxQob7j23Se9Q5HxXRbRA3Os1GXc2F20TKcIOFO1oEe/Alwtny5dqLM
 nKyXIfyL9uBP/z8hMF8oQIQAM5fn6nzSTCih1RbX5RwXTTt7cRQciH9LT8Mji2ve+1ey
 tPmlpvnaW6w7gBkTU1L7I84G7onz/9U25VpjIB6pvYWXCrGcmgzBgFAp8gs9T9/v2EJ8 EQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t816pjp3c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Sep 2023 19:28:58 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38KJPijw009511;
        Wed, 20 Sep 2023 19:28:58 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t816pjp35-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Sep 2023 19:28:58 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38KJ1PFU031222;
        Wed, 20 Sep 2023 19:28:57 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3t5r6m0mp4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Sep 2023 19:28:57 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38KJSsaG63504728
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Sep 2023 19:28:54 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 357FF20040;
        Wed, 20 Sep 2023 19:28:54 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2183E20043;
        Wed, 20 Sep 2023 19:28:52 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com.com (unknown [9.171.61.45])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 20 Sep 2023 19:28:51 +0000 (GMT)
From:   Aditya Gupta <adityag@linux.ibm.com>
To:     acme@kernel.org, jolsa@kernel.org, irogers@google.com,
        namhyung@kernel.org
Cc:     linux-perf-users@vger.kernel.org, maddy@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com,
        disgoel@linux.vnet.ibm.com
Subject: [PATCH v2 1/4] perf check: introduce check subcommand
Date:   Thu, 21 Sep 2023 00:58:44 +0530
Message-ID: <20230920192847.975897-2-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230920192847.975897-1-adityag@linux.ibm.com>
References: <20230920192847.975897-1-adityag@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: qHhYuqyrinWiMwuk4GB3Ps4HJatQn_Ef
X-Proofpoint-ORIG-GUID: UI9IZiUQxq4S6Mq6X7Ex__FPQkNzZhwW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-20_09,2023-09-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 mlxscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 suspectscore=0
 phishscore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309200158
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Currently the presence of a feature is checked with a combination of
perf version --build-options and greps, such as:

    perf version --build-options | grep " on .* HAVE_FEATURE"

Instead of this, introduce a subcommand "perf check --feature", with which
scripts can test for presence of a feature, such as:

    perf check --feature HAVE_FEATURE

'perf check --feature' command is expected to have exit status of 1 if feature is
built-in, and 0 if not, -2 if feature is not known.

An array 'supported_features' has also been introduced that can be
used by other commands like 'perf version --build-options', so that
new features can be added in one place, with the array

Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
---
 tools/perf/Build                        |   1 +
 tools/perf/Documentation/perf-check.txt |  56 +++++++++++
 tools/perf/builtin-check.c              | 128 ++++++++++++++++++++++++
 tools/perf/builtin.h                    |  18 ++++
 tools/perf/perf.c                       |   1 +
 5 files changed, 204 insertions(+)
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
index 000000000000..5cf6ab7df8c3
--- /dev/null
+++ b/tools/perf/Documentation/perf-check.txt
@@ -0,0 +1,56 @@
+perf-check(1)
+===============
+
+NAME
+----
+perf-check - check features in perf
+
+SYNOPSIS
+--------
+'perf check' [-q] [--feature]
+
+DESCRIPTION
+-----------
+With no options given, the 'perf check' just prints the perf version
+on the standard output.
+
+If the option '--feature' is given, then status of feature is printed
+on the standard output, ie. whether it is compiled-in/built-in or not
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
diff --git a/tools/perf/builtin-check.c b/tools/perf/builtin-check.c
new file mode 100644
index 000000000000..acd0cfe135d4
--- /dev/null
+++ b/tools/perf/builtin-check.c
@@ -0,0 +1,128 @@
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
+
+	// this should remain at end, to know the array end
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
+ * returns:
+ *   -1: Feature not known
+ *    0: Built-in
+ *    1: NOT Built in
+ */
+static int has_support(const char *feature)
+{
+	int res = -1;
+
+	for (int i = 0; supported_features[i].name; ++i) {
+		if ((strcmp(feature, supported_features[i].name) == 0) ||
+			(strcmp(feature, supported_features[i].macro) == 0)) {
+			res = supported_features[i].is_builtin;
+			if (!quiet)
+				STATUS(supported_features[i]);
+			break;
+		}
+	}
+
+	if (res == -1) {
+		if (!quiet)
+			color_fprintf(stdout, PERF_COLOR_RED, "Feature not known: %s", feature);
+		return -1;
+	}
+
+	return !res;
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
+		return has_support(check.feature);
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
index d3fc8090413c..83dc0ac42fdb 100644
--- a/tools/perf/perf.c
+++ b/tools/perf/perf.c
@@ -50,6 +50,7 @@ static struct cmd_struct commands[] = {
 	{ "archive",	NULL,	0 },
 	{ "buildid-cache", cmd_buildid_cache, 0 },
 	{ "buildid-list", cmd_buildid_list, 0 },
+	{ "check", cmd_check, 0 },
 	{ "config",	cmd_config,	0 },
 	{ "c2c",	cmd_c2c,	0 },
 	{ "diff",	cmd_diff,	0 },
-- 
2.41.0

