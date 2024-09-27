Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1774E1C3F1B;
	Fri, 27 Sep 2024 20:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727468880; cv=none; b=BfSGoE64P4rzEESzTUfqUxceyLfh+V9LlH45iNw+FMubQduice8VBtypNYtqVQ53zyJ0H/pMmnNg/M+Hoo58b3S5reDaTDbGBImYAIGKP5Q+hsJL3QchvcoQGzT+6/N/7ddrcXA62BuvK+UlE7k91OMNr8GUT4AgPsPsKJzoaGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727468880; c=relaxed/simple;
	bh=K1q2xLCuxeoesKIjk0h8yto/lXtLTYRLvejIlbxFPMg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U8BhT8fEuNsOAeUgvOzgRN+3cKBhIRbclHoehkTuv/l80lcX1MYaOjOyCJRjSGC5Yw3y8O7KTgdMbM7CqI07xKLiLtL+cQ+T+QR+jUf+0SpKiM9hxcEV8ouO3WItwlmxOTM7raV35rSO4HNNqlJZ/fqHjA7x1ZOzbSlPzkIY83s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VguJrTbB; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VguJrTbB"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7d50e7a3652so1739384a12.3;
        Fri, 27 Sep 2024 13:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727468877; x=1728073677; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EiQs2GbMjfrDlXFijeVJx4a8DvVOhQx26OFbZSLijn0=;
        b=VguJrTbBG4prltPtd4PmfGeAejGaq0uZUMFfSK47OKUU3SFDSNrD/t6mOW0LsWYSvZ
         dQkU7ruFc7p0UtMSsMj8Z6MAwMLdLzGyPBk6zDzgiewrHWyfB7xayeQe9y2m/Bs2JZZ7
         2m+CYzYQLv3frEcvb5iIbcMuQ+/cT7e/qdFr+fxKk2O/vtduBJ2T9AWjXcoXZ9TIAyWT
         SEgdRS7S/iFeb/pG9dJMjecupF+bigJfmRC32RLpvfRpN+sElS8VHkYcn/zaB/RhFi82
         aIwqVuRxBM7jDLndTf2XT61L6l/VYETwgE85uCWkMhGsOIYrfanjqm6tx/hBbv720js8
         QPJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727468877; x=1728073677;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EiQs2GbMjfrDlXFijeVJx4a8DvVOhQx26OFbZSLijn0=;
        b=NY6U/aeMfDBsjpt6zFCsuVU+TtewkQwlOLmXx2I5+xeztDsix2EGgrIeJRyk45RdH1
         bwOs0SJvdaTHgK04WSEUXl5RucnNTPU/PewPAVvBoUERgsOSQ42OyEjy2N6sZeWrMT9P
         JuUfBk/r0QE2fcHqL9Rz3g0/0YeSGIOAi99ilG78+M+CfWzLWHxpAGqI2CxftCKUNIKT
         EfLgM8pvmANq5nsSWDChaZtn8cqTmnVSQrB1vIlG/0io3gJCNEr6TcJ9XUanNZ3hBzA9
         EnuAk8m1+wm0SWyEKaMAGlogs8rLk8V8g3V8yQuvhbX97bJ9C/bKZZWuD0DN8U2mALi1
         327A==
X-Forwarded-Encrypted: i=1; AJvYcCVTeYAGJc+2fdeXf3lXXKrbG/qKua/MM1VE4r9pL6rfxrfq9N4/XCLEVKljyPw7x3CIfBKG6XRq1gKMVkk=@vger.kernel.org, AJvYcCXPyJRPsTgLkksul1rovAUCrvKjoASwee4tou0LwI8jxT2f/MB7xzt0hALTAQU0ehdqx0XN18YhyVrUXboTpjHKdA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywos40B1hcahuQKhNkA6a7RWfUsjUgco4S4I8rK2sA35tn7e9Ma
	xhSeV8Ze69de/Hj77Wa741KsWHthlOZeXvWnF0vWxOWeKpqR46ol
X-Google-Smtp-Source: AGHT+IF5BzhffwVtfCcMIYtigPSk3mX5TJgQXW8I8SL08Q1nbWCkqQzQsMKN9vBzTg+HNcZn2FmaMg==
X-Received: by 2002:a05:6a21:3418:b0:1cf:6c65:5dc with SMTP id adf61e73a8af0-1d4fa7eecb9mr6019746637.49.1727468877207;
        Fri, 27 Sep 2024 13:27:57 -0700 (PDT)
Received: from mbp.lan (c-67-174-206-244.hsd1.ca.comcast.net. [67.174.206.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b26524c32sm1998410b3a.157.2024.09.27.13.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 13:27:56 -0700 (PDT)
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
	Howard Chu <howardchu95@gmail.com>
Subject: [PATCH v6 5/8] perf record --off-cpu: Dump total off-cpu time at the end.
Date: Fri, 27 Sep 2024 13:27:33 -0700
Message-ID: <20240927202736.767941-6-howardchu95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240927202736.767941-1-howardchu95@gmail.com>
References: <20240927202736.767941-1-howardchu95@gmail.com>
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
 tools/perf/util/bpf_off_cpu.c | 116 +++++++++++++++++++++-------------
 1 file changed, 72 insertions(+), 44 deletions(-)

diff --git a/tools/perf/util/bpf_off_cpu.c b/tools/perf/util/bpf_off_cpu.c
index f7233a09ec77..2a1cfd7e0b09 100644
--- a/tools/perf/util/bpf_off_cpu.c
+++ b/tools/perf/util/bpf_off_cpu.c
@@ -138,12 +138,19 @@ int off_cpu_prepare(struct evlist *evlist, struct target *target,
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
 	skel = off_cpu_bpf__open();
 	if (!skel) {
 		pr_err("Failed to open off-cpu BPF skeleton\n");
@@ -259,7 +266,6 @@ int off_cpu_prepare(struct evlist *evlist, struct target *target,
 	}
 
 	if (evlist__first(evlist)->cgrp) {
-		struct evsel *evsel;
 		u8 val = 1;
 
 		fd = bpf_map__fd(skel->maps.cgroup_filter);
@@ -280,6 +286,7 @@ int off_cpu_prepare(struct evlist *evlist, struct target *target,
 		}
 	}
 
+	skel->bss->sample_type   = OFFCPU_EMBEDDED_SAMPLE_TYPES;
 	skel->bss->offcpu_thresh = opts->off_cpu_thresh * 1000;
 
 	err = off_cpu_bpf__attach(skel);
@@ -305,7 +312,8 @@ int off_cpu_write(struct perf_session *session)
 {
 	int bytes = 0, size;
 	int fd, stack;
-	u64 sample_type, val, sid = 0;
+	u32 raw_size;
+	u64 sample_type_off_cpu, sample_type_bpf_output, val, sid = 0, tstamp = OFF_CPU_TIMESTAMP;
 	struct evsel *evsel;
 	struct perf_data_file *file = &session->data->file;
 	struct off_cpu_key prev, key;
@@ -315,7 +323,6 @@ int off_cpu_write(struct perf_session *session)
 			.misc = PERF_RECORD_MISC_USER,
 		},
 	};
-	u64 tstamp = OFF_CPU_TIMESTAMP;
 
 	skel->bss->enabled = 0;
 
@@ -325,15 +332,10 @@ int off_cpu_write(struct perf_session *session)
 		return 0;
 	}
 
-	sample_type = evsel->core.attr.sample_type;
-
-	if (sample_type & ~OFFCPU_SAMPLE_TYPES) {
-		pr_err("not supported sample type: %llx\n",
-		       (unsigned long long)sample_type);
-		return -1;
-	}
+	sample_type_off_cpu    = OFFCPU_EMBEDDED_SAMPLE_TYPES;
+	sample_type_bpf_output = evsel->core.attr.sample_type;
 
-	if (sample_type & (PERF_SAMPLE_ID | PERF_SAMPLE_IDENTIFIER)) {
+	if (sample_type_bpf_output & (PERF_SAMPLE_ID | PERF_SAMPLE_IDENTIFIER)) {
 		if (evsel->core.id)
 			sid = evsel->core.id[0];
 	}
@@ -344,49 +346,75 @@ int off_cpu_write(struct perf_session *session)
 
 	while (!bpf_map_get_next_key(fd, &prev, &key)) {
 		int n = 1;  /* start from perf_event_header */
-		int ip_pos = -1;
+		int i = 0; /* raw data index */
 
 		bpf_map_lookup_elem(fd, &key, &val);
 
-		if (sample_type & PERF_SAMPLE_IDENTIFIER)
+		/*
+		 * Zero-fill some of these fields first, they will be overwritten by the dummy
+		 * embedded data (in raw_data) below, when parsing the samples. And because embedded
+		 * data is in BPF output, perf script -F without bpf-output field will not work
+		 * properly.
+		 */
+		if (sample_type_bpf_output & PERF_SAMPLE_IDENTIFIER)
 			data.array[n++] = sid;
-		if (sample_type & PERF_SAMPLE_IP) {
-			ip_pos = n;
-			data.array[n++] = 0;  /* will be updated */
-		}
-		if (sample_type & PERF_SAMPLE_TID)
-			data.array[n++] = (u64)key.pid << 32 | key.tgid;
-		if (sample_type & PERF_SAMPLE_TIME)
-			data.array[n++] = tstamp;
-		if (sample_type & PERF_SAMPLE_ID)
-			data.array[n++] = sid;
-		if (sample_type & PERF_SAMPLE_CPU)
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
-- 
2.43.0

