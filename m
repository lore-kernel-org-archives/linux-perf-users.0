Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481A1390985
	for <linux-perf-users@vger.kernel.org>; Fri, 22 May 2026 22:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779487504; cv=none; b=VSXplAwk+zBMCflIRdilcSIpOsETf2vdto7rVldAL8y5nTCJc9L1BZ+/Kn/tNKk6bMZYxu2GdzxMsXK7ocLy2HyvbgCQBOJ5W2yjsP2j1XSYsYH2JFhVuT9tBMg5gpTPDbkAB97G9eeZSg25LeNTJq4/g4mRAvulF3W3ze48qD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779487504; c=relaxed/simple;
	bh=uxCV9jppCE/H5q6yZLcRLCBj0mDjwse7q72zeU61xms=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ne9xy9PxrNzLy2pNNLvL43uZIs8cNMKTN6PUwMPdRyoRcjZu2KnWR4Sy8NfpWwimPzqsUsSxVdoG/OEn09hq86Gd43zQvo2FJT6mlwgYooLfBfJ4IiM0yGDTh4uqV0dLFtoQlWD2yiEaqA0MgdDxfNBQG1rujRiSNOEFwO+Dnb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nkP8vO8D; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nkP8vO8D"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-837cc5bc6deso4879892b3a.3
        for <linux-perf-users@vger.kernel.org>; Fri, 22 May 2026 15:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779487497; x=1780092297; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oc0Kr6q/YLQ3soV5ofZAEXnCcqwAjSYBE+48VtKkBGU=;
        b=nkP8vO8DS6r1cO8IL0pokdVNIgyERG/CNW3OHsZEoHQvP1zDFRtNDVOi2ZZZit+wFw
         zfY2lnNevnprv+LmT6yWGRKrCixNwj7v+xWLn/HyzU35oJ7t5vmhIOtWuN+ycgnJy0Dm
         bskAo80u09zwWc4I3lv37y8zXjWCJuwx/sqdbmYiYwvNYT8k942nWwmPXchODu+geMNH
         pu/oKc6C5BvTv7C64eTEzwArGZt2/BvcGmFQmWX8ddIdd+YbcKQWGNFCac6g8cTVrlRA
         n8gdpzgg/Tz014oXSbg58LlBk0B4otc1KfldE7OliR7x4D0jopbkHH5xsM62SZuqft1/
         9HlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779487497; x=1780092297;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oc0Kr6q/YLQ3soV5ofZAEXnCcqwAjSYBE+48VtKkBGU=;
        b=gvXpMERH9AErmhL/8RuKmorzaKMklSzRHitb9UJj84trlYRjVnoYEc6BQJjOhEbVQj
         btscqi4ARGIvt0YIsNgrM5S5139s8yi3EqgNLnGuViFmhmeeXqes+NtwLatq+V3raH1+
         2UjoBfJ1gM+Th1Ylde0HVtGjsg8eWZWWTYKWi+tDb+CgiuAF4P8IIENKtlluh4lYjdH0
         XaO0NLcQyVG+rYaFDGJAhr5MBGDTFCl18z9wG6n7po94fzBLQpafSqDQxVndxlECEUxs
         764AhwUmCZT111jmPluLGvp57yy4hSp1d4lzWwaFBUAvcjTKa7Y9goyIr+havShg9IZE
         0u2A==
X-Forwarded-Encrypted: i=1; AFNElJ+lcCmL0Cf2dYsO7xkU4xEaC2Tm1ODRgsbwxpW3gn5npxHzeBRyIKDgDNg5xeSzjHdofAZ8URVSReB4QsPACXDG@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/9PYjiPMSBKsDrP1p5HMz+NVOqq+8yr/mnLDWDpiAALWHOntx
	j4iPZTgnnJoQaa3nX9SJVXT1vUS7mq75jisb8AWpmBA0yViSKVcfgV83nbhHbrA1qEqOFvDjwIw
	845X2s/TEig==
X-Received: from pfnr26.prod.google.com ([2002:aa7:845a:0:b0:82f:805:b62a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:14c8:b0:82f:559d:ece3
 with SMTP id d2e1a72fcca58-8415f32d5ffmr4770377b3a.15.1779487496964; Fri, 22
 May 2026 15:04:56 -0700 (PDT)
Date: Fri, 22 May 2026 15:04:19 -0700
In-Reply-To: <20260522220435.2378363-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260428071903.1886173-1-irogers@google.com> <20260522220435.2378363-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <20260522220435.2378363-9-irogers@google.com>
Subject: [PATCH v9 08/23] perf data: Add open flag
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, alice.mei.rogers@gmail.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org, leo.yan@linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	tmricht@linux.ibm.com
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
index 94dc534a7386..ebeb46331005 100644
--- a/tools/perf/util/data.c
+++ b/tools/perf/util/data.c
@@ -345,9 +345,10 @@ static int open_dir(struct perf_data *data)
 	if (asprintf(&data->file.path, "%s/data", data->path) < 0)
 		return -1;
 
-	if (perf_data__is_write(data) &&
-	    mkdir(data->path, S_IRWXU) < 0)
+	if (perf_data__is_write(data) && mkdir(data->path, S_IRWXU) < 0) {
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
2.54.0.794.g4f17f83d09-goog

