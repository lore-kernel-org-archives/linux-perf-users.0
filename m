Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C69D3126DF
	for <linux-perf-users@vger.kernel.org>; Wed, 15 Jul 2026 13:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784123604; cv=none; b=nsPFTcnLKAhaOF17EL3Tf1VKW08is406B2sMOrdvP7g2p4fzRPghVp1DNT6N2iVRGgd50yjELh7q6auSyO81a+e0fmS6r5uENAhnAcF3qpcRRTNG5WPTyzJLI12uoee4b6lMbEeCvrUAtgUG3/ZOuY+JU/aeas7LoZu1UVqI5uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784123604; c=relaxed/simple;
	bh=O3ivOgmDRBqcXIeMODoLr5igdL7mEEZYikJ+jhp/gfU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=keHExF1KUVYCZzBmLrMAjVea0QWvTYzM+1suVHXTuG3wHCM4y9F4L30CDzz7FdQXfOed2oCjqgZ0/QGEcGAchjq6sFdcvO5YLCHU8a+9xSLr6mA5XK9p8vrTHl/axsU3NLZViUDRX5xT5o58tiKVpjLFDZhJgms7koWSRvjwE4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iqu0dGzM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iqu0dGzM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784123600;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rBXa+CtLSxnyksrkUXGGy3/jtRSwHraEoQaUzzqjDvk=;
	b=iqu0dGzMZQiEHj5JvCZTVl45YQSFN4e4Ohz0wvo2JfqwebCyeVJYXlm4CwEkBnaEtxeEbY
	DFC1WzFnRPg23rIC+dUxScluT/YprV0RxcfYukjdqfzOlhKMlGEBUMR3dUgomCgsAjbfI+
	j40wq8mXkRSonkkv2jN7I/iDLp6aykQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-73-2-WIypeINMSHPUU3M9hhWg-1; Wed,
 15 Jul 2026 09:53:16 -0400
X-MC-Unique: 2-WIypeINMSHPUU3M9hhWg-1
X-Mimecast-MFC-AGG-ID: 2-WIypeINMSHPUU3M9hhWg_1784123594
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 00B3018001F2;
	Wed, 15 Jul 2026 13:53:14 +0000 (UTC)
Received: from ashelat-thinkpadp1gen5.boston.csb (unknown [10.22.80.235])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C884D1956089;
	Wed, 15 Jul 2026 13:53:10 +0000 (UTC)
From: Anubhav Shelat <ashelat@redhat.com>
To: rostedt@goodmis.org,
	acme@kernel.org,
	peterz@infradead.org,
	Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Anubhav Shelat <ashelat@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: linux-trace-kernel@vger.kernel.org
Subject: [PATCH v5 3/5] perf tools: fall back to eventfs for unprivileged event discovery
Date: Wed, 15 Jul 2026 09:52:24 -0400
Message-ID: <20260715135231.338535-5-ashelat@redhat.com>
In-Reply-To: <20260715135231.338535-2-ashelat@redhat.com>
References: <20260715135231.338535-2-ashelat@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

When tracefs events are not readable by unprivileged users, fall back
to /sys/kernel/events (the read-only eventfs mount) for tracepoint
format and id file discovery. This allows perf trace to work for
unprivileged users on kernels that expose the eventfs filesystem.

The fallback is transparent: get_events_file() tries the tracefs path
first and only switches to eventfs when access() fails. On kernels
without eventfs, the existing error path is preserved.

Assisted-by: CLAUDE:claude-opus-4 Apogee
Signed-off-by: Anubhav Shelat <ashelat@redhat.com>
---
 tools/lib/api/fs/fs.c              | 10 ++++++
 tools/lib/api/fs/fs.h              |  1 +
 tools/lib/api/fs/tracing_path.c    | 52 ++++++++++++++++++++++++++----
 tools/lib/api/fs/tracing_path.h    |  1 +
 tools/perf/util/tp_pmu.c           |  5 +--
 tools/perf/util/trace-event-info.c | 19 ++++++-----
 6 files changed, 71 insertions(+), 17 deletions(-)

diff --git a/tools/lib/api/fs/fs.c b/tools/lib/api/fs/fs.c
index cbd8eab0d1df..abc3581a9703 100644
--- a/tools/lib/api/fs/fs.c
+++ b/tools/lib/api/fs/fs.c
@@ -46,6 +46,10 @@
 #define BPF_FS_MAGIC           0xcafe4a11
 #endif
 
+#ifndef EVENTFS_SUPER_MAGIC
+#define EVENTFS_SUPER_MAGIC    0x65766673
+#endif
+
 static const char * const sysfs__known_mountpoints[] = {
 	"/sys",
 	0,
@@ -88,6 +92,11 @@ static const char * const bpf_fs__known_mountpoints[] = {
 	0,
 };
 
+static const char * const eventfs__known_mountpoints[] = {
+	"/sys/kernel/events",
+	0,
+};
+
 struct fs {
 	const char *		 const name;
 	const char * const *	 const mounts;
@@ -150,6 +159,7 @@ FS(debugfs, debugfs, DEBUGFS);
 FS(tracefs, tracefs, TRACEFS);
 FS(hugetlbfs, hugetlbfs, HUGETLBFS);
 FS(bpf_fs, bpf, BPF_FS);
+FS(eventfs, eventfs, EVENTFS_SUPER);
 
 static bool fs__read_mounts(struct fs *fs)
 {
diff --git a/tools/lib/api/fs/fs.h b/tools/lib/api/fs/fs.h
index aa222ca30311..57790c93f80e 100644
--- a/tools/lib/api/fs/fs.h
+++ b/tools/lib/api/fs/fs.h
@@ -36,6 +36,7 @@ FS(debugfs)
 FS(tracefs)
 FS(hugetlbfs)
 FS(bpf_fs)
+FS(eventfs)
 
 #undef FS
 
diff --git a/tools/lib/api/fs/tracing_path.c b/tools/lib/api/fs/tracing_path.c
index 834fd64c7130..de4ed7c61415 100644
--- a/tools/lib/api/fs/tracing_path.c
+++ b/tools/lib/api/fs/tracing_path.c
@@ -3,6 +3,8 @@
 # define _GNU_SOURCE
 #endif
 
+#include <dirent.h>
+#include <fcntl.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
@@ -80,13 +82,46 @@ void put_tracing_file(char *file)
 	free(file);
 }
 
+char *get_events_dir(void)
+{
+	const char *eventfs;
+	char *path;
+	int saved_errno;
+
+	path = get_tracing_file("events");
+	if (path && faccessat(AT_FDCWD, path, R_OK, AT_EACCESS) == 0)
+		return path;
+
+	saved_errno = errno;
+	put_tracing_file(path);
+
+	eventfs = eventfs__mount();
+	if (eventfs && faccessat(AT_FDCWD, eventfs, R_OK, AT_EACCESS) == 0 &&
+	    eventfs__configured())
+		return strdup(eventfs);
+
+	/*
+	 * Prefer EACCES over other errors: it tells the user that events
+	 * exist but are not accessible, which is more actionable than
+	 * ENOENT from a missing filesystem.
+	 */
+	if (errno != EACCES)
+		errno = saved_errno;
+	return NULL;
+}
+
 char *get_events_file(const char *name)
 {
-	char *file;
+	char *dir, *file;
 
-	if (asprintf(&file, "%s/events/%s", tracing_path_mount(), name) < 0)
+	dir = get_events_dir();
+	if (!dir)
 		return NULL;
 
+	if (asprintf(&file, "%s/%s", dir, name) < 0)
+		file = NULL;
+
+	free(dir);
 	return file;
 }
 
@@ -97,8 +132,8 @@ void put_events_file(char *file)
 
 DIR *tracing_events__opendir(void)
 {
+	char *path = get_events_dir();
 	DIR *dir = NULL;
-	char *path = get_tracing_file("events");
 
 	if (path) {
 		dir = opendir(path);
@@ -110,7 +145,7 @@ DIR *tracing_events__opendir(void)
 
 int tracing_events__scandir_alphasort(struct dirent ***namelist)
 {
-	char *path = get_tracing_file("events");
+	char *path = get_events_dir();
 	int ret;
 
 	if (!path) {
@@ -121,6 +156,9 @@ int tracing_events__scandir_alphasort(struct dirent ***namelist)
 	ret = scandir(path, namelist, NULL, alphasort);
 	put_events_file(path);
 
+	if (ret < 0)
+		*namelist = NULL;
+
 	return ret;
 }
 
@@ -162,12 +200,12 @@ int tracing_path__strerror_open_tp(int err, char *buf, size_t size,
 			 "Hint:\tIs the debugfs/tracefs filesystem mounted?\n"
 			 "Hint:\tTry 'sudo mount -t debugfs nodev /sys/kernel/debug'");
 		break;
-	case EACCES: {
+	case EACCES:
 		snprintf(buf, size,
 			 "Error:\tNo permissions to read %s/events/%s\n"
-			 "Hint:\tTry 'sudo mount -o remount,mode=755 %s'\n",
+			 "Hint:\tTry 'sudo mount -o remount,mode=755 %s'\n"
+			 "Hint:\tOr check if /sys/kernel/events is available\n",
 			 tracing_path, filename, tracing_path_mount());
-	}
 		break;
 	default:
 		snprintf(buf, size, "%s", str_error_r(err, sbuf, sizeof(sbuf)));
diff --git a/tools/lib/api/fs/tracing_path.h b/tools/lib/api/fs/tracing_path.h
index fc6347c11deb..a93befb38f80 100644
--- a/tools/lib/api/fs/tracing_path.h
+++ b/tools/lib/api/fs/tracing_path.h
@@ -14,6 +14,7 @@ const char *tracing_path_mount(void);
 char *get_tracing_file(const char *name);
 void put_tracing_file(char *file);
 
+char *get_events_dir(void);
 char *get_events_file(const char *name);
 void put_events_file(char *file);
 
diff --git a/tools/perf/util/tp_pmu.c b/tools/perf/util/tp_pmu.c
index c2be8c9f9084..4f45bd816945 100644
--- a/tools/perf/util/tp_pmu.c
+++ b/tools/perf/util/tp_pmu.c
@@ -6,6 +6,7 @@
 #include <api/io_dir.h>
 #include <linux/kernel.h>
 #include <errno.h>
+#include <stdlib.h>
 #include <string.h>
 
 int tp_pmu__id(const char *sys, const char *name)
@@ -15,7 +16,7 @@ int tp_pmu__id(const char *sys, const char *name)
 	int id, err;
 
 	if (!tp_dir)
-		return -1;
+		return -errno;
 
 	scnprintf(path, PATH_MAX, "%s/%s/id", tp_dir, name);
 	put_events_file(tp_dir);
@@ -66,7 +67,7 @@ int tp_pmu__for_each_tp_sys(void *state, tp_sys_callback cb)
 	struct io_dirent64 *events_ent;
 	struct io_dir events_dir;
 	int ret = 0;
-	char *events_dir_path = get_tracing_file("events");
+	char *events_dir_path = get_events_dir();
 
 	if (!events_dir_path)
 		return -errno;
diff --git a/tools/perf/util/trace-event-info.c b/tools/perf/util/trace-event-info.c
index 45774722f249..643451d2c08d 100644
--- a/tools/perf/util/trace-event-info.c
+++ b/tools/perf/util/trace-event-info.c
@@ -92,8 +92,9 @@ static int record_header_files(void)
 	int err = -EIO;
 
 	if (!path) {
+		err = -errno;
 		pr_debug("can't get tracing/events/header_page");
-		return -ENOMEM;
+		return err;
 	}
 
 	if (stat(path, &st) < 0) {
@@ -115,8 +116,8 @@ static int record_header_files(void)
 
 	path = get_events_file("header_event");
 	if (!path) {
+		err = -errno;
 		pr_debug("can't get tracing/events/header_event");
-		err = -ENOMEM;
 		goto out;
 	}
 
@@ -228,13 +229,14 @@ static int record_ftrace_files(struct tracepoint_path *tps)
 
 	path = get_events_file("ftrace");
 	if (!path) {
+		ret = -errno;
 		pr_debug("can't get tracing/events/ftrace");
-		return -ENOMEM;
+		return ret;
 	}
 
 	ret = copy_event_system(path, tps);
 
-	put_tracing_file(path);
+	put_events_file(path);
 
 	return ret;
 }
@@ -256,15 +258,16 @@ static int record_event_files(struct tracepoint_path *tps)
 	struct stat st;
 	char *path;
 	char *sys;
-	DIR *dir;
+	DIR *dir = NULL;
 	int count = 0;
 	int ret;
 	int err;
 
-	path = get_tracing_file("events");
+	path = get_events_dir();
 	if (!path) {
+		err = -errno;
 		pr_debug("can't get tracing/events");
-		return -ENOMEM;
+		goto out;
 	}
 
 	dir = opendir(path);
@@ -315,7 +318,7 @@ static int record_event_files(struct tracepoint_path *tps)
 out:
 	if (dir)
 		closedir(dir);
-	put_tracing_file(path);
+	put_events_file(path);
 
 	return err;
 }
-- 
2.54.0

