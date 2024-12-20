Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B891A21C17F
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Dec 2024 18:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734720734; cv=none; b=CJX9CY5pYZNZojR+ean9+DwPO8+MlO+4PoD643utTlk91hp/fdofohGoOzROWEbbDRiQekf6LyCw/6+jq83jZxrhUQuxOCQPIkC51Y4E53QcbdukBc5zLYk075UuvA580MFBqLjfvqvP2elDPrrKdIQNDes0qC0TRhl7w/XlqSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734720734; c=relaxed/simple;
	bh=DUYLUfquG98uQq+kXpeAFU3xFpmomSDyKuleQtmrMEE=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=ZdmbGcD0zsR1rE3uBTMqS0G9WsEIbJdFE7wGQlGqininnVSAd/p4a1xGHGQs85c0SsFvSTXbgZklQC3QQWzMZNmNpbgNlrLzYcR/ZzGCfhr/LtRwJbO0ft7lomii7Do6tPYHFBsw6qillS93MPXoxXg1IWjeU7wKX1Eoi+A/jls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a994VDSO; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a994VDSO"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6f2bdb560ecso28700037b3.1
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Dec 2024 10:52:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734720731; x=1735325531; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3RjYZWYjU7P3d8ZH5N5N+LTCqyHJ1b2TYWiGLWSmoA4=;
        b=a994VDSOt1lmfscTiVHLGczfnUksxGdVGLxizjSlipDX2MBzF0ypLprLssSVTuz0BC
         D9BUdQzwuERsxhgnV6LvW0VKgW4ZFzaJfRmQcWIB2vMFbUmFOSFye18XTJ9eAoLoT/wp
         Nn24dVDYCSE8FFSyESxRPvO45YMt3hAdmLmK9jUTO3rXnUBURrF5NrKUKZoXQXMeYWCR
         T/Ae0RfmveUJoiYrXv+ShZsLT/LAcY6ygv/weeLhDqdjY1EzrYPAOxzXFM2zTa5a91pq
         MbXhUfxeO0Wt/Dvq2CTDs/y9+dbCL11B2SEAWVcGTpc8lusot+1wbhWsxCjfIKB3gJyS
         o1Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734720731; x=1735325531;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3RjYZWYjU7P3d8ZH5N5N+LTCqyHJ1b2TYWiGLWSmoA4=;
        b=aZd6A5HCKyrlyT/IvBUymC5/GdEuljvAWTOaQfJldxHnvDuYyItnNMtXUuH4ws8OYK
         zAUS5RGaC1Kfcm9mn18/s2yQaH/jhq4JeD5a6kJiYcgZZnySeJKISqe2f4x6IFS1a2zK
         AqG2Ab1bmIcHaKB/qi5SltO90trN3jFHAWZ2rm6Y+Upl4IkTIVmXVeEyIvfLmp4At0PF
         3Nwus8y7V9xJ3qXIKOX2hpDGcF47XqFVGIvrLF8J9dxcYYki1mg5ZLwVVY8LL9FfLlvT
         HsxAi5a0gLmFTcNPKA3jS0DeyhoW4B7Ic8ZRwbxq/z6MqEXOS9zZpSo0DFXsQSKhAj4N
         AqRw==
X-Forwarded-Encrypted: i=1; AJvYcCU5JQNfWOBu2bl2wuUIlxQ5LpikdwJXuBFW6t4MWcumwRriMv+5+s1MIoViuHyVe+vtdWVlwwSYhLSTTca/cBsb@vger.kernel.org
X-Gm-Message-State: AOJu0YzWcFXbfIYTpzbdYhiq2EtUslyd4ELvFI6J1sVGtKHwbz/G44PW
	dQYMT2YK6RTHZrVX3VdrhmAzdFrsA1O4WblO/n1L6eQ9APyzd2GDtSL4o1ABcaZkens00KgMrFS
	uS6mBUg==
X-Google-Smtp-Source: AGHT+IEtRVmaAuKRfic+UiyV02GKALJgnkq9gQfUbfzzW8ptoa0HAMbGM1hEnduwrk/PNQXb3sU2j16Vdtdy
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:2801:ca8b:1bd0:e38d])
 (user=irogers job=sendgmr) by 2002:a05:690c:ed4:b0:6e3:b08:92c7 with SMTP id
 00721157ae682-6f3f7f26de6mr93897b3.0.1734720730748; Fri, 20 Dec 2024 10:52:10
 -0800 (PST)
Date: Fri, 20 Dec 2024 10:52:07 -0800
Message-Id: <20241220185207.106161-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Subject: [PATCH v2] perf cpumap: Reduce cpu size from int to int16_t
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Tim Chen <tim.c.chen@linux.intel.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Leo Yan <leo.yan@arm.com>, 
	Kyle Meyer <kyle.meyer@hpe.com>
Content-Type: text/plain; charset="UTF-8"

Fewer than 32k logical CPUs are currently supported by perf. A cpumap
is indexed by an integer (see perf_cpu_map__cpu) yielding a perf_cpu
that wraps a 4-byte int for the logical CPU - the wrapping is done
deliberately to avoid confusing a logical CPU with an index into a
cpumap. Using a 4-byte int within the perf_cpu is larger than required
so this patch reduces it to the 2-byte int16_t. For a cpumap
containing 16 entries this will reduce the array size from 64 to 32
bytes. For very large servers with lots of logical CPUs the size
savings will be greater.

Signed-off-by: Ian Rogers <irogers@google.com>
Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
---
v2. Rebase and tweak commit message.
---
 tools/lib/perf/include/perf/cpumap.h |  3 ++-
 tools/perf/util/cpumap.c             | 13 ++++++++-----
 tools/perf/util/env.c                |  2 +-
 3 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/tools/lib/perf/include/perf/cpumap.h b/tools/lib/perf/include/perf/cpumap.h
index 188a667babc6..8c1ab0f9194e 100644
--- a/tools/lib/perf/include/perf/cpumap.h
+++ b/tools/lib/perf/include/perf/cpumap.h
@@ -4,10 +4,11 @@
 
 #include <perf/core.h>
 #include <stdbool.h>
+#include <stdint.h>
 
 /** A wrapper around a CPU to avoid confusion with the perf_cpu_map's map's indices. */
 struct perf_cpu {
-	int cpu;
+	int16_t cpu;
 };
 
 struct perf_cache {
diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
index 27094211edd8..85e224d8631b 100644
--- a/tools/perf/util/cpumap.c
+++ b/tools/perf/util/cpumap.c
@@ -427,7 +427,7 @@ static void set_max_cpu_num(void)
 {
 	const char *mnt;
 	char path[PATH_MAX];
-	int ret = -1;
+	int max, ret = -1;
 
 	/* set up default */
 	max_cpu_num.cpu = 4096;
@@ -444,10 +444,12 @@ static void set_max_cpu_num(void)
 		goto out;
 	}
 
-	ret = get_max_num(path, &max_cpu_num.cpu);
+	ret = get_max_num(path, &max);
 	if (ret)
 		goto out;
 
+	max_cpu_num.cpu = max;
+
 	/* get the highest present cpu number for a sparse allocation */
 	ret = snprintf(path, PATH_MAX, "%s/devices/system/cpu/present", mnt);
 	if (ret >= PATH_MAX) {
@@ -455,8 +457,9 @@ static void set_max_cpu_num(void)
 		goto out;
 	}
 
-	ret = get_max_num(path, &max_present_cpu_num.cpu);
-
+	ret = get_max_num(path, &max);
+	if (!ret)
+		max_present_cpu_num.cpu = max;
 out:
 	if (ret)
 		pr_err("Failed to read max cpus, using default of %d\n", max_cpu_num.cpu);
@@ -606,7 +609,7 @@ size_t cpu_map__snprint(struct perf_cpu_map *map, char *buf, size_t size)
 #define COMMA first ? "" : ","
 
 	for (i = 0; i < perf_cpu_map__nr(map) + 1; i++) {
-		struct perf_cpu cpu = { .cpu = INT_MAX };
+		struct perf_cpu cpu = { .cpu = INT16_MAX };
 		bool last = i == perf_cpu_map__nr(map);
 
 		if (!last)
diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
index 610c57da5b37..961a92545039 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -543,7 +543,7 @@ int perf_env__numa_node(struct perf_env *env, struct perf_cpu cpu)
 
 		for (i = 0; i < env->nr_numa_nodes; i++) {
 			nn = &env->numa_nodes[i];
-			nr = max(nr, perf_cpu_map__max(nn->map).cpu);
+			nr = max(nr, (int)perf_cpu_map__max(nn->map).cpu);
 		}
 
 		nr++;
-- 
2.47.1.613.gc27f4b7a9f-goog

