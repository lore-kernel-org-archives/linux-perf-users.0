Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792707778;
	b=N3+bFyxbJRnnIX2ThHRO/ukBBHn4gWkIHIlH/L9F8FgvpmUUqT4yCZZPxJI+4PzvJRam
	 alGdts2B2zV19iu8wRlQ/d8BtxZ2h8WuoxKeWVEVIM7zF2/avWs0qZfr5sJMSWog4OgcD
	 e4XsqVN600BkNS6A4zIMa9GGxET0GQS3GQzDH/F6kndWm5LJr3KV+YcWCRTwWVHiNQXJy
	 7CbQBLerCv5j1Jq12ioM2Hc5FTeOmGiEOw3CMrcQ0TtaeU1lRaZxJPbQcu4bhkwcgyaJW
	 5TOSzFt9k8uegE4y+bQiBN3xzKa1DXfOkuxoTJEu6PdOyFBhO727EOBmP2LAwhl4cSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792707778;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=VEcDmqjX6iIrqyD/adxI0CF2vRyPmzipKBsXE9bGWSk=;
	b=CZNwLPZPPMGJoh34jyD0aeKWJgjP66B3pD4ZnKm96GfT9zPXNPjTolV+YZMDjLSMleVp
	 d8tqcx8soxF1S5/tKl9Yo5u2KjQnkFAYha/c3+kwf68ZxcTQDXqnEfFHbpTgpfOVYy2vK
	 0loQYEGzcRCHzDeYmqSbZCcn4vTdxzXTg61ToezyiLKBIByJXxWGrj+a+TcBpmT0ZqwPn
	 BrSgO5NydNuLBp12zrbYwqt000B5niAcLQTi++ng9+hsaH+iLzpb63ioIzGghStlsR2d8
	 4lj0WNKYBwJLN2JKOImZzhnr3SHDJGiqNLvaPRi/fHXPIHoZ0ShHENt9/zsaRd7PJBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=RwduRJSt;
	arc=none smtp.remote-ip=74.125.82.198
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B23606A320
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Oct 2026 22:22:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48B23606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=RwduRJSt
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-3510d0baf63so714335eec.1
        for <linux-perf-users@vger.kernel.org>; Thu, 22 Oct 2026 15:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792707777; x=1793312577; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VEcDmqjX6iIrqyD/adxI0CF2vRyPmzipKBsXE9bGWSk=;
        b=RwduRJStXwZAxdvkLIYZizCOL2+HZrnn2jT6infWak1ZmFrwNz+VXESnFBCNo7bPvQ
         LMVVbGvUMUJuRFAn/U/hZJTXZ/EnhBiuVEDInWghcHRjpJwZnzC0xN07tsvVADq97+VA
         kRbyVxG+l7Dnh/hHVRHiMTjVtzIUsPKIpCB8TFjPHY74iET+ScWwJc7psvbU/RnEnJZA
         /ZmETIwF4nYUOpwLNtT1r1mvkn6H+H3esNdP6tdVpq0s4msHyuavZUebm7uHD7InSJKw
         jyWtuSAEGzockpZwiahkG5WUz5f1Y7r1lEElCNTltmho0/aub5mUq+SfgQwfiwmMkQG3
         1+bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792707777; x=1793312577;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VEcDmqjX6iIrqyD/adxI0CF2vRyPmzipKBsXE9bGWSk=;
        b=SV8ORe8fr+KivhmkHyj1RQaWNZ1M0qcdcGVn6mIBunjjCMgJGuJCL8iabpk+gSd70n
         IZ4L9jjPCCfQks/BYYtYLUV7qDaLB5XWXzHKCn3YSVeRUaK2q7x5xr9sLp0VTcstlflm
         7wnxo6yD4Iq+WWgUKtAz/bBpikzcGc4tFPGJ6hhrgv0KhPVF0+jO9bEkwC377VhBUWZR
         hL6Ero8ghIlGuA3qKYZ2yHLKrK1+6U4Xx8GgWk5jPIBCUPl3ar2SPZhBO0sJzSubpXvC
         rgozqF84rtqzTRsKVJK9tNX9lVFwRbisjiHYqTmTo1yyFFEwdM/AVGhp8Tnjw/Nj/exQ
         g1CQ==
X-Forwarded-Encrypted: i=1; AKwUvByl64Wlo4XB68iE8xiNZt9XkJ4q9LkoI63C1VGsG4qnw4pFhnpBsSpDHKbTYd8dUXtYVUdK6TLc9SDURNuLOGmh@vger.kernel.org
X-Gm-Message-State: AFq9FYLvK7avW0P1lOdkVPAIuIX7cc+1/toLD6HjKDxgsuGZyKnVAiwM
	nEPqEMnRpKwKw6GQxgRKIdacj+tSsEGMLNtF4mN2qDaPhkqASNwRsEcTzVEoRZ8nzw9TlylRRxR
	RCLz5BEwz+g==
X-Received: from dlah3.prod.google.com ([2002:a05:701b:2603:b0:17a:1e54:4da1])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:4505:10b0:183:e993:7901
 with SMTP id a92af1059eb24-195c58e8597mr691414c88.17.1792707776885; Thu, 22
 Oct 2026 15:22:56 -0700 (PDT)
Date: Thu, 22 Oct 2026 15:22:45 -0700
In-Reply-To: <20261022222245.2064964-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261022210753.1851597-1-irogers@google.com> <20261022222245.2064964-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
Message-ID: <20261022222245.2064964-4-irogers@google.com>
Subject: [PATCH v6 3/3] perf test: Don't count mlock budget wait time towards
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
index ae599b6cb4c9..0732fede7d54 100644
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
@@ -1262,8 +1300,7 @@ static void finish_test(struct child_test **child_tests, int running_test, int c
 		print_test_failure_snippet(stderr, err_output.buf);
 
 	clock_gettime(CLOCK_MONOTONIC, &end_time);
-	elapsed = (end_time.tv_sec - child_test->start_time.tv_sec) +
-		  (end_time.tv_nsec - child_test->start_time.tv_nsec) / 1000000000.0;
+	elapsed = child_test__elapsed_secs(child_test, &end_time);
 
 	print_test_result(t, curr_suite, curr_test_case, ret, width, /*running=*/0,
 			  err_output.buf, elapsed);
@@ -1539,9 +1576,7 @@ static int finish_tests_parallel(struct child_test **child_tests, size_t num_tes
 				 (child->result == TEST_FAIL || child->result == TEST_TIMEOUT))
 				print_test_failure_snippet(stderr, child->err_output.buf);
 
-			elapsed = (child->end_time.tv_sec - child->start_time.tv_sec) +
-				  (child->end_time.tv_nsec -
-				   child->start_time.tv_nsec) / 1000000000.0;
+			elapsed = child_test__elapsed_secs(child, &child->end_time);
 
 			print_test_result(child->test, child->suite_num, child->test_case_num,
 					  child->result, width, 0, child->err_output.buf, elapsed);
@@ -1613,6 +1648,9 @@ static int start_test(struct test_suite *test, int curr_suite, int curr_test_cas
 		(*child)->process.stdout_to_stderr = 1;
 	}
 	(*child)->process.no_exec_cmd = run_test_child;
+	if (mlock_budget && test->needs_mlock && !sequential && pass == 1 &&
+	    mlock_budget->next_slot < mlock_budget->nr_slots)
+		(*child)->mlock_time = &mlock_budget->slots[mlock_budget->next_slot++];
 	clock_gettime(CLOCK_MONOTONIC, &(*child)->start_time);
 	err = start_command(&(*child)->process);
 	if (err)
@@ -2206,10 +2244,10 @@ static struct test_suite **build_suites(void)
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
@@ -2231,10 +2269,8 @@ static bool perf_test__shares_mlock_budget(struct test_suite **suites, int argc,
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
@@ -2257,6 +2293,8 @@ static bool perf_test__mlock_budget_exhaustible(void)
 static void perf_test__setup_mlock_budget(struct test_suite **suites, int argc,
 					  const char *argv[], struct intlist *skiplist)
 {
+	size_t sharing, size;
+
 	/* Nothing can be denied the budget, nothing to take turns for. */
 	if (!perf_test__mlock_budget_exhaustible()) {
 		pr_debug("Not taking turns using the perf mlock budget: nothing can exhaust it\n");
@@ -2264,19 +2302,26 @@ static void perf_test__setup_mlock_budget(struct test_suite **suites, int argc,
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
@@ -2288,7 +2333,7 @@ static void perf_test__teardown_mlock_budget(void)
 		return;
 
 	mutex_destroy(&mlock_budget->lock);
-	munmap(mlock_budget, sizeof(*mlock_budget));
+	munmap(mlock_budget, mlock_budget->size);
 	mlock_budget = NULL;
 }
 
-- 
2.56.0.307.g5fe7bd680c-goog

