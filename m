Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5711D174F
	for <linux-perf-users@vger.kernel.org>; Fri, 11 Oct 2024 22:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728684249; cv=none; b=CxBEXbPTzXcrwPIR6FbO7yfRYuZTKIFRma8VR3e5ZLNPtAWldSqz45vf75AlyKL5zHDGjZQUjCrtVztt7l1ffz/qCa2NXwu4sVNS2u7yNxTfMhmY+6R7z8mlqEsAzyRJoz7ROKJ1K5BqDSllechTR6MLWeeCvYQdCYYndeO11Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728684249; c=relaxed/simple;
	bh=32CmiUO1Nu2w18z0VnqAHZyV/SwfhR5oLEkO3QAxKfY=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=W0bzCVXzs9VRHkiknnxPeX1WHkk1FTaxkWeEa+Du9swGCKZRR9zipGbEQNMR+w5d7JlVMEQCqSKAb3tRMxuaJT+Nvlu49RPiUkF32bsecBzob/u7dYyB97eTcgy8dcQ9EJD0JyTCQeU7er+R463pgfMtK1H7AUrszSNalplxyp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XUYiItyV; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XUYiItyV"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e28edea9af6so3439026276.3
        for <linux-perf-users@vger.kernel.org>; Fri, 11 Oct 2024 15:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728684247; x=1729289047; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pZqf2//xoOnb1H5/bkKLpMOcQ8vCY8XnITbcBJn/Kk0=;
        b=XUYiItyVexYmSCGBksEkVp7O9ddScH8lPGOrdlo/WY/drSzJY7RZ1+i1dD+F30A5vv
         NuTl4IAuwiJNrWnLwK6ZehbGOI5Z937VVkLOwXHrZ5YjKBF2bW6K4WxFSL14Vsj77a4/
         ykO00OgomaDsC5r4fyMRpxHKf1jYbSoYawvI/zF6KfkfcDmT3K/qQ0fTiaINIyok3tKa
         P4tCQQ3glpir6OsLBPvZQGU5cfm8gCoWnnyMeSfFDUMiJkdDSgHIHaV+zFuHUwL3XBQC
         salC0cUGKhGf1HANZRTZdiukwcYNW5yqdsGJu+lSdFL6SSkjsUqRzzTn1x/COr7+p3oK
         y2xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728684247; x=1729289047;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pZqf2//xoOnb1H5/bkKLpMOcQ8vCY8XnITbcBJn/Kk0=;
        b=RlKe68ZIFjh9HskqjmxpcvE2HkzYM/M3kui7bJ4NNLkw1EGeENLGqmYZchhcW3FHXn
         yfZku2Ze4svmydBzv+pko6l+ZXr34i/21+4c0qssgGCXp/zzc8UXtA7f7JH/rJv+mEU/
         xeRsNo+D1uZZc6nXss8yX7JGkO5YRDTal7XzwzKyrxc9HJu+wqWWSBW+NJt3sNl0rW5h
         FA5xDrWxtPaVTl7W7yT3kXwbDFYzef+8SYlnk9t6plXa7Xj7tFhoKyRWssfaslN5HSOZ
         HXkoeTkAGgQMdhl/P+XTh7GKIf0Q1cWVTrDDTmfhL2LStOiy5eWYhGOnCRXOmLRh8fXr
         ERvg==
X-Forwarded-Encrypted: i=1; AJvYcCUl/OX+5IGyn7VtcDTGWf+iRxKmIId24DzgJCQ9h5UFGzxVjyFYUaTwQQhK/1oONBdQr+2++cQTh3m0KXSC/MjS@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+SqVT0RUiGm5Tyfg6pZkC1+tu40RvA42GgnXzrPxrccPe2Wd3
	00bw2ApCHNYcwKIzQWqrlXT2RjthIlopl2N4vddn3SR3kRpGonQWL2nunuQdLaeYxjKO6CVFzeD
	mVPeN1w==
X-Google-Smtp-Source: AGHT+IFnQwK3S6BS+70+ID2qAC5s213z8mYXWb6kgkgpvLhH25KIn26m/qM2zLiTiXCF/WTydr0Zy+VcCrx+
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:8144:56f:2e1e:4db])
 (user=irogers job=sendgmr) by 2002:a25:ae8c:0:b0:e25:d596:4847 with SMTP id
 3f1490d57ef6-e2919ded25cmr12084276.6.1728684246675; Fri, 11 Oct 2024 15:04:06
 -0700 (PDT)
Date: Fri, 11 Oct 2024 15:03:47 -0700
In-Reply-To: <20241011220354.756798-1-irogers@google.com>
Message-Id: <20241011220354.756798-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241011220354.756798-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Subject: [PATCH v2 1/8] tools subcmd: Add non-waitpid check_if_command_finished()
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Howard Chu <howardchu95@gmail.com>, Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
	Michael Petlan <mpetlan@redhat.com>, Veronika Molnarova <vmolnaro@redhat.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Colin Ian King <colin.i.king@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Using waitpid can cause stdout/stderr of the child process to be
lost. Use Linux's /prod/<pid>/status file to determine if the process
has reached the zombie state. Use the 'status' file rather than 'stat'
to avoid issues around skipping the process name.

Tested-by: James Clark <james.clark@linaro.org>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/subcmd/run-command.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/tools/lib/subcmd/run-command.c b/tools/lib/subcmd/run-command.c
index 4e3a557a2f37..0a764c25c384 100644
--- a/tools/lib/subcmd/run-command.c
+++ b/tools/lib/subcmd/run-command.c
@@ -2,6 +2,7 @@
 #include <unistd.h>
 #include <sys/types.h>
 #include <sys/stat.h>
+#include <ctype.h>
 #include <fcntl.h>
 #include <string.h>
 #include <linux/string.h>
@@ -217,8 +218,40 @@ static int wait_or_whine(struct child_process *cmd, bool block)
 
 int check_if_command_finished(struct child_process *cmd)
 {
+#ifdef __linux__
+	char filename[FILENAME_MAX + 12];
+	char status_line[256];
+	FILE *status_file;
+
+	/*
+	 * Check by reading /proc/<pid>/status as calling waitpid causes
+	 * stdout/stderr to be closed and data lost.
+	 */
+	sprintf(filename, "/proc/%d/status", cmd->pid);
+	status_file = fopen(filename, "r");
+	if (status_file == NULL) {
+		/* Open failed assume finish_command was called. */
+		return true;
+	}
+	while (fgets(status_line, sizeof(status_line), status_file) != NULL) {
+		char *p;
+
+		if (strncmp(status_line, "State:", 6))
+			continue;
+
+		fclose(status_file);
+		p = status_line + 6;
+		while (isspace(*p))
+			p++;
+		return *p == 'Z' ? 1 : 0;
+	}
+	/* Read failed assume finish_command was called. */
+	fclose(status_file);
+	return 1;
+#else
 	wait_or_whine(cmd, /*block=*/false);
 	return cmd->finished;
+#endif
 }
 
 int finish_command(struct child_process *cmd)
-- 
2.47.0.rc1.288.g06298d1525-goog

