Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709E9286D5E;
	Wed, 13 Aug 2025 16:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755102808; cv=none; b=T77l/Xu8/X8DDsNcBiEHcletYP0mI1dyM/OUxFMsICHuaMMesDz5KWe8FzW4MUaYzJvFDMzyMWUSTUOipETbMN8Uf1TWdT3t6bydmxZqiKIJyhEi0bUHgUx6jUE9bzUNLX7L5esn+Fu1CC6V9zrXyfxPvJMqGMFrenfFA/iFJxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755102808; c=relaxed/simple;
	bh=x1ZKOZTYJGF/U2kjdvtZsaZAne1mqWiZ05vJsY4xHOE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WVsOcEre/a6xoqLOdzkVIAyzIc6dAyBFqJbBiQvIBOle2SRB49eHVkEsqg7oNyrZQRhUmGSUjWTxAL1xwxSJbkzYd7/AAZQOybJ1ufdf4RQ8GP0c3IMDtxmxMOACNptachcpB/SeHO9qxR4yngjESq/sSaWOjFOLtdw6D7GE+aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-76e2ead79b5so8379b3a.3;
        Wed, 13 Aug 2025 09:33:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755102806; x=1755707606;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AAxyR26sD/UmhZtDKgGa8VSqHxpVk6CfvVa4/B4m1GI=;
        b=peYtGTO0GSwqtuKojFgX84qYGwua6po1nat/1aQuMBhekJ8rDuz9MqG3Pe+Yr+oOwh
         USAeIRDAMbXkrqrScrxslJuZjtjtimn86eX8xBGnXEOlhQM5SAWKd48XUheKzRWwAb7H
         wQhtilb5PeF5id6o8IY0iQqW1FLL1DoWZJAlfHkzEJq/mlS/ujPOBvs12DGMLocveevD
         ltsdBtaUeKMBSQ1n8Bf4V3TJk9AvgBz+f5n3WhZ9U3V2vNFCgEMq0mF0KskuRHuHOEUn
         6olJK95oMori4JZckuvRXohbRW3LpuM+7tnOtk68Bd4fuwwdyahN3utlADnbPCiv/cya
         48Mw==
X-Forwarded-Encrypted: i=1; AJvYcCU+K7v3xGCbbESLXTKtcftqAxF04WKqT7x4jc8FUOixFPdcKo676XAACZl06/9AVj2ka25PNg2QKR6cD9Z6aTr5dg==@vger.kernel.org, AJvYcCWAjIKB5mOjwYgvD3qJpfUlVlgdSHBXOP9Asv4xpySKApEzlpVNZpJqkIDeCIMMTkmwrgFaOMLYdhX7FD4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnhepjIeVXPnfug7b7BeKsWLq+vUrQgCeDUdmu6Qn0eu+6oGXV
	nnu8SMKRzmdzHq0nqUf7CENYpamQ1l7R1qkahre9CzeUqBfVFqWMHvdh
X-Gm-Gg: ASbGncvo170/oR6L+lC9iYxxE4r7w6bJBBstjz1/6O1tDLFcDccQEmaTASv3HY+cpIA
	a+cXUvTdV0+0zOLP4/JsV4eLL+M5hlKbnD+OjyznYARmnz0Ycxui4KNbXFstfts7r1eO/sPidCV
	JLIKqNoXZpmFXB8sCrALRqSebEqq1UXKIyB7Nw3MCyEKK7ebiT4HTk+HwgLyaQwgjSglX9bQqm2
	vWrr6innf2L8XhjOAZ9mHxGBbe7xphYqJ9IwHE6RZDpr29RDZ0bzadFLCDjhkXYNYP4BgnLbzEe
	Vc3a8f2liPBzc5wRLvdc1Cs5wHYV4Jmq5SGdOGvA4uvRRIv1nAHI+o2d+rK5ofm6C/5uPM99lFM
	pzyCw283fCJ0j
X-Google-Smtp-Source: AGHT+IFd3ois8abXh2r0TeOVO5d30+2A5zCsUiP9wARw2gZzASwYYVLMa1p6/doAC9ierLEznR1A5g==
X-Received: by 2002:a05:6a00:b82:b0:76b:cdf5:f4ba with SMTP id d2e1a72fcca58-76e20f8c3b9mr2347472b3a.4.1755102805573;
        Wed, 13 Aug 2025 09:33:25 -0700 (PDT)
Received: from localhost ([218.152.98.97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccd45dffsm32483556b3a.0.2025.08.13.09.33.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 09:33:25 -0700 (PDT)
From: Yunseong Kim <ysk@kzalloc.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Liang Kan <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	Collin Funk <collin.funk1@gmail.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Yunseong Kim <ysk@kzalloc.com>
Subject: [PATCH] perf test: Add test case for event group throttling with inactive events
Date: Wed, 13 Aug 2025 16:32:52 +0000
Message-ID: <20250813163251.490451-2-ysk@kzalloc.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A recent UBSAN shift-out-of-bounds report was identified when throttling
event groups that included inactive (PERF_EVENT_STATE_OFF) events.
This occurred because pmu->start()/stop() could be called on these events,
potentially leaving event->hw.idx at -1. This leads to undefined behavior
when PMU code later uses this negative index as a shift exponent.

The issue need to ensuring perf_event_throttle() and
perf_event_unthrottle() skip inactive events entirely.

Introduce a new perf test suite, "event group throttle", to verify this
fix and prevent regressions.

The test sets up a scenario designed to trigger frequent throttling:
1. A parent event (leader) is created with sample_period = 1.
2. A child event is created in the same group but initialized with
   disabled = 1 (inactive).

A process opens these events and runs in a tight loop. The frequent
sampling of the leader causes the entire group, including the inactive
child event, to be rapidly throttled and unthrottled by the kernel.

The test monitors /dev/kmsg during execution, looking for "UBSAN",
"Invalid PMEV" "WARNING:", or "BUG:" messages.

To ensure robustness and avoid false positives from unrelated prior kernel
messages, the test opens /dev/kmsg and uses lseek(SEEK_END) to skip all
existing log entries before starting the test loop. If /dev/kmsg cannot be
accessed or seeked (e.g., lack of CAP_SYSLOG), the test handles it
appropriately by skipping or failing.

Related Reproducer by Mark Rutland
Link: https://lore.kernel.org/lkml/aIEePonPatjNrJVk@J2N7QTR9R3/

Related Kernel Fix
Link: https://lore.kernel.org/lkml/20250812012722.127646-1-ysk@kzalloc.com/
Cc: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Yunseong Kim <ysk@kzalloc.com>
---
 tools/perf/tests/Build                  |   1 +
 tools/perf/tests/builtin-test.c         |   1 +
 tools/perf/tests/event_group_throttle.c | 132 ++++++++++++++++++++++++
 tools/perf/tests/tests.h                |   1 +
 4 files changed, 135 insertions(+)
 create mode 100644 tools/perf/tests/event_group_throttle.c

diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
index 3e8394be15ae..e22e2f285500 100644
--- a/tools/perf/tests/Build
+++ b/tools/perf/tests/Build
@@ -70,6 +70,7 @@ perf-test-y += util.o
 perf-test-y += hwmon_pmu.o
 perf-test-y += tool_pmu.o
 perf-test-y += subcmd-help.o
+perf-test-y += event_group_throttle.o
 
 ifeq ($(SRCARCH),$(filter $(SRCARCH),x86 arm arm64 powerpc))
 perf-test-$(CONFIG_DWARF_UNWIND) += dwarf-unwind.o
diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 85142dfb3e01..d302bf9d1535 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -141,6 +141,7 @@ static struct test_suite *generic_tests[] = {
 	&suite__symbols,
 	&suite__util,
 	&suite__subcmd_help,
+	&suite__event_group_throttle,
 	NULL,
 };
 
diff --git a/tools/perf/tests/event_group_throttle.c b/tools/perf/tests/event_group_throttle.c
new file mode 100644
index 000000000000..7d5191d7e812
--- /dev/null
+++ b/tools/perf/tests/event_group_throttle.c
@@ -0,0 +1,132 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <stdlib.h>
+#include <unistd.h>
+#include <time.h>
+#include <sys/wait.h>
+#include <signal.h>
+#include <sys/syscall.h>
+#include <sys/types.h>
+#include <string.h>
+#include <stdio.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <errno.h>
+#include <linux/perf_event.h>
+#include "perf-sys.h"
+#include "tests.h"
+#include "debug.h"
+
+static struct perf_event_attr attr_parent = {
+	.type = PERF_TYPE_HARDWARE,
+	.size = sizeof(attr_parent),
+	.config = PERF_COUNT_HW_CPU_CYCLES,
+	.sample_period = 1,
+	.exclude_kernel = 1,
+};
+
+static struct perf_event_attr attr_child = {
+	.type = PERF_TYPE_HARDWARE,
+	.size = sizeof(attr_child),
+	.config = PERF_COUNT_HW_CPU_CYCLES,
+	.exclude_kernel = 1,
+	.disabled = 1,
+};
+
+static pid_t run_event_group_throttle(void)
+{
+	pid_t pid = fork();
+
+	if (pid == 0) {
+		int parent, child;
+
+		parent = sys_perf_event_open(&attr_parent, 0, -1, -1, 0);
+		if (parent < 0) {
+			pr_debug("Unable to create event: %d\n", parent);
+			exit(-1);
+		}
+
+		child = sys_perf_event_open(&attr_child, 0, -1, parent, 0);
+		if (child < 0) {
+			pr_debug("Unable to create event: %d\n", child);
+			exit(-1);
+		}
+
+		for (;;)
+			asm("" ::: "memory");
+
+		_exit(0);
+	}
+	return pid;
+}
+
+static bool is_kmsg_err(int fd)
+{
+	char buf[1024];
+	ssize_t len;
+
+	while ((len = read(fd, buf, sizeof(buf) - 1)) > 0) {
+		buf[len] = '\0';
+
+		if (strstr(buf, "UBSAN") || strstr(buf, "WARNING:") ||
+		    strstr(buf, "BUG:") || strstr(buf, "Invalid PMEV")) {
+			pr_debug("Kernel log error detected: %s", buf);
+			return true;
+		}
+	}
+
+	if (len < 0 && errno != EAGAIN) {
+		pr_debug("Error reading /dev/kmsg: %s\n", strerror(errno));
+		return true;
+	}
+
+	return false;
+}
+
+static int test__event_group_throttle(struct test_suite *test __maybe_unused,
+				int subtest __maybe_unused)
+{
+	time_t start;
+	pid_t pid;
+	int fd;
+
+	fd = open("/dev/kmsg", O_RDONLY | O_NONBLOCK);
+	if (fd < 0) {
+		/*
+		 * If /dev/kmsg cannot be opened (e.g. permission denied), skip the test
+		 * as we cannot verify the absence of kernel errors.
+		 */
+		pr_debug("Failed to open /dev/kmsg: %s. Skipping test.\n", strerror(errno));
+		return TEST_SKIP;
+	}
+
+	/*
+	 * Seek to the end to ignore past events (like EFI boot warnings).
+	 * This typically requires CAP_SYSLOG.
+	 */
+	if (lseek(fd, 0, SEEK_END) < 0) {
+		pr_debug("Failed to seek to end of /dev/kmsg: %s\n", strerror(errno));
+		return TEST_FAIL;
+	}
+
+	start = time(NULL);
+	do {
+		pr_debug("Starting event group throttling...\n");
+		pid = run_event_group_throttle();
+
+		sleep(8);
+
+		pr_debug("event group throttler(PID=%d)\n", pid);
+		kill(pid, SIGKILL);
+		waitpid(pid, NULL, 0);
+
+		/* Check for errors during the run */
+		if (is_kmsg_err(fd)) {
+			close(fd);
+			return TEST_FAIL;
+		}
+	} while (time(NULL) - start < 10);
+
+	return TEST_OK;
+}
+
+DEFINE_SUITE("event group throttle", event_group_throttle);
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index 97e62db8764a..031856a710b2 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -179,6 +179,7 @@ DECLARE_SUITE(event_groups);
 DECLARE_SUITE(symbols);
 DECLARE_SUITE(util);
 DECLARE_SUITE(subcmd_help);
+DECLARE_SUITE(event_group_throttle);
 
 /*
  * PowerPC and S390 do not support creation of instruction breakpoints using the
-- 
2.50.0

