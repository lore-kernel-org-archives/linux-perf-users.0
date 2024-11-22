Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BA816C453;
	Fri, 22 Nov 2024 04:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732250333; cv=none; b=GKx2oJyzSh0nxhqoFSmExxumlNl01eZq5+LFRHOcsscjJk/LeOHGj0KTOlFAiDNkExdJ0PPNYRZ3zpc4uU8F7qo0HfBsdQj7kL2sgtm6WrO1FvnTiMkdYxrFzL9EYR1Z61o9RPHYxK8W3xqGwby74glEub6uAAjLaGd+k3nKFEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732250333; c=relaxed/simple;
	bh=mTlC+dsjuz20TP9NXLl05x5MvL2ZF8LuKq6YVidbn2M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WA0GXDYgHdkNwGt7Ej7xPFArwHgnHbYQGOXOttsLqDRmaymaDANwE5vnBcGoSG6YpM/MP2FDmXN8V9kTePXtymTrp51+QjuENBJXzECk6sIJtBLmEFqOGnQSgh5CJkFGHRKNhVn9Yjb0Di6aIIiN9WP3chziFH5uLHzbXMqt6OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mwm1nfCj; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mwm1nfCj"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-21290973bcbso15569905ad.3;
        Thu, 21 Nov 2024 20:38:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732250331; x=1732855131; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JmHn/bdBOF0dPUymMSGq/r40vYqC7wwLOGiFt6IT0Mc=;
        b=mwm1nfCj4owc9lce0h61attRjX8FOdj0bS5/o+1Oy5em7HhQMD+VfqjF5Z10+8AhqA
         h0G8TpcdyLt29K8S4Ds2gq9WtLoyqjLPtOluEQizjMNO2Rech/Tl/2YpeNft3S+Pe6tM
         Ww9h6kgLCAuoXiEgTNd4Es/1StFmJVYoz93jOviRHJD7TDwX5nJzYSkpVrvohd35neXg
         RnR4at5kE1wQZBXZFwR8Nnnze2qVNJmBO0R0jZ2TkrAopiG8tWUPiSyzynjD+TABCrAd
         AF2TOoPaFcxndxSnoAD7Q6no7z/V5it1shC+QdEU88N4CL+Q422zCJuZ6DzboJbItIiv
         jr4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732250331; x=1732855131;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JmHn/bdBOF0dPUymMSGq/r40vYqC7wwLOGiFt6IT0Mc=;
        b=bt1H7kNr0yF0pzH7HD5QNVpjLj3owb0nl3vCi0qW2GMXFEU3wr5N8pmi44lEkFRd0p
         PEhUfYvCKGgCELJ6UsbYUEo0GVqV6Y4ugKIJa+EYZ8QvLjyQ98DgxM1Al/lIaJrLgLZ/
         /AyvHpg3xIOT/JXd5Ughaw87QvG4MXievHLNrpI6XGo7fqLR0vxNJCFu4BoLz1fDjhaM
         WwYDW5/kmgaybdC4ouzuywDVK5yiAbdJfmBfNZG6f2QtshpJNIR+ew7pXKTZux/6KoSr
         UPS5XvY5eVaxythZ2D5TbTxPnYteQ61MEdI7mtvM/I0wMc8kQROsJUcqwVSZWHtKZfOU
         VMdg==
X-Forwarded-Encrypted: i=1; AJvYcCU+dIlGfeIgAp6eYQYzyc5MapODW3/uYhVAJzRI+e2jTrjL+MvjbEPaZhDtd5SWpeEwgB7G6dz+eghEe8I=@vger.kernel.org, AJvYcCVTGlSWNyB/W190dMbeUocmXU4DpWPJius91AOe/838eNzZvTegHkPX9deKQVVq1XX1Zw+JVORuacL8N6NDDIZztw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyFt7p2I48nH7wp7y2e9V+pu8S8n82+JLLUJF69dNKJYP0MIYLr
	Cxt3+CVSAflJC42MCYUGWkR7p97gSIZb/BJ3REMXzrX0nLuz9Udn
X-Gm-Gg: ASbGnctjeoGvhF0YCwfn2e704V7ihIAdI6IsG/jjkUSEWevfKNiiDoDysi3O1W9xB5X
	bUkgK2LiZ1xP0EjoFCDl+lJMuKhYum8B9Xm4DHGS/PxOkQUChG34QpW+EIkQvwpheywQAw1LKn4
	wEYULpLDR3it/5KSkAv2hq8yetJfHPlFR2jQ2dNEgGTC8oVAAP/Fov6CIC0WvnVZryoi/p497xm
	ydQmJJbHSYNK4kdGf217BDG0H/5ZK9F3508UxHzHZectXsJhgdS6TI4kj4v/oP7oOelwnHgcdVE
	tcpNBOZDb6I=
X-Google-Smtp-Source: AGHT+IHm5T5Rb+fS5Wzz+Aa9U7EoOcMPQHYNmHgS5vI+QSn+mN1Bo3eZa07IZKFVZp4MHxZt7kCGfQ==
X-Received: by 2002:a17:902:ccc6:b0:20b:861a:25c7 with SMTP id d9443c01a7336-2129f6129e9mr20824795ad.54.1732250330973;
        Thu, 21 Nov 2024 20:38:50 -0800 (PST)
Received: from mbp.lan (c-67-174-206-244.hsd1.ca.comcast.net. [67.174.206.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129dc1544bsm6638135ad.193.2024.11.21.20.38.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 20:38:50 -0800 (PST)
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
	Howard Chu <howardchu95@gmail.com>,
	James Clark <james.clark@linaro.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v9 04/10] perf record --off-cpu: Preparation of off-cpu BPF program
Date: Thu, 21 Nov 2024 20:38:34 -0800
Message-ID: <20241122043840.217453-5-howardchu95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241122043840.217453-1-howardchu95@gmail.com>
References: <20241122043840.217453-1-howardchu95@gmail.com>
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
 tools/perf/util/bpf_off_cpu.c          | 25 +++++++++++++++++++++++++
 tools/perf/util/bpf_skel/off_cpu.bpf.c | 11 +++++++++++
 2 files changed, 36 insertions(+)

diff --git a/tools/perf/util/bpf_off_cpu.c b/tools/perf/util/bpf_off_cpu.c
index 9275b022b2ea..2378fb5a893f 100644
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
 
@@ -261,6 +284,8 @@ int off_cpu_prepare(struct evlist *evlist, struct target *target,
 		}
 	}
 
+	skel->bss->offcpu_thresh_ns = opts->off_cpu_thresh_us * 1000;
+
 	err = off_cpu_bpf__attach(skel);
 	if (err) {
 		pr_err("Failed to attach off-cpu BPF skeleton\n");
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

