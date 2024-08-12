Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A051D194152
	for <linux-perf-users@vger.kernel.org>; Mon, 12 Aug 2024 20:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723495668; cv=none; b=Y6rYerX28omCJjXMTQJpybUXJEnjl4O1PdvydvYvGAmIvnrDA6wlxSar3i9CPZW+w3mI/kD/eBnMn5CNjNXPEDsUxH/MSInnxM0HBlLM9u4G62qtlrnjsxIzZNbxvGR0x18ZD6KQri2ltriuAp1stCF1NpLUgt4Tsk/R+fnS25w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723495668; c=relaxed/simple;
	bh=Qrok1azG7UxnWaLySV6ZsE5DB8YS3BiC3PmFMnVvQAA=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=BRzzp7vif1WeSRzmyYijlszpZgFW9J7KIn7tPrPzZSYrfJjXyTaaYLbJZW8Tgz49T/tQMyZQ0835yYD5yg3oQE+1PKEz5Z7rLGqorSGTEP3+g2G28rWN2El4WLyBUorfNhi06gaaLzpaGomz209ki2VZGZvqfoI8SGErTOFFa4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AwPm+EHH; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AwPm+EHH"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-690404fd34eso117537917b3.1
        for <linux-perf-users@vger.kernel.org>; Mon, 12 Aug 2024 13:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723495665; x=1724100465; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gibdVPBI4QwODB2QVabO7wcogY6JGDVcaHEIkpe2Azo=;
        b=AwPm+EHHOIl64NO3n+8ug+lvDBjwVMerhy508QgjaFdHjzCHmzOUBnzqvKrq4nONuV
         MjLY4xAA1uRcitkBE37n+Zvi9M1xKyCOtjJlJaeHNtBSjL4tpcMCnqwpCEilzZwoL3SP
         ebt7aKgabkMDwttrTSvvhYKMrSRwafUdwL6SbWxJXknGy3OTvonSGRzWaW/USQ3R6EM/
         nuyvxS5hG6zUGcc/cSJEH6ZzaEYXv8+pwi0w0y+TWB5xf7zEN5ShUWptzvFOBrU9v8b1
         U2rkwk8c7DmHX7/6tFUyVutC2JeRHtFXG5eEC7vlMJJRmEZqLaPc+YIeZR57QYzUzHJ3
         S5IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723495665; x=1724100465;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gibdVPBI4QwODB2QVabO7wcogY6JGDVcaHEIkpe2Azo=;
        b=Ras4VDj4cKTJIhk2MiWstlXE4Xm107AzP4p0dLWSscRom6lqqj2png8TShmBygSgM0
         1Oq/nomQdFMGKHwak87ZxZTjDn5EBaIRpvRrdZ0bkGYG1w2vMlIjukxC2/J/jGpSe9SP
         X/fveCHUF83fl2ZZkaGfiUo3u44/Wv76/iUv1JjDwu+L7O+7QOiOXx3AN1+LNXExLUpi
         Zh6h2rg6WQXTCGaER2U0fCv2/B5m8/euTMYy3f/LNoK9cKuq+bF7FXspv1uzsYwFLuoW
         cDfjG7F/Si7zUlxsr3tFhF+CTHil5U10o5P23PlWrzcmFgUqaEFLeyZoM9zMX7ehHvDP
         HW9g==
X-Forwarded-Encrypted: i=1; AJvYcCXHzMURb/tj0XSAH7eny+TD9f2zB2e1LrenAwE3fhwKOiD01f1L10M0AjpThNdCUIWjU00iskTEX9g4PhInwe3xqjzfDMFJG+TPlMGo7FqRGg==
X-Gm-Message-State: AOJu0Yz2autefa3bx4m2OAjYP/K77VNkmWc6P12kYi/AZ86AcKjXgI6a
	ayb673hSb22J1Z98+8ovPXZktH6AzH756nhSGOngY0NjK5ofWRGm05dqHWHISdsP8uiqeeiMwF/
	1cbU8Mg==
X-Google-Smtp-Source: AGHT+IGcoDxlV6ReTDwa/pGeVDkEANIGIX3sSvxNGP6KX8/qg5oXdLKJGk56Ow4wd4MdzjIcDYZvPHQNsid+
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:e7f1:b90:720c:35bf])
 (user=irogers job=sendgmr) by 2002:a0d:c303:0:b0:61c:89a4:dd5f with SMTP id
 00721157ae682-6a96c6090efmr432737b3.0.1723495665556; Mon, 12 Aug 2024
 13:47:45 -0700 (PDT)
Date: Mon, 12 Aug 2024 13:47:01 -0700
In-Reply-To: <20240812204720.631678-1-irogers@google.com>
Message-Id: <20240812204720.631678-10-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240812204720.631678-1-irogers@google.com>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Subject: [PATCH v7 09/27] perf lock: Use perf_tool__init
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@arm.com>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Nick Terrell <terrelln@fb.com>, 
	Nick Desaulniers <ndesaulniers@google.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Song Liu <song@kernel.org>, 
	Ilkka Koskinen <ilkka@os.amperecomputing.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Yanteng Si <siyanteng@loongson.cn>, 
	Sun Haiyong <sunhaiyong@loongson.cn>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Use perf_tool__init so that more uses of struct perf_tool can be const
and not relying on perf_tool__fill_defaults.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-lock.c | 37 ++++++++++++++++++-------------------
 1 file changed, 18 insertions(+), 19 deletions(-)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index 6efa9d646637..2c216427e929 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -1933,22 +1933,21 @@ static bool force;
 static int __cmd_report(bool display_info)
 {
 	int err = -EINVAL;
-	struct perf_tool eops = {
-		.attr		 = perf_event__process_attr,
-		.event_update	 = process_event_update,
-		.sample		 = process_sample_event,
-		.comm		 = perf_event__process_comm,
-		.mmap		 = perf_event__process_mmap,
-		.namespaces	 = perf_event__process_namespaces,
-		.tracing_data	 = perf_event__process_tracing_data,
-		.ordered_events	 = true,
-	};
+	struct perf_tool eops;
 	struct perf_data data = {
 		.path  = input_name,
 		.mode  = PERF_DATA_MODE_READ,
 		.force = force,
 	};
 
+	perf_tool__init(&eops, /*ordered_events=*/true);
+	eops.attr		 = perf_event__process_attr;
+	eops.event_update	 = process_event_update;
+	eops.sample		 = process_sample_event;
+	eops.comm		 = perf_event__process_comm;
+	eops.mmap		 = perf_event__process_mmap;
+	eops.namespaces		 = perf_event__process_namespaces;
+	eops.tracing_data	 = perf_event__process_tracing_data;
 	session = perf_session__new(&data, &eops);
 	if (IS_ERR(session)) {
 		pr_err("Initializing perf session failed\n");
@@ -2069,15 +2068,7 @@ static int check_lock_contention_options(const struct option *options,
 static int __cmd_contention(int argc, const char **argv)
 {
 	int err = -EINVAL;
-	struct perf_tool eops = {
-		.attr		 = perf_event__process_attr,
-		.event_update	 = process_event_update,
-		.sample		 = process_sample_event,
-		.comm		 = perf_event__process_comm,
-		.mmap		 = perf_event__process_mmap,
-		.tracing_data	 = perf_event__process_tracing_data,
-		.ordered_events	 = true,
-	};
+	struct perf_tool eops;
 	struct perf_data data = {
 		.path  = input_name,
 		.mode  = PERF_DATA_MODE_READ,
@@ -2100,6 +2091,14 @@ static int __cmd_contention(int argc, const char **argv)
 
 	con.result = &lockhash_table[0];
 
+	perf_tool__init(&eops, /*ordered_events=*/true);
+	eops.attr		 = perf_event__process_attr;
+	eops.event_update	 = process_event_update;
+	eops.sample		 = process_sample_event;
+	eops.comm		 = perf_event__process_comm;
+	eops.mmap		 = perf_event__process_mmap;
+	eops.tracing_data	 = perf_event__process_tracing_data;
+
 	session = perf_session__new(use_bpf ? NULL : &data, &eops);
 	if (IS_ERR(session)) {
 		pr_err("Initializing perf session failed\n");
-- 
2.46.0.76.ge559c4bf1a-goog

