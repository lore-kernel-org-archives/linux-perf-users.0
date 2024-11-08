Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6616B2123E6;
	Fri,  8 Nov 2024 20:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731098519; cv=none; b=Au8bsexCf8gcYJH6hmtNaIEkcdM9PGIFA1Gt5ccmfWcvOJniXmARXcrEiFEbRSCrE/nESK5HqDPa02soviNigQymUUbcnZ7X7TqXkkODHZpnHVsa352vMFqb6SAPqC2iz55Vk552q0m6aq+hkreMKSoTyl7tag/i4PiQ04TdBB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731098519; c=relaxed/simple;
	bh=D4yVMT2FcG4D5LyFEnoiF/UGY7U3Zo7ouqlCO2gU1/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e/fUVsNflopiXaaxqzfO/TP0oq7Voj8nmBWHcfIW/dcqLtNz/L7fs9lvYk5T2QUFlUmtsijBmq8VafnXB7KPXUVGQE4Bn3Maer733EFQYwAJwFhfND2Ff7hhq2SVd/fATvgTx1ey6suCcrBYPu694JASmPQMUyL95e/HzVhnrrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fvcFxtCW; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fvcFxtCW"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-71ec997ad06so2175178b3a.3;
        Fri, 08 Nov 2024 12:41:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731098518; x=1731703318; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E2tyw1tOse2vzSiyEi9SCuAYRS4VzNw6M4PIA6JS/KU=;
        b=fvcFxtCWzp0LteVgCFmSyo4ebPyKQOfJz8bVOOgtcykWpuHT0SYMeIVduOePjLFr99
         DHnOSI87Lsdo7YVHMd4Mv7XJPJza0gl+cKgWgqbw74r+RFHHjZU3+xqxTp6X5D5LcH0W
         J49EHq0EreM2+GKOcjDY+LHXnmenoVO02k56m+gWI29NucA6NbMdjEJqWV1VD6wgBRSJ
         BrY2j6J2HPXWbcMgnuMvjHu3E3rEvCqq1XjmrasaJvNw8JRzzFgpnzU94K03vRq2QV3y
         Gkm+xy38Uee/GZN8Yz4g1tn6wANRMqYI97HuZQDwy+21E8X6IrpgSZeDBfVvKWXAXhUK
         nX7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731098518; x=1731703318;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E2tyw1tOse2vzSiyEi9SCuAYRS4VzNw6M4PIA6JS/KU=;
        b=jKQxymAMMc3b1UM0BTrhbwhTqj/MTKY93sVUhKXuXGNl0RvLCSdJ3zmOH7zwE+Ds7V
         HwtpBycglqfOBFN81sPB8bGzdKp0kmc/OZPTZo64LCkjqo/ljlUwdN77RuMpfIz1KFKz
         sNs0H5ODQai0plR5E+T7+V0nEjEAnX62yNR8N02AKGffBLcfjw/2C1smXTGDvuzGAYL0
         rvB78x9dN12cbllpVj5RKelfbKbLJCzC8cekj5k4CyhMvy1KWlJVl4BA5ONpXkideTIy
         jw32CENHaSiWkmkTP2dolaUo9ctyebFY/xSXA7lx4POYi4AfLYyotRvnRTckHDu5UdI3
         o2wQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVHLzyV56bO+v2Ykvw0bc6KXNxEtdQ7t+Ggalt4bnDPRC8/A3plZ1kfa0TwKz6USY73eVyKwnk4F1Mz84=@vger.kernel.org, AJvYcCVj4L+YndQlkSNuP5KJFz4kpmfT3+7JBFqpIRjZ1K4q7ofAAzdkzYfjGwkjikjzEeHWsoWu+VvkT3eYue0aucvFOw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9rs4syuu+Gamzv9bxQCjpL1ROcE/73GelBIuq4Y+D2zdyiWWM
	uWQvKCBBDsSNIHP9e30vTPIT4puYDKGS+NyBiH5f6ymRzVFcYmIA
X-Google-Smtp-Source: AGHT+IHC5toUl0yKFimGX5HCCwEhUAH5gjmPf0a4kj4mHRrpqamvhXyrJkR2NfYTS3mmkm5BrrJGAw==
X-Received: by 2002:a05:6a00:14d3:b0:71d:feb7:37f4 with SMTP id d2e1a72fcca58-724132a0015mr6215760b3a.6.1731098517701;
        Fri, 08 Nov 2024 12:41:57 -0800 (PST)
Received: from mbp.lan (c-67-174-206-244.hsd1.ca.comcast.net. [67.174.206.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7240785ffe3sm4221945b3a.2.2024.11.08.12.41.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 12:41:57 -0800 (PST)
From: Howard Chu <howardchu95@gmail.com>
To: acme@kernel.org,
	peterz@infradead.org
Cc: namhyung@kernel.org,
	irogers@google.com,
	mingo@redhat.com,
	mark.rutland@arm.com,
	james.clark@linaro.org,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Howard Chu <howardchu95@gmail.com>
Subject: [PATCH v7 09/10] perf record --off-cpu: Dump the remaining samples in BPF's stack trace map
Date: Fri,  8 Nov 2024 12:41:36 -0800
Message-ID: <20241108204137.2444151-10-howardchu95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241108204137.2444151-1-howardchu95@gmail.com>
References: <20241108204137.2444151-1-howardchu95@gmail.com>
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
Signed-off-by: Howard Chu <howardchu95@gmail.com>
---
 tools/perf/util/bpf_off_cpu.c | 62 +++++++++++++++++++++--------------
 1 file changed, 38 insertions(+), 24 deletions(-)

diff --git a/tools/perf/util/bpf_off_cpu.c b/tools/perf/util/bpf_off_cpu.c
index cfe5b17393e9..f1be354e2fe7 100644
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
@@ -61,6 +63,9 @@ static int off_cpu_config(struct evlist *evlist)
 static void off_cpu_start(void *arg)
 {
 	struct evlist *evlist = arg;
+	struct evsel *evsel;
+	struct perf_cpu pcpu;
+	int i, err;
 
 	/* update task filter for the given workload */
 	if (skel->rodata->has_task && skel->rodata->uses_tgid &&
@@ -304,6 +309,7 @@ int off_cpu_write(struct perf_session *session)
 {
 	int bytes = 0, size;
 	int fd, stack;
+	u32 raw_size;
 	u64 sample_type, val, sid = 0;
 	struct evsel *evsel;
 	struct perf_data_file *file = &session->data->file;
@@ -343,46 +349,54 @@ int off_cpu_write(struct perf_session *session)
 
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

