Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34BD3239082;
	Thu,  1 May 2025 02:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746066508; cv=none; b=T1VrWLLukdZz2VAJzcqPUqGskl9wQoJCIjdxq3quIn3ZWHJJZ3Li6IvGQGIaicmfXIwHJaSD4PEUhMMAm0Qm1jaKbpc9fkCroMJfxxKOve6JRCDsBAgHbwFtdmrnAqyJPm2Xn8psTohUxmPydsXNOOxhGkZ6KFMbd3GOw6JuEuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746066508; c=relaxed/simple;
	bh=EjZkhDjLf8FF0DjSXesgOJ/arnnm6yfJ+pBD7u5LPM8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q6Sa5snAxAuYED1yC9cno8pEzl2tIYbWYgfgF6bREeNhvmkYzYhK7ZU/Yi8Rqog4P7l2AFUaXuYQi6GXOBJpI6yUdRH2B7l1SYBJh7OEJzywLczcK0fET/nwsOyqLpRlVKhaRg2Gclm53YJ0il5ZZCvqZ5eI1+wJMOGbppn42C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XVI0VS0b; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XVI0VS0b"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-739b3fe7ce8so569658b3a.0;
        Wed, 30 Apr 2025 19:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746066506; x=1746671306; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tGiokA3zKaSxSjRFI8xP0E2QGWuB8HpmpdNiCB3BS38=;
        b=XVI0VS0bbSCO0dgSecD5GhuUuC0ztL7SD4KmW05pJUYz/+NWZ2XWPEOGNOW77qhKxx
         O09tVkVhHR8EZ6hm4adf5YygwL+FxbKVt9ehDETKJTy2HO5woV3RGC5BHVa+onSnUMER
         BpR329kSgbAb4o3Gef2/hC/JXveZC1JEoZEE5PGRK8B4QQm+00v5jOoU7rpY/mywiC5x
         ZNLEKPtC9aQ4UWORhcx756klLPkPbdRFybWDCguMctHyN4iGtNLw4CvR1HDwPgrcf3HQ
         vhIH68A2rJj9Xxa+AwbaRauPwe7fbkJVwVAz1CiAEnc4n4VpL4seF685uesFyTTGb++J
         gUwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746066506; x=1746671306;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tGiokA3zKaSxSjRFI8xP0E2QGWuB8HpmpdNiCB3BS38=;
        b=JNhjUXgkfmggOQdR3ucSPZuiEPfUKCwMRUrTEhTN7i6v9eYgli1Z+2ePU1CCH7SdX/
         oymZ1WdK82DOCITHLYt6wrTvO57oivp+xBDBYvQZjl0uQpSE1t5jSNZ+XhvxEse4qHZo
         E5bsbIq2+O4voO50il7shSdah6Wq9hcZLcIQjMSM8qMn41MGRPpKOHFLAFxt+vvka0BZ
         bmX2D9HcWqHRuEKaLfsT+0l5sLrG/mkzdblIgI8nB5HwbDiQ3oCzVgotoLROoMTBGNED
         7ZfqzxXRO3XmZdTei+TE3lB+K377Xuy2BEzII4KJNRUpmyLYpYGiZHEMnZOBoq/JlRnk
         I4aQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2I9RAPO/iojKSFVyhFb+cfr2oNjnLNbKaDHQsKwtOl2AX1yl7VrjJebw/PvaSahpWMlKTR+22WvJkQHY=@vger.kernel.org, AJvYcCWjH0M1L8MIX9zM93jMymdStq3pI8dDGBTapxMHx5A1MC4l3K2cAqUobCwakBjZ7C3/r55PXtPCuhD/1etzUFK4Ng==@vger.kernel.org
X-Gm-Message-State: AOJu0YxD4Uk3dsTCaHYdaM3oz85hAK3c7pCENOv+sl9T6W1rXZTnVusS
	XHB3RZ8mIuEuUplgaUoXgQ2nM7wVOvb92ER10wVvZvBfmQoN8Giz
X-Gm-Gg: ASbGncvBnpU7qVDcl7OUmTTgiai7sD2WsGgpBV7yV8tpc5PPUf0UXY7aDvfvRoQVIvP
	aqTWysu4xFxitMTMrP+SXo7jCq+08U2OjqL5CsCqVaXoem5ybxvEPpLNSirp0DRVXfUwvQMJnoM
	A9TF+7+k8kvZKnX3ZLBPqygJMSLRMRC2Vmacz49pa9Mp5G1CNGTP9gRAcyfSH1o+p6/VrRuROPM
	6Ii9Tvk4X7AwCcJ6C0lasfyW/lZ3tUZwqvVQV+W1Xd6HIQeja7S0bVdu1lS5YS7G5U6n8zNiewD
	Fa5sNrwqY3A+vyRtTX9LqBzghyA202ErCLzH2Y9xawugs9zfF0+KmiuTRD7Tiosvz4rIR0V8adg
	EnUtVNbjl2w==
X-Google-Smtp-Source: AGHT+IEipX1gYi7PaCzq9l2JDUbdhHcMGSYYfKkXqngEzcvHihjzaGEQt99sELSTwa2BOZTr8+2AEg==
X-Received: by 2002:a05:6a20:e687:b0:1f5:9961:c40 with SMTP id adf61e73a8af0-20a876446d4mr7314157637.8.1746066506266;
        Wed, 30 Apr 2025 19:28:26 -0700 (PDT)
Received: from howard-ubuntu.lan (c-73-202-46-50.hsd1.ca.comcast.net. [73.202.46.50])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74039a8fbe7sm2459599b3a.160.2025.04.30.19.28.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 19:28:25 -0700 (PDT)
From: Howard Chu <howardchu95@gmail.com>
To: acme@kernel.org
Cc: mingo@redhat.com,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	peterz@infradead.org,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	gautam@linux.ibm.com,
	Howard Chu <howardchu95@gmail.com>,
	James Clark <james.clark@linaro.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v16 08/10] perf record --off-cpu: Dump the remaining samples in BPF's stack trace map
Date: Wed, 30 Apr 2025 19:28:06 -0700
Message-ID: <20250501022809.449767-9-howardchu95@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250501022809.449767-1-howardchu95@gmail.com>
References: <20250501022809.449767-1-howardchu95@gmail.com>
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

Tested-by: Gautam Menghani <gautam@linux.ibm.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
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
index 1975a02c1683..c7fde66bb8f9 100644
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
@@ -313,6 +315,7 @@ int off_cpu_write(struct perf_session *session)
 {
 	int bytes = 0, size;
 	int fd, stack;
+	u32 raw_size;
 	u64 sample_type, val, sid = 0;
 	struct evsel *evsel;
 	struct perf_data_file *file = &session->data->file;
@@ -352,46 +355,54 @@ int off_cpu_write(struct perf_session *session)
 
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

