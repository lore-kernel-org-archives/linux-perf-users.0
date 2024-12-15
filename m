Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87BB71B87D6;
	Sun, 15 Dec 2024 18:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734286364; cv=none; b=uXhMG9eq+U601UQFz2cUG3C8VoGwYyl6JvTI2p8+47zRPIkr+4sHdg8wUVDyEjpaAcEJEsKYrsn7U+d91Q5qFJCeKuDVXOhbpWF/iCeLlYNOaBOLORl51BQY5eydKZep4SdWBZSUczAHBW4uRZ4CvtcZKVoC1kVHkW37K5RBIIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734286364; c=relaxed/simple;
	bh=aSoKRjTAYvF6lwpOwLrBmfF/+YBy6tjV5MtsYW5Lufc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LJzrytdhkQF2Itl34WragH6vpPKuehUvn3uCqkGvrt/Y/bPGyVaYUEhfQ5nGdpiIslT9aFU2HBuVGeDOystYwCNExUfEwuoiHDxy2WVy1ApbcYI1ukGQbSlXzU2pJIMLFLMAUWwLETpsHI7piHXmjnNM8eD8elHr8OtfvzgrHBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bpPSQgyP; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bpPSQgyP"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-72909c459c4so1881176b3a.1;
        Sun, 15 Dec 2024 10:12:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734286362; x=1734891162; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q63QEvX+BQjt0MQ+JeXke1lOVFwn9vKhYJT1IdWoMcM=;
        b=bpPSQgyP+pyfgdDf8pRP3g1laO7Tnaqwwg9zS/AETqZ+s8LQYmWdeA0ZmBwY/lfbBO
         r9Th5BqU0KArhRHHFnNk+rgn2NiTt7cMIb0XZsgmcomXydxADlYCounAqV18vs4DARh3
         d93TZLTZsffiZPHfnJRwcGsEvLG8SZEGhIxi6M0KYy5wC1LEUdKje8IdMw366qcMHBWo
         3y7NncvyyMZeVIyd+uRQvK3ggc5XzMuUJ3iMNSITH/x/yyLIuR9Sa8k0sIdyu0WFYDIX
         r+HiJ0kOduQbRQb3LaJTbTxqNJbl4N4C2VEg23wyyhQhOS+mHsq1GQXjEK3HdpEaUG7G
         9pxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734286362; x=1734891162;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q63QEvX+BQjt0MQ+JeXke1lOVFwn9vKhYJT1IdWoMcM=;
        b=LSYaOfVME2gvg/DE1HKx0/VdaQFQONJb2A2CqesPX09YHmEdI66FGZaEJFjy7z3CdG
         MaOQJDTFyy9eP8gUJK0qrc4muvNYrLjWZHBCV3PxLzLWGenfMJimbdlw23BLp2GVAT0Y
         /TieyRQ1vNsTlPNqFz6IkyO+fXvQWDTFHvqgTW1FudymxNS830AgGyKddhgL7vw+h76m
         PyjYTdkBNijGww3ibNoJy9ZRZkRawAIKgGBKrhOgLeF+0EHrlCwPseMVX5UTWCQDvad2
         0zSeFkZn3z+dNrTGpbSxF79e9BALKKqLMZuJgHA/g0xMoalE1wBAeZrdQtYhefVSVWTZ
         VaJw==
X-Forwarded-Encrypted: i=1; AJvYcCVKLvarepVvw9Hg3Jm6ojN8o7fc/6j3NporvKC4vdzVsk62JyB+ADyVgK2iVyP36zJukdBC7AVPixBuH4CpZupzZw==@vger.kernel.org, AJvYcCXOuq+QZ4Mr0J+YYwsHYcjjecTBjOsQeTdJtzKNrzeI266dste8fIAoP8C2zIbCDb8gQI3JyhqahcMeHVk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2m5JM8DCadBiV2IdMHNAkfx+Qs6zOL/uaFHRHLpKM7O6oS69j
	I8UL2crcE+DD8EmCS19MO53W5mRTub1WHNarZ6kvY/58LyFmf5hT
X-Gm-Gg: ASbGncsLaAHuWOZHcU3v3nXI1nNayfrZkldkQsmBYH2fZgXSZACmZhznlOf4ZV0gL/S
	7hGHfM8NQTMbjUkDumN2s+8/bYY8a/KHdibAtE0hczzP3ZhAU86p6mP3vD+SsXYt/FBu5Ig2JTn
	Edk9rR1GtQsLp2GFAUdxx98ZPEq0ZOZbpIbm+CUzCwYnmr1yaiYPbFwGsEsfpESjT8LPIN+vdZ7
	3qMuBVXG+wMqvikaZ2XbvCODC7GexIGJtZsGwblV9YDro1zVIhi9NlPEK8NjiBjVHVODaB4looW
	WDFWiBWHqhTk
X-Google-Smtp-Source: AGHT+IEH3UX6IGKWcsotxYYat/9d2h91vDhlDoj32ujW+KjFmp/d1tL5foLw0YUbv6SM/fCtzaVEsA==
X-Received: by 2002:a05:6a20:2d14:b0:1e1:c03c:b420 with SMTP id adf61e73a8af0-1e1dfe127admr15811916637.31.1734286361885;
        Sun, 15 Dec 2024 10:12:41 -0800 (PST)
Received: from mbp.lan (c-73-202-46-50.hsd1.ca.comcast.net. [73.202.46.50])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-801d5a90ba0sm2808120a12.16.2024.12.15.10.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2024 10:12:41 -0800 (PST)
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
Subject: [PATCH v14 03/10] perf record --off-cpu: Preparation of off-cpu BPF program
Date: Sun, 15 Dec 2024 10:12:13 -0800
Message-ID: <20241215181220.754822-4-howardchu95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241215181220.754822-1-howardchu95@gmail.com>
References: <20241215181220.754822-1-howardchu95@gmail.com>
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

