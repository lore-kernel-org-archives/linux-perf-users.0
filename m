Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6861B3469E7
	for <linux-perf-users@vger.kernel.org>; Wed,  8 Apr 2026 20:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775680745; cv=none; b=BNaGtRKbi/+Q5d4O8IpOQdBQQ/2sTNPKHNs2o0hrKjh1CxtoawLEssPGeVqnnVtoso37wO0U/qsUjCGQ+25MqYdPY2KzCLc4YcGk9FFlY3ml+m+9Y1LGDB2P0WIcue3eAs24T87ruuU7Eo8dSyK1hcFs4byNUnnetUPqhmuK+G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775680745; c=relaxed/simple;
	bh=9U9IMn8GI7vKwomCGri25crX5/IXo7U/upxpZKAo7YU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=e4Xtz63N8zlHc6nXrnTjFqjEL00ZPB9B/DtBj6PZUY7JB0CE+IvIvwcimsFfh5im1HZLDMHar4n8a0fnW8Qb1sgynmtjmo1XVRjW5790YzA/7nmR1ROuwdhcnWT+ad3J5BIAYezqrXec77UZXJAwn/AyjqvzoHNRCguW2Djl1BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s+BiPtqr; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s+BiPtqr"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-12c283a1212so227078c88.1
        for <linux-perf-users@vger.kernel.org>; Wed, 08 Apr 2026 13:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775680742; x=1776285542; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+iisR2tOQXP//wk281815W9gc4x0S3JhWEbbNPll4kY=;
        b=s+BiPtqrC5DIGwJkwGJGnwu/5f/8LvkS+4uuhKJDWj+jn5kJmGih6duCgmSdFE1zGK
         1mBk3Tb0/we0DeG0y9oJQnQhX8/R/XHKkRqFyyGV7FGBNARE5eT0t1Fwn8XSK6xXViEY
         pc7ElNrIwwYOmQKHSq0ytg2DKwMDzjtSp5Y47IWuPKWNuqGSi/qRdzU33r/wNxWGLuJt
         eKlEJxniwbKyPWoriGziKImOLgD3UziiiLsnO6FcLSY4FKY0Qs6rDVWSQP85TmkZ0j3T
         veCj9hso88Y8DTPaTaw+USGiRu/mydDsx6/N+Gd+U5rxbSwRDdTXt9SlVR52sN7uT+P8
         RWrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775680742; x=1776285542;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+iisR2tOQXP//wk281815W9gc4x0S3JhWEbbNPll4kY=;
        b=cprUdzmhGybYwdVhIKCT05gvQncAw94tDvpJ7lfkwu7tBx3fy0GPnOKigQ5tSrsHWr
         aUCCVQpXUyiRrnEj99J2dmFtItqpo7vSqtt+ZIOBuZV7HqfNRMQ++2F0vWb4W96K0OmQ
         gk2itgKaFVO1bZjuCUg4S+gpQJbmO1Utb98rfri/ffUXPg+Xmafks8AxBTXWrH8nk8ou
         g49YJCcEKA0tFg90cvr2E6BNM5rEtf7bcgcQoSKrBFAlqsWnIX90pZwUrvzMKX7GLY9X
         7lNr0DhBuYADMp8WxKE2jyaU2j7u9bwfh1pHHJ+Xm7GbxjubZ8nQ7dMsQVeViRl9YGuw
         7BoQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbyE15OtNpomkmf11ReOQvd7bIqXln3Xs4O2Fl09U6/2GWUhB6NvYLaG8ZMvfzi3uWgNXp4c19N1q5Orqz8eOF@vger.kernel.org
X-Gm-Message-State: AOJu0YwD0QwOSH5500Bu4GneYrD2cc5qT+9x11/blJe15jAiXVML6sOe
	9zwriw5CX6kaxY+b/XIcqttGywdPg3RiraBbenthw6FoOz7OPT7bgV8vw0xhqFs3XC/+ElDonJG
	UoEnW2IU1RQ==
X-Received: from dyckx2.prod.google.com ([2002:a05:7300:c7c2:b0:2d3:51a9:d76c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7023:b0a:b0:12a:949b:b9b
 with SMTP id a92af1059eb24-12c28c033c1mr592151c88.23.1775680742305; Wed, 08
 Apr 2026 13:39:02 -0700 (PDT)
Date: Wed,  8 Apr 2026 13:38:58 -0700
In-Reply-To: <20260408001416.101493-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260408001416.101493-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260408203858.100855-1-irogers@google.com>
Subject: [PATCH v5] perf data: Clean up use_stdio and structures
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
v2,v3,v4,v5: Sashiko fixes.
---
 tools/perf/builtin-inject.c |  7 ++-
 tools/perf/builtin-record.c | 12 +++--
 tools/perf/tests/topology.c |  3 +-
 tools/perf/util/data.c      | 99 +++++++++++++++++++++++++------------
 tools/perf/util/data.h      | 52 ++++++++++++++++---
 tools/perf/util/session.c   |  2 +-
 6 files changed, 124 insertions(+), 51 deletions(-)

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
index e919d1f021c3..a9cca6fe5a6b 100644
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
@@ -1845,10 +1845,12 @@ record__finish_output(struct record *rec)
 	}
 
 	rec->session->header.data_size += rec->bytes_written;
-	data->file.size = lseek(perf_data__fd(data), 0, SEEK_CUR);
+	data->file.size = perf_data__seek(data, 0, SEEK_CUR);
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
index 90df41da1a32..f8f9a52ccabb 100644
--- a/tools/perf/util/data.c
+++ b/tools/perf/util/data.c
@@ -20,18 +20,33 @@
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
+	data->dir.nr = 0;
 }
 
 int perf_data__create_dir(struct perf_data *data, int nr)
@@ -132,16 +147,21 @@ int perf_data__open_dir(struct perf_data *data)
 		files = file;
 		file = &files[nr++];
 
-		file->path = strdup(path);
+		*file = (struct perf_data_file){
+			.path = strdup(path),
+			.fd = -1,
+			.size = st.st_size,
+			.use_stdio = false,
+		};
 		if (!file->path)
 			goto out_err;
 
 		ret = open(file->path, O_RDONLY);
-		if (ret < 0)
+		if (ret < 0) {
+			ret = -errno;
 			goto out_err;
-
+		}
 		file->fd = ret;
-		file->size = st.st_size;
 	}
 
 	closedir(dir);
@@ -174,7 +194,7 @@ static bool check_pipe(struct perf_data *data)
 	}
 
 	if (is_pipe) {
-		if (data->use_stdio) {
+		if (data->file.use_stdio) {
 			const char *mode;
 
 			mode = perf_data__is_read(data) ? "r" : "w";
@@ -182,7 +202,7 @@ static bool check_pipe(struct perf_data *data)
 
 			if (data->file.fptr == NULL) {
 				data->file.fd = fd;
-				data->use_stdio = false;
+				data->file.use_stdio = false;
 			}
 
 		/*
@@ -344,7 +364,7 @@ int perf_data__open(struct perf_data *data)
 		return 0;
 
 	/* currently it allows stdio for pipe only */
-	data->use_stdio = false;
+	data->file.use_stdio = false;
 
 	if (!data->path)
 		data->path = "perf.data";
@@ -364,41 +384,57 @@ void perf_data__close(struct perf_data *data)
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
+		off_t res = fseeko(file->fptr, offset, whence);
+
+		return res < 0 ? -1 : ftello(file->fptr);
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
@@ -420,19 +456,18 @@ int perf_data__switch(struct perf_data *data,
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

