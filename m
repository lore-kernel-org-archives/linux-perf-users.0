Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6778E270EC8;
	Thu, 13 Feb 2025 23:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739487627; cv=none; b=WK+hqYBlDJyKdq2xTFUi0k5gqPu4Yz33mls3iyctKbZpxe9Fr6l41RWWI7iFcEq4VAH/BF9/DoA0wt18KwEhpYPaJg4o/XhxHVaqO+VgBddtVFtlaBljgdoJ0V0Mf0cIbNJ01haNFifrJmCMWP1ruXbsKDMk0TyGj2dmaSQySmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739487627; c=relaxed/simple;
	bh=5iyF3ehQWFPe6nTiSzDQN4FmBZhfvZFLZQvIVUC4BZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WPmTQlHDNheYNKpTw+M+ZfWpaNrsmqS7bO54Ay1Y9UXPGk/2DWl8wErf0C8dzWZSONDE9chuGs4bSEjmnNpzaFh/iSkgCE5+M2ZHuFKt84Y+jEuc/YHYsUX4vCvvadE0wy0idS3cLt8+R7TJCuNuYqDk7fDL72Z7uKpI4d/Be+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YbdHz0XJ; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YbdHz0XJ"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2f9b9c0088fso2272760a91.0;
        Thu, 13 Feb 2025 15:00:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739487625; x=1740092425; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NVFzboUXL9aW366CZRys/UMk8WcR5XGdl84CfzinmhE=;
        b=YbdHz0XJelENNiVkRkXsJjuW14shscNvqjYx1MVlVBZ9dMo95EHucmlBcbZhu0ldDV
         JyGqtLnusM3ahUaimB/Ef53sU6S5fftDjp+FYINpvY7iBlu1SOGnOaZ7TYnAP5iqte/s
         PmC8TDunEHtK6Kx6UH8/ufZ0Pte5xUUJPs8ISp6FdbK+TDQsltTRvu8mHdCeBfU6vxjX
         EKrL0gp8bRo1ZS84PS0ekJjyZULbQLKVx3JPQoilgc30VJFh6IDsoPeec+w/GOdmoRCH
         PV+PRDlct3WKne2RAK0nNDXnz6xOQ3mlTtvvPLBCSzDd/as2trjvrV1rpP1ohqXyjMqX
         F+gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739487625; x=1740092425;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NVFzboUXL9aW366CZRys/UMk8WcR5XGdl84CfzinmhE=;
        b=Oea/S4Si0TOnx7oKCAJrAvzYmnTXEy8hjgrzLFBZ5aHr65mUUF0gTmxqXPpP9XjTPY
         iyT8/fHqR0iX+YBP/WNw5TsDuDrELGe05INofEstsj5gZpJ9EPiV5ylxNZoa96s2QH6I
         BskqZC82iETgV5H5V/Xw25LJqbUMnZRa1VSvsxb5B5nkT5/pL62omAp4ityws2jPzieZ
         a+OaflPcHn0tWzt2dHzGjRIrfvTpEHwrcR1xHY9yiq0G1WFpvaQfraQPP2MTbxY0YGg6
         fUM9TaA8HQlxBSfCJ0N6hshc2XvpZHUMN496iD7Knm/1PF9LJFA1m0oBIgY8d3PS1CIs
         DyYw==
X-Forwarded-Encrypted: i=1; AJvYcCWM/ao0OULB6KJrNK9UWoT3k7iqUrel//F4paYobiJZTt0rPkCDDSetdLBl0hI2oV8wEz8qxkaMmLoPHlc=@vger.kernel.org, AJvYcCXUlB2TzZDiiLB6ztiUEbNJUjEHX2Wu2qETFrQTyubOngm9ZwW/uQ2Xs0FagtIEaXUMfImwEJgguAAt4SC+sj2paQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzjLK77MFzXk6HvINKMNWJTQDvE7xE3TxK70Al6hlT/UuE5NSaf
	1MA/naHpcnIiUHFStKQpIlBtKYDW038+8rvxpO/zglEe58Puyl9v
X-Gm-Gg: ASbGncsbCxZJtnTJwK3spO9yEGyseg+tFV2pQ+SCxqNME1CEbZEVS+dQmiRP8+fhjlX
	E9lCgQkxqhJgD6kj2rl/SBr+2yPgioSEZ2QAv+OBMGRXad928gOGaRfzz32bhnPoSk/Q4uYk6yQ
	W0+/h89pcP2tCMGiCQIWO5PDVBiYTtWMKSEBk/REJEhBTsZ6iw3yTYia4nj/VS23zDBQZTPoBCZ
	LxamFQefxbobHWDhrb2H5ApD38X/43fKRSAq9p4f8cfPNUy2nWdZMKDJUPhsJYB8MApZFy1lpK1
	gkx06+4XqaRFBpQqP0nrEuV7hAzmyQCh7HbD39XOUknBMrw=
X-Google-Smtp-Source: AGHT+IGtFiztEAjpNU0miFV/6OmgPWklJsqw92dDFR2Pjph8R0ElKCr9s7N9z9rklcQlkb7p8Rbdkg==
X-Received: by 2002:a17:90b:394f:b0:2fa:2252:f436 with SMTP id 98e67ed59e1d1-2fc0fbca207mr6855717a91.3.1739487624648;
        Thu, 13 Feb 2025 15:00:24 -0800 (PST)
Received: from mbp.lan (c-73-202-46-50.hsd1.ca.comcast.net. [73.202.46.50])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d5349210sm17641735ad.11.2025.02.13.15.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 15:00:24 -0800 (PST)
From: Howard Chu <howardchu95@gmail.com>
To: acme@kernel.org
Cc: namhyung@kernel.org,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Howard Chu <howardchu95@gmail.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	James Clark <james.clark@linaro.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v15 08/10] perf record --off-cpu: Dump the remaining samples in BPF's stack trace map
Date: Thu, 13 Feb 2025 15:00:07 -0800
Message-ID: <20250213230009.1450907-9-howardchu95@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250213230009.1450907-1-howardchu95@gmail.com>
References: <20250213230009.1450907-1-howardchu95@gmail.com>
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
index de71ff7a80d0..e55693bcbf08 100644
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
@@ -312,6 +314,7 @@ int off_cpu_write(struct perf_session *session)
 {
 	int bytes = 0, size;
 	int fd, stack;
+	u32 raw_size;
 	u64 sample_type, val, sid = 0;
 	struct evsel *evsel;
 	struct perf_data_file *file = &session->data->file;
@@ -351,46 +354,54 @@ int off_cpu_write(struct perf_session *session)
 
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
2.45.2

