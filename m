Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792592268;
	b=2kV3cWURYsgNr0i5ECv0beqrhrX9bGKkVonsmE3ZspL9OW+9DNbpjAiPfIUKFYO7Nqvw
	 0a4K+pyLABniE22h6iAsMasoFAb0/wTkfOjgWJWeQdHsUgNyN4Z6EQqq8kBS4LR3VjFeA
	 WGdkTYijNkTSK24dbJJnOfrA+aBJy8BQbvxEeInR/v/PLIy90lO2zmLP4gWM3LK1IivC+
	 QB1ko2Q1nlib/RKERj4aansVikm19D3hifpQGgCJXKauxPSbO3yBz0p/kAC57qRAA+AZR
	 vs4sB2+9K7+5DB+K/dckxUgQFO4ntcQ2Bbd0rrCaKz+BuTyp5i57M/HzmzR+bdYpEPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792592268;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=4emiTpWAarBibaAu0jj3yHN8NkMHkhKjP1v4saRY9lo=;
	b=I8b0BUJkl2NY+iL7++S1Y+wjSUewjlqcrJlO13IBZJEDrOA66kYjWhmymJmp4Llt+otO
	 JBK9Y0OHbCCol5/bRfbvAWG0TCwdZ2+OnmienOErFL82KA9dOId/Cln9o6ZkhP525kMTv
	 PJVZTuCpliINluHlM2Dy6gdovpetgUr2usHqx7Yr7DGREM9oB+ZSkayeQIiHLabw1C+U+
	 0q6cZ9quUNcc+IidrMcqMf5OOQPvyuEMf9Qj9S9zS4m2H2IP1zBcW5ZN2rEEycyZPRT2D
	 NlfP/cWTm68V7csIAuaabdLsaxluCyB7rcbKbw2dWm2ZqU1myK8QAvoyJ/Hh4LZpGMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VyreI7FN;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3737606A31F
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2026 14:17:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3737606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VyreI7FN
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a1e34ecb02so5768435e9.2
        for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2026 07:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792592266; x=1793197066; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4emiTpWAarBibaAu0jj3yHN8NkMHkhKjP1v4saRY9lo=;
        b=VyreI7FNndPmp276+/Ls1TtMiMyqPlVb5SMK80jxXjJ06gYDuYEVfOsTplVpQO550F
         LSjlerhYkBCaHixjr3lCMkPdkZfnLXnIAuIytwRWUemQqgLlzT2RZsfM+qU/J7PX0wO8
         oh3Nu22PTMmUkmAv+zTlB5e7yE5M2E42maNravx+0r+eSsl8awdj8F9BDC6I4txtJ7MI
         pnqJYWXW0t6uyiNh/qnX7uRhY1GRt7PEoEnclsj8ZVyt7ddKCBm26Z0mX5ObzGvXoyP+
         LEKqke0LOtvW/kreawGdLeA7u4D1nfuZqdG1iI0OEdl6Cctxlrhy3twcyqGmHkH4n7Fk
         R/XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792592266; x=1793197066;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4emiTpWAarBibaAu0jj3yHN8NkMHkhKjP1v4saRY9lo=;
        b=BS0Ho3heFGoqOaR8Tvs4dxVVkkeX95pQkRn31ya3f+5v2HMJC1JKWtXRmLF5hDaT26
         O1uqqKz0FLpfX6vaDcQ2jM7pe0KleF5Sru3xoHlFpcrXy+HIE5yZJ+nUF/+HnvyFl3OK
         KUSAjXyIxSiNX1T0RyUDhVD+IqQrDC/tpD5qcA4I+WII2Te41MjXS6iOh7rnfWYJJSQE
         pCxrVBR+ZTMFkIef7mPoSXq9p5h0DPc1jRa7VwNE+2wgsScrLIOg6CKvbnuMG6RjN74P
         p4wvrwsPlWqn3eMIN857Uc2L1On5mPd54wfMISa0eCpr1dscP2oq5+9a9XDmWEmxQZLk
         AYBA==
X-Forwarded-Encrypted: i=1; AKwUvBwabIhc1XsWsVtizBgqERXgDwEyH5h9+lPYZl7BA6BzldVHkEAPboaTsY2LgCQRSPxxidjxkM+rjk/bIUvqI3ZI@vger.kernel.org
X-Gm-Message-State: AFq9FYIyp3VtLHjP6sML1ofu+A8BJPSPSF6Zcm7vAM0VgnYehk/rMbLg
	1Mr33k6/16tDKcFksknQLLpAxU8QG9KJ9nEbDd9LwQ0S0z4U/KKdcwet
X-Gm-Gg: AYBFou3MRHkaCue8LCfdgdEnKDwXgW9XdrcHUMGHDmoUVcKojpLu93v+aUs24rvbuKV
	+l4rIKekDE7RoXzWjKeIHez4mVyN3ux6aobvqMJe+y4SGoSnhGWOTXMZfpGKLCrU9N5C4K7+UrC
	Zk++00NR6sp2RshBR4x62z3v4D5YGPQtxM9eRXU1B+FQbdClTHuBqiWfr4tPnbSx08CRy0atgf9
	r9SkXyk+f18PVpdJD+Yg3RZfYDeKXOXFmqS8rxOzeFb0Ne08Fc6DTn8ZidThhBqP9OvS4pv3LXW
	9CmvQItmWMqenAmWarVi/A2e284eZCZQz0VtMxpmhfXa6jsL2+oGlsJxm+CZc00I7Av6Lk4UbS5
	zBvBkkMFHP/JekBYhxZXGQ5JlB+TXZp6Q4kZbv9ANDok7vKDdJIlkkR8xUMbcL2wP4YcbJulJiY
	7YkUMKHB7J8CMj3KqWn+9DQmoyZM43sZqApMEuiPIbYtXP85+ryZlyAxgVZRoF3K+N02UBPtez4
	nu9otG6si+eCcvlP7fYh2LB03z7Fl/CePMbWhgbRGXSfcoikDZxKjXrT9UZ5Yz+0Tw=
X-Received: by 2002:a05:600c:3492:b0:4a1:e4c4:f6a9 with SMTP id 5b1f17b1804b1-4a1fdd3d479mr46131875e9.23.1792592265996;
        Wed, 21 Oct 2026 07:17:45 -0700 (PDT)
Received: from fedora ([2.35.202.135])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1fb83ff0dsm103238355e9.7.2026.10.21.07.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 07:17:45 -0700 (PDT)
From: Francesco Nigro <nigro.fra@gmail.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org
Cc: mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	james.clark@linaro.org,
	kan.liang@linux.intel.com,
	leo.yan@arm.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev,
	Francesco Nigro <nigro.fra@gmail.com>
Subject: [PATCH v2] perf test: Add test for events re-armed with PERF_EVENT_IOC_REFRESH
Date: Wed, 21 Oct 2026 16:17:36 +0200
Message-ID: <20261021141736.2414170-1-nigro.fra@gmail.com>
X-Mailer: git-send-email 2.55.0
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Open a sampling event with sample_period 1, re-arm it with
PERF_EVENT_IOC_REFRESH from its overflow signal handler, as
self-profilers such as async-profiler do, and check that each of 1000
events delivers a signal. One case uses a software event (page faults),
the other the syscalls:sys_enter_getppid tracepoint. The signal is a
real-time one, so overflows cannot be coalesced, and the page fault
buffer is marked MADV_NOHUGEPAGE so that each touched page faults once.

The tracepoint case fails since
commit 18dbcbfabfff ("perf: Fix the POLL_HUP delivery breakage"):
only the first overflow is delivered. The re-arming ioctl succeeds,
but the event count stays at 1. It passes on the parent commit. The
software case passes on both.

The test was written with an AI coding assistant (Claude) from a
standalone reproducer; I reviewed it and ran it in QEMU on current
mainline, on that commit and on its parent.

Link: https://github.com/async-profiler/async-profiler/issues/1813
Signed-off-by: Francesco Nigro <nigro.fra@gmail.com>
---

Notes:
    v2:
    - Mark the page fault buffer MADV_NOHUGEPAGE: with transparent_hugepage=always
      the software case got 489 of 1000 overflows (reported by Sashiko).
    - Use a real-time signal instead of SIGIO, so overflows cannot be coalesced.
    - Print the event count, POLL_HUP signals and the re-arm ioctl's errno.
    - Skip only on EACCES/EPERM, check the setup calls, accept >= 1000
      overflows, close the event before restoring the signal handler.
    
    v1: https://lore.kernel.org/r/20261021131006.2101248-1-nigro.fra@gmail.com
    
    To run it on any x86_64 box with virtme-ng:
    
      vng --kconfig && make -j$(nproc)
      make -C tools/perf NO_LIBTRACEEVENT=1
      vng -- tools/perf/perf test -vv REFRESH
    
    Tracepoint case, 2 vCPUs:
    
      b320789d6883 (parent)  Ok:     count 1000, 1000 overflows (1000 POLL_HUP)
      18dbcbfabfff           FAILED: count 1, 1 overflows (1 POLL_HUP), re-arm errno 0
      a804c5742bff (master)  FAILED: count 1, 1 overflows (1 POLL_HUP), re-arm errno 0
    
    The software case passes on all three, and on master with
    transparent_hugepage=always.
    
    Leo Yan's series "perf: Revert direct PMU stop for refresh limit"
    reverts 18dbcbfabfff for a different reason; I haven't tested it
    against this:
    https://lore.kernel.org/r/20260512-arm_cs_clean_perf_handle-v1-0-75ff373ecd22@arm.com
    
    #regzbot introduced: 18dbcbfabfff

 tools/perf/tests/Build           |   1 +
 tools/perf/tests/builtin-test.c  |   1 +
 tools/perf/tests/event_refresh.c | 162 +++++++++++++++++++++++++++++++
 tools/perf/tests/tests.h         |   1 +
 4 files changed, 165 insertions(+)
 create mode 100644 tools/perf/tests/event_refresh.c

diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
index 66944a4f4..199e10c8c 100644
--- a/tools/perf/tests/Build
+++ b/tools/perf/tests/Build
@@ -23,6 +23,7 @@ perf-test-y += hists_output.o
 perf-test-y += hists_cumulate.o
 perf-test-y += bp_signal.o
 perf-test-y += bp_signal_overflow.o
+perf-test-y += event_refresh.o
 perf-test-y += bp_account.o
 perf-test-y += wp.o
 perf-test-y += task-exit.o
diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 4d0784b16..2b10f4d7f 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -98,6 +98,7 @@ static struct test_suite *generic_tests[] = {
 	&suite__hists_link,
 	&suite__bp_signal,
 	&suite__bp_signal_overflow,
+	&suite__event_refresh,
 	&suite__bp_accounting,
 	&suite__wp,
 	&suite__task_exit,
diff --git a/tools/perf/tests/event_refresh.c b/tools/perf/tests/event_refresh.c
new file mode 100644
index 000000000..726e5de4c
--- /dev/null
+++ b/tools/perf/tests/event_refresh.c
@@ -0,0 +1,162 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Re-arm a sampling event from its overflow signal handler with
+ * PERF_EVENT_IOC_REFRESH and check that every overflow is delivered.
+ */
+#include <errno.h>
+#include <fcntl.h>
+#include <inttypes.h>
+#include <signal.h>
+#include <string.h>
+#include <unistd.h>
+#include <sys/ioctl.h>
+#include <sys/mman.h>
+#include <sys/syscall.h>
+#include <linux/perf_event.h>
+
+#include "cloexec.h"
+#include "debug.h"
+#include "tests.h"
+#include "tp_pmu.h"
+#include <internal/lib.h> // page_size
+#include "../perf-sys.h"
+
+#define NR_EVENTS 1000
+/* A real-time signal is queued, so no overflow can be coalesced away. */
+#define REFRESH_SIGNAL (SIGRTMIN + 1)
+
+static volatile sig_atomic_t overflows, hups, refresh_errno;
+
+static void sig_handler(int signum __maybe_unused, siginfo_t *info,
+			void *uc __maybe_unused)
+{
+	int saved_errno = errno;
+
+	overflows++;
+	if (info->si_code == POLL_HUP)
+		hups++;
+	if (ioctl(info->si_fd, PERF_EVENT_IOC_REFRESH, 1) < 0)
+		refresh_errno = errno;
+	errno = saved_errno;
+}
+
+/* Count overflow signals for NR_EVENTS calls of trigger(), period 1. */
+static int count_overflows(struct perf_event_attr *attr, void (*trigger)(int i))
+{
+	struct sigaction sa, old_sa;
+	uint64_t count = 0;
+	int fd, i, err = TEST_FAIL;
+
+	attr->size = sizeof(*attr);
+	attr->sample_period = 1;
+	attr->disabled = 1;
+
+	fd = sys_perf_event_open(attr, 0, -1, -1, perf_event_open_cloexec_flag());
+	if (fd < 0) {
+		int open_errno = errno;
+
+		pr_debug("failed opening event: %s\n", strerror(open_errno));
+		return open_errno == EACCES || open_errno == EPERM ? TEST_SKIP : TEST_FAIL;
+	}
+
+	memset(&sa, 0, sizeof(sa));
+	sa.sa_sigaction = sig_handler;
+	sa.sa_flags = SA_SIGINFO;
+	if (sigaction(REFRESH_SIGNAL, &sa, &old_sa) < 0) {
+		pr_debug("failed setting up signal handler\n");
+		close(fd);
+		return TEST_FAIL;
+	}
+
+	if (fcntl(fd, F_SETFL, O_RDWR | O_NONBLOCK | O_ASYNC) < 0 ||
+	    fcntl(fd, F_SETSIG, REFRESH_SIGNAL) < 0 ||
+	    fcntl(fd, F_SETOWN, getpid()) < 0) {
+		pr_debug("failed setting up signal delivery: %s\n", strerror(errno));
+		goto out;
+	}
+
+	overflows = 0;
+	hups = 0;
+	refresh_errno = 0;
+	if (ioctl(fd, PERF_EVENT_IOC_REFRESH, 1) < 0) {
+		pr_debug("PERF_EVENT_IOC_REFRESH failed: %s\n", strerror(errno));
+		goto out;
+	}
+	for (i = 0; i < NR_EVENTS; i++)
+		trigger(i);
+	ioctl(fd, PERF_EVENT_IOC_DISABLE, 0);
+
+	if (read(fd, &count, sizeof(count)) != sizeof(count))
+		pr_debug("failed to read the event count\n");
+	pr_debug("%d events, count %" PRIu64 ", %d overflows (%d POLL_HUP), re-arm errno %d\n",
+		 NR_EVENTS, count, overflows, hups, refresh_errno);
+	/* Unrelated page faults can only add overflows, never hide one. */
+	if (overflows >= NR_EVENTS)
+		err = TEST_OK;
+out:
+	/* Close first: a late signal must still find our handler. */
+	close(fd);
+	sigaction(REFRESH_SIGNAL, &old_sa, NULL);
+	return err;
+}
+
+static char *pages;
+
+static void touch_page(int i)
+{
+	pages[(long)i * page_size] = 1;
+}
+
+static int test__event_refresh_sw(struct test_suite *test __maybe_unused,
+				  int subtest __maybe_unused)
+{
+	struct perf_event_attr attr = {
+		.type = PERF_TYPE_SOFTWARE,
+		.config = PERF_COUNT_SW_PAGE_FAULTS,
+	};
+	int err;
+
+	pages = mmap(NULL, (long)NR_EVENTS * page_size, PROT_READ | PROT_WRITE,
+		     MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	if (pages == MAP_FAILED)
+		return TEST_FAIL;
+	/* One fault per touched page: a huge page would cover many of them. */
+	madvise(pages, (long)NR_EVENTS * page_size, MADV_NOHUGEPAGE);
+
+	err = count_overflows(&attr, touch_page);
+	munmap(pages, (long)NR_EVENTS * page_size);
+	return err;
+}
+
+static void call_getppid(int i __maybe_unused)
+{
+	syscall(SYS_getppid);
+}
+
+static int test__event_refresh_tp(struct test_suite *test __maybe_unused,
+				  int subtest __maybe_unused)
+{
+	struct perf_event_attr attr = {
+		.type = PERF_TYPE_TRACEPOINT,
+	};
+	int id = tp_pmu__id("syscalls", "sys_enter_getppid");
+
+	if (id < 0) {
+		pr_debug("no syscalls:sys_enter_getppid tracepoint\n");
+		return TEST_SKIP;
+	}
+	attr.config = id;
+
+	return count_overflows(&attr, call_getppid);
+}
+
+static struct test_case tests__event_refresh[] = {
+	TEST_CASE_REASON("Software event", event_refresh_sw, "permissions"),
+	TEST_CASE_REASON("Tracepoint event", event_refresh_tp, "permissions"),
+	{	.name = NULL, }
+};
+
+struct test_suite suite__event_refresh = {
+	.desc = "Event re-armed with PERF_EVENT_IOC_REFRESH",
+	.test_cases = tests__event_refresh,
+};
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index cee9e6b62..ecc25b5a3 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -124,6 +124,7 @@ DECLARE_SUITE(parse_events);
 DECLARE_SUITE(hists_link);
 DECLARE_SUITE(bp_signal);
 DECLARE_SUITE(bp_signal_overflow);
+DECLARE_SUITE(event_refresh);
 DECLARE_SUITE(bp_accounting);
 DECLARE_SUITE(wp);
 DECLARE_SUITE(task_exit);
-- 
2.55.0

