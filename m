Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792703286;
	b=lypHxBZLG2C5SqsOWCpn/mZRkf/uc8UA0To1bA63qMnNuY2aBtFYFjhS+B+HKCxT+jhE
	 PC4E8av5xw6aVUCsmWveYPkyHgO56UjxQEZ1dN3giXZyD+e5BTktA3zWW8y1kX37nvjYP
	 +cj1yBpkLFMFGCH1hI7tP3ObA2lUhtHapcK7yKfT3CMljhBzHeKKucUgODzP3Rpm/k3ts
	 YJ7UH5yvWW1rHpkt7m/k5q3PVtWipAl2MFm0XOtSXI2hQYAaAyX2AIfb9iNL2yihTSi3e
	 4Tc+h+a/7SVVAplP5hRO/nHrStivz+hfeKYsTPQkVwUOymlT9zB1elh/jaGqhXW3bxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792703286;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=97l3F0qa9psKlTIuzdbrVRWx6AWuAsCgx2ZlN91wNSs=;
	b=5U372gCuSsTIIlxLvvVDDUzSd31eN8rAwZ1PQUyuvJyxBXWDAPlPL2ObOTDtFBnmwQzR
	 M7oc+DYn1vBFV16I5wvTKoLfsnnRQ7G9/iRJA0rX8/BGaMytkTwKAzUgCN33hL971SsCn
	 41q1esJOn61oC3fpdTiQYcf5pbB/rIvdpDaMnFe89jjy6A2aMNbuXodzt+TuV25bYcKvb
	 BtXH00aqqTMPNfNwpo7w0ho829P9B7I9epcHLZncnvQWEWWS/mHB0O5ZYaZT+P3JbU0eR
	 7w0F5Y5zwhykDWNGWdiFzgKE7cIi6DBKbhI/oaLET5fYQNQQxFWBIwX+DoIUPSZowNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=brXWvW4E;
	arc=none smtp.remote-ip=74.125.82.197
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A70606A31E
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Oct 2026 21:08:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 38A70606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=brXWvW4E
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-35cbea41088so302699eec.1
        for <linux-perf-users@vger.kernel.org>; Thu, 22 Oct 2026 14:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792703285; x=1793308085; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=97l3F0qa9psKlTIuzdbrVRWx6AWuAsCgx2ZlN91wNSs=;
        b=brXWvW4EV878jT2FGNiDmCOD1mNu0kDa9W9AfmgWU2HST08wU5lt1c3MqE34+QSRSW
         tPxDtqe7T/vmUZxWqCjOmlj7m7pLHGjDjGTdLHUaLjOXX5EWxcH7THGrDTPqLKQRzgZf
         TxNlsx8s+7HGRBUV28hSnsbvlc9B8Q8F5cQ5dCT2/U66qosfTQBwm64Nmo6jv4s8oQ5k
         7y/Z94+Fch+IAtgIbAytaEDdYal/ecrN6m0iD32nhNn+1sWnlJSzFzoLtRXQuk2Bf1eQ
         ByisoqM2Cbj6TPPcRUXgVRT4TLP64cNHejgoGxh/32cbTf/82u6Yj1LkRR4HAdXYmaeb
         CJvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792703285; x=1793308085;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=97l3F0qa9psKlTIuzdbrVRWx6AWuAsCgx2ZlN91wNSs=;
        b=ENNivuKsoPrwbJUdHj+xQhKeNXW35KBwKcae6UIBHCNOIgLJGmuH9Rp4P0QLh/4Y4Y
         lx+bCNhoBIKVc5AFBwSoPVVDkCjNHSuOu/EcWCFCM0OSNN8r55PvpwLJhP8JlnkyGmvf
         7gPVf3cSu2mvQLbo7UT5wBwdQHhPDA2QAufH62hqB7yG5NcTMhOBPKp4+mDK4QFUGhw1
         NFWuiDs3FIlZCQL5yZujudvfEYdri+Wfsn+GHwn56WpTl5Co1x60ONs6cYZXS3Uf9e53
         Qfjsjr8VghVgoFC3zYpjxFJ4yH3ei5KV5WrRoOB1YfO1aB6Zea0qaNbGALw+T39TQg1o
         VWAg==
X-Forwarded-Encrypted: i=1; AKwUvBwbUpmQRobMI/47p9wX6+9cdmtyyjHkj1FwkzpEUOEwbE4E1wHW80+fU4ZmNz/p79zvU6qiEf9xKlmGZCNX6n0v@vger.kernel.org
X-Gm-Message-State: AFq9FYKZRpu5e54hF0fqbjtX6jOq8UQbMzaCgayjVKbbaGBRiWBI8mM3
	Z018iS8D+zpdycugH5EEV5T2YEaeo0BQg6rL26GxNfMWS38prv4oLW+fazDQ19wZtDqyb/2M/6V
	rGxDVTl19Og==
X-Received: from dlex15.prod.google.com ([2002:a05:701b:47af:b0:18c:3061:3bca])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:4212:10b0:14a:d8fe:33b3
 with SMTP id a92af1059eb24-195c72d8c23mr483052c88.40.1792703285065; Thu, 22
 Oct 2026 14:08:05 -0700 (PDT)
Date: Thu, 22 Oct 2026 14:07:53 -0700
In-Reply-To: <20261022210753.1851597-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261012234724.721224-1-irogers@google.com> <20261022210753.1851597-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
Message-ID: <20261022210753.1851597-4-irogers@google.com>
Subject: [PATCH v5 3/3] perf test: Don't count mlock budget wait time towards
 test timeout
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: 9erthalion6@gmail.com, adrian.hunter@intel.com, james.clark@linaro.org, 
	jolsa@kernel.org, leo.yan@arm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

When multiple parallel tests need room in kernel.perf_event_mlock_kb,
they take turns acquiring the shared mlock_budget->lock mutex in
run_test_case_mlocked() after being forked in start_test().

Because child->start_time is recorded in start_test() when the child
process is forked, any time a test spends waiting in the
mlock_budget->lock queue would otherwise be counted against both its
per-test timeout (causing tests later in the queue to time out before
they even start) and its JUnit XML testcase elapsed time.

Extend struct mlock_budget with a per-slot shared start_time and started
flag populated in run_test_case_mlocked() once the child acquires
mlock_budget->lock. In check_child_timeout(), skip tests that are still
waiting for mlock_budget->lock and measure the timeout from the lock
acquisition timestamp once started. Also use the post-lock start_time
when computing the test's elapsed duration.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/builtin-test.c | 81 +++++++++++++++++++++++++--------
 1 file changed, 63 insertions(+), 18 deletions(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 58dc75ba82cf..e1bfde78d34d 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -79,8 +79,17 @@ static unsigned int test_timeout = 120;
  * processes and robust so that a test killed while holding it doesn't leave
  * the budget locked, see mutex_init_pshared_robust().
  */
+struct mlock_child_time {
+	struct timespec start_time;
+	bool started;
+};
+
 struct mlock_budget {
 	struct mutex lock;
+	size_t size;
+	size_t nr_slots;
+	size_t next_slot;
+	struct mlock_child_time slots[];
 };
 
 static struct mlock_budget *mlock_budget;
@@ -384,6 +393,7 @@ struct child_test {
 	struct timespec start_time;
 	struct timespec end_time;
 	struct timespec timeout_time;
+	struct mlock_child_time *mlock_time;
 };
 
 static jmp_buf run_test_jmp_buf;
@@ -414,6 +424,8 @@ static int run_test_case_mlocked(struct child_test *child)
 	int err;
 
 	mutex_lock(&mlock_budget->lock);
+	clock_gettime(CLOCK_MONOTONIC, &child->mlock_time->start_time);
+	__atomic_store_n(&child->mlock_time->started, true, __ATOMIC_RELEASE);
 	err = run_test_case(child);
 	mutex_unlock(&mlock_budget->lock);
 
@@ -459,7 +471,6 @@ static int run_test_child(struct child_process *process)
 		SIGABRT, SIGBUS, SIGFPE, SIGILL, SIGINT, SIGPIPE, SIGQUIT, SIGSEGV, SIGTERM,
 	};
 	struct child_test *child = container_of(process, struct child_test, process);
-	bool needs_mlock = mlock_budget && child->test->needs_mlock;
 	int err, sig;
 
 	/*
@@ -486,7 +497,7 @@ static int run_test_child(struct child_process *process)
 	pr_debug("---- start ----\n");
 	pr_debug("test child forked, pid %d\n", getpid());
 
-	if (needs_mlock)
+	if (child->mlock_time)
 		err = run_test_case_mlocked(child);
 	else
 		err = run_test_case(child);
@@ -1027,6 +1038,28 @@ static void kill_child_process(pid_t pid, int sig)
 		kill(pid, sig);
 }
 
+static bool child_test__started(const struct child_test *child, struct timespec *start_time)
+{
+	if (child->mlock_time) {
+		if (!__atomic_load_n(&child->mlock_time->started, __ATOMIC_ACQUIRE))
+			return false;
+		*start_time = child->mlock_time->start_time;
+		return true;
+	}
+	*start_time = child->start_time;
+	return true;
+}
+
+static double child_test__elapsed_secs(const struct child_test *child,
+				       const struct timespec *end_time)
+{
+	struct timespec start_time;
+
+	if (!child_test__started(child, &start_time))
+		start_time = child->start_time;
+	return timespec_diff_secs(end_time, &start_time);
+}
+
 static void check_child_timeout(struct child_test *child, const struct timespec *now)
 {
 	pid_t pid;
@@ -1043,7 +1076,12 @@ static void check_child_timeout(struct child_test *child, const struct timespec
 		return;
 
 	if (!child->timed_out) {
-		if (timespec_diff_secs(now, &child->start_time) >= test_timeout) {
+		struct timespec start_time;
+
+		if (!child_test__started(child, &start_time))
+			return;
+
+		if (timespec_diff_secs(now, &start_time) >= test_timeout) {
 			child->timed_out = true;
 			child->timeout_time = *now;
 			pr_debug3("Timeout (%us) for test %d.%d (pid %d), sending SIGTERM\n",
@@ -1258,8 +1296,7 @@ static void finish_test(struct child_test **child_tests, int running_test, int c
 		print_test_failure_snippet(stderr, err_output.buf);
 
 	clock_gettime(CLOCK_MONOTONIC, &end_time);
-	elapsed = (end_time.tv_sec - child_test->start_time.tv_sec) +
-		  (end_time.tv_nsec - child_test->start_time.tv_nsec) / 1000000000.0;
+	elapsed = child_test__elapsed_secs(child_test, &end_time);
 
 	print_test_result(t, curr_suite, curr_test_case, ret, width, /*running=*/0,
 			  err_output.buf, elapsed);
@@ -1532,9 +1569,7 @@ static int finish_tests_parallel(struct child_test **child_tests, size_t num_tes
 				 (child->result == TEST_FAIL || child->result == TEST_TIMEOUT))
 				print_test_failure_snippet(stderr, child->err_output.buf);
 
-			elapsed = (child->end_time.tv_sec - child->start_time.tv_sec) +
-				  (child->end_time.tv_nsec -
-				   child->start_time.tv_nsec) / 1000000000.0;
+			elapsed = child_test__elapsed_secs(child, &child->end_time);
 
 			print_test_result(child->test, child->suite_num, child->test_case_num,
 					  child->result, width, 0, child->err_output.buf, elapsed);
@@ -1606,6 +1641,9 @@ static int start_test(struct test_suite *test, int curr_suite, int curr_test_cas
 		(*child)->process.stdout_to_stderr = 1;
 	}
 	(*child)->process.no_exec_cmd = run_test_child;
+	if (mlock_budget && test->needs_mlock && !sequential && pass == 1 &&
+	    mlock_budget->next_slot < mlock_budget->nr_slots)
+		(*child)->mlock_time = &mlock_budget->slots[mlock_budget->next_slot++];
 	clock_gettime(CLOCK_MONOTONIC, &(*child)->start_time);
 	err = start_command(&(*child)->process);
 	if (err)
@@ -2199,10 +2237,10 @@ static struct test_suite **build_suites(void)
 #undef for_each_suite
 }
 
-static bool perf_test__shares_mlock_budget(struct test_suite **suites, int argc,
-					   const char *argv[], struct intlist *skiplist)
+static size_t perf_test__count_mlock_budget(struct test_suite **suites, int argc,
+					    const char *argv[], struct intlist *skiplist)
 {
-	int sharing = 0;
+	size_t sharing = 0;
 
 	/* The selection rules mirrored here are __cmd_test()'s: when they change, change both. */
 	for (int curr_suite = 0; suites[curr_suite]; curr_suite++) {
@@ -2224,10 +2262,8 @@ static bool perf_test__shares_mlock_budget(struct test_suite **suites, int argc,
 					       curr_suite, argc, argv))
 				sharing += runs_per_test;
 		}
-		if (sharing > 1)
-			return true;
 	}
-	return false;
+	return sharing;
 }
 
 /*
@@ -2250,6 +2286,8 @@ static bool perf_test__mlock_budget_exhaustible(void)
 static void perf_test__setup_mlock_budget(struct test_suite **suites, int argc,
 					  const char *argv[], struct intlist *skiplist)
 {
+	size_t sharing, size;
+
 	/* Nothing can be denied the budget, nothing to take turns for. */
 	if (!perf_test__mlock_budget_exhaustible()) {
 		pr_debug("Not taking turns using the perf mlock budget: nothing can exhaust it\n");
@@ -2257,19 +2295,26 @@ static void perf_test__setup_mlock_budget(struct test_suite **suites, int argc,
 	}
 
 	/* Nothing runs at the same time, nothing to share the budget with. */
-	if (sequential || !perf_test__shares_mlock_budget(suites, argc, argv, skiplist))
+	if (sequential)
+		return;
+
+	sharing = perf_test__count_mlock_budget(suites, argc, argv, skiplist);
+	if (sharing <= 1)
 		return;
 
-	mlock_budget = mmap(NULL, sizeof(*mlock_budget), PROT_READ | PROT_WRITE,
+	size = sizeof(*mlock_budget) + sharing * sizeof(mlock_budget->slots[0]);
+	mlock_budget = mmap(NULL, size, PROT_READ | PROT_WRITE,
 			    MAP_SHARED | MAP_ANONYMOUS, /*fd=*/-1, /*offset=*/0);
 	if (mlock_budget == MAP_FAILED) {
 		mlock_budget = NULL;
 		pr_err("Failed to map the shared area used to take turns using the perf mlock budget\n");
 		return;
 	}
+	mlock_budget->size = size;
+	mlock_budget->nr_slots = sharing;
 
 	if (!mutex_init_pshared_robust(&mlock_budget->lock)) {
-		munmap(mlock_budget, sizeof(*mlock_budget));
+		munmap(mlock_budget, size);
 		mlock_budget = NULL;
 		pr_debug("Not taking turns using the perf mlock budget\n");
 	}
@@ -2281,7 +2326,7 @@ static void perf_test__teardown_mlock_budget(void)
 		return;
 
 	mutex_destroy(&mlock_budget->lock);
-	munmap(mlock_budget, sizeof(*mlock_budget));
+	munmap(mlock_budget, mlock_budget->size);
 	mlock_budget = NULL;
 }
 
-- 
2.56.0.307.g5fe7bd680c-goog

