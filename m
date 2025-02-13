Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F04F22D7B2;
	Thu, 13 Feb 2025 23:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739487620; cv=none; b=aChRDqi+is3BqTniASlaXpzNH4zFBlcDjGPzJLYWO0xUcsf+U8VHfpRwXca67ho2af3Jxl3K4aACWdG/3Ua8K/OwCkVKgg00fz6lCNOM1Nd0URYgLAuQ4qMLlekRLMxbgy+bN7er7dRspZg/r1RLYnpz1ITbOOUNSG3474awjzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739487620; c=relaxed/simple;
	bh=B7pJ83661aYJVk1jhA2ZmEebrYQLC7i67R/mekIQ7/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rTI4YKyBKOKHsf2ZhkQSjfQvntVB52VV81KS/7y8/xaT0Hg/7oNtPtp/MGY77b1y3FViLm7c2sdRy4fUd6fBeLjMsQToeXBRC2Ac7WvKvlmwyHuMuewGzfytyf/CwSLZIGhiJcrZpKTExw7p61MgYDuUwyZfAaOp5N3aaRin4ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JZVcOijp; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JZVcOijp"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-21f5660c2fdso29103295ad.2;
        Thu, 13 Feb 2025 15:00:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739487617; x=1740092417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IcIDgG6uFwVdSQFSE2lqNj2d3UfP3qCKN5H2yvCiHY8=;
        b=JZVcOijpJAxJtitZt7KkYaCWx9A16DKgiBQ8fwJjOJjyVRbccRzjXon/V6rs8X821F
         387lbzQFCrEWEvz48rOCuC9YzAXtS/kAIiHMbJEB8E4L6vBhs60N126IFboiUlYDMP5y
         jNVKp+oqa9JOmUs/DwxaDcnyXF+3zaV2t57dG3b7zWskbsenLeZ01z5ShbXcpSuq3dHA
         7jwPKWMvzQkr+qsVeTOjy0jK5EeXGJzOkugHAQ7IAPN0qXFM78b4yd5H9j4UlDK7TTYQ
         16kwQwEZPig/uUI66N6EH1tDyXwROvQQHNtnYmUsVP3ALI2XizVgaJuptpt9j5HWuBae
         P63Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739487617; x=1740092417;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IcIDgG6uFwVdSQFSE2lqNj2d3UfP3qCKN5H2yvCiHY8=;
        b=rj56koEr0miSzxe1tLXUWr0IcYBFiADtl9OXA26lzWnNPcavg3r4AX0Y4ZNPZvpgh/
         xIVbhFA4nRlAzlusP8yPsZrGzr4pblQHqinY9QvUyWAXuQbMZGGm6D2nDxUqqEenVAKV
         QA3ptob+a4odCng977e8thAyKQveKSm9ISyg4jkxWUHX08v3DOfPogIf4gw3ZDw3MsQa
         IcvT8+vGTFSfdGZ120TWQmg2VCT2vcY+AZ+fD5ZAQZJXMKUvjPtjlvXDSIsG1iqnPMZG
         EGPAKPHTLIH29Hw6FRwCs9zdqj6qz7i2QF0MKx8MSrqjG+Gkh3HpjF49iez/mKvrmMmW
         CDBg==
X-Forwarded-Encrypted: i=1; AJvYcCUCc+4Lg2rcuZY2vbgKbaw4Iula1YcFx4iFqDOk5V3viN3jiDMbGu2uLoFvKqmepq0Qce7QO44IsoizYAw=@vger.kernel.org, AJvYcCX/5OEvRXVNHuWjZFTyQyWY2k9gf3REKuY7QJMCkVCX8btY65p0CUuLjeRO70rVZIN4zy2SkodYOIRPi+7r8VTelQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwdkOV+ioVGNB0qhOZ6cNvfRi4qLTnhEmoG4kynsd1Dm9r5RT5l
	9WsZbJzDwE9lgCWqAcgdq9eJBcBVBK/iID+PDleKOK8zhSK3Npjj
X-Gm-Gg: ASbGncvpwHAnGwBJnvZEA/5ZujnGR47qk5DEBT/K4H88UwmpLmFkhWsruxkFook5v2n
	aRxp5+QEoQJ3kElcePgy8Qx8eKox9b+2EDRyOx2LkOCcRX4ExSjQaUq0EYOmO7uKoNv1ZVis2AO
	kSG1XmFBecw69+lT4EkxaIU9H3j39OK1Og8lOOQoLV64lDil4KqRCqxyk3Ja0t+kd4jyoFYXFFZ
	XfuR8DncFlZOInV4sebkkLiAbC2Db8u8+QNTs/DLFSHZcGnlHkmYqpYWAsME0Dvu/USoK+6zEPk
	PgTf9gmNmc6QqdpayraBTI3ugju8t17yquASZyx1z09tpTo=
X-Google-Smtp-Source: AGHT+IGL/ijyFjjZMK5uS6WK7zyW0nMkN/WJlEJdDy/BS2iFi4C+qqMS96u38AnPURIGvF9F+9xOtw==
X-Received: by 2002:a17:902:d508:b0:215:e685:fa25 with SMTP id d9443c01a7336-220d1eddf52mr74858945ad.20.1739487617191;
        Thu, 13 Feb 2025 15:00:17 -0800 (PST)
Received: from mbp.lan (c-73-202-46-50.hsd1.ca.comcast.net. [73.202.46.50])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d5349210sm17641735ad.11.2025.02.13.15.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 15:00:16 -0800 (PST)
From: Howard Chu <howardchu95@gmail.com>
To: acme@kernel.org
Cc: namhyung@kernel.org,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Howard Chu <howardchu95@gmail.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	James Clark <james.clark@linaro.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v15 03/10] perf record --off-cpu: Preparation of off-cpu BPF program
Date: Thu, 13 Feb 2025 15:00:02 -0800
Message-ID: <20250213230009.1450907-4-howardchu95@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250213230009.1450907-1-howardchu95@gmail.com>
References: <20250213230009.1450907-1-howardchu95@gmail.com>
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
index 2101aa2b7c42..de71ff7a80d0 100644
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
2.45.2

