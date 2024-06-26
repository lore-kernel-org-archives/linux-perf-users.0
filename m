Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7392B1850B8;
	Wed, 26 Jun 2024 14:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719413729; cv=none; b=o1UiRUa9ZcS/EGY9ZfTS6vqJ9BBuNnqdL8LtwqL7UYDMpcbD2xdyuLtJfyslwuQ8GrrDpu/yPmEfGSyBF2hNErd0FVI+d9PAdOoiLTBfmIxTQaPGifb997Unj0C258d7R5BNulRRoXn9JZOfbD8Yt7br0VGidn+2bGE+OqT/xqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719413729; c=relaxed/simple;
	bh=KcANrdZ7y8VoQfMbuEJKrubTtZ2yiWBODLZMnaA5OY4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oKw6RK+Uw4qbh3pRS0bn3VQfCyUuoYLYrCLlQh6Eja94IJWNXSN/w7kpn1KK56wGkdqwRUUdELU5oAUWtRLDQyKDy/y1mbtJVFY+w45iHzHo8gLks0EOZ4DcBoBaqGt0e8dvciPsdU45gx25ZIoy7p3W91jOx6rMeE+F4+gk0ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C487DDA7;
	Wed, 26 Jun 2024 07:55:51 -0700 (PDT)
Received: from e127643.cambridge.arm.com (e127643.arm.com [10.1.33.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 89D703F73B;
	Wed, 26 Jun 2024 07:55:23 -0700 (PDT)
From: James Clark <james.clark@arm.com>
To: linux-perf-users@vger.kernel.org,
	irogers@google.com,
	namhyung@kernel.org
Cc: robin.murphy@arm.com,
	James Clark <james.clark@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] perf pmu: Don't de-duplicate core PMUs
Date: Wed, 26 Jun 2024 15:54:46 +0100
Message-Id: <20240626145448.896746-3-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240626145448.896746-1-james.clark@arm.com>
References: <20240626145448.896746-1-james.clark@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Arm PMUs have a suffix, either a single decimal (armv8_pmuv3_0) or 3 hex
digits which (armv8_cortex_a53) which Perf assumes are both strippable
suffixes for the purposes of deduplication. S390 "cpum_cf" is a
similarly suffixed core PMU but is only two characters so is not treated
as strippable because the rules are a minimum of 3 hex characters or 1
decimal character.

There are two paths involved in listing PMU events:

 * HW/cache event printing assumes core PMUs don't have suffixes so
   doesn't try to strip.
 * Sysfs PMU events share the printing function with uncore PMUs which
   strips.

This results in slightly inconsistent Perf list behavior if a core PMU
has a suffix:

  # perf list
  ...
  armv8_pmuv3_0/branch-load-misses/
  armv8_pmuv3/l3d_cache_wb/          [Kernel PMU event]
  ...

Fix it by partially reverting back to the old list behavior where
stripping was only done for uncore PMUs. For example commit 8d9f5146f5da
("perf pmus: Sort pmus by name then suffix") mentions that only PMUs
starting 'uncore_' are considered to have a potential suffix. This
change doesn't go back that far, but does only strip PMUs that are
!is_core. This keeps the desirable behavior where the many possibly
duplicated uncore PMUs aren't repeated, but it doesn't break listing for
core PMUs.

Searching for a PMU continues to use the new stripped comparison
functions, meaning that it's still possible to request an event by
specifying the common part of a PMU name, or even open events on
multiple similarly named PMUs. For example:

  # perf stat -e armv8_cortex/inst_retired/

  5777173628      armv8_cortex_a53/inst_retired/          (99.93%)
  7469626951      armv8_cortex_a57/inst_retired/          (49.88%)

Fixes: 3241d46f5f54 ("perf pmus: Sort/merge/aggregate PMUs like mrvl_ddr_pmu")
Suggested-by: Ian Rogers <irogers@google.com>
Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/util/pmu.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 97d74fe6d816..28af48ea803f 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -847,6 +847,23 @@ __weak const struct pmu_metrics_table *pmu_metrics_table__find(void)
 	return perf_pmu__find_metrics_table(NULL);
 }
 
+/**
+ * Return the length of the PMU name not including the suffix for uncore PMUs.
+ *
+ * We want to deduplicate many similar uncore PMUs by stripping their suffixes,
+ * but there are never going to be too many core PMUs and the suffixes might be
+ * interesting. "arm_cortex_a53" vs "arm_cortex_a57" or "cpum_cf" for example.
+ *
+ * @skip_duplicate_pmus: False in verbose mode so all uncore PMUs are visible
+ */
+static size_t pmu_deduped_name_len(const struct perf_pmu *pmu, const char *name,
+				   bool skip_duplicate_pmus)
+{
+	return skip_duplicate_pmus && !pmu->is_core
+		? pmu_name_len_no_suffix(name)
+		: strlen(name);
+}
+
 /**
  * perf_pmu__match_ignoring_suffix - Does the pmu_name match tok ignoring any
  *                                   trailing suffix? The Suffix must be in form
@@ -1796,9 +1813,8 @@ static char *format_alias(char *buf, int len, const struct perf_pmu *pmu,
 			  const struct perf_pmu_alias *alias, bool skip_duplicate_pmus)
 {
 	struct parse_events_term *term;
-	size_t pmu_name_len = skip_duplicate_pmus
-		? pmu_name_len_no_suffix(pmu->name)
-		: strlen(pmu->name);
+	size_t pmu_name_len = pmu_deduped_name_len(pmu, pmu->name,
+						   skip_duplicate_pmus);
 	int used = snprintf(buf, len, "%.*s/%s", (int)pmu_name_len, pmu->name, alias->name);
 
 	list_for_each_entry(term, &alias->terms.terms, list) {
@@ -1839,9 +1855,8 @@ int perf_pmu__for_each_event(struct perf_pmu *pmu, bool skip_duplicate_pmus,
 		size_t buf_used, pmu_name_len;
 
 		info.pmu_name = event->pmu_name ?: pmu->name;
-		pmu_name_len = skip_duplicate_pmus
-			? pmu_name_len_no_suffix(info.pmu_name)
-			: strlen(info.pmu_name);
+		pmu_name_len = pmu_deduped_name_len(pmu, info.pmu_name,
+						    skip_duplicate_pmus);
 		info.alias = NULL;
 		if (event->desc) {
 			info.name = event->name;
-- 
2.34.1

