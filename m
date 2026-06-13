Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751783C197F
	for <linux-perf-users@vger.kernel.org>; Sat, 13 Jun 2026 05:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781328458; cv=none; b=DT2oF2vRlPinq8SRJESms8omBNOI67wJniFH876ZidhpV9uk7v+ImN8mVCEUuAZ2S18Tx+8VO1qZ6nHBtl7KAspbZzxaZAemhhjPv/GvnL7QggSMUC3b8zFj55uzZ09EkC7k+i82GaqY+kh7ipTxbspD0WxyoVoOn5V1tyd/eN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781328458; c=relaxed/simple;
	bh=46UPsdVhKLSGOesq+b4o9rur5WYGR9zwjyMivGxYXrA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cWcHU9iTUaaKHtYjNazuzOLM2bk+hHE7OBHsTp3sZ78cD3caJexgLowFZtY+PTOa+4CeO81MctkU/V1tejjNrbNhwSUlyMVteSNWCZIrtHfsj43zzb2GygSOV2hcvJQUt6f0Q8pwd+gMXdGReKe6RYkRznZPXY0v9xszQrk6kaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mlqnKfiK; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mlqnKfiK"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-304ec73b015so1391690eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 12 Jun 2026 22:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781328454; x=1781933254; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vT2Mha6cP/S+RPKLMMcfihXr8wIiT308bjbyJ4T0oAQ=;
        b=mlqnKfiKp1Re+XgdgpHUBSUQADMctPE+vHCkAf/flN0znZ5XiPwwRChR6apwOaykmi
         YEoM/kp80TvagtU9pLxVTQq92F+MXFFlzyrwVLHq9mK+Ucjj+rH8D2qUMnuY5wEP1oll
         FJNtU+CFofb3nNw1x3ld8fZJTRNdkN0gTegrBADtkpVLmWcMQPUCSNy2KkD1wEExh9p8
         SgV5eLo0ULQEEP4P3kBfHeuKJOgn0KBACsJe9IdwSaJbeWPDTHkTq2ktH1ARQXYNHJZm
         XrMa9gtyXV11e2X/oxzxAXKAYP+QEqTV+QS3yn+On9Bhwc/snq4AFF6o3ElOqS1cB+Fj
         Hg8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781328454; x=1781933254;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vT2Mha6cP/S+RPKLMMcfihXr8wIiT308bjbyJ4T0oAQ=;
        b=ItW4qCSAGFlP66QDem2G4SCFLE+k+mpV6hpLVKcdR+LX4gJK2bMS5aP8tjFfu63FlF
         SQO03j/IxnkZHtJLyJ1Wz9F6yQI2pXB71Mh5GtEoKQwh5Pxms7Ayd0yDg2alCsFae0Jo
         GKqrbAj2O92LiVL6DQfqF1UlqGw2JYlqimByFBd2Od2m4IDsw9bO0991YhnpQDv//0IS
         1cBgWQRE/dWLM7nYuQ50alm72qXIiGdnGeopbIIM+ydwrGeSywk7FOt6mo1RUg2Z/9Ao
         hAFgkBZIMLSsaMngM9o0X78PiNZj8JkUWdNWBx5LTXUn4kggNXxQuXjABQyxPCyrIA73
         hb6w==
X-Forwarded-Encrypted: i=1; AFNElJ9Ap9g8ck3mQXWeMA5r27tYJzuBl2yaIe+m5blusvya/xrTN5NP8MVV4csINCOOg0Aozk32WtlURo/a68ZQr9Wu@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7K/gbyVQcCDMdr5HBh84HS9tiLKrOBlp+LH4Op9NrpNujrIJM
	PDFTOzLFodeXfb2A+ldpLKfCtEDV0TLRED8lRwCYMV1AYekqPqE/ynZOATiZPPpH30/o1pe6z0/
	9bXjI2TcCow==
X-Received: from dybmj14.prod.google.com ([2002:a05:7301:e0e:b0:304:dbcd:d155])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:fd15:b0:304:8366:7456
 with SMTP id 5a478bee46e88-3081ff41333mr3839485eec.3.1781328454262; Fri, 12
 Jun 2026 22:27:34 -0700 (PDT)
Date: Fri, 12 Jun 2026 22:27:05 -0700
In-Reply-To: <20260613052722.1424093-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260612221211.1221305-1-irogers@google.com> <20260613052722.1424093-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260613052722.1424093-5-irogers@google.com>
Subject: [PATCH v16 04/20] perf data: Add open flag
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

