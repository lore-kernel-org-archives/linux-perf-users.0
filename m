Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D2A29BDA6
	for <linux-perf-users@vger.kernel.org>; Fri, 22 Aug 2025 17:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755884859; cv=none; b=qyJp4vzoKWe3hU/IuOGLUWxsmL2EpJMKNj7mXdFc4OnefTGG3uauSgqQJXp1ZZgCNuSOHr4yuOJhuwTEX7GjU7H0q/9lE/J87FLW+OxTiJp8nxwvHGDWLfpey3D1OuNMJSOeGu+SuxThczIcmpiZfXNXAAVrLcbpsaPu7ny1wc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755884859; c=relaxed/simple;
	bh=Tewu1o9TEDAwro0wIjOKO+bdoL8MBTkvGl+q4i50X14=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f5o2NvZ9v9uFvIpCiH0QpjC4g1QnU3JRXhAZk6MaI84zyjSD+m9elo6uA5Y5DzrwSiRQ/77WADSNJP/ejgt1d+4su/BjkNwjxiVYJIeG1lyYjAQNB2fH3p8bRe2TtjAJaawRHsIXfwtCYAZ/CWANjiGX2UfiK/d/STNX0SCFvqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=H9am+3yK; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="H9am+3yK"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4b109921fe7so27751371cf.0
        for <linux-perf-users@vger.kernel.org>; Fri, 22 Aug 2025 10:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1755884856; x=1756489656; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lASAogWwaY4J3oXaSg+X8r5SCu4Wp/t1yzCv89toveQ=;
        b=H9am+3yK6oHMcrJhdU25BLMmvUy/4ftKC/0yzLUQn7CYRf2Yguiyg196cWuZW583SV
         Z34pSjxRXP3F7y9M0uwdqyxU44v3VIx06QIiMrZZBqpSvGHNY4xlILH3wRlfwIGKlTjS
         mTWNhx3eUV9XRUPD/PBG914c003I24Lhqxawebj6/2H/8KEWnap3xdJCsi0Zer7UfC4Q
         ZBuQQybf8/79c68HuRfBKpjjPJuRTiSq9btfRm3TSZUUOGZBfqxXTnWO09m6pBpmaxY4
         R0+BmP/SVlEZD6hELrToVggKcr1mmyDdATyrnBZxbmxGoeVGZTq3qCoMdAkb6LmYlPVq
         YiiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755884856; x=1756489656;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lASAogWwaY4J3oXaSg+X8r5SCu4Wp/t1yzCv89toveQ=;
        b=aFf1GbgQyvdAniEKs/U/03JvwzePlO4VNj316pP0BVMx3CpvID0GqO9VhyfzHgh3vc
         9uPdssHoZa0UfrAirVMijxFvLM3BNQg+aPOaRzJwAOy6sGlxLaH3Hibg83NtfKN5rm6j
         5/5/NOMmvN57u36g/85sInrbKU+yzFqwJcjBVdWyOIvyyFBWCPg9JFA7Z6iVR8GXvChZ
         sWCMKlrQ5LMeP0/9Vv2L0muU9s6+5qjvPaK1A+fH0kS/YqnIOJi4LdhoQnFPQmN78Lpq
         fr1E69aUGnSGb06IVxoNXMRZLslRZ1IKV0Ra17BUezN8kCThcqiFlIFZfrJ7zHAbG8fV
         c7Ww==
X-Forwarded-Encrypted: i=1; AJvYcCUFszoN8nsiOOY1xCRInDyn4ICkc9odqul8NdcE6R5IQPbRKZF3HzGzJafSQPYS0KKQ6aMfN1xhbtDoU3FDL69I@vger.kernel.org
X-Gm-Message-State: AOJu0YxKbJMFlkY9gw7OWnYcUiZD40QAa+gjE7is89hzTab6aZCZaRCj
	P2wwucaYZDtzrT0d9wOnikXyjqS7wXMMoFu+0ppKVDtOIntwW/GJSHaSq3Qpa4t0x18=
X-Gm-Gg: ASbGncv0R5jVFi21IsHbi9l0zgL6Z0JInq847/xjXGOjSSvrrtxSldoccxQ3axXzSK1
	hGs/Te+7kssuW1RygHRWn7Z3W+6I/RJBcH+3PLQXQ3ScMF76ZTu0Z4wBlu4IH+G1RxO/+p8lAHH
	X/cmisE4cb4wPLgDg9yKyQcU//lwM8CER/OmfJpZeoxAxeWqxAtte301LT8SS0SRq3W8o2yGDwJ
	TeUW6rjTE21lKm1BbvU/io9nyn4cJZ9oCLYjJtFKRbZqpGO5VKX3MgTGQgYpZKHkIv1UNGaXzvL
	GMXRaaF6mRLf+lv88YqYtC6aDqtDi7XnGcC2Hsy0vGMn2KKBf26FItG9ub1WirJc7E/x/4NWlj4
	MQwoMceOB5RhMfyAKNKt7TCT1lKLxfixw4Kv0FslA52KKip/dJxjoAZ0LWDitq4HfdNqJ00Wy1d
	OaFBnW/A==
X-Google-Smtp-Source: AGHT+IF7NBwPyWijDa6fVd6FPPHBKgHBj6d8UJ7rY1WXrx0r6jLeZuvNMUy7ENqP9DpN+xFIGjFOyA==
X-Received: by 2002:a05:622a:4016:b0:4ae:f8bb:7c6a with SMTP id d75a77b69052e-4b2aaaf96abmr39630891cf.54.1755884855769;
        Fri, 22 Aug 2025 10:47:35 -0700 (PDT)
Received: from jesse-lt.jtp-bos.lab (pool-108-26-215-125.bstnma.fios.verizon.net. [108.26.215.125])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b2b8e6023asm3121361cf.53.2025.08.22.10.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 10:47:35 -0700 (PDT)
From: Jesse Taube <jesse@rivosinc.com>
To: linux-riscv@lists.infradead.org
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Oleg Nesterov <oleg@redhat.com>,
	Kees Cook <kees@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang Kan" <kan.liang@linux.intel.com>,
	Shuah Khan <shuah@kernel.org>,
	Jesse Taube <jesse@rivosinc.com>,
	Himanshu Chauhan <hchauhan@ventanamicro.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Deepak Gupta <debug@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Atish Patra <atishp@rivosinc.com>,
	Anup Patel <apatel@ventanamicro.com>,
	Mayuresh Chitale <mchitale@ventanamicro.com>,
	Evan Green <evan@rivosinc.com>,
	WangYuli <wangyuli@uniontech.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Nam Cao <namcao@linutronix.de>,
	Yunhui Cui <cuiyunhui@bytedance.com>,
	Joel Granados <joel.granados@kernel.org>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Celeste Liu <coelacanthushex@gmail.com>,
	Chunyan Zhang <zhangchunyan@iscas.ac.cn>,
	Nylon Chen <nylon.chen@sifive.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-perf-users@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Joel Stanley <joel@jms.id.au>
Subject: [PATCH 8/8] selftests: riscv: Add test for hardware breakpoints
Date: Fri, 22 Aug 2025 10:47:15 -0700
Message-ID: <20250822174715.1269138-9-jesse@rivosinc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250822174715.1269138-1-jesse@rivosinc.com>
References: <20250822174715.1269138-1-jesse@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add riscv specific selftest for hardware breakpoints.
These tests are based on:
tools/testing/selftests/breakpoints/breakpoint_test_arm64.c

Signed-off-by: Jesse Taube <jesse@rivosinc.com>
---
The selftest fails as register_user_hw_breakpoint seemingly does not
call arch_install_hw_breakpoint. The test also seems to fail on arm64
in the same way when I tested it.

RFC -> V1:
 - New commit
V1 -> V2:
 - Add KHDR_INCLUDES to Makefile
 - Change <elf.h> to <linux/elf.h>
---
 tools/perf/tests/tests.h                      |   3 +-
 tools/testing/selftests/riscv/Makefile        |   2 +-
 .../selftests/riscv/breakpoints/.gitignore    |   1 +
 .../selftests/riscv/breakpoints/Makefile      |  13 +
 .../riscv/breakpoints/breakpoint_test.c       | 246 ++++++++++++++++++
 5 files changed, 263 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/riscv/breakpoints/.gitignore
 create mode 100644 tools/testing/selftests/riscv/breakpoints/Makefile
 create mode 100644 tools/testing/selftests/riscv/breakpoints/breakpoint_test.c

diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index 8aea344536b8..5ff35304c11a 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -183,7 +183,8 @@ DECLARE_SUITE(util);
  * Just disable the test for these architectures until these issues are
  * resolved.
  */
-#if defined(__powerpc__) || defined(__s390x__) || defined(__arm__) || defined(__aarch64__)
+#if defined(__powerpc__) || defined(__s390x__) || defined(__arm__) || defined(__aarch64__) || \
+    defined(__riscv)
 #define BP_SIGNAL_IS_SUPPORTED 0
 #else
 #define BP_SIGNAL_IS_SUPPORTED 1
diff --git a/tools/testing/selftests/riscv/Makefile b/tools/testing/selftests/riscv/Makefile
index 099b8c1f46f8..96aba246cb3e 100644
--- a/tools/testing/selftests/riscv/Makefile
+++ b/tools/testing/selftests/riscv/Makefile
@@ -5,7 +5,7 @@
 ARCH ?= $(shell uname -m 2>/dev/null || echo not)
 
 ifneq (,$(filter $(ARCH),riscv))
-RISCV_SUBTARGETS ?= abi hwprobe mm sigreturn vector
+RISCV_SUBTARGETS ?= abi hwprobe mm sigreturn vector breakpoints
 else
 RISCV_SUBTARGETS :=
 endif
diff --git a/tools/testing/selftests/riscv/breakpoints/.gitignore b/tools/testing/selftests/riscv/breakpoints/.gitignore
new file mode 100644
index 000000000000..9b3193d06608
--- /dev/null
+++ b/tools/testing/selftests/riscv/breakpoints/.gitignore
@@ -0,0 +1 @@
+breakpoint_test
diff --git a/tools/testing/selftests/riscv/breakpoints/Makefile b/tools/testing/selftests/riscv/breakpoints/Makefile
new file mode 100644
index 000000000000..2315d7d874fc
--- /dev/null
+++ b/tools/testing/selftests/riscv/breakpoints/Makefile
@@ -0,0 +1,13 @@
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2021 ARM Limited
+# Originally tools/testing/arm64/abi/Makefile
+
+CFLAGS += -I$(top_srcdir)/tools/include
+CFLAGS += $(KHDR_INCLUDES)
+
+TEST_GEN_PROGS := breakpoint_test
+
+include ../../lib.mk
+
+$(OUTPUT)/breakpoint_test: breakpoint_test.c
+	$(CC) -static -o$@ $(CFLAGS) $(LDFLAGS) $^
diff --git a/tools/testing/selftests/riscv/breakpoints/breakpoint_test.c b/tools/testing/selftests/riscv/breakpoints/breakpoint_test.c
new file mode 100644
index 000000000000..2675055a924e
--- /dev/null
+++ b/tools/testing/selftests/riscv/breakpoints/breakpoint_test.c
@@ -0,0 +1,246 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2016 Google, Inc.
+ *
+ * Original Code by Pavel Labath <labath@google.com>
+ *
+ * Code modified by Pratyush Anand <panand@redhat.com>
+ * for testing different byte select for each access size.
+ * Originally tools/testing/selftests/breakpoints/breakpoint_test_arm64.c
+ */
+
+#define _GNU_SOURCE
+
+#include <asm/ptrace.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <sys/ptrace.h>
+#include <sys/param.h>
+#include <sys/uio.h>
+#include <stdint.h>
+#include <stdbool.h>
+#include <stddef.h>
+#include <string.h>
+#include <stdio.h>
+#include <unistd.h>
+#include <linux/elf.h>
+#include <errno.h>
+#include <signal.h>
+
+#include "../../kselftest.h"
+
+#define MAX_BP_SIZE 8
+
+static volatile uint8_t var[3*MAX_BP_SIZE] __attribute__((__aligned__(MAX_BP_SIZE)));
+
+static void child(int size, int wr)
+{
+	volatile uint8_t *addr = &var[MAX_BP_SIZE + wr];
+
+	if (ptrace(PTRACE_TRACEME, 0, NULL, NULL) != 0) {
+		ksft_print_msg(
+			"ptrace(PTRACE_TRACEME) failed: %s\n",
+			strerror(errno));
+		_exit(1);
+	}
+
+	if (raise(SIGSTOP) != 0) {
+		ksft_print_msg(
+			"raise(SIGSTOP) failed: %s\n", strerror(errno));
+		_exit(1);
+	}
+
+	if ((uintptr_t) addr % size) {
+		ksft_print_msg(
+			 "Wrong address write for the given size: %s\n",
+			 strerror(errno));
+		_exit(1);
+	}
+
+	switch (size) {
+	case 1:
+		*addr = 47;
+		break;
+	case 2:
+		*(uint16_t *)addr = 47;
+		break;
+	case 4:
+		*(uint32_t *)addr = 47;
+		break;
+	case 8:
+		*(uint64_t *)addr = 47;
+		break;
+	}
+
+	_exit(0);
+}
+
+static bool set_watchpoint(pid_t pid, int size, int wp)
+{
+	const volatile uint8_t *addr = &var[MAX_BP_SIZE + wp];
+	const int offset = (uintptr_t)addr % 8;
+	const unsigned int type = 2; /* Write */
+	const unsigned int enable = 1;
+	struct __riscv_hwdebug_state debug_state;
+	struct iovec iov;
+
+	memset(&debug_state, 0, sizeof(debug_state));
+	debug_state.addr = (uintptr_t)(addr - offset);
+	debug_state.len = size;
+	debug_state.ctrl = enable;
+	debug_state.type = type;
+	iov.iov_base = &debug_state;
+	iov.iov_len = sizeof(debug_state);
+	if (ptrace(PTRACE_SETREGSET, pid, NT_RISCV_HW_BREAK, &iov) == 0)
+		return true;
+
+	if (errno == EIO)
+		ksft_print_msg(
+			"ptrace(PTRACE_SETREGSET, NT_RISCV_HW_BREAK) not supported on this hardware: %s\n",
+			strerror(errno));
+
+	ksft_print_msg(
+		"ptrace(PTRACE_SETREGSET, NT_RISCV_HW_BREAK) failed: %s\n",
+		strerror(errno));
+	return false;
+}
+
+static bool run_test(int wr_size, int wp_size, int wr, int wp)
+{
+	int status;
+	siginfo_t siginfo;
+	pid_t pid = fork();
+	pid_t wpid;
+
+	if (pid < 0) {
+		ksft_test_result_fail(
+			"fork() failed: %s\n", strerror(errno));
+		return false;
+	}
+	if (pid == 0)
+		child(wr_size, wr);
+
+	wpid = waitpid(pid, &status, __WALL);
+	if (wpid != pid) {
+		ksft_print_msg(
+			"waitpid() failed: %s\n", strerror(errno));
+		return false;
+	}
+	if (!WIFSTOPPED(status)) {
+		ksft_print_msg(
+			"child did not stop: %s\n", strerror(errno));
+		return false;
+	}
+	if (WSTOPSIG(status) != SIGSTOP) {
+		ksft_print_msg("child did not stop with SIGSTOP\n");
+		return false;
+	}
+
+	if (!set_watchpoint(pid, wp_size, wp))
+		return false;
+
+	if (ptrace(PTRACE_CONT, pid, NULL, NULL) < 0) {
+		ksft_print_msg(
+			"ptrace(PTRACE_CONT) failed: %s\n",
+			strerror(errno));
+		return false;
+	}
+
+	alarm(3);
+	wpid = waitpid(pid, &status, __WALL);
+	if (wpid != pid) {
+		ksft_print_msg(
+			"waitpid() failed: %s\n", strerror(errno));
+		return false;
+	}
+	alarm(0);
+	if (WIFEXITED(status)) {
+		ksft_print_msg("child exited prematurely\n");
+		return false;
+	}
+	if (!WIFSTOPPED(status)) {
+		ksft_print_msg("child did not stop\n");
+		return false;
+	}
+	if (WSTOPSIG(status) != SIGTRAP) {
+		ksft_print_msg("child did not stop with SIGTRAP\n");
+		return false;
+	}
+	if (ptrace(PTRACE_GETSIGINFO, pid, NULL, &siginfo) != 0) {
+		ksft_print_msg(
+			"ptrace(PTRACE_GETSIGINFO): %s\n",
+			strerror(errno));
+		return false;
+	}
+	if (siginfo.si_code != TRAP_HWBKPT) {
+		ksft_print_msg(
+			"Unexpected si_code %d\n", siginfo.si_code);
+		return false;
+	}
+
+	kill(pid, SIGKILL);
+	wpid = waitpid(pid, &status, 0);
+	if (wpid != pid) {
+		ksft_print_msg(
+			"waitpid() failed: %s\n", strerror(errno));
+		return false;
+	}
+	return true;
+}
+
+static void sigalrm(int sig)
+{
+}
+
+int main(int argc, char **argv)
+{
+	int opt;
+	bool succeeded = true;
+	struct sigaction act;
+	int wr, wp, size;
+	bool result;
+
+	ksft_print_header();
+	ksft_set_plan(213);
+
+	act.sa_handler = sigalrm;
+	sigemptyset(&act.sa_mask);
+	act.sa_flags = 0;
+	sigaction(SIGALRM, &act, NULL);
+	for (size = 1; size <= MAX_BP_SIZE; size = size*2) {
+		for (wr = 0; wr <= MAX_BP_SIZE; wr = wr + size) {
+			for (wp = wr - size; wp <= wr + size; wp = wp + size) {
+				result = run_test(size, MIN(size, 8), wr, wp);
+				if ((result && wr == wp) ||
+				    (!result && wr != wp))
+					ksft_test_result_pass(
+						"Test size = %d write offset = %d watchpoint offset = %d\n",
+						size, wr, wp);
+				else {
+					ksft_test_result_fail(
+						"Test size = %d write offset = %d watchpoint offset = %d\n",
+						size, wr, wp);
+					succeeded = false;
+				}
+			}
+		}
+	}
+
+	for (size = 1; size <= MAX_BP_SIZE; size = size*2) {
+		if (run_test(size, 8, -size, -8))
+			ksft_test_result_pass(
+				"Test size = %d write offset = %d watchpoint offset = -8\n",
+				size, -size);
+		else {
+			ksft_test_result_fail(
+				"Test size = %d write offset = %d watchpoint offset = -8\n",
+				size, -size);
+			succeeded = false;
+		}
+	}
+
+	if (succeeded)
+		ksft_exit_pass();
+	else
+		ksft_exit_fail();
+}
-- 
2.43.0

