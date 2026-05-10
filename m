Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5B224677F;
	Sun, 10 May 2026 03:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778384140; cv=none; b=StDpwT/yhcCNYwXXGx14P1Pg72LgGSWy5C8Qd0UuJFp71//+SpQohf/CcjSwmZ6Q1YatIl7Xx8WyJjk6V/lc3BqylZsR+WyYx2LvvDageISV8eWljz6xguNfiL0SXvxIdhfa1yvfcqyjWx7lHRXlDhAYsH477iweVPr9VyuCzMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778384140; c=relaxed/simple;
	bh=CqFwPdskAmw+P1xkh14kA1xCrBzke1eMXGS0ToHyLos=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T+qDenfus9o1qaUIHQ5zWLCaHzjK7/yRx0M4MjfV8F4qXWZ0f0ZptJ+0QapUvMLqYVZJogqiOCBcee0DaTyHRSonf5qL7PX87epaq6fiRIausD02hfXos//hBN0YPZjP0CCOg8+WJZVtwfbU9EHVZZaA8uiFi4sjd/0dEKrmnZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=StAnZMfF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="StAnZMfF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BC0EC2BCB8;
	Sun, 10 May 2026 03:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778384140;
	bh=CqFwPdskAmw+P1xkh14kA1xCrBzke1eMXGS0ToHyLos=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=StAnZMfF/TcbifprWZbBPHEAcKNN+lecb+uSgufnqXKF2uRPbrapVW063HYjF7Idp
	 2Nrl/wCRXxCw+IQxwk30OjjBGOY2ARe7kqXzKHVs6qp8XGobmpQzo4dg90sf7qx/tS
	 yZJ6M1zTbP241cYLC7Qwv35fv6tnvByUo643Mgdj7jQJ1YkIDh0Ns7Nkgov9W+cNrI
	 +7Maj8KbmSZ6Dl0Jd8IeQhrEMOuMKtDeLTAmdUC2l7wvFb4xQGTWB+KVEoMXEnqZox
	 ZJRuBXXarXM65ChJt2DgIcqGYWlDhxjf4brmFuaNRmgdQ2Kx5FDSc9jb6qP6OhERst
	 V0dYgGnPaPSbw==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	sashiko-bot@kernel.org,
	"Claude Opus 4.6 (1M context)" <noreply@anthropic.com>
Subject: [PATCH 12/28] perf cpumap: Reject RANGE_CPUS with start_cpu > end_cpu
Date: Sun, 10 May 2026 00:34:03 -0300
Message-ID: <20260510033424.255812-13-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260510033424.255812-1-acme@kernel.org>
References: <20260510033424.255812-1-acme@kernel.org>
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

Reported-by: sashiko-bot@kernel.org # Running on a local machine
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Assisted-by: Claude Opus 4.6 (1M context) <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cpumap.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
index 11922e1ded844a03..c32db7b307d7d959 100644
--- a/tools/perf/util/cpumap.c
+++ b/tools/perf/util/cpumap.c
@@ -93,9 +93,18 @@ static struct perf_cpu_map *cpu_map__from_entries(const struct perf_record_cpu_m
 static struct perf_cpu_map *cpu_map__from_mask(const struct perf_record_cpu_map_data *data)
 {
 	DECLARE_BITMAP(local_copy, 64);
-	int weight = 0, mask_nr = data->mask32_data.nr;
+	int weight = 0, mask_nr;
+	/* Cache validated long_size — data is mmap'd and could change */
+	u16 long_size;
 	struct perf_cpu_map *map;
 
+	/* long_size must be 4 or 8; other values overflow cpus_per_i below */
+	if (data->mask32_data.long_size != 4 && data->mask32_data.long_size != 8)
+		return NULL;
+
+	long_size = data->mask32_data.long_size;
+	mask_nr = data->mask32_data.nr;
+
 	for (int i = 0; i < mask_nr; i++) {
 		perf_record_cpu_map_data__read_one_mask(data, i, local_copy);
 		weight += bitmap_weight(local_copy, 64);
@@ -106,11 +115,14 @@ static struct perf_cpu_map *cpu_map__from_mask(const struct perf_record_cpu_map_
 		return NULL;
 
 	for (int i = 0, j = 0; i < mask_nr; i++) {
-		int cpus_per_i = (i * data->mask32_data.long_size  * BITS_PER_BYTE);
+		int cpus_per_i = (i * long_size * BITS_PER_BYTE);
 		int cpu;
 
 		perf_record_cpu_map_data__read_one_mask(data, i, local_copy);
 		for_each_set_bit(cpu, local_copy, 64) {
+			/* Guard against more set bits than the first pass counted */
+			if (j >= weight)
+				break;
 			if (cpu + cpus_per_i < INT16_MAX) {
 				RC_CHK_ACCESS(map)->map[j++].cpu = cpu + cpus_per_i;
 			} else {
@@ -129,8 +141,12 @@ static struct perf_cpu_map *cpu_map__from_range(const struct perf_record_cpu_map
 	struct perf_cpu_map *map;
 	unsigned int i = 0;
 
+	if (data->range_cpu_data.end_cpu < data->range_cpu_data.start_cpu)
+		return NULL;
+
+	/* any_cpu is boolean (0 or 1), not a count — clamp to avoid inflated nr */
 	map = perf_cpu_map__empty_new(data->range_cpu_data.end_cpu -
-				data->range_cpu_data.start_cpu + 1 + data->range_cpu_data.any_cpu);
+				data->range_cpu_data.start_cpu + 1 + !!data->range_cpu_data.any_cpu);
 	if (!map)
 		return NULL;
 
-- 
2.54.0

