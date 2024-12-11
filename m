Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA3A1F0E51;
	Wed, 11 Dec 2024 22:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733954430; cv=none; b=ZcEPPxjhnXkO6i2rWfrFT7/erL9muLsh3vE6fFvhtYxJcEx0O/yBCZbIsRWTNXP41INgdxREXgdHBjqu+rKKYCYxP5WBgpSK+NXjrtNZ4zUWGYuWVH2HSCe6VeEuU/2sGtirx9GO5CY+M8jI09SgnuWn+awe8Amj7kvpOGGgoAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733954430; c=relaxed/simple;
	bh=mTlC+dsjuz20TP9NXLl05x5MvL2ZF8LuKq6YVidbn2M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hocc/84pJa65puQRIBE/nKMPdpH5HNtL++uaiLDk3v8PWb6KNRzbuHOV9vs/LYE8/MBHFw5DdrPkHSM+fQ4YKV0bzbvlQ0fSX4/oPj7yEFrCsR/JSOsFtAtHI+MeiDSqevtu5BAQRyOIQG+rM8+kiB/R4uy0VsROzh2rcrD8Oyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qh6aVmU7; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qh6aVmU7"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7fd49d85f82so3121203a12.3;
        Wed, 11 Dec 2024 14:00:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733954428; x=1734559228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JmHn/bdBOF0dPUymMSGq/r40vYqC7wwLOGiFt6IT0Mc=;
        b=Qh6aVmU7YaeKLoAp3rrHhTgjiy/ZqFuN2jwyRStiu4EbGDkhAIHO7LIAvE3dLUKTT0
         4P7KRYzkY9PQvsfgg1XN5hh/MRrh5ONJDFUoUWElXTDuCDGy5tRdZbP5Fhk0JULaO++j
         o+8U+tXaIcjGaGwJlic/3nw/rpLw0G9gn5Jw4lSyJooI4Pyi5TZHWd1wGfMYukRmB0+f
         giYk/J56JT/SvbezixQaAJa+01FyABZNCY9su0l/l8xfl12crSkUKgdCUQNj3D5euKgI
         fRQlR0QF3Qr35LFa4njZQlmjj7NEdRFMKkfGyu/OpnHwYET+f3PTlXkyRzrYH2YN86me
         XbrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733954428; x=1734559228;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JmHn/bdBOF0dPUymMSGq/r40vYqC7wwLOGiFt6IT0Mc=;
        b=Moyw/K7qIO53ZBGO2UNQ50tbeoPhs3A0DUi3i7luiu6bN1sOQWEZOX9aZ9etjnGjf6
         zSBIEwNNycZVafBgCV8d6OyZ+Pkxq5AGeS3J9WX1IWicEq4ESebFCBfV0mBX/rNDens2
         2JGzXwf4UQ3emzuzATJxQKstQefrHviEQ5SWrWEyZObJ8lSOjfH1ZomIhNJQFGX0Ihtv
         bjMAe3VVC+WB/VEbMfcdGJ4NWlv10bVeQVk13lf/T2ySZHG8B75+0J6TNLDQs83+rJZm
         Mu8aR5na1RNwjsyX2bQ5SC/4e2dJVcf1Wx1edkAPN1pcNGXzmpnwbGs++EQVnubXY/Ab
         udGg==
X-Forwarded-Encrypted: i=1; AJvYcCVrpwsCdnapKjdQCekipOcVjTxoj8uI7w5VBTXlXaYsBDS+qJEHQxAhXOPSPx0gHiDHfaHwlWGL/+sRV/wRacWwLA==@vger.kernel.org, AJvYcCXUXOB2g1gq4c1NqEQXEqW+ICQNoLjYZNDpAqSzj1i9yfWlkxyaQ6kVeTSxrOVylVwxMxajXva87yxXD2Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWABug/AhmxOT42HvJNz/AxWzV4WiMPsKAHqzvPswNww/KJVQO
	QuTmXa+RNGqA00nEHhDs/HhDHBvR67jMj1/TokiT5aiiSCmjPwVn
X-Gm-Gg: ASbGncuvYJ9M3rDWP/UrckGHyslpDlxBKujO9DLFRpM/xVyT3driM/wZWR/61zJ1Bt9
	xJ2j7NsflTAhGlISc/ZKL3VnVxUM1cjRbOXHuWKamlzlt2vDw/CNYrPL4EIIkjrUUtcPSNtoe0i
	EDfu35iYScmEMo0HgrLBSOwE3XRAytIqeWOCSdRc5g7JsaIeFJpneNH2Vt7onrdBnhzvwMJkoWH
	dNH0kFBVIwwRr5TLqMG2iknGZe6MQQ1CcFex3FaQcRuMcNYdyv56jfZ7rZEqx52XPWUIxtewn1g
	yVRcRiIkdQ==
X-Google-Smtp-Source: AGHT+IESIqEvocXn1x9xaKJN69LVMNhEL6INdMAGav0xpPmZeFPIiCm5MGR853yyWvWaziXwP4Cspg==
X-Received: by 2002:a17:90b:5405:b0:2ea:bf1c:1e3a with SMTP id 98e67ed59e1d1-2f127fa5e12mr8993110a91.12.1733954428269;
        Wed, 11 Dec 2024 14:00:28 -0800 (PST)
Received: from mbp.lan (c-73-202-46-50.hsd1.ca.comcast.net. [73.202.46.50])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef2700cccasm13912665a91.22.2024.12.11.14.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 14:00:27 -0800 (PST)
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
Subject: [PATCH v10 03/10] perf record --off-cpu: Preparation of off-cpu BPF program
Date: Wed, 11 Dec 2024 14:00:07 -0800
Message-ID: <20241211220014.931479-4-howardchu95@gmail.com>
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

