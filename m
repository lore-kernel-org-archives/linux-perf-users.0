Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D2C5158B6;
	Tue, 13 Oct 2026 20:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791922524; cv=none; b=ADgIkc5zxOZk/Zzz+QsBkYmAoEoBKkltJhag4DoQTd0vJ6s3nqHvYBiVSRlG9HAsFVvnUfEP3IWgTqyIy4vfk6Te3r6eE5Esrcl6LBez3xM5vEsR20wCTGMCdqZvgZrWb664kamdCDdRoBXWVjQHgwintGGGF900k0YSo3ltfek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791922524; c=relaxed/simple;
	bh=iRJ9HE8noqrW28PYTDJ2HxMYxU56nR8+RiAyQWdSljg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r1dGE0Adnm8W+VLFQuYYgXM3JmZNZxD94J9qBT+BWEf86mQ1c9CU9FcQnAd48nWl+ql+QmerlyTCmxCAxONerss9oJC5KTsIJyzAn5FT16ma5DLClwfqhHc4cqEyHdlW7Cluq3yb8ZkuUCgGoZHI0NkGrW+FrZ0LjxANjwv+3HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mJCv1x9q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mJCv1x9q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9A3B1F00899;
	Tue, 13 Oct 2026 20:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791922518;
	bh=a0kj66xrl2sfWln++ekh845XZE9AxjG2ybNI2NnsNpo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mJCv1x9qDc6xdP2CLL3cpveT6oOnZjDFlLPG9ZBGjIZI1uFwVHl5oBHodolZrWDod
	 RqwA4oiUi1xeozDxMNWvFjZpxXAW1VwrqZj4l830YD6u1XLN7ECbKospWVWeiwsR6g
	 mgU9HFyVYI8pYaKEMabv+PyH8tFwH9PIfw3nEmRsxeL7EIxvXVTxlMd1wAybw3Uz4/
	 eDL5gQW2ohVXuZ4Pnns8EP3IBNL9mVEfuAuazuyqNXrbEdMyj6S8j4Az45N2TjTpmD
	 WrUaYymUlVedXb6pUFgYMnNAAbkhwIkOJxAMSy0WCZUbDGHDaHfENLCSsQNPQkieWx
	 RKbyaQ8nbUaqA==
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
Subject: [PATCH v2 18/19] perf tests: Mark the C tests mapping perf ring buffers
Date: Tue, 13 Oct 2026 17:14:13 -0300
Message-ID: <20261013201415.36428-19-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261013201415.36428-1-acme@kernel.org>
References: <20261013201415.36428-1-acme@kernel.org>
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
flag, see the previous changes, so that they take turns using that
budget while the tests that don't map them keep running in parallel.

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

