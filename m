Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73AC4A2E0A
	for <linux-perf-users@vger.kernel.org>; Thu, 11 Jun 2026 17:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781198306; cv=none; b=GIzkyOVKoBWepws3nTtf/GFu351Rs3cNd7KClWcmflLCcBVxwXiNOKTFZnfhPhNAaWoFVvpVA1pCA73RF4OHvNVilXj6HEiX+fNH1N3IdggrmtytKKazXJC4HO/4QuHzYU6lOxcKLn5rc8vzCOKT33I1eeGUUd0+bmb9X+48SM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781198306; c=relaxed/simple;
	bh=46UPsdVhKLSGOesq+b4o9rur5WYGR9zwjyMivGxYXrA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MWeCOUTdnpyunvokbVkoySuqb+GYOYIrvx8ZNlaqUXoBzk90QtCyglOPuO0CSC9SeR3WgqbXMC/W2xuvlGfmJv7XznQh7Giu8RomZDjPXegtiu49pUYc2HFNMXBFmzQTQwTsZgEY27X+SxLGbF665EUbOMYDhFY46hpCEK0r51c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uMJODUoM; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uMJODUoM"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-304f1820babso203574eec.1
        for <linux-perf-users@vger.kernel.org>; Thu, 11 Jun 2026 10:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781198299; x=1781803099; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vT2Mha6cP/S+RPKLMMcfihXr8wIiT308bjbyJ4T0oAQ=;
        b=uMJODUoMD0Yk/ELxLe2BEtS/YKpi3TuviHBfyDtoUxVgIWnYLY3FZ6XsezHq28gFTe
         EA4BT2b+qBMovEka7vrQ52tOHNTYwj5uG0duUAvI+eFdMRlmcwqpesG/Gt/swciIUr1A
         4cduEgZfcz5kgOCZDZSv4mawZsBjo5Hyohx7mVlT5Z1oKCzw7ktOt5HtQrJcTrKJHcQy
         hv8HSy1jQo6zloxnxqubVdlv8EMmtUIbkl+NfsWjWXQ1EKHFHxNfw0AvHiGhRGsIl6jc
         fgB9CDMOGmpNXj2LDdFvPPn7G2mBkGqvaz3d62CiR2O6aIIRiTkBzPDmaSlESEAQt9og
         I3Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781198299; x=1781803099;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vT2Mha6cP/S+RPKLMMcfihXr8wIiT308bjbyJ4T0oAQ=;
        b=hoVOqG3MjRNo7nJg+b0tR/kwkjMUQVTGYrn8F7AmHhCnw8uKc8TviVq9RlngSM9jxR
         Gnn05n8n5hqQPrLot3lJ8UfxPuRTc02Jsgw4Jw/IJHj6/DNd/5LQZNzyrblCJ8/eP9iO
         hmR410CqcRhbJaKAtn8+6ctwzy9Jx/gHfgALPw74Ckwb9HvRemF+cSbxznKXad/Z80nz
         xHmYbc4GB5hKXXjPSsj1asJdg82bdKaAykibPTsBck8Rmg81LHflJ6CM4D5M7GPonK5T
         kaA6CiqnSw3iCFKW49wkcDy1wL5Bo4o6Ngoq8z2cSqPTUsMi+MUQIQYuzVHJYEal+n/W
         nXHg==
X-Forwarded-Encrypted: i=1; AFNElJ+DAfvsaen0eBdMkrch1HGHVA/gQTPAtALaXN0WeoPSVc3LGX5y+0ND37duo8NnCEhMQzntqe/tF5j8Rz2lVgVq@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8U0pGtNAQeuo8GMpJN1hAdnzNq5qQFigUR8ekEUyVcQiUBSFh
	VWTJTJLcq3AB+3+wz5Gr8y7aDLza8H9rPgb60TP2G8h9ZpsuvHIVimdMuet2xv1xnwh6eFeRu+E
	hlefWksqwbA==
X-Received: from dyu11.prod.google.com ([2002:a05:693c:810b:b0:304:d999:2b0c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:72c1:b0:304:d82f:c2da
 with SMTP id 5a478bee46e88-308047cfd83mr2755414eec.8.1781198298587; Thu, 11
 Jun 2026 10:18:18 -0700 (PDT)
Date: Thu, 11 Jun 2026 10:17:41 -0700
In-Reply-To: <20260611171756.4008769-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260605191500.2477026-1-irogers@google.com> <20260611171756.4008769-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260611171756.4008769-5-irogers@google.com>
Subject: [PATCH v12 04/19] perf data: Add open flag
From: Ian Rogers <irogers@google.com>
To: irogers@google.com
Cc: acme@kernel.org, adrian.hunter@intel.com, alice.mei.rogers@gmail.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org, leo.yan@linux.dev, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, namhyung@kernel.org, peterz@infradead.org, 
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

