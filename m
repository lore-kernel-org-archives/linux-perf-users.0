Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974C4883F
	for <linux-perf-users@vger.kernel.org>; Wed,  8 Apr 2026 00:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775607262; cv=none; b=pFs6lynHuEDsE4QiRbZh8f/gMiZ6PFExBmgMe1YFBgwh98KJwi3E/lTr8hj8mh+Xku3Cnk+MjSaqpzQNxmmNk3DXsA31qHesTksnoN68+uL1NUBz2DNmijYLwM6vSuWFgrJ3ljjz1uiENCWHrqwihoWnlD6K0jZFe951QYwlb/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775607262; c=relaxed/simple;
	bh=k9BHdb/HVsFgmdbe64pebB51SK54jg1wu48+vYDONrE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=T7jiwDFhawuedm/mNlJ8gcODGKg7iF39Qb3UTa9ZP2xuf59mxEJ7bCxLWfzwS0Swa8ubfE6Dq3NKaiF1KR10je+CaCr18jsxm8K+wotGuFL4qe1HPrE5bC9hgHJOQlgL2x3CxcBlbiuymPl/AwSKXBzTe96t33uhPbzaVm3EZ2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SsmpxV9H; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SsmpxV9H"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2bda35eab74so380868eec.0
        for <linux-perf-users@vger.kernel.org>; Tue, 07 Apr 2026 17:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775607260; x=1776212060; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aheP49N7Y5ZOjhHMibpYHQWbRpSoFY3WIUdLGOjoGNw=;
        b=SsmpxV9HcOebdMsQYC2HYPw+OcF6k5lG2TzAhPqYP0BEGFpRGbOtAn7Hj57UmceN0s
         JkzUcsMF6ItRcvc/kAgaqUE/gNDKSXFMKQCuUXNsWVfkC46XGb/WhFQHDkG8IlS78136
         ZMJZTSYLL1UR2dRMSKBmeyGN6LLCVwRrzJUh8Hkz4qW+t08uNbv5HhFQ+ttXK0FJySPF
         88dpFYqo7sSZ7guAlynRYWtwYmeCuG464ZXtnW0rcVdEumHtTOl7g5HEwIxOwnD7rwGD
         lJFMmkTkHyfmsUJkOpvrDqmWQ9rMZItZArXUSYFV4v1aqYSpd3qjvnqSixVq8dgL5h26
         /6ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775607260; x=1776212060;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aheP49N7Y5ZOjhHMibpYHQWbRpSoFY3WIUdLGOjoGNw=;
        b=H1NtldPljNPtCk4usxeoCKoFRUE6LXw7reD3WXzDG5a5neafHxShBNgHujuaTN1Jzs
         7eXlDAUYKXkZr49zfjoOuoEpvwTfKta7FYz4How4Ql+htlOus5kC7dobfzXFFNjqFHaC
         USWHOkiS3NRr3s2PdtqZpQmzxcsSxhTBYOTI0DmntknPwTsMTq2s9CPsCb5t/9ZZ0Sd9
         scDRktzwpxKr79Z/81SxxmPKZrupRmhImb8pbbFBbHHPNEo+as5UfhYUhaAPv2SlC1LF
         Hu6YhDa4yFMoZYZyJZgoDbscZ3O5WXo/1pmyVKcb9ZmXwsNjo0f+QORqfic9fhyGxyyA
         qxUw==
X-Forwarded-Encrypted: i=1; AJvYcCUJpsqvpcaM5rTcx4EJ1xogQurcRIL5H4GsAn1MhddyFBuOMLfqVnnpbDoWX/WGey9tt4xX+qM+ObyIPW8FA/2C@vger.kernel.org
X-Gm-Message-State: AOJu0YxqjtY2fkEsm7vwDw2gsglOMZkl+W/BLDvgM9aYoSIGTNFlRt0G
	jsGJU6ffmtw23uBHIqyGUQW/IpdTHlbs41gDYZQFJHrAchDx1DSdMTCQwezqbrs5VGqW2qdW3Hd
	X2+NiCu/lXg==
X-Received: from dycjx9.prod.google.com ([2002:a05:7300:fd09:b0:2c4:a6ff:49de])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:3d06:b0:2c5:6140:54d6
 with SMTP id 5a478bee46e88-2cad60cbee8mr9534506eec.1.1775607259515; Tue, 07
 Apr 2026 17:14:19 -0700 (PDT)
Date: Tue,  7 Apr 2026 17:14:16 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260408001416.101493-1-irogers@google.com>
Subject: [PATCH v2] perf data: Clean up use_stdio and structures
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Chun-Tse Shao <ctshao@google.com>, 
	Swapnil Sapkal <swapnil.sapkal@amd.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

use_stdio was associated with struct perf_data and not perf_data_file
meaning there was implicit use of fd rather than fptr that may not be
safe. For example, in perf_data_file__write. Reorganize perf_data_file
to better abstract use_stdio, add kernel-doc and more consistently use
perf_data__ accessors so that use_stdio is better respected.

Signed-off-by: Ian Rogers <irogers@google.com>
---
v2: Sashiko pointed out that fseek differs in result to lseek, fix.
---
 tools/perf/builtin-inject.c |  7 ++--
 tools/perf/builtin-record.c | 10 +++--
 tools/perf/tests/topology.c |  3 +-
 tools/perf/util/data.c      | 83 ++++++++++++++++++++++++-------------
 tools/perf/util/data.h      | 52 +++++++++++++++++++----
 tools/perf/util/session.c   |  2 +-
 6 files changed, 111 insertions(+), 46 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 5b29f4296861..14ced122c9a9 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -270,9 +270,8 @@ static s64 perf_event__repipe_auxtrace(const struct perf_tool *tool,
 	inject->have_auxtrace = true;
 
 	if (!inject->output.is_pipe) {
-		off_t offset;
+		off_t offset = perf_data__seek(&inject->output, 0, SEEK_CUR);
 
-		offset = lseek(inject->output.file.fd, 0, SEEK_CUR);
 		if (offset == -1)
 			return -errno;
 		ret = auxtrace_index__auxtrace_event(&session->auxtrace_index,
@@ -2479,12 +2478,12 @@ int cmd_inject(int argc, const char **argv)
 		.output = {
 			.path = "-",
 			.mode = PERF_DATA_MODE_WRITE,
-			.use_stdio = true,
+			.file.use_stdio = true,
 		},
 	};
 	struct perf_data data = {
 		.mode = PERF_DATA_MODE_READ,
-		.use_stdio = true,
+		.file.use_stdio = true,
 	};
 	int ret;
 	const char *known_build_ids = NULL;
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index e919d1f021c3..764afd93d8bd 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -453,7 +453,7 @@ static int record__aio_pushfn(struct mmap *map, void *to, void *buf, size_t size
 static int record__aio_push(struct record *rec, struct mmap *map, off_t *off)
 {
 	int ret, idx;
-	int trace_fd = rec->session->data->file.fd;
+	int trace_fd = perf_data__fd(rec->session->data);
 	struct record_aio aio = { .rec = rec, .size = 0 };
 
 	/*
@@ -1640,7 +1640,7 @@ static int record__mmap_read_evlist(struct record *rec, struct evlist *evlist,
 	int rc = 0;
 	int nr_mmaps;
 	struct mmap **maps;
-	int trace_fd = rec->data.file.fd;
+	int trace_fd = perf_data__fd(&rec->data);
 	off_t off = 0;
 
 	if (!evlist)
@@ -1847,8 +1847,10 @@ record__finish_output(struct record *rec)
 	rec->session->header.data_size += rec->bytes_written;
 	data->file.size = lseek(perf_data__fd(data), 0, SEEK_CUR);
 	if (record__threads_enabled(rec)) {
-		for (i = 0; i < data->dir.nr; i++)
-			data->dir.files[i].size = lseek(data->dir.files[i].fd, 0, SEEK_CUR);
+		for (i = 0; i < data->dir.nr; i++) {
+			data->dir.files[i].size =
+				perf_data_file__seek(&data->dir.files[i], 0, SEEK_CUR);
+		}
 	}
 
 	/* Buildid scanning disabled or build ID in kernel and synthesized map events. */
diff --git a/tools/perf/tests/topology.c b/tools/perf/tests/topology.c
index 75b748ddf824..f54502ebef4b 100644
--- a/tools/perf/tests/topology.c
+++ b/tools/perf/tests/topology.c
@@ -54,7 +54,8 @@ static int session_write_header(char *path)
 	session->header.data_size += DATA_SIZE;
 
 	TEST_ASSERT_VAL("failed to write header",
-			!perf_session__write_header(session, session->evlist, data.file.fd, true));
+			!perf_session__write_header(session, session->evlist,
+						    perf_data__fd(&data), true));
 
 	evlist__delete(session->evlist);
 	perf_session__delete(session);
diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
index 90df41da1a32..41993dfd6c2b 100644
--- a/tools/perf/util/data.c
+++ b/tools/perf/util/data.c
@@ -20,18 +20,30 @@
 #include "rlimit.h"
 #include <internal/lib.h>
 
-static void close_dir(struct perf_data_file *files, int nr)
+static void perf_data_file__close(struct perf_data_file *file)
 {
-	while (--nr >= 0) {
-		close(files[nr].fd);
-		zfree(&files[nr].path);
+	if (file->use_stdio) {
+		fclose(file->fptr);
+		file->fptr = NULL;
+	} else {
+		close(file->fd);
+		file->fd = -1;
 	}
+	zfree(&file->path);
+}
+
+static void close_dir(struct perf_data_file *files, int nr)
+{
+	while (--nr >= 0)
+		perf_data_file__close(&files[nr]);
+
 	free(files);
 }
 
 void perf_data__close_dir(struct perf_data *data)
 {
 	close_dir(data->dir.files, data->dir.nr);
+	data->dir.files = NULL;
 }
 
 int perf_data__create_dir(struct perf_data *data, int nr)
@@ -174,7 +186,7 @@ static bool check_pipe(struct perf_data *data)
 	}
 
 	if (is_pipe) {
-		if (data->use_stdio) {
+		if (data->file.use_stdio) {
 			const char *mode;
 
 			mode = perf_data__is_read(data) ? "r" : "w";
@@ -182,7 +194,7 @@ static bool check_pipe(struct perf_data *data)
 
 			if (data->file.fptr == NULL) {
 				data->file.fd = fd;
-				data->use_stdio = false;
+				data->file.use_stdio = false;
 			}
 
 		/*
@@ -344,7 +356,7 @@ int perf_data__open(struct perf_data *data)
 		return 0;
 
 	/* currently it allows stdio for pipe only */
-	data->use_stdio = false;
+	data->file.use_stdio = false;
 
 	if (!data->path)
 		data->path = "perf.data";
@@ -364,41 +376,57 @@ void perf_data__close(struct perf_data *data)
 	if (perf_data__is_dir(data))
 		perf_data__close_dir(data);
 
-	zfree(&data->file.path);
-
-	if (data->use_stdio)
-		fclose(data->file.fptr);
-	else
-		close(data->file.fd);
+	perf_data_file__close(&data->file);
 }
 
-ssize_t perf_data__read(struct perf_data *data, void *buf, size_t size)
+static ssize_t perf_data_file__read(struct perf_data_file *file, void *buf, size_t size)
 {
-	if (data->use_stdio) {
-		if (fread(buf, size, 1, data->file.fptr) == 1)
+	if (file->use_stdio) {
+		if (fread(buf, size, 1, file->fptr) == 1)
 			return size;
-		return feof(data->file.fptr) ? 0 : -1;
+		return feof(file->fptr) ? 0 : -1;
 	}
-	return readn(data->file.fd, buf, size);
+	return readn(file->fd, buf, size);
+}
+
+ssize_t perf_data__read(struct perf_data *data, void *buf, size_t size)
+{
+	return perf_data_file__read(&data->file, buf, size);
 }
 
 ssize_t perf_data_file__write(struct perf_data_file *file,
 			      void *buf, size_t size)
 {
+	if (file->use_stdio) {
+		if (fwrite(buf, size, /*nmemb=*/1, file->fptr) == 1)
+			return size;
+		return -1;
+	}
 	return writen(file->fd, buf, size);
 }
 
 ssize_t perf_data__write(struct perf_data *data,
 			 void *buf, size_t size)
 {
-	if (data->use_stdio) {
-		if (fwrite(buf, size, 1, data->file.fptr) == 1)
-			return size;
-		return -1;
-	}
 	return perf_data_file__write(&data->file, buf, size);
 }
 
+off_t perf_data_file__seek(struct perf_data_file *file, off_t offset, int whence)
+{
+	if (file->use_stdio) {
+		off_t res = fseek(file->fptr, offset, whence);
+
+		return res < 0 ? -1 : ftell(file->fptr);
+	}
+	return lseek(file->fd, offset, whence);
+}
+
+off_t perf_data__seek(struct perf_data *data, off_t offset, int whence)
+{
+	assert(!data->is_pipe);
+	return perf_data_file__seek(&data->file, offset, whence);
+}
+
 int perf_data__switch(struct perf_data *data,
 		      const char *postfix,
 		      size_t pos, bool at_exit,
@@ -420,19 +448,18 @@ int perf_data__switch(struct perf_data *data,
 		pr_warning("Failed to rename %s to %s\n", data->path, *new_filepath);
 
 	if (!at_exit) {
-		close(data->file.fd);
+		perf_data_file__close(&data->file);
 		ret = perf_data__open(data);
 		if (ret < 0)
 			goto out;
 
-		if (lseek(data->file.fd, pos, SEEK_SET) == (off_t)-1) {
+		if (perf_data__seek(data, pos, SEEK_SET) == (off_t)-1) {
 			ret = -errno;
-			pr_debug("Failed to lseek to %zu: %m\n",
-				 pos);
+			pr_debug("Failed to seek to %zu: %m", pos);
 			goto out;
 		}
 	}
-	ret = data->file.fd;
+	ret = perf_data__fd(data);
 out:
 	return ret;
 }
diff --git a/tools/perf/util/data.h b/tools/perf/util/data.h
index 1438e32e0451..8299fb5fa7da 100644
--- a/tools/perf/util/data.h
+++ b/tools/perf/util/data.h
@@ -17,32 +17,70 @@ enum perf_dir_version {
 	PERF_DIR_VERSION	= 1,
 };
 
+/**
+ * struct perf_data_file: A wrapper around a file used for perf.data reading or writing. Generally
+ * part of struct perf_data.
+ */
 struct perf_data_file {
+	/**
+	 * @path: Path of file. Generally a copy of perf_data.path but for a
+	 * directory it is the file within the directory.
+	 */
 	char		*path;
 	union {
+		/** @fd: File descriptor for read/writes. Valid if use_stdio is false. */
 		int	 fd;
+		/**
+		 * @fptr: Stdio FILE. Valid if use_stdio is true, currently just
+		 * pipes in perf inject.
+		 */
 		FILE	*fptr;
 	};
+	/** @size: Size of file when opened. */
 	unsigned long	 size;
+	/** @use_stdio: Use buffered stdio operations. */
+	bool		 use_stdio;
 };
 
+/**
+ * struct perf_data: A wrapper around a file used for perf.data reading or writing.
+ */
 struct perf_data {
+	/** @path: Path to open and of the file. NULL implies 'perf.data' will be used. */
 	const char		*path;
+	/** @file: Underlying file to be used. */
 	struct perf_data_file	 file;
+	/** @is_pipe: Underlying file is a pipe. */
 	bool			 is_pipe;
+	/** @is_dir: Underlying file is a directory. */
 	bool			 is_dir;
+	/** @force: Ignore opening a file creating created by a different user. */
 	bool			 force;
-	bool			 use_stdio;
+	/** @in_place_update: A file opened for reading but will be written to. */
 	bool			 in_place_update;
+	/** @mode: Read or write mode. */
 	enum perf_data_mode	 mode;
 
 	struct {
+		/** @version: perf_dir_version. */
 		u64			 version;
+		/** @files: perf data files for the directory. */
 		struct perf_data_file	*files;
+		/** @nr: Number of perf data files for the directory. */
 		int			 nr;
 	} dir;
 };
 
+static inline int perf_data_file__fd(struct perf_data_file *file)
+{
+	return file->use_stdio ? fileno(file->fptr) : file->fd;
+}
+
+ssize_t perf_data_file__write(struct perf_data_file *file,
+			      void *buf, size_t size);
+off_t perf_data_file__seek(struct perf_data_file *file, off_t offset, int whence);
+
+
 static inline bool perf_data__is_read(struct perf_data *data)
 {
 	return data->mode == PERF_DATA_MODE_READ;
@@ -70,10 +108,7 @@ static inline bool perf_data__is_single_file(struct perf_data *data)
 
 static inline int perf_data__fd(struct perf_data *data)
 {
-	if (data->use_stdio)
-		return fileno(data->file.fptr);
-
-	return data->file.fd;
+	return perf_data_file__fd(&data->file);
 }
 
 int perf_data__open(struct perf_data *data);
@@ -81,8 +116,7 @@ void perf_data__close(struct perf_data *data);
 ssize_t perf_data__read(struct perf_data *data, void *buf, size_t size);
 ssize_t perf_data__write(struct perf_data *data,
 			 void *buf, size_t size);
-ssize_t perf_data_file__write(struct perf_data_file *file,
-			      void *buf, size_t size);
+off_t perf_data__seek(struct perf_data *data, off_t offset, int whence);
 /*
  * If at_exit is set, only rename current perf.data to
  * perf.data.<postfix>, continue write on original data.
@@ -99,8 +133,10 @@ int perf_data__open_dir(struct perf_data *data);
 void perf_data__close_dir(struct perf_data *data);
 unsigned long perf_data__size(struct perf_data *data);
 int perf_data__make_kcore_dir(struct perf_data *data, char *buf, size_t buf_sz);
-bool has_kcore_dir(const char *path);
 char *perf_data__kallsyms_name(struct perf_data *data);
 char *perf_data__guest_kallsyms_name(struct perf_data *data, pid_t machine_pid);
+
+bool has_kcore_dir(const char *path);
 bool is_perf_data(const char *path);
+
 #endif /* __PERF_DATA_H */
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 3a911c70cd0e..f8f358bac5d3 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -2569,7 +2569,7 @@ static int __perf_session__process_dir_events(struct perf_session *session)
 		if (!data->dir.files[i].size)
 			continue;
 		rd[readers] = (struct reader) {
-			.fd		 = data->dir.files[i].fd,
+			.fd		 = perf_data_file__fd(&data->dir.files[i]),
 			.path		 = data->dir.files[i].path,
 			.data_size	 = data->dir.files[i].size,
 			.data_offset	 = 0,
-- 
2.53.0.1213.gd9a14994de-goog

