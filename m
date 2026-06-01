Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA5F35AC3E
	for <linux-perf-users@vger.kernel.org>; Mon,  1 Jun 2026 06:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780294514; cv=none; b=pNW49mA/tE8o/8dHSWOfzzeVmBnQUks7dXUZ3cg1zYfcU401zd9HlPa4RDGot/nJyaFAUNRRXM4oI6cQ6qyiIIZZqA9ze2UJ05eGnxl9bGlM4EkpD+tCSC8zdRyvIW4VGR1Bv6fC+5KnZ+m8RCitb1iSYXE9XZAMzbMasw7nVAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780294514; c=relaxed/simple;
	bh=GHY8UOEZQgFkQZkPtks2Wzv0O5wAfEaNJkDa2zil9OM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eLQfG6mIoy2UyrqttjTTQCupJUz7jskKNGKfdgnPTLBtmZiiNjZ0KE+F0U0C5x6VvP/7+qRJAVYNhm+6rJySZNuMfUDGN7avTiKg0fl/dAUrOPIxhwNzId0OPXEmA4wctWAFBVcBU7CbaruUNa9LzDiDfSxK3b6c2t5f7I2mo94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iPdslOVr; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iPdslOVr"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-1361d52b3a0so16808641c88.0
        for <linux-perf-users@vger.kernel.org>; Sun, 31 May 2026 23:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780294511; x=1780899311; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LgI7Gk169yArBVuMXS9CrXCl+U2LTyt0u+P/s791rwk=;
        b=iPdslOVriEMFCnOdMJ/h2H0jyEZ1Kxk8wRhPwwAX/tkwenl1NnxB12AbgpvXwHVvpk
         dn4Dje0eplImPFA62un5PT6VmVOZfDG2CCClbH/aI6kEdlUYfXPA3l610EeRefp23+0g
         rwDNmYsiyxexzNgDJqHAZkdbcyADhePX50M4c8PUB66iu//YJ/lXsfQYtKMxKKngp3Hz
         uVph2fa4KgTuU59hxT13A/RwbDAzfcp+QcjX05al343Zw+2Z/pRxacpd0S3DGr2LHGAr
         Jvqm0iXankBNKmn5DQjEkHx3DBXLOTdXJVfZpK03U1PRv+dgkVPzUbulVAdsUTtXm7r2
         5jLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780294511; x=1780899311;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LgI7Gk169yArBVuMXS9CrXCl+U2LTyt0u+P/s791rwk=;
        b=L+8bXw3PADchT50UDd7NXv/heY+GJRPwfm7xPmpAL+a06z5hcQl0TmETiuq50SDtmX
         3qMb8JjnC/JVD5ZjwDMfsknwmsPWLdcntGLgorsX9MDrVV6v+C/G4cpdoeMCOJsqv7Ev
         WjYuRksGqeAp2oh6u3Tte4PFfaSnW24PkogHNa6abscPpu7QlFSnxsaFgewptKY7lFl4
         yi2JcWGecqFio45MPiq/8b4Imwe+diORTJHhoeFeFgW60p7oGNG6Q6c2xRSKJXIvuisS
         oG1PWVq+AKkFtq/BhFYu7M6o/CCFIC/4qobv+C3NaZOS/gV2MTxFZSTNtlXtKITSVsTU
         kibw==
X-Forwarded-Encrypted: i=1; AFNElJ+S6oGFZ2fN0Wi89mviZyQ8shIC+7wL/8tIAtro101Fa4J8TCOBwxCIcITFN7RUZ+kVo2cKJ61pK6/HyhyZHKSY@vger.kernel.org
X-Gm-Message-State: AOJu0YzhHfdtmQ35yZDt1IRWvv5OcQ2cGPNYt4YfDf5+paJg4+hOwyR5
	ggFGH65qvUqmIygsMTc+0yVfLahB9fyC+YXlzCI8Lhsyhl7o9OK1Xh7z8ISo30H9K9iJZKSqXTr
	kNwQ1OjPeVg==
X-Received: from dldoa11.prod.google.com ([2002:a05:701a:ca8b:b0:135:ebea:dc20])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:f99:b0:132:f16:a574
 with SMTP id a92af1059eb24-137d3d09cf1mr4177384c88.7.1780294510508; Sun, 31
 May 2026 23:15:10 -0700 (PDT)
Date: Sun, 31 May 2026 23:13:57 -0700
In-Reply-To: <20260601061401.1541457-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260601000548.1195604-1-irogers@google.com> <20260601061401.1541457-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260601061401.1541457-12-irogers@google.com>
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

