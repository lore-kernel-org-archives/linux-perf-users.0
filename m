Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202851C32FC;
	Fri, 27 Sep 2024 18:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727463245; cv=none; b=kqFE6nwrejzjNv6Pgf769V1kFtVJ9fcIWE2dtd/L+Rwq+Ga98Cp7Z4IYTly9+x+ISsZxKA/MvP56D0ousR7Q4PUGUxUumtufjNobFvco3Cgigoj0paHgdi69s+MPOopttf80UJ2yZGnTEVraJjDGsW0ZTUI9fwi16+2dMvf5I7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727463245; c=relaxed/simple;
	bh=K1q2xLCuxeoesKIjk0h8yto/lXtLTYRLvejIlbxFPMg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IfNioCashD7JClScFurSq6mPgYW/X24rqevrPYZ8qIOeo98OydjGr0JayabQEAkqWSDzoX5Ihh2fcq/p3EXYRIONV4nqgWO9/rYM53GEQ3908yVItHWdj26LC/yDR9V9XDEZC47vOq0OqygTW1lMkeZxqLeliyK5UvVsdJ/4trs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AYxCJQGt; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AYxCJQGt"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-718e285544fso1998862b3a.1;
        Fri, 27 Sep 2024 11:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727463243; x=1728068043; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EiQs2GbMjfrDlXFijeVJx4a8DvVOhQx26OFbZSLijn0=;
        b=AYxCJQGt9y2ii698llgHAaYtZxRzccWPTLPkTMP7dEgYkYg6Y843gcceiOEfpCqQPG
         GYlPkMqwlbYdTjtoTB9vcmZnmr9mjF9XxVFutRXtiSqyXnVFSH8qdvWcTvL5+RkhQ9t0
         hb5O/PWdt5i0cS1c268TBQuBjxg4O1neMrdHDe0QEYIOxmfWTM6vsHfrGV88A24fRTYh
         yQrtpUUt4Edj1xGarvzY5KddQffAN2Z4NITXgqxD7Cv/Q2RU1mORwlVeMV+hzkY9J3Tp
         F28y/qkwEcetTuIgPbn4Uo0d91uM63WCbu4/LPNFyvgCNRCQolApTq9is7SI+WS9bdVL
         snnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727463243; x=1728068043;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EiQs2GbMjfrDlXFijeVJx4a8DvVOhQx26OFbZSLijn0=;
        b=bMRKHDg+Q4L9tduHnlOiFka8hoXMAzQWIBkOxjjgsejYM6POCzW6Ryp2C5hSYa+Vup
         dPWV6JCsZOM2KNiEJzt7sNvcF7BFt3YS7M+7FbcNdktD/9wpwtmUT4U0MIu6G7hu24Ih
         RmCHLmsic/lEpRcfyeROZyEYwhPcBOf9y84WjpBta0gdmA//bBxbGEuCYh8EXhUOHfWN
         BrmxQW/zIrgkmlRcwq0SQPd0XPQSJCW2fHYTe4WeLWeV1jedgHCWw1LzTWUTdcpl4HKM
         6VmBnVY78nT43T5v40cCOTfKViRMjuS9ep2r7UREWU1Ebt4LNKIwi8selJEQGrz3Qu5H
         Zd1g==
X-Forwarded-Encrypted: i=1; AJvYcCVxYMBcJhVo/UV8+iuDv9ww9sznHLa9Wj2v4OC99ysKe7YMqM20/0bsaZy++Pjm+VHf3dCue5xqYGIxLf0=@vger.kernel.org, AJvYcCWxRBCMXglfw9M2jmsIvBNw89ucPyjpCwJppiXhDaRJU62RZ+NuOKae5IbkMgnVlnjIKauxMg4ZZtiOIW1/Cl72+A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxpJA0i9B0G2cqSEru9AtiahAvaKGr5agBgJA/jgK/mx7Tu5UIE
	ZYWFeWnijPRuBZHcRHt6VGoSizg0wm15wFNtD0KOuD1RFXjV2YRk
X-Google-Smtp-Source: AGHT+IEvvDtpdoN3quf3yciXgoF6FrQWmoxfPNG6O6sXtZkqBDFkL4uAIV+fiUxAKDO4LeKCyGUHXQ==
X-Received: by 2002:a05:6a00:2396:b0:717:869c:2c60 with SMTP id d2e1a72fcca58-71b2607039fmr6471824b3a.26.1727463243394;
        Fri, 27 Sep 2024 11:54:03 -0700 (PDT)
Received: from mbp.lan (c-67-174-206-244.hsd1.ca.comcast.net. [67.174.206.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b264c23b6sm1930244b3a.88.2024.09.27.11.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 11:54:03 -0700 (PDT)
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
Subject: [PATCH v5 5/8] perf record --off-cpu: Dump total off-cpu time at the end.
Date: Fri, 27 Sep 2024 11:53:37 -0700
Message-ID: <20240927185340.658143-6-howardchu95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240927185340.658143-1-howardchu95@gmail.com>
References: <20240927185340.658143-1-howardchu95@gmail.com>
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

