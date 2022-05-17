Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77C2BC433FE
	for <linux-perf-users@archiver.kernel.org>; Tue, 17 May 2022 21:59:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbiEQV7q (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 17 May 2022 17:59:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbiEQV7a (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 17 May 2022 17:59:30 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94B3F5133F
        for <linux-perf-users@vger.kernel.org>; Tue, 17 May 2022 14:59:28 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2fecfc7a95aso3896847b3.22
        for <linux-perf-users@vger.kernel.org>; Tue, 17 May 2022 14:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=bHIfvp4h5+ssKuj8eNqRd5kt2hjUb/pDEBzybkniKr0=;
        b=Xr6OSICeeW3nG+Y6QMPT7KOMogW9es5BLqnQs017TEHoLAU0f67AFrjOhcZ+Iosxgx
         TIxeNDdvIyhcNB0W6vy1dnfQC7Wozuglb3StACTeorBLL3SQxGcljpMA74L0LgqNZStE
         ubB1I0A27dMDisMm4HlP7sAXuicN7EUq2w3PHhAZ76IrA3hhkpybDL/LOsSo9wlpb6+j
         qze9bol4YVEoHT2idSbfQmkEI+hTLAvvq5h+6ZgDwCnWrZHsbDCGZBAkTpQoSE15BEVX
         iS3yUr1Q8LbBtDDnESCeuwoqodbSR0zEn/ZITEuTF/25UatsyyBE4UdpE1LYPmCYy15I
         2WJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=bHIfvp4h5+ssKuj8eNqRd5kt2hjUb/pDEBzybkniKr0=;
        b=JX5+GpzQ/VUAIsg1eLpkR9QieV7Co72tr7kKES8G6fOGkIwiRDvEvJoaaviM6CIAur
         mnqM8YieRxllkWbMjsFinhzDAqfuDIoz6uNArpFWRFHwpOHAqvg3v6z0qwKtZBR7DVs+
         WeJZnFv47t3sm7JANjxjEU6jmPB/9ECefJcB+E1cac1wk6rSLE006LH/GxG7WbGFUQ10
         8q99NlEjTwywfyKEgGPR5bLatBF3dE/PqcQRi1Z37TZUIkkSKCU9sCzmdJ71Sn8esIwR
         0LiRHVN8VmeYwKgSKswmKalzdeZIUGUjAQ7LB+zn8VAsl77uxiN99EzqpdI+tPnohFrl
         vP9Q==
X-Gm-Message-State: AOAM531bgF8xN2ximWpc/kW3cVenvT1LxAnhmfQaGcNKdE6X4c0uc3Dh
        yzoKiPDTP1cwHdpkWLmWnYlugeaBev4e
X-Google-Smtp-Source: ABdhPJw3JcqolGpOdZgevIZVMTmUfmg4eTYIvxXlWvKMxmhlJTlifkppTSD2lsZQjr/E4mc3ncVBvk64P0hR
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:a5a1:af73:fe09:fd5])
 (user=irogers job=sendgmr) by 2002:a5b:2c5:0:b0:64b:1219:9156 with SMTP id
 h5-20020a5b02c5000000b0064b12199156mr24485524ybp.115.1652824767738; Tue, 17
 May 2022 14:59:27 -0700 (PDT)
Date:   Tue, 17 May 2022 14:59:17 -0700
In-Reply-To: <20220517215917.692906-1-irogers@google.com>
Message-Id: <20220517215917.692906-4-irogers@google.com>
Mime-Version: 1.0
References: <20220517215917.692906-1-irogers@google.com>
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
Subject: [PATCH v3 3/3] perf test: Json format checking
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

Add field checking tests for perf stat JSON output.
Sanity checks the expected number of fields are present, that the
expected keys are present and they have the correct values.

Signed-off-by: Claire Jensen <cjense@google.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../tests/shell/lib/perf_json_output_lint.py  |  91 +++++++++++
 tools/perf/tests/shell/stat+json_output.sh    | 147 ++++++++++++++++++
 2 files changed, 238 insertions(+)
 create mode 100644 tools/perf/tests/shell/lib/perf_json_output_lint.py
 create mode 100755 tools/perf/tests/shell/stat+json_output.sh

diff --git a/tools/perf/tests/shell/lib/perf_json_output_lint.py b/tools/perf/tests/shell/lib/perf_json_output_lint.py
new file mode 100644
index 000000000000..c3ed2624f8f5
--- /dev/null
+++ b/tools/perf/tests/shell/lib/perf_json_output_lint.py
@@ -0,0 +1,91 @@
+#!/usr/bin/python
+# SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
+# Basic sanity check of perf JSON output as specified in the man page.
+
+import argparse
+import sys
+import json
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
+args = ap.parse_args()
+
+Lines = sys.stdin.readlines()
+
+def isfloat(num):
+  try:
+    float(num)
+    return True
+  except ValueError:
+    return False
+
+
+def isint(num):
+  try:
+    int(num)
+    return True
+  except ValueError:
+    return False
+
+def is_counter_value(num):
+  return isfloat(num) or num == '<not counted>' or num == '<not supported>'
+
+def check_json_output(expected_items):
+  if expected_items != -1:
+    for line in Lines:
+      if 'failed' not in line:
+        count = 0
+        count = line.count(',')
+        if count != expected_items:
+          raise RuntimeError('wrong number of fields. counted {0}'
+                             ' expected {1} in {2}\n'.format(count, exp, line))
+  checks = {
+      'aggregate-number': lambda x: isfloat(x),
+      'core': lambda x: True,
+      'counter-value': lambda x: is_counter_value(x),
+      'cgroup': lambda x: True,
+      'cpu': lambda x: isint(x),
+      'die': lambda x: True,
+      'event': lambda x: True,
+      'event-runtime': lambda x: isfloat(x),
+      'interval': lambda x: isfloat(x),
+      'metric-unit': lambda x: True,
+      'metric-value': lambda x: isfloat(x),
+      'node': lambda x: True,
+      'pcnt-running': lambda x: isfloat(x),
+      'socket': lambda x: True,
+      'thread': lambda x: True,
+      'unit': lambda x: True,
+  }
+  input = '[\n' + ','.join(Lines) + '\n]'
+  for item in json.loads(input):
+    for key, value in item.items():
+      if key not in checks:
+        raise RuntimeError(f'Unexpected key: key={key} value={value}')
+      if not checks[key](value):
+        raise RuntimeError(f'Check failed for: key={key} value={value}')
+
+
+try:
+  if args.no_args or args.system_wide or args.event:
+    expected_items = 6
+  elif args.interval or args.per_thread or args.system_wide_no_aggr:
+    expected_items = 7
+  elif args.per_core or args.per_socket or args.per_node or args.per_die:
+    expected_items = 8
+  else:
+    # If no option is specified, don't check the number of items.
+    expected_items = -1
+  check_json_output(expected_items)
+except:
+  print('Test failed for input:\n' + '\n'.join(Lines))
+  raise
diff --git a/tools/perf/tests/shell/stat+json_output.sh b/tools/perf/tests/shell/stat+json_output.sh
new file mode 100755
index 000000000000..7748b677f2f9
--- /dev/null
+++ b/tools/perf/tests/shell/stat+json_output.sh
@@ -0,0 +1,147 @@
+#!/bin/bash
+# perf stat JSON output linter
+# SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
+# Checks various perf stat JSON output commands for the
+# correct number of fields.
+
+set -e
+
+pythonchecker=$(dirname $0)/lib/perf_json_output_lint.py
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
+	echo -n "Checking json output: no args "
+	perf stat -j true 2>&1 | $PYTHON $pythonchecker --no-args
+	echo "[Success]"
+}
+
+check_system_wide()
+{
+	echo -n "Checking json output: system wide "
+	if ParanoidAndNotRoot 0
+	then
+		echo "[Skip] parnoia and not root"
+		return
+	fi
+	perf stat -j -a true 2>&1 | $PYTHON $pythonchecker --system-wide
+	echo "[Success]"
+}
+
+check_system_wide_no_aggr()
+{
+	echo -n "Checking json output: system wide "
+	if ParanoidAndNotRoot 0
+	then
+		echo "[Skip] parnoia and not root"
+		return
+	fi
+	echo -n "Checking json output: system wide no aggregation "
+	perf stat -j -A -a --no-merge true 2>&1 | $PYTHON $pythonchecker --system-wide-no-aggr
+	echo "[Success]"
+}
+
+check_interval()
+{
+	echo -n "Checking json output: interval "
+	perf stat -j -I 1000 true 2>&1 | $PYTHON $pythonchecker --interval
+	echo "[Success]"
+}
+
+
+check_event()
+{
+	echo -n "Checking json output: event "
+	perf stat -j -e cpu-clock true 2>&1 | $PYTHON $pythonchecker --event
+	echo "[Success]"
+}
+
+check_per_core()
+{
+	echo -n "Checking json output: per core "
+	if ParanoidAndNotRoot 0
+	then
+		echo "[Skip] parnoia and not root"
+		return
+	fi
+	perf stat -j --per-core -a true 2>&1 | $PYTHON $pythonchecker --per-core
+	echo "[Success]"
+}
+
+check_per_thread()
+{
+	echo -n "Checking json output: per thread "
+	if ParanoidAndNotRoot 0
+	then
+		echo "[Skip] parnoia and not root"
+		return
+	fi
+	perf stat -j --per-thread -a true 2>&1 | $PYTHON $pythonchecker --per-thread
+	echo "[Success]"
+}
+
+check_per_die()
+{
+	echo -n "Checking json output: per die "
+	if ParanoidAndNotRoot 0
+	then
+		echo "[Skip] parnoia and not root"
+		return
+	fi
+	perf stat -j --per-die -a true 2>&1 | $PYTHON $pythonchecker --per-die
+	echo "[Success]"
+}
+
+check_per_node()
+{
+	echo -n "Checking json output: per node "
+	if ParanoidAndNotRoot 0
+	then
+		echo "[Skip] parnoia and not root"
+		return
+	fi
+	perf stat -j --per-node -a true 2>&1 | $PYTHON $pythonchecker --per-node
+	echo "[Success]"
+}
+
+check_per_socket()
+{
+	echo -n "Checking json output: per socket "
+	if ParanoidAndNotRoot 0
+	then
+		echo "[Skip] parnoia and not root"
+		return
+	fi
+	perf stat -j --per-socket -a true 2>&1 | $PYTHON $pythonchecker --per-socket
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

