Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E733B3BF9
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Jun 2026 07:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780385531; cv=none; b=p+QCo0rQbOu47k5+5bb0TiWhAP6HU1clYh+MrBXg/fqlki9KmJCb/gPHv/dZBpvA5RZCGE+EIYi/TFwxExj7I0DnPF2DrIhqXLQCu5vxVSY5Bas/eMP1fQJ6fMwow72jjOMG1h4M5dvpLRtGhz5P/FXKdZAby7qBmhADUDUxwsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780385531; c=relaxed/simple;
	bh=TEcBlkRXP0aLRqSO1xUVAlBdPZbo0AOnZi+UeYmfL3c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=e2jfd4VFViW8W3D8l5/lAI5h/lmsewqGWWwfoEfd9E+/wGIvT8LDBYjaaxx4j7ukSU9AS0c+Ik8FflFyKpOaxnsdIrJVouAj4w2DsT6yXVxzg7/rAOA3whOlMBJWkMIJa/6yCpbTwLXvJ9C+UAvMK4khchFWxMtosBpEGmDiVR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iaiDsoMU; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iaiDsoMU"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-137d4309062so7675768c88.0
        for <linux-perf-users@vger.kernel.org>; Tue, 02 Jun 2026 00:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780385524; x=1780990324; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vlKCGIeoP9gFnsy1L4NY9TgahXlL3xTJGu0ES0JouDQ=;
        b=iaiDsoMUnEVsis6OxBngpoLY7e2r03QcEskjwg9Hpdv2VqW2I4SeZBseU5vboCssjQ
         qFZ8huhJdzDv1IZ9mXKRP8q4GZYrOScizmnslX2+M0t6XvzlKDx4/nxBe3HU8S/zyIO+
         hFkBtfYPBYqJK7skhQvicOTb8tnQiRlbNe7l36VaUqWgvK7WoeJk+tGp0//er7W9zifq
         EWY3PINAFqfCud5n7G5HgF+aFZJzkKJvjxIyQTrhOJUhLTWPWvv3ZlkoIhdIbwmlQoDt
         CwwWXmYBzWnhAIobOYIR5H9Ghn4paJTTj4mR3xxb/h+DKjd94TRaUr6f51zW9hd5u+ju
         kR6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780385524; x=1780990324;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vlKCGIeoP9gFnsy1L4NY9TgahXlL3xTJGu0ES0JouDQ=;
        b=X1tavJkdWNzy6w+usBqR8toV7V72RKz3tAt9EXQY1+ZIgWkyb8Nu8Bh/ZNFDNkAGWO
         LFnuDyDCiwDjpcq4yD1Gcorn1IRS3l5iQr+Dqy4+FkWXsLmS3nGanPmC0ZqjFeX1z3Xt
         D09mLWCBVVrzifRhF6X/6SopxY4FIsefihY8+KNmSrXmxJYBZK9fjXwbhFaoG615Hc1q
         q7eYuNXmSHOIhNeRJac7AVsh23BLAQI6C0lf5RLoqEvXFBTkccKAiP2LbupSvBWma14h
         RM70d4CmI7EvnbiIKA4snGzhJcBOlBpcVWPRdsEheu5pewTDbYSYrzFYtY6FVCeZC5sm
         6U6Q==
X-Forwarded-Encrypted: i=1; AFNElJ/mfQeMgssIto/f0M8DJucXAYINRjqI6ZEmUY5uiZDiqmfCaWAeHhFuezcUe3waBXpCwMfMqK/jbQaGRMK9rYct@vger.kernel.org
X-Gm-Message-State: AOJu0YyPzMaCwSxDbv2BsS4lrh/GUkCofU0mXkHHSIrZeqvBwlPWBFkD
	Ki1MbrSn93ZTY9Lb754lK0kgCBNNgEKFPYnSUeJCe/24rssKf6yXTrHdoBVsVGfC6qYhBK+9CzQ
	kqYTuNSMwpg==
X-Received: from dly11-n2.prod.google.com ([2002:a05:701b:204b:20b0:137:ee1d:b1c2])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:671e:b0:12f:c7c3:f5ab
 with SMTP id a92af1059eb24-137d3f18decmr7234119c88.2.1780385524021; Tue, 02
 Jun 2026 00:32:04 -0700 (PDT)
Date: Tue,  2 Jun 2026 00:31:27 -0700
In-Reply-To: <20260602073132.2653307-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260601061401.1541457-1-irogers@google.com> <20260602073132.2653307-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.929.g9b7fa37559-goog
Message-ID: <20260602073132.2653307-13-irogers@google.com>
Subject: [PATCH v7] perf test: Skip shebang and SPDX comments in shell test descriptions
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, alexander.shishkin@linux.intel.com, 
	james.clark@linaro.org, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

When extracting shell test descriptions in tests-scripts.c, the parser
skipped the first line assuming it was the shebang (#!/bin/sh) and then
read the first comment line on line 2 as the test description.

However, checkpatch.pl expects shell scripts to declare their SPDX
license identifier on line 2 (# SPDX-License-Identifier: ...). This
caused the test harness to extract the SPDX license string as the test
description.

Refactor shell_test__description to use io__getline, skipping both
shebang and SPDX comment lines. This allows shell tests to include
standard SPDX headers without breaking test suite description
extraction.

Assisted-by: Gemini-CLI:Google Gemini 3
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/tests-scripts.c | 82 ++++++++++++++++++--------------
 1 file changed, 47 insertions(+), 35 deletions(-)

diff --git a/tools/perf/tests/tests-scripts.c b/tools/perf/tests/tests-scripts.c
index f18c4cd337c8..ec24a1d974ae 100644
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
@@ -78,43 +83,50 @@ static int shell_tests__dir_fd(void)
 static char *shell_test__description(int dir_fd, const char *name)
 {
 	struct io io;
-	char buf[128], desc[256];
-	int ch, pos = 0;
+	char buf[128], *line = NULL;
+	size_t line_len = 0;
+	ssize_t len;
+	char *desc = NULL;
+	const char *spdx = "SPDX-License";
 
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
+		if (*p == '!' || (strstr(p, spdx) && strstr(p, "-Identifier:")))
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
@@ -178,9 +190,9 @@ static void append_script(int dir_fd, const char *name, char *desc,
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
2.54.0.929.g9b7fa37559-goog

