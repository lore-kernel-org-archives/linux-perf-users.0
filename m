Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E4923EA8A
	for <linux-perf-users@vger.kernel.org>; Fri, 27 Mar 2026 06:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774591240; cv=none; b=QZ136UF4wBpyM9JZ5xAU62QFSKkULpm8gczgdLGVFsfOjVnk2Mbh/+gQitdWS8PDDpP3p8C66m4XcJI/RAIWmSMM5jfEGZyJQUuIIqnLyRMupDh6mKk1vhlpnFqDf8lQRJGJbVxSI0+zEDsOZcAiToyv07PfuXEd05bkYMau7w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774591240; c=relaxed/simple;
	bh=7by32mE098PrC98ifd1wv1RjxNxqtJBI7IB4w/ka4FM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HBUt4fdRCgOyL0QoP2yZr+EAK+MITJL2BsVOzwQIl9dwzia2rzMQKjSjehYpMkfb/HL5KumdCHZYCgNcFeu76IxzGVlQH+ZueWvTxGqdkb/e2ogeoBmrLExFYHlcOKIg+wP9dVmHnXuij8cn0Q/Q5kwEpcwP1jNgNzla+uS5Z2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a8F38c1K; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a8F38c1K"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2c166ac27c6so2040232eec.0
        for <linux-perf-users@vger.kernel.org>; Thu, 26 Mar 2026 23:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774591237; x=1775196037; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bSaSPNMMLz85x3cusqDT6CCMGHSADwo/AJ+TzcNU1qY=;
        b=a8F38c1Khx0yIDbr9YvVYE7anMkJ1dGK88QNZ+LDKNYCt3FUn/9CP2XhNEKweEIIOu
         Sx3z6zFIAhujdfKzR3UPhxT6v18/S4XiZbKGPpw1AIw81Nxyf5ki2gCUEk9ynjhUft0A
         MqYXOIgyY4bXVc3yUg3CeuinZzwxchff56V87wvNBxbuEURd9LBx6wRggmTT5n6y+dAB
         y65wOy5Ek7s8161B6vOUradw3Ekv8AkN7bsC9rWzL++sLHQIqHvvV8Lq0Cx2VFKKr0g8
         YKMF4eUzZL1sGYyyai0NPjvc3iLw0Tc36JBtK3KnWlSuXOxTbVn8qKWMxZ+rO+fvXi0S
         9yZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774591237; x=1775196037;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bSaSPNMMLz85x3cusqDT6CCMGHSADwo/AJ+TzcNU1qY=;
        b=rvbuan1PyTZE8Neike9v/NKxDmBnFvHwx3pWfGF3xAccSaztiW9AArDVjlrasg1pBN
         d9Xlnz3FnOXtOevgMuDGwxbXB0z6LC6Z8riYPzOBrLst2e/it4WjBVL2RTQsbi935q2u
         8rycXq6la1jlATVQZ5ZWs/iJ6QJNa++5PHMAJuDz+jVq0MyMioHsQRhFi6sydk1dafqw
         Of4UGvsLzDNkvppfAtZgNEbb/ykO3H79kwCzPEdXwl8stbrFzTbNpzBsQuM+aAqE/R5N
         hX046n6qHmNjvPhDamtWetu1U8nVLa17lzzJpzWkcDI9saM3JfxJETcvPJsxyurCIeh3
         +rAw==
X-Forwarded-Encrypted: i=1; AJvYcCXr9s/g2xnQletnSB1v9SvmIB/HCq/A+XS4owa3hCUlu5uV9kNkkZ2gJ1rq1v0bttBCEgTkzp/cbIGRPkuiYiAy@vger.kernel.org
X-Gm-Message-State: AOJu0YzyhS3wDVvT5RZ4yl89isKuonqDkxfPIOIhsWkUSu2h6lZlfXaC
	OmY55akniU1w/tuALyHoG66YBakXLW+32U6mEcxjim4J7HLOuvGiOxz+VHvCnqyIXBJcJXYvRS9
	ct1l5G5h2zA==
X-Received: from dycc10.prod.google.com ([2002:a05:693c:60ca:b0:2c0:bee5:18c9])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:f689:b0:128:ced9:9409
 with SMTP id a92af1059eb24-12ab291a28dmr523173c88.37.1774591236655; Thu, 26
 Mar 2026 23:00:36 -0700 (PDT)
Date: Thu, 26 Mar 2026 23:00:33 -0700
In-Reply-To: <20260326174521.1829203-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260326174521.1829203-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
Message-ID: <20260327060033.2294469-1-irogers@google.com>
Subject: [PATCH v2] perf tests task-analyzer: Write test files to tmpdir
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, namhyung@kernel.org
Cc: irogers@google.com, agordeev@linux.ibm.com, gor@linux.ibm.com, 
	hca@linux.ibm.com, jameshongleiwang@126.com, japo@linux.ibm.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-s390@vger.kernel.org, sumanthk@linux.ibm.com, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Writing to the test output files in the current working directory can
fail in various contexts such as continual test. Other tests write to
a mktemp-ed file, make the "perf script task-analyszer tests" follow
this convention too. Currently this isn't possible for the perf.data
file due to a lack of perf script support, add a variable for when
this support is available.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/test_task_analyzer.sh | 38 +++++++++++---------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/tools/perf/tests/shell/test_task_analyzer.sh b/tools/perf/tests/shell/test_task_analyzer.sh
index e194fcf61df3..b1a6a7e017e4 100755
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
 
@@ -61,7 +65,7 @@ skip_no_probe_record_support() {
 
 prepare_perf_data() {
 	# 1s should be sufficient to catch at least some switches
-	perf record -e sched:sched_switch -a -- sleep 1 > /dev/null 2>&1
+	perf record -e sched:sched_switch -a -o "${perfdata}" -- sleep 1 > /dev/null 2>&1
 	# check if perf data file got created in above step.
 	if [ ! -e "perf.data" ]; then
 		printf "FAIL: perf record failed to create \"perf.data\" \n"
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
2.53.0.1018.g2bb0e51243-goog

