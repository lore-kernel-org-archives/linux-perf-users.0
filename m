Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2770913A276;
	Wed,  7 Aug 2024 15:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723045152; cv=none; b=hztmzz6hcVCGsvvmMqdMayqnPzNmJd0Kp5gNlf99jEyBHuzffLR0dvHE8OP3yL1NOFYJ6JP3TW8NbNiOtl65eQOp8Sf1lLMuS4xrtQ2RQR9X8EW5713AF+i+0lVnNwLn+6nfUuKoCvnZyCAsBC0S+qI/ojwtTU5Py+JfblvjIZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723045152; c=relaxed/simple;
	bh=POqXyFIlz2EObunHi26K+syLYamY1BPxYt+X4L0suqY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iVVD1cBBAkW4yZiiYaT5Ajllpx+RAJsST4nXB51Spf7xfmld9b1Z6w7wlKjDF4hTNY4N4icHkrJlPn0eQWWYbo6RQLAEQSFbJhUowU6NTmib9DzI5clNzgMHieLa2kB8j4WBN16WBKG487ibhhdVQkSPApWhZSxF/uoRaQRk0Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eWIc0zn5; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eWIc0zn5"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1fc66fc35f2so8061385ad.0;
        Wed, 07 Aug 2024 08:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723045150; x=1723649950; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FB1CGIEHJSZZ9KdFY8HItW4iTLpXpK/3aHFpRN33YZo=;
        b=eWIc0zn5Xg0b88vyCKqUlygoAT8s4p5hAIsKDfIZpfWGNd9ef/bktb7f0ZaSPdx1m2
         ot6uxjqdsNbohLvrtJzNAdTDbYgl33g5lGb7sjgOHlKuan5Bu6akQpl03qb0rjEyKJ66
         2k/2LrO5juEqHJEiZoSQISO4kInlyuasIfbm7VIR2sbM/XPXfRL04HDIqaRzQA2MyutO
         c/HjZNL9uwYDsYBTNG/R3oSdFE4TSmD2HaXPkfzruPg64zZG2+4MDzYlzKqspuS+1UXt
         a5zJ+N77phXW6oi5eWs52ZQsl2sdpzSfrRa0LwJSLNFH/RLIF9EJFTyvEzqc10kCz98l
         5LVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723045150; x=1723649950;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FB1CGIEHJSZZ9KdFY8HItW4iTLpXpK/3aHFpRN33YZo=;
        b=pvrBbuW68qwgEMIIJZ6N+UxEE4tmmFjm0Jcp1GqeTiBjLzwZXOklsId0JBjZruCd/F
         0QKYdMCedZd1LfxwPGQaU0C7uhKPpBiJper7Iv9Rvzitgq7dwnkYOpqcR+7THMR+9C2b
         PtkJo0QAo/fwnxtJvxj0jHparAXyA30CgqrLvKgwsKg8yYDxVq+0iUtKzbayqMFXG7uT
         uErIdmP+bbZuz3TzxhHuVOJIKXnyLVvT6o5w5DgVjZMoXsPMFArGJ8SEfbLTCeLA140p
         fddiocDlp1+i5IuVYuTO9tGfyLhStCVi2KPd37y8ka1rT1DAnoUUkvK/ltcnIKz/AdP2
         IJjw==
X-Forwarded-Encrypted: i=1; AJvYcCWzznJF4J3Z9rAzowjFxUC2JSdUpHdT4tz7SH4Qi7ZfGNliJk8rn8jNgn8U380aHRSaOZqxeSPBIbtPhuCRJGkHcMHQvwPGTvpCWeu96BoLXgxTugRpZU+fdPtQTov0nZHqJZUHg3AJim3kyldaIQ==
X-Gm-Message-State: AOJu0YyuLLHUQAgVycsebWFBKKQLkV44KXaKX61j3PkOJfeZsZfXZsep
	0XNoJif9VIof/lh4lD/sPBxbaJXSjd5K3W5ZJY2heHewZXdq9VkO
X-Google-Smtp-Source: AGHT+IFBc95ZWZ1Xhdvrudq6BQGqUmBmqgVCrN8NZXvJHKDm3s4BeoPGn7Y9inAQ1Fj8xVrV5RrF4A==
X-Received: by 2002:a17:902:ced1:b0:1fc:54c4:61a7 with SMTP id d9443c01a7336-2008552d025mr37190455ad.23.1723045150308;
        Wed, 07 Aug 2024 08:39:10 -0700 (PDT)
Received: from localhost.localdomain ([120.229.49.55])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff59297329sm108097375ad.247.2024.08.07.08.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 08:39:10 -0700 (PDT)
From: Howard Chu <howardchu95@gmail.com>
To: namhyung@kernel.org
Cc: irogers@google.com,
	acme@kernel.org,
	adrian.hunter@intel.com,
	jolsa@kernel.org,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/9] perf record --off-cpu: Parse offcpu-time event
Date: Wed,  7 Aug 2024 23:38:37 +0800
Message-ID: <20240807153843.3231451-4-howardchu95@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240807153843.3231451-1-howardchu95@gmail.com>
References: <20240807153843.3231451-1-howardchu95@gmail.com>
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
 tools/perf/util/bpf_off_cpu.c | 55 ++++++++++++++++++++---------------
 tools/perf/util/evsel.c       |  2 +-
 2 files changed, 32 insertions(+), 25 deletions(-)

diff --git a/tools/perf/util/bpf_off_cpu.c b/tools/perf/util/bpf_off_cpu.c
index 1e0e454bfb5e..fae0bb8aaa13 100644
--- a/tools/perf/util/bpf_off_cpu.c
+++ b/tools/perf/util/bpf_off_cpu.c
@@ -13,6 +13,7 @@
 #include "util/cgroup.h"
 #include "util/strlist.h"
 #include <bpf/bpf.h>
+#include <internal/xyarray.h>
 
 #include "bpf_skel/off_cpu.skel.h"
 
@@ -38,39 +39,24 @@ union off_cpu_data {
 
 static int off_cpu_config(struct evlist *evlist)
 {
-	struct evsel *evsel;
-	struct perf_event_attr attr = {
-		.type	= PERF_TYPE_SOFTWARE,
-		.config = PERF_COUNT_SW_BPF_OUTPUT,
-		.size	= sizeof(attr), /* to capture ABI version */
-	};
-	char *evname = strdup(OFFCPU_EVENT);
+	char off_cpu_event[64];
 
-	if (evname == NULL)
-		return -ENOMEM;
-
-	evsel = evsel__new(&attr);
-	if (!evsel) {
-		free(evname);
-		return -ENOMEM;
+	/* after parsing off-cpu event, we'll specify its sample_type in evsel__config() */
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
 	if (!skel->bss->has_cpu && !skel->bss->has_task &&
@@ -86,6 +72,27 @@ static void off_cpu_start(void *arg)
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
 
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index b961467133cf..ccd3bda02b5d 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1379,7 +1379,7 @@ void evsel__config(struct evsel *evsel, struct record_opts *opts,
 		evsel__reset_sample_bit(evsel, BRANCH_STACK);
 
 	if (evsel__is_offcpu_event(evsel))
-		evsel->core.attr.sample_type &= OFFCPU_SAMPLE_TYPES;
+		evsel->core.attr.sample_type = OFFCPU_SAMPLE_TYPES;
 
 	arch__post_evsel_config(evsel, attr);
 }
-- 
2.45.2

