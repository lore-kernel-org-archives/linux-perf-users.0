Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190C639021C
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 22:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777156911; cv=none; b=KCxRpBavWdA1ns+Uh/FYXQUDgb+GnuwIydF5lK9WxET5iyqDbWQZFiSG90j20GVm2BmFDfkOi49WNyTufOT4lfgT98WG4tmrhew3kHXtcgUSyfDG68fo6TolyvocQ9EwxcyUnnZQoEtqwtisT3ztI7Cdyej6tBTf3dT3dIEqMFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777156911; c=relaxed/simple;
	bh=gfLLI2JWYrhGkycbda+k+ahRBIJmlPsVfm7fy7d7O8E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KUZDDQKtgUyk9oj8dAlkGbu4kXSbqs8OUXuAhPot1cLU29bMxsYRF4Lxb+8KGXca9ArhUG7LcAJtavVAGOT0FrZvbqlDRRAuS3WS/4TShREHADFFIr7MbDSz8RHT+MPqv8LtAbWzMQvv8wVPRQ8dZyH3/Rb3Ph/fMtOySsh7DgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S+sTv+wB; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S+sTv+wB"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-12c726f4055so9216737c88.1
        for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 15:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777156909; x=1777761709; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=22olXlLY2a/aW3iIRalXE3Od5F0yl9bqDC7eX7ett48=;
        b=S+sTv+wB48Ve+zyBlJSmwmD37IgUf2TN2U4rVF6RBmG7wQC0uzmpJvYYPMTaTHshrE
         Y6fxlc0WvWIV0yXLLiIBfFfCG8r0gYRpI8d41c5jS1WhgGvwhnyGNeTmQPJAskNTix/c
         YwTvK2TJLEYP6E17JCP8Hy+ZINuqNon9Fm37w2T8Sh+Hfa9E9ChnWDh1n+cDw+RbLuy2
         8uZRVEynKexZKPs003XKESj06JQa3DnAJ/hqmhpjGq0FGgTc+aosTOWtjgmX31hJPwE6
         oFQ7PaRaWz/0Cm5VUaIrZsU8r+Cyj07ilAPQNL6m0lFi02VRG2Y+KT//D2PjHRzc1vUN
         C2sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777156909; x=1777761709;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=22olXlLY2a/aW3iIRalXE3Od5F0yl9bqDC7eX7ett48=;
        b=k82yn+KcvTnPVQaL4E7XwVoIECt4iGT57gFIAPk3js76qU/J/t2Dhso2dr9Pdx2s/y
         c+58aMBO9gkZ7+WRIrxjSu0+5A2+EzZVDrV0NEZz2jqvtLpUTo9GItx57Sca15bmYOm/
         l3TlMtfVQRV1R9Jbz5fGVf1WkX2fYgx5FhiCnqlEeigODU5tlY4NeikXedfxZdJH0Mfe
         bLy0PxpIDYo3b0Zq8OelmqYtC0EDuNprqtvkgXR9MdV1U+69OuFFmbBOAb0shDlCekkk
         thxetGpGpULxXMQLzfiavt35sNYjBvrYRvU1A+Zglt6ZHlyA7M57Z7AtQQbPkTY6rAF1
         QO+A==
X-Forwarded-Encrypted: i=1; AFNElJ8ho8QFDpy7S/rOUqSRjixlCTGv0q+AyFQ2s6xxd9fJ+N5XrCkPoJJhrmb6PxRFtOJV7BIJAWH+RpLbPMBAOnQE@vger.kernel.org
X-Gm-Message-State: AOJu0YyNlUA4NNbwj+b56xzQ0q27jrnn7m3BDY0A9J2Crb+bU9AlZYlq
	voAGU5wFfZqNyVy/Fk8Bk8eXCMgQlpa3+JiM3Of5hT4Z6bWx4IPYEStR0bg02ZQ2pWxc52TDFZ8
	iGnEwPHPh0Q==
X-Received: from dlbbs39.prod.google.com ([2002:a05:7022:927:b0:12c:8b66:5a8d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6b99:b0:12c:2dd7:9099
 with SMTP id a92af1059eb24-12c73f9fb84mr20495568c88.30.1777156909066; Sat, 25
 Apr 2026 15:41:49 -0700 (PDT)
Date: Sat, 25 Apr 2026 15:40:34 -0700
In-Reply-To: <20260425224125.160890-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260425174858.3922152-1-irogers@google.com> <20260425224125.160890-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260425224125.160890-10-irogers@google.com>
Subject: [PATCH v7 09/59] perf data: Add open flag
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

