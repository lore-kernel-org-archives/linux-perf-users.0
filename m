Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C42DC4338F
	for <linux-perf-users@archiver.kernel.org>; Fri, 13 Aug 2021 19:21:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 035E7608FC
	for <linux-perf-users@archiver.kernel.org>; Fri, 13 Aug 2021 19:21:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233507AbhHMTWR (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 13 Aug 2021 15:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbhHMTWQ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 13 Aug 2021 15:22:16 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA34C0617AD
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Aug 2021 12:21:49 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id b12-20020a25cb0c0000b0290593e6b14f6aso9235605ybg.22
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Aug 2021 12:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=fDMyfspV5B/FqENN5/SukYEbaS4Jer0fbwUSDGQHTmw=;
        b=Qcrd/9oYMj9PHIAUTei7pgk6ymyjHgT3wYYx5SLyl2DMrDLFSWNpGfKniJwM1d/w2U
         yMeQ58kOlwFiI2SDuTNIeQ5I76odrVCS6QUDQkehpk3ceRumuNHOLTMsbWRwS4tJKjV3
         WXy1ol0AWI3peGx3N2/F1gy1mY8sYRXyrl8zvN3nz17HylvCd1nf10SvViS/X3n+xCwd
         9TNL4Yb5rLu7b7qUC8RKfICJYcgykrMFoGAJTFzxMZZ9D1cLaUltAD81xtBIDIUTnoRV
         iKvh7lc8ErkrIYxJ58gggk5RRHicqqeixMUtPj/bthjEvm2pMs/8SLSVZVhtjjcTZQrC
         aJOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=fDMyfspV5B/FqENN5/SukYEbaS4Jer0fbwUSDGQHTmw=;
        b=NJL05VP/jlK7SLYv/FPDl4jjeuHtPxXPjLIUJh2cD56wKGlS/K6tCxsYRNd2wBg71j
         +2ISoFFlMO4N5XuKnowA3nfS7tm9BylpMvmRxZ5T/KFY7ZTcqswI4XqfuzighUiMqInu
         vTiwQ8K9SirEA/j/+s9dE9ylKSjOy7dlrrQA5//yShY8QLHPou7A7vZsMM/4HCpcrNgg
         sbdFCx2H0mAYsfRIzHkCIIZNa6yfLyknQt1byNMDcoJH+AWhBIBLMjbRga5/H37KlagG
         XB05aHKsuMxtAAFCgNWYRoXv2Sg7KrnsyoDdQ7UIScrL1WqCH3Qs9ZAuMWvoaZO9Z7AU
         tjuw==
X-Gm-Message-State: AOAM530oZz6bJxEyQ2iiy7cY51pXBPLmwmK8qJzyqRUNFmm3LPrds6/R
        Xfj8dtbeg1GMYKyRGRi9SZtukc7Xqzc=
X-Google-Smtp-Source: ABdhPJzHLNAT1NbUU5NMPaXShCIG+e/FjJdggIXfRf+WcwcFF+/yfTa8f/QCUb9GmvxxIGmNM0+2SqzqLUk=
X-Received: from cjense.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:6d0])
 (user=cjense job=sendgmr) by 2002:a5b:98c:: with SMTP id c12mr4943175ybq.156.1628882508682;
 Fri, 13 Aug 2021 12:21:48 -0700 (PDT)
Date:   Fri, 13 Aug 2021 19:21:09 +0000
Message-Id: <20210813192108.2087512-1-cjense@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: [PATCH v2 1/1] Add field checking tests for perf stat CSV output.
From:   Claire Jensen <cjense@google.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, clairej735@gmail.com,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Claire Jensen <cjense@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Counts expected fields for various commands. No testing added for
summary mode since it is broken.

An example of the summary output is:

         summary,263831,,instructions:u,1435072,100.0,0.46,insn per cycle
,,,,,1.37,stalled cycles per insn

This should be:

         summary,263831,,instructions:u,1435072,100.0,0.46,insn per cycle
         summary,,,,,,1.37,stalled cycles per insn

The output has 7 fields when it should have 8. Additionally, the newline
spacing is wrong, so it was excluded from testing until a fix is made.

Version 2 fixes an issue with the SPDX-License-Identifier and puts it on
line 3 and the test name on line 2.

Signed-off-by: Claire Jensen <cjense@google.com>
---
 .../tests/shell/lib/perf_csv_output_lint.py   |  51 ++++++++
 tools/perf/tests/shell/stat+csv_output.sh     | 109 ++++++++++++++++++
 2 files changed, 160 insertions(+)
 create mode 100644 tools/perf/tests/shell/lib/perf_csv_output_lint.py
 create mode 100644 tools/perf/tests/shell/stat+csv_output.sh

diff --git a/tools/perf/tests/shell/lib/perf_csv_output_lint.py b/tools/perf/tests/shell/lib/perf_csv_output_lint.py
new file mode 100644
index 000000000000..b6f8adfb6a26
--- /dev/null
+++ b/tools/perf/tests/shell/lib/perf_csv_output_lint.py
@@ -0,0 +1,51 @@
+#!/usr/bin/python
+# SPDX-License-Identifier: GPL-2.0
+
+from __future__ import print_function
+import argparse
+import sys
+
+# Basic sanity check of perf CSV output as specified in the man page.
+# Currently just checks the number of fields per line in output.
+
+ap = argparse.ArgumentParser()
+ap.add_argument('--no-args', action='store_true')
+ap.add_argument('--interval', action='store_true')
+ap.add_argument('--all-cpus-no-aggr', action='store_true')
+ap.add_argument('--all-cpus', action='store_true')
+ap.add_argument('--event', action='store_true')
+ap.add_argument('--per-core', action='store_true')
+ap.add_argument('--per-thread', action='store_true')
+ap.add_argument('--per-die', action='store_true')
+ap.add_argument('--per-node', action='store_true')
+ap.add_argument('--per-socket', action='store_true')
+ap.add_argument('--separator', const=',', nargs='?')
+args = ap.parse_args()
+
+Lines = sys.stdin.readlines()
+ch = args.separator
+
+
+def check_csv_output(exp):
+  for line in Lines:
+    if 'failed' not in line:
+      count = 0
+      count = line.count(args.separator)
+      if count != exp:
+        sys.stdout.write(''.join(Lines))
+        raise RuntimeError('wrong number of fields.'
+                           ' expected {0} in {1}\n'.format(exp, line))
+
+try:
+  if args.no_args or args.all_cpus or args.event:
+    check_csv_output(6)
+
+  if args.interval or args.per_thread:
+    check_csv_output(7)
+
+  if args.per_core or args.per_socket or args.per_node or args.per_die:
+    check_csv_output(8)
+
+except:
+  sys.stdout.write('Test failed for input: ' + ''.join(Lines))
+  raise
diff --git a/tools/perf/tests/shell/stat+csv_output.sh b/tools/perf/tests/shell/stat+csv_output.sh
new file mode 100644
index 000000000000..0f673f423cf7
--- /dev/null
+++ b/tools/perf/tests/shell/stat+csv_output.sh
@@ -0,0 +1,109 @@
+#!/bin/bash
+# perf stat csv output test
+# SPDX-License-Identifier: GPL-2.0
+# Tests various perf stat CSV output commands for the
+# correct number of fields and the CSV separator set to ','.
+
+set -e
+
+pythonchecker=$(dirname $0)/lib/perf_csv_output_lint.py
+file="/proc/sys/kernel/perf_event_paranoid"
+paranoia=$(cat "$file" | grep -o -E '[0-9]+')
+echo $paranoia
+
+check_no_args()
+{
+	perf stat -x, sleep 1 2>&1 | \
+	python $pythonchecker --no-args --separator
+}
+
+if [ $paranoia -gt 0 ]; then
+	echo check_all_cpus test skipped because of paranoia level.
+else
+	check_all_cpus()
+	{
+		perf stat -x, -a 2>&1 sleep 1 | \
+		python $pythonchecker --all-cpus --separator
+	}
+	check_all_cpus
+fi
+
+check_interval()
+{
+	perf stat -x, -I 1000 2>&1 sleep 1 | \
+	python $pythonchecker --interval --separator
+}
+
+check_all_cpus_no_aggr()
+{
+	perf stat -x, -A -a --no-merge 2>&1 sleep 1 | \
+	python $pythonchecker --all-cpus-no-aggr --separator
+}
+
+check_event()
+{
+	perf stat -x, -e cpu-clock 2>&1 sleep 1 | \
+	python $pythonchecker --event --separator
+}
+
+if [ $paranoia -gt 0 ]; then
+	echo check_all_cpus test skipped because of paranoia level.
+else
+	check_per_core()
+	{
+		perf stat -x, --per-core -a 2>&1 sleep 1 | \
+		python $pythonchecker --per-core --separator
+	}
+	check_per_core
+fi
+
+if [ $paranoia -gt 0 ]; then
+	echo check_all_cpus test skipped because of paranoia level.
+else
+	check_per_thread()
+	{
+		perf stat -x, --per-thread -a 2>&1 sleep 1 | \
+		python $pythonchecker --per-thread --separator
+	}
+	check_per_thread
+fi
+
+if [ $paranoia -gt 0 ]; then
+	echo check_per_die test skipped because of paranoia level.
+else
+	check_per_die()
+	{
+		perf stat -x, --per-die -a 2>&1 sleep 1 | \
+		python $pythonchecker --per-die --separator
+	}
+	check_per_die
+fi
+
+if [ $paranoia -gt 0 ]; then
+	echo check_per_node test skipped because of paranoia level.
+else
+	check_per_node()
+	{
+		perf stat -x, --per-node -a 2>&1 sleep 1 | \
+		python $pythonchecker --per-node --separator
+	}
+	check_per_node
+fi
+
+if [ $paranoia -gt 0 ]; then
+	echo check_per_socket test skipped because of paranoia level.
+else
+	check_per_socket()
+	{
+		perf stat -x, --per-socket -a 2>&1 sleep 1 | \
+		python $pythonchecker --per-socket --separator
+	}
+	check_per_socket
+fi
+
+check_no_args
+check_interval
+check_all_cpus_no_aggr
+check_event
+
+exit 0
-- 
2.33.0.rc1.237.g0d66db33f3-goog

