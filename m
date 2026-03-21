Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBBE01DF258
	for <linux-perf-users@vger.kernel.org>; Sat, 21 Mar 2026 06:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774073790; cv=none; b=Ls35+Wk8zOyjfzH7zUdtA9mrL1WRKv3xJIL7qQU3XKFwd4Z3MseH8EjxxKbCYbo9BrzUEQvQkmY3t7OK5TNhqkvBKVEQ+AP/fgxKWRjXDsbPplm9fCOKV4kENFjpe0OejU+M0Ya44QxV/yrsoqoevHLSuTfSm60qPTaCz0EJbx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774073790; c=relaxed/simple;
	bh=hzUHg/Rr7zHctFOvkGtG2cxFzAArMhXqHtmI8pxKW6g=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=QSwTWhEbElfuz4QWdcvvEr9cMLoFBjUKyFZAzmTjw3eVyV+YKVkoXnzrnwfk8oNEIJK1scyNInO0a0BUbXYVGdiu1TpYOnBQU6Z83DxDZ+RGj/AyRYYqtM6werEIO73Ub7g55b0wHpC2URG+CkAZj12z2Sy3auYLXZMB0oIVlHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wj3TPJc6; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wj3TPJc6"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2bdc1b30ac8so68101314eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Mar 2026 23:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774073788; x=1774678588; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HYPRju/rpMO2YL/AEK0Hs0ueiqArdFKTD0SNUgo6yS4=;
        b=wj3TPJc6vTcqRMF09nqa1g0zoX5+GLxIyf65OF7rC9IfE1aDbwFc7iJp5Kwc89UjAb
         E+4Pr0+9+mrNyYSa9SQInMQo9oid46CE27601lHTmHmi2Et5fNLcdQ5xCo9S/3TOx72p
         0g8wQzgbZWARpxOliSgTXnaZ0uHz478cpOcNk6XquXxYuEYOco6U9IfKC1MNnOD6VDPF
         IAFWgpyfJSlLHt25YE8E8nicAUhq3M8QIkk4nqisY6SY1rYjOgng5wsQCDqni64xVh04
         qb8S19jf0n001fAtB+7AJEfPvuuZzgj8jvbYRTA0wJjkyEZtLhvbMy2VcSBjoXkFq4IJ
         rl9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774073788; x=1774678588;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HYPRju/rpMO2YL/AEK0Hs0ueiqArdFKTD0SNUgo6yS4=;
        b=HyWpNEn95YPR9nT+2AwKYNe3hrkz8QncgcWf1+6iOA+Y/mmsVRN6ahkRkWQtSeK8+W
         XztC+8OSj71EZfiqwmnpcWcU0fpsNttzwkzy3BKLiB1+3/yB1JEsjnHpuUTMB8q8S4wN
         tuZySjmBNAFK9CmRdr5ixfXcggn2PM7Uw6Q02sBU2PEdG37jw35A8PFLpnRisL/FO3W1
         XckXzuZ7e64KdnY5tQTJyQMT5T/R6UDbdVgkdGIQHwGafQspwkg8n9VgSeJoaF+h7Rb8
         6xjDOxzAgHUO0JkkFkd/lo9Gfp0MIitxTvXz6T3wQtxQ7SgovF/WMj60g54l6HHjqUZ+
         //KA==
X-Forwarded-Encrypted: i=1; AJvYcCVMVcwPm9Q22FIjzVVSvZ/v2PEo4A78aCwGzxz8Rxzz8lQDnvOCZAoPJuQ6vca/FDXRe7q58MTzpFTX6jTuzIJ0@vger.kernel.org
X-Gm-Message-State: AOJu0YzNDdvSz9Y7zPrzVW4nUm+hTAsVTEBZXvRU12gRTF8boC9azGN/
	59hLiEVhZppeQ9yNTWz/UAYmoIKSF8iCGtk12MA22U9H5usxcr/0CX3IsVb0tQjJ0+hMJmktiRM
	oeB6vNfto9g==
X-Received: from dybna27.prod.google.com ([2002:a05:7300:cc1b:b0:2c1:f6:65e5])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:3f16:b0:2b8:66f3:2502
 with SMTP id 5a478bee46e88-2c109585265mr2881662eec.1.1774073787701; Fri, 20
 Mar 2026 23:16:27 -0700 (PDT)
Date: Fri, 20 Mar 2026 23:16:24 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.959.g497ff81fa9-goog
Message-ID: <20260321061624.811157-1-irogers@google.com>
Subject: [PATCH v1] perf tests task-analyzer: Write all test files to tmpdir
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Writing to the test output files in the current working directory can
fail in various contexts such as continual test. Other tests write to
a mktemp-ed file, make the "perf script task-analyszer tests" follow
this convention too. Currently this isn't possible for the perf.data
file due to a lack of perf script support.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/test_task_analyzer.sh | 37 +++++++++++---------
 1 file changed, 20 insertions(+), 17 deletions(-)

diff --git a/tools/perf/tests/shell/test_task_analyzer.sh b/tools/perf/tests/shell/test_task_analyzer.sh
index e194fcf61df3..cc74b03477fe 100755
--- a/tools/perf/tests/shell/test_task_analyzer.sh
+++ b/tools/perf/tests/shell/test_task_analyzer.sh
@@ -3,6 +3,10 @@
 # SPDX-License-Identifier: GPL-2.0
 
 tmpdir=$(mktemp -d /tmp/perf-script-task-analyzer-XXXXX)
+# perf script report only supports input from the perf.data file.
+perfdata="perf.data"
+csv="$tmpdir/csv"
+csvsummary="$tmpdir/csvsummary"
 err=0
 
 # set PERF_EXEC_PATH to find scripts in the source directory
@@ -15,11 +19,10 @@ fi
 export ASAN_OPTIONS=detect_leaks=0
 
 cleanup() {
-  rm -f perf.data
-  rm -f perf.data.old
-  rm -f csv
-  rm -f csvsummary
+  rm -f "${perfdata}"
+  rm -f "${perfdata}".old
   rm -rf "$tmpdir"
+
   trap - exit term int
 }
 
@@ -61,7 +64,7 @@ skip_no_probe_record_support() {
 
 prepare_perf_data() {
 	# 1s should be sufficient to catch at least some switches
-	perf record -e sched:sched_switch -a -- sleep 1 > /dev/null 2>&1
+	perf record -e sched:sched_switch -a -o "${perfdata}" -- sleep 1 > /dev/null 2>&1
 	# check if perf data file got created in above step.
 	if [ ! -e "perf.data" ]; then
 		printf "FAIL: perf record failed to create \"perf.data\" \n"
@@ -130,28 +133,28 @@ test_extended_times_summary_ns() {
 }
 
 test_csv() {
-	perf script report task-analyzer --csv csv > /dev/null
-	check_exec_0 "perf script report task-analyzer --csv csv"
-	find_str_or_fail "Comm;" csv "${FUNCNAME[0]}"
+	perf script report task-analyzer --csv "${csv}" > /dev/null
+	check_exec_0 "perf script report task-analyzer --csv ${csv}"
+	find_str_or_fail "Comm;" "${csv}" "${FUNCNAME[0]}"
 }
 
 test_csv_extended_times() {
-	perf script report task-analyzer --csv csv --extended-times > /dev/null
-	check_exec_0 "perf script report task-analyzer --csv csv --extended-times"
-	find_str_or_fail "Out-Out;" csv "${FUNCNAME[0]}"
+	perf script report task-analyzer --csv "${csv}" --extended-times > /dev/null
+	check_exec_0 "perf script report task-analyzer --csv ${csv} --extended-times"
+	find_str_or_fail "Out-Out;" "${csv}" "${FUNCNAME[0]}"
 }
 
 test_csvsummary() {
-	perf script report task-analyzer --csv-summary csvsummary > /dev/null
-	check_exec_0 "perf script report task-analyzer --csv-summary csvsummary"
-	find_str_or_fail "Comm;" csvsummary "${FUNCNAME[0]}"
+	perf script report task-analyzer --csv-summary "${csvsummary}" > /dev/null
+	check_exec_0 "perf script report task-analyzer --csv-summary ${csvsummary}"
+	find_str_or_fail "Comm;" "${csvsummary}" "${FUNCNAME[0]}"
 }
 
 test_csvsummary_extended() {
-	perf script report task-analyzer --csv-summary csvsummary --summary-extended \
+	perf script report task-analyzer --csv-summary "${csvsummary}" --summary-extended \
 	>/dev/null
-	check_exec_0 "perf script report task-analyzer --csv-summary csvsummary --summary-extended"
-	find_str_or_fail "Out-Out;" csvsummary "${FUNCNAME[0]}"
+	check_exec_0 "perf script report task-analyzer --csv-summary ${csvsummary} --summary-extended"
+	find_str_or_fail "Out-Out;" "${csvsummary}" "${FUNCNAME[0]}"
 }
 
 skip_no_probe_record_support
-- 
2.53.0.959.g497ff81fa9-goog

