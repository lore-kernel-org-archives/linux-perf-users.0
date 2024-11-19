Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965E013B58F
	for <linux-perf-users@vger.kernel.org>; Tue, 19 Nov 2024 01:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731979049; cv=none; b=A8YcSbWn0bt8GqRKC+whVWx772t42EbtsF+jmTWhS8Qtt6tA9a3H3Q5FX/5IeNs34+rSbyT7OEIvVzGPz7ElAl6z2FxuPS64Yo6X3FLGZQfX8ONcqOTd/mevN9fW1xxy4+f6NGdOkPN6yi7zBb8Cx1I+EycRWYTPS1Rb5lbqSNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731979049; c=relaxed/simple;
	bh=/CbhJo0NIgUB0KCfbS3Ow1Hrm07M2ACCA+WmmfLTdk8=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=QKTUbiioPJHQVz2vE1Ma4jcvaaV33ZePOteAisbtZg3XU5IrhXETU8tdB+gDdAD9aLZqsXSUHHw5OwJCyJh5PCOfO28u/5rDVP0wO0Eroh7Cjn9G7HSH949H4hF/ZqacAP0ThAp4Fk1gVTQ++vi1c2eJPOQQvSQSi+ZBzVZAwuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p0RqEjdJ; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p0RqEjdJ"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6ee426e3414so64360537b3.3
        for <linux-perf-users@vger.kernel.org>; Mon, 18 Nov 2024 17:17:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731979046; x=1732583846; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=isAY0YfEtXbULouihI9XfHEkMTzWUigK0hJ8gnm8q9k=;
        b=p0RqEjdJ46evA/Uh7bKlxORrcu1zvfoJQQAFC98bsbDp6w4UIiVcZEpSwhvqHTQjMp
         FYyMTd62UGCTBPY/qosGnQRtVE5EKbjSSbwYBK/falJg+qH4zWlrZRXpa/J8e0OIrMB6
         7LiE+04fssqlAwxP8z2eAUgY8os4VHEMDKCVydKrTaeB/F+W+9CFO9woMw54D5QM5qZ6
         TYy8l4kPr1lSloAhZaj2u7R8ogarZoAZ+WwEFalMEj5Grlm2Iq6Slr8G2tfDsAgbiCSK
         IFATpiU4ynoB1t3/G9/9ZhwA0f4k0IOwM2OH8Zel9MgPDEF/4yA2G1i7NI2j3gAy7bZm
         6ZTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731979046; x=1732583846;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=isAY0YfEtXbULouihI9XfHEkMTzWUigK0hJ8gnm8q9k=;
        b=ngs/adxeu8201kI8UPXBWwoUNkhP3F7iDMkAk9p65IdIxHme/yKSuWvdUU8jIzbmga
         u3ijODIYCBC2z+hl8PMsfCouzLoCposM514v5Z5q+FIQceLWD7FRQ+DBb1ooMU+Up1fG
         G+G5ckbDknAfN4UEQXmLOLKX1GjGdzuGIfT9/nV4qxtjsaaZNGoZBB26uCIpQF/w/kln
         FAJ2JsGB01Pd/1xJ/te8i+utma0Pi+q1TzZITqddOuxpI5MELY2wm1HIknVjqHn5w/r6
         oGQFb6J4UPpLzUvQfZjaKCBITTUhgKHwwrmYkx0a1mXcs0+9091ctJtqNuFxdMlf/zuK
         gffA==
X-Forwarded-Encrypted: i=1; AJvYcCUxh6ZEOpwh8kPtOb9yCRV4oMc3DkUL2lEnO43yyw8QmaOeMl5iOzl5sd/RAgKAaZWBEOEV7R6r2w8vHNfWW+Ou@vger.kernel.org
X-Gm-Message-State: AOJu0YwvvtNO8hC9Rot4mq19tHGZUnzYK1yln2z2ph9HT9oWhQDE6rHn
	i6AEKHxb8pw+gcH9GnlUlp+h6qqeCCLB5APGuSDVMUjy9ItDx+h/qLfyq0qlUDYTqHXidygGXdo
	bMTyovw==
X-Google-Smtp-Source: AGHT+IHZX+7Jb+2d4opeVjrsbxJXniCxR+KBCLpT/d/Kur/EzCUs9u2aJWg9HoZ3agM9btcjLB8/iGdTa753
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:22a4:ded5:5c37:fcc7])
 (user=irogers job=sendgmr) by 2002:a05:690c:3348:b0:6ea:8395:9af9 with SMTP
 id 00721157ae682-6ee55cb5a1cmr2057947b3.6.1731979046564; Mon, 18 Nov 2024
 17:17:26 -0800 (PST)
Date: Mon, 18 Nov 2024 17:16:28 -0800
In-Reply-To: <20241119011644.971342-1-irogers@google.com>
Message-Id: <20241119011644.971342-7-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241119011644.971342-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Subject: [PATCH v7 06/22] perf script: Use openat for directory iteration
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
Acked-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-script.c | 87 +++++++++++++++++++++++++------------
 tools/perf/util/path.c      | 10 +++++
 tools/perf/util/path.h      |  1 +
 3 files changed, 71 insertions(+), 27 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 2a7e704c0a54..ebf9ac7a97b1 100644
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
2.47.0.338.g60cca15819-goog

