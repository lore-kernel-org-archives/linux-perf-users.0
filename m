Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570E613B783;
	Wed,  7 Aug 2024 15:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723045160; cv=none; b=t7Hazl4mA850VcZiNSMyYiS9O51ozvm0Ru35fc3Fo9GTEsj3j7u9JZf8LQnRO0YfykPoktEBhm2sDIpKBExnhFygoxr8w0PfEIAbA3/jnEWZZa3WNZyDQAzK7SdDMzJ/aqumDykM5lVRodzkCveU1BuRhxZK9y2l/XAR2Sdu2aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723045160; c=relaxed/simple;
	bh=RI+3yVkIbTsBaDX4k5Qtq/bNNlaLMwk2mVtlK99zP9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sUllEuN+iW5M1vZTW7NwpAjKKwlITH2StSGF1SO3tofQ/nqAo/c/6HSTFmEgxS+pdaEvYxgrEv4JrKvtTNEhpsUxVbJACteukSAAakMHkYa5CFJ5Ht+pqJkqB0VZofy6YM8tFVAxV+dBsWt7iyfjPh6G3aKtd8P767wg9WyvxCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k8RwrJfo; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k8RwrJfo"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1fda7fa60a9so376405ad.3;
        Wed, 07 Aug 2024 08:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723045159; x=1723649959; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9CbD8V8xBx+xYu1GXsRQcpvSfOCRofW7N4CgCXoEGn4=;
        b=k8RwrJfoA1SqpiiO+eX0duUa2GOHuLfGR9qOM4xflfXqHmxA1Yy5yRFUtwvS/oGQYT
         a1a6AoI5Rhus/G/pTw8pmN8IKpynMJFESeWPAs7R21a0+VODZW95tj8gq0SXs8CIZTBV
         3KUef3lt9MAL6MN/1PX2vcwplb5N3CDo/dQ4mlyNfuuwGZ+CzVvT3j3Kh9wf8th05jAW
         2/HvK4YwHb70Jf/LlBYEthtiDvdiLOdF6H2aN0MXmgmFjoJ/Smzc7UN79cmLYOem47uz
         du/rYfSHxMnOUFOueeC3CHhmEQqg2dA3DX0LBoxbN//gynbIQfcpiqjhTh6SD04imHZv
         rcDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723045159; x=1723649959;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9CbD8V8xBx+xYu1GXsRQcpvSfOCRofW7N4CgCXoEGn4=;
        b=TmhZ4uMZC+M3dZ3BkJEsCG+gr0OvKnwZ6g5jnjewUHaBPNauvv10DV1cuJwlKncWfc
         8ZU8H6j8xIcAwDzimMuEtUNtUD3bh18cECrrrX1AUvkk0ynJTl42BFmCsHDo9NBpQiPO
         ZIV621VNegZEjUSTU2b8NvRWMTQtEBGOsIFSUctW39HWR14zyk8k2eCoIk7jf2WO4UFS
         hvQmhXepmV1bm3huuYSa1X7tfpfEYVjxBzKl9FMCCgkB0NZLSq0+n8c5L+iQFUs+nKmd
         KAvT0p6fxWKZ8kz7g/3yJey/7/hI7I15df75zlup9u9br9xuQ3hZlFmTqYGa7m4OSD5a
         rc9A==
X-Forwarded-Encrypted: i=1; AJvYcCVK6YcAKSuxS0Qed4A1ehDaOqDCn9K5BJTiPYR1m4r8MayWHSASsYFn8W8AZyj+r2w0aE5+jzZc9goIyfCSvAnGRIHtzNrV7bHCoT+RIB9lhnFSG9W4UealfdpyZ4L7fsPFUMq2iCupTSpP0vzh/w==
X-Gm-Message-State: AOJu0Yx9je3OU/wIMCEdQpX8mTuUE7zplNTJeae2APANLiE5zJa9LNzK
	klfZKbNtUQZSbqB5TG/dd5HsP6pKQE8wTvN7Dbt8gXPyzaoL8o1YKlaV6KWS
X-Google-Smtp-Source: AGHT+IFArYTQyPIXgHZ96DWXBE3P7beBq4UuR0NqZH3P8mXjhi+5QCEvOTkuxIhIxizDcM4Ev3mbMQ==
X-Received: by 2002:a17:903:41d2:b0:1fc:a869:7fb7 with SMTP id d9443c01a7336-1ff5746074cmr244965155ad.54.1723045158566;
        Wed, 07 Aug 2024 08:39:18 -0700 (PDT)
Received: from localhost.localdomain ([120.229.49.55])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff59297329sm108097375ad.247.2024.08.07.08.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 08:39:18 -0700 (PDT)
From: Howard Chu <howardchu95@gmail.com>
To: namhyung@kernel.org
Cc: irogers@google.com,
	acme@kernel.org,
	adrian.hunter@intel.com,
	jolsa@kernel.org,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 5/9] perf record --off-cpu: Dump total off-cpu time at the end.
Date: Wed,  7 Aug 2024 23:38:39 +0800
Message-ID: <20240807153843.3231451-6-howardchu95@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240807153843.3231451-1-howardchu95@gmail.com>
References: <20240807153843.3231451-1-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

By setting a placeholder sample_type and then writing real data into
raw_data, we mimic the direct sample method to write data at the end.

Note that some data serve only as placeholders and will be overwritten
by the data in raw_data. Additionally, since the IP will be updated in
evsel__parse_sample(), there is no need to handle it in off_cpu_write().

Suggested-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Howard Chu <howardchu95@gmail.com>
---
 tools/perf/util/bpf_off_cpu.c | 119 +++++++++++++++++++++-------------
 tools/perf/util/off_cpu.h     |  10 ++-
 2 files changed, 84 insertions(+), 45 deletions(-)

diff --git a/tools/perf/util/bpf_off_cpu.c b/tools/perf/util/bpf_off_cpu.c
index fae0bb8aaa13..24104d703242 100644
--- a/tools/perf/util/bpf_off_cpu.c
+++ b/tools/perf/util/bpf_off_cpu.c
@@ -37,6 +37,8 @@ union off_cpu_data {
 	u64 array[1024 / sizeof(u64)];
 };
 
+u64 off_cpu_raw_data[1024 / sizeof(u64)];
+
 static int off_cpu_config(struct evlist *evlist)
 {
 	char off_cpu_event[64];
@@ -139,12 +141,21 @@ int off_cpu_prepare(struct evlist *evlist, struct target *target,
 	int ncpus = 1, ntasks = 1, ncgrps = 1;
 	struct strlist *pid_slist = NULL;
 	struct str_node *pos;
+	struct evsel *evsel;
 
 	if (off_cpu_config(evlist) < 0) {
 		pr_err("Failed to config off-cpu BPF event\n");
 		return -1;
 	}
 
+	evsel = evlist__find_evsel_by_str(evlist, OFFCPU_EVENT);
+	if (evsel == NULL) {
+		pr_err("%s evsel not found\n", OFFCPU_EVENT);
+		return -1 ;
+	}
+
+	evsel->sample_type_embed = OFFCPU_EMBEDDED_SAMPLE_TYPES;
+
 	skel = off_cpu_bpf__open();
 	if (!skel) {
 		pr_err("Failed to open off-cpu BPF skeleton\n");
@@ -257,7 +268,6 @@ int off_cpu_prepare(struct evlist *evlist, struct target *target,
 	}
 
 	if (evlist__first(evlist)->cgrp) {
-		struct evsel *evsel;
 		u8 val = 1;
 
 		skel->bss->has_cgroup = 1;
@@ -279,6 +289,7 @@ int off_cpu_prepare(struct evlist *evlist, struct target *target,
 		}
 	}
 
+	skel->bss->sample_type   = OFFCPU_EMBEDDED_SAMPLE_TYPES;
 	skel->bss->offcpu_thresh = opts->off_cpu_thresh * 1000ull;
 
 	err = off_cpu_bpf__attach(skel);
@@ -304,7 +315,8 @@ int off_cpu_write(struct perf_session *session)
 {
 	int bytes = 0, size;
 	int fd, stack;
-	u64 sample_type, val, sid = 0;
+	u32 raw_size;
+	u64 sample_type_off_cpu, sample_type_bpf_output, val, sid = 0, tstamp = OFF_CPU_TIMESTAMP;
 	struct evsel *evsel;
 	struct perf_data_file *file = &session->data->file;
 	struct off_cpu_key prev, key;
@@ -314,7 +326,6 @@ int off_cpu_write(struct perf_session *session)
 			.misc = PERF_RECORD_MISC_USER,
 		},
 	};
-	u64 tstamp = OFF_CPU_TIMESTAMP;
 
 	skel->bss->enabled = 0;
 
@@ -324,15 +335,10 @@ int off_cpu_write(struct perf_session *session)
 		return 0;
 	}
 
-	sample_type = evsel->core.attr.sample_type;
+	sample_type_off_cpu    = OFFCPU_EMBEDDED_SAMPLE_TYPES;
+	sample_type_bpf_output = evsel->core.attr.sample_type;
 
-	if (sample_type & ~OFFCPU_SAMPLE_TYPES) {
-		pr_err("not supported sample type: %llx\n",
-		       (unsigned long long)sample_type);
-		return -1;
-	}
-
-	if (sample_type & (PERF_SAMPLE_ID | PERF_SAMPLE_IDENTIFIER)) {
+	if (sample_type_bpf_output & (PERF_SAMPLE_ID | PERF_SAMPLE_IDENTIFIER)) {
 		if (evsel->core.id)
 			sid = evsel->core.id[0];
 	}
@@ -343,49 +349,74 @@ int off_cpu_write(struct perf_session *session)
 
 	while (!bpf_map_get_next_key(fd, &prev, &key)) {
 		int n = 1;  /* start from perf_event_header */
-		int ip_pos = -1;
+		int i = 0; /* raw data index */
 
 		bpf_map_lookup_elem(fd, &key, &val);
 
-		if (sample_type & PERF_SAMPLE_IDENTIFIER)
-			data.array[n++] = sid;
-		if (sample_type & PERF_SAMPLE_IP) {
-			ip_pos = n;
-			data.array[n++] = 0;  /* will be updated */
-		}
-		if (sample_type & PERF_SAMPLE_TID)
-			data.array[n++] = (u64)key.pid << 32 | key.tgid;
-		if (sample_type & PERF_SAMPLE_TIME)
-			data.array[n++] = tstamp;
-		if (sample_type & PERF_SAMPLE_ID)
+		/* bpf output data */
+		if (sample_type_bpf_output & PERF_SAMPLE_IDENTIFIER)
 			data.array[n++] = sid;
-		if (sample_type & PERF_SAMPLE_CPU)
+		/* fill in an empty value, it will be overwritten by embedded data */
+		if (sample_type_bpf_output & PERF_SAMPLE_IP)
 			data.array[n++] = 0;
-		if (sample_type & PERF_SAMPLE_PERIOD)
-			data.array[n++] = val;
-		if (sample_type & PERF_SAMPLE_CALLCHAIN) {
-			int len = 0;
-
-			/* data.array[n] is callchain->nr (updated later) */
-			data.array[n + 1] = PERF_CONTEXT_USER;
-			data.array[n + 2] = 0;
+		if (sample_type_bpf_output & PERF_SAMPLE_TID)
+			data.array[n++] = 0;
+		if (sample_type_bpf_output & PERF_SAMPLE_TIME)
+			data.array[n++] = tstamp; /* we won't overwrite time */
+		if (sample_type_bpf_output & PERF_SAMPLE_CPU)
+			data.array[n++] = 0;
+		if (sample_type_bpf_output & PERF_SAMPLE_PERIOD)
+			data.array[n++] = 0;
+		if (sample_type_bpf_output & PERF_SAMPLE_RAW) {
+			/*
+			 * the format of raw data is as follows:
+			 *
+			 *  [ size ][ data ]
+			 *  [     data     ]
+			 *  [     data     ]
+			 *  [     data     ]
+			 *  [ data ][ empty]
+			 *
+			 * because embedded data is in BPF output, perf script -F without bpf-output
+			 * field will not work properly
+			 *
+			 */
+			if (sample_type_off_cpu & PERF_SAMPLE_TID)
+				off_cpu_raw_data[i++] = (u64)key.pid << 32 | key.tgid;
+			if (sample_type_off_cpu & PERF_SAMPLE_PERIOD)
+				off_cpu_raw_data[i++] = val;
+			if (sample_type_off_cpu & PERF_SAMPLE_CALLCHAIN) {
+				int len = 0;
+
+				/* off_cpu_raw_data[n] is callchain->nr (updated later) */
+				off_cpu_raw_data[i + 1] = PERF_CONTEXT_USER;
+				off_cpu_raw_data[i + 2] = 0;
+
+				bpf_map_lookup_elem(stack, &key.stack_id, &off_cpu_raw_data[i + 2]);
+				while (off_cpu_raw_data[i + 2 + len])
+					len++;
+
+				/* update length of callchain */
+				off_cpu_raw_data[i] = len + 1;
+
+				/* calculate sample callchain off_cpu_raw_data length */
+				i += len + 2;
+			}
+			if (sample_type_off_cpu & PERF_SAMPLE_CGROUP)
+				off_cpu_raw_data[i++] = key.cgroup_id;
 
-			bpf_map_lookup_elem(stack, &key.stack_id, &data.array[n + 2]);
-			while (data.array[n + 2 + len])
-				len++;
+			raw_size = i * sizeof(u64) + sizeof(u32); /* 4 empty bytes for alignment */
 
-			/* update length of callchain */
-			data.array[n] = len + 1;
+			/* raw_size */
+			memcpy((void *)data.array + n * sizeof(u64), &raw_size, sizeof(raw_size));
 
-			/* update sample ip with the first callchain entry */
-			if (ip_pos >= 0)
-				data.array[ip_pos] = data.array[n + 2];
+			/* raw_data */
+			memcpy((void *)data.array + n * sizeof(u64) + sizeof(u32), off_cpu_raw_data, i * sizeof(u64));
 
-			/* calculate sample callchain data array length */
-			n += len + 2;
+			n += i + 1;
 		}
-		if (sample_type & PERF_SAMPLE_CGROUP)
-			data.array[n++] = key.cgroup_id;
+		if (sample_type_bpf_output & PERF_SAMPLE_CGROUP)
+			data.array[n++] = 0;
 
 		size = n * sizeof(u64);
 		data.hdr.size = size;
diff --git a/tools/perf/util/off_cpu.h b/tools/perf/util/off_cpu.h
index 2dd67c60f211..eaf7be92472d 100644
--- a/tools/perf/util/off_cpu.h
+++ b/tools/perf/util/off_cpu.h
@@ -10,12 +10,20 @@ struct record_opts;
 
 #define OFFCPU_EVENT  "offcpu-time"
 
+#define OFF_CPU_THRESH_DEFAULT 500000ull
+
 #define OFFCPU_SAMPLE_TYPES  (PERF_SAMPLE_IDENTIFIER | PERF_SAMPLE_IP | \
 			      PERF_SAMPLE_TID | PERF_SAMPLE_TIME | \
 			      PERF_SAMPLE_ID | PERF_SAMPLE_CPU | \
-			      PERF_SAMPLE_PERIOD | PERF_SAMPLE_CALLCHAIN | \
+			      PERF_SAMPLE_PERIOD | PERF_SAMPLE_RAW | \
 			      PERF_SAMPLE_CGROUP)
 
+/*
+ * for embedded data to overwrite the original sample, duplicated sample types
+ * must be set in the original OFFCPU_SAMPLE_TYPES, except for callchain.
+ */
+#define OFFCPU_EMBEDDED_SAMPLE_TYPES  (PERF_SAMPLE_TID | PERF_SAMPLE_PERIOD | \
+				       PERF_SAMPLE_CALLCHAIN | PERF_SAMPLE_CGROUP)
 
 #ifdef HAVE_BPF_SKEL
 int off_cpu_prepare(struct evlist *evlist, struct target *target,
-- 
2.45.2

