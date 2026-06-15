Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D273B0AE1
	for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 06:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781504211; cv=none; b=HRRjRsrzzMr+E731k9RMSJngF3rqsE6DF2/g9QX3g6XXt12f0j8LAaoxvN0gZ+nUgdzkUoYzQ/aZLG9yMKPtXRpRZ14oaQQa96LIDxDoBy5xALHhILuxgVSDw94o4vYWMze9yRJGBiPKtqS4n5CcKzmCW3e/Wigph2u5OycOWjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781504211; c=relaxed/simple;
	bh=46UPsdVhKLSGOesq+b4o9rur5WYGR9zwjyMivGxYXrA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CgwU+YNboPsVsShVS8B7893UIyGgJjt+Ulr2iZIMCxNfRESC8M5N/ApmS1ju8dcB0OfTBuSDZgqpWW6vQ+cmwW9mMfShWrvF0Y/l8QDaMLsfusM7pnpBZR5laOhIbcCI8JoGLvotTVibi1hFEf1b+Tmjunk/cERm+QuqJ7radV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UZT/7C+Z; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UZT/7C+Z"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-30762d67a64so4250909eec.0
        for <linux-perf-users@vger.kernel.org>; Sun, 14 Jun 2026 23:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781504205; x=1782109005; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vT2Mha6cP/S+RPKLMMcfihXr8wIiT308bjbyJ4T0oAQ=;
        b=UZT/7C+ZCoRp7IUJC6w11nSiaeLQ4qdNkjD/W4vI/Vhxdwg7QFbrvbYBtUNDhA5qSs
         PDO75RcbNOWlkxSLDQ3eK5X/pRyQEIh2zZHZs6esSDCDQnQxPFasXk1zctK1kHr7vU9P
         DgYHeH0llBf//CUDc4sNRBQ/S55cqnDFcTdBDl7UuCMoTIxTcSdpfDdHQBgXbQZxRjCC
         W+EcVBbpH4NJQef8LF30scVpYd/KqM6qkJDheTmYePlc6GChCBfmpeBPVJC07bhOUTtJ
         oTjzeIvlm58TO0txHt3EpSPifdMK7rzWgqHs/yv6hTrqFyHBbx+ozxVhKiP8IjFgvOzg
         1BPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781504205; x=1782109005;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vT2Mha6cP/S+RPKLMMcfihXr8wIiT308bjbyJ4T0oAQ=;
        b=IkCuwhBZojCX5naZfQJw5le7zDblwB7tJrTqO3Bd3E3VHIq8/LdA4QxrFrSBuYqp4p
         K3UjLLm2It/ISLT62mzOepW/gZFmFVvwhQ2OgKtjr/SKAz23QsoEQvbZSTtLllmD1CA9
         UOMNifBfa6BlXp59Bfu7N1n1DoBw6Qpe4GV4KxPOCxeSIBhwPUp335925UR9F47W7+bG
         6vOGKgOJMRIde+7pU/03yrlqSvSvW4ar3dhqQzvqDUkVfNLuxZcAXip73FH9gmCFQr56
         70ImgV8+ChodvSY8K6tFlDJX3JA6DZhVGRU8XUQrSkjWLMtRRBt1thW/pJUiFNJxMb++
         4HlQ==
X-Forwarded-Encrypted: i=1; AFNElJ8QtlS/RV5j0MKjhWA8lr2C/xWvPMyaqHrUF6Yck2hf6gb0gSOduSycJtHisHla8/mLvkiU27jWfbwYBYW/tjjY@vger.kernel.org
X-Gm-Message-State: AOJu0YyPkyDkmJsA+tuy/DVxHztPqISz9Pv9E5DUsTXssIY8RQo68mNF
	5EeOCx70pmd7b5PrlHf6M+p63unEy789cysvdATZJGFkdc9ECa+i7ZPyJTrNyjwXhWMaX2Kq4Rv
	kwp6jFINiEA==
X-Received: from dybff23.prod.google.com ([2002:a05:7300:bf17:b0:2ee:de47:cde3])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:8347:b0:30a:e5d4:22a2
 with SMTP id 5a478bee46e88-30ae5d42b37mr2561713eec.34.1781504204883; Sun, 14
 Jun 2026 23:16:44 -0700 (PDT)
Date: Sun, 14 Jun 2026 23:16:14 -0700
In-Reply-To: <20260615061631.2382079-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260615002812.2234795-1-irogers@google.com> <20260615061631.2382079-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260615061631.2382079-5-irogers@google.com>
Subject: [PATCH v19 04/20] perf data: Add open flag
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

