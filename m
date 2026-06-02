Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FAF53FF88D
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Jun 2026 17:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780422142; cv=none; b=Flm8f9GPejgfLQzFBmIcjWNy3ADzbtPzodWKYDH/ymYJ+s6NEnRaYPHx2qDnYwTFPpVKUDC9phBnVO4rqjM5zJLdcJ1iXIMIHykrs59dRFptp29TW+2j9x+3gPVehB0fO8Qnuj3uyM8bUafIHE45tYPUWCsfootcOvWoLE6R+bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780422142; c=relaxed/simple;
	bh=QeTonlOK2ZuCaDEu+aEZYh1vOWh0EbUf17Xpc7eUhvg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=c7yhCGrQk8D5r9AMJiw5RFytHMbT7ueMdM3tmYQa+ZVsm3T2GTBz5QtzAkXSEtFZHNcVDoq/CMZdUBEZ0+jAj/gP3vnBIQo3i4oW4T60C3QhnT0STdMDRfgDaurpDJTu8yT2Z/aC9A02Q/ERIUh+6n0ghFCV6+S84ziy+3L6dys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o33I+/YP; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o33I+/YP"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-304efad654dso305652eec.1
        for <linux-perf-users@vger.kernel.org>; Tue, 02 Jun 2026 10:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780422140; x=1781026940; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TRmFlruqKVdaEoFv9ClOIhUa+QV8y9XFS8NBfE9fCTQ=;
        b=o33I+/YP9OSLmv9vBBIUAB54MiGqhLVLmM7hhPtt5djQNpbzJUiL+VazA/Xb+p0/pQ
         OIxk3obCuh+6RiFFMBfqHseYrU0NM6PVh/1wdq4S+XYmWoAlggMaLEAXDbdmjGSgdbgB
         zhNi4v3R13EQz69vFkprUWPPL1TyvfW3CygORD5MpaLGKKm7eZhO7NnveMhzZ2c8TKAT
         p/9e8uyRGuz5mUpJn1/lXGTkxTu+cf7k7oHrcG5IKlO9myIMRvXm8Y8naaY4DEMWYoXK
         +bpo1aKXUjiU4Q9318aXa43gHL3RoIf4xPrHKjXLFUMMfA21EwxXx39vDsAwIGFVXtP7
         WFAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780422140; x=1781026940;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TRmFlruqKVdaEoFv9ClOIhUa+QV8y9XFS8NBfE9fCTQ=;
        b=gguCu7xny0uNPXqXOjJDNJvV1vtf+f+zQsgmfR8BgZ8RsO504TrZvPXz40zSRkAHBX
         7d4CUdwwLBlLHOGDkfpi12LwPVnI/N2n4q9rM5Su2XVKfx50+ZiEw/taWDu5p9k4MPeU
         M/D7KJCTBNfOpSHWzQ8ofX1jjHWk6mixIm2CZbIMxgR+D9tNJlxX0sU6A4Z31llb9P7I
         7oTxHT6klhOm1NLuTRBVJNqeWGefreNX+6D7ld0Mc2OCcPHOTajQoYSwybb+4Th7cC2j
         d1doLxziS86lsO5izSPeshLlt4bYBFLazV2PR4FslttCVKhfMQYC1zK2UAF78gAQ7/cd
         /obg==
X-Forwarded-Encrypted: i=1; AFNElJ9QLmZTftemwSzjaLHrJEJdllktkmh9b/xxPRNVfgaJ5sIGZnbSTn63KYH5OIY36A48AFOwJ2zffan6He2bJEwD@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt2BpByKzyqqgrHRKMen9zMG4ENri6vL+88CAkngjePfbtoWZk
	Hy72wMSft4xwG0Phz8WxrL5Z/g1Tx3/WP/GBO5rRrp1bxfuiiMZF8OlI5q2KfUnaky4xfn+cWkO
	XkIBCG1mv8Q==
X-Received: from dyaa3.prod.google.com ([2002:a05:693c:40c3:b0:2f7:9a2b:1dba])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:6145:b0:2dd:6937:79b8
 with SMTP id 5a478bee46e88-304fa523a44mr9162972eec.5.1780422139827; Tue, 02
 Jun 2026 10:42:19 -0700 (PDT)
Date: Tue,  2 Jun 2026 10:41:23 -0700
In-Reply-To: <20260602174129.3192312-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260602073132.2653307-1-irogers@google.com> <20260602174129.3192312-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1013.g208068f2d8-goog
Message-ID: <20260602174129.3192312-13-irogers@google.com>
Subject: [PATCH v8 12/18] perf test: Skip shebang and SPDX comments in shell
 test descriptions
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
index f18c4cd337c8..0370bc701373 100644
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
+	if (len < 0 || (size_t)len > sizeof(filename) - strlen(name) - 2) {
+		pr_err("Failed to readlink %s or path too long", link);
 		return;
 	}
 	filename[len++] = '/';
-- 
2.54.0.1013.g208068f2d8-goog

