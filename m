Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26EF91C2DDA;
	Fri, 27 Sep 2024 20:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727468876; cv=none; b=ExeICDJGwD1KEEgYWtKfJB/LHhQUJwWI4jH1E88QWUv/vScqKO1UmLtpJ7NBEsRaHVLGf6/y9pb/O6DXy/Ikh4P30FSeXWbWcYAM8tkezwjXbyWMuV/RszHOgHA91CHdbEw34FeYbCHYpYxUFQtipb9jVlKMzTLMNDAR9879B+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727468876; c=relaxed/simple;
	bh=IbeF3vvTFS3uXzbOh2z2k7t1WaKPLo/Or5yaygXV5PY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TVfgKFhHWEe3Y2vQXJk3L891PqonpqmRhBbnZNuseJ2hAfRGJ6ZgdP/eB+zaoJd4SWFrbSLrL4QfAOmoj3VI0WOiz2xpdF2ghq+oRoi2uFJWpwJgG4ESGkamKKePVpOXQWf2ttCVB7vuboy5nAW3NNtx44ZGVfNcBQ85QyfdCBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A8ncmt0w; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A8ncmt0w"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-718d6ad6050so2110082b3a.0;
        Fri, 27 Sep 2024 13:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727468874; x=1728073674; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pcTojKKYJZOaO/dDLRwrljyuqPboNnN4q6IqpqSp2Jk=;
        b=A8ncmt0wOgGRKxsyb2JSyfi+/6ZYaAy4S4iXjUNr/wn09BZldODo1DraNfwgZFfhnL
         rFK5NBD5tCgandYccj2SDcmXqBKpDAUG6bW6rX1BYDLh+l/9HOiDqw5TlimYHcWmHb+y
         jNkEOMjPOE+NuFPZcaZW/Dvvl6FfdwzZ31BVDzJUOkzaqqD7mly9QYEDV4LHAL/vEeBe
         AW2vmb8HEk2RZwhh0Rg0O5inK78vEidupO7J7Wob6ej0bXawhv0RRhetrtyxPmoLa+Pv
         sLIuM4UXuktYoSrnrBJZcdZBO+AEcxrG9nr9uac1XpxCVEeGF/dMY7g4+xzQjGtvDMwO
         Dkag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727468874; x=1728073674;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pcTojKKYJZOaO/dDLRwrljyuqPboNnN4q6IqpqSp2Jk=;
        b=MxMYaAvjYyGiKHEue0sgBhv92KduoedgyaDi5LHjKBVUZs2raRuQPLywQydEjyAg+9
         2oMWdjL8y9CHnh862AqL2HPJxS+ibV5mxGcUSCrD6KISskRcxdzkPmrVEoqQa0vN50+3
         OrbhWmaNzp3ckguhMewW6d9YdgA8pWnWnBhXVZYL9eKNwO0JBAtpVN3VPVdlRxSk+iUf
         bFmXts17UwfhTnFrY0ER68ONNhDkwZIzTxe2g9Lq0y+QWZlWLg65VsAUtR5fcBezP/nC
         kAWDP4sGqE3p16PqfQPiCQlWTJINVCkTg40H2AlKHGkAZBmXMi888pNv9cq/25r6+kDj
         ZWjA==
X-Forwarded-Encrypted: i=1; AJvYcCW4lucvH7AsXAiM6ocGzmFa8POn4kqWdZ9MhoZGSNKFyZUD8XslXPang/i461fYDxQyDUX55OQTvmfd5YwhkeVR5g==@vger.kernel.org, AJvYcCXVY7NXLAMKESDLsRJ1jagFY6DIprS1sn4CEkG92cEGnQbFAiYHTxqCH3t9dzHgDS4GWv9sx0SVowArwXk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMEV9/+NxpxQzBDAfrvnR6WOBzVh2oX0WmT7wQBD1RV8p+bpSK
	zcX1gbZZTKsHIQlp3XzKFTeRtLlBCSupwjoVgwJstt3H1lY9G/Tb
X-Google-Smtp-Source: AGHT+IEsXIE4fvWhmOMoSWZDl4693YEoXWLviaEmLilmHw14TJwjSso+3+PTy7DOYNYYvTqPKhPzsA==
X-Received: by 2002:aa7:8881:0:b0:717:94d2:43c3 with SMTP id d2e1a72fcca58-71b2604c297mr6914990b3a.18.1727468874356;
        Fri, 27 Sep 2024 13:27:54 -0700 (PDT)
Received: from mbp.lan (c-67-174-206-244.hsd1.ca.comcast.net. [67.174.206.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b26524c32sm1998410b3a.157.2024.09.27.13.27.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 13:27:54 -0700 (PDT)
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
Subject: [PATCH v6 3/8] perf record --off-cpu: Parse offcpu-time event
Date: Fri, 27 Sep 2024 13:27:31 -0700
Message-ID: <20240927202736.767941-4-howardchu95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240927202736.767941-1-howardchu95@gmail.com>
References: <20240927202736.767941-1-howardchu95@gmail.com>
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
 tools/perf/util/bpf_off_cpu.c          | 56 +++++++++++++++-----------
 tools/perf/util/bpf_skel/off_cpu.bpf.c |  9 +++++
 2 files changed, 41 insertions(+), 24 deletions(-)

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
 
diff --git a/tools/perf/util/bpf_skel/off_cpu.bpf.c b/tools/perf/util/bpf_skel/off_cpu.bpf.c
index 5ea320aa9a53..e2a887228fd9 100644
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

