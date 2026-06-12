Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDBC63D45E4
	for <linux-perf-users@vger.kernel.org>; Fri, 12 Jun 2026 22:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781302366; cv=none; b=bJjoQ1ONtCsgbJfhtN1cJrK3784b7uD8Er/NaOSBXTcn5X5cSxxZwOjsjdT05H/5dZIfDN3jgQryBR5kI643voYmFlzlH05IGKSAqcoOINpKVQGzdbProOEdHwsJFsPD1ZsdkPbvt9HF2Sw0Cchj53/T4B0OWEZWFklUzyZp4Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781302366; c=relaxed/simple;
	bh=46UPsdVhKLSGOesq+b4o9rur5WYGR9zwjyMivGxYXrA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LXWRkbvKUfk3Lmt1u6pLKBka/yZMBA6SqxjFRL1InqsaCrB5Wpu/vjDQ/yXbkWbpTpSGHKsb9Z/6tEYgq6FsUuZhA4BktNMtDqSasYaYkz/BgrRhZlS56JsYToz50jp/zVsidt7H0tCvOz5gzqjwDppTdT5Pg3BdLJdiSrbBsWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ETG/ZFvo; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ETG/ZFvo"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-304f23c55b2so2044259eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 12 Jun 2026 15:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781302364; x=1781907164; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vT2Mha6cP/S+RPKLMMcfihXr8wIiT308bjbyJ4T0oAQ=;
        b=ETG/ZFvo/o9oKpjVrcoO/0BUhrlzst1AtYGiW+C1QhWnjWfO2YuadtmDXmVCgKXaib
         Hz+XNf3vItNT5WPgepF9wO4K/DtgUc0JYgXYhLt/s5hJm0FCeBtdBJq4cErK6h5eNx7Z
         vm3gHgptWLpXyW6HG+iLdbf+I85bqJi4SfQ3V5sLTjVoFE0Yd3QETK5pHjyMjTo5pGXJ
         rI3i/Yn8i1DLzvNyiIJNJacxSIkUEGF9o1fvyAYJsOJoRCBpcUPysoE3LuSyjvg+SZW/
         8IDC3qAgeVXUCMf8l97paA1eEbihESr3Smx6YU4PMD0fE2kNONqXFq8UVdDZ2gUWVsCW
         IE2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781302364; x=1781907164;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vT2Mha6cP/S+RPKLMMcfihXr8wIiT308bjbyJ4T0oAQ=;
        b=BN1TnakdVfcVUhjqBQTYQ6Fuxoxn0cU+5VL/Ejj0hPQ3Z3+lREwseNabvsJbprvtlm
         WOOG2DrlpB+4BmQMm53D07IjMAIJ28waKQ4ymOOzmbEl41mEwOzGVil4/wk1epFFe+QE
         BouCCO878tLZWuT2NLTqfP9x0DF8fUDw4mRdZJF+JhnKNaf+cI5X+2NfxcFTnJZCigiM
         zz8DVqw5UVswTX+yy2n5qflzSxXhdF6skzZ1qPRKAr5EWCLpHCA5IbVcbTSy+3HcmjmY
         Zl5MSbRRlVxI0Xb7p+hDTfLTdbjcJcWgscQSXq3/9oQ4yuqTs4v38ap8SO34p+J9zG0J
         EItA==
X-Forwarded-Encrypted: i=1; AFNElJ8p9x1qFMFjrKa82GffjAxfDBetDKPSygNS+930QJje1LNrjHdwxpSojixgtrsy9g4AtI1CiWv4SaJBihKR262H@vger.kernel.org
X-Gm-Message-State: AOJu0YylhM88VKPiRIc9Bk6/4++ZDZB5YWNYqXGB1pAyGqAW5Y7ziA3n
	/iDUv6TLHjbx/jMYD8odKuBdOa4K/GnTRuHAGEBW9RKN/BJBHt+R/iKZA8GB8RD7BInQSiPadSw
	SKsSF3MVrsQ==
X-Received: from dyab15.prod.google.com ([2002:a05:693c:830f:b0:2e6:52c7:6f4f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:e882:b0:304:acc:f079
 with SMTP id 5a478bee46e88-30820096c15mr2953444eec.27.1781302363638; Fri, 12
 Jun 2026 15:12:43 -0700 (PDT)
Date: Fri, 12 Jun 2026 15:11:56 -0700
In-Reply-To: <20260612221211.1221305-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260612180956.1105352-1-irogers@google.com> <20260612221211.1221305-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260612221211.1221305-5-irogers@google.com>
Subject: [PATCH v15 04/19] perf data: Add open flag
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

