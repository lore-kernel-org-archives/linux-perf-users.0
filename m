Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722A83859CB
	for <linux-perf-users@vger.kernel.org>; Tue, 23 Jun 2026 01:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782178111; cv=none; b=Jk9rRrrtJWHX8W+ndu+BWG+fNfGnRiS6yfzPt+kCz9sRYMDIoCl3xMaYqTkmLqrleQfsSnG+2WrZzd+Qs6nDztTOChW4dxCo4b2KFp4hfQvQruEqqNbjA2AJln0PTwZFOuNd7w7wfWlm/Yu7OLoYNMOwqWEMEpQCEhTCnCNOeOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782178111; c=relaxed/simple;
	bh=Fc4Nwdad5ioYr6Lrhvzpo+ONmpqJLhAnOcahwnVeP0M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bEww2cXnPqQsvM0nC0CkDNlkFI1XpfPuYw2u2wudhG9z9V/+oV/Zu4Y4bhIXDQAmQAug5PZgUztV1OTHDs5Shuett9bTNNiPWqgqpKrrKkqE+5zNffD4Q5YcmrbLlT3Vq9O2CrhwUELZLg11mttzh1df2u34hQB2xkoEHCgmJaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wIBzv142; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wIBzv142"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-138acbc0e69so18653031c88.0
        for <linux-perf-users@vger.kernel.org>; Mon, 22 Jun 2026 18:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782178106; x=1782782906; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4Cp+I45ECZr4QxUAj/Nb81MMcDSVZJ+AyCrMlfPOIX0=;
        b=wIBzv142k5fgXt4PcrmHaYBBFmJUKxDKFJG+s3/xsVTBSStYCL7Ci8ceaGXKFW3HVU
         RrVfKHbQ4E96VYiPHh61oQKacq2FmK4Ip7XYG4qL/CfylHtwuEl8poxswZ9q0XnA4OhZ
         6w6ZlZ8aBcRjVR44jkHhyaG2vAUuzJT5Lje2nE8KlN0j7Yo3c7/GnBXTWSXw17Fhimpc
         vAofuf8ko59K0KzOyuCbf1Zjv4gZSMEDQOq7rAEeU3RSkSOQ2P9md+WHN/zJkfH1QKaj
         L9vRwjw6EpktAy823KH1rVbeDyf91nC4uLh+YfhK0GdbvHyJoGgWQEaXQwIBXRfc9Fm8
         Ve3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782178106; x=1782782906;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4Cp+I45ECZr4QxUAj/Nb81MMcDSVZJ+AyCrMlfPOIX0=;
        b=GHVdtEDAOlbFCgf35nkiWCNHvM78vEKHZpL5yxfFycgkb2OumHGrxNP/KPexRlzJB2
         xwCasiRmx7RualoJloE0jKJRiYWTKfyozTnnTOcq9qIthl0VASikteiZA3BFISiOaR7n
         +HXSUJwQmw5Cksj13s/SjGkNWX1wSrh08wExFIJ0UVqLSRo+CKSiQYOHKdKi2DttM7Ir
         +gADwT9JowNt0EaxsHJqCdEs3/5rdoML9+/yAMOksYKYP235j2UNooD+aHwdZ/u+sqmY
         Ji6hyRTt4U5I48RwB5fOoHBBN0RmkmtVvK8biFMpbv9GksPJi2ec/nNURMK5l6atMvie
         m/dg==
X-Forwarded-Encrypted: i=1; AFNElJ8ADwrrQqDcZscb0Jn0YVJsH4FiRMM3PChiAQ31Gixg7CqVtbvD+LeSBi3l3aACSieKX4f46hWaiwUzPWXgURlR@vger.kernel.org
X-Gm-Message-State: AOJu0Yy86K7I6qmwH9uaFGDmJd9HCGI1Wj1pKm/2GmPu5uiThiTlmTV+
	TjyPSKgw7tEnFF5/KxrIFnHeEaDlmiRaNFIavcu1F+P0xYRG0c2Y5Loz3xCz76xiyQ2GSvgq9cs
	OF5upyOcqxw==
X-Received: from dlbbt3.prod.google.com ([2002:a05:7022:983:b0:139:c268:a5ed])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:f697:b0:138:37a6:6cff
 with SMTP id a92af1059eb24-139ad5d75cfmr7717119c88.0.1782178105236; Mon, 22
 Jun 2026 18:28:25 -0700 (PDT)
Date: Mon, 22 Jun 2026 18:27:56 -0700
In-Reply-To: <20260623012758.2291858-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260616164819.370939-1-irogers@google.com> <20260623012758.2291858-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.rc0.786.g65d90a0328-goog
Message-ID: <20260623012758.2291858-12-irogers@google.com>
Subject: [PATCH v4 11/13] perf tests: Speed up lock contention analysis shell test
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	leo.yan@arm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	thomas.falcon@intel.com, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

The lock contention analysis test suite (`lock_contention.sh`) performs a
series of 13 separate profiling checks to verify various aggregation and
filtering parameters of `perf lock contention`. Each of these checks runs
the `perf bench sched messaging` messaging benchmark as its workload.

By default, `sched messaging` runs 10 groups of 40 processes (400
processes total) generating substantial task scheduling, context
switching, and IPC message passing. When traced system-wide for lock
events, the tracing overhead (handling millions of lock acquisitions and
releases) slows execution down significantly, causing the test suite to
take over 80 seconds.

Optimize this by introducing a scaled-down messaging benchmark workload:
`perf bench sched messaging -g 1 -p`. Running 1 group (40 processes) takes
only 0.01 seconds natively (instead of 0.08 seconds), drastically reduces
the sheer volume of lock acquire/release trace events, and reduces CPU
context switching during tracing while still generating sufficient lock
events to fully exercise the BPF/record filters.

Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/lock_contention.sh | 32 ++++++++++++++---------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/tools/perf/tests/shell/lock_contention.sh b/tools/perf/tests/shell/lock_contention.sh
index 52e8b9db9fbd..ba598370be73 100755
--- a/tools/perf/tests/shell/lock_contention.sh
+++ b/tools/perf/tests/shell/lock_contention.sh
@@ -9,6 +9,10 @@ perfdata=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
 result=$(mktemp /tmp/__perf_test.result.XXXXX)
 errout=$(mktemp /tmp/__perf_test.errout.XXXXX)
 
+# Workload to generate lock contention.
+# Using 1 group (-g 1) keeps runtime low while generating sufficient lock events.
+msg_workload="perf bench sched messaging -g 1"
+
 cleanup() {
 	rm -f ${perfdata}
 	rm -f ${result}
@@ -50,7 +54,7 @@ check() {
 test_record()
 {
 	echo "Testing perf lock record and perf lock contention"
-	perf lock record -o ${perfdata} -- perf bench sched messaging -p > /dev/null 2>&1
+	perf lock record -o ${perfdata} -- ${msg_workload} > /dev/null 2>&1
 	# the output goes to the stderr and we expect only 1 output (-E 1)
 	perf lock contention -i ${perfdata} -E 1 -q 2> ${result}
 	if [ "$(cat "${result}" | wc -l)" != "1" ]; then
@@ -70,7 +74,7 @@ test_bpf()
 	fi
 
 	# the perf lock contention output goes to the stderr
-	perf lock con -a -b -E 1 -q -- perf bench sched messaging -p > /dev/null 2> ${result}
+	perf lock con -a -b -E 1 -q -- ${msg_workload} > /dev/null 2> ${result}
 	if [ "$(cat "${result}" | wc -l)" != "1" ]; then
 		echo "[Fail] BPF result count is not 1:" "$(cat "${result}" | wc -l)"
 		err=1
@@ -81,7 +85,7 @@ test_bpf()
 test_record_concurrent()
 {
 	echo "Testing perf lock record and perf lock contention at the same time"
-	perf lock record -o- -- perf bench sched messaging -p 2> ${errout} | \
+	perf lock record -o- -- ${msg_workload} 2> ${errout} | \
 	perf lock contention -i- -E 1 -q 2> ${result}
 	if [ "$(cat "${result}" | wc -l)" != "1" ]; then
 		echo "[Fail] Recorded result count is not 1:" "$(cat "${result}" | wc -l)"
@@ -107,7 +111,7 @@ test_aggr_task()
 	fi
 
 	# the perf lock contention output goes to the stderr
-	perf lock con -a -b -t -E 1 -q -- perf bench sched messaging -p > /dev/null 2> ${result}
+	perf lock con -a -b -t -E 1 -q -- ${msg_workload} > /dev/null 2> ${result}
 	if [ "$(cat "${result}" | wc -l)" != "1" ]; then
 		echo "[Fail] BPF result count is not 1:" "$(cat "${result}" | wc -l)"
 		err=1
@@ -130,7 +134,7 @@ test_aggr_addr()
 	fi
 
 	# the perf lock contention output goes to the stderr
-	perf lock con -a -b -l -E 1 -q -- perf bench sched messaging -p > /dev/null 2> ${result}
+	perf lock con -a -b -l -E 1 -q -- ${msg_workload} > /dev/null 2> ${result}
 	if [ "$(cat "${result}" | wc -l)" != "1" ]; then
 		echo "[Fail] BPF result count is not 1:" "$(cat "${result}" | wc -l)"
 		err=1
@@ -148,7 +152,7 @@ test_aggr_cgroup()
 	fi
 
 	# the perf lock contention output goes to the stderr
-	perf lock con -a -b --lock-cgroup -E 1 -q -- perf bench sched messaging -p > /dev/null 2> ${result}
+	perf lock con -a -b --lock-cgroup -E 1 -q -- ${msg_workload} > /dev/null 2> ${result}
 	if [ "$(cat "${result}" | wc -l)" != "1" ]; then
 		echo "[Fail] BPF result count is not 1:" "$(cat "${result}" | wc -l)"
 		err=1
@@ -170,7 +174,7 @@ test_type_filter()
 		return
 	fi
 
-	perf lock con -a -b -Y spinlock -q -- perf bench sched messaging -p > /dev/null 2> ${result}
+	perf lock con -a -b -Y spinlock -q -- ${msg_workload} > /dev/null 2> ${result}
 	if [ "$(grep -c -v spinlock "${result}")" != "0" ]; then
 		echo "[Fail] BPF result should not have non-spinlocks:" "$(cat "${result}")"
 		err=1
@@ -202,7 +206,7 @@ test_lock_filter()
 		return
 	fi
 
-	perf lock con -a -b -L tasklist_lock -q -- perf bench sched messaging -p > /dev/null 2> ${result}
+	perf lock con -a -b -L tasklist_lock -q -- ${msg_workload} > /dev/null 2> ${result}
 	if [ "$(grep -c -v "${test_lock_filter_type}" "${result}")" != "0" ]; then
 		echo "[Fail] BPF result should not have non-${test_lock_filter_type} locks:" "$(cat "${result}")"
 		err=1
@@ -241,7 +245,7 @@ test_stack_filter()
 		return
 	fi
 
-	perf lock con -a -b -S unix_stream -E 1 -q -- perf bench sched messaging -p > /dev/null 2> ${result}
+	perf lock con -a -b -S unix_stream -E 1 -q -- ${msg_workload} > /dev/null 2> ${result}
 	if [ "$(cat "${result}" | wc -l)" != "1" ]; then
 		echo "[Fail] BPF result should have a lock from unix_stream:" "$(cat "${result}")"
 		err=1
@@ -269,7 +273,7 @@ test_aggr_task_stack_filter()
 		return
 	fi
 
-	perf lock con -a -b -t -S unix_stream -E 1 -q -- perf bench sched messaging -p > /dev/null 2> ${result}
+	perf lock con -a -b -t -S unix_stream -E 1 -q -- ${msg_workload} > /dev/null 2> ${result}
 	if [ "$(cat "${result}" | wc -l)" != "1" ]; then
 		echo "[Fail] BPF result should have a task from unix_stream:" "$(cat "${result}")"
 		err=1
@@ -285,7 +289,8 @@ test_cgroup_filter()
 		return
 	fi
 
-	perf lock con -a -b --lock-cgroup -E 1 -F wait_total -q -- perf bench sched messaging -p > /dev/null 2> ${result}
+	perf lock con -a -b --lock-cgroup -E 1 -F wait_total -q \
+		-- ${msg_workload} > /dev/null 2> ${result}
 	if [ "$(cat "${result}" | wc -l)" != "1" ]; then
 		echo "[Fail] BPF result should have a cgroup result:" "$(cat "${result}")"
 		err=1
@@ -293,7 +298,8 @@ test_cgroup_filter()
 	fi
 
 	cgroup=$(cat "${result}" | awk '{ print $3 }')
-	perf lock con -a -b --lock-cgroup -E 1 -G "${cgroup}" -q -- perf bench sched messaging -p > /dev/null 2> ${result}
+	perf lock con -a -b --lock-cgroup -E 1 -G "${cgroup}" -q \
+		-- ${msg_workload} > /dev/null 2> ${result}
 	if [ "$(cat "${result}" | wc -l)" != "1" ]; then
 		echo "[Fail] BPF result should have a result with cgroup filter:" "$(cat "${cgroup}")"
 		err=1
@@ -328,7 +334,7 @@ test_csv_output()
 	fi
 
 	# the perf lock contention output goes to the stderr
-	perf lock con -a -b -E 1 -x , --output ${result} -- perf bench sched messaging -p > /dev/null 2>&1
+	perf lock con -a -b -E 1 -x , --output ${result} -- ${msg_workload} > /dev/null 2>&1
 	output=$(grep -v "^#" ${result} | tr -d -c , | wc -c)
 	if [ "${header}" != "${output}" ]; then
 		echo "[Fail] BPF result does not match the number of commas: ${header} != ${output}"
-- 
2.55.0.rc0.786.g65d90a0328-goog

