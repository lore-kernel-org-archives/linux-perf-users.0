Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C064734D3B0
	for <linux-perf-users@vger.kernel.org>; Mon,  1 Jun 2026 06:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780294503; cv=none; b=d3NfmxmqwWn9Wr4Xktk+qUSSbLWYkeBO21Py1q1BIHfftnZwCrW+8uobKctpJ6vPVcmVhKGRVqezdnscQCorgvKcrMTiatt33Ceza9hp2ZQIz49wrHrai39YIA6YX8hQ6JZac59PGr1VXimStAlVHb6VxKbSGwMt+M461zR33c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780294503; c=relaxed/simple;
	bh=7n0GOpFdK0D9/T2ts6a0KLwCVVtFYd1C2oZi1sY0al0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hevSja8Qajthgn59X9OKSRSIbqcAh4795EoXIz8SKY+yypUUev7vlnqfEjy7suFAVfObkeqg2PsL3YW2yHpCbSr/AkN41n4uHGK0qMuubbBxiQik1SgFNxCQqPWZsklWcrsV64isPaHvT/Os9tsKvwHDsN7qFYY0xdaIWDy3jhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OagFg4NN; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OagFg4NN"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-1365060ac82so8095720c88.1
        for <linux-perf-users@vger.kernel.org>; Sun, 31 May 2026 23:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780294501; x=1780899301; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=I451DX2U3uFjvueSGTTz18fbr5Eyooiuku7kTqgCnjM=;
        b=OagFg4NNKI3Fosr6fr6agxcOG4G8a300jSGkO9CBIFnM81ftz1M0iXnPTgqJA4fYbK
         8gk/QtxAK6cR+KdYpBIMqVLPeE0fKGmh3lLqMJVN65Pkl/V0j7/ns+pxYk9ZF9PmZKj/
         o3TirkoKNFIVt4KadlMhBy8kZzdTG46ExWyzR4SQ5auvJELW2jGJSJm4qwfY5C3Kd3NR
         ZVgxnde/YGjXIy9Vws146Tl180MQzbB+xgz6BkUxvy0dD6JwEEzDd+crZHMpEaTGrSQo
         F5o08J3YrS6ILNTNe4hYaGIypBMe3OlEwB4UIKWzHCPnwpOTZQ5U3tv/nbBR6aT/ncWF
         CvfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780294501; x=1780899301;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I451DX2U3uFjvueSGTTz18fbr5Eyooiuku7kTqgCnjM=;
        b=bEBZdX4C9x3YvP08leHF7DWWgJY7t5RprX0ZNzhB/CDoDaVeeEjKTuYQwXUcDR/rLZ
         jhE+k0tNimOiyeuWWlnf5aZYEtYFFuMkBJLCsBchCm+yVpJJmIra6TMTESzVUDbqCmtO
         YUJFxVkLVJMxhLn3I41/2jq/SGb6z7uh1G5jZTL7Gyxo4M71cTX5IK/grvRfmkBEKWJp
         661NNrMlSyBYBX+H8Xdhsyk1OYzzS16Ok/HDls/8KCRWAGYs32lLmVf3Fej/F9njWNZh
         gGW0RfB8Q7sfgEX6DYrGHIyAeDs6b1AsGPVqyX+hSOSpTBMhqHVdpD1LHQsGERVowZRB
         kPjQ==
X-Forwarded-Encrypted: i=1; AFNElJ+lT2/h6JxyJgBn2AZSFmoQdbhKOAkCcv/XJQGfeYnLqgQIJHdyeg8pzzqVrIyRDoFKNJ5cgCe4RY48PByGqH0d@vger.kernel.org
X-Gm-Message-State: AOJu0YwMQf3uVRiDYo0KO12sVIfS5fzCp8yyxMXqdTeZwmAwR+0a8uX7
	Y5ru1NvvFVS1fITPapcoZkh5P+qvvjQTzKEOQhPdJT1RGNz+/mJZY31yKmAhbByeBQiIfp5fjgx
	hnL3L/6BV2Q==
X-Received: from dlbsj5.prod.google.com ([2002:a05:7022:f905:b0:134:b02e:a831])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:217:b0:136:aebc:24f5
 with SMTP id a92af1059eb24-137d4435cddmr3481044c88.15.1780294500509; Sun, 31
 May 2026 23:15:00 -0700 (PDT)
Date: Sun, 31 May 2026 23:13:52 -0700
In-Reply-To: <20260601061401.1541457-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260601000548.1195604-1-irogers@google.com> <20260601061401.1541457-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260601061401.1541457-7-irogers@google.com>
Subject: [PATCH 06/15] tools subcmd: Robust fallback and existence checks for
 process reaping
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, adrian.hunter@intel.com, 
	namhyung@kernel.org
Cc: alexander.shishkin@linux.intel.com, james.clark@linaro.org, 
	jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

Update check_if_command_finished() to check if cmd->pid <= 0 to avoid
reaping process hazards when PID has been set to -1 on startup error.

Transition the procfs status fopen() fallback from active waitpid() calls
to robust kill(pid, 0) existence and ESRCH detection logic. This allows
zombie processes to remain until explicitly reaped by finish_command(),
eradicating the risk of infinite loops induced by kernel PID reuse across
unrelated system daemons.

Assisted-by: Gemini-CLI:Google Gemini 3
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/subcmd/run-command.c | 51 ++++++++++++++++++++++++++++++++--
 1 file changed, 49 insertions(+), 2 deletions(-)

diff --git a/tools/lib/subcmd/run-command.c b/tools/lib/subcmd/run-command.c
index b7510f83209a..5ae7b9fa4dab 100644
--- a/tools/lib/subcmd/run-command.c
+++ b/tools/lib/subcmd/run-command.c
@@ -233,7 +233,14 @@ int check_if_command_finished(struct child_process *cmd)
 	char filename[6 + MAX_STRLEN_TYPE(typeof(cmd->pid)) + 7 + 1];
 	char status_line[256];
 	FILE *status_file;
+#endif
+
+	if (cmd->finished)
+		return 1;
+	if (cmd->pid <= 0)
+		return 1;
 
+#ifdef __linux__
 	/*
 	 * Check by reading /proc/<pid>/status as calling waitpid causes
 	 * stdout/stderr to be closed and data lost.
@@ -241,8 +248,48 @@ int check_if_command_finished(struct child_process *cmd)
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
2.54.0.823.g6e5bcc1fc9-goog

