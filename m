Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6F537BE9C
	for <linux-perf-users@vger.kernel.org>; Sat, 13 Jun 2026 07:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781334678; cv=none; b=ohWtfznKGbzvxhhPg95KMcMRdThqynQSAtG6jFos0sERQGkE499v9D6H7JIMEYvxBhWusUY/coR6/TFCnPGRM89g0zHQGLJ4yOkDR3//Q4Jxw365GaJwQY3Ss8KxqZ4lE3Hr1b8ZaNMVDuDje0T3vhLxqVwZE1dfaAe89wEWB4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781334678; c=relaxed/simple;
	bh=46UPsdVhKLSGOesq+b4o9rur5WYGR9zwjyMivGxYXrA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NgBkYEb9SJAwGaYwpjPMyTqVEbdyflHjZox0hF4VJgHzRSaj5EQ1eS7HRBAUiUxAJqu/fnLvoIYNu325NJHBQC676YDvkRPFUUcqYnxdK9WRAowvf7sELL47w2bHUqDqRW795xyRJNsQuVX6XkvEF6uebG7W+chx2Nhgkburt7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ht9A0BCA; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ht9A0BCA"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-304df51ff3eso3712756eec.0
        for <linux-perf-users@vger.kernel.org>; Sat, 13 Jun 2026 00:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781334674; x=1781939474; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vT2Mha6cP/S+RPKLMMcfihXr8wIiT308bjbyJ4T0oAQ=;
        b=ht9A0BCA12nrgPpcuhkWBCp5sK0Tf9hv414qZAUMlSQx5fQBjZsVWMxehSd5xmpkWs
         6D4JOAzTT54IZ02QX0PqIcIehYn0z+FpUzLo3vIrkCE+zUYCiV9vTR9Jacu/Hqb7T6Z8
         guecfbzJTeCtsEHh/Gl3pqW36SMVl0sILzhbip/3rC6r//pSSdnXqDuKxLPTCQPxS56j
         luuQpd9rdW0m8JUDqN4EC8vdStvAvq9/5hLYUhsf4gZVQnAqdS6dL94Xpo8iOCOz5/E9
         BQEq/AJG9ShxOKdtKTRh8llzRy65PX0VbAfUvku5sIgva8PkIyKL8xJ0ioNlCt9sobTH
         FFOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781334674; x=1781939474;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vT2Mha6cP/S+RPKLMMcfihXr8wIiT308bjbyJ4T0oAQ=;
        b=LwFWXKTqDeZbGl90zDyAXPQy2B92KUmfXZl412I9qvwJln7UuKv7VvzmYqoazEkPQF
         UowaB+t88l8RUhNbnsbJ71UZQ5ZnyObxbXJupRHulplD1NY2p1jifUgfUzDlo7+Yh0tn
         lQHGBxWwPNbsxWEw6ttqQsbAdX2A9UHEdub7hbXB9kWS+Nf3JemuMloje6im0KY7+EqZ
         ODVRzwmtNgiuyHjdX8B7A8TORxtUKStylxnReNg51xMn2sQi/ka+YjqVAtzCVfCyWYJA
         D5afEJTVL7NhgMnd74voMXW0RluQW2gOeYSCRNXeYGgvYIahyIo91mSsSIzvfM29v+rs
         vJwQ==
X-Forwarded-Encrypted: i=1; AFNElJ/a9qMiXY4A6bpZRIMlqmgKTGsAC6sosV6kONWxvmtPokfDN+DvIZjF4RXxNr2kQ2vemSgvycrNHoOAqM3+X2uu@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ+zRXJi2m4CK/NgVcOh68kJcBvaafN8fGX0j+4frV8tAsKnJB
	zApRRIqgTROX8PMHiGpKDWp7JiYLY/SSCFgUSWH/TrYYw/t/ndP/U9tYwDZ5/6RwkC3EkPJVGa+
	ODpm5Fd+iew==
X-Received: from dybmj14.prod.google.com ([2002:a05:7301:e0e:b0:304:dbcd:d155])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:f10a:b0:307:91f5:92e2
 with SMTP id 5a478bee46e88-3081ff4b659mr3454624eec.4.1781334674094; Sat, 13
 Jun 2026 00:11:14 -0700 (PDT)
Date: Sat, 13 Jun 2026 00:10:44 -0700
In-Reply-To: <20260613071100.1508192-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260613052722.1424093-1-irogers@google.com> <20260613071100.1508192-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260613071100.1508192-5-irogers@google.com>
Subject: [PATCH v17 04/20] perf data: Add open flag
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, alice.mei.rogers@gmail.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org, leo.yan@linux.dev, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Avoid double opens and ensure only open files are closed. This
addresses some issues with python integration where the data file
wants to be opened before being given to a session.

Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
---
Changes in v2:

1. Fixed File Rotation: In perf_data__switch() , I added data->open =
   false; after the file is closed. This ensures that the subsequent
   perf_data__open() call will not exit early and will successfully
   open the new file.

2. Fixed Memory Leak: In open_dir() , I added a call to
   zfree(&data->file.path) if mkdir() fails, preventing the leak of
   the path string.
---
 tools/perf/util/data.c | 27 ++++++++++++++++++++++-----
 tools/perf/util/data.h |  4 +++-
 2 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
index 94dc534a7386..33fd1b82019e 100644
--- a/tools/perf/util/data.c
+++ b/tools/perf/util/data.c
@@ -345,9 +345,10 @@ static int open_dir(struct perf_data *data)
 	if (asprintf(&data->file.path, "%s/data", data->path) < 0)
 		return -1;
 
-	if (perf_data__is_write(data) &&
-	    mkdir(data->path, S_IRWXU) < 0)
+	if (perf_data__is_write(data) && mkdir(data->path, 0700) < 0) {
+		zfree(&data->file.path);
 		return -1;
+	}
 
 	ret = open_file(data);
 
@@ -360,9 +361,16 @@ static int open_dir(struct perf_data *data)
 
 int perf_data__open(struct perf_data *data)
 {
-	if (check_pipe(data))
+	int ret;
+
+	if (data->open)
 		return 0;
 
+	if (check_pipe(data)) {
+		data->open = true;
+		return 0;
+	}
+
 	/* currently it allows stdio for pipe only */
 	data->file.use_stdio = false;
 
@@ -375,16 +383,24 @@ int perf_data__open(struct perf_data *data)
 	if (perf_data__is_read(data))
 		data->is_dir = is_dir(data);
 
-	return perf_data__is_dir(data) ?
-	       open_dir(data) : open_file_dup(data);
+	ret = perf_data__is_dir(data) ? open_dir(data) : open_file_dup(data);
+
+	if (!ret)
+		data->open = true;
+
+	return ret;
 }
 
 void perf_data__close(struct perf_data *data)
 {
+	if (!data->open)
+		return;
+
 	if (perf_data__is_dir(data))
 		perf_data__close_dir(data);
 
 	perf_data_file__close(&data->file);
+	data->open = false;
 }
 
 static ssize_t perf_data_file__read(struct perf_data_file *file, void *buf, size_t size)
@@ -457,6 +473,7 @@ int perf_data__switch(struct perf_data *data,
 
 	if (!at_exit) {
 		perf_data_file__close(&data->file);
+		data->open = false;
 		ret = perf_data__open(data);
 		if (ret < 0)
 			goto out;
diff --git a/tools/perf/util/data.h b/tools/perf/util/data.h
index 8299fb5fa7da..76f57f60361f 100644
--- a/tools/perf/util/data.h
+++ b/tools/perf/util/data.h
@@ -50,6 +50,8 @@ struct perf_data {
 	const char		*path;
 	/** @file: Underlying file to be used. */
 	struct perf_data_file	 file;
+	/** @open: Has the file or directory been opened. */
+	bool			 open;
 	/** @is_pipe: Underlying file is a pipe. */
 	bool			 is_pipe;
 	/** @is_dir: Underlying file is a directory. */
@@ -59,7 +61,7 @@ struct perf_data {
 	/** @in_place_update: A file opened for reading but will be written to. */
 	bool			 in_place_update;
 	/** @mode: Read or write mode. */
-	enum perf_data_mode	 mode;
+	enum perf_data_mode	 mode:8;
 
 	struct {
 		/** @version: perf_dir_version. */
-- 
2.54.0.1136.gdb2ca164c4-goog

