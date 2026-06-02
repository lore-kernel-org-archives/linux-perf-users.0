Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB69381B00
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Jun 2026 07:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780385518; cv=none; b=aqBxT8WWJoDT9JiWfm1ZN9cJWocmZmLVr2AawHf7MVkbKJTYTeXGhbzP9renR91k7OQnv8AmDUmIapx/PTpM31IJ2CVSmtiXr7ShuIFbFe70OgJoSdR3ocBBCP5r+5X+JBpGGY/TPzVSUouNXLTAC23ieMG8WIypEDfJC2j+Yvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780385518; c=relaxed/simple;
	bh=NrhJQifWIdjWZpa4T76cPwBhyfTRIBWalPjZpnGarEs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=i8noPX7zC6PgPxFJZH5sKi0VWzhfyl6XUAQYGm0++Rb6MlwLU2zYdUoNsa6v0PeTtNpYfXGDgppyR3P2JmX3r3ScmXTuuEL2VdcJA/JowJplmZ2+H/xRGzlzBDO6d7VtpLqHaUDUIXEJ2GFbvf7hsvwogt62BFiANyVR3QGMrCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j09hL2W2; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j09hL2W2"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-13537722193so17823586c88.0
        for <linux-perf-users@vger.kernel.org>; Tue, 02 Jun 2026 00:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780385514; x=1780990314; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7sb/QX9TZo/2ucU/CoEjrWNAWFKUT7xSSMp8X290oyk=;
        b=j09hL2W2q7yGB0wpuk8mBe68oZ3LD+dOKHUsbH8c/vE+mJZuT3YstjoMjDTgHPuGmL
         9H/xMr17d01EyJAITR+PDVdHKxIQHnGbbBJvggFRnVVGNAsY/v0///aA2CxpSO1A2PmA
         Rnl6ZKvVzThqA4Oj+GYe7v9q2/V6bpWzc0tNYHYoM9lpZKda/xPICw/hNweT6S/EXCAc
         uRxSLcn3sc2yYseRnq/qbAm6hqBBU4PH6Qi4phzEFr01QP67TSGgJMFviS0zZAUfs4Hx
         ybuemz/hse8T8xjgZDURsCctUKuKZwtAmS4Cqw7ejBM2y++3J/wRk30c6QVfJhu9MSTM
         nXew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780385514; x=1780990314;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7sb/QX9TZo/2ucU/CoEjrWNAWFKUT7xSSMp8X290oyk=;
        b=kaCNm+2RZZ1cYDxsScDNGxxgrhcD3QcMVRUXCqU1kRxRqS2qHJB1ScdPYcrrFWgm/p
         zbeG3EJf8VIRQyTwMMERBS4rGHITTVu9/xNA5WNlR4wFQkl++lWTEqjl/gY/LDdedYMe
         CbRstE0Kod1fy4a5s65oMLKhuRmw0ss1Ekvlgy8L6DUhwxwcY3Z0s5I2BSV8vLW1ZYbf
         iK36WKiTG+k9YjlSAt55cfJtaW6BxwcymPywQX8r5PfgitHKaSMJx9DfIUhrCkwfwAZZ
         PnQDMA9ARHps4MC6muwwavOuuLqlFKGT3gW9LsLRxeYDI6MN2tye9sBRhY+h7rhnvCX3
         HvIg==
X-Forwarded-Encrypted: i=1; AFNElJ+Memk20si4BXpeq/IdVI+rCxyMqF6wuyakastV8a2m6tdu5i+Q/hOpVXqtYbWbQe9gENZkzRwRCAnWLEIyvwog@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6Vq0Du/KEmKJAnqMSgn7WYnDg0Dz+zGuDWIlplVBo09QvYOan
	+lMirauvlQKoZ1fnquejoXrUv2z+QE3/Bw4aU692y8FU6GIXqulJ9OaaPMsa8XVesn3VoaxZfls
	hwvVq6W6PJQ==
X-Received: from dlc3.prod.google.com ([2002:a05:7022:383:b0:12d:b2ba:b551])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:e23:b0:136:602b:80ac
 with SMTP id a92af1059eb24-137d413a2eamr6177904c88.27.1780385513482; Tue, 02
 Jun 2026 00:31:53 -0700 (PDT)
Date: Tue,  2 Jun 2026 00:31:22 -0700
In-Reply-To: <20260602073132.2653307-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260601061401.1541457-1-irogers@google.com> <20260602073132.2653307-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.929.g9b7fa37559-goog
Message-ID: <20260602073132.2653307-8-irogers@google.com>
Subject: [PATCH v7] tools subcmd: Robust fallback and existence checks for
 process reaping
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, alexander.shishkin@linux.intel.com, 
	james.clark@linaro.org, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

Update check_if_command_finished() and wait_or_whine() to handle invalid
PIDs gracefully (<= 0) by setting cmd->finished = 1 and returning early.
This avoids executing waitpid(-1, ...) or waitpid(0, ...) downstream,
which can block or reap parallel tests' exit status causing state
corruption.

Introduce a fallback mechanism in check_if_command_finished() using
waitpid(..., WNOHANG) when /proc/<pid>/status is inaccessible (e.g. due
to EMFILE/ENFILE) to safely check and reap finished children.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/subcmd/run-command.c | 69 ++++++++++++++++++++++++++++++++--
 1 file changed, 65 insertions(+), 4 deletions(-)

diff --git a/tools/lib/subcmd/run-command.c b/tools/lib/subcmd/run-command.c
index b7510f83209a..bd21b8bfd58b 100644
--- a/tools/lib/subcmd/run-command.c
+++ b/tools/lib/subcmd/run-command.c
@@ -169,8 +169,18 @@ int start_command(struct child_process *cmd)
 
 static int wait_or_whine(struct child_process *cmd, bool block)
 {
-	bool finished = cmd->finished;
-	int result = cmd->finish_result;
+	bool finished;
+	int result;
+
+	if (cmd->pid <= 0) {
+		cmd->finished = 1;
+		if (cmd->pid < 0 && cmd->finish_result == 0)
+			cmd->finish_result = -ERR_RUN_COMMAND_FORK;
+		return cmd->finish_result;
+	}
+
+	finished = cmd->finished;
+	result = cmd->finish_result;
 
 	while (!finished) {
 		int status, code;
@@ -233,7 +243,18 @@ int check_if_command_finished(struct child_process *cmd)
 	char filename[6 + MAX_STRLEN_TYPE(typeof(cmd->pid)) + 7 + 1];
 	char status_line[256];
 	FILE *status_file;
+#endif
 
+	if (cmd->finished)
+		return 1;
+	if (cmd->pid <= 0) {
+		cmd->finished = 1;
+		if (cmd->pid < 0 && cmd->finish_result == 0)
+			cmd->finish_result = -ERR_RUN_COMMAND_FORK;
+		return 1;
+	}
+
+#ifdef __linux__
 	/*
 	 * Check by reading /proc/<pid>/status as calling waitpid causes
 	 * stdout/stderr to be closed and data lost.
@@ -241,8 +262,48 @@ int check_if_command_finished(struct child_process *cmd)
 	sprintf(filename, "/proc/%u/status", cmd->pid);
 	status_file = fopen(filename, "r");
 	if (status_file == NULL) {
-		/* Open failed assume finish_command was called. */
-		return true;
+		int status;
+		pid_t waiting;
+
+		/*
+		 * fopen() can fail with ENOENT if the process has been reaped.
+		 * It can also fail with EMFILE/ENFILE if RLIMIT_NOFILE is reached.
+		 * In those cases, use waitpid(..., WNOHANG) to robustly check
+		 * and reap the process if it has exited.
+		 */
+		if (errno == ENOENT)
+			return 1;
+
+		waiting = waitpid(cmd->pid, &status, WNOHANG);
+		if (waiting == cmd->pid) {
+			int result;
+			int code;
+
+			cmd->finished = 1;
+			if (WIFSIGNALED(status)) {
+				result = -ERR_RUN_COMMAND_WAITPID_SIGNAL;
+			} else if (!WIFEXITED(status)) {
+				result = -ERR_RUN_COMMAND_WAITPID_NOEXIT;
+			} else {
+				code = WEXITSTATUS(status);
+				switch (code) {
+				case 127:
+					result = -ERR_RUN_COMMAND_EXEC;
+					break;
+				case 0:
+					result = 0;
+					break;
+				default:
+					result = -code;
+					break;
+				}
+			}
+			cmd->finish_result = result;
+			return 1;
+		}
+		if (waiting < 0 && (errno == ECHILD || errno == ESRCH))
+			return 1;
+		return 0;
 	}
 	while (fgets(status_line, sizeof(status_line), status_file) != NULL) {
 		char *p;
-- 
2.54.0.929.g9b7fa37559-goog

