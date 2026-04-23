Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCC338229F
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 16:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776962078; cv=none; b=dFDA4w9ZooZIgQNc977eOXvARfJYPPS6Sz2hL7SZXRTc8E8sUDQ09ikkjee9xk/4U9+w4uhGxgV+TExwjCyB7PZyVTayMfluSHtD/brQijPo3q1lT/stwfARJwbxkr0m4KskKqxqEnYwILBtIRYF31uDq7M5/oA4H+7clOzSaUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776962078; c=relaxed/simple;
	bh=Zb64ot1CY7ozMkL+v/djQHF0QpRaH6k4HoY8b22qO3M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=opI+2AHwQ7fGalPJTO8zTgV8L98ExHxOQ2BOzn3hJJ20+aN9dQJeS4z3DuGGdqHPbJWVJ5XdG2ueuNcBdw7K9HNEE30/uuYSrwXqWHBAGglUHPSyG2uLFUqCs8aeUECu9lbyk0G7TIXy4LWFrkNfmkKFVbe7RbPFu29IN+BvK9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uHOnpNpj; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uHOnpNpj"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2c0f6593ef5so8468166eec.1
        for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 09:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776962076; x=1777566876; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Lv7tXJ02CIRSss2k5YcPZwnn2v+gRoVcm/4yvPuX8VM=;
        b=uHOnpNpjZloEBMoOcWZEXVe1fW3ZZ5LEk4JWYoU0Ei70W104+RliVIczSuthXZ6iG7
         +sD6hygoowWN7lYWIoWofM7RTcGD2ojCmcD7OccHjJhTlsjK5pEB9tPyvIUb+nIhIDPN
         /Ij0YqhzWemgOcLpLhi3y4iEoE+T3ho/m8YzPfP8Mwyfkfh+pi2kdqMEmCiXGtGTfEgx
         t5ekWtg4WsCBJD7a8fxI8PGH9cIiDR7jHD1gfomOQYLflRDdHH27XgMfJi9aZB8dDaTT
         oNRw/QwVZuOHVQMWTeiNembZo1PL3lZnO+Aa6UswXcwVreauufBtSK28+hKWL1f5D0Ky
         Nc+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776962076; x=1777566876;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lv7tXJ02CIRSss2k5YcPZwnn2v+gRoVcm/4yvPuX8VM=;
        b=p8dhO638DUFy6CCLH8yM3Mu4h8T+3NAl3sMnPt7/r6yPCkf6SEMWiPLUBBb6hVgbqT
         BDMsrXv6r75+grsTd0bt7xs/K/ZYLpZK44VtIdKUFQjWIFTT9u/rtoDduDS9c9EDFy+e
         fuUKx4FQjE/RdoR4ImrgBXhqaA7ICJuWuP1aIEVSCzorpDX8FCZNWeU/fD6p2SouoZpF
         YvHWsLhRVdvh4OUovXNNWQX2AoViMcf48Uip4gTBhevs54yJ/uQ49yn/UTvBm34ykyio
         7gVKOkVcfOyF2S7osC8j1GQeefJ0uUhITNtpfXnOZTC/VO66eGs+Frnn5Wy5mxiGlJxu
         L+mQ==
X-Forwarded-Encrypted: i=1; AFNElJ83STqyBTs5RSle4Pp+u2Xy7NOedA7FkcgxpNJ4603yaR5zt4cE1uvn/ReCZEH6W8atXybAMdoig4lr6YnHWqpO@vger.kernel.org
X-Gm-Message-State: AOJu0YwlYchh/wbA66VZDiCJmWafJ8kFWTqsf7fp+KN7SBHXXeGotQ8s
	FaSd9HFVHubWvVOGTdXe2zCoSjHwfPPQkHH7zhTtFP4MIIvzcPMinmsSHD/UCzl/dZEOYtFR9sS
	FNBrUfas/9Q==
X-Received: from dybmd39.prod.google.com ([2002:a05:7301:1827:b0:2de:ed01:5510])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:2393:b0:2d9:6f2f:9f6f
 with SMTP id 5a478bee46e88-2e483d82ddbmr16347307eec.24.1776962075403; Thu, 23
 Apr 2026 09:34:35 -0700 (PDT)
Date: Thu, 23 Apr 2026 09:33:17 -0700
In-Reply-To: <20260423163406.1779809-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260423161006.1762700-1-irogers@google.com> <20260423163406.1779809-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260423163406.1779809-10-irogers@google.com>
Subject: [PATCH v4 09/58] perf data: Add open flag
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

