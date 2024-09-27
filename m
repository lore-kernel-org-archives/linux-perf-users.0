Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285FD1C2439;
	Fri, 27 Sep 2024 18:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727463240; cv=none; b=fUVX6ZDWLBIpFtcx0bS9IhEtQkbSbFl8FB2+BXoqNoDRAkL0CgVnHMteO7qxXqT9mjaNf8+rcsKYGd9z7cOr6op3Mdqs0gaG6WdHIw6q8VY/5gSGBxVCBxv5SVll4HOi0bFlPI+fqI+dOvn7qtDMY6WMAdJyNUSUUa4p3FMvpr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727463240; c=relaxed/simple;
	bh=99KfpGlXB8W4BAGbDG/1/yCro9ZdfzMDY98xd7oKYaA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vAmhGYNBVOq0W3UEww1FehKAnleGONxLE36xPVG4dIwu6JlXcLXNxs6pHb9AX6KpKPe8Ncf2oZwZiRYYYpdf3sNsyb31ItmB0wq8TECuYt/UOJMt8F0n2a2/AXSmCa0pcnj5boulwxc80yxUluaqcEn3lhJ/cxxBHhGNdkDQINk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YFzLxFsj; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YFzLxFsj"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7db174f9050so651779a12.3;
        Fri, 27 Sep 2024 11:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727463237; x=1728068037; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E3HDeCFK/m+LDhVXu5v4d5xbrEo+hRCk0bljD8Hp21Q=;
        b=YFzLxFsjreW2+e8icMaEj0rQq07YMJuMQEr/VWPOmn92KViyUmZJdpRi73Ro/eBveN
         aWaeputnBLr1kaigfGBQd78zk0Y24q81HIbeDAcIfpHvJQqGjXI70JcnkxLajBCQKvaJ
         45pGwOCxJK4azcV4NO4316CCqggGOMoeaLJG6TTTcWCgeIhhRZUpIRwyqW8dj1RihGo7
         jrTIweT/IEUs3Z9qifznKwKoogeQgXh/Mty6pOJ/8NjCQIJIyhAK3ScgWmkc8Pq7ShuD
         v5BTcH+dj1eH5c4yTMosZq6mPFuXAf0qxOj6MXO5i0gM4B7R/pV+OQC8jxrb3puVycvV
         6eEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727463237; x=1728068037;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E3HDeCFK/m+LDhVXu5v4d5xbrEo+hRCk0bljD8Hp21Q=;
        b=KSbnc6h17z1MuCK/HkV95wmSYesf+hbZmqkGS/s6e02lwtP6XKgoAihxAlT5DPAAI3
         WgkPOU5+/gtaVh6rODhGM/NdEJqTaMdMQfmIvw6wxkilWipUY1Q6L1KgAekJsvluKJnK
         WsWcmhXNpfTWGWYs1UNGUmwZmWXZKxwV3jc/NA8jt384/xs3WCcopgVtFLCWtFZT4MGH
         aLDzz280PslTzQiUVk5SgB9IHIirD1QYGaTStYpMMjYMDXpPw9qMB7TMzCWFmNqDzYoU
         gQoCPoVZfnjusks2yDhZrKYmmvOWLcqywsElimslm8+PWakz32VNsfl0LOOX6Btj/Cit
         8OAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMacIe5JKTWGTK3bu/V5rc4Zhv3zjut0D2diQ/0FMwAdSJKTrJsdrnBm2ikX1x/S9YgkqHT3TsHfEZAdmv7Av5EA==@vger.kernel.org, AJvYcCWMCZQDNfek/DUPuJFUbjtTH76PjW1f1xUyGMSdeZQc+vKRuiYpTHo5FRIwC4tFL0FFDjkkxZ8vqWPVl2w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5mHIw9sr8vzMawc+8OQoxtXyyGwgfvIj09FIMlyBtAbihnSif
	0gztyLqoG4tqHEHDmNQsE39JxLov5MkscdWzoMsBHPf6AYeZBWf1
X-Google-Smtp-Source: AGHT+IGDS9iH7oiijkulaUfQ8MGLULEaVhiNL5HZBT3mkntZZUJyOD+zowobOZSOhbWfd4FGlgnVQA==
X-Received: by 2002:a05:6a20:ce4d:b0:1d0:56b1:1c59 with SMTP id adf61e73a8af0-1d4fa7ab7c8mr5675187637.32.1727463237294;
        Fri, 27 Sep 2024 11:53:57 -0700 (PDT)
Received: from mbp.lan (c-67-174-206-244.hsd1.ca.comcast.net. [67.174.206.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b264c23b6sm1930244b3a.88.2024.09.27.11.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 11:53:56 -0700 (PDT)
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
Subject: [PATCH v5 3/8] perf record --off-cpu: Parse offcpu-time event
Date: Fri, 27 Sep 2024 11:53:35 -0700
Message-ID: <20240927185340.658143-4-howardchu95@gmail.com>
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

Parse offcpu-time event using parse_event, in off_cpu_start(), write
evlist fds got from evlist__open() to perf_event_array BPF map.

Signed-off-by: Howard Chu <howardchu95@gmail.com>
---
 tools/perf/util/bpf_off_cpu.c | 56 ++++++++++++++++++++---------------
 1 file changed, 32 insertions(+), 24 deletions(-)

diff --git a/tools/perf/util/bpf_off_cpu.c b/tools/perf/util/bpf_off_cpu.c
index eaef643f50e3..f7233a09ec77 100644
--- a/tools/perf/util/bpf_off_cpu.c
+++ b/tools/perf/util/bpf_off_cpu.c
@@ -13,6 +13,7 @@
 #include "util/cgroup.h"
 #include "util/strlist.h"
 #include <bpf/bpf.h>
+#include <internal/xyarray.h>
 
 #include "bpf_skel/off_cpu.skel.h"
 
@@ -36,41 +37,27 @@ union off_cpu_data {
 	u64 array[1024 / sizeof(u64)];
 };
 
+u64 off_cpu_raw_data[1024 / sizeof(u64)];
+
 static int off_cpu_config(struct evlist *evlist)
 {
-	struct evsel *evsel;
-	struct perf_event_attr attr = {
-		.type	= PERF_TYPE_SOFTWARE,
-		.config = PERF_COUNT_SW_BPF_OUTPUT,
-		.size	= sizeof(attr), /* to capture ABI version */
-	};
-	char *evname = strdup(OFFCPU_EVENT);
-
-	if (evname == NULL)
-		return -ENOMEM;
+	char off_cpu_event[64];
 
-	evsel = evsel__new(&attr);
-	if (!evsel) {
-		free(evname);
-		return -ENOMEM;
+	scnprintf(off_cpu_event, sizeof(off_cpu_event), "bpf-output/no-inherit=1,name=%s/", OFFCPU_EVENT);
+	if (parse_event(evlist, off_cpu_event)) {
+		pr_err("Failed to open off-cpu event\n");
+		return -1;
 	}
 
-	evsel->core.attr.freq = 1;
-	evsel->core.attr.sample_period = 1;
-	/* off-cpu analysis depends on stack trace */
-	evsel->core.attr.sample_type = PERF_SAMPLE_CALLCHAIN;
-
-	evlist__add(evlist, evsel);
-
-	free(evsel->name);
-	evsel->name = evname;
-
 	return 0;
 }
 
 static void off_cpu_start(void *arg)
 {
 	struct evlist *evlist = arg;
+	struct evsel *evsel;
+	struct perf_cpu pcpu;
+	int i, err;
 
 	/* update task filter for the given workload */
 	if (skel->rodata->has_task && skel->rodata->uses_tgid &&
@@ -84,6 +71,27 @@ static void off_cpu_start(void *arg)
 		bpf_map_update_elem(fd, &pid, &val, BPF_ANY);
 	}
 
+	/* sample id and fds in BPF's perf_event_array can only be set after record__open() */
+	evsel = evlist__find_evsel_by_str(evlist, OFFCPU_EVENT);
+	if (evsel == NULL) {
+		pr_err("%s evsel not found\n", OFFCPU_EVENT);
+		return;
+	}
+
+	if (evsel->core.id)
+		skel->bss->sample_id = evsel->core.id[0];
+
+	perf_cpu_map__for_each_cpu(pcpu, i, evsel->core.cpus) {
+		err = bpf_map__update_elem(skel->maps.offcpu_output,
+					   &pcpu.cpu, sizeof(__u32),
+					   xyarray__entry(evsel->core.fd, pcpu.cpu, 0),
+					   sizeof(__u32), BPF_ANY);
+		if (err) {
+			pr_err("Failed to update perf event map for direct off-cpu dumping\n");
+			return;
+		}
+	}
+
 	skel->bss->enabled = 1;
 }
 
-- 
2.43.0

