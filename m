Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7048F22370A
	for <linux-perf-users@vger.kernel.org>; Wed,  8 Apr 2026 06:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775630848; cv=none; b=lGOKFdE0k7NagAE8hskoyydosbVu97I15jsozE7wGvvXp7aJEQ42TeVm2K1vrXwrx3WA/Qu6Zklblim0Hql8JiOOv7CjGuPWvH6F88giC33CZu9b+HrJSIPO1GbHBW+9BtcGusagseITGKAyql3OJiSEfb9ufs3P++EmRf/ksT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775630848; c=relaxed/simple;
	bh=touw0gtNoXShn9EzIBmXtUxCytV4EQPnV8QgH5S/Onk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=JNDEnZfqrmT4rDE9GiL4CiLFBnnrihpzQ/V97bsYXWszyK5LHLbG+P7mLlxtWpnF9X2BEJCjmpYHc49h3O9H9KcY32Hd63Unaj1XWlioLebbepDgZACNr/QthSqBg5vziwGc9YPYaU1huATvpFw6gDpv50J9jbsy3eA8cms7krw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jNkCWtTD; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jNkCWtTD"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-12c20d5d7f4so1682379c88.1
        for <linux-perf-users@vger.kernel.org>; Tue, 07 Apr 2026 23:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775630844; x=1776235644; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wtpOqmI/sAuiBkwd5Ch2RaR3pi7a2FSQRKQOi5Uvwaw=;
        b=jNkCWtTD0KPRi50a8dLbgjQHPUhTp5YYB4fm+rCPXW0aVeX2MTJN9lEu6LsIlNyDDo
         0sLoOWd8Plg4OWICifwD5pHzyYBXnBfQvbOKuuF4d+K4i59w8rLFRC00pzWumKjjydQe
         ykYIqz5LGDtw/F8Nql9iBm12/YL+7fn2lO7Ych/S15ebw1N9myIQ4OvSkH03tti83BJc
         znGIvmBS1UvLa3txt1J8ZcXQylVAkkjtjLrj7+3pzgM9iu7hLvvYJv8VAeP23X1y0EnU
         iyAqxSe9qnQRbjBjmkrqAiq7qeDhTZoaoV1EP1ONkbV4ri/3gwZrEjb//q5tFldhliL+
         pxIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775630844; x=1776235644;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wtpOqmI/sAuiBkwd5Ch2RaR3pi7a2FSQRKQOi5Uvwaw=;
        b=tRQ7fALAFf+R64rpv2YQAHiczJ5GQGcPrhRZfi5Ml/FyclgwqNrwnPP4mh4sgC7IeT
         d3ep7SLFsXIY4Jfl8yfSZnXl8K+fjOjlUbpxdqtCSwUnEH2DrrgrzSz2o1Vgj+PTCTUe
         N4uziyfoKxgDXxluKGWagMCR5Ju1MKHhMxkHklQJWlWF1TeUf4Dg9gGZsfQHIg5ulf4T
         MavES9qo16PnjGUJdy8uSYKkYtm9tUMg7jAH58bBVaQ3PDZYAnGbLpNkiZlpgagatySF
         VMUQTVC3X83VMiFnk4RYkHNoSeCo+DwEUktyEP5b5NhTYfBBNVum48PZcTs8LBbc1jf5
         +DZA==
X-Forwarded-Encrypted: i=1; AJvYcCV/uA2VhtOv7s6tR18/rVHV8FGOFy4/iFtJz9rfYATHCtJYupsvvlqoQ7YsLPffImxm3o/M9a3ceU+Tf8z4d0VH@vger.kernel.org
X-Gm-Message-State: AOJu0Yze/pHiTGPiWUBJJhZGQOVwxAaYz1IltCZ5tH4GAxoz8oByTANn
	RpEbuMI7ljKLNSabY3fjz73qvRDYpf9ygjMQ8YyfHVSmB7MWyUlSm0qja6lWTv9J75iMggX4wq9
	SPg873HRbZw==
X-Received: from dlbsw3.prod.google.com ([2002:a05:7022:3a83:b0:12a:7dc7:7b04])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:321:b0:124:abaa:7ff2
 with SMTP id a92af1059eb24-12bfb7512d3mr9982948c88.24.1775630844324; Tue, 07
 Apr 2026 23:47:24 -0700 (PDT)
Date: Tue,  7 Apr 2026 23:47:21 -0700
In-Reply-To: <20260408001416.101493-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260408001416.101493-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260408064721.138338-1-irogers@google.com>
Subject: [PATCH v3] perf data: Clean up use_stdio and structures
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
v2,v3: Sashiko fixes.
---
 tools/perf/builtin-inject.c |   7 ++-
 tools/perf/builtin-record.c |  10 ++--
 tools/perf/tests/topology.c |   3 +-
 tools/perf/util/data.c      | 101 +++++++++++++++++++++++-------------
 tools/perf/util/data.h      |  52 ++++++++++++++++---
 tools/perf/util/session.c   |   2 +-
 6 files changed, 120 insertions(+), 55 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index b4add7a70b22..f174bc69cec4 100644
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
@@ -2503,12 +2502,12 @@ int cmd_inject(int argc, const char **argv)
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
index 90df41da1a32..a1914d71e333 100644
--- a/tools/perf/util/data.c
+++ b/tools/perf/util/data.c
@@ -20,18 +20,32 @@
 #include "rlimit.h"
 #include <internal/lib.h>
 
-static void close_dir(struct perf_data_file *files, int nr)
+static void perf_data_file__close(struct perf_data_file *file)
 {
-	while (--nr >= 0) {
-		close(files[nr].fd);
-		zfree(&files[nr].path);
+	if (file->use_stdio) {
+		if (file->fptr) {
+			fclose(file->fptr);
+			file->fptr = NULL;
+		}
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
@@ -132,16 +146,14 @@ int perf_data__open_dir(struct perf_data *data)
 		files = file;
 		file = &files[nr++];
 
-		file->path = strdup(path);
-		if (!file->path)
+		*file = (struct perf_data_file){
+			.path = strdup(path),
+			.fd = open(path, O_RDONLY),
+			.size = st.st_size,
+			.use_stdio = false,
+		};
+		if (!file->path || file->fd < 0)
 			goto out_err;
-
-		ret = open(file->path, O_RDONLY);
-		if (ret < 0)
-			goto out_err;
-
-		file->fd = ret;
-		file->size = st.st_size;
 	}
 
 	closedir(dir);
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
+	/* Note, a pipe fd will fail with -1 with errno of ESPIPE. */
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
index 7588cca110d2..fda4b56a056a 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -2583,7 +2583,7 @@ static int __perf_session__process_dir_events(struct perf_session *session)
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

