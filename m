Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47581315D49
	for <linux-perf-users@vger.kernel.org>; Sun, 31 May 2026 05:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780205289; cv=none; b=NJfPuj5C6CAwirh4URMW5ZormZG8Z+7esbmegL4EFlh+YAd5E0oOGfcoOOxPoLN+DBeXcdyOu8o+a1q1Q+UsU7l3rGoU57fRdHCAUd3qHrciIoH4nOBXzngHs4W/KIr7y3BVDpQEuSInSsTBg2AjcKsogWxDu5kNTNmbg17EQzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780205289; c=relaxed/simple;
	bh=o9S1W3Wj0PsfPl6uVprUkU7SxJX/Cs5+m2/NbSFzAE4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BNvxxQKPpOv5QLRqUemJqVU9d6BkBHPLu3CQNY0olVn8+8q9rpRaSJGxS5akZoHi8fvHxi18VRpDyX56aTHXsMvgTa80ljPTl2XHj/RG71sa+almjhqQ6DgeCUUmy6zEjLcwuOyEuDBWsNQCCeMRUqpYgXTvxN277jpT/HV3BZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YLQ1OEJc; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YLQ1OEJc"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-304e7fbfaf5so3150000eec.1
        for <linux-perf-users@vger.kernel.org>; Sat, 30 May 2026 22:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780205284; x=1780810084; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fS0VKuH2a4WRNjAkM6oVJSakxkg1EpritKWTCB2wi2A=;
        b=YLQ1OEJcgltoEKg22mx8UjUYtfdVvPLes1UCptGOs9oN9mEScOFMzPMJWH1o/HMrZ8
         hgh4par9rTwQpkGp1d5yyEPjAzIEA31iwdYLNjx5aY3yo43gc/nACGXSgL7InxmcfN8v
         1qaGcfYQLL3lfMHOjnl7zwrT2tQxPMzi+VvOwlTDcLH9A7OqMiR5BWS4GhkVoH79SVXk
         ISnDOFuBGHSUVknxKg+c0Qt/e0gACzL3oaCYwDw1VOcZVxMK5HiViSojCtvnPCEzs7PI
         /FwnhSUQhn+W5Svu+Zz6W+uPLCKYWfxo6t/WPAfayX04xrTI+ZzF4u+APzT3fmzNLJgI
         UqEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780205284; x=1780810084;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fS0VKuH2a4WRNjAkM6oVJSakxkg1EpritKWTCB2wi2A=;
        b=Qp243+V5jkfnRqYXOlGFcOP2kG48Rcyt5VQ6wtCxKfo42WltcfmkM/2enwMmqxdInC
         fA2MCoSjsZ+VaQeBIUdI6R95+RxUmJnAghQwQvmevglXyrlFectzGEmvgxDwynMVibLl
         jkrpg5nJ8ZYqvr6O4oX3VVM9cdsSMWynqzo3HT4WAGS+dRVSuljhrMQBXMVgdkPHC5o1
         5gX4JGde9lL/JKl8gfjFKL9EYhrgSMG4zzAFWwMOCpzUdeJtcz9waIlE+g45gtBZERgu
         91Punw7PmOJuLA/1eGkFwTYA5R1AkwLauLxVnxrkymXCCDZWrSE17UVbl+RmUXssord2
         FA4A==
X-Forwarded-Encrypted: i=1; AFNElJ+9shRBZSdoquaHZ6imeoYMwBkWH/oljkcvNQrU2+heXkzXiThFQRNJW0UEAbgQClFDaHZRCeW9S3J4c+/QKFP+@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4TdDCegoERyRGqeGqrfEnCf6YE9fUxMPf31gP/6W2n566hV+j
	dgUngC8y1QEsRvUCiCs8QsWKSFKyat0E5GRapkXgTAOON6OuQtGXh/iFDZP5qHaEFet8n17RsPb
	5I53bmGM1WA==
X-Received: from dybrp19.prod.google.com ([2002:a05:7301:4613:b0:304:eb73:cff1])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:641c:b0:2c5:b23e:48a6
 with SMTP id 5a478bee46e88-304fa6197dfmr2866920eec.23.1780205284259; Sat, 30
 May 2026 22:28:04 -0700 (PDT)
Date: Sat, 30 May 2026 22:27:36 -0700
In-Reply-To: <20260531052740.796087-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260513230450.529380-1-irogers@google.com> <20260531052740.796087-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260531052740.796087-11-irogers@google.com>
Subject: [PATCH v2 10/14] perf test: Skip shebang and SPDX comments in shell
 test descriptions
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, adrian.hunter@intel.com, 
	namhyung@kernel.org
Cc: alexander.shishkin@linux.intel.com, james.clark@linaro.org, 
	jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org
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
 tools/perf/tests/tests-scripts.c | 64 +++++++++++++++++---------------
 1 file changed, 35 insertions(+), 29 deletions(-)

diff --git a/tools/perf/tests/tests-scripts.c b/tools/perf/tests/tests-scripts.c
index f18c4cd337c8..48a2624da643 100644
--- a/tools/perf/tests/tests-scripts.c
+++ b/tools/perf/tests/tests-scripts.c
@@ -78,43 +78,49 @@ static int shell_tests__dir_fd(void)
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
+
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
2.54.0.823.g6e5bcc1fc9-goog

