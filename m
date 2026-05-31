Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B674134678E
	for <linux-perf-users@vger.kernel.org>; Sun, 31 May 2026 06:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780209494; cv=none; b=OOGc5t74qIYCOShu4eWobv+xduszypOkKhTHd047Lii0xPAH8luEoF6ZgbYVvdZDoYHdhPhEVRhBnhOyoSGS3QhkYOeJ7bYTmUkIin0hUIgBRj4yCRLlydbsNRGf1Jii14N+V1JKUUHUlMoQKPetsh7lrxURueTNt4vNQ6B1GQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780209494; c=relaxed/simple;
	bh=uLld3+uwOCg40ZO/4xygF3vwIqly1oKARTE8eN08oMI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZhOwe/nkv3nwi7mMmryGIt83cXxRraWKIt1JmsuXh5WynTevAWhYFZb+BFFffPeQtVdqKCj+XgSPXbnA9zaJ9jihrqyayS8umM3Q4qIJbhV1L8rjJaNfa7X9HvsIaU1ULv2EFM/aCd154daPAv3OEwMqVtzHnlyemBL5PdqcLcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rsOfa/8g; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rsOfa/8g"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-3041ab826ddso16191958eec.0
        for <linux-perf-users@vger.kernel.org>; Sat, 30 May 2026 23:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780209489; x=1780814289; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MXre2okYx3MjQdUqAJ2nIZgNcGxZc3YS3uUa9O3ZGec=;
        b=rsOfa/8gXTTdM/GRlri1nXmp0HS/c6igQ6eg5RSGux3mtQ23LFrxk46Lpw7uQywhQ6
         RCVFYqCpFdiB6h8hdGMr4++m2d0++z+AWJmxutybAv2+a40z5aRpsvGCZuEhmpgtr3V8
         1caNAzJFmFsUMWTeHv02K0juyuFTQN0nEi0fuUcej1HnQ8SYtzEn+8jvChdPJRhoxKf3
         gKgiyZ3RYe8eu+ZSgY26GTCcIZ2PV2B/fuB0zaZhIUSXxkh3itbO59bE9Fg7Gi56u520
         Kwv0MYQiIb7YPPQM4YOiEsWmGa1V0m6vcD/vlJwLuGENwaHLYMMliKhKeEgpt+1rC4jd
         g9gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780209489; x=1780814289;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MXre2okYx3MjQdUqAJ2nIZgNcGxZc3YS3uUa9O3ZGec=;
        b=ftrwZ48Nrvb2sqVTCpPhAwOm+Kwwp+5dGNSlBHI89sqQMk/16zv+gkfwdKAY+q1sG6
         b3bzzMdFvEpagbCN4871NnTo9bxY1TEfrXoYajNkI7kdi1nZmw6tdPkYrbAkBLH64GPK
         M9iFkGrY2AsEIn4IawLLvY1yCVsTJWD72CN4CgK1fOMw/a13LaC+zXSjD2kgi+YriSvb
         mUZrhLZOp58ogpXPhS76lfWQSbA/6AleDBQurtau5n0Xr5B5tT/iIySJ39GcAiFltDra
         rIM3TwssUF7utp9+1S4tG+YHDgTZie5/9tjz+VUzveCjcgJ4s2+AY0cFLvS5+LXIaVs4
         s+Lw==
X-Forwarded-Encrypted: i=1; AFNElJ9gr2UihNH2A9CTwOr+f3pCWwoTD37yphAhj59IzWTP9ZpKlvtolkMQ8ngbpe9Qjy/oCpHrUQhnrZ7gUU+T1fuW@vger.kernel.org
X-Gm-Message-State: AOJu0Yww1VRm8pF3antlO3ORaOR5dlLZLhlq/gluPzfZ1KOtFanqj/vm
	Cbn993PrhPoAsZlQ+Dw4BzIphizZRN/8fIFUR4WezyO6CzZRXX1Wvd/C5edmnlsRBO9b2asra9c
	JZnxGt8izoA==
X-Received: from dlbrl23.prod.google.com ([2002:a05:7022:f517:b0:136:e690:f3e9])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:72c5:b0:2f2:6dde:df66
 with SMTP id 5a478bee46e88-304fa628f82mr3023492eec.22.1780209488641; Sat, 30
 May 2026 23:38:08 -0700 (PDT)
Date: Sat, 30 May 2026 23:37:32 -0700
In-Reply-To: <20260531063736.871777-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260531052740.796087-1-irogers@google.com> <20260531063736.871777-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260531063736.871777-11-irogers@google.com>
Subject: [PATCH v3 10/14] perf test: Skip shebang and SPDX comments in shell
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
 tools/perf/tests/tests-scripts.c | 66 +++++++++++++++++---------------
 1 file changed, 36 insertions(+), 30 deletions(-)

diff --git a/tools/perf/tests/tests-scripts.c b/tools/perf/tests/tests-scripts.c
index f18c4cd337c8..11ad1263ef85 100644
--- a/tools/perf/tests/tests-scripts.c
+++ b/tools/perf/tests/tests-scripts.c
@@ -51,7 +51,7 @@ static int shell_tests__dir_fd(void)
 		return -1;
 	/* Follow another level of symlink if there */
 	if (lstat(path2, &st) == 0 && (st.st_mode & S_IFMT) == S_IFLNK) {
-		scnprintf(path, sizeof(path), path2);
+		scnprintf(path, sizeof(path), "%s", path2);
 		if (readlink(path, path2, sizeof path2) < 0)
 			return -1;
 	}
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

