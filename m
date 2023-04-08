Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDBF3C77B61
	for <linux-perf-users@archiver.kernel.org>; Sat,  8 Apr 2023 05:45:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbjDHFpV (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 8 Apr 2023 01:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjDHFpU (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 8 Apr 2023 01:45:20 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF1FD53C
        for <linux-perf-users@vger.kernel.org>; Fri,  7 Apr 2023 22:45:19 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 67-20020a250146000000b00b714602d43fso545814ybb.10
        for <linux-perf-users@vger.kernel.org>; Fri, 07 Apr 2023 22:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680932719;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EpEz085JU7twaA0xGBNJklGbins3FjmOEhAY5KBr3hI=;
        b=KX2nA++HX1KtLQzej5YBbVPTkbE3T1gnenqquuDJ2qtt+CUull9c2B8fVVEmExmX99
         CSNC3nqulopcPSfCbsuheSVCHmzmIFD8JmkBkaPnuSHVpDp9LrnblUEO1loWbt+0wVIb
         CJJyrq0r80zRc+79hkIHzxWZUNhQyG9k4AElW/LKaMwnA+m+lvzhS8+ZTPd8bocES3kg
         swaa/mj7Ro3IVQwh1KgPM4gc5YPYZARHjCaSIz5v0kGH51gm8E/xeAjXpOe2M3nw9vRs
         RKWUTzXcCTRiMEIgiynJxVDqQuPbnt30aY2RQf/d6GUjlGA+CW11YBQrlMOPIe95+oBv
         rcXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680932719;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EpEz085JU7twaA0xGBNJklGbins3FjmOEhAY5KBr3hI=;
        b=Z1G19/mZeBOrsdrx8KIqLzA3iW7zhJJv5s4F6xYnKHAwfGJYTz4+va2A8cSXbqfkUH
         HKqH9FfJtTKncpdvHMAyLzyMLFJKhFoyTdJuRh9VfaTO+eizvid4BJGwMTVBpDsRI9rX
         BHH1loHSyolPjU7LDcVUtcfI5nHAARI3M/nKmUkJnD96CO4azP/tsQeU6EDi/eQzPp6j
         BT48eAzEJny/rMnZNLUP+RxZ/pFf+yPBX8e5cwc8iGsOoEcuG23p1WlroM4QZFqEMII5
         MaGqCbDeHklJBtmth8j5grSWLqYVlBEeLFqtYU0LxE6fmuayj5hx6Scv2mhr0mQ8dqZm
         UqIQ==
X-Gm-Message-State: AAQBX9fUHinEgldP3cLdcZOcr4sTf2vDgUoDH9UnW4NuTYY+zcINemRn
        rAbRllg2rwf9oHNKcKLvC4XGFgYFVLzB
X-Google-Smtp-Source: AKy350YHG89dcL0LW8jDIaMdapMaJt8Pm+V6JOzkUoIEH2EQ7B0swQ3wTeEOrFVYfl+iG6y0ejpZ2yNxwEg5
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:b240:9cdf:7861:b23e])
 (user=irogers job=sendgmr) by 2002:a81:b184:0:b0:545:f7cc:f30 with SMTP id
 p126-20020a81b184000000b00545f7cc0f30mr563386ywh.0.1680932718987; Fri, 07 Apr
 2023 22:45:18 -0700 (PDT)
Date:   Fri,  7 Apr 2023 22:44:54 -0700
In-Reply-To: <20230408054456.3001367-1-irogers@google.com>
Message-Id: <20230408054456.3001367-2-irogers@google.com>
Mime-Version: 1.0
References: <20230408054456.3001367-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
Subject: [PATCH v2 1/3] perf test: Write CSV output to a file
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
        Thomas Richter <tmricht@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Write the CSV output to a file, then sanity check this output. This
avoids problems with debug/warning/error output corrupting the file
format.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/stat+csv_output.sh | 58 ++++++++++++++++-------
 1 file changed, 42 insertions(+), 16 deletions(-)

diff --git a/tools/perf/tests/shell/stat+csv_output.sh b/tools/perf/tests/shell/stat+csv_output.sh
index 324fc9e6edd7..fb78b6251a4e 100755
--- a/tools/perf/tests/shell/stat+csv_output.sh
+++ b/tools/perf/tests/shell/stat+csv_output.sh
@@ -9,6 +9,20 @@ set -e
 skip_test=0
 csv_sep=@
 
+stat_output=$(mktemp /tmp/__perf_test.stat_output.csv.XXXXX)
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
 function commachecker()
 {
 	local -i cnt=0
@@ -30,9 +44,11 @@ function commachecker()
 
 	while read line
 	do
-		# Check for lines beginning with Failed
-		x=${line:0:6}
-		[ "$x" = "Failed" ] && continue
+		# Ignore initial "started on" comment.
+		x=${line:0:1}
+		[ "$x" = "#" ] && continue
+		# Ignore initial blank line.
+		[ "$line" = "" ] && continue
 
 		# Count the number of commas
 		x=$(echo $line | tr -d -c $csv_sep)
@@ -42,7 +58,7 @@ function commachecker()
 			echo "wrong number of fields. expected $exp in $line" 1>&2
 			exit 1;
 		}
-	done
+	done < "${stat_output}"
 	return 0
 }
 
@@ -55,7 +71,8 @@ function ParanoidAndNotRoot()
 check_no_args()
 {
 	echo -n "Checking CSV output: no args "
-	perf stat -x$csv_sep true 2>&1 | commachecker --no-args
+	perf stat -x$csv_sep -o "${stat_output}" true
+        commachecker --no-args
 	echo "[Success]"
 }
 
@@ -67,27 +84,29 @@ check_system_wide()
 		echo "[Skip] paranoid and not root"
 		return
 	fi
-	perf stat -x$csv_sep -a true 2>&1 | commachecker --system-wide
+	perf stat -x$csv_sep -a -o "${stat_output}" true
+        commachecker --system-wide
 	echo "[Success]"
 }
 
 check_system_wide_no_aggr()
 {
-	echo -n "Checking CSV output: system wide "
+	echo -n "Checking CSV output: system wide no aggregation "
 	if ParanoidAndNotRoot 0
 	then
 		echo "[Skip] paranoid and not root"
 		return
 	fi
-	echo -n "Checking CSV output: system wide no aggregation "
-	perf stat -x$csv_sep -A -a --no-merge true 2>&1 | commachecker --system-wide-no-aggr
+	perf stat -x$csv_sep -A -a --no-merge -o "${stat_output}" true
+        commachecker --system-wide-no-aggr
 	echo "[Success]"
 }
 
 check_interval()
 {
 	echo -n "Checking CSV output: interval "
-	perf stat -x$csv_sep -I 1000 true 2>&1 | commachecker --interval
+	perf stat -x$csv_sep -I 1000 -o "${stat_output}" true
+        commachecker --interval
 	echo "[Success]"
 }
 
@@ -95,7 +114,8 @@ check_interval()
 check_event()
 {
 	echo -n "Checking CSV output: event "
-	perf stat -x$csv_sep -e cpu-clock true 2>&1 | commachecker --event
+	perf stat -x$csv_sep -e cpu-clock -o "${stat_output}" true
+        commachecker --event
 	echo "[Success]"
 }
 
@@ -107,7 +127,8 @@ check_per_core()
 		echo "[Skip] paranoid and not root"
 		return
 	fi
-	perf stat -x$csv_sep --per-core -a true 2>&1 | commachecker --per-core
+	perf stat -x$csv_sep --per-core -a -o "${stat_output}" true
+        commachecker --per-core
 	echo "[Success]"
 }
 
@@ -119,7 +140,8 @@ check_per_thread()
 		echo "[Skip] paranoid and not root"
 		return
 	fi
-	perf stat -x$csv_sep --per-thread -a true 2>&1 | commachecker --per-thread
+	perf stat -x$csv_sep --per-thread -a -o "${stat_output}" true
+        commachecker --per-thread
 	echo "[Success]"
 }
 
@@ -131,7 +153,8 @@ check_per_die()
 		echo "[Skip] paranoid and not root"
 		return
 	fi
-	perf stat -x$csv_sep --per-die -a true 2>&1 | commachecker --per-die
+	perf stat -x$csv_sep --per-die -a -o "${stat_output}" true
+        commachecker --per-die
 	echo "[Success]"
 }
 
@@ -143,7 +166,8 @@ check_per_node()
 		echo "[Skip] paranoid and not root"
 		return
 	fi
-	perf stat -x$csv_sep --per-node -a true 2>&1 | commachecker --per-node
+	perf stat -x$csv_sep --per-node -a -o "${stat_output}" true
+        commachecker --per-node
 	echo "[Success]"
 }
 
@@ -155,7 +179,8 @@ check_per_socket()
 		echo "[Skip] paranoid and not root"
 		return
 	fi
-	perf stat -x$csv_sep --per-socket -a true 2>&1 | commachecker --per-socket
+	perf stat -x$csv_sep --per-socket -a -o "${stat_output}" true
+        commachecker --per-socket
 	echo "[Success]"
 }
 
@@ -202,4 +227,5 @@ then
 else
 	echo "[Skip] Skipping tests for system_wide_no_aggr, per_core, per_die and per_socket since socket id exposed via topology is invalid"
 fi
+cleanup
 exit 0
-- 
2.40.0.577.gac1e443424-goog

