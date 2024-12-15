Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B72B1C3C0B;
	Sun, 15 Dec 2024 18:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734286370; cv=none; b=iyZNhyFEZ9W1HP+qF4RX+DgRhlY46pt2nWE6JHbZJlnIw8CSwGiCbaMYKJQHkFP5YjZ1Cgjkl8IVmgJl/NN+e8Ad/fgA7rqw3awFZmTvDfSBikOF3FX6guzo6UvwWkL3cgrI0f9rvfC5kTYY2irwKhB74eVhAk5RhwYutYha2IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734286370; c=relaxed/simple;
	bh=lwpItHlU96z4UGlv+o5kLmRFuWMmSjHuiiEw79vAX2k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ICqEkCWDxyhwQ2Zyb8kBJUOiM3xyoZELD5We1m4/pmU0A0LMyHCSJ5ulkGWZDQNaDmjvYpVGEuTK6OT71/HXzXT46yPhHJLfWab3d7SjJC6uiWNdHBPF5t4d5i7GBv6IFVrCrZl4KrHriQMP3f1feD5B2GJb93qB/Rz7ySUaXYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NND+8Obn; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NND+8Obn"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-728eccf836bso2811818b3a.1;
        Sun, 15 Dec 2024 10:12:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734286369; x=1734891169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jcAu/W6kHIkTq88lSfam6h5x/9TA0/DITGh4yas2uXE=;
        b=NND+8ObnRqwVIlrktzIJguuhx8V0l5rHmtqeTTssaAxufwyoNkeVkHzbNd0tJVqLd1
         SU+o+iBML4UJhfN8ArWblgJK3N5/j5KJGzW8ceQb+FuBUIv0El2WEPZ1iPqnlWbbgI9i
         u3oVJXc0iSA0JXfl36DJ7jlIav517Q6SKr9GSFdGSpFMI07Q4wX7iZtKxaYkAsWQczcG
         EoGI7jtZcycB24IxzzMF9aPOOUOQq5EN34/E7kqWHOHifF3aC1wsnJ9JfVGCpyuPkXhT
         x0IFxSzVvTfJPItbaXvPkhCf6pNGGOda3HNoxk8mFec+AETlCbxBAxGEoQ+sDRZ4ciAe
         g2Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734286369; x=1734891169;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jcAu/W6kHIkTq88lSfam6h5x/9TA0/DITGh4yas2uXE=;
        b=Y5qOdTMyJMRuL6w7nnICupPLrtCB1y2/aGvtX/RATH9n7/BXwt7j4MUrMxHRu17mDj
         Ov+yM2M5w12vLAdn8Pp+nPoSzJpL5E7eVxFwHzfzWJOTRgW8wV2aik44sFX4T0aBiy5n
         Uod9qI0Jgx7pRVjtINpj3zUTe+fQnMRs/zMZinbow+MJE7SMXoCdUIXd6i7X5V/fzmCH
         +J6OOwXjNyDk2kCf2qQQTuoGC++lg+vfsklgWrSLsShYsZLW1gYXGTVTWiv6H3odJp6u
         qjBrLr/qIuAu4UVTZUuCofMHsoM2lJrPolfqY0ZmAwH3H66PZj9HmdonQ5G9Bazg4+ue
         lkZQ==
X-Forwarded-Encrypted: i=1; AJvYcCULzEmI5I/hNe5GibEdfYwx7eHLNCdi03klNPabUBkyPnln6bzXx4jDgCuONV452Zwy9iVHZHUrp9Gj51E=@vger.kernel.org, AJvYcCX3AJCN376/1c05W//a/hbDCHiGwAsUVU+UJ6pYNOjs5Wh567THQ/kiiMwf/6SfICplAThO/5ij1h0LegRj8VXQDw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwERtvb8nVEGGqGHXNA9G/Quj2ey71/rCAYXXTwfnU3ldBmu8aH
	wTX7IWGpqvrYWomnDKNYtISqLN0Rs5EBoBMg+g3HZAWYgb40fT26
X-Gm-Gg: ASbGnct2rJ49FcAJblGATkl4Vp8i51/V8PxIHeyRqzkqEUDmvLI/jhLWvm90+1//ukb
	I05MYC7VDqKcC+DFSeHhSb8WBE/iVJY74zEbZXypykQi7mUvZXs5jsdCDBTbwaDjX/m5aE2+cjO
	xyzVdRAe/yxSTTqwJu2wLDXz6y/hVqfrnQ4uKXaZjdud2BtqAZ3WcFqG+gmTK6Rg9pqG33gxmeu
	ygnxkrBxbDiSqBNMO04zmpUC8X30WQqYL7v5K58gMWPoJQ5ec00yl8ynq4H+lcaV7mtV9Hp8lpz
	Rr85FCEhKdy0
X-Google-Smtp-Source: AGHT+IGDq+Cl8cPm2InhFiD3r0RmXa5zFSKWx4rdHL4kM/DaplXbXmpnvIJPlGqLGmpG2pdQOrKDwg==
X-Received: by 2002:a05:6a00:b88:b0:727:3ccc:25b0 with SMTP id d2e1a72fcca58-7290c25cbf2mr13146523b3a.16.1734286368689;
        Sun, 15 Dec 2024 10:12:48 -0800 (PST)
Received: from mbp.lan (c-73-202-46-50.hsd1.ca.comcast.net. [73.202.46.50])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-801d5a90ba0sm2808120a12.16.2024.12.15.10.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2024 10:12:48 -0800 (PST)
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
Subject: [PATCH v14 08/10] perf record --off-cpu: Dump the remaining samples in BPF's stack trace map
Date: Sun, 15 Dec 2024 10:12:18 -0800
Message-ID: <20241215181220.754822-9-howardchu95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241215181220.754822-1-howardchu95@gmail.com>
References: <20241215181220.754822-1-howardchu95@gmail.com>
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
index 84c3bf6a9614..2e7e4ae43ffc 100644
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
@@ -307,6 +309,7 @@ int off_cpu_write(struct perf_session *session)
 {
 	int bytes = 0, size;
 	int fd, stack;
+	u32 raw_size;
 	u64 sample_type, val, sid = 0;
 	struct evsel *evsel;
 	struct perf_data_file *file = &session->data->file;
@@ -346,46 +349,54 @@ int off_cpu_write(struct perf_session *session)
 
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

