Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4545740FD9B
	for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 16:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781542226; cv=none; b=Z8frVEK5U5eJoWAgQ4/fMUF0JhOxr7jq0UqtTo5k7FmR9jl7GQRwAlJgtCl/gTgvihcJMxHMSPg0yNH+oFl70wXSSJ99dG1ytYnpJs82rkB87AC9RCDKj2Q9hRrpnD7XhhxDEmY7F5HzXAGW2oAXz9eIIlkKTVoo8EuhOP0GuDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781542226; c=relaxed/simple;
	bh=46UPsdVhKLSGOesq+b4o9rur5WYGR9zwjyMivGxYXrA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SF1+XGoFqSSQQmh66nLhb9JnQIe9vP5kmzWVx9fjb01Y8KHEx64KNjozNnc2yWso7KCTl4FyNytasvLw5Ar0TKeCDBQwe3JGvvxMf3DnIhRs6cDDYxzeIickIVWPGbaNt4mz7ktgcuQwpg9n0vM/13dy3jqYHBcgMjr1qXQbdyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JdpfAuc3; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JdpfAuc3"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-304d8613efbso4291096eec.1
        for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 09:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781542224; x=1782147024; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vT2Mha6cP/S+RPKLMMcfihXr8wIiT308bjbyJ4T0oAQ=;
        b=JdpfAuc3Dy0UN3TomemO58fxdvkXkFz7kaJAa7F2M1bJPYJ9+1m45AybIVrSb+v71R
         wx327SsmyP/sykRF8NdRvCBfh12jzU+00BkYYDQD8dYVhyHVKhyPYt72uCnaifUGxu2w
         Fj7YpSuYfXg5/5M3p5WPUDB/d8Yfacit/19MMcS2hCfD0On0vXnPYCRWFdiE/hnfTdPV
         NWTZIEaBwGjAu+JTxrYcWLzMg+O6r9EY2k4KzZ3htUEmc9OsuZ2JkNt11fx4P9mT2Tqs
         oN6+tp3lp3vsvk/TPRjlZXTv4xIIBUS+DLBmcPsO8+75xDH4L/FQREZHVyw7stZORd/g
         V3jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781542224; x=1782147024;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vT2Mha6cP/S+RPKLMMcfihXr8wIiT308bjbyJ4T0oAQ=;
        b=cn+dGsQXdqNNvIJieRjEaTkiyb3XhzeaBpx5pvcfOwhnDCTzRY5zdjLSnTqqi1SLoP
         hxtn0LU7CUdY3yyZk6kqp/LmQTye8qJXoCs82Ft9XucFPpkkFWhQjAu9cMctBrWVwSsF
         Zeiq8Kd+nKvkJhyFlIH/yBGuosi4gAJCCwhBB7Dvw7P7DAHqDytVieCbBtb2TKUQ6DmU
         pNZyN17FOHN/UNtRmdbmiQ1qhKNFMoWQvNwrdpkWzRo+rxt+T8tGki0bqVB4OgB7Js+X
         cTz/06Uumz1mHQmQK3Jeh5bD4SBym9T63HmjDWvjg4JQ4S5nPZGsEGdUJRRYBtHNTDLc
         vYLA==
X-Forwarded-Encrypted: i=1; AFNElJ99RiMB7rubbuNp/2Ny3iK8Ok05Z78jOMfi3ZrGKOR2i69qKuU2NbbtSH3KdRjkxQ94HrKp+Rn+uMQkCoSnVOvi@vger.kernel.org
X-Gm-Message-State: AOJu0YwRjka6D7N/YCXWi3URC4nzHHgqOwp4fd0YZjPMHVyG3KN1rJns
	L8nZhDTzg5NJMS9B+x/+Dc3aRuoqBOrA/yKXEpDTELfL0MVn/NiirdNL67lVvpMYFXb56xLoBt0
	h2MZfGYvtXA==
X-Received: from dybmc34.prod.google.com ([2002:a05:7301:19a2:b0:307:d71d:34a7])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:e882:b0:304:3c33:7ae7
 with SMTP id 5a478bee46e88-30ba596a9c8mr200eec.7.1781542222501; Mon, 15 Jun
 2026 09:50:22 -0700 (PDT)
Date: Mon, 15 Jun 2026 09:49:54 -0700
In-Reply-To: <20260615165010.2724690-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260615061631.2382079-1-irogers@google.com> <20260615165010.2724690-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260615165010.2724690-5-irogers@google.com>
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

