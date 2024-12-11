Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19D71F37C9;
	Wed, 11 Dec 2024 22:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733954439; cv=none; b=SnHvOZUPg1bwfFspoAPCv9nACCEEyBCSzNb8VGZF+OQKUBNyz5a0I3QmoTPDjLEIK9bzyBwenoPz1HQ/VOnVbMjZ90T4jOh80yKD/Y5LwWCoa2qRyE/sMFjqBhIt85DdWqyrTQJoZc9HwCxstr4WIVPV6VqVa//wp9ZlYOnYZTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733954439; c=relaxed/simple;
	bh=goTdjk11qmBk6a5P1AA+giS5yljV5oLTjYAh1YgVF+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eutmhVE1TOlc8xjc7DSO2u8vfoJ59dFWX4wOzxEO+VYAIzGKMbE1dgAcd7IXtQNr5Xg26bCMUwzxqVRBsq/yCQkkjt6pcP3+NKDU9IuQlM/60W0qR7Gx7sJX+dxKyodsLFc4VTnmtcnKAPOAI/0nfFX0t8upwuQnR+ZbRDqMilo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ATEi6aeZ; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ATEi6aeZ"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2ef70c7efa5so4080468a91.2;
        Wed, 11 Dec 2024 14:00:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733954437; x=1734559237; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L7PbFB0EtVCviJ5bhbaIb04d6odUROmdh06maH/pBNc=;
        b=ATEi6aeZtfFIB5wHujNLRBnBKbminH7YL+DgRRavnqpXELdKPaEe7JIMYfAMdu4Wop
         LGSROYCKz57uwJBAlNZAS/u1gzPXMD/b1Dgz7U50N5SzHIlLHmSP2M0Xi6GcPusstUHU
         Ug7LUW7cmg+MIUGfqDn3wQgqJyneKk8YSphPKz18+2PhRwktmZ0iWkTgxjrY/4DSl2Yp
         WxnelqXsxlvhPIPgdyLYdzbIWm9AxXLa8kOYyP11jViyB2DunA9qRAPQHHi72a+j0rQF
         syMHi7L5Goo77TMS/vDpAxDyDc95Rx+uOmzw7/jTdjjjVX1nzSWns9PRwGHMeV/mkkzU
         aKcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733954437; x=1734559237;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L7PbFB0EtVCviJ5bhbaIb04d6odUROmdh06maH/pBNc=;
        b=Y2NA5/MMj5xyKvhF/pG9U68Y+Ie+6gS3Lhqz4weGW4sPSU/HgvSeYmbk8Ovx33K+2k
         mA8i0+sWfqd6vgnYq91+WjPJFFCz/umJqHj3YGgyYEDZqOuqr5u38tEkJuL4Yoncaryu
         ae2M9IytpsrwvpR2p4Cb3e4jfK1jkDsLkQWPFjj32dJD30QlAWcD5nRh6aEgl9K9vF+f
         bUQmNUX5vXuwC3DZYXISjddAstbEuHkpcDP/q0sWQrjLUHSgDOFBcDRUebNUlMOVRih0
         E5xzqb7Fy/K8bSREvWCAr51AkcF3xotUyspHJdTXV5VqnjZ9sMzqObk/HlPEoSPYcoIC
         I4qQ==
X-Forwarded-Encrypted: i=1; AJvYcCUoicjsgGaJo9wI5NovtLnA0b1cL9WhRFWSST9RUTwCm7MeZFw9cBCjEllkqSYsdMYASHM0gKdIDVn/qQ8zpTwG6Q==@vger.kernel.org, AJvYcCXnlhRfOOVeJOUWsRI3b6GnXC6eXYVf7WBSXxHtxT8WBOict5xobMDEsuev1YpqpGACJMkHX7daVcXQI2s=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywbq7taDM8MYWgc8U8pOAG/PAFxxpbKlPFcIE481DJTu71Dvlfd
	OEiFEAc5Nc+Wtr3A0tiHIuQ1hzsZvCpNbMBVedkj5O7feTOE7pqt
X-Gm-Gg: ASbGncuir+PYzB663wlYrdhe63urWID44ziajlAgiJEQ1yYas6Vx5msrxzVgs5AZT62
	myyzsD6/4vgw/Km2QLo56bTobEJuIbzeIN+zUY/Xbp7YqLmpuu8zSHLv0k3GrC51y7X3PlHUVMO
	XUogR5Dg0FcVdH5PxJ6RHs5FY7tTqs9BdhorJHhjWoP4UyP4VamTEw55CSGuHKmvPara4ZIM8z1
	4E3uo+K3+G552/GAK0sAkRclikz2Efv+8t2Ow8g1xh3uaHxyTq/0kDfbQ21S7xDGctar4TVxSmJ
	qn/t79r3Jg==
X-Google-Smtp-Source: AGHT+IHpNgluicFatyt1Ht9/5l9c7EW3bCB0pLr2d9tguk/ehE0k3pxWArTwymRCVaou9OSI01qdRg==
X-Received: by 2002:a17:90b:3e82:b0:2ee:94d1:7a9d with SMTP id 98e67ed59e1d1-2f12804a1cdmr6273017a91.32.1733954437077;
        Wed, 11 Dec 2024 14:00:37 -0800 (PST)
Received: from mbp.lan (c-73-202-46-50.hsd1.ca.comcast.net. [73.202.46.50])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef2700cccasm13912665a91.22.2024.12.11.14.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 14:00:36 -0800 (PST)
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
Subject: [PATCH v10 08/10] perf record --off-cpu: Dump the remaining samples in BPF's stack trace map
Date: Wed, 11 Dec 2024 14:00:12 -0800
Message-ID: <20241211220014.931479-9-howardchu95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241211220014.931479-1-howardchu95@gmail.com>
References: <20241211220014.931479-1-howardchu95@gmail.com>
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

