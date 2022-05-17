Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19AC5C433EF
	for <linux-perf-users@archiver.kernel.org>; Tue, 17 May 2022 21:59:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbiEQV71 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 17 May 2022 17:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbiEQV7Z (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 17 May 2022 17:59:25 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A8C251336
        for <linux-perf-users@vger.kernel.org>; Tue, 17 May 2022 14:59:24 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2d11b6259adso4028517b3.19
        for <linux-perf-users@vger.kernel.org>; Tue, 17 May 2022 14:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=fvU+Gi72lI7UuLvKQmm5tyEVTfbTBpYfMrJxtkdVrUA=;
        b=f30fLm4axkE9Tg2UZ4RPiyaL8QLq/igCFboReOI+Xd0A+ZEmX6UdxDREvFF21Ahj+S
         bFMyeP9vQ1EFFBvrVPai28qTk91yjFPBIGSpEeOVt6qACSpiylxyVuUy8wXRnT0Diekq
         ujisnbkf2WUZWU3UbctpU4nI1lhUGOOIlhUHemo+/aL1+EiJ9cmr56DQlmRx05j5buid
         ZtDE6pkRkFd457nS2oaO/vHK1uF86MJd8kPjuiBrmfb+KJvYwcs1ro4yZN+H0uT56paD
         gWtbMfYpnI3ce6dp3nTnSVWspwpboLShcSEQgdpcC086q/1mjsvl+OvL8tFf7oQI7ka8
         qJOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=fvU+Gi72lI7UuLvKQmm5tyEVTfbTBpYfMrJxtkdVrUA=;
        b=Wu6ZQwwMJACZPKLjHSqjcKpBUCErkeMv25Y14HuI3yZ0RY70pywSzlOZf9EUgL1fF7
         wN915dp3js2IAVL4GGvfXOdOagBPXBrWLrwx6NVwR6/BOtL6qQ0k+Y/K2ngSV0w1d4Gy
         0AFYOmc/DYkPBeY4WLq7Rnuu86x//wJ9jHnBv9FrYOhCF9bE5+VvqZ5Cv8TyqJn4CcxU
         HDwx0BbFfKpXj8QcO6AU/7ySMeDCbA4ZVZSNpyp1t2dWg3mbyEZwqetc75WjX+7BHBjJ
         zkycivnZOknkZ2N0gstV3Xtg+de+NDXD58Ld2b4Var28Mh+MaKTSAqA80dnV+Q2XBgBQ
         aZnA==
X-Gm-Message-State: AOAM533ia0/jseQHmEiCsZzBQqISNr6+nPamfV7NQMoyWcMYcBDoXqTd
        o9S7GdxurGWME26FHllJV9uPMfRVuJEd
X-Google-Smtp-Source: ABdhPJxrhKe03q6UYtG7QGmmWThKSCqDwWK021ZpxxRnLkqz8+7Root0CcPncxPBetdy58cTIHxg2DNdpx0s
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:a5a1:af73:fe09:fd5])
 (user=irogers job=sendgmr) by 2002:a0d:d801:0:b0:2fe:feb2:242a with SMTP id
 a1-20020a0dd801000000b002fefeb2242amr13162823ywe.127.1652824763346; Tue, 17
 May 2022 14:59:23 -0700 (PDT)
Date:   Tue, 17 May 2022 14:59:15 -0700
In-Reply-To: <20220517215917.692906-1-irogers@google.com>
Message-Id: <20220517215917.692906-2-irogers@google.com>
Mime-Version: 1.0
References: <20220517215917.692906-1-irogers@google.com>
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
Subject: [PATCH v3 1/3] perf test: Add checking for perf stat CSV output.
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Sandipan Das <sandipan.das@amd.com>,
        Claire Jensen <cjense@google.com>, Alyssa Ross <hi@alyssa.is>,
        Like Xu <likexu@tencent.com>,
        James Clark <james.clark@arm.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Claire Jensen <clairej735@gmail.com>
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

From: Claire Jensen <cjense@google.com>

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

Signed-off-by: Claire Jensen <cjense@google.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../tests/shell/lib/perf_csv_output_lint.py   |  48 ++++++
 tools/perf/tests/shell/stat+csv_output.sh     | 147 ++++++++++++++++++
 2 files changed, 195 insertions(+)
 create mode 100644 tools/perf/tests/shell/lib/perf_csv_output_lint.py
 create mode 100755 tools/perf/tests/shell/stat+csv_output.sh

diff --git a/tools/perf/tests/shell/lib/perf_csv_output_lint.py b/tools/perf/tests/shell/lib/perf_csv_output_lint.py
new file mode 100644
index 000000000000..714f283cfb1b
--- /dev/null
+++ b/tools/perf/tests/shell/lib/perf_csv_output_lint.py
@@ -0,0 +1,48 @@
+#!/usr/bin/python
+# SPDX-License-Identifier: GPL-2.0
+
+import argparse
+import sys
+
+# Basic sanity check of perf CSV output as specified in the man page.
+# Currently just checks the number of fields per line in output.
+
+ap = argparse.ArgumentParser()
+ap.add_argument('--no-args', action='store_true')
+ap.add_argument('--interval', action='store_true')
+ap.add_argument('--system-wide-no-aggr', action='store_true')
+ap.add_argument('--system-wide', action='store_true')
+ap.add_argument('--event', action='store_true')
+ap.add_argument('--per-core', action='store_true')
+ap.add_argument('--per-thread', action='store_true')
+ap.add_argument('--per-die', action='store_true')
+ap.add_argument('--per-node', action='store_true')
+ap.add_argument('--per-socket', action='store_true')
+ap.add_argument('--separator', default=',', nargs='?')
+args = ap.parse_args()
+
+Lines = sys.stdin.readlines()
+
+def check_csv_output(exp):
+  for line in Lines:
+    if 'failed' not in line:
+      count = line.count(args.separator)
+      if count != exp:
+        sys.stdout.write(''.join(Lines))
+        raise RuntimeError(f'wrong number of fields. expected {exp} in {line}')
+
+try:
+  if args.no_args or args.system_wide or args.event:
+    expected_items = 6
+  elif args.interval or args.per_thread or args.system_wide_no_aggr:
+    expected_items = 7
+  elif args.per_core or args.per_socket or args.per_node or args.per_die:
+    expected_items = 8
+  else:
+    ap.print_help()
+    raise RuntimeError('No checking option specified')
+  check_csv_output(expected_items)
+
+except:
+  sys.stdout.write('Test failed for input: ' + ''.join(Lines))
+  raise
diff --git a/tools/perf/tests/shell/stat+csv_output.sh b/tools/perf/tests/shell/stat+csv_output.sh
new file mode 100755
index 000000000000..82c25e9c7f21
--- /dev/null
+++ b/tools/perf/tests/shell/stat+csv_output.sh
@@ -0,0 +1,147 @@
+#!/bin/bash
+# perf stat CSV output linter
+# SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
+# Tests various perf stat CSV output commands for the
+# correct number of fields and the CSV separator set to ','.
+
+set -e
+
+pythonchecker=$(dirname $0)/lib/perf_csv_output_lint.py
+if [ "x$PYTHON" == "x" ]
+then
+	if which python3 > /dev/null
+	then
+		PYTHON=python3
+	elif which python > /dev/null
+	then
+		PYTHON=python
+	else
+		echo Skipping test, python not detected please set environment variable PYTHON.
+		exit 2
+	fi
+fi
+
+# Return true if perf_event_paranoid is > $1 and not running as root.
+function ParanoidAndNotRoot()
+{
+	 [ $(id -u) != 0 ] && [ $(cat /proc/sys/kernel/perf_event_paranoid) -gt $1 ]
+}
+
+check_no_args()
+{
+	echo -n "Checking CSV output: no args "
+	perf stat -x, true 2>&1 | $PYTHON $pythonchecker --no-args
+	echo "[Success]"
+}
+
+check_system_wide()
+{
+	echo -n "Checking CSV output: system wide "
+	if ParanoidAndNotRoot 0
+	then
+		echo "[Skip] parnoia and not root"
+		return
+	fi
+	perf stat -x, -a true 2>&1 | $PYTHON $pythonchecker --system-wide
+	echo "[Success]"
+}
+
+check_system_wide_no_aggr()
+{
+	echo -n "Checking CSV output: system wide "
+	if ParanoidAndNotRoot 0
+	then
+		echo "[Skip] parnoia and not root"
+		return
+	fi
+	echo -n "Checking CSV output: system wide no aggregation "
+	perf stat -x, -A -a --no-merge true 2>&1 | $PYTHON $pythonchecker --system-wide-no-aggr
+	echo "[Success]"
+}
+
+check_interval()
+{
+	echo -n "Checking CSV output: interval "
+	perf stat -x, -I 1000 true 2>&1 | $PYTHON $pythonchecker --interval
+	echo "[Success]"
+}
+
+
+check_event()
+{
+	echo -n "Checking CSV output: event "
+	perf stat -x, -e cpu-clock true 2>&1 | $PYTHON $pythonchecker --event
+	echo "[Success]"
+}
+
+check_per_core()
+{
+	echo -n "Checking CSV output: per core "
+	if ParanoidAndNotRoot 0
+	then
+		echo "[Skip] parnoia and not root"
+		return
+	fi
+	perf stat -x, --per-core -a true 2>&1 | $PYTHON $pythonchecker --per-core
+	echo "[Success]"
+}
+
+check_per_thread()
+{
+	echo -n "Checking CSV output: per thread "
+	if ParanoidAndNotRoot 0
+	then
+		echo "[Skip] parnoia and not root"
+		return
+	fi
+	perf stat -x, --per-thread -a true 2>&1 | $PYTHON $pythonchecker --per-thread
+	echo "[Success]"
+}
+
+check_per_die()
+{
+	echo -n "Checking CSV output: per die "
+	if ParanoidAndNotRoot 0
+	then
+		echo "[Skip] parnoia and not root"
+		return
+	fi
+	perf stat -x, --per-die -a true 2>&1 | $PYTHON $pythonchecker --per-die
+	echo "[Success]"
+}
+
+check_per_node()
+{
+	echo -n "Checking CSV output: per node "
+	if ParanoidAndNotRoot 0
+	then
+		echo "[Skip] parnoia and not root"
+		return
+	fi
+	perf stat -x, --per-node -a true 2>&1 | $PYTHON $pythonchecker --per-node
+	echo "[Success]"
+}
+
+check_per_socket()
+{
+	echo -n "Checking CSV output: per socket "
+	if ParanoidAndNotRoot 0
+	then
+		echo "[Skip] parnoia and not root"
+		return
+	fi
+	perf stat -x, --per-socket -a true 2>&1 | $PYTHON $pythonchecker --per-socket
+	echo "[Success]"
+}
+
+check_no_args
+check_system_wide
+check_system_wide_no_aggr
+check_interval
+check_event
+check_per_core
+check_per_thread
+check_per_die
+check_per_node
+check_per_socket
+exit 0
-- 
2.36.0.550.gb090851708-goog

