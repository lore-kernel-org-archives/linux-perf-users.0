Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067911F238E;
	Wed, 11 Dec 2024 22:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733955939; cv=none; b=EHlftQ2hCXQBNEzThQrN7mSp885J6yJaT0YmfAbaFeSdiZClOnwCGXP4ttkPPsObaJEVgNa85QMgXak2tTWf0gw0hPTB2fJQtneXC9Lp9UlrsklOxQ1kA/PD66LUbTlgqfoh2601Z4qemc1wdF37PeY+TCPWHAUTaaJuuxvpNKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733955939; c=relaxed/simple;
	bh=mTlC+dsjuz20TP9NXLl05x5MvL2ZF8LuKq6YVidbn2M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mjQcC3yYCpKibhwJnWHrecwsH7vgewqAKsG7XFwcgh07FIAesTKe2pC1RS4i4WZ2lNxeT6OgNOO637Jm8SJq92OICU3p3CMeeq0VZ0Dhj2cDkXhGDb0wBdP9Dwidr26h/UWYYq+Q7nEWh34nlOtH99Kn4BqnRZapnjz0Y5p2Ee8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XlcTVf7D; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XlcTVf7D"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7fd377ff3c5so1001454a12.0;
        Wed, 11 Dec 2024 14:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733955937; x=1734560737; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JmHn/bdBOF0dPUymMSGq/r40vYqC7wwLOGiFt6IT0Mc=;
        b=XlcTVf7DmZCf8AKHzwQKd/vRPK97prMTuqUMD/9BsG/4Qfk6RfEULf4XcKAjP0GrxH
         rDGScNYCEgLk+iTrivvr7UFFGrHJNzL25WlWuCCssp0V7P85U2qwpK5wKCdZ/gnBSk4O
         W1DVdxtRSVbc8c/Ze6SooPCCbzKloibuRb9aMFygZ3y1u/Ax5Em1sBR7Dr/DF6/rxq1T
         yp6Ap3x4jeH65r+mWacoztnXukHHpPK4+oS3yECF/Y16csuSiC18FeLLImghxcxIUi4f
         9f4fvKqN31+e6lbFRxdhx7d6qa+uQJmKI9exqcFDxU5vqYDSOBBwlCZVzUucOa1oOiE5
         dlAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733955937; x=1734560737;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JmHn/bdBOF0dPUymMSGq/r40vYqC7wwLOGiFt6IT0Mc=;
        b=NH6I3aWeGSS9fsdZ9g55aQ9tOZ26YT0sXuuiTyUWnpuQ0Fkuds16kzXQKpG0+Sg3V1
         jwLrwcdwvRpKYnfaqmCLO3uBNEJmnWCKOOy16zpEA1gdJer2JCPJylFgwHWbjzgqNSfC
         rs91a3lZtPyDdjYKv09NeLX9oNm93N7NHxBcuntPkMpCwO18UOJVXKMTwXS9mdCOqYaQ
         +/jh5rDS94TOZtPsIWTwd3jN9a+YHYhQUVKodqO/aT4afoTWM2yGOVvHtqI0eDEgJ2Gf
         A2DakKFaGfZ6kDcKUJBI2TtU/K/ryiSmasBDTXLE2R89LB7JuhSHZ0xXiVDs/t48eHsa
         Rc7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVg8xiPS5Gb1sRk0b+qQWFKbfrxTdMrZlKPkNn1KxOongaQ/zt2RsWSxmq199b+MGTeMY54RcA7g6TRaGM=@vger.kernel.org, AJvYcCVylU63nPVNb5M6qKyiGmQijEkzSZc/96a+d77IFI4i2OgbyAPtmraL+kp2JJaJy4pFcHiELAiNpxrKiizDJ9ggNg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yym1g9pxhBCTy9rHHvBOzaCiJ4HWBrLQknicScNr45p81GJuQRr
	g/u05ENEVYtl/dcqNutU6SekZg2rOwltiNP7yX76+PbLrS42HhJh
X-Gm-Gg: ASbGncv5M3H5OQClSd9EUP11ddX7QTDyeJONI7K6mRwFMMGBEXep/hIw99fcDsqFRN/
	+CK9shJUaHoXlVXbhprdTf4sZ7JDiHLH+r0WC7FjH9XMZ3WzOHfoD2hddIedfhBZH7uxwHB4Gkw
	6PFk72k+8wqXvYMDq4qN1e26OaAH9sCmfx/jVdufX+pgxLXi8FKhyn0vyYunsMsUxKAKNac8Zpg
	7nuTBaIqYWcD+C/6m/WodnxQ0JxBrFwr02eq4kHhxHlRDdcZi8wqdjlrQ9QiJStPd2n+nKuhpDM
	Gl+ugj0OIw==
X-Google-Smtp-Source: AGHT+IGrOiXY9/XJEGANU0OHT3kZrZv/GSlcQYfsev4+eQW3acJ7Lkht+k4m0iUzTykY9LK5YsYwkw==
X-Received: by 2002:a17:90b:4d83:b0:2ea:4c4d:95a1 with SMTP id 98e67ed59e1d1-2f13ac98aaemr1404761a91.17.1733955937353;
        Wed, 11 Dec 2024 14:25:37 -0800 (PST)
Received: from mbp.lan (c-73-202-46-50.hsd1.ca.comcast.net. [73.202.46.50])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef6d1fd68asm11241561a91.36.2024.12.11.14.25.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 14:25:36 -0800 (PST)
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
Subject: [PATCH v11 03/10] perf record --off-cpu: Preparation of off-cpu BPF program
Date: Wed, 11 Dec 2024 14:25:21 -0800
Message-ID: <20241211222528.945590-4-howardchu95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241211222528.945590-1-howardchu95@gmail.com>
References: <20241211222528.945590-1-howardchu95@gmail.com>
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

