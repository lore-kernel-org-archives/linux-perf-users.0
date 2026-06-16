Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD8E3890FC
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Jun 2026 01:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781573294; cv=none; b=bN9oeW0LUQ9HrUrYPgF9EuFlRmzEvcKqJllA95sX1Riyx74vJx4W7OCaXhQ5S71VPZC6HRyqOf27zndQ4FqsMoKW2tXdYqpNnM9NNX8oT4fVFm9qShpuw2+5xuyRjWiZMqdBM2ZeBmCRdvzsIdaQUXq87yBRs/xXSlBz55Uy4p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781573294; c=relaxed/simple;
	bh=rEPXRyX0K/GCuSjm0kaZnjRIwLDhYV7ih8X/3JF6rIU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=ueJduYeIUGD44nhx6pr9r73O0Yz0nQsK1YL9DwNo32CIG9D+w4paY/02sBnz9jrIpbS0wsC/BOkKVIRYPj58F+rklGHEZkN2Dsqe7tEBCilHNfccaafp0RJYPwXL9xCux7jHPAa5ttyF7ScTS0NVSVe+AMXZEAmUc6T9fg9PG2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H0ZLt2YN; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H0ZLt2YN"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-308004a2c49so484364eec.0
        for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 18:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781573292; x=1782178092; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PssKuP4CKaena/eiTOkn4uj7AlehBZrS5ZJr/3Okq+4=;
        b=H0ZLt2YNkTPZHg0oXc2vGSrwKVfpdKROP91BIqOQr7wcFgc29PBrwmh9oIY8ohiAod
         WSYBtanWAwzwN2VcqbA98QmET+Tqn/I0FrPBFNoQedVz5KmGcOgNWZDtOq8OsMCdyDn2
         V11qmasR2CuCuJn/05NeOieRqbFci6IM/oowV80FFsGyuSoABdFtYvWnFNISLIoXjMkS
         oaQ6PQywuHcmpMIKR27a53GTMB+Sr9EXRoN7t+VZO8+PzGv75t5vd+OWzlG6CSU7H+PG
         YWVw1k3bGR3VpcS2ej+qWFLoGSqa8RyEY9Zwgcgq6mbXjnO6vKjNGPu7Up+B6PiNk68a
         3/9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781573292; x=1782178092;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PssKuP4CKaena/eiTOkn4uj7AlehBZrS5ZJr/3Okq+4=;
        b=lgKZv6TCupF98PyiGe8HRC6flpvGftHQt+ujUcaDmYmlOvPrLK6YE+YzxHWuigtfBI
         VhQMy2RWHd5LRa9k4rBbN26xJguzrlCrvove40dmAUQTaHQiBIVHNBBFdOTsZhEs112x
         b7n4wNWUH2TapWTvHgoW6pbXm/hd7ytTmqYuSUpj5oGTrCy7PntlaF/ELKgm300cqhg2
         f43rDs18b4XTcvRnoPfcGMPM53FfBR1CimqRO3oGncY71ntxUglj1duEUasvzaMoeKua
         UlCM8pjXqK2CeAN3O39iCCTeylaLJLcpjcU/+Rhga5shZKk2DW0vaMj5DAVeqvstZmWR
         YeDg==
X-Forwarded-Encrypted: i=1; AFNElJ8JlHPJKnXdFz+3yGCq7GRCaN8+hqyTRNku+xirip5ItpJn+EXAshjXHNG/5jHC+um3r3xiKdqMLOQtC/Wqsmnz@vger.kernel.org
X-Gm-Message-State: AOJu0YzjWJrXHN8q4hTFSWyG0oaBEAH6MT8sb/cgOolT/xV5dWiVHf3W
	ts0Bh8KHgSO6giSAkXNnzzkZ1W222Emyi95TudVF7XKG8yfwCoTE004DBfP/i6a0udFIYTmdX2z
	JdFthBnHdmw==
X-Received: from dydz8.prod.google.com ([2002:a05:7300:22c8:b0:307:a303:44ea])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:cd91:b0:304:d32e:65f9
 with SMTP id 5a478bee46e88-30ba5912e59mr950199eec.6.1781573291517; Mon, 15
 Jun 2026 18:28:11 -0700 (PDT)
Date: Mon, 15 Jun 2026 18:27:43 -0700
In-Reply-To: <20260616012744.4049193-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260616012744.4049193-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260616012744.4049193-12-irogers@google.com>
Subject: [PATCH v1 11/12] perf tests: Speed up lock contention analysis shell test
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Thomas Falcon <thomas.falcon@intel.com>, 
	Leo Yan <leo.yan@arm.com>, Thomas Richter <tmricht@linux.ibm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The lock contention analysis test suite (`lock_contention.sh`) performs
a series of 13 separate profiling checks to verify various aggregation
and filtering parameters of `perf lock contention`. Each of these checks
runs the `perf bench sched messaging` messaging benchmark as its workload.

By default, `sched messaging` runs 10 groups of 40 processes (400 processes
total) generating substantial task scheduling, context switching, and IPC
message passing. When traced system-wide for lock events, the tracing overhead
(handling millions of lock acquisitions and releases) slows execution down
significantly, causing the test suite to take over 80 seconds.

Optimize this by introducing a scaled-down messaging benchmark workload:
`perf bench sched messaging -g 1 -p`. Running 1 group (40 processes) takes
only 0.01 seconds natively (instead of 0.08 seconds), drastically reduces the
sheer volume of lock acquire/release trace events, and reduces CPU context
switching during tracing while still generating sufficient lock events to fully
exercise the BPF/record filters.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/lock_contention.sh | 30 +++++++++++++----------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/tools/perf/tests/shell/lock_contention.sh b/tools/perf/tests/shell/lock_contention.sh
index 52e8b9db9fbd..f589d387f6b3 100755
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
@@ -285,7 +289,7 @@ test_cgroup_filter()
 		return
 	fi
 
-	perf lock con -a -b --lock-cgroup -E 1 -F wait_total -q -- perf bench sched messaging -p > /dev/null 2> ${result}
+	perf lock con -a -b --lock-cgroup -E 1 -F wait_total -q -- ${msg_workload} > /dev/null 2> ${result}
 	if [ "$(cat "${result}" | wc -l)" != "1" ]; then
 		echo "[Fail] BPF result should have a cgroup result:" "$(cat "${result}")"
 		err=1
@@ -293,7 +297,7 @@ test_cgroup_filter()
 	fi
 
 	cgroup=$(cat "${result}" | awk '{ print $3 }')
-	perf lock con -a -b --lock-cgroup -E 1 -G "${cgroup}" -q -- perf bench sched messaging -p > /dev/null 2> ${result}
+	perf lock con -a -b --lock-cgroup -E 1 -G "${cgroup}" -q -- ${msg_workload} > /dev/null 2> ${result}
 	if [ "$(cat "${result}" | wc -l)" != "1" ]; then
 		echo "[Fail] BPF result should have a result with cgroup filter:" "$(cat "${cgroup}")"
 		err=1
@@ -328,7 +332,7 @@ test_csv_output()
 	fi
 
 	# the perf lock contention output goes to the stderr
-	perf lock con -a -b -E 1 -x , --output ${result} -- perf bench sched messaging -p > /dev/null 2>&1
+	perf lock con -a -b -E 1 -x , --output ${result} -- ${msg_workload} > /dev/null 2>&1
 	output=$(grep -v "^#" ${result} | tr -d -c , | wc -c)
 	if [ "${header}" != "${output}" ]; then
 		echo "[Fail] BPF result does not match the number of commas: ${header} != ${output}"
-- 
2.54.0.1136.gdb2ca164c4-goog

