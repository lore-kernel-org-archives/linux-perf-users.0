Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BC6381AE0
	for <linux-perf-users@vger.kernel.org>; Sun, 31 May 2026 08:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780215794; cv=none; b=RmVEYmP/A+9j5ymqDKbBk7ROLTv+voYr8NxWAm0qXpTyqsETkPZSGxdamdjhTdeSNlTF5BSzzAXaWhFjWrYoiuS9AspndQPkFQj78D4r6fO0bx6zPPXWQPex72zYIwsctuzoQl71vU0iyG4VDeF48GYyz9OTFM9ydugOvOmi0tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780215794; c=relaxed/simple;
	bh=GHY8UOEZQgFkQZkPtks2Wzv0O5wAfEaNJkDa2zil9OM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UYzGwhhkr2jvdhGOXd7jSE/vhP1bKlacXsrvHm1Orejy0vmkmisLZvYDnDzqXFKFY7vw6hVcoKq/2Dto148acih18Qs4gdfSmYui4eyXGctu8ezJb3Hdohewi8xUXzrgyzHfhKqZ1xFWxMJRZP7PRnsHlxWuAoHBpnDlEVYcyYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T9ErKFvZ; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T9ErKFvZ"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-304f1820babso2544639eec.1
        for <linux-perf-users@vger.kernel.org>; Sun, 31 May 2026 01:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780215789; x=1780820589; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LgI7Gk169yArBVuMXS9CrXCl+U2LTyt0u+P/s791rwk=;
        b=T9ErKFvZVL5TFv7zC3g2LHvSgy++Bp/soaOph0VkyJp6QrGbvoxOyi9ksiF6Wq7E+Y
         eYW+SF/Xwgf6QnbN5FlIpTDWl/J8imaDwdJLiQ1c1ihj2fineYVJkn41YVecg0ARmcSW
         6cud/kEarDSwFwGydbauoG+f6HYeyNONm4xgR3/Zj1kf48GEGT0DtK7VuEVZLLDx6nPc
         1d6eTYQZTSTVS+hqNQDcR33wazNu2VYirWMugeEn6hFPW/HHvBSIbj0piiL6q29ZvpVj
         A36L8EeVZm+/6HAwoartUaFh1l8zn82dcCfyv6jYfVdDw9W+ePJilKNgrVcHSytyQ6Gc
         fmoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780215789; x=1780820589;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LgI7Gk169yArBVuMXS9CrXCl+U2LTyt0u+P/s791rwk=;
        b=Tpc40Jj4pn0xfbTAiehGU14aUboUkWJJ/Jk/36TWinwHziaoajmFCMy+lhieMwlD4O
         3oVhL0z+6xw7A/cukpcvUrIysmnYjUi6TTgAd/mTNxpKEsrkqsZq6/OtkL33g3gS5Pst
         xkeQ6P38rA4qDFuXBiTUFh4abeeMs4+erJsLBtjhbSDHd7w3Z/2x/L38wInveWvwA1rG
         0UQO8abwlWUXrvwlCMwrnXk+qO6gvrvKjMd44pH657u+qw0EY7suQam/6ldBrW+ZQzkx
         gPqIrvkaRsHRXZsUd3GYjDg5ZXAYaGxCNg20fg7uEe3iMSydAht3EGh1U0k/lxfQ2UMU
         WVkw==
X-Forwarded-Encrypted: i=1; AFNElJ9HrIPx1OFH+nvetlQKv3UnsOfa/I9cGL3woUI0t1kOs6qJ2/Xls2o3b6cVqTu6OoefTUsw+eSBNWymaW3c1YSm@vger.kernel.org
X-Gm-Message-State: AOJu0YwV/S1/ucFT5TiD5vFm+EUSZeF/9dw2bEesdE4dPL2csfomTMdH
	UDLq3r8DfYvz+3itLRbfIvx1hI0PQ0PzX07EFNPbPgMY8OJdbuCfHPPTnLVGNPxVB01I+B14fE/
	Bv7YxOdcfjw==
X-Received: from dybts9.prod.google.com ([2002:a05:7300:f589:b0:303:9bd4:479a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:3b05:b0:304:df0e:9dba
 with SMTP id 5a478bee46e88-304fa6a755cmr3052765eec.31.1780215788559; Sun, 31
 May 2026 01:23:08 -0700 (PDT)
Date: Sun, 31 May 2026 01:22:31 -0700
In-Reply-To: <20260531082235.940833-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260531063736.871777-1-irogers@google.com> <20260531082235.940833-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260531082235.940833-12-irogers@google.com>
Subject: [PATCH v4 11/15] perf test: Skip shebang and SPDX comments in shell
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

