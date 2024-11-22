Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3090217C7C6;
	Fri, 22 Nov 2024 04:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732250342; cv=none; b=ejnBJuKJbPBd5guPUtpOpUy0FFyzgbYR04WGNwOkeV7KqKgzR/WM/BfMQ2gcNWDhAr7GHiL0Kmx83g6lwtAnQYs0S3IRqUK+XqANb0k+ypmbpB6UAJhYAVa2ofMDImq5sHOXLawJTqT1Fz6hLMzBMZgI6lokKDMVoV5ikHDCL50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732250342; c=relaxed/simple;
	bh=goTdjk11qmBk6a5P1AA+giS5yljV5oLTjYAh1YgVF+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PyCXMqJAK9pLvXNU2nvQCvmoqT8Clu0+xyjn/jwo+BJIYSIE+idAawQ8TKp1R/4EZ9Mc0SxQpHbUMS/uy0YfYtA9Zf1g7nK+TJFDLXB57NmbAxPhKY8VtUPgh+WZbG14N8ceXeBwNj7R7kelGTmXZbROZYBEZeCSCZgb72iM0Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bLWtdEQ6; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bLWtdEQ6"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2129fd7b1a5so3370985ad.1;
        Thu, 21 Nov 2024 20:38:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732250338; x=1732855138; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L7PbFB0EtVCviJ5bhbaIb04d6odUROmdh06maH/pBNc=;
        b=bLWtdEQ6sfSsZP9+ymmLrTHOxVAG/MMF4L3hZGNgkoaHfzCHVvPmHd9jJoN+FUgh+a
         Lx19fLQxPyn8V/GMC3Vzm5a85u+e0Embyp+YU93+maYna9lA2O0Jjpj/AmPWHcCk3B0M
         5+9TZOKubXQ13OXGJ2lO/+JBgv4qMvlkOUP+RdEq37Jurjpm7n83S3GP16ZR8Nu95bR8
         KO79gl8rcKARfO9HvrLZXYHAbf/9B7m01QyopQcmmJ0cVp/6ReZLxFWvtPuMFeCeREs3
         +0JWcBsC+UTgs9SL+7jdaUC3gzzudyPfuAMC7BvILb+FAyFSqnW+j3ncoMsk7RaJHb8N
         GXqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732250338; x=1732855138;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L7PbFB0EtVCviJ5bhbaIb04d6odUROmdh06maH/pBNc=;
        b=gvWvRu/vYiJfqJ6DEo/T/iA4hZXQuA6rSo03jvmj0vUSaxpad4klxC8amcfSO3jxEk
         Uf2UefyiEMoceb6/9SrEqdgoqvWL7HcfhzlebghMz1u7fUmo54V6+ppNDO3oAAjO6VcO
         +xq3shm5HJyv1TYhx5M0N5H197JP1bKDS+JTF6rCJ79FYuOV0zKd/bDZk6lmKRTvFxRe
         u4c36Wi9VU8Jt7yB3OdTCf5wfvEAh1A3Vog2C2kxuAPRR588vVrgnUrZXrLSEtUFEXbX
         3/zvgKD48TCVMWivoUXCL6KKSJltYubFgYFaxkkZuPIIbOTpSVn5BI9wNg/h17RQf+ta
         B6Rw==
X-Forwarded-Encrypted: i=1; AJvYcCUDAL0n6r47mBfGQM27HqSS9+CV7tlMmlYdgUxWJ2YBFFx1E2aP8t2rt6axo9Disj1sJ3QTYb1yFmwbFWsdqmc9nQ==@vger.kernel.org, AJvYcCW3kqkIgCGDIZu1pNDTqjSreiAyUucARvVqnSxPnYLam7hfZD1Uw0nU065DGQ1Tn/hz5UFYjNbMb8uWlVk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3+y9V1YSo5N2FqoE+SgG/xY8AwnwJ+nOtg7O/IAWje61IXxP8
	WFXO74YxQW7+Hyc4FM4bllyjrjReRfEzCwq5VpiEDdDFA9O/sDjH
X-Gm-Gg: ASbGncvs1NVPRP1ouUTDbSGhU1v9FktLJUgbZQcGGipETPSqZIFx2hXrmPektUi8Nv0
	/vwH7AvUbWAgd7fXc9JEnFWqFZZszg4hFvuf8bi3/4g0JHenOM2nowfNnZSoAayjRS5IdkkuFFL
	0oTeK+tflBTQFTN6KOjp8xnKAIOasGCdzV6UdsngHF1NuXP1eq3hrkm36w/rkdsp2PkMpWQWwcU
	gg15Bm1YQQpM/QYtEgTkOrRqwhxNNE9yort1bJDBeqHNDUpqsXjoPwKRImLF7Bq2zXnELkps6vs
	dvfxGkeE9h0=
X-Google-Smtp-Source: AGHT+IFakci6wd+SwbI7M/tBtmwb9/0itlK4/Wzl9Sv7NXBCtZa/WM4AqH351Nhf5/50lGUGZY0tUg==
X-Received: by 2002:a17:902:db07:b0:211:efa9:a4df with SMTP id d9443c01a7336-2129f22b9b1mr18783525ad.17.1732250338554;
        Thu, 21 Nov 2024 20:38:58 -0800 (PST)
Received: from mbp.lan (c-67-174-206-244.hsd1.ca.comcast.net. [67.174.206.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129dc1544bsm6638135ad.193.2024.11.21.20.38.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 20:38:58 -0800 (PST)
From: Howard Chu <howardchu95@gmail.com>
To: peterz@infradead.org
Cc: mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Howard Chu <howardchu95@gmail.com>,
	James Clark <james.clark@linaro.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v9 09/10] perf record --off-cpu: Dump the remaining samples in BPF's stack trace map
Date: Thu, 21 Nov 2024 20:38:39 -0800
Message-ID: <20241122043840.217453-10-howardchu95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241122043840.217453-1-howardchu95@gmail.com>
References: <20241122043840.217453-1-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Dump the remaining samples, as if it is dumping a direct sample.

Put the stack trace, tid, off-cpu time and cgroup id into the raw_data
section, just like a direct off-cpu sample coming from BPF's
bpf_perf_event_output().

This ensures that evsel__parse_sample() correctly parses both direct
samples and accumulated samples.

Suggested-by: Namhyung Kim <namhyung@kernel.org>
Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Howard Chu <howardchu95@gmail.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20241108204137.2444151-10-howardchu95@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/bpf_off_cpu.c | 59 +++++++++++++++++++++--------------
 1 file changed, 35 insertions(+), 24 deletions(-)

diff --git a/tools/perf/util/bpf_off_cpu.c b/tools/perf/util/bpf_off_cpu.c
index 2378fb5a893f..d6f015362e85 100644
--- a/tools/perf/util/bpf_off_cpu.c
+++ b/tools/perf/util/bpf_off_cpu.c
@@ -37,6 +37,8 @@ union off_cpu_data {
 	u64 array[1024 / sizeof(u64)];
 };
 
+u64 off_cpu_raw[MAX_STACKS + 5];
+
 static int off_cpu_config(struct evlist *evlist)
 {
 	char off_cpu_event[64];
@@ -309,6 +311,7 @@ int off_cpu_write(struct perf_session *session)
 {
 	int bytes = 0, size;
 	int fd, stack;
+	u32 raw_size;
 	u64 sample_type, val, sid = 0;
 	struct evsel *evsel;
 	struct perf_data_file *file = &session->data->file;
@@ -348,46 +351,54 @@ int off_cpu_write(struct perf_session *session)
 
 	while (!bpf_map_get_next_key(fd, &prev, &key)) {
 		int n = 1;  /* start from perf_event_header */
-		int ip_pos = -1;
 
 		bpf_map_lookup_elem(fd, &key, &val);
 
+		/* zero-fill some of the fields, will be overwritten by raw_data when parsing */
 		if (sample_type & PERF_SAMPLE_IDENTIFIER)
 			data.array[n++] = sid;
-		if (sample_type & PERF_SAMPLE_IP) {
-			ip_pos = n;
+		if (sample_type & PERF_SAMPLE_IP)
 			data.array[n++] = 0;  /* will be updated */
-		}
 		if (sample_type & PERF_SAMPLE_TID)
-			data.array[n++] = (u64)key.pid << 32 | key.tgid;
+			data.array[n++] = 0;
 		if (sample_type & PERF_SAMPLE_TIME)
 			data.array[n++] = tstamp;
-		if (sample_type & PERF_SAMPLE_ID)
-			data.array[n++] = sid;
 		if (sample_type & PERF_SAMPLE_CPU)
 			data.array[n++] = 0;
 		if (sample_type & PERF_SAMPLE_PERIOD)
-			data.array[n++] = val;
-		if (sample_type & PERF_SAMPLE_CALLCHAIN) {
-			int len = 0;
-
-			/* data.array[n] is callchain->nr (updated later) */
-			data.array[n + 1] = PERF_CONTEXT_USER;
-			data.array[n + 2] = 0;
-
-			bpf_map_lookup_elem(stack, &key.stack_id, &data.array[n + 2]);
-			while (data.array[n + 2 + len])
+			data.array[n++] = 0;
+		if (sample_type & PERF_SAMPLE_RAW) {
+			/*
+			 *  [ size ][ data ]
+			 *  [     data     ]
+			 *  [     data     ]
+			 *  [     data     ]
+			 *  [ data ][ empty]
+			 */
+			int len = 0, i = 0;
+			void *raw_data = (void *)data.array + n * sizeof(u64);
+
+			off_cpu_raw[i++] = (u64)key.pid << 32 | key.tgid;
+			off_cpu_raw[i++] = val;
+
+			/* off_cpu_raw[i] is callchain->nr (updated later) */
+			off_cpu_raw[i + 1] = PERF_CONTEXT_USER;
+			off_cpu_raw[i + 2] = 0;
+
+			bpf_map_lookup_elem(stack, &key.stack_id, &off_cpu_raw[i + 2]);
+			while (off_cpu_raw[i + 2 + len])
 				len++;
 
-			/* update length of callchain */
-			data.array[n] = len + 1;
+			off_cpu_raw[i] = len + 1;
+			i += len + 2;
+
+			off_cpu_raw[i++] = key.cgroup_id;
 
-			/* update sample ip with the first callchain entry */
-			if (ip_pos >= 0)
-				data.array[ip_pos] = data.array[n + 2];
+			raw_size = i * sizeof(u64) + sizeof(u32); /* 4 bytes for alignment */
+			memcpy(raw_data, &raw_size, sizeof(raw_size));
+			memcpy(raw_data + sizeof(u32), off_cpu_raw, i * sizeof(u64));
 
-			/* calculate sample callchain data array length */
-			n += len + 2;
+			n += i + 1;
 		}
 		if (sample_type & PERF_SAMPLE_CGROUP)
 			data.array[n++] = key.cgroup_id;
-- 
2.43.0

