Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A2B3B8BD4
	for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 22:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781562632; cv=none; b=lx3cV5bQcTdNaW1/9B1NfeKAn9rZT1QkzmOdad60XO0v6/l6ANnHrXINgKFqmhRjdf4hMC3XOQ8ot7k72dJ1ZKijSaaW3tplekYFX1REVBUuy9qegcrcC9NHYufO2U0d/FYffk7kqgm14k9OQeTm6mhV5wmzB29ykZuENU/pzBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781562632; c=relaxed/simple;
	bh=Zqp65KwQSLcOOhvyQLJkWCUgZ1jmploQaB+dpb5COyQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LHIoEegL04Wpm+muYdDOlX2jdVBmS/7E4DM6FZPGXo3o+IREkUTV3PsgYKRcjh7UEglPeOBPurOGjzwGfMrycz4i5NSN/Lx+si6yL88tzZYRPXvm+igynv74ozjpbkFdkLK+8URpkNFCLjA/YyRkYSFuSje5lLV7JkPTjlXnk3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i+IiZ1+g; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i+IiZ1+g"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-307fd7138b1so5891031eec.0
        for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 15:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781562631; x=1782167431; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=U1DtSw96iac8P2WFh4+eWHNrQtra6MxsqACQHocD5Fs=;
        b=i+IiZ1+gXASOSwngAzoln1R7YIYVmakOZ5LQymQtScC5Y0ePk77yejMrFxc0fmoIIt
         5YI+o+gOFONbQo7yMXm9j6S2/k7P/7drUBnJKU8u59rDtcBF2IJMTPmGBX9Ng2OejG/V
         ZbTETn7aC+9OG8Ii4LxeEJe5zdq23Jbj6Ktw7K8MQWuHRIBwaTgynP7Zz9Az7wbUpE9F
         FTi4d6SmeovHwrpkNNvKmBWJse8n9vCix7rnwpVU/z6KR9yGsf5LNhtUpvZGYTzoXaVS
         dlZL76dSwkBuzVAkh+y0S/v8WLWKQH7DZNZqGp1cWqDhubiNovQ5cgIt/ohzJwRyzYkm
         IrYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781562631; x=1782167431;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U1DtSw96iac8P2WFh4+eWHNrQtra6MxsqACQHocD5Fs=;
        b=n1sHvolmoe/zCkpoUQtm7X7YUmotcdIqTErKQuzu9IYppjMkQe5EKNy4Ho1Iw+8t23
         eQUh+qg9XreIBTISkoNl84pPktOHukzuTzUx/h+pTvMFJdY5LsTnTuFvVBU/XKfCoZUh
         mKd28GoOj4y6nyllmvFOhgXf/oeU/pQ7tm3dhES5XUj5AXfB1+/5FE8IY9lLvDf1Y2AD
         bHVufVFAzFAG3/gwltGeO1NQnqDN6U2IcCLtjQK3yKVTy/PATEnDCV8FMm+nPe5cMMjJ
         2sDp4hWP/wT+KyBptiLIAxgfC0kEdlQT+zEzOtT85p4ReIEvKs7Dx5yMwCFeNnSjneAk
         tLlw==
X-Forwarded-Encrypted: i=1; AFNElJ+Gi94wFkqQNkIvXvtTJmjy3sFAfDbBXb01kMWHKRVuttgUAmt8AYB20QuR86wkylf6xDrSqDpxAKETo3IIdYYR@vger.kernel.org
X-Gm-Message-State: AOJu0YxIsSYcfprR/23azVisOVTPu372Be9Frj7h8Sryo8/fq8nb6fbr
	5rHjP2jiL+GX3v5nHrxu1hYjYP2doKImgsbfuekvFuqjSuh5skywNVcirH0dgUQm++4QwQDIILy
	U4pMhOVvVlQ==
X-Received: from dyev5.prod.google.com ([2002:a05:7300:4305:b0:2da:2af9:bfe2])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:5710:b0:2c1:7793:7bbb
 with SMTP id 5a478bee46e88-3093e2a95b6mr6559840eec.27.1781562630425; Mon, 15
 Jun 2026 15:30:30 -0700 (PDT)
Date: Mon, 15 Jun 2026 15:29:54 -0700
In-Reply-To: <20260615223011.3873955-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260615061631.2382079-1-irogers@google.com> <20260615223011.3873955-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260615223011.3873955-5-irogers@google.com>
Subject: [PATCH v20 04/21] perf data: Add open flag
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

