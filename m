Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0778D1DED7C;
	Thu, 12 Dec 2024 23:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734046048; cv=none; b=JASzeqtoXUahcWn0N7iAQxbRilAEQfvDMmm4yI1HhrngwYpMf6ieEhdbR09yjkUI7nPVrpdTJFWZZ6HegYBOhRULdv4+eSPv3HlX2quI/Q6QXczVTR/HYlqs9dyQiXH24o8emeRPARSiwzfLxLVkkjtBOp1XMd0kqcLT3h0ABqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734046048; c=relaxed/simple;
	bh=aSoKRjTAYvF6lwpOwLrBmfF/+YBy6tjV5MtsYW5Lufc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bqxrl0pDzWdqdluBefEqrbYrr0ZRq9wzT/KevbjCxsP8FeAMbZmgy/Gz+JRbCLtS8f95U2u4cLqhzJqS9f63npjveexuAAcHP9Y9wFvUCQAJXjyZdVqSpQfxQjYdXexR2Np8AY5WR2Y/yjx97e74OrG9H6wS/79LzFxJ8Sme3+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g4sO0IWX; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g4sO0IWX"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-725f3594965so910279b3a.3;
        Thu, 12 Dec 2024 15:27:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734046046; x=1734650846; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q63QEvX+BQjt0MQ+JeXke1lOVFwn9vKhYJT1IdWoMcM=;
        b=g4sO0IWXoruQ9tY5xyfs6ZckOtLswdfzORHTcccPZ1Yg/ZcRBQWxYGzeKDC75dxN2c
         QtaLDyQQYhiedxfM8Piy20m5lLWET1BgP+RoBgV28YTcdczA4KofFT89aZQEsjfOl52c
         xWFlfExImbdaLw69atATVFvXMtRfBdcQ+I2XFfA+I99wQFPO9YJFUiskQzfae8YKDk2J
         X6BNs1JVflgts347VVt2ruxpDwjz7a9NTySkeh5jKKzvFcZPurPZOmWYyLUH45TrhUXe
         C7oAiHyFPp5FDMX3m9jsZe2e5VzefwYMOLx/KYowVVqwljQ6rlNxINQq4EgnNBHJGbsc
         Fbgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734046046; x=1734650846;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q63QEvX+BQjt0MQ+JeXke1lOVFwn9vKhYJT1IdWoMcM=;
        b=sDk5zSdLSNDIIt6ODq255UK9DoVyvp1RoANwn6IxaTcQbl1MNW3RgmspIxpEtoVM5J
         T+Er8hiv3GH1tYeGi2FyVL3xE36yHsMJ3gj7/Kd1dEJDklPlVlCT6lFaCcWubOWLxWMc
         yfx4ZMUQMEJk/R1rmZrintx2mzYSZD8Ce1Rr9Zu9+yfhuW3mmlNPzeIYdwh1dT1Xj8Y0
         mgAecbDL8HUBgzh6MtakBzlYy8MFISvA8dHda1bkrEKneKZ9GnntKtRWqjBClRqYTfki
         uyxyKEEkqjwlLRESQQVoFQ2Jv8QJJRhgnRORhBrNhDoUcJilq2/Nc7tD4cRF/aBn3mFT
         Ebgw==
X-Forwarded-Encrypted: i=1; AJvYcCW+rU1dYr27Ig18pO5wxFdNtsxdJMwwPoVx+rSWBOWj9Sfp6QVNOa7KnF2c2SZXXn9ifyhf3LEXLMdH+xw=@vger.kernel.org, AJvYcCWtSz0MvzZlLxBLFPiDdzoOgeuYikdUcDf5+SUkrYyE2g6188EJjhoe6JWoJF3SSLMuvzBVDPMXHjQuR2xlh55rDw==@vger.kernel.org
X-Gm-Message-State: AOJu0YymJpsS2bK3VBGoFtXXFceMLwtPjoC9dT21ulSPI998dp9kIJ8P
	4jVXGVJedM8t+ugD+LxHVlSm+RyONWIw4b82oYaYKB55Hv3/8Zhtr9d+IN18
X-Gm-Gg: ASbGncute0bNbK14Si+LBbMzTkXLvkGGD6sxbIMB13W2gnUWwcRET6detTmhxDwbysR
	J3IWCfknCFZEix3y8JNAcDnzl6wvhWuCET4VdAgB8Hu9gRUH7cvoGCVokOWdZANyoK58CqmjcPc
	nFKMHjHAnMgKBag7H6ams7Vz1HJ19t3vIw5U/iQ9IXwCgA1qHvgi56QK8SAnSFjUXeKkdbCn+Tn
	Kw6FserbiiMBCfiOmcvU51bxr+tDJd68nnQ14G7CY0QVUKJ0XYbf1kd9S+8AS4fMSFjry6aX7X8
	9NlMShfaerRS
X-Google-Smtp-Source: AGHT+IF3bWy4/7+rA4tsl8I0t4eHn4NBoxq/qjxO+2Ac6Y6BNOplm7T0fvnZ2+ABeBRnWPP4/R9lNw==
X-Received: by 2002:a05:6a20:c99a:b0:1e0:c954:ea85 with SMTP id adf61e73a8af0-1e1dfd359a5mr740163637.13.1734046046249;
        Thu, 12 Dec 2024 15:27:26 -0800 (PST)
Received: from mbp.lan (c-73-202-46-50.hsd1.ca.comcast.net. [73.202.46.50])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd4e202e9asm7324674a12.72.2024.12.12.15.27.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 15:27:25 -0800 (PST)
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
Subject: [PATCH v13 03/10] perf record --off-cpu: Preparation of off-cpu BPF program
Date: Thu, 12 Dec 2024 15:27:10 -0800
Message-ID: <20241212232717.232507-4-howardchu95@gmail.com>
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
 tools/perf/util/bpf_skel/off_cpu.bpf.c |  9 +++++++++
 2 files changed, 32 insertions(+)

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
index c152116df72f..1cdd4d63ea92 100644
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
-- 
2.43.0

