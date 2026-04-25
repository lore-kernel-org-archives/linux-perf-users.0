Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC96346E78
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 17:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777139361; cv=none; b=U5DmC1YTJ4PD5mBBuOmg+rfnw1XCYJmCKoqgDbUPe1039KIEy0+cmXYd//ms8PIpmzwM+Ko/VP/dt8LuErdkjfttBxDfBBgj6Mjsj0mQrYJTlZPik2CBqMPh4E8pAG3iz0dxULaZz0HQ+pPo4MYz1SYzh9Lrrg3v5bvPVEctdlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777139361; c=relaxed/simple;
	bh=gfLLI2JWYrhGkycbda+k+ahRBIJmlPsVfm7fy7d7O8E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=X0pmM+WPaNKKzWWmu0y7njTInoKlAGpzY0mailC6uOttSwC/XMmMJ3jXPCipobg4FopJlalLUh8OZvslgvk8kG0pEEHJLAqy6nLz8qr27JbyM7z7fCJP+6lyS/JsuNB7iFx/rWA7rQKLTNRqHmkQ7Z29gciHGpkRc0/JHsRjTkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sfnR1r27; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sfnR1r27"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2ba9a744f7dso11617844eec.0
        for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 10:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777139359; x=1777744159; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=22olXlLY2a/aW3iIRalXE3Od5F0yl9bqDC7eX7ett48=;
        b=sfnR1r27d/tu1y4CbxfRpozvfsFpfDyh8CwKMAmecWIoZjNYbCTa4FL1E+57NKTyZ1
         YS02UOGBWA5NtHJldcKer0lglHQyonZI9wuoqdp+fFYTnwCaznxD5TMiBEw+SHhgFhyi
         Z2M9GBYChjPgzEYUf8BDGE3DmOqfOnTRLD8zhYt7t/CCNIgTCbl6TDxhiA5tPTy3thUv
         gnyPBnF3n19HAGMqXuKqF9pyApZ9iBwx1aSA17eqf8ng2hZ2/ZEIaRA/K/9qA819SIOB
         idTfVRAMoI7ec/rVGq9Tygvn3fBjmEODJ3MDQ5Qe7yxMHTfNkXQswB064gbsubLDCj+H
         9B8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777139359; x=1777744159;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=22olXlLY2a/aW3iIRalXE3Od5F0yl9bqDC7eX7ett48=;
        b=sI66d3lzSFLNaHfcyfQM4c6neA2oxWz3EaJSVTBcXflzMjPn+PhR2AATaE3xT6Job6
         BC00ESAPwEsQWZ43MNUdCZznrTe77FG2/xNfpFIzYzJ6ZfxHwrjjDN7vlQXf/v2qOI/O
         hIrnpxUIP7R+5KanmEECQQA6IfWwwZdjvFvqjGsVkdFvM336zQwwFPGZ+6m0SCpP9oRd
         AThKFNroBzHWJ5T/YCEpmZdGYa1KjuJc0N/0BfGyBEx5Ph1xoq+GWIdn1Eu8FxpxL7qE
         m/fOkapBpWd3qFGMG/596WiByLuxU6RTQQ3uzyfcCZC2aVMwXwPpZeZQbWQQ85Z+U/gl
         ewjg==
X-Forwarded-Encrypted: i=1; AFNElJ/bpsOhE8fvo2hkQl5gmJSXWEZvQ4/ZN7He3tIvrTqNrROscLU9m4CLlci2T8BouYgrsc/1hrMFqizP2HIXW8Oy@vger.kernel.org
X-Gm-Message-State: AOJu0YwQBl7+iOH7wRD9XGSEOnjQ9T53SFXaNpndd3BIkdHmVqjuSPvM
	/tkR2LFnaa7ExCyc8zUWNj8KZptroQy75Jl3ZwY7ZawpZUvdJy/5L7kFMOGhjx6s/moboIuVjvh
	PxbY7f7UzyQ==
X-Received: from dyz11.prod.google.com ([2002:a05:693c:408b:b0:2d9:912f:7ec1])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:fe03:b0:2ea:ed29:ab1f
 with SMTP id 5a478bee46e88-2eaed29b8a6mr1930484eec.0.1777139358979; Sat, 25
 Apr 2026 10:49:18 -0700 (PDT)
Date: Sat, 25 Apr 2026 10:48:07 -0700
In-Reply-To: <20260425174858.3922152-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260424164721.2229025-1-irogers@google.com> <20260425174858.3922152-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260425174858.3922152-10-irogers@google.com>
Subject: [PATCH v6 09/59] perf data: Add open flag
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

