Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB97388E68
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 16:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776960628; cv=none; b=IfeswVvnh0mYsQNGZdildL75ejVzUWh1gmPxILYkZiAx42iHAHW7txwq7ZmnQJ3abxgSQS0qiSiUDoqO4AfiqxhniUsnx7FOGjkuTSISA5bnQ2v1DU50FquAxXesvjHIPihMzh8XVO8kmIqJ+Uxt0Hv/l5gOQBZAhLXVpJuLp14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776960628; c=relaxed/simple;
	bh=Zb64ot1CY7ozMkL+v/djQHF0QpRaH6k4HoY8b22qO3M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SGjVVswat3JZ7VedbOpuj4HveHPs4Wa/GeFgfMQ+27vQqwTTmbyDJoeMcRlV1H6/lhWPZz/5CSixBikODRQo/KoBBZHgPQ2iMO3XBJNDj5WwTe2kC9CSpcWQ8b2Gxx4d/q9mHvxSUqMOyp0bWI8pKQj1cfUrIn/7H+9eNjrhClE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lfSgNlIT; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lfSgNlIT"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2c0f6593ef5so8433314eec.1
        for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 09:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776960626; x=1777565426; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Lv7tXJ02CIRSss2k5YcPZwnn2v+gRoVcm/4yvPuX8VM=;
        b=lfSgNlIT9CC0Tr5jHwkwbAG0mM2uiQU7NYm8W8yimmwfcCfmL2zHMOcoDOXHIOrQDr
         TD5ofSbKKP5+dWpXCB2tID2BKbXvPw6LJV4qqEakpOl64lvxgbMUJ2mONGPtMcyeSzcb
         yrEAqbD7WhwWJm9cmnmaEng8UzCrchmnDbYxk7H08KlqguTbUKeIjVoaU0+oCh2MN1NO
         wHQXZ1CvbfD5GhEczd+OE9+7HDp1g+0K1UsUp5fAlP9wBD7i6/6nG1Ml3ukjfW4EdPy2
         BRyMv2AyOGccboc/fUFoMx+YW02EVNxViLwRArnCVUIaojXXeNimXALNCVG+6WDdboLb
         W9Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776960626; x=1777565426;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lv7tXJ02CIRSss2k5YcPZwnn2v+gRoVcm/4yvPuX8VM=;
        b=gBVrW1eK8+FT8OHGwwYKMAZYOmng++dTCUJDuJPeVzkpF8lhdC5lR83fnHx2yNQqZG
         pGMadINLS/H1PHNqdi/6SzOqL4FN8y4MIESmvJ+cnPwIiuEzJpfCzHer/0ilXiQX5Cu7
         kQT+fy4dEqKt6HWTdWHWv49Z3j7Nfz9NoXsZwVf+tiIMlA6BdxsEJmdfJPWRkDXpayu6
         js8ZJlaJL1Mshqv+fLDNJ9a28rC6gO+g0YnGfDpI8RrQyi/u54aNCNGKIeUJy8hzOBso
         75fa8kmh3BzseHM8pdyW7c3upNuVsI3IMVuo1dIiMmKjRBlXDVCQ/n0IKUgpR2xzvQ67
         a1Xw==
X-Forwarded-Encrypted: i=1; AFNElJ+XPup0cfyfynowTswBIied5zxqGwYAFHUaLW03cLa7t8lB5OZwE15xRIQKTZLFyfHe3a8109IrEjRi8YUFLP7R@vger.kernel.org
X-Gm-Message-State: AOJu0YyU5sd6XvF+w1HBS9gXknQZXB9DB62gGfSJHdIv9V3hP66CXEP2
	HU/MgvRhcHlg+bvM9UEw4rOxhi0WIhnlkFBjBvMUkwlgITCQ0T14A4QuZA0n9T+LHz3JnFzSh7L
	F7UVJLIerJQ==
X-Received: from dyckg11.prod.google.com ([2002:a05:7301:d18b:b0:2e8:5e04:ef25])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:2c86:b0:2da:1874:f3bb
 with SMTP id 5a478bee46e88-2e47a103c2fmr14634642eec.23.1776960625559; Thu, 23
 Apr 2026 09:10:25 -0700 (PDT)
Date: Thu, 23 Apr 2026 09:09:15 -0700
In-Reply-To: <20260423161006.1762700-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260423035526.1537178-1-irogers@google.com> <20260423161006.1762700-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.rc2.533.g4f5dca5207-goog
Message-ID: <20260423161006.1762700-9-irogers@google.com>
Subject: [PATCH v3 08/58] perf data: Add open flag
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, adrian.hunter@intel.com, 
	james.clark@linaro.org, leo.yan@linux.dev, namhyung@kernel.org, 
	tmricht@linux.ibm.com
Cc: 9erthalion6@gmail.com, adityab1@linux.ibm.com, 
	alexandre.chartre@oracle.com, alice.mei.rogers@gmail.com, 
	ankur.a.arora@oracle.com, ashelat@redhat.com, atrajeev@linux.ibm.com, 
	blakejones@google.com, changbin.du@huawei.com, chuck.lever@oracle.com, 
	collin.funk1@gmail.com, coresight@lists.linaro.org, ctshao@google.com, 
	dapeng1.mi@linux.intel.com, derek.foreman@collabora.com, dsterba@suse.com, 
	gautam@linux.ibm.com, howardchu95@gmail.com, john.g.garry@oracle.com, 
	jolsa@kernel.org, jonathan.cameron@huawei.com, justinstitt@google.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mike.leach@arm.com, mingo@redhat.com, 
	morbo@google.com, nathan@kernel.org, nichen@iscas.ac.cn, 
	nick.desaulniers+lkml@gmail.com, pan.deng@intel.com, peterz@infradead.org, 
	ravi.bangoria@amd.com, ricky.ringler@proton.me, stephen.s.brennan@oracle.com, 
	sun.jian.kdev@gmail.com, suzuki.poulose@arm.com, swapnil.sapkal@amd.com, 
	tanze@kylinos.cn, terrelln@fb.com, thomas.falcon@intel.com, 
	tianyou.li@intel.com, tycho@kernel.org, wangyang.guo@intel.com, 
	xiaqinxin@huawei.com, yang.lee@linux.alibaba.com, yuzhuo@google.com, 
	zhiguo.zhou@intel.com, zli94@ncsu.edu
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
2.54.0.rc2.533.g4f5dca5207-goog

