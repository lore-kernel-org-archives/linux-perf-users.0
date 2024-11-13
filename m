Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E9D13635C;
	Wed, 13 Nov 2024 00:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731457717; cv=none; b=Sqi9nNURHiV4pCwbvDTZm9sEU7CeHeObE8i4Y6qGMYM/E6eFGgEPWyQE+Y2YyhGq0MJy2lsldHhlFeARQceI02mk9tdwg217w7WaecGgNbMvtjCy2xwgttjiFGX9glwlDonuhkdE8O/1CLkk9PDX46mYG7Ra2nveQI38BgC5m04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731457717; c=relaxed/simple;
	bh=sb+supRPW/fkpZ9vc7XCX9Jloxm0dJEW/JuJSj/ygOk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BV8oHmbdIfM/0n9c6pVrWYy9g7ewUiiBmwzuh2MYlWSB+UqEN4Ea7ooI/GLe+W8F1qi4gOg8xcHKRj9HDSMjR3YE2xosGNLFCFt3J7PfFJTlMdMYvUOsT6iPugZxhAWMd5rdqy7C/58QstOxqkk6BBpx8NCaQGQRBa07HR0GVb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yn9dJZzZ; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yn9dJZzZ"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20e6981ca77so72872535ad.2;
        Tue, 12 Nov 2024 16:28:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731457715; x=1732062515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9mWDHVgN1ZhsnvTOrpwFobfS9+/sponIhrFkhay1424=;
        b=Yn9dJZzZK9X/0B9zXj7l4q6Z/dYooZxBdraLO/uZPXq/jXt3ZtZMvJKWHHb8hnX73k
         Dic05zYxICSjKSO7OtzKkBRUrLS2L7Mam3uhhhEQB3X8yQPTqaRjYUIbHxrZc6tWCSHp
         Am74oKWcJxLAoXf37pW+V9xYNAwBECHJKcIZ+VV8LPCjUAQYBn5JEPdSFuLS7napR8Ts
         +8Fkaou1oYi3ldTOrZ4BQBdzI7AvQDdrJHdmbr8m2Y8iHjGYwB3wR6G0TAzX61scK2aI
         kAAKQZYY/cY+SSgXqKLgDY6v+ODvY0HIF3nI+qrFh/0frEtPwdicrqz+o6OSJjxFWDRh
         YUaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731457715; x=1732062515;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9mWDHVgN1ZhsnvTOrpwFobfS9+/sponIhrFkhay1424=;
        b=XRfEyCTmL5SHpR1Lnu6ZqvTB9H0YUE+P3+vDI9ih79a/kD5jhK5uaLVd1du9lH2SVR
         DVPmDUtL+n+5XfeUE3bCss1JMGmonL1RPpsapZVWOw5ewmHJsyKPXn49i9u4MYzCsAYd
         VBGQCjBAFyFmr1BIvy9ZyoRgDB3Y4K7WlsL7hOZtrsEB8g1Nna5noytO4CcUlVef31GL
         80ZhjuYuJl6Z1AhaH2MccgjEpAtDVZwzVDz2W/yVcpL/iInG2sJ68oMQmJF2JZ3F99V9
         Y4MzEUy0noZUTvt3Lv6CQ5AGbGYUUwzf7B3bJx+KKwbV1iNYDu8WUdWpRlgf7ePwNZBp
         cTjA==
X-Forwarded-Encrypted: i=1; AJvYcCWRt7vroGD5FvywjfGWh+A4zryqmydub8F4SoJPTBJL9WbK3+BPdw16WyUGGSHYl46sMvL/2m+kkkmYWkL2r94AnQ==@vger.kernel.org, AJvYcCWq/FxB7VkTOvUxcCl8LEZ+NQaRWlGLS4IUMmSXMgnD3MbN7vGtBlYc9VvkNCccgxV98BUwZgEyarFGhWg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqczmXEF0HpolEy+TEMtR5ad0q1YequDPv6uZzKjdPqdBboUUV
	uAsJ37jKRah3/s0SI+aPnJMcYC3R3jqoQDinLxo0U9zK1vDMdMYx
X-Google-Smtp-Source: AGHT+IF7GKcD2Q2v101tqIyQO1ocFMlkX5zhmmT47kNxgCSWd7nXOGA/SB55eXP9P/6KlBiH57eE3A==
X-Received: by 2002:a17:902:ea02:b0:20b:ab4b:5432 with SMTP id d9443c01a7336-211b5bcc3b0mr14309325ad.12.1731457715324;
        Tue, 12 Nov 2024 16:28:35 -0800 (PST)
Received: from mbp.lan (c-67-174-206-244.hsd1.ca.comcast.net. [67.174.206.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177e458bdsm100158425ad.133.2024.11.12.16.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 16:28:35 -0800 (PST)
From: Howard Chu <howardchu95@gmail.com>
To: acme@kernel.org,
	peterz@infradead.org
Cc: namhyung@kernel.org,
	irogers@google.com,
	mingo@redhat.com,
	jolsa@kernel.org,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Howard Chu <howardchu95@gmail.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v8 09/10] perf record --off-cpu: Dump the remaining samples in BPF's stack trace map
Date: Tue, 12 Nov 2024 16:28:17 -0800
Message-ID: <20241113002818.3578645-10-howardchu95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241113002818.3578645-1-howardchu95@gmail.com>
References: <20241113002818.3578645-1-howardchu95@gmail.com>
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
index 61729a65b529..16528f8509b7 100644
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

