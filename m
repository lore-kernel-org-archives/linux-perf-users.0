Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCEC1152196;
	Thu, 12 Dec 2024 02:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733970295; cv=none; b=okrMztc7TP7HeH1p8EEXec8kWEk3mLVLWFePnG4AYzP4bUPKuLxEw7fMKqMxYaRQM49m0sEvXys9bSOltkCEfdBloGqTChCkWsA7kcyJ58HlrX/JD6zzKhC2ZcNEsvTz742BrFVOnaZyXz4oRwebdG+v68tY5ZypRUgH3KRQFuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733970295; c=relaxed/simple;
	bh=X78f+c1TDnm2CEdrRJd3WavyM72MSbW/aHQcCoAKZRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CAIk/yO70dDSr6KbkFhWmnjAgVOQTdmKqVjGC4GxZUzRoFGzADiM6N/MHHu/DkWJCcZo7NComTHQAQ4Gfa4/WABgxGMfbg576I59cod0F5dFb3d6ZgW2m83brKu09SBBQ7m1DfYQDrqY1w12R6TsdeTpGlpyunkcJ5FkFybxgbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N9MjJ3nw; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N9MjJ3nw"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7fd2ff40782so143527a12.2;
        Wed, 11 Dec 2024 18:24:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733970293; x=1734575093; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iRKO0sSW06Oh7i/UgLwemlC4hofAQlpyGMLJXo3S+e0=;
        b=N9MjJ3nwc/9DSOXjkBFlpXnEzCcTsOvMPTGHWzJzCZB5OCL1s/szdY4KutHfQF8s7M
         NYEr2spc35TWgoEud7arlbX8heWAI9a37/UcXiE9RrCPqdFC2zrGf6LYS8yzc/TUEpMi
         JDT04NDAYPHCdhZ5JlIjrVwpN/USAZG2y1kel+lDv1Fa0IRAs5iUOt6+PJyy4q5F9IyY
         LsEw3KNZzEMsfoRytLCsSPaS3nWDOTU1ouMVxDcytgtqsv2N/eCnSjQbf9ZlM+m8ZCS0
         SrM8qfGELubHHF9Azr0Ji37lQgFNf4o8uorzcMD831CSADYWTH3PvKS02fI9u2yngkdF
         +/Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733970293; x=1734575093;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iRKO0sSW06Oh7i/UgLwemlC4hofAQlpyGMLJXo3S+e0=;
        b=QwueeYcMt8odd+DvFjU2UQp3ybp3CeFl0ZLotK3uqyX8SlRoIHmnlRXSV6TDE+j6wQ
         9iTcCwi8MpjLLUjz4Xgf+rp4FDQuv5SIrff+VKEDVtJr+IjKJumHNsYtKv6cKZJh2SxM
         RKo9TeKmenGc5U1ufJI1/DTl0vdn1m1RK7Nam1MMHInz1mZWYSrQ98MGc8JaFStOe9eL
         oqQ+lA6haeJh5ipxxISNS2itlkbW5dT9qIH9U3ic/HKKV0ukiSRhsKUiBMSUw5qgowcO
         eqQot3x30x6eRMN2j7CCTziuCVVICIqfvIgyu3hkz9rDEJScRbLU7WrNtm3X1scs/S+4
         9eOg==
X-Forwarded-Encrypted: i=1; AJvYcCVVHH1kfyLyuUaH4dCC1xrcpCOcnK78q+9s/2JnOhX1ryceu2mXKxlEHwUqtZ++8k/4tsWQyv1G7i1eapvGgrlGbA==@vger.kernel.org, AJvYcCWNOQnGzQICX6rajTDhIyJUaAkIMchEqDgpNDW6sM4kIxaS2ujtgR3Nvn3Do13ImETlbLjc4NrsMI0l3bE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs2NpkqJw9OIRgJ7tk8mwWymtW2OuLC7InuUm+h1rlD//KaoC9
	LB1ZKsZhkgeF6GMIvGEkMmSwnbv89MMBMtnzv2B2h0Wu5Xjoet9T
X-Gm-Gg: ASbGncuDevlZ2bZZva4t1AzCZzZla1jl06NKz36oaIg+i1aJjn7k3LCLrRXEzVXFXIq
	xQ2SstcthsGCSg22hl4vFT3zc4Z2EX4qN0/uN74CAICImb3tT82/pxB8MnS5WVO0Kd/+fjX+SVh
	Uw3NhNekaricQXC26uB9lzuntGAaRoWk8JeYx8mcdWCL1Y0//M6H4o89WD5rnpnt0DYQpRdIchJ
	rrA1T/zRvSYMqwfmZZ3swuvA8320vbLt+494A+D247BYvPQu+o/M3iS1IAmukpTmNqEG0fWzYn/
	4XnehAj1Q5xJ
X-Google-Smtp-Source: AGHT+IG1OvB6kBCuTKYtRXn+Xq0Dcnx6LNv5Hbou76sPYhOuRUhxuSh1sIxwVOjYMQgo7SnyIuJxTw==
X-Received: by 2002:a17:90a:db92:b0:2ee:fa3f:4740 with SMTP id 98e67ed59e1d1-2f1280e1420mr8518639a91.35.1733970293135;
        Wed, 11 Dec 2024 18:24:53 -0800 (PST)
Received: from mbp.lan (c-73-202-46-50.hsd1.ca.comcast.net. [73.202.46.50])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f142daeb5asm112583a91.12.2024.12.11.18.24.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 18:24:52 -0800 (PST)
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
Subject: [PATCH v12 03/10] perf record --off-cpu: Preparation of off-cpu BPF program
Date: Wed, 11 Dec 2024 18:24:13 -0800
Message-ID: <20241212022420.1035999-4-howardchu95@gmail.com>
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

Set the perf_event map in BPF for dumping off-cpu samples.

Set the offcpu_thresh to specify the threshold.

Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Howard Chu <howardchu95@gmail.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20241108204137.2444151-5-howardchu95@gmail.com
[ Added some missing iteration variables to off_cpu_config() and fixed up
  a manually edited patch hunk line boundary line ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/bpf_off_cpu.c          | 23 +++++++++++++++++++++++
 tools/perf/util/bpf_skel/off_cpu.bpf.c | 11 +++++++++++
 2 files changed, 34 insertions(+)

diff --git a/tools/perf/util/bpf_off_cpu.c b/tools/perf/util/bpf_off_cpu.c
index 9275b022b2ea..84c3bf6a9614 100644
--- a/tools/perf/util/bpf_off_cpu.c
+++ b/tools/perf/util/bpf_off_cpu.c
@@ -13,6 +13,7 @@
 #include "util/cgroup.h"
 #include "util/strlist.h"
 #include <bpf/bpf.h>
+#include <internal/xyarray.h>
 
 #include "bpf_skel/off_cpu.skel.h"
 
@@ -60,6 +61,9 @@ static int off_cpu_config(struct evlist *evlist)
 static void off_cpu_start(void *arg)
 {
 	struct evlist *evlist = arg;
+	struct evsel *evsel;
+	struct perf_cpu pcpu;
+	int i;
 
 	/* update task filter for the given workload */
 	if (skel->rodata->has_task && skel->rodata->uses_tgid &&
@@ -73,6 +77,25 @@ static void off_cpu_start(void *arg)
 		bpf_map_update_elem(fd, &pid, &val, BPF_ANY);
 	}
 
+	/* update BPF perf_event map */
+	evsel = evlist__find_evsel_by_str(evlist, OFFCPU_EVENT);
+	if (evsel == NULL) {
+		pr_err("%s evsel not found\n", OFFCPU_EVENT);
+		return;
+	}
+
+	perf_cpu_map__for_each_cpu(pcpu, i, evsel->core.cpus) {
+		int err;
+
+		err = bpf_map__update_elem(skel->maps.offcpu_output, &pcpu.cpu, sizeof(__u32),
+					   xyarray__entry(evsel->core.fd, i, 0),
+					   sizeof(__u32), BPF_ANY);
+		if (err) {
+			pr_err("Failed to update perf event map for direct off-cpu dumping\n");
+			return;
+		}
+	}
+
 	skel->bss->enabled = 1;
 }
 
diff --git a/tools/perf/util/bpf_skel/off_cpu.bpf.c b/tools/perf/util/bpf_skel/off_cpu.bpf.c
index c152116df72f..c87132e01eb3 100644
--- a/tools/perf/util/bpf_skel/off_cpu.bpf.c
+++ b/tools/perf/util/bpf_skel/off_cpu.bpf.c
@@ -18,6 +18,8 @@
 #define MAX_STACKS   32
 #define MAX_ENTRIES  102400
 
+#define MAX_CPUS  4096
+
 struct tstamp_data {
 	__u32 stack_id;
 	__u32 state;
@@ -39,6 +41,13 @@ struct {
 	__uint(max_entries, MAX_ENTRIES);
 } stacks SEC(".maps");
 
+struct {
+	__uint(type, BPF_MAP_TYPE_PERF_EVENT_ARRAY);
+	__uint(key_size, sizeof(__u32));
+	__uint(value_size, sizeof(__u32));
+	__uint(max_entries, MAX_CPUS);
+} offcpu_output SEC(".maps");
+
 struct {
 	__uint(type, BPF_MAP_TYPE_TASK_STORAGE);
 	__uint(map_flags, BPF_F_NO_PREALLOC);
@@ -97,6 +106,8 @@ const volatile bool uses_cgroup_v1 = false;
 
 int perf_subsys_id = -1;
 
+__u64 offcpu_thresh_ns;
+
 /*
  * Old kernel used to call it task_struct->state and now it's '__state'.
  * Use BPF CO-RE "ignored suffix rule" to deal with it like below:
-- 
2.43.0

