Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C094F2DA76C
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Jun 2026 07:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780385504; cv=none; b=Nck0Ys4bmx4d7DLxzvH3ib5inbk7UAKjtX8K+b3pYIVaggFl3Tis7ie4CG5LqLXNYLqg2qxX0f+QzG37QQZIxJZFoY9AmmjyEF0c6dAJU5OALAZQt1C7OgJRvreiRIQQ117ZAQQ80CWF40ovvoPXdGrVYM5jqNhWfuLHd7+Y/Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780385504; c=relaxed/simple;
	bh=IWOg3/r5HH/nHVezZY8s/UQg/HMZImK5fAKTwC3rPas=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=E/6SrirGZEV11sN5vx26PxIEfngSmB3yVi65NuH2Vz8h65Yn/nnk8b75KTmUMpL8p/152ohPnm7Hx5Kofy8t1P0VLeFdxZuwQKlkR21p1xBZR3Ij80Csd44+tlcxmr3kqt/cZ+UGpPHbAE6LmEdE1F/JC1h4UeYeY/dA/PHYq+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Owqhx97x; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Owqhx97x"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-137dd5100c7so3689346c88.1
        for <linux-perf-users@vger.kernel.org>; Tue, 02 Jun 2026 00:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780385501; x=1780990301; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ww4Ls3lfLjoC/rNY6qfkoB5Qxh88DLI22GdrDMFE67k=;
        b=Owqhx97xM51sJNqoK7x8aiKnB7mUGhtwPoSs0xrnbDFhD74M3Lj2Wb0kCn3KjtBwgH
         S0GxIxjtPYjDnkzHcQyg3cDmQvpubtR/oFFqIqwSFuZtLww7v6OQJh7FOmvDdvxdVeVc
         glKuiUmuyK52ok6k/lLGDQ7TkERiaJDLOai8zHOgLy3uNdodmjTvScXtVu/H4g6u8Fy6
         Z7M6OeA2wTgu4V/p5hslpSFGkDcyC+MgihwAvWPS1innWDPf/8Ovz7xOEvbv+hnGc2U1
         MTjdb0EB0hF2uURDctNXyAZv5Y+iZMFcn2a0CCiuJMQK0PrVkfkmMF+A8YiohOk3DBxm
         9s8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780385501; x=1780990301;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ww4Ls3lfLjoC/rNY6qfkoB5Qxh88DLI22GdrDMFE67k=;
        b=O/biAJsFAOXcqCHAnZJbp7qdtleegYSoFr34XI0VUxigrw2LdR8cp7GdwkMV5e23UY
         NP6tYtKbLaXk5XJY17G6CMqGN7+d9cthuQG7RRH/En5y6UhQFvfHxnZfj3lY6MZPUl1K
         mJH9bdrSYiGPPCi6k1jha/c5QMbiW8oJ/Q/tUDT957rFFKn4xodj+YgBnYR+u9odF2Fz
         51GT8VOJgPmdjQtf1B3zXgkJUXey1kwY/i51LqynTnUL/RSLy6muCvbzZjjxmikoceNh
         FDA5WOZ9lUM5iePUyHlwOYd5bTFhZS+JYfCwz/fAo0PQAIaDrvYJEoo3i8TTSfeOvo8w
         oioA==
X-Forwarded-Encrypted: i=1; AFNElJ+EQIz9DJK/w9vMQSQJcV0XJx0gkbaLFC2fZFSBAVvs0GTgAI4jTb+Tfiu9DcY0v9OQ+iHVDt+GeqNkrl95dz3P@vger.kernel.org
X-Gm-Message-State: AOJu0YwqXcAsYsFI8zprAn+59+r7yHH12ZuV8FVda6ViCjTlnsgFILnj
	oRF1r4eKMI8q/csGkif9FxXmv3x4cDkk4EGEYX54Tn3oVLAIoiVLxpH/SKZxeTFLVe7PzDPkRvm
	m3+iQhlaDJw==
X-Received: from dlbqq10.prod.google.com ([2002:a05:7022:ed0a:b0:135:db69:f5db])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:ec0c:b0:132:5d42:55ba
 with SMTP id a92af1059eb24-137d3d09ebfmr5987771c88.16.1780385500481; Tue, 02
 Jun 2026 00:31:40 -0700 (PDT)
Date: Tue,  2 Jun 2026 00:31:16 -0700
In-Reply-To: <20260602073132.2653307-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260601061401.1541457-1-irogers@google.com> <20260602073132.2653307-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.929.g9b7fa37559-goog
Message-ID: <20260602073132.2653307-2-irogers@google.com>
Subject: [PATCH v7] perf tpebs: Fix concurrent stop races and PID reuse
 hazards in tpebs_stop
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, alexander.shishkin@linux.intel.com, 
	james.clark@linaro.org, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

Parallel verbose test execution can trigger a race condition in tpebs_stop
if called concurrently or when PID reuse occurs, causing finish_command()
to block or reap the wrong process.

Introduce a `tpebs_stopping` flag inside intel-tpebs.c to prevent
redundant stop execution paths, and safely restore the `cmd.pid`
temporarily only during `finish_command()` to ensure it is properly reaped,
while preventing other threads from referencing it.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/intel-tpebs.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/perf/util/intel-tpebs.c b/tools/perf/util/intel-tpebs.c
index ed8cfe2ba2fa..ddb0579a451e 100644
--- a/tools/perf/util/intel-tpebs.c
+++ b/tools/perf/util/intel-tpebs.c
@@ -37,6 +37,7 @@ static pthread_t tpebs_reader_thread;
 static struct child_process tpebs_cmd;
 static int control_fd[2], ack_fd[2];
 static struct mutex tpebs_mtx;
+static bool tpebs_stopping;
 
 struct tpebs_retire_lat {
 	struct list_head nd;
@@ -320,8 +321,14 @@ static int tpebs_stop(void) EXCLUSIVE_LOCKS_REQUIRED(tpebs_mtx_get())
 {
 	int ret = 0;
 
+	if (tpebs_stopping)
+		return 0;
+
 	/* Like tpebs_start, we should only run tpebs_end once. */
 	if (tpebs_cmd.pid != 0) {
+		pid_t actual_pid = tpebs_cmd.pid;
+
+		tpebs_stopping = true;
 		tpebs_send_record_cmd(EVLIST_CTL_CMD_STOP_TAG);
 		tpebs_cmd.pid = 0;
 		mutex_unlock(tpebs_mtx_get());
@@ -332,8 +339,10 @@ static int tpebs_stop(void) EXCLUSIVE_LOCKS_REQUIRED(tpebs_mtx_get())
 		close(ack_fd[0]);
 		close(ack_fd[1]);
 		close(tpebs_cmd.out);
+		tpebs_cmd.pid = actual_pid;
 		ret = finish_command(&tpebs_cmd);
 		tpebs_cmd.pid = 0;
+		tpebs_stopping = false;
 		if (ret == -ERR_RUN_COMMAND_WAITPID_SIGNAL)
 			ret = 0;
 	}
-- 
2.54.0.929.g9b7fa37559-goog

