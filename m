Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814E1389111
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 03:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776916558; cv=none; b=iWR/LUid4ebyIOAAazFNF9gUdXxa7PteT6sTN4UwND1zTCkLlNZ+62LRrCioRBZwjYJdN/jlcIoLHro9vCgSiTMS/X2MgwCUs89ajm0eXPSUPkQVvDtGxuKsT8aUHbffh45xIjuZDFx6L3MoevHsa33Zv/T+SyL/ojgNUlxCt/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776916558; c=relaxed/simple;
	bh=Zb64ot1CY7ozMkL+v/djQHF0QpRaH6k4HoY8b22qO3M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Q+aB/hnxT3UPk1UGfWV8J9kJxCwFGN/nm+CBlVchc/EM20owJk7AopgMUg93VDYsrpWvGhOnSmpkVU04VUU6oNO/9tQFA9iOwvcHq75UcYCdBOg7zrHCywk1tOWkpi3rp+sTuNLlo70kGmGBKifeipV2nW1I5wpd8hndlT/gNnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=no4dycXC; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="no4dycXC"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2c16233ee11so8466819eec.1
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Apr 2026 20:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776916556; x=1777521356; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Lv7tXJ02CIRSss2k5YcPZwnn2v+gRoVcm/4yvPuX8VM=;
        b=no4dycXCx/Uhwihcm4XtWdIok3aqSb9vNqnDSYmya9waZ4+vFeLAhvad0EGY34PqFN
         Qtz5ojevtqEdxP3k8+pbc9A2iyZTadid15BGFfJDP6ZzEQNYzCVNihaZmrqHk58C3Cal
         uglnGvbb8ekhLlB5D3MYmKXTMWsfGdzF4gBUlpksslTCb6U6JaMN42cSxZ+KRlz3qL/R
         dwnrCUwzqGN7S+UtLMIXtshWxrtgTfwElUFKly7y5AFP6Qdn7WjE3no2AG9v/h7PcVci
         lY900+C4eqKTSMpBWxcr+ub4/V74TC6U0r8eRHpzr4FlTkFI27UOh2W0E8CXAA1qvrQ9
         rx2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776916556; x=1777521356;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lv7tXJ02CIRSss2k5YcPZwnn2v+gRoVcm/4yvPuX8VM=;
        b=dUlwClAHhdwp+wcOoH0I1psukmX/7RXE1Q12Ayyl1kJTIHM25FlZtDJfLIKd8UafGu
         GJoCtOmXSS35Mk0o1t8khR/tyUY5S0+BGeTSJZlGHDeguNtpMKJHDRANYF1C9opBwts8
         wB8Uwm7OLLG+I10tGeIELwav7V4zhGoVQsDxou/O1eCaRF8J0M6SCKIteJfFduMpLj4o
         dgiYG+EjOXhi/LKdI8beQS23gtCSev5uoAMboDcJGVeQrxgsQlKT4u/+w/6qkI4oWoTJ
         8HeeyzcpOEGQl5lLLLBwvFVQlRE9SlOIENpW3TEvklbhc9F46NoqY+fP/wV+mXrzMVhN
         JQ0Q==
X-Forwarded-Encrypted: i=1; AFNElJ/hIph1pq9F2XSE/qZFQ1A7RxgZ0ryACt0p9Vhz37yeLTc+5/PqzsD2XROJJzsX/cSKgVb1Odv4BqkIEOPqM0V0@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh+/BhQQPQcW5NztTvmHPMqe/whcgTLCkNRVYhazE56Yo4Tuj6
	F1xGtXWWPhCI7KW2cT4vqGeWMjf9BqTm5MoD2M/KmGphOpNZR5IfMdbYA3KTbDsFWDvFTnwowXx
	q4Bh3GbliGg==
X-Received: from dyblf37.prod.google.com ([2002:a05:7301:a25:b0:2da:4e8f:1752])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:2c84:b0:2da:44ac:6d17
 with SMTP id 5a478bee46e88-2e47873bd2cmr14888100eec.17.1776916555482; Wed, 22
 Apr 2026 20:55:55 -0700 (PDT)
Date: Wed, 22 Apr 2026 20:54:36 -0700
In-Reply-To: <20260423035526.1537178-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260419235911.2186050-27-irogers@google.com> <20260423035526.1537178-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.rc2.533.g4f5dca5207-goog
Message-ID: <20260423035526.1537178-10-irogers@google.com>
Subject: [PATCH v2 09/58] perf data: Add open flag
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

