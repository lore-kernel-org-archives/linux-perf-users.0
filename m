Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C53BC6FD1D
	for <linux-perf-users@archiver.kernel.org>; Tue,  4 Apr 2023 17:12:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235428AbjDDRMZ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 4 Apr 2023 13:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233419AbjDDRMU (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 4 Apr 2023 13:12:20 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADA00114
        for <linux-perf-users@vger.kernel.org>; Tue,  4 Apr 2023 10:12:17 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id b124-20020a253482000000b00b72947f6a54so32832586yba.14
        for <linux-perf-users@vger.kernel.org>; Tue, 04 Apr 2023 10:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680628336;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TZONwuqfItcGVp6ITohrbP5GvIwso+WspPhpgQVUWFg=;
        b=W9DzcaWbsqGV6JKzrXRHYQPMdFleapDXPqFoe14TCXv359/DzhO8f3ebiZdgv0Hcz/
         ErwnwONx0IYpQrI8jtttQBHfcvULdWUtJpMbqWKuVObzPzyFpVuH6C4Av/HroCs4LYm5
         Ru+pAQqS+/Joz3KscMc69nl4Mu74lc06nVLAdrgURca+B0lE7yXYABWfW5Vpz8hCokeC
         pT7IigDpQC7gBdaHJxgJJDT9q8KV1SI5mXWl3x+CWl7rt4aimbLB+oyx+VpWlgJSxIwf
         4m3XDuVtZITr0/Lb72UVlicvRk3T+N0SwU5SAEJj0a3WEyKWQswa7Dg6LxAIiVACAy9D
         I8Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680628336;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TZONwuqfItcGVp6ITohrbP5GvIwso+WspPhpgQVUWFg=;
        b=ZkcBqhBJ/NBSZvKIXURFJnOuuQzy9fg58OHH/KhJdOFp/tQD+6OJFttrQfmla7jty2
         CFGras8zNcjDYl+fA2AJcv+PtEPBhi9BEkbDuwm9glBfP5s2lEbe6QyWbMfZBX2IJnxM
         +VXxU9u8R/EdqiUFfi6CddPYyEVr2PzAnfb8ztsQTThXmospmEuZpZjNUpWG+jqA2oGx
         H861+3bGNt3BiXWHZYt1b0s4chmsduqn3oEN66has1QHbAChVwuFsyBhuH89f9lZhLm6
         PTTjTk+RR3v0i+jgtJnETjTR4Tr/c576cUYFPCXOqW2XZKZ8hnM3MMdwcYQ7YgcdoC2R
         xQeA==
X-Gm-Message-State: AAQBX9el4f+w/2b6N8n9XEDWom5oeMIHOwTLSMG9nCqi3KMb7dEneUti
        MvQOG8sERR9tXIhgahNHQrEjeYwcZWbj
X-Google-Smtp-Source: AKy350YR13RjzF9oXsel9DCut3UHkS8UYtfrSXqifFrFSAqyeKLVe6/4DMQ/XFVHaOJxItrFv8Jjw26rR7V/
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:a051:e074:d6f:dc29])
 (user=irogers job=sendgmr) by 2002:a25:d8d1:0:b0:b82:410e:daab with SMTP id
 p200-20020a25d8d1000000b00b82410edaabmr2357660ybg.8.1680628336683; Tue, 04
 Apr 2023 10:12:16 -0700 (PDT)
Date:   Tue,  4 Apr 2023 10:11:46 -0700
In-Reply-To: <20230404171146.2018616-1-irogers@google.com>
Message-Id: <20230404171146.2018616-3-irogers@google.com>
Mime-Version: 1.0
References: <20230404171146.2018616-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Subject: [PATCH v1 3/3] perf test: Write Json output to a file
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Claire Jensen <cjense@google.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Write the Json output to a file, then sanity check this output. This
avoids problems with debug/warning/error output corrupting the file
format.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../tests/shell/lib/perf_json_output_lint.py  |  3 +-
 tools/perf/tests/shell/stat+json_output.sh    | 48 ++++++++++++++-----
 2 files changed, 38 insertions(+), 13 deletions(-)

diff --git a/tools/perf/tests/shell/lib/perf_json_output_lint.py b/tools/perf/tests/shell/lib/perf_json_output_lint.py
index 97598d14e532..61f3059ca54b 100644
--- a/tools/perf/tests/shell/lib/perf_json_output_lint.py
+++ b/tools/perf/tests/shell/lib/perf_json_output_lint.py
@@ -17,9 +17,10 @@ ap.add_argument('--per-thread', action='store_true')
 ap.add_argument('--per-die', action='store_true')
 ap.add_argument('--per-node', action='store_true')
 ap.add_argument('--per-socket', action='store_true')
+ap.add_argument('--file', type=argparse.FileType('r'), default=sys.stdin)
 args = ap.parse_args()
 
-Lines = sys.stdin.readlines()
+Lines = args.file.readlines()
 
 def isfloat(num):
   try:
diff --git a/tools/perf/tests/shell/stat+json_output.sh b/tools/perf/tests/shell/stat+json_output.sh
index 2c4212c641ed..ecb015ac7c85 100755
--- a/tools/perf/tests/shell/stat+json_output.sh
+++ b/tools/perf/tests/shell/stat+json_output.sh
@@ -23,6 +23,20 @@ then
 	fi
 fi
 
+stat_output=$(mktemp /tmp/__perf_test.stat_output.XXXXX.json)
+
+cleanup() {
+  rm -f "${stat_output}"
+
+  trap - EXIT TERM INT
+}
+
+trap_cleanup() {
+  cleanup
+  exit 1
+}
+trap trap_cleanup EXIT TERM INT
+
 # Return true if perf_event_paranoid is > $1 and not running as root.
 function ParanoidAndNotRoot()
 {
@@ -32,7 +46,8 @@ function ParanoidAndNotRoot()
 check_no_args()
 {
 	echo -n "Checking json output: no args "
-	perf stat -j true 2>&1 | $PYTHON $pythonchecker --no-args
+	perf stat -j -o "${stat_output}" true
+	$PYTHON $pythonchecker --no-args --file "${stat_output}"
 	echo "[Success]"
 }
 
@@ -44,27 +59,29 @@ check_system_wide()
 		echo "[Skip] paranoia and not root"
 		return
 	fi
-	perf stat -j -a true 2>&1 | $PYTHON $pythonchecker --system-wide
+	perf stat -j -a -o "${stat_output}" true
+	$PYTHON $pythonchecker --system-wide --file "${stat_output}"
 	echo "[Success]"
 }
 
 check_system_wide_no_aggr()
 {
-	echo -n "Checking json output: system wide "
+	echo -n "Checking json output: system wide no aggregation "
 	if ParanoidAndNotRoot 0
 	then
 		echo "[Skip] paranoia and not root"
 		return
 	fi
-	echo -n "Checking json output: system wide no aggregation "
-	perf stat -j -A -a --no-merge true 2>&1 | $PYTHON $pythonchecker --system-wide-no-aggr
+	perf stat -j -A -a --no-merge -o "${stat_output}" true
+	$PYTHON $pythonchecker --system-wide-no-aggr --file "${stat_output}"
 	echo "[Success]"
 }
 
 check_interval()
 {
 	echo -n "Checking json output: interval "
-	perf stat -j -I 1000 true 2>&1 | $PYTHON $pythonchecker --interval
+	perf stat -j -I 1000 -o "${stat_output}" true
+	$PYTHON $pythonchecker --interval --file "${stat_output}"
 	echo "[Success]"
 }
 
@@ -72,7 +89,8 @@ check_interval()
 check_event()
 {
 	echo -n "Checking json output: event "
-	perf stat -j -e cpu-clock true 2>&1 | $PYTHON $pythonchecker --event
+	perf stat -j -e cpu-clock -o "${stat_output}" true
+	$PYTHON $pythonchecker --event --file "${stat_output}"
 	echo "[Success]"
 }
 
@@ -84,7 +102,8 @@ check_per_core()
 		echo "[Skip] paranoia and not root"
 		return
 	fi
-	perf stat -j --per-core -a true 2>&1 | $PYTHON $pythonchecker --per-core
+	perf stat -j --per-core -a -o "${stat_output}" true
+	$PYTHON $pythonchecker --per-core --file "${stat_output}"
 	echo "[Success]"
 }
 
@@ -96,7 +115,8 @@ check_per_thread()
 		echo "[Skip] paranoia and not root"
 		return
 	fi
-	perf stat -j --per-thread -a true 2>&1 | $PYTHON $pythonchecker --per-thread
+	perf stat -j --per-thread -a -o "${stat_output}" true
+	$PYTHON $pythonchecker --per-thread --file "${stat_output}"
 	echo "[Success]"
 }
 
@@ -108,7 +128,8 @@ check_per_die()
 		echo "[Skip] paranoia and not root"
 		return
 	fi
-	perf stat -j --per-die -a true 2>&1 | $PYTHON $pythonchecker --per-die
+	perf stat -j --per-die -a -o "${stat_output}" true
+	$PYTHON $pythonchecker --per-die --file "${stat_output}"
 	echo "[Success]"
 }
 
@@ -120,7 +141,8 @@ check_per_node()
 		echo "[Skip] paranoia and not root"
 		return
 	fi
-	perf stat -j --per-node -a true 2>&1 | $PYTHON $pythonchecker --per-node
+	perf stat -j --per-node -a -o "${stat_output}" true
+	$PYTHON $pythonchecker --per-node --file "${stat_output}"
 	echo "[Success]"
 }
 
@@ -132,7 +154,8 @@ check_per_socket()
 		echo "[Skip] paranoia and not root"
 		return
 	fi
-	perf stat -j --per-socket -a true 2>&1 | $PYTHON $pythonchecker --per-socket
+	perf stat -j --per-socket -a -o "${stat_output}" true
+	$PYTHON $pythonchecker --per-socket --file "${stat_output}"
 	echo "[Success]"
 }
 
@@ -179,4 +202,5 @@ then
 else
 	echo "[Skip] Skipping tests for system_wide_no_aggr, per_core, per_die and per_socket since socket id exposed via topology is invalid"
 fi
+cleanup
 exit 0
-- 
2.40.0.348.gf938b09366-goog

