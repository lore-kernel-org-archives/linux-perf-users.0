Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7460370ACF
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Jun 2026 01:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781572563; cv=none; b=Gdg8NoCsAJk25ZzC8sWdSTNSPCZfeBY+5qXO4t1YJw4ohjbn8OMNNoyodrkm/5zCU7f8k7jk47g+6q1fGprTBcWKqy5e4HR9vCKCy+Pk9DbUCl/GTjdMQ8RSKrgj6qWWOfXoH+2BImmiuPCyws4hvFrnwIBBBFCvkjOJEzAHytA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781572563; c=relaxed/simple;
	bh=Zqp65KwQSLcOOhvyQLJkWCUgZ1jmploQaB+dpb5COyQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pQB6g2E/86Wi0vWiT3HA+vPHUNPNpEiYE6u9mAsfRPmBs9/Y+fB5oBy4rHRykprzRIWoZNeXVTH8wwm3ojETffw3yoEU2hqKNZZoKdEtT04sUbpTg9p1tbVR9cjfaR1eJanoRyeQLqIqthiKxZffwWNXeBjG7OQGyyc4l/BsFQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LpyAmxLz; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LpyAmxLz"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-304dd917645so8301605eec.1
        for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 18:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781572559; x=1782177359; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=U1DtSw96iac8P2WFh4+eWHNrQtra6MxsqACQHocD5Fs=;
        b=LpyAmxLzqxWbW/lhz2KWoXa9t0jVvNS1rBLi76epYcYDPd4eSLwjYFpUm6c67tpLTR
         Cl3PyRyvl36pYwmwZej0VqVkC38kINSUzKZLuWTe6m/2tMbt+AB6zwcqJ5584/o0v+8u
         KCV2Ioj1VQvFjJVt+pMf0U56hN7Y75EdrIMFeAyLqRDDEgmLjF4vAanjjMxt5vCqUN16
         9FrC0+M3Qx6N3DsZWsGxqkVhpihlsxkRQY9t6M0reIqvUc9iyPZINsoeF3LO5DGnTtjD
         7iVEItGrWfOToErWQfvKd/7xhL/R/3qUVuEj1YArtuifAEQ8rykrGDROVAC4ntju3Mfb
         wDKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781572559; x=1782177359;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U1DtSw96iac8P2WFh4+eWHNrQtra6MxsqACQHocD5Fs=;
        b=dr2hKdvAmKWLB2m1kPq/yNvYlhDiVk5AnUN6iO+NjX1xcoCPJNoBoqWneZGdwcmuWv
         RDBPcKQUW/d527W3mZ3GFWhq2162ViRkOZ0Htg+sjum42nsUsI3K3qJpx+b6edu8rb3E
         IjD1VRUAU68CX8bMkoGr21RS4Fp8J+irkklD08fVWQHwFn7DZhJfje4e1QY3/2yjvGeM
         zGu5WDCvjihFXP4e9kZ+Q0+2vWdmqvy/ORRFiVBSU3u9dn/GfU9T+iPfY6XI3KFU0usg
         i5NfUc5dO/FKwQhrGOEPhN8RFLvsbM8ZiLR+lwMECPsMed6SZF7m3AvTOyx2diRu1fFG
         yQSA==
X-Forwarded-Encrypted: i=1; AFNElJ/lN3KtTt8cQzsawtXbLgm5g1kmUq864gxw0YmK7PLGO7SiI+II+/iQoQhuEcD87Rz9W8v17UKaxLKuBwzSM+ma@vger.kernel.org
X-Gm-Message-State: AOJu0YxRpYQ75BOp1NhB8eLzX+ZwoRrIqPGjNjZVKnTQOm05rG7+9L8X
	Py9zmScFWTUEg8cE7eBJaOA23S2pQmDGJcr7ILp4PMQeHEL/jMuMp6ZVc8lmNSVMWkPw6iGGv24
	vfR4Iypw4rQ==
X-Received: from dyuw24.prod.google.com ([2002:a05:693c:8818:b0:2ee:b6da:180])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:1344:b0:304:e7c9:b528
 with SMTP id 5a478bee46e88-308200d33aemr8416739eec.30.1781572558508; Mon, 15
 Jun 2026 18:15:58 -0700 (PDT)
Date: Mon, 15 Jun 2026 18:15:26 -0700
In-Reply-To: <20260616011543.4037138-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260615223011.3873955-1-irogers@google.com> <20260616011543.4037138-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260616011543.4037138-5-irogers@google.com>
Subject: [PATCH v21 04/21] perf data: Add open flag
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

