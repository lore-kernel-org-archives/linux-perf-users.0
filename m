Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AAF33C9899
	for <linux-perf-users@vger.kernel.org>; Wed, 13 May 2026 23:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778713533; cv=none; b=CRUqVaKiXAI1/+E2OxpP1HHu5UTlGVnFksPAos0K/5vUGtQCA0ou0RKeGnuKlF40FSVsQ826aOHJ09wbD9YGHQ9QxBW5iolP7p6BXubW6y6YmUEGAWk3spJRO4Nt/htYdhEQQ4YwTm4hybeHzznldsXdXMqUfTRu/eetOSJ3DSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778713533; c=relaxed/simple;
	bh=vpf+2Z0ckU17Vs/9aEBAStfnVa36ISsrnoMZSSRvK30=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=vDRO8+w1hSuWTj87ytS9kcGjA2c4bEIhZz/OdzgnvC5Fr4+gTe+bsRUP/tCrv1LUFyDZLMLXQpwK9XprzLkSU+yuhnBV+y4kpckYD6VrSv2Ffssyf16cJNRM0YG+n0K+6IJUupV92Oc7timM630teKaGDkMqvc4zNNIcwjsILqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kRySqyGJ; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kRySqyGJ"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-132d631edaaso22587119c88.0
        for <linux-perf-users@vger.kernel.org>; Wed, 13 May 2026 16:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778713525; x=1779318325; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oAnSqe0u3N3zRPR+yqo5zwJWmBEDQU9syav8IE+ViOo=;
        b=kRySqyGJR7PU672PSU8IvfJ337DklGHXav2H3X7MVezKoon6s2DeWmokvJHvF7mhXH
         GXBJsyUaSzFHZG8YyrbNezj3QKV9IATbYaOzzaZ1ZoMlXzs74ZO5oX1sOJWaleSH/rIN
         By6qM90kw/pA+ZNdTBAtzQdyOjwJLIAuvr3jjMNuRi+WegHfvF1HaE7BjLiaOUKKAAsY
         pn7oJJN9C9B91hnS6KF0AvNh2hHgOio5RnImrRXEX3oRzPD2ZbbUjdUZH4t67Y6S20TJ
         qZan23f1UlOXzPw3MZpQUjztaiHfznNueWA+DPGxX1+EwyrDvZsF4vxJy9WNGyQzvWNk
         Q7SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778713525; x=1779318325;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oAnSqe0u3N3zRPR+yqo5zwJWmBEDQU9syav8IE+ViOo=;
        b=br87+S26iStynHVeB+LYHlDebVZg8pmYveMqIlvgbFKfCL7LmdgfLK8DJqm8dqzMwE
         aituSPCuXE7OsZw8fLk/E+f9seyimPdbsOtUrEjbq6nxxcqWGaDv89xVJHaZob1GfRiw
         GgA6OO0inMrbqSgnJTfnOtxSD9vP/zzWHs4q1t93hD8UEM66S77Ri48YFvQ56dsQIf1c
         OHfMc25SGtAzAuEPPpqXZB4+hvZcp/9lPHX4gQ+YuZS7d3F7J5dceIRcXd+sinnuAZaf
         R7udm1lnkCvU1IIsEIFEebj/gyZza88+LTLpImj3y7nLhGBc2Rduyu0gmSM0hdZ+uLwc
         bpVQ==
X-Forwarded-Encrypted: i=1; AFNElJ88CYjTD8mrBNzo0cRnxCRVlH9DfZ9Y7oJG3tIVJCb4ppeBBO/p+mqNeIx9t00nMFmeZzEJN7vMJJb1g+H8IipV@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ3FmApcv1cPoG7EqnRTy2r+anxaqnR+U/+BdByJYqIgytSlSy
	zfckbe01s9rmMHpnQRjHiCPttZ6THkZuE8iN0gX2WxgS+IuzeF9aFmwXgmAEAhf6WT3fn3KmPSf
	tIzaIXR4OnQ==
X-Received: from dlbbq39.prod.google.com ([2002:a05:7022:6727:b0:12d:bbfe:96d3])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:438c:b0:12b:ec67:3523
 with SMTP id a92af1059eb24-1342ee3ec9bmr3202937c88.9.1778713524367; Wed, 13
 May 2026 16:05:24 -0700 (PDT)
Date: Wed, 13 May 2026 16:04:46 -0700
In-Reply-To: <20260513230450.529380-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260513230450.529380-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260513230450.529380-11-irogers@google.com>
Subject: [PATCH v1 10/14] perf test: Skip shebang and SPDX comments in shell
 test descriptions
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

When extracting shell test descriptions in tests-scripts.c, the parser
skipped the first line assuming it was the shebang (#!/bin/sh) and then read
the first comment line on line 2 as the test description.

However, checkpatch.pl expects shell scripts to declare their SPDX license
identifier on line 2 (# SPDX-License-Identifier: ...). This caused the test
harness to extract the SPDX license string as the test description.

Refactor shell_test__description to use io__getline, skipping both shebang
and SPDX comment lines. This allows shell tests to include standard SPDX
headers without breaking test suite description extraction.

Assisted-by: Gemini-CLI:Google Gemini 3
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/tests-scripts.c | 63 +++++++++++++++++---------------
 1 file changed, 34 insertions(+), 29 deletions(-)

diff --git a/tools/perf/tests/tests-scripts.c b/tools/perf/tests/tests-scripts.c
index f18c4cd337c8..48f28cb80db7 100644
--- a/tools/perf/tests/tests-scripts.c
+++ b/tools/perf/tests/tests-scripts.c
@@ -78,43 +78,48 @@ static int shell_tests__dir_fd(void)
 static char *shell_test__description(int dir_fd, const char *name)
 {
 	struct io io;
-	char buf[128], desc[256];
-	int ch, pos = 0;
+	char buf[128], *line = NULL;
+	size_t line_len = 0;
+	ssize_t len;
+	char *desc = NULL;
 
 	io__init(&io, openat(dir_fd, name, O_RDONLY), buf, sizeof(buf));
 	if (io.fd < 0)
 		return NULL;
 
-	/* Skip first line - should be #!/bin/bash Shebang */
-	if (io__get_char(&io) != '#')
-		goto err_out;
-	if (io__get_char(&io) != '!')
-		goto err_out;
-	do {
-		ch = io__get_char(&io);
-		if (ch < 0)
-			goto err_out;
-	} while (ch != '\n');
-
-	do {
-		ch = io__get_char(&io);
-		if (ch < 0)
-			goto err_out;
-	} while (ch == '#' || isspace(ch));
-	while (ch > 0 && ch != '\n') {
-		desc[pos++] = ch;
-		if (pos >= (int)sizeof(desc) - 1)
+	while ((len = io__getline(&io, &line, &line_len)) > 0) {
+		char *p = line;
+
+		/* Skip leading whitespace */
+		while (*p && isspace(*p))
+			p++;
+
+		/* Must be a comment */
+		if (*p != '#')
+			continue;
+		p++;
+
+		/* Skip shebang or SPDX lines */
+		if (*p == '!' || strstr(p, "SPDX-License-Identifier:"))
+			continue;
+
+		/* Skip whitespace after # */
+		while (*p && isspace(*p))
+			p++;
+
+		/* If we found non-empty text, this is the description! */
+		if (*p && *p != '\n') {
+			char *end = p + strlen(p);
+			while (end > p && isspace(end[-1]))
+				end--;
+			*end = '\0';
+			desc = strdup(p);
 			break;
-		ch = io__get_char(&io);
+		}
 	}
-	while (pos > 0 && isspace(desc[--pos]))
-		;
-	desc[++pos] = '\0';
-	close(io.fd);
-	return strdup(desc);
-err_out:
+	free(line);
 	close(io.fd);
-	return NULL;
+	return desc;
 }
 
 /* Is this full file path a shell script */
-- 
2.54.0.563.g4f69b47b94-goog

