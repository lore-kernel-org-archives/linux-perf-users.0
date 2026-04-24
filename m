Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4950F336893
	for <linux-perf-users@vger.kernel.org>; Fri, 24 Apr 2026 16:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777049286; cv=none; b=brrNdQmNlntDp0112oWnHPn8hEoQXYsCp7BYWTyoGojfpEXVvUgZzUJWKuPnuR0bDlyYEZ7JYsHdwvUI6Zhn7qbDtuu3vgA2B5LrwWH+14ggt9Own0J5x20sUQIGrK+TJSrzDNrbN3a5i3BZs+cQ/87nYNySkfWmupkTAyJ1kQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777049286; c=relaxed/simple;
	bh=gfLLI2JWYrhGkycbda+k+ahRBIJmlPsVfm7fy7d7O8E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mYGmNOaJ6DsoRBgegXm2y+kF3EYUsWkOpCYjULajSnuOrb6Zep7rhI8NXvtVvWtQxfKj6a6JBXO9/GHIpAq5w0kLt6bPSrCKkUnd0Mc58ZY/NBa6cu+TlpehWf873jfOOwL7ipDJ58O126/mR+k/l6iouJvnUqhIsnUFpy+7vaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e3u7tTyE; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e3u7tTyE"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-12c21dbc9c1so29133072c88.0
        for <linux-perf-users@vger.kernel.org>; Fri, 24 Apr 2026 09:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777049284; x=1777654084; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=22olXlLY2a/aW3iIRalXE3Od5F0yl9bqDC7eX7ett48=;
        b=e3u7tTyE8wlQlgigcSHyJJPdhnYKq9alXWXyBdbOsIn20+fyAEm6jTSgfVlwlSAIhm
         JX3kaAfe028RAsjgEHsrJ+/1oRRtT28ftFjuRozYEqOSCw1CcJjv1sQIX5h4zPJJfQQm
         fnTE+42RThHlJw+9WryoOUQFF7QbxFlAhFLLFb59cUjnAwOto4q+0RNB/tlRiC4Lw14r
         IW2RmIQh/DtgjFma6Umby2TtYU791aKfu1Wb7r605/n5yFDGJBks82Ka5UrWdNiIjegN
         dx/QsRUIwDAl/OkbHC7PcnBa7Hpg2odRT525YBnHVqY5rWV6ix/R9HPAEcOHQIH0mZo3
         VJAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777049284; x=1777654084;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=22olXlLY2a/aW3iIRalXE3Od5F0yl9bqDC7eX7ett48=;
        b=WkTwQ+T5l+Sg97+loBFQcHffHQk0eknV7yjrsZuOXLCTR269p2TLS7/6pLCCQ98iNA
         pu7QY9V5AEsOWx7NhqU9jDYE788IvV9mrXVRnlgTOt5zjHU/wDgkgwQ+68nIHvML80Z6
         rg4wuC816TSqKZ1LqfmEZ13xwWWjo/DF4vek3Rzr2+evgn6+KHjrxRGMziG+ZUCbcbZU
         iM/ZIAGSWTBd+vAZNY+MA1+hLENRSvlKUGLURO+F1Knnt37STJkV2F12P0G2Qz/MS9fT
         tlAE/WCjx0YbS/9JTMYX5AwVZkjKekZeOr5hEmjB5XbLKWMisZG8rUez6oyeMJYj53/d
         RClA==
X-Forwarded-Encrypted: i=1; AFNElJ+AMlNUbmHdCb8RVlXf8DGHAiLiSX9y4HLzXKmAjnnhSiy8A+crnNbNrTlrnVDPq4P+s8c89/l9DNe+rmVCcAc/@vger.kernel.org
X-Gm-Message-State: AOJu0YwDMBikfrD8jJscj2uDpgm5WOFE1IQ55jNDmTwF/6zvcdqA2XAr
	D3f01374NgI2vyCB7/CAN6859Rg2olssfLgiiarGvioz2IAtE2BL7ay0cJIBb5d4l9W3/MUFdwG
	1rTKBF+wWtg==
X-Received: from dled13-n1.prod.google.com ([2002:a05:701b:42cd:10b0:12a:ad8d:be18])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:60f:b0:124:abaa:7ff2
 with SMTP id a92af1059eb24-12c73f9bc97mr18739871c88.24.1777049284122; Fri, 24
 Apr 2026 09:48:04 -0700 (PDT)
Date: Fri, 24 Apr 2026 09:46:31 -0700
In-Reply-To: <20260424164721.2229025-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260423163406.1779809-1-irogers@google.com> <20260424164721.2229025-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260424164721.2229025-10-irogers@google.com>
Subject: [PATCH v5 09/58] perf data: Add open flag
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

