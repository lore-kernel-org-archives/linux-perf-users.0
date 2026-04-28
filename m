Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF1A3D5221
	for <linux-perf-users@vger.kernel.org>; Tue, 28 Apr 2026 07:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777360777; cv=none; b=OuXsdYLskdfYl7hAZ5PyjAwESVLg8Z+kxThRgImTpcz+vzFUAKCfbQNzcRoTJILslWY6sg/AH1WDf9ZjcqTB90WKzbhn5D2D68ovHiUjjwFaX6peoH50XYJYWiiof+W6F89o0t2FPZ0r+L6U1iuT2vXL78n98tVVeoIElKPgpUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777360777; c=relaxed/simple;
	bh=gfLLI2JWYrhGkycbda+k+ahRBIJmlPsVfm7fy7d7O8E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CrulhYJ6AN1PYF4vGHXWLP/97MCwoh32Q+lT4BeZRUF1+nFmDjIOqeWxiPG8I/jYfe2mQfIXCQPC/5oBGA+g7J2EtMTlX1FowhTVIUjz03p6DHfilKKHSaVgtMSLpoPpXD/cLLSIdM+RPmGIPyHLLbVco2di1WKcIW8fF67CDH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OEqE3Byu; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OEqE3Byu"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2cc75e79b97so31247137eec.1
        for <linux-perf-users@vger.kernel.org>; Tue, 28 Apr 2026 00:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777360775; x=1777965575; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=22olXlLY2a/aW3iIRalXE3Od5F0yl9bqDC7eX7ett48=;
        b=OEqE3Byuevwl9eZKH/DGfYS1P1yt99YR8l9qBaQWGhVaIrJ+yWHJ4LL/xoWP5By2DD
         HRKKZB4VkDiy/vs5/iMcuUqHk4EG+s/W4bVjE9oGoHBTzCtJuAxjOgNRmh1AEmVK0lfG
         lBNR1wScTp5T7i3X3C7gHKkyAdNIs+NmUFYl2XC25SASZ8lHnBgYXNE0sUdXBTFx42Ok
         bYjbNRq6bxLad27/qTzAFeOoGYaBL21Np/2LcnhS5d9d9OOR3kpbek4EX7ocec1ouohu
         fg1Bk8T0GtgA46HtjWvu6uspJB1JuftPbwpVEPfmSmwH0VVgiQtf1ycLPhLTFR2WacZt
         5ang==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777360775; x=1777965575;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=22olXlLY2a/aW3iIRalXE3Od5F0yl9bqDC7eX7ett48=;
        b=TL/Jkr5V9nWebXQe7rpAZO/0I9Dh3+ECKs/9E++F48+ptxmsN8/1CvQrTpRAedG9Pz
         pq+kOt2PbKLv1O3L1+NERcsuYgYGIfTslMwlDBXvQI81y+JAikXmYVej6kddakp5r+q3
         SdVg/F8FHeeAk90lVGur7Qpn/90FxWMx7tr2MLtMkKGPURKh9w9+eu7YTEY1UyADkPgx
         R9v9nydrO8q/Ac9AzbzvALhKHY37lrUYcugx3a1OVh8LJF2tZ5n501GDggZnXXWFhtP6
         hg9f3ahwkFxjQIDV3DIhWmF0Bo8i2KQeY5akgTdGjZX43kfdz9pfIkwkSU/GhXsYPBmj
         62mQ==
X-Forwarded-Encrypted: i=1; AFNElJ/baQghRBNMbhZvzZ4xv4IEbUZhA7u//vbehrBPjoWJP3AzisFI6cdWpQppg2T7DysQUsD5349HKa4QCYmMjAXF@vger.kernel.org
X-Gm-Message-State: AOJu0YxYeLQAqnqq5H1prOmWE6za+9Qiqo4es0dXc/yRGzRGzIeA7L5C
	wAjqoxVXjpv2qZ7PxFnd6MGjj43gCLQxL6TGgNeZRt0JZLJq1N8MqF0RLcAwD4QFGhKODeAbIR2
	v/LigPt4ESQ==
X-Received: from dybor13.prod.google.com ([2002:a05:7301:1f0d:b0:2d8:4599:1d20])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:148b:b0:2e0:4edd:64e4
 with SMTP id 5a478bee46e88-2ed0a10cb66mr958174eec.26.1777360775061; Tue, 28
 Apr 2026 00:19:35 -0700 (PDT)
Date: Tue, 28 Apr 2026 00:18:13 -0700
In-Reply-To: <20260428071903.1886173-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260425224951.174663-1-irogers@google.com> <20260428071903.1886173-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260428071903.1886173-9-irogers@google.com>
Subject: [PATCH v8 08/58] perf data: Add open flag
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, alice.mei.rogers@gmail.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org, leo.yan@linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	tmricht@linux.ibm.com, Ian Rogers <irogers@google.com>
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

