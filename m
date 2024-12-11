Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7005E1F4706;
	Wed, 11 Dec 2024 22:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733955948; cv=none; b=hsiu4PUjIVhEVcM/20lzY8p4eiwKgKv8QFbNewwb1hsd/9WUT2mQ1SIiFiI6cX3VaZEkZ3xQ8HdMvym9ZrcmWPaMz2L9qEbaFXdlIQuHOtrmVrjRQ+vWBXMlj4tvJQAStBYlBpZWlf0Ismji4ahtVUXy3qGM/ds9fOKQ/G8mA88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733955948; c=relaxed/simple;
	bh=goTdjk11qmBk6a5P1AA+giS5yljV5oLTjYAh1YgVF+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bE2RwxShss77qTvrIHI8R1CTHMr6TVzKayMbGj9G4V0tTiuUvioftdMI2ZXeFQTm8nxukfA0aClet7I2/+hOdQylPc0YckOmIfHerjFeZzVs2Glu2riR0C14yyVgZQYHQvx19zPnko40ci3qDQM3LKDiopY/wKU/vF0ad3rkxvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WQJLyEGo; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WQJLyEGo"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2ee51f8c47dso5332929a91.1;
        Wed, 11 Dec 2024 14:25:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733955946; x=1734560746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L7PbFB0EtVCviJ5bhbaIb04d6odUROmdh06maH/pBNc=;
        b=WQJLyEGoXaVWq5aw74S0ZbpsrrwF3EN6ek54Uplwu5yf4arh4HKUOmvHdQAFY0W/hN
         1AdHM9h8nbM1XUZhm3yzcx8OPxAYSO8vSEFjo0QpAkHyGVo/xwntE/hI33/G92i0+hlX
         boHoNNeerd2Xal0dVWnFSqWwnry118KwaGFN846cXsb0pmtQ3a4993+4yYmgB4ISqDU+
         HnMJMuf/44mIhp/Xi1dBXAdDhSKe5ZNEM3q7sssQeFW1xpPTBQjbs3eOGQ6VvlMEEKKO
         7F1wU5Mn05ys1s9Uchp2oo9OQZZebr2SauYepTeloLiPgymZBXdm9Cxl1iGf9vJd5OlY
         5Syg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733955946; x=1734560746;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L7PbFB0EtVCviJ5bhbaIb04d6odUROmdh06maH/pBNc=;
        b=GFkml30VUghsIsM50nLvKdg9uyZdUoxrG7QSdYq4xSCz+yCCCrc3CEwlTVJ6YfUE6P
         x0T84vfshffJ3Q2s4PquXV8GJ2fVnB3SRL20CEMxkxlIAaO1O0js5Zlm4RpS1w8Q2PCw
         cI3suFMEyPzesLfr4Tpv7/Q8g6cgrucG95VHclTC3rexq0g6mdRy0ZAXdKA09o5I/cbB
         93H9qf8wlmd3rglvkKgtb0Z+6eYH8XCWJEvidChOCAJkMwWhG276upgTZ8efEc/hfVdt
         5Cm+JUN+YjTgHvPMC7ajRM+6Y7W+/T0xGOtV/WtDIfZcjg5H8OC841/npKCMjBsLlMQT
         gHYA==
X-Forwarded-Encrypted: i=1; AJvYcCUFANJGwkYP8l9exRn4ayk/NpJ7snJ2E6mUBVeljrMbMo6L2ddfAGJn7KKEkNISjpzbfeBODtAuRHsLGtWV9AIlCQ==@vger.kernel.org, AJvYcCUqdgR+LOWfWgdoxg9TMRn8BQ5F6oUJIT2bp+CY0mAfJqOMkhXrmyd6zbiwJADuz61H3CTmpzcST0FevFI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yze3FlySko3ER1jEC99n2RaEEn+ziq5w5kayWaJxesUMcjA0/UT
	bVCsV55CTaq9oxyYcerL2FOfWF8W2lzzvn1QncuKXXk4uURmb2ov
X-Gm-Gg: ASbGncue4rfIWrWsQ5D4W8yzU+1Mi/GJC+OvPlAw68Ju2pNKYDAP9l/HrzGF5SvZCQx
	FCNM+Bi6KT+rIVyAZgWcvqOg1CSDIQukyXCYTRjuHzaGi4lNlpoed+7Fh1dS7NQWx5S3x9obh2I
	0ZxpE4HwT0ygjtnPS/FNnb6l5jy72XAktw3UXBMRui4I+VhQ9odoN/Z4wlH9pOgxNeIl0cbC5BI
	ZSzc8HIk2IKKu6ojuMS/zGe166h5yCYM9fMgnaSp14sMGFMKwZg537/5YeNr2WUg/5KiubCgJ5g
	24OZfrd6Tg==
X-Google-Smtp-Source: AGHT+IGESFebilgK8NsdZlHdrxnoXg8SNLXC+f0KsTa2W/4KdO47LHGLBZovz1fcij05Nrx7h6uafA==
X-Received: by 2002:a17:90b:3a83:b0:2ee:e518:c1d8 with SMTP id 98e67ed59e1d1-2f12808c035mr7184244a91.30.1733955945712;
        Wed, 11 Dec 2024 14:25:45 -0800 (PST)
Received: from mbp.lan (c-73-202-46-50.hsd1.ca.comcast.net. [73.202.46.50])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef6d1fd68asm11241561a91.36.2024.12.11.14.25.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 14:25:45 -0800 (PST)
From: Howard Chu <howardchu95@gmail.com>
To: acme@kernel.org
Cc: namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Howard Chu <howardchu95@gmail.com>,
	Ingo Molnar <mingo@redhat.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v11 08/10] perf record --off-cpu: Dump the remaining samples in BPF's stack trace map
Date: Wed, 11 Dec 2024 14:25:26 -0800
Message-ID: <20241211222528.945590-9-howardchu95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241211222528.945590-1-howardchu95@gmail.com>
References: <20241211222528.945590-1-howardchu95@gmail.com>
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

