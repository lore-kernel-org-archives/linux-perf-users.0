Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CB939D6D4
	for <linux-perf-users@vger.kernel.org>; Thu, 11 Jun 2026 22:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781217912; cv=none; b=FDyI7lG/n5PCJLOdzKp/lMkHH+ECg7sRcOlPGmYTRyWsZWv9z5q8sXCP2tPW3TEipQg5SCuWkk6TbiVaHXsAed50ndaonexmk0XboRmwrO/hSpDRmD/VowKeRAWKOH3oCJF2VtW6PjSsaprZ/JQNnzV2tPfYQJCPc0gOO7tQPy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781217912; c=relaxed/simple;
	bh=46UPsdVhKLSGOesq+b4o9rur5WYGR9zwjyMivGxYXrA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ln6l6z61p1/+duMtiW03/5BdgUGJWSsXnz3IQwSF452vn4l9CuhYdv+n0Hq/hnpf/rzr+MfxhFBA0zHbLWntsekaRdb4SUtfBo0B63r03stlH7YtMBD21Wny055digkSHuY7e5S+4RT94ApU560hdUTny2Bt6jL3ZLGncxAWQPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uEs2x2mC; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uEs2x2mC"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-304e7fc90b1so472634eec.1
        for <linux-perf-users@vger.kernel.org>; Thu, 11 Jun 2026 15:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781217907; x=1781822707; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vT2Mha6cP/S+RPKLMMcfihXr8wIiT308bjbyJ4T0oAQ=;
        b=uEs2x2mC3gkS+roTcpTCcCmwR7Xtvp4zolkYQ/Qop/UPrQaDZri7aABRPIKK0FwNLp
         CaslphuUYuNp16+foXrdqpGVqloFQjdTCL3unz1hmQR1hXTHHMof5xIP8+uKSdGiJL7z
         ikYwsNnnx0X1cbCMjyb64t5ApCXysiYPFnBDiRNfstHFEm6PXqq4YlG7Uv6ZT1YCOcSr
         HJSks15rhXRPhDidglD0EswpLI0FGZ9CPTrBCw3TZ+dXSiQTRUblfIUvnOsUcUua2Ag5
         zbvysolJ+F+Pfq2dXqVJnKXfNivr2QIxuImn68zGEUSfieGDLJJ56kH60WS5yZYuiP9w
         t7Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781217907; x=1781822707;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vT2Mha6cP/S+RPKLMMcfihXr8wIiT308bjbyJ4T0oAQ=;
        b=ZaQF1nS+KsgVEcW8XcVPwd2bxSPVzUNoR+IJfrlx2zcIj3PQAXCR8zhlk2z2mApvp7
         Fz6cG3fqxLvj21g8Go7UuGtDGkjakJaChBPiRBeKrKtHpO0TPOIa3MpRHBQA3iI1DZLH
         cmt42LKUX4OBTYF2m7oFucxPft9D3ELMW2qWOtyKKn/VMRjKftDBmlv0xbstEZjy1XF8
         ngwr1qXmNQK8ZBK9OXXbdzoKosxb+wsj+rBOBeKex9OdiH2z2VBCoUKEybtNtb+88ZWj
         +WcMND/BI0Ibkq2xfDkBCsxgqFaDP1rfV59FXE/gS2zco0bKUNaqTzU4/Ij6Cu8NWLtX
         1k6w==
X-Forwarded-Encrypted: i=1; AFNElJ+4OM+ppMZ0uqlXQlFjeAGt59Giq4nSoxyDOgIS2yq+dqDNM+02qJOaSQw6RwEpXZsVwLne3OE+GFJNCrYVZv6S@vger.kernel.org
X-Gm-Message-State: AOJu0Yws/VceuyMrSOywYcQ9Y0so9uvetJI5w+EdcRcuxH7n1lej5rRf
	1clplZpU4/7Bix+OFAOO9Luo9qk58FLGJRWImZ5CDvBZkrkPMDffFVI2GSKUremJJbLr0UK4+YN
	Vj/IKYy7gtA==
X-Received: from dlbrx9.prod.google.com ([2002:a05:7022:1709:b0:138:57f:8a4f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:527:b0:134:df7f:a5cf
 with SMTP id a92af1059eb24-1384bbbd4demr131117c88.29.1781217906281; Thu, 11
 Jun 2026 15:45:06 -0700 (PDT)
Date: Thu, 11 Jun 2026 15:44:40 -0700
In-Reply-To: <20260611224455.201994-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260611171756.4008769-1-irogers@google.com> <20260611224455.201994-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260611224455.201994-5-irogers@google.com>
Subject: [PATCH v13 04/19] perf data: Add open flag
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

