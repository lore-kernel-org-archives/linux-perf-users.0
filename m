Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09FB3DA7F7
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Jun 2026 06:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781590473; cv=none; b=VvfwtL9OA8xJCYphjh17ZGWUheU+xok1tLPcqTSFkJhUYaGlt/wL5Xv94l37zap5Ox1QkrCCAh+4ezlLsN4fg1J8YNELUJKPr0zD5t+cw0/S7k+Zp979XL2saeRmtRuW1ZXjnG5SojCNOVyLSjhFb0OxwY8YDG78YhqgE98NLtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781590473; c=relaxed/simple;
	bh=rEPXRyX0K/GCuSjm0kaZnjRIwLDhYV7ih8X/3JF6rIU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=beG+ieUaKURdMJO9Ih45ILe/8DMbJOUHtBsEWsMTpdU32iOagHDnya+uNugpgZ3eeduS2VTIUGJ3Rp/a01yC06fmFYoi8uBjTvig1kOfFk/1ZZsKqgLmEZN9S/gf730RipLuTN8r9KgZuTBpkFzv97cR+17+R7rbBeUyiVDuIbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Cs5ImRdj; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Cs5ImRdj"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-308004a2c49so1141673eec.0
        for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 23:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781590471; x=1782195271; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PssKuP4CKaena/eiTOkn4uj7AlehBZrS5ZJr/3Okq+4=;
        b=Cs5ImRdjAJ/wDL9fzRSmSZZzzAe9MXJ5jbi2Pe9GDJKY9A3cu/5cbYdaWUoW2j/OJX
         XtAVPmkH+tXSREnNawZSmF0LnN16Llru9BMVaVYmaLofbC27qp36oiSYlI0DrxygFTu9
         k2FTCcsmR3pw+8SCuJmHvhEr0FP56wbDEzwq9KYIwOAl3qsftAgMj2oumnN4GHe77Lct
         4waYxSVl6cIaVgd65yBBNlSvqhDqLjgNby6yhoi9wCXorisL9Jb5UV3blkFx16h5O8u2
         2ioBpCHYwbFUf5KWCyJ0A0jY/sd1GnkEizEoFGczig1mU5sWgaVpz5IUwcaOUVjfkAH6
         UKmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781590471; x=1782195271;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PssKuP4CKaena/eiTOkn4uj7AlehBZrS5ZJr/3Okq+4=;
        b=WZts9Xj3wj8ue0DDVMWFTFucodBVDgZSyZ/jIdDLWSqLA5/7uGcCXv9bHRNNU8senF
         3c6iCMIPOP2NNQeQ/2iVkeObTz1d1022jaIfjgsMpo+7px7/QslHK1eo+lAeyEpc4djn
         0fXhNk93oNzScYq/nkGfri86ZEVOrprpnq1DmJpSwTXn21xSQyIghbJD6YNHSTf423NU
         o5QlYyPRA2CL2qYJqOt9hgRuFRLkd6fTaY7N1qyHs8N+m+2g0LLE8xcLTfn/02gQEQ83
         Q7U2vNN2jR/UhuKY4Mwexu3vNYUiOAcVIoy7Eo2febzTO2ADgiSA3bSQ7GZbTTmSYVaQ
         gEhw==
X-Forwarded-Encrypted: i=1; AFNElJ+EjglWjV1lb2sZv1t63Ebe0QaIXM3mV/zkeWUB/VQqx2tl12m/JI0Xmy6zDqBOky30Sxnf2C1q1b4ITtzSnVMf@vger.kernel.org
X-Gm-Message-State: AOJu0YxZSrCHpbZwhn2f/1A+wWIZ9PMtbzaBHD51eFsBgs+LUA7V8aXb
	GsDwYT2+JTJ8UC/6cQY+K/DdwAmrpWaEltjNAx+ZUKd9FbpAmkdCGIoFAnc2H3LAamQlGhAs5zC
	nmyN77IaR7w==
X-Received: from dycpz7.prod.google.com ([2002:a05:7300:fe07:b0:304:e502:fe2d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:19a2:b0:2df:919f:ce59
 with SMTP id 5a478bee46e88-30ba5ec7bb1mr1493016eec.19.1781590470759; Mon, 15
 Jun 2026 23:14:30 -0700 (PDT)
Date: Mon, 15 Jun 2026 23:14:03 -0700
In-Reply-To: <20260616061404.41929-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260616012744.4049193-1-irogers@google.com> <20260616061404.41929-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260616061404.41929-12-irogers@google.com>
Subject: [PATCH v2 11/12] perf tests: Speed up lock contention analysis shell test
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	leo.yan@arm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	thomas.falcon@intel.com, tmricht@linux.ibm.com
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

