Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D7D3DEFE7
	for <linux-perf-users@vger.kernel.org>; Tue, 26 May 2026 11:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779794105; cv=none; b=lO0AqLz2F4M+EK7XQESRa6scEFX8lfOb0FnuIPtaUhoBPAym40SnK4PG3um3vEWU4Qnx5upKSR6g4mQMWN3DB1m7qr+0CeKWu0SbXMEVf4nJi6lB57eL0WTVQU3LWlySrWpjb9NKSNhDjtdUh3IlK7qNYfqkZNzyRGdBRCWEkqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779794105; c=relaxed/simple;
	bh=DZvZtVaDVjgtTMrzxG2c64n+J7UyBOrBeYeDJdKv4PU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QILU0XHIQTft3T+2PC4wjDqU0jjmDZevwT4eclKf5dPxOqKsFaosct6M7KppT2Eu1KO6eu2zVVbCi8w5gDwqDocvkrK9/9Ljm4kPqBlD9YvXwad34ZHTwxeajb0ldNdX7dNHLyai24W11o1kDNMeFmokxOOoBM7HgsNAtr8+DxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xIzqOKK6; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xIzqOKK6"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-45ebafde87cso2349086f8f.3
        for <linux-perf-users@vger.kernel.org>; Tue, 26 May 2026 04:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1779794101; x=1780398901; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A/gStB7riG3y0hEx2ktfiQB2K0otiavQ178eEzNn/V0=;
        b=xIzqOKK6rhB+bM9sgSSFRzVzlqw85f2mYLjd6H8d1fECX0wp+j6y+cO95s8QLS+SHp
         q2dX8glk+0jsfY8wWHlIdbLAtOBBLjm7dgTGfMle52+QbFcnvZSXYGRSla/wde+Zw49e
         6S6vTNE7OHEwz373iU5p+ePkt0zwSTJVLRh7jq2bGQFzh9GJR/6HXb0embcuQ0rNhPDx
         f2Km3EFWRWgtfhdu82PZ5kcwDRenyrlV/VuOIFyESvLCWCFssGzNxaTb8TuziEB8GLCX
         3Z8DK7hnPj57c5th4UZDHM8UacN81PdfZ5Bu//Vj6PVPtHxq3dKlJ5WYKeJmgOhn+1JF
         ZWUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779794101; x=1780398901;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=A/gStB7riG3y0hEx2ktfiQB2K0otiavQ178eEzNn/V0=;
        b=S6cfiZOaHRPy46yGkpjQQm9CQFogZriChkYNYdnj9pVoCgLmc8UwAPwysJIPngEUT+
         lj0rfXHsWJI/ec5ZQ1QrhN8rWhO9v/gteMw7nDfSYEy+Rd4U9Uc0M3yAd3rMfyUjwJDR
         p2kdCDBjQ1Hdn0/Gr7d8A6iVvO9+FGdCk4nWCAScdYuB8fDg7VJ8+2DSgStPvGqdVN2Y
         fkbkGNwD1+Uzcidc0myQBt9ihXp79GjZHRuhG0EPTf+HVECFy4Z39kmDx31JkZGcP1bO
         VnlDOSIF6uTp1El13fLoZQXY4sL6uGsI8mcwzOJbmLsLfT8rdwPPZX+/b5iIZGz8f7KU
         dKJw==
X-Forwarded-Encrypted: i=1; AFNElJ9aAqF/b3ngCUPfqVn6bfP2hR0mu9vEAcM7KB0TqGMrNwdpF4fiv5tJCs0ojsWEbcPEYcJMLZMcOEkU0RCGSK73@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa3EmwhoeJL7tTm1BTEwMYlBkhOnlIbWMTkzwzzEkA+bqcyHeI
	fpeiBGXkDe5/kWtAguBfEtjHAsnT73anq0b0rasL89Ke/Ang0MJEyyKTMXUXWAcu6DM=
X-Gm-Gg: Acq92OHjSX5Nn1S13gC3qQ0xQDzHdinom3r7XLaIFAUo3Hm+1ubv8aEinVEkLiDNUD8
	2K77W6LqhWVs2Pp2SZYLCypNekovQWH0WSZnUtu6wKpTCE3u14iOaZKeifpBdQ1FoMEykq4ze26
	IhobEiGrDLyCFaiL/XHH91z1DPsSQs1GJVC0XBdbUmnjtCZFrZBI0C9fIyTcg46e1edLZz8HjRg
	ScZr7sM9pUJf3l7yKPafHz0y4QU23oMrv6qlH6DgdZiSGJotYDX4QUf0t5jn5OG/b/lubZyIz16
	bQfQHHUwwl986QhYB/aw+3Ymyo8Sdiy4HTNiiENtghMkLX5eAYowL3El5+kkOACkKWsXRd1dpRr
	5N65lNsn8hM2UBAurqH79ZYjGeaP+ptiWlqIJcSRnTVvwKIGxiNpClL3tSqzGVf0jFusC4WZxXl
	MHu6hlgNA0ZtGU9YESnrpsC9hfNUwJm7gR
X-Received: by 2002:a05:6000:4707:b0:455:7e5d:9142 with SMTP id ffacd0b85a97d-45eb38bb01fmr30064916f8f.32.1779794101143;
        Tue, 26 May 2026 04:15:01 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6c9f598sm35375627f8f.6.2026.05.26.04.15.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 04:15:00 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Tue, 26 May 2026 12:14:37 +0100
Subject: [PATCH 2/2] perf test cs-etm: Test thread attribution
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260526-james-cs-context-tracking-fix-v1-2-ebd602e18287@linaro.org>
References: <20260526-james-cs-context-tracking-fix-v1-0-ebd602e18287@linaro.org>
In-Reply-To: <20260526-james-cs-context-tracking-fix-v1-0-ebd602e18287@linaro.org>
To: Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@arm.com>, Leo Yan <leo.yan@arm.com>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
 Amir Ayupov <aaupov@meta.com>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

Add a workload that creates two threads that read and write to a pipe so
that every read/write results in the other thread being scheduled. If
this is run on one CPU then the threads will alternate and we can test
that processor trace always attributes symbols to the correct thread and
that the attribution changes at the exact point that the thread switch
happened.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/tests/shell/coresight/Makefile          |  1 +
 .../shell/coresight/context_switch_loop/.gitignore |  1 +
 .../shell/coresight/context_switch_loop/Makefile   | 29 ++++++++
 .../context_switch_loop/context_switch_loop.c      | 83 ++++++++++++++++++++++
 .../tests/shell/coresight/context_switch_thread.sh | 48 +++++++++++++
 5 files changed, 162 insertions(+)

diff --git a/tools/perf/tests/shell/coresight/Makefile b/tools/perf/tests/shell/coresight/Makefile
index fa08fd9a5991..710e742d9def 100644
--- a/tools/perf/tests/shell/coresight/Makefile
+++ b/tools/perf/tests/shell/coresight/Makefile
@@ -6,6 +6,7 @@ include ../../../../../tools/scripts/utilities.mak
 
 SUBDIRS = \
 	asm_pure_loop \
+	context_switch_loop \
 	memcpy_thread \
 	thread_loop \
 	unroll_loop_thread
diff --git a/tools/perf/tests/shell/coresight/context_switch_loop/.gitignore b/tools/perf/tests/shell/coresight/context_switch_loop/.gitignore
new file mode 100644
index 000000000000..86a7becebba4
--- /dev/null
+++ b/tools/perf/tests/shell/coresight/context_switch_loop/.gitignore
@@ -0,0 +1 @@
+context_switch_loop
diff --git a/tools/perf/tests/shell/coresight/context_switch_loop/Makefile b/tools/perf/tests/shell/coresight/context_switch_loop/Makefile
new file mode 100644
index 000000000000..722afc993cb0
--- /dev/null
+++ b/tools/perf/tests/shell/coresight/context_switch_loop/Makefile
@@ -0,0 +1,29 @@
+# SPDX-License-Identifier: GPL-2.0
+
+include ../Makefile.miniconfig
+
+BIN=context_switch_loop
+LIB=
+
+all: $(BIN)
+
+$(BIN): $(BIN).c
+ifdef CORESIGHT
+ifeq ($(ARCH),arm64)
+	$(Q)$(CC) $(CFLAGS) $(BIN).c -O0 -o $(BIN) $(LIB)
+endif
+endif
+
+install-tests: all
+ifdef CORESIGHT
+ifeq ($(ARCH),arm64)
+	$(call QUIET_INSTALL, tests) \
+		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/$(INSTDIR_SUB)/$(BIN)'; \
+		$(INSTALL) $(BIN) '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/$(INSTDIR_SUB)/$(BIN)/$(BIN)'
+endif
+endif
+
+clean:
+	$(Q)$(RM) -f $(BIN)
+
+.PHONY: all clean install-tests
diff --git a/tools/perf/tests/shell/coresight/context_switch_loop/context_switch_loop.c b/tools/perf/tests/shell/coresight/context_switch_loop/context_switch_loop.c
new file mode 100644
index 000000000000..6b7cd11952a2
--- /dev/null
+++ b/tools/perf/tests/shell/coresight/context_switch_loop/context_switch_loop.c
@@ -0,0 +1,83 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/compiler.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/prctl.h>
+#include <sys/wait.h>
+#include <unistd.h>
+
+static int loops = 100;
+static char buf;
+int work = 1234;
+
+#define write_block(fd) \
+	do { \
+		if (write(fd, &buf, 1) <= 0) \
+			exit(1); \
+	} while (0)
+
+#define read_block(fd) \
+	do { \
+		if (read(fd, &buf, 1) <= 0) \
+			exit(1); \
+	} while (0)
+
+static noinline void thread1(int in_fd, int out_fd)
+{
+	for (int i = 0; i < loops; i++) {
+		read_block(in_fd);
+		work += i * 3;
+		write_block(out_fd);
+	}
+}
+
+static noinline void thread2(int in_fd, int out_fd)
+{
+	for (int i = 0; i < loops; i++) {
+		write_block(out_fd);
+		work += i * 7;
+		read_block(in_fd);
+	}
+}
+
+int main(int argc, char **argv)
+{
+	int a_to_b[2], b_to_a[2];
+	pid_t thread1_pid;
+	int status;
+
+	if (argc > 1) {
+		loops = atoi(argv[1]);
+		if (loops < 0) {
+			fprintf(stderr, "Invalid number of loops: %s\n", argv[1]);
+			return 1;
+		}
+	}
+
+	if (pipe(a_to_b) || pipe(b_to_a)) {
+		perror("Pipe error");
+		return 1;
+	}
+
+	thread1_pid = fork();
+	if (thread1_pid < 0) {
+		perror("Fork error");
+		return 1;
+	}
+
+	if (!thread1_pid) {
+		prctl(PR_SET_NAME, "thread1", 0, 0, 0);
+		thread1(b_to_a[0], a_to_b[1]);
+		exit(0);
+	}
+
+	prctl(PR_SET_NAME, "thread2", 0, 0, 0);
+	thread2(a_to_b[0], b_to_a[1]);
+
+	if (waitpid(thread1_pid, &status, 0) != thread1_pid || !WIFEXITED(status) ||
+	    WEXITSTATUS(status))
+		return 1;
+
+	return 0;
+}
diff --git a/tools/perf/tests/shell/coresight/context_switch_thread.sh b/tools/perf/tests/shell/coresight/context_switch_thread.sh
new file mode 100755
index 000000000000..10b4118dff9b
--- /dev/null
+++ b/tools/perf/tests/shell/coresight/context_switch_thread.sh
@@ -0,0 +1,48 @@
+#!/bin/bash -e
+# CoreSight / Context switch thread attribution (exclusive)
+
+# SPDX-License-Identifier: GPL-2.0
+
+TEST="context_switch_loop"
+
+if [ "$(id -u)" != 0 ]; then
+	# Requires root for "-C 0" in record command
+	echo "[Skip] No root permission"
+	exit 2
+fi
+
+# shellcheck source=../lib/coresight.sh
+. "$(dirname $0)"/../lib/coresight.sh
+
+DATA="$DATD/perf-$TEST.data"
+SCRIPT="$DATD/perf-$TEST.script"
+
+check_samples() {
+	owner_samples=$(grep -c "thread1.*thread1" "$SCRIPT" || true)
+	next_samples=$(grep -c "thread2.*thread2" "$SCRIPT" || true)
+
+	if [ "$owner_samples" -eq 0 ] || [ "$next_samples" -eq 0 ]; then
+		err "No samples found"
+	fi
+
+	if grep "thread2.*thread1" "$SCRIPT"; then
+		err "Thread1 symbol was attributed to thread2"
+	fi
+
+	if grep "thread1.*thread2" "$SCRIPT"; then
+		err "Thread2 symbol was attributed to thread1"
+	fi
+}
+
+# Pin to one CPU so the two threads alternate running but record into the
+# same trace buffer.
+perf record -o "$DATA" -e cs_etm/timestamp=0/u -C 0 \
+	-- taskset --cpu-list 0 "$BIN" 20 > /dev/null 2>&1
+
+# Test both instruction and branch sample generation modes.
+perf script -i "$DATA" --itrace=i4 -F comm,pid,tid,ip,sym > "$SCRIPT" 2>/dev/null
+check_samples
+perf script -i "$DATA" --itrace=b -F comm,pid,tid,ip,sym > "$SCRIPT" 2>/dev/null
+check_samples
+
+exit 0

-- 
2.34.1

