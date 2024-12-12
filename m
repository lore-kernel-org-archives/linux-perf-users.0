Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BFE11885AA;
	Thu, 12 Dec 2024 02:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733970303; cv=none; b=cdLcGlGoKWsijPF7x0SNH+TRiKWoRmmZcldS2w7r8zfcjm37xjx0nrd/5wcsNbYmFdimCHEHwo0wxYnBXusUg0c18m3vNAXzhkuQMCGBsq4s5MAxkAljMPb7KqfPo/2h/8Nx6QzTsvrkkRffjSgchLFL+WhZwP5VjGsUwrDY9o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733970303; c=relaxed/simple;
	bh=lwpItHlU96z4UGlv+o5kLmRFuWMmSjHuiiEw79vAX2k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OUooxeaoCdUCquC+vS9y5r9z5zJd6BNgweqhnM/7KSlsvRYFiKIR085tTKtbnAz7U371Auxjs7baQuxD7ySmCzvspPtp2Mf4tjZl5z5h+useHGDzh3HRzWMe4mHWj0cEfB6AgyvIGefP+tnsSQn+tjTUAsHhoROmARKn4ADUmhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UlK/LiE4; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UlK/LiE4"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2ef714374c0so96307a91.0;
        Wed, 11 Dec 2024 18:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733970301; x=1734575101; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jcAu/W6kHIkTq88lSfam6h5x/9TA0/DITGh4yas2uXE=;
        b=UlK/LiE4hflUoh8BbIWq6eHXNo7bniMdfymuNpaSVSBsoiW7GBBXDk0ZRZAVfXAU/h
         tpKczx2CChCGLsI4O8KKi/YNA9yVLILBrQ/Bshq4yHwfB2uDddaIshqyLyKe+RUq0LtO
         OUZKM5i8fFjmk+YILON9XDX1VqjVpRc22pr1xcGJXqoQb/9i/Rbvl20b4NoftFIzlj/r
         l6sr+dj8pZCKdsUESczcf8q5h0AF0t2mdk+7O9a8mih6WnWeO2AcVljy11ae6PRXDrpP
         +i2By8eOAxJnzN0CjtdS+bui4uN13tuOPbjsz9Vnwy5yCwyC2qVIAiimGfXkQt5BrYpu
         rhPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733970301; x=1734575101;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jcAu/W6kHIkTq88lSfam6h5x/9TA0/DITGh4yas2uXE=;
        b=FHbTmZ9tFjIEaPHV5WRGiFdk/qkKVXyUvaRpYpT6Xn39dkgtusipchYM1wMWahvUVo
         fFR/la1a+iyaw2tbs66GpzxdDlyfN3F3waZfCwqHxVquzCbBvz5xmBkgef/p2JyTE4Bu
         borg2PQ8+Si1qgWU0v8atBz/9p5B3rphwAphowIGvmAGscgQxWWbiy2iqZnX+q8rID2t
         MInih7LGHnY5NvCX1X2DX/gyxAlW9z0Z/vUD1Po1q9hBtTHlewM4HSlL0byugzPHEwmm
         4NS7tDt+qpXjRxshEuYkNAnpOVOaoNzKPD80SfPz7ThRpYbYLrsYY3UQl1PMKEakjQPO
         wS9Q==
X-Forwarded-Encrypted: i=1; AJvYcCU5PmTydJMSuyB48dnfStpUtulFP8JsZ1YCjmziGtKT/TkYcM3FpXGfr8rw/lXYZokNeEPPqQNQEIY0DWY=@vger.kernel.org, AJvYcCXrY+zXvxP1wYKbR4/aMXSSnEULe+HPa6DiD8HQVNJBJj91cEzzvAdqYQ0w76nikOD5Kk+1q1wufIczvxVsiJHHVg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz59maEHiL6tsSS3YvzyJiNkZNtj80ne6Lu9QWQDsGfuBVmOcaM
	UtiL4RK3CCnlM3rOg5rGqcb1LutTUx3z4W6hVdi8ESpivuXHfOt6
X-Gm-Gg: ASbGncta62NFyvHY0LPgJ1LDnXevoPmEg4JBH3Oqgn1kGTU0oXS7uNtWyCd4O8LqY48
	zRbLk8m1nA9N62t4tQGz6Kd+G1PZxVO5B0Tx77BhM2giHE1wz/8+45HJvWKzHE1HNsEVRafdTDe
	SGQRPA183nMmYRP/IwOw10IVLxyyyxa/x/InWJkOTwqNI2yDDKAJ/FsMAJVRZJRvI0GZbYO37py
	IkXEt2huDnwD1WmiFGmpSmn1bl4KdBC8x1hRTfHWa3DRTickkzbGMvbk7NzHhcDqz7PrBm7phMw
	h/ht20KGwPfW
X-Google-Smtp-Source: AGHT+IE7w714CujGIQKGjhkJ2iYDP4ZnIQCCgB5bZsYlNyn+OqmvKi4m+hF+0DyIu4aD2J4Dx+1wWg==
X-Received: by 2002:a17:90b:1d03:b0:2ee:8253:9a9f with SMTP id 98e67ed59e1d1-2f13ac54753mr2362343a91.11.1733970301486;
        Wed, 11 Dec 2024 18:25:01 -0800 (PST)
Received: from mbp.lan (c-73-202-46-50.hsd1.ca.comcast.net. [73.202.46.50])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f142daeb5asm112583a91.12.2024.12.11.18.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 18:25:01 -0800 (PST)
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
Subject: [PATCH v12 08/10] perf record --off-cpu: Dump the remaining samples in BPF's stack trace map
Date: Wed, 11 Dec 2024 18:24:18 -0800
Message-ID: <20241212022420.1035999-9-howardchu95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241212022420.1035999-1-howardchu95@gmail.com>
References: <20241212022420.1035999-1-howardchu95@gmail.com>
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

