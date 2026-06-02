Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F79E3438BA
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Jun 2026 17:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780422124; cv=none; b=hzI3zLjAQyw9YLbqQPzydMnhJ8JTNSoMIfJzOo3WQBX15OSPpBdDINOtLb9tHJbiYiVupj1n1Z9OEBCb3b+uVYuD6dXpLsyLgXqS2IIJEPsPmmCycmTAVZFpPg0C9bfpxjctzrJFqdgvIP2lfItnclOI35bwA8pmlPGqI+Y3yM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780422124; c=relaxed/simple;
	bh=RlTs4+CvmQBcuzjPaawGE+Su+7rLHOBZtuvgu4cIVl4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cHSp5duapjguy/e0YpqhQMntRhV6oHHKV+SjoFndv+97B6pWOoBnOY6H1VuTklwWFI1FHKCNoD+GacyqnqML6JtkA/kPZ0dRyHMdV3QoULQUjv8628/3WdwSBqlNSuwmfk0UD1eyNZZA6f4J5ZHHDVPQgCNrh/QFtfTIPUhsMGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KufFmmHx; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KufFmmHx"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-8422b544a4bso2179214b3a.3
        for <linux-perf-users@vger.kernel.org>; Tue, 02 Jun 2026 10:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780422122; x=1781026922; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iotGOx3jMR4tDVWp1JTzlSSm5z5uHBCJINbc/HPb57Q=;
        b=KufFmmHx9vvp8BQGBwqg7SApea5i36sUXQxWVbsyxl9WDnCTQmLZddznAfk03+n7a7
         GvZf48sbW59jy4HwRVhlGKPjjWip3MBIfIiJ6JvOD6OxpJX/OqdZUyu8kJiEtQunloYs
         1JF3YTPRDNnp+vN1/rJob5H6ttyznk17ir0NDduZTLasf47NXesJyBsYaKV2sE3CwjJc
         bSzEHZw87969dCrh7AWdc1b+AToaP9hynxLz5ZCKvcB3WXGckTDldYgCSrXBibMkhFXi
         016/JmOjmYgZjr3FJ6Srl3Dgdy6W0i+9T5L44RwBY4yW6XKfj8q2uAhJC6Kbw7FwNugA
         kDaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780422122; x=1781026922;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iotGOx3jMR4tDVWp1JTzlSSm5z5uHBCJINbc/HPb57Q=;
        b=SAOcVlnbmYdH0bVKBZgWvB8hUQMW8Spr20PeQDtH/U1e2407KWqVz5UnTkfDf7Z7uS
         RoTFyh8qQITl5S89dHJTwhymN6DpaTBnsdnsZkkV0KhcMP6ZwYqGlPylIZNw4Yl5jfAI
         UjanAE/u0gZqymUWzXhwMitCxvxl3iAjnXYzAySXSuCbhQdMxh1+l1G6+qmKfOMAGy9v
         hphJm3M8uuZLjskci1F50YEKYIW8TJGEMmu2RwMGP9lifUKLgbFZs4LvTqmwxTVYtNha
         PpOOEqtiWRXTzE7dnJMWts9qLn+SHcTFSxglkgapJ6FKBoLELHUVz1d8e6sHVipG1D3/
         i1dA==
X-Forwarded-Encrypted: i=1; AFNElJ8uPIRvc7fPavcqbXpq7s7pKZGGEmdNBPmxC7JPnREeqoV/rZ/rtDWIRXuy1SjjNrdxN8RR7JluclQ/eARvDezj@vger.kernel.org
X-Gm-Message-State: AOJu0YzKNhrEZk1W9wJ5NcBD+l0crCMc2alFKkZ6QT3+KTt/s0F4+VQu
	bndqgsJEytD741UoAJuydzK7x8kLBixDA1H5Wy1CUlPXtyxTvzNivhD0d6jS81ZTZt5T+x5q/9t
	h3BGMAXP1Gg==
X-Received: from pfes4.prod.google.com ([2002:aa7:8d44:0:b0:82f:6a26:5f78])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2d01:b0:842:6e1f:c8fc
 with SMTP id d2e1a72fcca58-8428310ebf1mr459416b3a.32.1780422122197; Tue, 02
 Jun 2026 10:42:02 -0700 (PDT)
Date: Tue,  2 Jun 2026 10:41:18 -0700
In-Reply-To: <20260602174129.3192312-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260602073132.2653307-1-irogers@google.com> <20260602174129.3192312-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1013.g208068f2d8-goog
Message-ID: <20260602174129.3192312-8-irogers@google.com>
Subject: [PATCH v8 07/18] tools subcmd: Robust fallback and existence checks
 for process reaping
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

Assisted-by: Gemini-CLI:Google Gemini 3
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
2.54.0.1013.g208068f2d8-goog

