Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA6847CC83
	for <linux-perf-users@vger.kernel.org>; Fri,  5 Jun 2026 07:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780645240; cv=none; b=aRJuJb4Z/kwAMsBow2ezh9ZYYcJ9ckLhXxgaZaetc6PoibtEdGqTqKpSmqeJh1tVH+KJ0Jj2ko9NVOwBWjhoy1UzjwoRZg2SkQwboVrkRDtl74yZvLed57Vxm6dy7Uv0+/s/KhH7AW3dfmlb+3AoRmElK8+KShkykt5gTo/sNOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780645240; c=relaxed/simple;
	bh=taSKB9BzdfFFc5okG7SIw+6aW6dC+xrRCx+VI9z577Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=H1KkcPBrDvPuYlGa9uBCizJawzSGopBc0TkB9koar8jq+de1TNu8ZE+5CT24POcQXNtLYSIucVOVgsxIYLQ8B0IZSt1nPzNjoz6/e3eLR8Stion60vUjr8me2zUV/4xzLI6HP6jc//Ibn1TdFR9npP6ZM62piRSN22zNSZhWMOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UNSW4fMc; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UNSW4fMc"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-304dd917645so1516932eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 05 Jun 2026 00:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780645238; x=1781250038; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=b1KCxLzm5r/4/75FpnIjDCoJZ2/GF5PCnxsr/c+/xOQ=;
        b=UNSW4fMcpZvCiGSAR4grzwUFrsydUwfICBnFrS0tLpXkkRH19ugZickkxdM7ltpKsz
         MXnzM4cmCDLLo7/p34wLySYlYTttZukC2LYWvyvL6/WgTN7aaMdIkBbdfnxdhjDeoicM
         kUIDMABhhxbte6s54SgADiJCy5ug983f+be07z8dt+mHqRikV29vXk9ddYcqx5gGH2kP
         6t+LanIeQj+YVJmNRHn8418jaOIxxPRY+pkcADFDOyAuuDhyoxJ0qPpKgjNReaEIB44Q
         oYcDzEQ1NCP7N64hzhV3gSpgLNTud1g4Of7jiL8mcIXD0z1ZIYHfPvsWKe5tiRstBMGI
         kupA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780645238; x=1781250038;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b1KCxLzm5r/4/75FpnIjDCoJZ2/GF5PCnxsr/c+/xOQ=;
        b=T9/TWz6mHDanZHzN/CkoxkaTJ7Mix3t5uo4HQaNlTomjheFKAy4j135iT2NSJW2xEE
         m0hwl3MmX01Nq+k8hiAMA7tByy3+AGgSsV9L8ik/k5CKQliGUjQCYuwK4u/mb5vrr5Td
         4pgSc3vCDDMTgppFVg/mMxVD/mkeupWN/KBGCrovEVBxt8RfhAN4VjV9VeYMO2uMeR61
         DF6oK1V9GxcccCDaRXC+XvR07oIMBGBz1RwqgfcAZI+ivtYc+xlLte282w7kznLaRiKY
         mieL+AD9TWK/QTyyvPa+4MA09ijamz7BmU2iQzM5pltZ1gvyi/EJ6Yo/IRVd5t9u4Aqq
         3xzQ==
X-Forwarded-Encrypted: i=1; AFNElJ9nFMC6MUy4UP6CrAL6q1MDdhAi0nFOccLLEdlA/iL8p4++kwQbXbvVWurZo+VwWlmTkeY1G5BgF8m2mwveMTNg@vger.kernel.org
X-Gm-Message-State: AOJu0YyWkGb8J9Ju9K+E1+j8s42LxEGI1GPImD/IYxUoWXs2vpfjumPS
	ueKqUSApZNUpzHwbb6ShibrSzJWSHSkx7OyiH62q88RPgdu5nryvXpIMAkAsBTF0IRV8yntg0eE
	40lUeUnpulg==
X-Received: from dyjf13.prod.google.com ([2002:a05:7300:680d:b0:304:e55d:6669])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:2142:b0:2e2:4979:ec7
 with SMTP id 5a478bee46e88-3077af4c787mr1106753eec.10.1780645237512; Fri, 05
 Jun 2026 00:40:37 -0700 (PDT)
Date: Fri,  5 Jun 2026 00:39:48 -0700
In-Reply-To: <20260605074003.1730715-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260522220435.2378363-1-irogers@google.com> <20260605074003.1730715-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260605074003.1730715-5-irogers@google.com>
Subject: [PATCH v10 04/19] perf data: Add open flag
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
2.54.0.1032.g2f8565e1d1-goog

