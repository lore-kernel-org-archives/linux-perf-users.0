Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7CDC4418EE
	for <linux-perf-users@vger.kernel.org>; Tue, 31 Mar 2026 18:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774980327; cv=none; b=KDW3osIXU+nr6n5M8qQsriC928lYDlTWnkidkqimXTEZapPOY514Fa/gQ8yiTkHILRhE6+Z6U++LCr4tDgb1KemeOJ6oJs8BDCanzSdbvqE8/IIOPyK8GpIdXcFrgIV2QIYky7MVvi/5ytulhOBFdU9Qay9DhynTg31PDJKBmEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774980327; c=relaxed/simple;
	bh=jY24kDcrTrXJ5ZqUpRCt0hVvN945zz/1ecHdLBvF+wE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZWkDwQH/uJYxurRwn/VcYlI6SRTaWqI2pdmnGK0rjpai7nQCwtQGIj5Le7ZO/AgoILGBMey3Ln2L/fLWNU+wyiD81AqkPc2MUduyDoB07veu6ItJ914xYDI/qY7Dsi2VHFQgLALtXnxJwK6PzcOLZnUbFUcZoR4JVWAygZPo09w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VO5YNwVs; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VO5YNwVs"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2c16233ee11so6604907eec.1
        for <linux-perf-users@vger.kernel.org>; Tue, 31 Mar 2026 11:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774980325; x=1775585125; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Cn7FoXYW9ejkkjulKIZ3tlU8/vQCi8J/JUEU2GlXiJ8=;
        b=VO5YNwVsI0c2rVEdIHOdA2vZHUZiSTtygDmvZ0PcpJgqBGlLcbwWjSFf3zlPrqWLMA
         suWAKX1wq4RUYX9bZyKpLXbhFHBsuIfXNxmbYjmQ4SbAs0+jyJZBtTZGqFrgzefMej7C
         JFKAdgUUdfzRXbsfyVKVsssfJPzpgji2DQJSHluLZvRDdoSA0+9AsseHAs8tWabJMtl5
         +o+q7jopICNawkcTJ2BOin4WlQwGPFNLlG5zCB/Htb/c40s6oC30G93SGHNrhm7g536s
         bIbYYHtVJuxwfhaMow8QbcCKnOFFR3rENcR0WJiPPYITeFcjORlxx7HqjznaLJe+EVfU
         NLHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774980325; x=1775585125;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cn7FoXYW9ejkkjulKIZ3tlU8/vQCi8J/JUEU2GlXiJ8=;
        b=LVtsbfT0dy/qIdp58EJNpkEivdeiEkfnkKOYEdHRQsWhGF7YPYNNUCHFWRNj6qbh+3
         0Q9DNZzUnnBxrufxBvbxfTvA/+aSJML9Jt4F1nuw7svex6g2T2WbQPyoEOYDsK/l6+GE
         YcebA5gLD8Xq/WCm2Tu9M6C0hJHFLa0AstLD6xErqFI1tP5zpTHbbhjYQ8SsRoLWCj3K
         hquCBZDB/TiufHC2R2KQ79+BAznSyeKN9++y7OKSLFpoaOoxpLtV+7NX0BTLKkIzeNEY
         3FqPvoxu1Hd9uhJkq7KydLZzPI2sGPZ+n4yWDphM1uFI8LJ3i30pbtc11IEoUhPeQ5yA
         6trg==
X-Forwarded-Encrypted: i=1; AJvYcCXKDFyptgQ+izzPlCCWG96LD84iBK4V864YX9t0RfkmdwRB0PJsUd1j2qkMwbzxg2Mr/tH3UeCAN/ldjSwXE+dP@vger.kernel.org
X-Gm-Message-State: AOJu0YxZOfctoPY9hAcr7vlIgrHcZ8sQdMGa/559WLLqZsy9+jgMhGJa
	XtlIKomHHZcB62Zdn27wvvBYEDDBaC6D1DW5lPtRII+dl59Zxa3w2DJprw4wKusmrcEL2Lc1Ld7
	ZavRBX5XHGg==
X-Received: from dyblf46.prod.google.com ([2002:a05:7301:a2e:b0:2c7:32bb:d28d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:6d1f:b0:2be:833c:149d
 with SMTP id 5a478bee46e88-2c9325b4835mr151328eec.28.1774980324535; Tue, 31
 Mar 2026 11:05:24 -0700 (PDT)
Date: Tue, 31 Mar 2026 11:05:20 -0700
In-Reply-To: <CAP-5=fUJb+a4s45p4aL8_qf-nC3EdTxL9oey1xh6ax=1rjUr=A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAP-5=fUJb+a4s45p4aL8_qf-nC3EdTxL9oey1xh6ax=1rjUr=A@mail.gmail.com>
X-Mailer: git-send-email 2.53.0.1118.gaef5881109-goog
Message-ID: <20260331180520.4052231-1-irogers@google.com>
Subject: [PATCH v3] perf tests task-analyzer: Write test files to tmpdir
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, namhyung@kernel.org
Cc: irogers@google.com, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

Writing to the test output files in the current working directory can
fail in various contexts such as continual test. Other tests write to
a mktemp-ed file, make the "perf script task-analyszer tests" follow
this convention too. Currently this isn't possible for the perf.data
file due to a lack of perf script support, add a variable for when
this support is available.

Signed-off-by: Ian Rogers <irogers@google.com>
---
v3: Address missed rename feedback from Namhyung.
v2: Improvements to commit message:
    https://lore.kernel.org/lkml/20260327060033.2294469-1-irogers@google.com/
v1: https://lore.kernel.org/lkml/20260321061624.811157-1-irogers@google.com/
---
 tools/perf/tests/shell/test_task_analyzer.sh | 42 +++++++++++---------
 1 file changed, 23 insertions(+), 19 deletions(-)

diff --git a/tools/perf/tests/shell/test_task_analyzer.sh b/tools/perf/tests/shell/test_task_analyzer.sh
index e194fcf61df3..0314412e63b4 100755
--- a/tools/perf/tests/shell/test_task_analyzer.sh
+++ b/tools/perf/tests/shell/test_task_analyzer.sh
@@ -3,6 +3,11 @@
 # SPDX-License-Identifier: GPL-2.0
 
 tmpdir=$(mktemp -d /tmp/perf-script-task-analyzer-XXXXX)
+# TODO: perf script report only supports input from the CWD perf.data file, make
+# it support input from any file.
+perfdata="perf.data"
+csv="$tmpdir/csv"
+csvsummary="$tmpdir/csvsummary"
 err=0
 
 # set PERF_EXEC_PATH to find scripts in the source directory
@@ -15,11 +20,10 @@ fi
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
 
@@ -61,10 +65,10 @@ skip_no_probe_record_support() {
 
 prepare_perf_data() {
 	# 1s should be sufficient to catch at least some switches
-	perf record -e sched:sched_switch -a -- sleep 1 > /dev/null 2>&1
+	perf record -e sched:sched_switch -a -o "${perfdata}" -- sleep 1 > /dev/null 2>&1
 	# check if perf data file got created in above step.
-	if [ ! -e "perf.data" ]; then
-		printf "FAIL: perf record failed to create \"perf.data\" \n"
+	if [ ! -e "${perfdata}" ]; then
+		printf "FAIL: perf record failed to create \"${perfdata}\" \n"
 		return 1
 	fi
 }
@@ -130,28 +134,28 @@ test_extended_times_summary_ns() {
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
2.53.0.1118.gaef5881109-goog

