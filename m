Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9636F148FEB
	for <linux-perf-users@vger.kernel.org>; Sat,  9 Nov 2024 06:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731133118; cv=none; b=QM9+MTsJoZqg2a2HU7oyGd/lFNtYS5G0HDueZpVwD0w4LnvYhBOnobcWDy+Y80XrquwfxbTErjHnpK+M2fKEhHFnteq27ZM7DYBi6UFWnLLOo6+9rvVNNPppzTn3SsPYB3vnXzK+Me8Xb51QmdC/cOKauDBHKCXI3aKS6CEb5SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731133118; c=relaxed/simple;
	bh=YYtvRxCX/8ofSsiGiywJUusvMbgIjREiaLL6Eyo+6Dc=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=VhfIQ3VgL/QAfiy/U+leJgV2qi64vXJNiiNpaQNKCJFDIdtM7KEAf8IX+n9Vsn6Cl7OOeOaChIk76zfIWqPjv/3xSF/ANDS3ZKYPQHEmTi46wMatkfBCvkmnT1w5Vk+OtGWreWQzoUCKZNsNuOY2CXXYuYDe5lLP5YVfsHmPck0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E3Pjp+lt; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E3Pjp+lt"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e2e3321aae0so4834569276.1
        for <linux-perf-users@vger.kernel.org>; Fri, 08 Nov 2024 22:18:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731133115; x=1731737915; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9GoQivGoNWmT9gaE1TJbS6tMzpRjpjMvcsKtvvg35Zs=;
        b=E3Pjp+ltrE5x84U+RUsgy0dsj1eoeko2Q0vb53JUUlAW+9JyOjUyNeCuJTmZDGEqKB
         yTBiwKEYtyUA90mULmzoq2NZumy51YsF6Nbe/SuEFnk1g1QcIMPYfDbenbfG4NsS1q3F
         IUQeS2bdrpJXbFzk16uQJh5rGjS+YDzQUCKE0nJGGYs5y4qCcTdrD1yPb+p7HC589YWL
         aN25C38fTq9pGOnAuWqFW6ElWbidCQicYp/ywZn5+eFWbIVf0QDLIHzggttdBOD58+bQ
         D/p4N7dpH76sbo+C/lDuI4w68ESg+0W8CMuyaSCZsQyRRpPvtFdpj7LQPgwfHCoQ+cYH
         Ouyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731133115; x=1731737915;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9GoQivGoNWmT9gaE1TJbS6tMzpRjpjMvcsKtvvg35Zs=;
        b=oOzPaFPDVJ/UfBDlP177wr657T4XMRUQ1VmSDQJnyDyckphnJVdJcW3YwD4M5VnRpG
         UmBuuN6okpztb5vR97uKFxwzBT/E4DrXtK/jXqg+/ei+HHV5hB/vVA0fYtAolmS36H0g
         1GS572NvdTLFVLLEjGnZr05FNH1fPYd1Ip/blodeTtxWukzHUqEpRswzpWI+e2lvouMH
         iLrKZ1kMVHqpReqOFb4N6zZjDXve2AFaHS3wCO6oJrAYzBjVeObjCwNljGRc1MtXqisn
         kXkOF2Gjjztt5Wx7BqEmmfTB8/Zfu7INIUd+7OynnJFZgWe/Uecb9FWFqUW70zXbzUG+
         autw==
X-Forwarded-Encrypted: i=1; AJvYcCW3euON1bBKGIzFXpyjh8sYorJjtyBrP3SeCrYHXXytYMP6aWDT/oSz0A3bPQa6z0L8wL4FkmkLlj1VVSQprjtC@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/J+uQSYLnobn64k2vVJkYu60H3x2C1b19AWFhJAKdUdd7eFcS
	tQ5zB6PGfA1IbaJlP1k31tmKZFF/tYcg1OuqC7sYRZ2AebaF+Ru3n7LOjbZjaB6SReKCwMKtdLv
	B6vAFuQ==
X-Google-Smtp-Source: AGHT+IHN8AifqxPtJuLxZYkfsnYSnHbvgQJ2hKIeIjxdRVDK9jcOgpIpfRgTpb20QsgGDAYn7wzspuDMBXO7
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:acc2:d48f:a998:5915])
 (user=irogers job=sendgmr) by 2002:a25:d8cb:0:b0:e30:d717:36ed with SMTP id
 3f1490d57ef6-e337f8ead19mr3757276.10.1731133115271; Fri, 08 Nov 2024 22:18:35
 -0800 (PST)
Date: Fri,  8 Nov 2024 22:17:53 -0800
In-Reply-To: <20241109061809.811922-1-irogers@google.com>
Message-Id: <20241109061809.811922-7-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241109061809.811922-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Subject: [PATCH v6 06/22] perf script: Use openat for directory iteration
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
	Weilin Wang <weilin.wang@intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Josh Poimboeuf <jpoimboe@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Rewrite the directory iteration to use openat so that large character
arrays aren't needed. The arrays are warned about potential buffer
overflows by GCC when the code exists in a single C file.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-script.c | 87 +++++++++++++++++++++++++------------
 tools/perf/util/path.c      | 10 +++++
 tools/perf/util/path.h      |  1 +
 3 files changed, 71 insertions(+), 27 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 5d5a1a06d8c6..e20d55b8a741 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -3530,27 +3530,35 @@ static void free_dlarg(void)
  * which is covered well now. And new parsing code should be added to
  * cover the future complex formats like event groups etc.
  */
-static int check_ev_match(char *dir_name, char *scriptname,
-			struct perf_session *session)
+static int check_ev_match(int dir_fd, const char *scriptname, struct perf_session *session)
 {
-	char filename[MAXPATHLEN], evname[128];
-	char line[BUFSIZ], *p;
-	struct evsel *pos;
-	int match, len;
+	char line[BUFSIZ];
 	FILE *fp;
 
-	scnprintf(filename, MAXPATHLEN, "%s/bin/%s-record", dir_name, scriptname);
+	{
+		char filename[FILENAME_MAX + 5];
+		int fd;
 
-	fp = fopen(filename, "r");
-	if (!fp)
-		return -1;
+		scnprintf(filename, sizeof(filename), "bin/%s-record", scriptname);
+		fd = openat(dir_fd, filename, O_RDONLY);
+		if (fd == -1)
+			return -1;
+		fp = fdopen(fd, "r");
+		if (!fp)
+			return -1;
+	}
 
 	while (fgets(line, sizeof(line), fp)) {
-		p = skip_spaces(line);
+		char *p = skip_spaces(line);
+
 		if (*p == '#')
 			continue;
 
 		while (strlen(p)) {
+			int match, len;
+			struct evsel *pos;
+			char evname[128];
+
 			p = strstr(p, "-e");
 			if (!p)
 				break;
@@ -3593,7 +3601,7 @@ int find_scripts(char **scripts_array, char **scripts_path_array, int num,
 		 int pathlen)
 {
 	struct dirent *script_dirent, *lang_dirent;
-	char scripts_path[MAXPATHLEN], lang_path[MAXPATHLEN];
+	int scripts_dir_fd, lang_dir_fd;
 	DIR *scripts_dir, *lang_dir;
 	struct perf_session *session;
 	struct perf_data data = {
@@ -3602,51 +3610,76 @@ int find_scripts(char **scripts_array, char **scripts_path_array, int num,
 	};
 	char *temp;
 	int i = 0;
+	const char *exec_path = get_argv_exec_path();
 
 	session = perf_session__new(&data, NULL);
 	if (IS_ERR(session))
 		return PTR_ERR(session);
 
-	snprintf(scripts_path, MAXPATHLEN, "%s/scripts", get_argv_exec_path());
+	{
+		char scripts_path[PATH_MAX];
 
-	scripts_dir = opendir(scripts_path);
+		snprintf(scripts_path, sizeof(scripts_path), "%s/scripts", exec_path);
+		scripts_dir_fd = open(scripts_path, O_DIRECTORY);
+		pr_err("Failed to open directory '%s'", scripts_path);
+		if (scripts_dir_fd == -1) {
+			perf_session__delete(session);
+			return -1;
+		}
+	}
+	scripts_dir = fdopendir(scripts_dir_fd);
 	if (!scripts_dir) {
+		close(scripts_dir_fd);
 		perf_session__delete(session);
 		return -1;
 	}
 
-	for_each_lang(scripts_path, scripts_dir, lang_dirent) {
-		scnprintf(lang_path, MAXPATHLEN, "%s/%s", scripts_path,
-			  lang_dirent->d_name);
+	while ((lang_dirent = readdir(scripts_dir)) != NULL) {
+		if (lang_dirent->d_type != DT_DIR &&
+		    (lang_dirent->d_type == DT_UNKNOWN &&
+		     !is_directory_at(scripts_dir_fd, lang_dirent->d_name)))
+			continue;
+		if (!strcmp(lang_dirent->d_name, ".") || !strcmp(lang_dirent->d_name, ".."))
+			continue;
+
 #ifndef HAVE_LIBPERL_SUPPORT
-		if (strstr(lang_path, "perl"))
+		if (strstr(lang_dirent->d_name, "perl"))
 			continue;
 #endif
 #ifndef HAVE_LIBPYTHON_SUPPORT
-		if (strstr(lang_path, "python"))
+		if (strstr(lang_dirent->d_name, "python"))
 			continue;
 #endif
 
-		lang_dir = opendir(lang_path);
-		if (!lang_dir)
+		lang_dir_fd = openat(scripts_dir_fd, lang_dirent->d_name, O_DIRECTORY);
+		if (lang_dir_fd == -1)
 			continue;
-
-		for_each_script(lang_path, lang_dir, script_dirent) {
+		lang_dir = fdopendir(lang_dir_fd);
+		if (!lang_dir) {
+			close(lang_dir_fd);
+			continue;
+		}
+		while ((script_dirent = readdir(lang_dir)) != NULL) {
+			if (script_dirent->d_type == DT_DIR)
+				continue;
+			if (script_dirent->d_type == DT_UNKNOWN &&
+			    is_directory_at(lang_dir_fd, script_dirent->d_name))
+				continue;
 			/* Skip those real time scripts: xxxtop.p[yl] */
 			if (strstr(script_dirent->d_name, "top."))
 				continue;
 			if (i >= num)
 				break;
-			snprintf(scripts_path_array[i], pathlen, "%s/%s",
-				lang_path,
+			scnprintf(scripts_path_array[i], pathlen, "%s/scripts/%s/%s",
+				exec_path,
+				lang_dirent->d_name,
 				script_dirent->d_name);
 			temp = strchr(script_dirent->d_name, '.');
 			snprintf(scripts_array[i],
 				(temp - script_dirent->d_name) + 1,
 				"%s", script_dirent->d_name);
 
-			if (check_ev_match(lang_path,
-					scripts_array[i], session))
+			if (check_ev_match(lang_dir_fd, scripts_array[i], session))
 				continue;
 
 			i++;
diff --git a/tools/perf/util/path.c b/tools/perf/util/path.c
index 00adf872bf00..9712466c51e2 100644
--- a/tools/perf/util/path.c
+++ b/tools/perf/util/path.c
@@ -68,6 +68,16 @@ bool is_directory(const char *base_path, const struct dirent *dent)
 	return S_ISDIR(st.st_mode);
 }
 
+bool is_directory_at(int dir_fd, const char *path)
+{
+	struct stat st;
+
+	if (fstatat(dir_fd, path, &st, /*flags=*/0))
+		return false;
+
+	return S_ISDIR(st.st_mode);
+}
+
 bool is_executable_file(const char *base_path, const struct dirent *dent)
 {
 	char path[PATH_MAX];
diff --git a/tools/perf/util/path.h b/tools/perf/util/path.h
index d94902c22222..fbafbe7015dd 100644
--- a/tools/perf/util/path.h
+++ b/tools/perf/util/path.h
@@ -12,6 +12,7 @@ int path__join3(char *bf, size_t size, const char *path1, const char *path2, con
 
 bool is_regular_file(const char *file);
 bool is_directory(const char *base_path, const struct dirent *dent);
+bool is_directory_at(int dir_fd, const char *path);
 bool is_executable_file(const char *base_path, const struct dirent *dent);
 
 #endif /* _PERF_PATH_H */
-- 
2.47.0.277.g8800431eea-goog

