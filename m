Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8022C9D
	for <linux-perf-users@vger.kernel.org>; Mon,  1 Jun 2026 00:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780272388; cv=none; b=ISL85vvCkfOD6VdvNKIGg5U6MsjAJxEg6WHDb5JRrXD+ae1yfUH96Y1joFc+/vqrGgIAyEcUOBRRiUCT2xb1xzkw31I/nLXYRNmGFfw2zzIMHBcNTcF8mITnycdpiKQD3JRJwmLn+IfKicMa8BR3v2WqJtBiSQ1xt9Z/CSxfX+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780272388; c=relaxed/simple;
	bh=GHY8UOEZQgFkQZkPtks2Wzv0O5wAfEaNJkDa2zil9OM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=P1VT6PIlxm11kD04M75AjfpbPKa4RZkoqWTrHFUZHJehg+7pN0fLb1HbtD19Q5ee7wyHGgRkyX7s1X4Kgp8PtImTJKxJaIstv9KQxzoKSglnJLm4yUGbQZh4f4k7xqQ80IKIjkh03zccY3pYrAMharXBlXRgj2TTTfr+ykaNMCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GnG8GwvM; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GnG8GwvM"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-304efad654dso619432eec.1
        for <linux-perf-users@vger.kernel.org>; Sun, 31 May 2026 17:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780272379; x=1780877179; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LgI7Gk169yArBVuMXS9CrXCl+U2LTyt0u+P/s791rwk=;
        b=GnG8GwvMty2CsPh1/40w7lUh6A4MiGUyyYIWOfOLIkwcKyLnZMKKaNkLqX10P1To+J
         pctSGAbQc63AL4WvDA3pncgzAxZv7o8XJmmTs5PiZshBU6bXKGcm01jZr1Ilzt0wjFG6
         w4VGXT7TQY7h1yroCWSFhh+b5yPkuETyWDJ0S2VsS6Bp/X7vjaHi5E7ZNgb5AhbLAylN
         1f/SsoW1OyCdPyF1kAJadrZQoe8FwPSXyTEYPyQNBblthhJi1rHKyXO7JgH5HgdwfAMm
         MJni9S7fzxl71x2TgodHe+8zfGK0uIAQE6d3KVFwgKd2cb+W5tpLAp4O51VeLmjvLdrP
         vHng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780272379; x=1780877179;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LgI7Gk169yArBVuMXS9CrXCl+U2LTyt0u+P/s791rwk=;
        b=Rixg8g6+pz0BAjb4lD4JXvjYyRzrsX+GKTlvgngMPob1G7CLa5XwquHrWwxiszgrWr
         bzmkmdqbqyHVTBxMKiihEP0BHd0oKmpGVjYPvFdpfJ4HlTLymg+uYDot35I8kxtkRDp9
         rJVTuTvFvtYYWtP4ETklh3wKt/zbZigFedJLrbtWMO8OGY4hZCAnMzDmoUCoiQ6PyZck
         8DRcOoKB8zUifbika1Wd7f+pSRmwOyQZxp1N4CT5vSu0K+H3zfYmsT9oQthTqcEsnflP
         LtHRa5QrVLI5LSUwNQEbkPDdX5kwGtgKn+ezPSx3rTB5kgkcZsMFn6p44vNMU3FIS6bH
         WU8Q==
X-Forwarded-Encrypted: i=1; AFNElJ/CyKHwK5V1ybSiwzzRN85L0O7sc2Pwj9bD22BKxUvi2rnOv/U5YQFQNSbAewLyuxOGUbVp07WLl6nyVMh5no1f@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7tUgaM/FeGQYAMqOCkzlz4VHd3m3OkSEFJghHlEh02eB+Zj6F
	QvBCvqA2+Cwq2C9BxuRKcT6uURzDudjC0f77Cit6EysEL4JFwb7l4VJFk6Uu6ELzpkEe32AFJe4
	BpuQqFi/R7w==
X-Received: from dlea10-n2.prod.google.com ([2002:a05:701b:420a:20b0:136:6230:5814])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:4393:b0:137:e532:f53f
 with SMTP id a92af1059eb24-137e532f5f8mr155858c88.34.1780272378636; Sun, 31
 May 2026 17:06:18 -0700 (PDT)
Date: Sun, 31 May 2026 17:05:44 -0700
In-Reply-To: <20260601000548.1195604-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260531082235.940833-1-irogers@google.com> <20260601000548.1195604-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260601000548.1195604-12-irogers@google.com>
Subject: [PATCH 11/15] perf test: Skip shebang and SPDX comments in shell test descriptions
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
 tools/perf/tests/tests-scripts.c | 81 ++++++++++++++++++--------------
 1 file changed, 46 insertions(+), 35 deletions(-)

diff --git a/tools/perf/tests/tests-scripts.c b/tools/perf/tests/tests-scripts.c
index f18c4cd337c8..7466c1e8d920 100644
--- a/tools/perf/tests/tests-scripts.c
+++ b/tools/perf/tests/tests-scripts.c
@@ -31,6 +31,7 @@ static int shell_tests__dir_fd(void)
 {
 	struct stat st;
 	char path[PATH_MAX], path2[PATH_MAX], *exec_path;
+	ssize_t len;
 	static const char * const devel_dirs[] = {
 		"./tools/perf/tests/shell",
 		"./tests/shell",
@@ -47,13 +48,17 @@ static int shell_tests__dir_fd(void)
 	}
 
 	/* Use directory of executable */
-	if (readlink("/proc/self/exe", path2, sizeof path2) < 0)
+	len = readlink("/proc/self/exe", path2, sizeof(path2) - 1);
+	if (len < 0)
 		return -1;
+	path2[len] = '\0';
 	/* Follow another level of symlink if there */
 	if (lstat(path2, &st) == 0 && (st.st_mode & S_IFMT) == S_IFLNK) {
-		scnprintf(path, sizeof(path), path2);
-		if (readlink(path, path2, sizeof path2) < 0)
+		scnprintf(path, sizeof(path), "%s", path2);
+		len = readlink(path, path2, sizeof(path2) - 1);
+		if (len < 0)
 			return -1;
+		path2[len] = '\0';
 	}
 	/* Get directory */
 	p = strrchr(path2, '/');
@@ -78,43 +83,49 @@ static int shell_tests__dir_fd(void)
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
@@ -178,9 +189,9 @@ static void append_script(int dir_fd, const char *name, char *desc,
 	char *exclusive;
 
 	snprintf(link, sizeof(link), "/proc/%d/fd/%d", getpid(), dir_fd);
-	len = readlink(link, filename, sizeof(filename));
-	if (len < 0) {
-		pr_err("Failed to readlink %s", link);
+	len = readlink(link, filename, sizeof(filename) - 1);
+	if (len < 0 || (size_t)len >= sizeof(filename) - strlen(name) - 2) {
+		pr_err("Failed to readlink %s or path too long", link);
 		return;
 	}
 	filename[len++] = '/';
-- 
2.54.0.823.g6e5bcc1fc9-goog

