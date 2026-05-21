Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1C1306742;
	Thu, 21 May 2026 01:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779325888; cv=none; b=NYs3l92yzrTwpIpOFkl/flwkcIAE7aR5aRIfUaUyGrBsvlEzZUwtQl8QsB4zF6QZbWnOmUWgsGxMbpZfnk/zgV+5aOVn1ypB2IsRUKGzDCP2VwDvBwj4y775JhHI1Nehp4+8TJEcBauLiWx17nQCWYFIXkREURWo7zJEK9wyObE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779325888; c=relaxed/simple;
	bh=AisTe5aNqx5CvT1F82WxI0V4CfiyYNVG1u/onxrZmks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bl+8v8j6/MTDGdsR/Lbgfz1wWsckCt31JBjVftBlW5ujpyQiaXtHdTDkPo4g1jqGd0eE4Km88SSZjKdvajbnndlPHQNuWrUNuuXGIOD+VEtGWnHwZmHcqgnQ6MC/YYKmlv4N4AiXzqux7iJcorClma4u4pcrJ18nlVwAgV02vsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dTzEM5vG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dTzEM5vG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 145691F000E9;
	Thu, 21 May 2026 01:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779325887;
	bh=s2fVRvE1DE0+S2DjkNwQCDdJdaMAXP10pP6s9pG8VJc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dTzEM5vGF1tOK7JtIRDatQo/tjKa+gl5uMhZfChsvAgB+t2RIM0UfOZcLaF/r4Uhm
	 kbxynuhykCc3ANLmbXbXV/wGKBBwXGPAvlfOFb375ZCNdpKSSjMaY6VhOYDJxnxo2E
	 p5qaX8JIqGs1EyoxidUSPw3xBqDo8VIgkqhra9YzDQ9/r7XH8Jw9m2oItDuol0KafU
	 2nWwpJ3wC/NTd+3VTj+sA25uDEGsVEvR29iXKb7mdPNVy5nSfI1Fx/uj2FXIpzXMFi
	 kwsMfNDaqpF/OfE6dsctkc/zbHiFyWRafFB+opdC4fIXCk/TSWDzdTzdG6e+j50gzx
	 wCXBoy1SmehOw==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	sashiko-bot@kernel.org,
	"Claude Opus 4.6 (1M context)" <noreply@anthropic.com>
Subject: [PATCH 12/27] perf cpumap: Reject RANGE_CPUS with start_cpu > end_cpu
Date: Wed, 20 May 2026 22:09:57 -0300
Message-ID: <20260521011027.622268-13-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260521011027.622268-1-acme@kernel.org>
References: <20260521011027.622268-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

cpu_map__from_range() computes nr_cpus as end_cpu - start_cpu + 1.
When a crafted perf.data has start_cpu > end_cpu, this wraps to a
huge value, causing perf_cpu_map__empty_new() to attempt a massive
allocation.

Return NULL when the range is inverted.

Also clamp any_cpu to boolean (0 or 1) since it is added to the
allocation count — a crafted value > 1 would inflate the map size.

Harden cpu_map__from_mask() to reject unsupported long_size values
(anything other than 4 or 8), preventing misinterpretation of the
mask data layout.

Snapshot mmap'd fields via READ_ONCE() into locals to prevent
TOCTOU re-reads — the data pointer references MAP_SHARED mmap'd
memory that could theoretically change between reads on a
FUSE-backed file:

- cpu_map__from_range(): snapshot start_cpu, end_cpu, any_cpu
- cpu_map__from_entries(): snapshot nr and each cpu[i] element
- cpu_map__from_mask(): snapshot long_size (before validation,
  closing the check-then-read gap), mask_nr
- perf_record_cpu_map_data__read_one_mask(): add u16 long_size
  parameter so callers pass the validated copy instead of
  re-reading data->mask32_data.long_size from mmap'd memory

Reported-by: sashiko-bot@kernel.org # Running on a local machine
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Assisted-by: Claude Opus 4.6 (1M context) <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cpumap.c | 62 +++++++++++++++++++++++++++++-----------
 1 file changed, 45 insertions(+), 17 deletions(-)

diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
index 11922e1ded844a03..b1e5c29c6e3ec8df 100644
--- a/tools/perf/util/cpumap.c
+++ b/tools/perf/util/cpumap.c
@@ -10,6 +10,7 @@
 #include <linux/bitmap.h>
 #include "asm/bug.h"
 
+#include <linux/compiler.h>
 #include <linux/ctype.h>
 #include <linux/zalloc.h>
 #include <internal/cpumap.h>
@@ -40,15 +41,16 @@ bool perf_record_cpu_map_data__test_bit(int i,
 
 /* Read ith mask value from data into the given 64-bit sized bitmap */
 static void perf_record_cpu_map_data__read_one_mask(const struct perf_record_cpu_map_data *data,
-						    int i, unsigned long *bitmap)
+						    int i, unsigned long *bitmap,
+						    u16 long_size)
 {
 #if __SIZEOF_LONG__ == 8
-	if (data->mask32_data.long_size == 4)
+	if (long_size == 4)
 		bitmap[0] = data->mask32_data.mask[i];
 	else
 		bitmap[0] = data->mask64_data.mask[i];
 #else
-	if (data->mask32_data.long_size == 4) {
+	if (long_size == 4) {
 		bitmap[0] = data->mask32_data.mask[i];
 		bitmap[1] = 0;
 	} else {
@@ -64,24 +66,27 @@ static void perf_record_cpu_map_data__read_one_mask(const struct perf_record_cpu
 }
 static struct perf_cpu_map *cpu_map__from_entries(const struct perf_record_cpu_map_data *data)
 {
+	/* Snapshot nr — data is mmap'd and could change between reads */
+	u16 nr = READ_ONCE(data->cpus_data.nr);
 	struct perf_cpu_map *map;
 
-	map = perf_cpu_map__empty_new(data->cpus_data.nr);
+	map = perf_cpu_map__empty_new(nr);
 	if (!map)
 		return NULL;
 
-	for (unsigned int i = 0; i < data->cpus_data.nr; i++) {
+	for (unsigned int i = 0; i < nr; i++) {
+		u16 cpu = READ_ONCE(data->cpus_data.cpu[i]);
 		/*
 		 * Special treatment for -1, which is not real cpu number,
 		 * and we need to use (int) -1 to initialize map[i],
 		 * otherwise it would become 65535.
 		 */
-		if (data->cpus_data.cpu[i] == (u16) -1) {
+		if (cpu == (u16) -1) {
 			RC_CHK_ACCESS(map)->map[i].cpu = -1;
-		} else if (data->cpus_data.cpu[i] < INT16_MAX) {
-			RC_CHK_ACCESS(map)->map[i].cpu = (int16_t) data->cpus_data.cpu[i];
+		} else if (cpu < INT16_MAX) {
+			RC_CHK_ACCESS(map)->map[i].cpu = (int16_t) cpu;
 		} else {
-			pr_err("Invalid cpumap entry %u\n", data->cpus_data.cpu[i]);
+			pr_err("Invalid cpumap entry %u\n", cpu);
 			perf_cpu_map__put(map);
 			return NULL;
 		}
@@ -93,11 +98,21 @@ static struct perf_cpu_map *cpu_map__from_entries(const struct perf_record_cpu_m
 static struct perf_cpu_map *cpu_map__from_mask(const struct perf_record_cpu_map_data *data)
 {
 	DECLARE_BITMAP(local_copy, 64);
-	int weight = 0, mask_nr = data->mask32_data.nr;
+	int weight = 0, mask_nr;
+	/* Snapshot before validation — data is mmap'd and could change */
+	u16 long_size = READ_ONCE(data->mask32_data.long_size);
 	struct perf_cpu_map *map;
 
+	/* long_size must be 4 or 8; other values overflow cpus_per_i below */
+	if (long_size != 4 && long_size != 8) {
+		pr_warning("WARNING: cpu_map mask: unsupported long_size %u\n", long_size);
+		return NULL;
+	}
+
+	mask_nr = READ_ONCE(data->mask32_data.nr);
+
 	for (int i = 0; i < mask_nr; i++) {
-		perf_record_cpu_map_data__read_one_mask(data, i, local_copy);
+		perf_record_cpu_map_data__read_one_mask(data, i, local_copy, long_size);
 		weight += bitmap_weight(local_copy, 64);
 	}
 
@@ -106,11 +121,14 @@ static struct perf_cpu_map *cpu_map__from_mask(const struct perf_record_cpu_map_
 		return NULL;
 
 	for (int i = 0, j = 0; i < mask_nr; i++) {
-		int cpus_per_i = (i * data->mask32_data.long_size  * BITS_PER_BYTE);
+		int cpus_per_i = (i * long_size * BITS_PER_BYTE);
 		int cpu;
 
-		perf_record_cpu_map_data__read_one_mask(data, i, local_copy);
+		perf_record_cpu_map_data__read_one_mask(data, i, local_copy, long_size);
 		for_each_set_bit(cpu, local_copy, 64) {
+			/* Guard against more set bits than the first pass counted */
+			if (j >= weight)
+				break;
 			if (cpu + cpus_per_i < INT16_MAX) {
 				RC_CHK_ACCESS(map)->map[j++].cpu = cpu + cpus_per_i;
 			} else {
@@ -126,18 +144,28 @@ static struct perf_cpu_map *cpu_map__from_mask(const struct perf_record_cpu_map_
 
 static struct perf_cpu_map *cpu_map__from_range(const struct perf_record_cpu_map_data *data)
 {
+	/* Snapshot fields — data is mmap'd and could change between reads */
+	u16 start_cpu = READ_ONCE(data->range_cpu_data.start_cpu);
+	u16 end_cpu = READ_ONCE(data->range_cpu_data.end_cpu);
+	u16 any_cpu = READ_ONCE(data->range_cpu_data.any_cpu);
 	struct perf_cpu_map *map;
 	unsigned int i = 0;
 
-	map = perf_cpu_map__empty_new(data->range_cpu_data.end_cpu -
-				data->range_cpu_data.start_cpu + 1 + data->range_cpu_data.any_cpu);
+	if (end_cpu < start_cpu) {
+		pr_warning("WARNING: cpu_map range: end_cpu %u < start_cpu %u\n",
+			   end_cpu, start_cpu);
+		return NULL;
+	}
+
+	/* any_cpu is boolean (0 or 1), not a count — clamp to avoid inflated nr */
+	map = perf_cpu_map__empty_new(end_cpu - start_cpu + 1 + !!any_cpu);
 	if (!map)
 		return NULL;
 
-	if (data->range_cpu_data.any_cpu)
+	if (any_cpu)
 		RC_CHK_ACCESS(map)->map[i++].cpu = -1;
 
-	for (int cpu = data->range_cpu_data.start_cpu; cpu <= data->range_cpu_data.end_cpu;
+	for (int cpu = start_cpu; cpu <= end_cpu;
 	     i++, cpu++) {
 		if (cpu < INT16_MAX) {
 			RC_CHK_ACCESS(map)->map[i].cpu = cpu;
-- 
2.54.0

