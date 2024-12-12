Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776F01DFE36;
	Thu, 12 Dec 2024 23:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734046056; cv=none; b=qUfe6rAgHyLlzNDazgLUPf0R58kLY5kCFfGgGRqZHt938I0/RkzWHv06RcXtfxZ10YRih4AQWyisOPiLwix8dVMD2/VMXTzy3Ehqd9UDO8/SXd4VhyMyAqM+1wOi/IEkQt/WP3h+9k/p8Ijl7+c+0lpd95iNXWSuknMoy2sSkz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734046056; c=relaxed/simple;
	bh=lwpItHlU96z4UGlv+o5kLmRFuWMmSjHuiiEw79vAX2k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e3r7fRuTbLL/VD7h/qJPP4K7ZdeevxwJmmD3L7G4zxyOoQNRV8GT5OozCQAL1jYsc5DOCq40DP6yiJrOgXFr1QuYkqZ2GLPlw6TZ8ibsGq5Jw/A09HI21VKP9w4e9A/dD6QQsSAHeJa+Wov4lK13/oh6BPJVkUtT4w/UzD3xO0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lt4n4/b3; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lt4n4/b3"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-728e81257bfso975557b3a.2;
        Thu, 12 Dec 2024 15:27:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734046054; x=1734650854; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jcAu/W6kHIkTq88lSfam6h5x/9TA0/DITGh4yas2uXE=;
        b=lt4n4/b3p0COS4ob9Y8PHAOlvDJOW+h9vidKBeYfIlzLlbiaJFULeC2R+/OsyrVzIm
         OOC15vynVM1pVJB5T8/ELAJnc2CGibZcED0z5QIHSlSgMdPVu4EvkrUfRsVi1TMaBjYP
         4z8pHvfvrYlg89ROqJf/8dqrExIpz5V9zmfbSRrwaCEavu4iJnCjo3Og8RIMLkLemrN0
         P3xprrN9K9i0yeYZuxx2y88WCgx1tcdtLKjWjZJFpO+VTjQr9E9ePfDSAXBIfCAU+eA+
         GxoL+nqR8TI80KAimFQtu23M+NiVtWsYrvY5j9SGIibJ1d1/lkIuYnxbguB9szO4PYhg
         qQHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734046054; x=1734650854;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jcAu/W6kHIkTq88lSfam6h5x/9TA0/DITGh4yas2uXE=;
        b=k3QoabqjWXVmOHQwAEtATpbY+UKv9tefQ+HKicZPOw1sYSZV7HaEBZdPD1flv11RpT
         YSco9h6NIEw6SPuK0wpKDZ+QsqP+igt/gd+dIL8G6xnti4b7FfjyLri22OpqNB+YN2Zh
         6/MtTSFaTzJaciZyScF9lWC2NJwVwmJtVL2M5SXjy0LXZmLKDtqWdQ4wpZ7zmkDNguCH
         0DgQQEu3xAHeoW91EC+UfRNdZ6E1PIlQthW02E5NaIzcdcplEN1YuuyQfPILL8ZlufYJ
         gulGPkVSzM1OjPRi3BrGaZ6NKU0us5CkHSdGmS84efrZ6k93s3j+A0vLV6US3Udm2sYK
         352Q==
X-Forwarded-Encrypted: i=1; AJvYcCUATDl/DzrABMP/2fWLes2DnSQSXVhyAObuqkrGF2KxE0eQ4NH9u91eUA9Te0oG+ulDiuPqZ2/cFdfqO28=@vger.kernel.org, AJvYcCXBUMwivZmtAJIli7ON/i9N2x/ZkXNIQ4RswvhadratX/VBsORl2HIYkZ1xKqvivDQ0EhXRt2OEdLILqQghnq2kUA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzS2URF0XsKwgCir8iQ1xPBgPPh7kHCK06N0DXMYbw4mzVsXV0E
	+Mv5QDUN7Y4P2abTuXdK+fTQA4kcwmyQEAbs2XEeoVIlI0hHDk5/
X-Gm-Gg: ASbGncu2oLJpMwHmhXiDnFrn+zykj4powxv/d7RBWHFPmEygQdjqwPjEJ3M23u3u2O1
	peI9ftdctNIZT+jHp/pnD/1ZWpuPLYbQoq4DtHEuI5BKsC11IDZ09m5a0z4zz0/t2uy3uuUlruF
	Sv9VO4Sf1tqao2W7cCj9ORxCwb5k71D0NEVaGRWABCzzMyC0+1mzxg5OGByNDZDFcb/XgSnD3pT
	XjgveGMKWg/S/CBg6ze5Pmyq8Du96UH4foQ/reXt7wQmZrGk2995TvVQ43cr0z5BCaMINBo/s+c
	vSx2GmQxHAhG
X-Google-Smtp-Source: AGHT+IEFrdudXUfEVL/HF3cjqtD3KySyOxhbu+h17MlpMRZX/Bpli/Odok/KLQLPNQ1QMVbbqNEQ2g==
X-Received: by 2002:a05:6a21:7803:b0:1e1:b35b:5132 with SMTP id adf61e73a8af0-1e1dfd6023bmr549961637.20.1734046053870;
        Thu, 12 Dec 2024 15:27:33 -0800 (PST)
Received: from mbp.lan (c-73-202-46-50.hsd1.ca.comcast.net. [73.202.46.50])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd4e202e9asm7324674a12.72.2024.12.12.15.27.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 15:27:33 -0800 (PST)
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
Subject: [PATCH v13 08/10] perf record --off-cpu: Dump the remaining samples in BPF's stack trace map
Date: Thu, 12 Dec 2024 15:27:15 -0800
Message-ID: <20241212232717.232507-9-howardchu95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241212232717.232507-1-howardchu95@gmail.com>
References: <20241212232717.232507-1-howardchu95@gmail.com>
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

