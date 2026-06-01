Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D53DB640
	for <linux-perf-users@vger.kernel.org>; Mon,  1 Jun 2026 00:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780272372; cv=none; b=gEbjrj3gYWLEuZ6X88pKRq5MKycrNw+DF69JZ2+Ck+1FveJGtjNMo0yxwcN+IRdYUvpVmA3rqog3BF6bEyB1Z7cqtYqBTH54yVLyGh/cfaPXZ14Jsk7wyupJAG0J4WkW6YZayz2aezp3VJlmm/v3QUHDtE7gt8guygvQxabRRBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780272372; c=relaxed/simple;
	bh=dvReU4g/NxS8DLIsJ2sbcFS0Fd6nVsGlSNQltEjnBZw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lvYF2sVRxsKV4A5GM3GVfXXBEN2SuY+sNcukKvaNE72XXT6hbeoN9NOI/QmRGT6GXlvAJkgbObnwkkUY2K33Fo9nbI5tPPZdUegc5JJ6+11xaicHj3NKXVV2fpVeTWrj/EDA0avXVivyoOQxnNVR+QSxHKFCUnG4fZRJQ0A71fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lEGDea2q; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lEGDea2q"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-304df51ff3eso3529460eec.0
        for <linux-perf-users@vger.kernel.org>; Sun, 31 May 2026 17:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780272368; x=1780877168; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=h9fLZuj/ySLLFaADzST448l4SO7NZ4u7R/46YrlFeHI=;
        b=lEGDea2qCXS/4ccWDepxg89egqbgPhYaNU4JVMVUVxJvF/IfvJlVs9Djy0Pvw8Ck41
         LBDTxJbN4UwkSUW2NFz3n5p+R+5IOJWgxBfBXouy8iv6g4tud+wwV08g7vT3+AmIl62w
         v7Qz86s2ItWmZbZ3LC3a5X+0RbTlHDQNFPKT/oLeXM/S6IktHzjZMVTRCUsGIsvBbKv3
         JhZaeE1TQRGk7t0EnPc6XM/lXNTG0SoKYfnCDDxqxo1fJSDC2onQLz+HOUKfBmSyoOgC
         abpZdbbiML8NUeIY8/OB3nSYm5nLULgSLoU222jGp1hWpO1c7ufPZapndquBRJG9oWxw
         TIOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780272368; x=1780877168;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h9fLZuj/ySLLFaADzST448l4SO7NZ4u7R/46YrlFeHI=;
        b=pXRydM31fEDH0iJKAKBbdrP1AvwmKe7mDAflO5o3+zjsYSUi5ycvUFlIxGzJyZ1JUs
         e9hEleMdZpqi+NyBAedC8+/cFO0iAXZo495BqQINi0AnILj/pKeNpDSdf5Ieh5/pSbli
         wcr+M38UbWk/ciszbA+Dv8+WDQyH07Ut8sCWwqq0Rb3wJlm6wJPFhC4nMIzMtu/6mC1w
         Pt+Irv/PwvSedaczF28KK2J+pUlSCiPcGE2AjoI3KzwC6phMeBJ1FA/N6JdYlAWqkaV/
         m+svJ6ON7kFdbV9k56HBzR++b7uUAcm0nMOO/cyLDOhLQx4G43716wj3rlBOUZ3nP/Wi
         nLvw==
X-Forwarded-Encrypted: i=1; AFNElJ8vjPh3LMb3G4vFOLpDqgi91PRSn/1+rDTjs4KzULGSKGTqo19OtP7d1ruyDm5LXKajJiKSs0kAy79+W46m7cK7@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf205jFKs6C+AmIi4bxjcHUsX+OhuuRx8d/z4wcV6RD1/HPjgj
	gIuubBS9amuc2IOMqDUYYFik13xy6QvEtioay4nRUu8zG4Qd5ulKH89V+lfS9ITNco2XRqolqw2
	d1/HpCFaKow==
X-Received: from dleb1-n1.prod.google.com ([2002:a05:701b:4241:10b0:136:8134:c2ed])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6085:b0:130:73ed:208
 with SMTP id a92af1059eb24-137d3bf3fbdmr3244860c88.9.1780272368172; Sun, 31
 May 2026 17:06:08 -0700 (PDT)
Date: Sun, 31 May 2026 17:05:39 -0700
In-Reply-To: <20260601000548.1195604-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260531082235.940833-1-irogers@google.com> <20260601000548.1195604-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260601000548.1195604-7-irogers@google.com>
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

Transition the procfs status fopen() fallback to robust waitpid(..., WNOHANG)
existence checking upon EMFILE/ENFILE limits.

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

