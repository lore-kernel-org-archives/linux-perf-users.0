Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824FF391E57
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 22:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777157432; cv=none; b=F8GcyGu5CDNzVE3DQDW60inEadQAILYvgvdYhINE/AsyH9t1xBoMKtsxXc9Aa1H+lmKp4Fb+dJVN9HzsU3knszCiDRFzY7HBAT3ILm4G0Pb9za/va8JD2udC3UhLlonSovm9fd4GPaZo8KsQu8dxl+X4evFfbFiy+UKeeTKp+qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777157432; c=relaxed/simple;
	bh=gfLLI2JWYrhGkycbda+k+ahRBIJmlPsVfm7fy7d7O8E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KzFa1jF5tp5eCbnhMF50W3C13Xr4875D6gmgRwSSAlM2xU3yIhcUwsqmVPx3AO6l9qlhSHFY8zqCDLFVWZ5gpd5Y5LwEWkeIfLwkHcnQZQNL6l08qevFJhZVpwTsKl7aSYsLmlIhGR/I90WTAzS9xChZjLoOgln2t4XnueV+78g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ndSBOmTo; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ndSBOmTo"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2e60238adb1so21620329eec.0
        for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 15:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777157431; x=1777762231; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=22olXlLY2a/aW3iIRalXE3Od5F0yl9bqDC7eX7ett48=;
        b=ndSBOmTo4OIZiqqqmgnw5O0jTEjAxVZzuTABmO00wKA6F9EJbM9dqDoviXIiZ2Mwrh
         Tuz9sN3w/rX+i94Iv5jL2zP9weiybLy5LlsZPdJ7Io56wma3sowHYxaoBLoDmTBG8GKf
         G8SQffwQPcJIaqA240FtrlRaxakqZWLftlkUHuMJKXPyQJs7fy/YsxcgJmJJ1fDnQG79
         FHrTZxZt+4rXBa2jR9T0ZHo7GGfmhk0APUYrmiLmuhPFAXiuUkD6OJEPMCZTm8OvD4BG
         B7dyLemdQvwhDFMJzQXi04f55xMe/i4eGfJ/6yRs1Y9jh2pDV/7cjcV6GqdpD+6I0jgn
         Pjng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777157431; x=1777762231;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=22olXlLY2a/aW3iIRalXE3Od5F0yl9bqDC7eX7ett48=;
        b=RMlBLyfrRbniXyBAWXh1dVz8ZBenNP75RwQab5o75Do4jbV37rWfrE0BeUDF4pSX2y
         V5LUMDC45SyQmQHeZqUNTqVi/4mXVGuaOB/ihM47NG3w/TAippzPggu/sBwmF5ijaWlL
         OIRRrzneRVciH1ILRfH/103Dvohg0PNcVfXkyyj/rMFuXOUJwrBtdusPC6zOtSFHmVH1
         hoKjrX5UNa9zUSSLCAG+A+H1UYapYKx2D2wJccb7RtzhcSlIDzs/xiDVCjiJB2BZRTqj
         i3xIl0kMr1dPri6l6CZueAmigIze+fpcI/0mnzk3u1awvmMB+OarX3unSE9lCdIhWdNm
         1Y1w==
X-Forwarded-Encrypted: i=1; AFNElJ/dkEsnvmRaJ7Gp6U+3CpO6lFOGVAO9nW4VMWs366APYTqjeD1kAVElA5FalI7/qf4wXa65uuNB77wEJ7I4+PYh@vger.kernel.org
X-Gm-Message-State: AOJu0YxuNWoMrtHYN5Nzz46GD3IhPzp8d+7XjVtn3OV4EKZ4XXRHdphN
	T2G727VlH9tUMCzCv3MUcMXpEr8jAsNxpmLpQOuI10VwPHA8+yVx+CUDD/2rNPjxEGnHRl8nHcF
	lBcFL3rAiAQ==
X-Received: from dyjf14.prod.google.com ([2002:a05:7300:680e:b0:2d9:9fa3:5aa6])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:cc14:b0:2c6:1557:9997
 with SMTP id 5a478bee46e88-2e478839eb6mr19777325eec.14.1777157430513; Sat, 25
 Apr 2026 15:50:30 -0700 (PDT)
Date: Sat, 25 Apr 2026 15:49:01 -0700
In-Reply-To: <20260425224951.174663-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260425174858.3922152-1-irogers@google.com> <20260425224951.174663-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260425224951.174663-10-irogers@google.com>
Subject: [PATCH v7 09/59] perf data: Add open flag
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, adrian.hunter@intel.com, james.clark@linaro.org, 
	leo.yan@linux.dev, namhyung@kernel.org, tmricht@linux.ibm.com
Cc: alice.mei.rogers@gmail.com, dapeng1.mi@linux.intel.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Avoid double opens and ensure only open files are closed. This
addresses some issues with python integration where the data file
wants to be opened before being given to a session.

Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
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
 tools/perf/util/data.c | 26 ++++++++++++++++++++++----
 tools/perf/util/data.h |  4 +++-
 2 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
index 94dc534a7386..17baf71897d1 100644
--- a/tools/perf/util/data.c
+++ b/tools/perf/util/data.c
@@ -346,8 +346,10 @@ static int open_dir(struct perf_data *data)
 		return -1;
 
 	if (perf_data__is_write(data) &&
-	    mkdir(data->path, S_IRWXU) < 0)
+	    mkdir(data->path, S_IRWXU) < 0) {
+		zfree(&data->file.path);
 		return -1;
+	}
 
 	ret = open_file(data);
 
@@ -360,9 +362,16 @@ static int open_dir(struct perf_data *data)
 
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
 
@@ -375,16 +384,24 @@ int perf_data__open(struct perf_data *data)
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
@@ -457,6 +474,7 @@ int perf_data__switch(struct perf_data *data,
 
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
2.54.0.545.g6539524ca2-goog

