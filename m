Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F9A47DF82
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Jun 2026 16:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781628532; cv=none; b=c6gBiSRTALBXXpTBH6U+bIOxEUjXSQT7a6Tmg8ZWocR1B/Gs8kSCj8IZhx6DE+IvzjjuKIU9RtAuOJ1y4WCF9MHotDoaqugsMuhWRHP12tI6Z+m4DD3709d3Ldh59PyYezgdrdngcOjvqZPsreAU7sGqdEmc/iVJvZcWTykujrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781628532; c=relaxed/simple;
	bh=BVEqPg1/gLWp+6UtIzaJVrAG6IkBWeSXqNe4kwQz3F4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nEkhmRO8QGU4Z9PyN0XWS8Zt3UuTL1d/tXn4J5lWPz5fylbAZYkp4vbtAx26hwDw3UqlXU4c7ZRKfZd3zEKZd1sNmuqOpgznMduJP7dl5yUvBmtqeN4qqf+5e/65m8PN30mEI4ipNvFfne8TZp5k9kI8+59gnHPUjTzynQqRTpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rk04wC9T; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rk04wC9T"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-307625ee07fso16772063eec.1
        for <linux-perf-users@vger.kernel.org>; Tue, 16 Jun 2026 09:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781628529; x=1782233329; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nthEv6EusQawzI2xPar1f8e6+ba1HIZX31oEpmZqeAs=;
        b=rk04wC9TZJ/FYVAJDajIcChDWss0NMFiOWHKiEwsu1xECN75cQ3bwMscIoYuUUEI5H
         C/oVJ7MimOmhdysjeXun8BDMWwW6JgFv5kDtFpAfGG/LpP8vk6BE4edeaRodL0k0ZHJi
         5TTuMWMkUATdAkfcMpUyRmo4hNdLLpXiqL80sR8uGdEMjIBDw3v2H4f69hrivDJKCSqJ
         N2R84HHCzC/273BVOACvm4sGooXDlK+i1lYA+BJC4oHoywDZvJCFE9gXXWU4+Bq/BJnW
         BmyNvSq7goDPaBZlDsVky46aLqkSWd8M4zq/LCG6vOjw0ZgaGXDQW3frrKsonHM9wVxH
         YtMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781628529; x=1782233329;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nthEv6EusQawzI2xPar1f8e6+ba1HIZX31oEpmZqeAs=;
        b=ELKWvnYsG9hYp2f6guoWzkbVg0pY01n4CNJztHUmsYW4JeWoGkaUO4rBiyBDFfJ/hf
         Dqijm3eAucl/hvYpUDZXF+HPcoakzg739ZmJRMdfMUmzHlGiZPge+XuITA4QOa55FQ9L
         a3Zhxk3Rq+2b5DLfJvuryHo7pZ38fZGriYS2LsDeWH7IvC1Iy9kTLIdOLhuKMvXQqGv7
         FAN1Exp8HlYugEIIi5MoSxlc0EwZq4H1pMQKRh73IObzqor3s1xinPGS/xY0NRzZIeyw
         xX5W5RE1vEEVw/lQOw0xavNnA4RlYwJmRjN7j54Uj1KUN4EEeX0rhLc44g1+VIZOPy9F
         Sc9g==
X-Forwarded-Encrypted: i=1; AFNElJ+6IQdeuuNd8sOVN/c3aL0VXsycoJnJkj+6nN76IWKa1MCWriGlCDFTIqpOBcFUH7u0fB8Pe0mXbW5wQclMBsiz@vger.kernel.org
X-Gm-Message-State: AOJu0YwibHyIfLxy5gJ8tidfMz7l3cDbagcFM8i6SG03X32vlGdCC07u
	eiuTVFcLvLWPLlNUuoeNcif/vVH70yX5KRd6YW+N6NeRztyMtS3V9CQeYfIGhlswjuDqbM/gETt
	XWQaKIwB//g==
X-Received: from dybmw17.prod.google.com ([2002:a05:7300:cd91:b0:30b:96b8:80b2])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:e82e:b0:304:e72a:d4d9
 with SMTP id 5a478bee46e88-30bca09cf59mr57105eec.19.1781628529079; Tue, 16
 Jun 2026 09:48:49 -0700 (PDT)
Date: Tue, 16 Jun 2026 09:48:16 -0700
In-Reply-To: <20260616164819.370939-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260616061404.41929-1-irogers@google.com> <20260616164819.370939-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1189.g8c84645362-goog
Message-ID: <20260616164819.370939-12-irogers@google.com>
Subject: [PATCH v3 11/13] perf tests: Speed up lock contention analysis shell test
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
index 52e8b9db9fbd..953483d987e9 100755
--- a/tools/perf/tests/shell/lock_contention.sh
+++ b/tools/perf/tests/shell/lock_contention.sh
@@ -9,6 +9,10 @@ perfdata=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
 result=$(mktemp /tmp/__perf_test.result.XXXXX)
 errout=$(mktemp /tmp/__perf_test.errout.XXXXX)
 
+# Workload to generate lock contention.
+# Using 1 group (-g 1) keeps runtime low while generating sufficient lock events.
+msg_workload="perf bench sched messaging -g 1 -p"
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
2.54.0.1189.g8c84645362-goog

