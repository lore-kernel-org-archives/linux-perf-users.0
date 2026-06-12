Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D7937BE72
	for <linux-perf-users@vger.kernel.org>; Fri, 12 Jun 2026 18:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781287819; cv=none; b=buZIfiqcwc3v1GE/IAdDDU6aG7mBwhiAGn5SsirqVtjI04y9Y1jul7MoncRhUggezkV6q2sx6eO33AKAO72Fw4IdhuPhmJEQOUmL1mJxVI+pK5nlE9O0rC0KklhUBZMmfHocOyMLuyTiuVYGRJNqpu7P63anhsCwnjD1PtUXFYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781287819; c=relaxed/simple;
	bh=46UPsdVhKLSGOesq+b4o9rur5WYGR9zwjyMivGxYXrA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TFD8Llue5/My5XQ1tfQ8UAORzvkD31cDKrAuXVu62MYTsbKJoJsSqYLE9TY/p9auL5CtwBPtnvIoQISdfkUCGmagFTpJo4FRwRKL5AFOB14Iwwx/C2d9ve/cEdvKPqRBWAruWmO3cFFl4uKJ3aMNzD57BaeXE4XgmDPsdpmjUqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HNt0Q533; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HNt0Q533"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-304f1820babso2024118eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 12 Jun 2026 11:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781287813; x=1781892613; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vT2Mha6cP/S+RPKLMMcfihXr8wIiT308bjbyJ4T0oAQ=;
        b=HNt0Q533GETKuhvcAJatuqoBC13o91y4MLbeCZMIvABlAYjuNWzXsF+qktksXRJxyu
         CDp4mnTvWOUIillKxHcx40RPeI5hJzSSZ1NoRhQ6AHb3fNXBMfROWiSGtHFW+o+DB3FR
         4jZN8pI49oiLoE53VXKXaX1Z6gzbFrEwGYReSG1yNSUvIcQsp0Cj35B37C3PE066WyrA
         1Jx/J33Eqqn9wYEtr4wLaX6NcT/AVhcxWxmtIj+Zsqkl8bGVvpEGwqdXjWIyxu8IeU6Q
         yEXhB0LQgR0keiBoy5G9GT9KDZ2lQTdsjZJhsWdHOr0WkOQRuAhTPfgXKpEc7brovq0T
         77/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781287813; x=1781892613;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vT2Mha6cP/S+RPKLMMcfihXr8wIiT308bjbyJ4T0oAQ=;
        b=JEFd8e3IiU8B9vJ0cuueID/KAc/bVGepFN4XWDVCNAkHK1ksLleGRU3OgTpiExQla4
         5FgxQqKIKQktJ6o+izPZECRV0QcS+NJl9nqBwJEaWFWpSnHV5aRbeO/oPyEgnvhKkpby
         ZG42h8H9it8lLWkhlsW1O/s15aKq0VtbuaMqVsZDbsXN+mJ3jGF1GCnlc/6qGQxfuT6+
         HI2x+TSQz/faBaa0YVA7YqDqbVKEbObnoahCO94cTuDBe+4iJHlIUB8Q1hJiVXs21HsY
         ynDC3UDu58Xt6GhXc2Lgvw8TgFxQaiIrbB7OxIohTzKluwh1FrAubwDrybw0vAicMySt
         yM1g==
X-Forwarded-Encrypted: i=1; AFNElJ/9W29vs6ZSFZU/CU1tPvCY3vRA1IGj4t7Z7tuCf/MZrIQxr2jJVKXRScjikLyRJmLTFag89qGn5yt3trct2ZF+@vger.kernel.org
X-Gm-Message-State: AOJu0Yz27a46J4TWPKCED5iVPCjCaocUqthFxMK73XfLuH41aDGMbPQV
	P2+0dtXkUiglTLWJ/S53wydknYlJ74wUeNzO8HtoMAnyXD8ZpHDrto8yOOiSbFcFaJ2WElCisd/
	2RqDb3TELxQ==
X-Received: from dycpz7.prod.google.com ([2002:a05:7300:fe07:b0:304:e502:fe2d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:e125:b0:2f3:986d:2d01
 with SMTP id 5a478bee46e88-3082004c3f5mr2358414eec.19.1781287812720; Fri, 12
 Jun 2026 11:10:12 -0700 (PDT)
Date: Fri, 12 Jun 2026 11:09:41 -0700
In-Reply-To: <20260612180956.1105352-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260611224455.201994-1-irogers@google.com> <20260612180956.1105352-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260612180956.1105352-5-irogers@google.com>
Subject: [PATCH v14 04/19] perf data: Add open flag
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

