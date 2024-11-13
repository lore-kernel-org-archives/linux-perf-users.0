Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F40B28E37;
	Wed, 13 Nov 2024 00:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731457709; cv=none; b=rVPs29ZTrWh53NqScyz3cJxjucp+dGUYJHAOgvdeIjXeu9o8kNj9H9pMQ90j6yFPIlhcc/ZQ58F9zev/dvCmfNoRpe3BwgEIz0p1yal03XU9Vy6chZCDTjBB1Cdv1f4/ySAJLgRlMXhxkRNdfcMHyLi/rkN1WMgDQWz3rrmtGEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731457709; c=relaxed/simple;
	bh=FnN0JefpK/XJbE40rMOuzyObGxpocXm8qyCa6PsXe3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LR4s59jdgTWiBJN9ffzo0isqydhY/U4RXx4Cp+EZo0OyFo8h8D4mR3fPyFAgdxq26PneLMzDb/DYquowzvLdbugk8I82/LRwXUOw3BMmC+BXG49TTUfQjIeLVgqJAPL7AZ8ZLfaXxPFBMwJeZMsSW6dPDJIAomKEoucaNY5gRyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bAAJK3Bg; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bAAJK3Bg"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20c805a0753so62265925ad.0;
        Tue, 12 Nov 2024 16:28:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731457708; x=1732062508; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HqhOub90lKje0JDDIfka68HwdQxfOlgwod/Qhwqzi9c=;
        b=bAAJK3BgQmNuNkOnVi4kaQk5Pnnoqi5OLtcmY3H2ZBmUkfbW2D3e5iSEJ4ukKqtNPf
         4oFq3i7GL57JIdhU3/8DWZIgfQG9Gfd5UGmU3T5w4pgJJWR3Aq+j/SzroOsJpXgys7Nc
         J/0qmyabwnuxrJJk4v9aZD7bH5smqwDRfba+rU9/SkGyW3eYbW0Ukd7lQNOdS8eEczdu
         gZ/bceWY9I82VqfrhGaxUTNaeryKiqBAnFbYwykgGJYoHEt54ynB5ArHW3F7bCZcYGVM
         88mVZ3mZuKfWRypmWvJyfRb6KizhgcwcmUOznHmMG8BzgHj8aX7ERP7gl4frdQuYN/hc
         VyYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731457708; x=1732062508;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HqhOub90lKje0JDDIfka68HwdQxfOlgwod/Qhwqzi9c=;
        b=JJpSmuX3Kio2/b82CbV+kSts7eZpzErlbBxlrYrcX1ELLUe+htvDsOOL16JRjbfB3d
         FFvm/HW6qpkNVv5mHyblSa096bCQu2f63O9/h7jn2YNBh64SZ1gPldhc1zzJGJQz6bAN
         6sFjMbAXDpSvfKalitRDLWCL8yUdAG10sdbjm9sGjKm/6Jp32hKYEhFw48sLXPqwaLG/
         FtfxNKMNneqFnbGIAQuEp77FYbfzMH7VGZZh/xCRV9iRsPfix1EElVatWdFFd2kLvAsR
         Czxqf6AIkxcztK/tXwJY1a/4Z53StqIM9j+ikXE4dE8gQ/sslXZkVNCG1zpVAE4Pf1Gs
         jMDA==
X-Forwarded-Encrypted: i=1; AJvYcCXYwUYOFzB6FIQ2X9hUimbUM9wZQKPjJD5DBK4w56Q0BDWlPTtDjNkU7Mu9KJl63gFAK7TBmyXvvUZwOFU=@vger.kernel.org, AJvYcCXnBWRktNXc4lCSBjwSTR4Z2fW7lJIrWL4P6qThCKnesgdI48pdEFitYKXyDfqLXHw5eyV1GNt0VZgWDPtNXvJnYw==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu1H+43EXsSzeFCxrhc9OrTQgyr6cZ0NVI3cO9fuV0Y1pNuP5k
	M5KrfYAxImr/SUByECfMj/C/0pqNeIygFr78i0j/Y/JdGF6fJpbb
X-Google-Smtp-Source: AGHT+IGQY45Hat16INkJ6kDUhh9NygDODyIXVVIZS9gwbOUKG2dAC/O8EB7uMEN1h5cQXdOdOg2uyw==
X-Received: by 2002:a17:903:1104:b0:20c:da66:3875 with SMTP id d9443c01a7336-21183d52b6dmr221292675ad.24.1731457707644;
        Tue, 12 Nov 2024 16:28:27 -0800 (PST)
Received: from mbp.lan (c-67-174-206-244.hsd1.ca.comcast.net. [67.174.206.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177e458bdsm100158425ad.133.2024.11.12.16.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 16:28:27 -0800 (PST)
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
Subject: [PATCH v8 04/10] perf record --off-cpu: Preparation of off-cpu BPF program
Date: Tue, 12 Nov 2024 16:28:12 -0800
Message-ID: <20241113002818.3578645-5-howardchu95@gmail.com>
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
index 558c5e5c2dc3..61729a65b529 100644
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

