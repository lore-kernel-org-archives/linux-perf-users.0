Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BE525E463
	for <linux-perf-users@vger.kernel.org>; Mon, 10 Feb 2025 19:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739214758; cv=none; b=WIZFMkBFCTT7knc5nrjmcD66ebky2uQ+Ke8adbewSD3+T5RYcoo+M/gRjkcmnKk5Qx9gZBZ08HT33joAzid/q/yyRPmKegUQI/V3l+p96+f7/i7ZoxxTRJseSP67lZg7B3kISagoSHJ0GHLob/r/4Xw3jNq91iU8i7Bx3OSMrUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739214758; c=relaxed/simple;
	bh=c4VvBbH7uMZOC2uY2zHXPsbHjoTOuRrPLVazsSCZ0zU=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Cc:Content-Type; b=RWGLqbQ1hl296MEwpTjvpmX6QDerJGEqh7H1AFOg9lqLHJO5uaIpIIEyzj0m9Q38Mc7ZRQc67lGtPrNihAunxuJWAxOi0GOtNVIeEjCJQzN9jW3mZezypgSw9YvboH3H8lgNbGdVkekj9s/b+/P91N0GUih6j3ZT565uMFeYUAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WtMEFT/3; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WtMEFT/3"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6f2c7746509so69675207b3.1
        for <linux-perf-users@vger.kernel.org>; Mon, 10 Feb 2025 11:12:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739214754; x=1739819554; darn=vger.kernel.org;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OR8P25OJ4vGDOaMebWgow/0A+NvhiOK6b9XUs76+pr4=;
        b=WtMEFT/394V7MaYCKEgMR77pw4O+uKq9F3nMh06Wh+qrP7griXXukLYqJIiuwBGgkl
         e/OzMWb/HL3McCwBKYRTCE0ddcRAlNFfzpJhRTOHBIYrC86ruZpkWrwdUnTuWKznJjmT
         MBjhbaM86KydgD00TFUVnhJ78wMBWXW/8Vr0wS5So4JJe+oi0nmwnV0yyMU8C2j56rG4
         mEYA9nQvCC2WrgQImY7MCwaoxvoliqruKDYkw855ZKdt/8pTGGggwzVig61Oq8d8gYmW
         oUypsQgsKr3ybUYaiIXY2U+4OurJmcusTIKVR1Waoax6lPwi2TFv9oAjgX0Ar+fMsEdK
         Lo9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739214754; x=1739819554;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OR8P25OJ4vGDOaMebWgow/0A+NvhiOK6b9XUs76+pr4=;
        b=xSOfsHy3CaQUWHPN/UZ/vOIzRpZmr+aGmuz5gAzFNv7uS3ajxFgrGG/KHZfa5/FkVj
         F4k/AuZhVEtoYZjWUA1of7BR0Y7RDhZHEtane2OaPRCDIXQs0tvq1jyGEkofOBGKXpy4
         K3f9jEHEO1B7Z3+2w0U6xzhnAPPLwNu02cUkl/mbl72Hv0+da4ckj/G9aJmiP018e4me
         ugwlmxgq1hqrniedUOD+sJBzl7FZ16ngIC6LaQaEgTkiAi0SMfPVr7QJ+Y/aInA/IY0G
         jqECmwuIFjG0J3I5ekZvndRTrQHbobHtIEF7Hrqw4iVK64YAXJPtwtmz5+4fzZ4AU2Vm
         CH/g==
X-Forwarded-Encrypted: i=1; AJvYcCUrxYX7wUhPulEZ451L1lDqxCInu991sAmofod1kHxTu9zRGaocrvbUybBhYPO6Sj8PPSEjNK4k7J6Nl9MGZiZg@vger.kernel.org
X-Gm-Message-State: AOJu0Yz32q1ik5XwN15VZFmi7ts4bOfqCkqNYo+cl+Oywgysjy0jRen7
	ipiTU+568cJ+j1jLLplkZN9DR0EvC30qKwhMe4dRM4zmN+vfw2Gvo/sGS69k8Ogi6FC+4Y2thpV
	zz2gk7Q==
X-Google-Smtp-Source: AGHT+IEFGNvZNrTvurg9Q9s3VyBmuy8tCX2cZ77ByEDGWHebDA0fRRpZBRRIZa6H7Ph07kANZ45IznFo9U02
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:c64e:af58:30d4:168d])
 (user=irogers job=sendgmr) by 2002:a05:690c:3306:b0:6fb:be:e331 with SMTP id
 00721157ae682-6fb00bee3cfmr263747b3.6.1739214754488; Mon, 10 Feb 2025
 11:12:34 -0800 (PST)
Date: Mon, 10 Feb 2025 11:12:31 -0800
Message-Id: <20250210191231.156294-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Subject: [PATCH v3] perf cpumap: Reduce cpu size from int to int16_t
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@linaro.org>, Tim Chen <tim.c.chen@linux.intel.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kyle Meyer <kyle.meyer@hpe.com>
Cc: Ian Rogers <irogers@google.com>
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
---
v3. Add bounds checks as suggested by Leo Yan <leo.yan@arm.com>.
v2. Rebase and tweak commit message add Reviewed-by: Tim Chen
    <tim.c.chen@linux.intel.com>.
---
 tools/lib/perf/cpumap.c              |  8 ++--
 tools/lib/perf/include/perf/cpumap.h |  3 +-
 tools/perf/util/cpumap.c             | 68 +++++++++++++++++++---------
 tools/perf/util/env.c                |  2 +-
 4 files changed, 54 insertions(+), 27 deletions(-)

diff --git a/tools/lib/perf/cpumap.c b/tools/lib/perf/cpumap.c
index fcc47214062a..4454a5987570 100644
--- a/tools/lib/perf/cpumap.c
+++ b/tools/lib/perf/cpumap.c
@@ -185,7 +185,7 @@ struct perf_cpu_map *perf_cpu_map__new(const char *cpu_list)
 	while (isdigit(*cpu_list)) {
 		p = NULL;
 		start_cpu = strtoul(cpu_list, &p, 0);
-		if (start_cpu >= INT_MAX
+		if (start_cpu >= INT16_MAX
 		    || (*p != '\0' && *p != ',' && *p != '-' && *p != '\n'))
 			goto invalid;
 
@@ -194,7 +194,7 @@ struct perf_cpu_map *perf_cpu_map__new(const char *cpu_list)
 			p = NULL;
 			end_cpu = strtoul(cpu_list, &p, 0);
 
-			if (end_cpu >= INT_MAX || (*p != '\0' && *p != ',' && *p != '\n'))
+			if (end_cpu >= INT16_MAX || (*p != '\0' && *p != ',' && *p != '\n'))
 				goto invalid;
 
 			if (end_cpu < start_cpu)
@@ -209,7 +209,7 @@ struct perf_cpu_map *perf_cpu_map__new(const char *cpu_list)
 		for (; start_cpu <= end_cpu; start_cpu++) {
 			/* check for duplicates */
 			for (i = 0; i < nr_cpus; i++)
-				if (tmp_cpus[i].cpu == (int)start_cpu)
+				if (tmp_cpus[i].cpu == (int16_t)start_cpu)
 					goto invalid;
 
 			if (nr_cpus == max_entries) {
@@ -219,7 +219,7 @@ struct perf_cpu_map *perf_cpu_map__new(const char *cpu_list)
 					goto invalid;
 				tmp_cpus = tmp;
 			}
-			tmp_cpus[nr_cpus++].cpu = (int)start_cpu;
+			tmp_cpus[nr_cpus++].cpu = (int16_t)start_cpu;
 		}
 		if (*p)
 			++p;
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
index 5c329ad614e9..9bc5e0370234 100644
--- a/tools/perf/util/cpumap.c
+++ b/tools/perf/util/cpumap.c
@@ -67,19 +67,23 @@ static struct perf_cpu_map *cpu_map__from_entries(const struct perf_record_cpu_m
 	struct perf_cpu_map *map;
 
 	map = perf_cpu_map__empty_new(data->cpus_data.nr);
-	if (map) {
-		unsigned i;
-
-		for (i = 0; i < data->cpus_data.nr; i++) {
-			/*
-			 * Special treatment for -1, which is not real cpu number,
-			 * and we need to use (int) -1 to initialize map[i],
-			 * otherwise it would become 65535.
-			 */
-			if (data->cpus_data.cpu[i] == (u16) -1)
-				RC_CHK_ACCESS(map)->map[i].cpu = -1;
-			else
-				RC_CHK_ACCESS(map)->map[i].cpu = (int) data->cpus_data.cpu[i];
+	if (!map)
+		return NULL;
+
+	for (unsigned int i = 0; i < data->cpus_data.nr; i++) {
+		/*
+		 * Special treatment for -1, which is not real cpu number,
+		 * and we need to use (int) -1 to initialize map[i],
+		 * otherwise it would become 65535.
+		 */
+		if (data->cpus_data.cpu[i] == (u16) -1) {
+			RC_CHK_ACCESS(map)->map[i].cpu = -1;
+		} else if (data->cpus_data.cpu[i] < INT16_MAX) {
+			RC_CHK_ACCESS(map)->map[i].cpu = (int16_t) data->cpus_data.cpu[i];
+		} else {
+			pr_err("Invalid cpumap entry %u\n", data->cpus_data.cpu[i]);
+			perf_cpu_map__put(map);
+			return NULL;
 		}
 	}
 
@@ -106,8 +110,15 @@ static struct perf_cpu_map *cpu_map__from_mask(const struct perf_record_cpu_map_
 		int cpu;
 
 		perf_record_cpu_map_data__read_one_mask(data, i, local_copy);
-		for_each_set_bit(cpu, local_copy, 64)
-			RC_CHK_ACCESS(map)->map[j++].cpu = cpu + cpus_per_i;
+		for_each_set_bit(cpu, local_copy, 64) {
+			if (cpu + cpus_per_i < INT16_MAX) {
+				RC_CHK_ACCESS(map)->map[j++].cpu = cpu + cpus_per_i;
+			} else {
+				pr_err("Invalid cpumap entry %d\n", cpu + cpus_per_i);
+				perf_cpu_map__put(map);
+				return NULL;
+			}
+		}
 	}
 	return map;
 
@@ -127,8 +138,15 @@ static struct perf_cpu_map *cpu_map__from_range(const struct perf_record_cpu_map
 		RC_CHK_ACCESS(map)->map[i++].cpu = -1;
 
 	for (int cpu = data->range_cpu_data.start_cpu; cpu <= data->range_cpu_data.end_cpu;
-	     i++, cpu++)
-		RC_CHK_ACCESS(map)->map[i].cpu = cpu;
+	     i++, cpu++) {
+		if (cpu < INT16_MAX) {
+			RC_CHK_ACCESS(map)->map[i].cpu = cpu;
+		} else {
+			pr_err("Invalid cpumap entry %d\n", cpu);
+			perf_cpu_map__put(map);
+			return NULL;
+		}
+	}
 
 	return map;
 }
@@ -427,7 +445,7 @@ static void set_max_cpu_num(void)
 {
 	const char *mnt;
 	char path[PATH_MAX];
-	int ret = -1;
+	int max, ret = -1;
 
 	/* set up default */
 	max_cpu_num.cpu = 4096;
@@ -444,10 +462,12 @@ static void set_max_cpu_num(void)
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
@@ -455,8 +475,14 @@ static void set_max_cpu_num(void)
 		goto out;
 	}
 
-	ret = get_max_num(path, &max_present_cpu_num.cpu);
+	ret = get_max_num(path, &max);
 
+	if (!ret && max > INT16_MAX) {
+		pr_err("Read out of bounds max cpus of %d\n", max);
+		ret = -1;
+	}
+	if (!ret)
+		max_present_cpu_num.cpu = (int16_t)max;
 out:
 	if (ret)
 		pr_err("Failed to read max cpus, using default of %d\n", max_cpu_num.cpu);
@@ -606,7 +632,7 @@ size_t cpu_map__snprint(struct perf_cpu_map *map, char *buf, size_t size)
 #define COMMA first ? "" : ","
 
 	for (i = 0; i < perf_cpu_map__nr(map) + 1; i++) {
-		struct perf_cpu cpu = { .cpu = INT_MAX };
+		struct perf_cpu cpu = { .cpu = INT16_MAX };
 		bool last = i == perf_cpu_map__nr(map);
 
 		if (!last)
diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
index cae4f6d63318..36411749e007 100644
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
2.48.1.502.g6dc24dfdaf-goog

