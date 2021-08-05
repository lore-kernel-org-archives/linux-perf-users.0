Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8127FC4338F
	for <linux-perf-users@archiver.kernel.org>; Thu,  5 Aug 2021 17:14:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6420361102
	for <linux-perf-users@archiver.kernel.org>; Thu,  5 Aug 2021 17:14:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237497AbhHERO7 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 5 Aug 2021 13:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232651AbhHERO7 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 5 Aug 2021 13:14:59 -0400
Received: from mail-io1-xd49.google.com (mail-io1-xd49.google.com [IPv6:2607:f8b0:4864:20::d49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18668C0613D5
        for <linux-perf-users@vger.kernel.org>; Thu,  5 Aug 2021 10:14:45 -0700 (PDT)
Received: by mail-io1-xd49.google.com with SMTP id k20-20020a6b6f140000b029053817be16cdso4079734ioc.3
        for <linux-perf-users@vger.kernel.org>; Thu, 05 Aug 2021 10:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=INEvP19P6WTC1AGBfQEXR3fV4WN5Ayl4veWqJISDaiQ=;
        b=N5Xwt3ZG+nWnvK2mcmtPCia+NEMrO/oyV9+aumLMqiwAqGkw4QI8GvxplQK6fHVJav
         kNgbLjymnv+CuALFDDkIO4a++gcamdQnr2Dkg5R3JrOe0eliBSerFwHKOFEn0kIVGsZ1
         aoplmPoGEY/VhgPWpEmQ2oA/sS/4i6v9WmyNWfrKpEhrO6cMyHijHgU1bamG8usON3kW
         eJMnUdNaJDzNB8OolugGcYngJRH09yucB/M5KH6zHHv0wPB6Jz7/+FSslvRYTArBYctl
         SOcaOQ2KrTzYNznABfgFE16XvHO9MutE6sg6C08bAmJ4++Ov+xj0KLIOOhSWCYnKbsqC
         OzFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=INEvP19P6WTC1AGBfQEXR3fV4WN5Ayl4veWqJISDaiQ=;
        b=AtblGneyfDHzWNLDpppS9vKnuLen2zt9AWjOGrsq+piP3+LRQAcupj6wXMb+d2XZsF
         pATNBV8F/caU9k/TZJ+kbb4tha2DdWC8wT2DdNsYHtVvXsA8mRpxbdaEkqbzGLkD5TCR
         u3KtRI+pR4kH8VfFiQHJdfkxh8D62GA1U3RmRr1DFHJB82Cko4TIN1AXagMBrx5dO7hf
         iDRPJPgiuu/X4v/4eOyLTNvchKW7qBitgeHkUtanOVw5ofUs+2afEZyRUkc170DfHK7u
         90+gFqW7J5kefcUpne+koByp3URWy6FezulPAYZZPr1QMvM1ZMhUBy/XwfAEHrU5q3bh
         jsLQ==
X-Gm-Message-State: AOAM531H3xGcKtM9qIhBfadQ6+SJ7B8k/0/asXGs6kVtMlcYKcbc1XzN
        Cv37Ft8TSRhuhJ4cOSaI3V3ei7LBgcsgjctySc2ACz0aYleq5a+ZXCofeQ0vP0WWFulhwNEaSyQ
        Z/28BK2OxKROKXbXsM8cdg4wYx2puLmMOY+OdwyTP38P4ak2UCTzY/TQnLnuYRnSdnwlLLxueD2
        4=
X-Google-Smtp-Source: ABdhPJycgyaIlPUs35dwX8nRQZnNTy7oj/KlyZ/36c1VHTFdVZE4GKQN3/BTFvSouM1sUdjmwALZwxmSflg=
X-Received: from cjense.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:6d0])
 (user=cjense job=sendgmr) by 2002:a5d:97cc:: with SMTP id k12mr183182ios.4.1628183684323;
 Thu, 05 Aug 2021 10:14:44 -0700 (PDT)
Date:   Thu,  5 Aug 2021 17:14:31 +0000
Message-Id: <20210805171431.940897-1-cjense@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.605.g8dce9f2422-goog
Subject: [PATCH 1/1] perf test: Add test for CSV output.
From:   Claire Jensen <cjense@google.com>
To:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, irogers@google.com,
        eranian@google.com
Cc:     Claire Jensen <cjense@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Add field checking tests for perf stat CSV output. Counts expected
fields for various commands. No testing added for summary mode
since it is broken.

An example of the summary output is:

         summary,263831,,instructions:u,1435072,100.0,0.46,insn per cycle
,,,,,1.37,stalled cycles per insn

This should be:

         summary,263831,,instructions:u,1435072,100.0,0.46,insn per cycle
         summary,,,,,,1.37,stalled cycles per insn

The output has 7 fields when it should have 8. Additionally, the newline
spacing is wrong, so it was excluded from testing until a fix is made.
---
 .../tests/shell/lib/perf_csv_output_lint.py   |  55 ++++++++
 tools/perf/tests/shell/stat+csv_output.sh     | 117 ++++++++++++++++++
 2 files changed, 172 insertions(+)
 create mode 100644 tools/perf/tests/shell/lib/perf_csv_output_lint.py
 create mode 100644 tools/perf/tests/shell/stat+csv_output.sh

diff --git a/tools/perf/tests/shell/lib/perf_csv_output_lint.py b/tools/perf/tests/shell/lib/perf_csv_output_lint.py
new file mode 100644
index 000000000000..ef8a32c3523c
--- /dev/null
+++ b/tools/perf/tests/shell/lib/perf_csv_output_lint.py
@@ -0,0 +1,55 @@
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
+
+
+
+
diff --git a/tools/perf/tests/shell/stat+csv_output.sh b/tools/perf/tests/shell/stat+csv_output.sh
new file mode 100644
index 000000000000..282f9547e7be
--- /dev/null
+++ b/tools/perf/tests/shell/stat+csv_output.sh
@@ -0,0 +1,117 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+# perf stat csv output test
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
+if [ $paranoia -gt 0 ];
+then
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
+if [ $paranoia -gt 0 ];
+then
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
+if [ $paranoia -gt 0 ];
+then
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
+if [ $paranoia -gt 0 ];
+then
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
+if [ $paranoia -gt 0 ];
+then
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
+if [ $paranoia -gt 0 ];
+then
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
+
-- 
2.32.0.605.g8dce9f2422-goog

