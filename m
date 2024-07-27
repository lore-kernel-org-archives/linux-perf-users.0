Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F004B188CDB
	for <linux-perf-users@vger.kernel.org>; Mon, 29 Jul 2024 16:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722271579; cv=none; b=RDKVXuaJPzFa6BsMnBRBPrI0/pKlTEgq9esV+hEKbvwmBzAovDmFbQErHWsRP98eQ3QZGxVmNjsaTbBrVwfjQGaA7VFkUppi9wt8Zj9Di0EFpy41hPjlVqIza4xPSYc5ugf0Yk7JfdGk5tDt2xrESl6uu9CJGOmAjhOOdtDObRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722271579; c=relaxed/simple;
	bh=etOVA7exvPfFTzoKY8Fso7Jdm7CkckVi5SBT4zKGBQQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FLtWjgIWk3hG6F0CZmCAXL4sW13NgTJNGQm9+3k0Q5HsKe8yjJr64EQokyFlTYwkNmTHOvC5G0AuQFz2WuQ4/PD2kqHg0CwGJXlahAh8sqehE7ArGg6WQo62bSuEJ7Dtw/gpszpph0pzf9CAWzR4bBmBGEUMLZwd1vBuyJcSbgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=si/D5Nw5; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="si/D5Nw5"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1fd6ed7688cso22650505ad.3
        for <linux-perf-users@vger.kernel.org>; Mon, 29 Jul 2024 09:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1722271576; x=1722876376; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TiJ7fM85IMGMjgBBVYYw2ZNteCJKvpwjrHE2P481mUM=;
        b=si/D5Nw5bXzZWCnofDgsL7pgSb1ARcMF2ZLz8CGawwrDXFSeujISVWosTh1pWrwwgi
         Y5SLPzHYOEIbdm8DA56jrh2iGxIy6gr3J2fi0DQDhUy6/pugFDg4pRZa/QTstt2prcE5
         1LELcbFNQy+dBWO1/Os5CFWfOjRP5TKdzcpZ529TX7PxotrQhoMTnew07+/LzswPEdPp
         R2woQPlsInLrY1WJEbLfM1a8zBltJ8OLvwN2QFP5q+Mi7BJJOoLNN1qI/2M7EPs6a7hj
         +frRa4BkHh1Ngzw7N+CKCdEpoSyoKMDbavgj9LT9b8+vWUj/YuQE1DQrlZYpua2wSmrF
         TwQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722271576; x=1722876376;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TiJ7fM85IMGMjgBBVYYw2ZNteCJKvpwjrHE2P481mUM=;
        b=CtEVUhRlSjn7nUMcN9cwElJTn09g3OXl9w9lcN82qcW0vd+6g/z1HKEwyh3+jikh/J
         TfrNXHwy3RkUs6NZ9Sy0W8OZ3kIqc1wGr0O3ZV4dqU+yNPubsQbAl9OtFUJs/6VD7WLk
         EnDqNfzkICMinl/Eucc6OR/Kn3uyF/MK3cDz1CIqPbMxiytQglDMlPJDmbEDWL/LErPM
         Udoc8d4HvlMsvkD6VRUcuz/R/wnuTpjNxwWCeOb4NIAIlS3ho9hHUEAVO53p5yQnLmrD
         iSgjo0Sl8lzGO725nL/DKVFALmImjeiqL8t5kkDOFfjJ54nwybg9DQvl8niSLvCuEOZ/
         4sRg==
X-Gm-Message-State: AOJu0YwGgN1HyH3hzgtj9qvS0wZzfVyJrCKlfYmVHw5TAx3EFpyM0Xxt
	EDqX04VkEGcyVDNAcGjKqw52yf3qxBdi1/Usmb5ZM19jWKKRrcwAwvU4VMVrnhI=
X-Google-Smtp-Source: AGHT+IFhuipRzGKQii+jATiqJQQJZtOk5vz10sHKaqUAKhBj4Dqb4RoBXjOU9eIeu9ns2+sh073puA==
X-Received: by 2002:a17:903:1245:b0:1fb:3e8c:95a6 with SMTP id d9443c01a7336-1ff048e59c8mr60825725ad.40.1722271576219;
        Mon, 29 Jul 2024 09:46:16 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7d401c6sm85480545ad.117.2024.07.29.09.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 09:46:15 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Fri, 26 Jul 2024 22:29:36 -0700
Subject: [PATCH v2 6/8] libperf: Add perf_evsel__{refresh, period}()
 functions
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240726-overflow_check_libperf-v2-6-7d154dcf6bea@rivosinc.com>
References: <20240726-overflow_check_libperf-v2-0-7d154dcf6bea@rivosinc.com>
In-Reply-To: <20240726-overflow_check_libperf-v2-0-7d154dcf6bea@rivosinc.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, Charlie Jenkins <charlie@rivosinc.com>, 
 Shunsuke Nakamura <nakamura.shun@fujitsu.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722271564; l=6171;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=aVBjIsxJT8LS4fAGhXq/xpQCeYcYwi9ufo4Vs2pLLv0=;
 b=4ordREpvBQFF9nRLjzkG5AYtTDom9kp+2J+geJhO9Yp6HMv/+UWcHQtAxs9+iatyKJaqco8NC
 SpRNHVe7k69ClWIp01TemQTm7dk2bf/Zfb5bcN84iq/MmtiCHsCmzla
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

From: Shunsuke Nakamura <nakamura.shun@fujitsu.com>

Add the following functions:

  perf_evsel__refresh()
  perf_evsel__period()

to set the over flow limit and period.

Signed-off-by: Shunsuke Nakamura <nakamura.shun@fujitsu.com>
Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 tools/lib/perf/Documentation/libperf.txt |  2 ++
 tools/lib/perf/evsel.c                   | 46 ++++++++++++++++++++++++++------
 tools/lib/perf/include/perf/evsel.h      |  2 ++
 tools/lib/perf/libperf.map               |  2 ++
 4 files changed, 44 insertions(+), 8 deletions(-)

diff --git a/tools/lib/perf/Documentation/libperf.txt b/tools/lib/perf/Documentation/libperf.txt
index f1bfe6b6e78a..aac764e63db6 100644
--- a/tools/lib/perf/Documentation/libperf.txt
+++ b/tools/lib/perf/Documentation/libperf.txt
@@ -162,6 +162,8 @@ SYNOPSIS
   int perf_evsel__disable(struct perf_evsel *evsel);
   int perf_evsel__disable_cpu(struct perf_evsel *evsel, int cpu_map_idx);
   bool perf_evsel__has_fd(struct perf_evsel *evsel, int fd);
+  int perf_evsel__refresh(struct perf_evsel *evsel, int refresh);
+  int perf_evsel__period(struct perf_evsel *evsel, int period);
   struct perf_cpu_map *perf_evsel__cpus(struct perf_evsel *evsel);
   struct perf_thread_map *perf_evsel__threads(struct perf_evsel *evsel);
   struct perf_event_attr *perf_evsel__attr(struct perf_evsel *evsel);
diff --git a/tools/lib/perf/evsel.c b/tools/lib/perf/evsel.c
index 6b98cba6eb4f..063498fc52f2 100644
--- a/tools/lib/perf/evsel.c
+++ b/tools/lib/perf/evsel.c
@@ -418,7 +418,7 @@ int perf_evsel__read(struct perf_evsel *evsel, int cpu_map_idx, int thread,
 	return 0;
 }
 
-static int perf_evsel__ioctl(struct perf_evsel *evsel, int ioc, void *arg,
+static int perf_evsel__ioctl(struct perf_evsel *evsel, int ioc, unsigned long arg,
 			     int cpu_map_idx, int thread)
 {
 	int *fd = FD(evsel, cpu_map_idx, thread);
@@ -430,7 +430,7 @@ static int perf_evsel__ioctl(struct perf_evsel *evsel, int ioc, void *arg,
 }
 
 static int perf_evsel__run_ioctl(struct perf_evsel *evsel,
-				 int ioc,  void *arg,
+				 int ioc, unsigned long arg,
 				 int cpu_map_idx)
 {
 	int thread;
@@ -447,7 +447,7 @@ static int perf_evsel__run_ioctl(struct perf_evsel *evsel,
 
 int perf_evsel__enable_cpu(struct perf_evsel *evsel, int cpu_map_idx)
 {
-	return perf_evsel__run_ioctl(evsel, PERF_EVENT_IOC_ENABLE, NULL, cpu_map_idx);
+	return perf_evsel__run_ioctl(evsel, PERF_EVENT_IOC_ENABLE, 0, cpu_map_idx);
 }
 
 int perf_evsel__enable_thread(struct perf_evsel *evsel, int thread)
@@ -457,7 +457,7 @@ int perf_evsel__enable_thread(struct perf_evsel *evsel, int thread)
 	int err;
 
 	perf_cpu_map__for_each_cpu(cpu, idx, evsel->cpus) {
-		err = perf_evsel__ioctl(evsel, PERF_EVENT_IOC_ENABLE, NULL, idx, thread);
+		err = perf_evsel__ioctl(evsel, PERF_EVENT_IOC_ENABLE, 0, idx, thread);
 		if (err)
 			return err;
 	}
@@ -471,13 +471,13 @@ int perf_evsel__enable(struct perf_evsel *evsel)
 	int err = 0;
 
 	for (i = 0; i < xyarray__max_x(evsel->fd) && !err; i++)
-		err = perf_evsel__run_ioctl(evsel, PERF_EVENT_IOC_ENABLE, NULL, i);
+		err = perf_evsel__run_ioctl(evsel, PERF_EVENT_IOC_ENABLE, 0, i);
 	return err;
 }
 
 int perf_evsel__disable_cpu(struct perf_evsel *evsel, int cpu_map_idx)
 {
-	return perf_evsel__run_ioctl(evsel, PERF_EVENT_IOC_DISABLE, NULL, cpu_map_idx);
+	return perf_evsel__run_ioctl(evsel, PERF_EVENT_IOC_DISABLE, 0, cpu_map_idx);
 }
 
 int perf_evsel__disable(struct perf_evsel *evsel)
@@ -486,7 +486,37 @@ int perf_evsel__disable(struct perf_evsel *evsel)
 	int err = 0;
 
 	for (i = 0; i < xyarray__max_x(evsel->fd) && !err; i++)
-		err = perf_evsel__run_ioctl(evsel, PERF_EVENT_IOC_DISABLE, NULL, i);
+		err = perf_evsel__run_ioctl(evsel, PERF_EVENT_IOC_DISABLE, 0, i);
+	return err;
+}
+
+int perf_evsel__refresh(struct perf_evsel *evsel, int refresh)
+{
+	int i;
+	int err = 0;
+
+	for (i = 0; i < xyarray__max_x(evsel->fd) && !err; i++)
+		err = perf_evsel__run_ioctl(evsel, PERF_EVENT_IOC_REFRESH, refresh, i);
+	return err;
+}
+
+int perf_evsel__period(struct perf_evsel *evsel, __u64 period)
+{
+	struct perf_event_attr *attr;
+	int i;
+	int err = 0;
+
+	attr = perf_evsel__attr(evsel);
+
+	for (i = 0; i < xyarray__max_x(evsel->fd); i++) {
+		err = perf_evsel__run_ioctl(evsel, PERF_EVENT_IOC_PERIOD,
+					    (unsigned long)&period, i);
+		if (err)
+			return err;
+	}
+
+	attr->sample_period = period;
+
 	return err;
 }
 
@@ -497,7 +527,7 @@ int perf_evsel__apply_filter(struct perf_evsel *evsel, const char *filter)
 	for (i = 0; i < perf_cpu_map__nr(evsel->cpus) && !err; i++)
 		err = perf_evsel__run_ioctl(evsel,
 				     PERF_EVENT_IOC_SET_FILTER,
-				     (void *)filter, i);
+				     (unsigned long)filter, i);
 	return err;
 }
 
diff --git a/tools/lib/perf/include/perf/evsel.h b/tools/lib/perf/include/perf/evsel.h
index 77816a35c383..613a63790346 100644
--- a/tools/lib/perf/include/perf/evsel.h
+++ b/tools/lib/perf/include/perf/evsel.h
@@ -63,6 +63,8 @@ LIBPERF_API int perf_evsel__enable(struct perf_evsel *evsel);
 LIBPERF_API int perf_evsel__enable_cpu(struct perf_evsel *evsel, int cpu_map_idx);
 LIBPERF_API int perf_evsel__enable_thread(struct perf_evsel *evsel, int thread);
 LIBPERF_API int perf_evsel__disable(struct perf_evsel *evsel);
+LIBPERF_API int perf_evsel__refresh(struct perf_evsel *evsel, int refresh);
+LIBPERF_API int perf_evsel__period(struct perf_evsel *evsel, __u64 period);
 LIBPERF_API int perf_evsel__disable_cpu(struct perf_evsel *evsel, int cpu_map_idx);
 LIBPERF_API struct perf_cpu_map *perf_evsel__cpus(struct perf_evsel *evsel);
 LIBPERF_API struct perf_thread_map *perf_evsel__threads(struct perf_evsel *evsel);
diff --git a/tools/lib/perf/libperf.map b/tools/lib/perf/libperf.map
index f68519e17885..12bdf2f43993 100644
--- a/tools/lib/perf/libperf.map
+++ b/tools/lib/perf/libperf.map
@@ -35,6 +35,8 @@ LIBPERF_0.0.1 {
 		perf_evsel__munmap;
 		perf_evsel__mmap_base;
 		perf_evsel__read;
+		perf_evsel__refresh;
+		perf_evsel__period;
 		perf_evsel__cpus;
 		perf_evsel__threads;
 		perf_evsel__attr;

-- 
2.44.0

