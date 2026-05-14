Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B3EB33A6EB;
	Thu, 14 May 2026 16:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778775706; cv=none; b=kFhKhZ+Zq4MDzx7yWSibDiyK/Psle0p8Q2ByHeORMt8xQ1L9IaYTBtBioKk6AdukSduubnFVjXcH/M5CqcvSSGRORsI/LW9eXTvum9KmFD0loXbvCJzA4SRYEUJZuEMOWM70bM8mC2YDzaCspCqbDuGn62Kn7wehgEleQUVt+GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778775706; c=relaxed/simple;
	bh=2a0gpR2LbWiiGVQTO6Zhnp1bBsKU4mNG4BJxn2FWJco=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WNQVedllE6nR+PrOwNzUXNjngqzcjK4EGQdOxPAEnGeVv5fHn4zeBy0DIKgLrJrFrk37g3o/Lm3TgjbK1MTBJSbizibk8DYMaU6FinYHjd9wC3Z9QmDX1uaByyQl1BdK81j7V70+3ltD8hv2goBHsOzBt2wveybPFJJRLCA2YtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=QkVIKRNN; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="QkVIKRNN"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EE0A42682;
	Thu, 14 May 2026 09:21:30 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A60B53F7B4;
	Thu, 14 May 2026 09:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1778775696; bh=2a0gpR2LbWiiGVQTO6Zhnp1bBsKU4mNG4BJxn2FWJco=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=QkVIKRNNg+ImYHcXvReCOU8VZjOd2YOvpJ/v+e46bFgviKI+gJ36MqIhmJtKwnCvB
	 7Dsa5pmSk/9C62RiMq39waLD0lo3DaM4OSUBXUmMYME+oqlNRLvJlyGx7iue8BP+fm
	 J63gqX60YtWavvkUWD/DVMgRNlcu24og4ZM6bsbI=
From: Leo Yan <leo.yan@arm.com>
Date: Thu, 14 May 2026 17:21:19 +0100
Subject: [PATCH v2 1/2] selftests/perf_events: Add test for refresh limit
 signals
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260514-arm_cs_clean_perf_handle-v2-1-cbb29c3b3661@arm.com>
References: <20260514-arm_cs_clean_perf_handle-v2-0-cbb29c3b3661@arm.com>
In-Reply-To: <20260514-arm_cs_clean_perf_handle-v2-0-cbb29c3b3661@arm.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, 
 Sumanth Korikkar <sumanthk@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778775688; l=5909;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=2a0gpR2LbWiiGVQTO6Zhnp1bBsKU4mNG4BJxn2FWJco=;
 b=uaBy9NcvV6fV2loqLj+4z1V296PWlNlsfMWVow/AfT/ha+0QMpr1QSQpuwETgzK/TEm2sPyWq
 ISGptNSsMXwC2m7jWFFjUgQ73dxOKeJ1kxfQk0y2+HKEeZsAn4e+/64
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

perf reports POLL_IN for overflows while an event still has refreshes
left, and POLL_HUP when the refresh count reaches zero and the event is
disabled.

Add a test to verify PERF_EVENT_IOC_REFRESH with a task-clock software
event. Use a real-time signal so notifications are queued instead of
being coalesced.

Each iteration sets the refresh count to 5 and waits for a POLL_HUP
notification after 5 task-clock overflows at a 1 microsecond interval.
The sequence is repeated 100 times, verifying that exactly one POLL_HUP
notification is delivered per iteration. The test is bounded by
the default selftest timeout (30 seconds).

    POLL_IN             POLL_HUP
    e1   e2   e3   e4   e5        |
    |    |    |    |    |         |
  --+----+----+----+----+---------+----------------------
    <-----      Iter 1      -----> <--- Iter2 ... --->

POLL_IN is allowed to be lower than the theoretical maximum because
overflow delivery is deferred through irq_work. If timers expire too
close to each other, pending irq_work may not run before the next timer
expires, so some POLL_IN notifications can be missed.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/testing/selftests/perf_events/.gitignore     |   1 +
 tools/testing/selftests/perf_events/Makefile       |   3 +-
 .../testing/selftests/perf_events/refresh_signal.c | 120 +++++++++++++++++++++
 3 files changed, 123 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/perf_events/.gitignore b/tools/testing/selftests/perf_events/.gitignore
index 4931b3b6bbd3971145b0e09b1fcdaf6cae9eb10e..e1bcf3ab8ab24bdb742a9cd593810c1c566d4b20 100644
--- a/tools/testing/selftests/perf_events/.gitignore
+++ b/tools/testing/selftests/perf_events/.gitignore
@@ -3,3 +3,4 @@ sigtrap_threads
 remove_on_exec
 watermark_signal
 mmap
+refresh_signal
diff --git a/tools/testing/selftests/perf_events/Makefile b/tools/testing/selftests/perf_events/Makefile
index 2e5d85770dfeadd909196dbf980fd334b9580477..e0591b1045f959476a0c5bb57e471a01006b66ee 100644
--- a/tools/testing/selftests/perf_events/Makefile
+++ b/tools/testing/selftests/perf_events/Makefile
@@ -2,5 +2,6 @@
 CFLAGS += -Wl,-no-as-needed -Wall $(KHDR_INCLUDES)
 LDFLAGS += -lpthread
 
-TEST_GEN_PROGS := sigtrap_threads remove_on_exec watermark_signal mmap
+TEST_GEN_PROGS := sigtrap_threads remove_on_exec watermark_signal mmap \
+		  refresh_signal
 include ../lib.mk
diff --git a/tools/testing/selftests/perf_events/refresh_signal.c b/tools/testing/selftests/perf_events/refresh_signal.c
new file mode 100644
index 0000000000000000000000000000000000000000..5519ea7b56f9dc7aea31e53698bb201bcd76b241
--- /dev/null
+++ b/tools/testing/selftests/perf_events/refresh_signal.c
@@ -0,0 +1,120 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+
+#include <fcntl.h>
+#include <linux/perf_event.h>
+#include <poll.h>
+#include <signal.h>
+#include <sys/ioctl.h>
+#include <time.h>
+
+#include "../kselftest_harness.h"
+
+#define RT_SIG			(SIGRTMIN + 1)
+
+#define EVENT_LIMIT		5
+#define ITERATIONS		100
+
+static struct {
+	volatile sig_atomic_t in;
+	volatile sig_atomic_t hup;
+} count;
+
+static void sigio_handler(int signo __maybe_unused, siginfo_t *info,
+			  void *ucontext __maybe_unused)
+{
+	switch (info->si_code) {
+	case POLL_IN:
+		count.in++;
+		break;
+	case POLL_HUP:
+		count.hup++;
+		break;
+	}
+}
+
+FIXTURE(refresh_signal)
+{
+	struct sigaction old_sa;
+	int fd;
+};
+
+FIXTURE_SETUP(refresh_signal)
+{
+	struct sigaction sa = { 0 };
+	struct perf_event_attr attr = { 0 };
+
+	sa.sa_sigaction = sigio_handler;
+	sa.sa_flags = SA_SIGINFO;
+	sigemptyset(&sa.sa_mask);
+
+	/* Use a real-time signal so notifications are reliably queued */
+	EXPECT_EQ(sigaction(RT_SIG, &sa, &self->old_sa), 0);
+
+	attr.size = sizeof(attr);
+	attr.type = PERF_TYPE_SOFTWARE;
+	attr.config = PERF_COUNT_SW_TASK_CLOCK;
+	attr.disabled = 1;
+	attr.sample_period = 1000;	/* 1 us */
+	attr.exclude_kernel = 1;
+	attr.exclude_hv = 1;
+
+	self->fd = syscall(__NR_perf_event_open, &attr, 0, -1, -1, 0);
+	ASSERT_NE(self->fd, -1);
+
+	/* Enable async notification */
+	ASSERT_EQ(fcntl(self->fd, F_SETFL, fcntl(self->fd, F_GETFL) | O_ASYNC), 0);
+
+	/* Receive the signal for current process */
+	ASSERT_EQ(fcntl(self->fd, F_SETOWN, getpid()), 0);
+
+	/* Use signo instead of the default SIGIO */
+	ASSERT_EQ(fcntl(self->fd, F_SETSIG, RT_SIG), 0);
+}
+
+FIXTURE_TEARDOWN(refresh_signal)
+{
+	EXPECT_EQ(ioctl(self->fd, PERF_EVENT_IOC_DISABLE, 0), 0);
+
+	close(self->fd);
+	sigaction(RT_SIG, &self->old_sa, NULL);
+}
+
+TEST_F(refresh_signal, refresh_stress)
+{
+	int i;
+
+	ASSERT_EQ(ioctl(self->fd, PERF_EVENT_IOC_RESET, 0), 0);
+
+	for (i = 0; i < ITERATIONS; i++) {
+		sig_atomic_t old_count = count.hup;
+
+		/* Set event limit and the event is enabled */
+		ASSERT_EQ(ioctl(self->fd, PERF_EVENT_IOC_REFRESH, EVENT_LIMIT), 0);
+
+		/*
+		 * Wait for new the POLL_HUP notification. The test is bounded
+		 * by the default timeout.
+		 */
+		while (old_count == count.hup)
+			;
+	}
+
+	/*
+	 * Events before EVENT_LIMIT are reported as POLL_IN. When the limit
+	 * is reached, the final event is reported as POLL_HUP. The total
+	 * number of events is scaled by the number of iterations.
+	 *
+	 * Events are delivered via irq_work. If timers expire too close to
+	 * each other, irq_work may not run before the next timer fires,
+	 * causing some POLL_IN events to be missed. Therefore, use a
+	 * less-or-equal comparison for POLL_IN.
+	 *
+	 * The last event stops the timer, so the POLL_HUP signal must be
+	 * observed once per iteration when the limit is reached.
+	 */
+	EXPECT_LE(count.in, (EVENT_LIMIT - 1) * ITERATIONS);
+	EXPECT_EQ(count.hup, ITERATIONS);
+}
+
+TEST_HARNESS_MAIN

-- 
2.34.1

