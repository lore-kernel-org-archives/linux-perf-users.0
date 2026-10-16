Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025122931CE;
	Fri, 16 Oct 2026 00:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792109975; cv=none; b=ln/IVWZ5AusP+XP4Bat0L99rko+/3gX74D1e/jl4rJ3hgPWgK4PudmhPHOvyK3G6G/02fG3tYkS5z4xzvcfXQ+tl8Ywre8Omnd2g0hKrcRC2hVXmbDnT8PqnyeFfDi6Hee+c1XX0K+XKxpOByo0Ug91ZypwE+Fb9FswEim55m3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792109975; c=relaxed/simple;
	bh=OpIlLjiTysxfDVRxktllByqVZ7DOp/4tw+K6KtWohc0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e6AUjycEUXRwZ5jHQM9bZ8QX+UbX+85/NaumcwdArbq/1LiEmVEojH8riuibBSlmH6r38IzLxsRDx2bRjIOnrSirp+pN7PkFdgFUXo6yJ1ZuI3KaZ296uaIzdoVQA80v0wMw+Ki4QLc5PP2YG34cRCLRAqjywvk2Ky/mqMLgofY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dk2q/ejM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dk2q/ejM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B1FF1F000C4;
	Fri, 16 Oct 2026 00:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792109973;
	bh=NsYY1h2BPTo9Qr8Q3wCnAt7APVuwPdmAUcMqXqx64nw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dk2q/ejMxJdiA8xTGSbg4xmg9JIKw53NuLGpzJARoqiuudL0gbQwt4NMChHAujJxJ
	 SwnYnxQy9j/qML4Qa3rnDylq9xP2/dqntnAcRFJRYeYoiipplG4fzTDKGjCoKjUif5
	 CcWqlGWHsX+Tu0m8GgZfYwv5yGz0pfYD7DoSrapFm5AgXWmakrvnqRQcTcOEndaMyF
	 aEHvv8w1ZE/Fw+Rh9hM0j+9wCb5hpewsVtIQzB88ca72+urlVmzFKQfq6ayNIvRX48
	 x4J/NXwIamPeyVVIK+WaIFPuSb14YcmfO31Izo4NTkKDn7EZ4Dzl3pHq708iWN6fS+
	 QkK6LCLNEwBvQ==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v3 16/19] perf tests: Mark the C tests mapping perf ring buffers
Date: Thu, 15 Oct 2026 21:18:40 -0300
Message-ID: <20261016001843.71978-17-acme@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261016001843.71978-1-acme@kernel.org>
References: <20261016001843.71978-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

The C tests that run 'perf record' in the test process itself map ring
buffers and so need room in the per user budget set in
kernel.perf_event_mlock_kb: mark them with the new 'needs_mlock' suite
flag, read by the turnstile added later in the series, so that they
take turns using that budget while the tests that don't map them keep
running in parallel.

Assisted-by: LLM
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/backward-ring-buffer.c     | 2 +-
 tools/perf/tests/code-reading.c             | 2 +-
 tools/perf/tests/keep-tracking.c            | 2 +-
 tools/perf/tests/mmap-basic.c               | 1 +
 tools/perf/tests/openat-syscall-tp-fields.c | 1 +
 tools/perf/tests/perf-record.c              | 1 +
 tools/perf/tests/perf-time-to-tsc.c         | 1 +
 tools/perf/tests/sw-clock.c                 | 2 +-
 tools/perf/tests/task-exit.c                | 1 +
 9 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/tools/perf/tests/backward-ring-buffer.c b/tools/perf/tests/backward-ring-buffer.c
index 2735cc26d7eec3fb..9314696858ff7c84 100644
--- a/tools/perf/tests/backward-ring-buffer.c
+++ b/tools/perf/tests/backward-ring-buffer.c
@@ -167,4 +167,4 @@ static int test__backward_ring_buffer(struct test_suite *test __maybe_unused, in
 	return ret;
 }
 
-DEFINE_SUITE("Read backward ring buffer", backward_ring_buffer);
+DEFINE_SUITE_NEEDS_MLOCK("Read backward ring buffer", backward_ring_buffer);
diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-reading.c
index c50b526f44fb523f..130cd6021f930597 100644
--- a/tools/perf/tests/code-reading.c
+++ b/tools/perf/tests/code-reading.c
@@ -885,4 +885,4 @@ static int test__code_reading(struct test_suite *test __maybe_unused, int subtes
 	};
 }
 
-DEFINE_SUITE("Object code reading", code_reading);
+DEFINE_SUITE_NEEDS_MLOCK("Object code reading", code_reading);
diff --git a/tools/perf/tests/keep-tracking.c b/tools/perf/tests/keep-tracking.c
index b760041bed307859..6d8d8cd57200645d 100644
--- a/tools/perf/tests/keep-tracking.c
+++ b/tools/perf/tests/keep-tracking.c
@@ -161,4 +161,4 @@ static int test__keep_tracking(struct test_suite *test __maybe_unused, int subte
 	return err;
 }
 
-DEFINE_SUITE("Use a dummy software event to keep tracking", keep_tracking);
+DEFINE_SUITE_NEEDS_MLOCK("Use a dummy software event to keep tracking", keep_tracking);
diff --git a/tools/perf/tests/mmap-basic.c b/tools/perf/tests/mmap-basic.c
index 5cec7644952c7dba..02cfe8533ac05036 100644
--- a/tools/perf/tests/mmap-basic.c
+++ b/tools/perf/tests/mmap-basic.c
@@ -448,4 +448,5 @@ static struct test_case tests__basic_mmap[] = {
 struct test_suite suite__basic_mmap = {
 	.desc = "mmap interface tests",
 	.test_cases = tests__basic_mmap,
+	.needs_mlock = true,
 };
diff --git a/tools/perf/tests/openat-syscall-tp-fields.c b/tools/perf/tests/openat-syscall-tp-fields.c
index 5365889d326f8bc7..1ea336fbc7e7c030 100644
--- a/tools/perf/tests/openat-syscall-tp-fields.c
+++ b/tools/perf/tests/openat-syscall-tp-fields.c
@@ -160,4 +160,5 @@ static struct test_case tests__syscall_openat_tp_fields[] = {
 struct test_suite suite__syscall_openat_tp_fields = {
 	.desc = "syscalls:sys_enter_openat event fields",
 	.test_cases = tests__syscall_openat_tp_fields,
+	.needs_mlock = true,
 };
diff --git a/tools/perf/tests/perf-record.c b/tools/perf/tests/perf-record.c
index 0cac6ae1a1fc05ed..370dbde08eac71c3 100644
--- a/tools/perf/tests/perf-record.c
+++ b/tools/perf/tests/perf-record.c
@@ -372,4 +372,5 @@ static struct test_case tests__PERF_RECORD[] = {
 struct test_suite suite__PERF_RECORD = {
 	.desc = "PERF_RECORD_* events & perf_sample fields",
 	.test_cases = tests__PERF_RECORD,
+	.needs_mlock = true,
 };
diff --git a/tools/perf/tests/perf-time-to-tsc.c b/tools/perf/tests/perf-time-to-tsc.c
index f8f71fdd32b1bfed..0cefa2df2db728f8 100644
--- a/tools/perf/tests/perf-time-to-tsc.c
+++ b/tools/perf/tests/perf-time-to-tsc.c
@@ -218,4 +218,5 @@ static struct test_case time_to_tsc_tests[] = {
 struct test_suite suite__perf_time_to_tsc = {
 	.desc = "Convert perf time to TSC",
 	.test_cases = time_to_tsc_tests,
+	.needs_mlock = true,
 };
diff --git a/tools/perf/tests/sw-clock.c b/tools/perf/tests/sw-clock.c
index d181858816352c67..1b62dae55f076d30 100644
--- a/tools/perf/tests/sw-clock.c
+++ b/tools/perf/tests/sw-clock.c
@@ -149,4 +149,4 @@ static int test__sw_clock_freq(struct test_suite *test __maybe_unused, int subte
 	return ret;
 }
 
-DEFINE_SUITE("Software clock events period values", sw_clock_freq);
+DEFINE_SUITE_NEEDS_MLOCK("Software clock events period values", sw_clock_freq);
diff --git a/tools/perf/tests/task-exit.c b/tools/perf/tests/task-exit.c
index 95393edbfe363e5e..9fac426ac2f9eab3 100644
--- a/tools/perf/tests/task-exit.c
+++ b/tools/perf/tests/task-exit.c
@@ -158,4 +158,5 @@ struct test_case tests__task_exit[] = {
 struct test_suite suite__task_exit = {
 	.desc = "Number of exit events of a simple workload",
 	.test_cases = tests__task_exit,
+	.needs_mlock = true,
 };
-- 
2.55.0

