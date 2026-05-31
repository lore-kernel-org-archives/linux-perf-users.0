Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B1A3815FF
	for <linux-perf-users@vger.kernel.org>; Sun, 31 May 2026 08:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780215782; cv=none; b=I0sChVLmv48pzz5ZY0u8F43NmnEVZmxMdu6pCTS9kbqFsKVHU0b1Qwbb45QR2YKphrFVyAQ1NLr85EHX3einWVTijwKs0g5FGEsO1hqdJzw2pfnmg5FN/4CGp7cjk0oooAygGVGUTYIEzyUzszagU1yl+E+tdv9W5ZYLkalECP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780215782; c=relaxed/simple;
	bh=wrNm9QLAb+VQwqq9JlUudLM1iAVOj2+j2UxoNxeus9o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uEhrbgqsk53B8WnLXphyPH0vMKGnr6UupgduTwoQy07UiYbSFc7phONSsJSTCoAUMllLCQ0339Tw+wSvTJ95u7cRECuQz1B/nzs70lvLYVZfBcyhVFc8ipBOZnrMT9KGoGzrNTQ8UptOpaLwRJLCDjYLyWjH5A5oWjahqRPXRrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oipWUuC3; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oipWUuC3"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-304f1820babso2544503eec.1
        for <linux-perf-users@vger.kernel.org>; Sun, 31 May 2026 01:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780215780; x=1780820580; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uaRQ49pm2mOAYIqJ+hx7MMSjBKGvNpBDziWUSvD72VE=;
        b=oipWUuC3nSnF3dEXP5KWec8P9Fqo3LGvJrFWCuSwo2waHXJNzA9PIowtAniqLScVOs
         cqyHZ+/Ab3athvZUdaOhhuPsQqJxZYom4hXQg25vI8WHnAYGQkvfGBjwUATVW+nrxJy6
         lB8QL0zlwnGmoSiFlL7GvTi5yh/SaX8yRts81WJRM6VfMg499iLzeDDLa5efzYvw7fVF
         +sAklKZh1T10VdIzhQ0tX+L3sah6VA3YVUo4vnJIm91C3msInM38KwB/4JWjcqitMNM6
         0ilm5KMLzfDv0Cr9K1INGVcf0Yom0SV9Mhx6KTGJ7pQ0XPS/FonBX1L7CauqNQ3ATFF8
         jBIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780215780; x=1780820580;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uaRQ49pm2mOAYIqJ+hx7MMSjBKGvNpBDziWUSvD72VE=;
        b=WskwFTSha+8UZe46b5xbRL0ahIex3ib9Sf/zVyDjK/WZGLmuJgqW4/GJ9MEIK6hVeG
         PPMyx2J+Qe+7/UJsDzy0H+HuAbr1vs4YlNXFq7PbjrXda1/mXKV13cnD+lbzeyW7n2Xs
         xAqG9YBSBvoRmgFGsr0PyyKpSAMhaDTlscLGlf/ZwQJUb9m1Ll+xpZAp8AlvO6PZ9uXF
         fsq9pfsOCxvRv9dihLX3suTdGpip9be5b+Tv6DwE9lVDm6FqaGRTwVgCpGdH5BvJZg9x
         UwTe/80p5CSbBg8KXDYLEjf2M3ONTxHEYqi4HJQIP17sKn7Ucgm+hVjDGldY+P3bhaCE
         YxXA==
X-Forwarded-Encrypted: i=1; AFNElJ+l0UEpZWJ/9RZmjzDPvpm6XKjg9ANReu3x0cA9PB9roP8DXd8NEoxoO2dk54fifKp8i5Nf4dJQ2qKH6Oy6irkl@vger.kernel.org
X-Gm-Message-State: AOJu0YxnyBgB65KLj7YHhNFZ4jcF1UPyhBHB1PaQTQp9UA35jer21ZX4
	4WRoirBOXqDT4XxSFShaVJjeg7g1+VsHImQOhMOs3HzbPh07VHM+DM/AUjIMceWR1A/biOrZRpJ
	ggfGkVqfXfA==
X-Received: from dlbcj19.prod.google.com ([2002:a05:7022:6993:b0:132:8d92:4d6c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:661f:b0:119:e56b:98a4
 with SMTP id a92af1059eb24-137d401c317mr2506414c88.11.1780215779314; Sun, 31
 May 2026 01:22:59 -0700 (PDT)
Date: Sun, 31 May 2026 01:22:26 -0700
In-Reply-To: <20260531082235.940833-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260531063736.871777-1-irogers@google.com> <20260531082235.940833-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260531082235.940833-7-irogers@google.com>
Subject: [PATCH v4 06/15] tools subcmd: Robust fallback and existence checks
 for process reaping
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
 tools/lib/subcmd/run-command.c | 50 ++++++++++++++++++++++++++++++++--
 1 file changed, 47 insertions(+), 3 deletions(-)

diff --git a/tools/lib/subcmd/run-command.c b/tools/lib/subcmd/run-command.c
index b7510f83209a..a305935d2bfb 100644
--- a/tools/lib/subcmd/run-command.c
+++ b/tools/lib/subcmd/run-command.c
@@ -229,20 +229,64 @@ static int wait_or_whine(struct child_process *cmd, bool block)
 
 int check_if_command_finished(struct child_process *cmd)
 {
-#ifdef __linux__
 	char filename[6 + MAX_STRLEN_TYPE(typeof(cmd->pid)) + 7 + 1];
 	char status_line[256];
 	FILE *status_file;
 
+	if (cmd->finished)
+		return 1;
+	if (cmd->pid <= 0)
+		return 1;
+
 	/*
 	 * Check by reading /proc/<pid>/status as calling waitpid causes
 	 * stdout/stderr to be closed and data lost.
 	 */
 	sprintf(filename, "/proc/%u/status", cmd->pid);
+#ifdef __linux__
 	status_file = fopen(filename, "r");
 	if (status_file == NULL) {
-		/* Open failed assume finish_command was called. */
-		return true;
+		/*
+		 * fopen() can fail with ENOENT if the process has been reaped.
+		 * It can also fail with EMFILE/ENFILE if RLIMIT_NOFILE is reached,
+		 * or with EINTR/ENOMEM. Use kill(pid, 0) as a robust fallback
+		 * to distinguish between active processes and dead ones without
+		 * consuming file descriptors.
+		 */
+		if (errno == ENOENT)
+			return 1;
+		if (kill(cmd->pid, 0) < 0 && errno == ESRCH) {
+			waiting = waitpid(cmd->pid, &status, WNOHANG);
+			if (waiting == cmd->pid) {
+				int result;
+				int code;
+
+				cmd->finished = 1;
+				if (WIFSIGNALED(status)) {
+					result = -ERR_RUN_COMMAND_WAITPID_SIGNAL;
+				} else if (!WIFEXITED(status)) {
+					result = -ERR_RUN_COMMAND_WAITPID_NOEXIT;
+				} else {
+					code = WEXITSTATUS(status);
+					switch (code) {
+					case 127:
+						result = -ERR_RUN_COMMAND_EXEC;
+						break;
+					case 0:
+						result = 0;
+						break;
+					default:
+						result = -code;
+						break;
+					}
+				}
+				cmd->finish_result = result;
+				return 1;
+			}
+			if (waiting < 0 && errno == ECHILD)
+				return 1;
+		}
+		return 0;
 	}
 	while (fgets(status_line, sizeof(status_line), status_file) != NULL) {
 		char *p;
-- 
2.54.0.823.g6e5bcc1fc9-goog

