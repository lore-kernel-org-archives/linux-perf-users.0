Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5461A2553;
	Tue, 13 Aug 2024 16:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723564902; cv=none; b=f+ywtGFNYGzd0zb5HCQW6G1EdRps4sHXTXE7pVFH8vm2GQgQk+U5XMiXjO8v3kt53eGVh7Mrns+SdRdxdYRf4Gptfrc3FMYR3ruMwCOF03m7tYV3dvbBwWgSJlWDKBTMqJuW93u+djjFtZfGI0RoYZLVX6WRJ3GCfiGRQc/NiX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723564902; c=relaxed/simple;
	bh=RGx8KZ0mPU+21hMxzYjjPTeGX0Yn/dEoOCKNO8974xA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iCkJcaU8ff4XVyQW9aRdjEpMXy9O9oKt+Q0J+O4+mUS/Dl8pDIbVvAvc0Cv3h5ILs6FIuZ3kNzEEvvh8VdmH9jzw7skF8yFMsRinRlkqFw1ZX7jUb98KUGEP+2/9d1vu8NnmIT1/92RFBY45AzLuXLQPUxGEfzhFNgAfZv/EilA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XgeB+BbH; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XgeB+BbH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723564901; x=1755100901;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RGx8KZ0mPU+21hMxzYjjPTeGX0Yn/dEoOCKNO8974xA=;
  b=XgeB+BbHxwtEibMx4wkHIxgb+TquE9o+ODvlQL9lCFbtRmgspJRLcpV0
   tXylJBynbinc1EsWkc8LUaJeAkbsUQBqA4DgFqJRCjPaaogdxf/wEdg1Q
   Ynr0jxNKHvRz7DbhGLMlYr5JJ7m4lyISFhQv7mYG2zMeo0FNOARC22Lu5
   1VeM5Y5NlcbkzWQ0WX/zIaIp7C82awKoapubNxh3h+IRv2fpUD4d8CXJu
   D9wo7GhfX8KbVN+Y7VVwypP1O7ZIRcx/r3Rvvgysoq+Nq1xUKejQhsiOP
   cbw3EZ3xq3oDioJWYPhItittW8TL3joQlixXkelzbwN8lQmUiRrOrgPzl
   w==;
X-CSE-ConnectionGUID: yzdImREJS5CLV1c9ngVNZg==
X-CSE-MsgGUID: l/0mBFwVQk6cMoszCJc2Wg==
X-IronPort-AV: E=McAfee;i="6700,10204,11163"; a="21383214"
X-IronPort-AV: E=Sophos;i="6.09,286,1716274800"; 
   d="scan'208";a="21383214"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 09:01:37 -0700
X-CSE-ConnectionGUID: /T59vsbtS3K/EhZSM77mgg==
X-CSE-MsgGUID: /XYrNTUOTLaRHI5VY+3xhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,286,1716274800"; 
   d="scan'208";a="59479750"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orviesa008.jf.intel.com with ESMTP; 13 Aug 2024 09:01:36 -0700
From: kan.liang@linux.intel.com
To: acme@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	peterz@infradead.org,
	mingo@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: adrian.hunter@intel.com,
	ak@linux.intel.com,
	eranian@google.com,
	Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V3 5/9] perf evsel: Assign abbr name for the branch counter events
Date: Tue, 13 Aug 2024 09:02:04 -0700
Message-Id: <20240813160208.2493643-6-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20240813160208.2493643-1-kan.liang@linux.intel.com>
References: <20240813160208.2493643-1-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

There could be several branch counter events. If perf tool output the
result via the format "event name + a number", the line could be very
long and hard to read.

An abbreviation is introduced to replace the full event name in the
display. The abbreviation starts from 'A' to 'Z9', which can support
up to 286 events. The same abbreviation will be assigned if the same
events are found in the evlist. The next patch will utilize the
abbreviation name to show the branch counter events in the output.

Acked-by: Namhyung Kim <namhyung@kernel.org>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/util/evlist.c | 55 +++++++++++++++++++++++++++++++++++++++-
 tools/perf/util/evsel.h  |  6 +++++
 2 files changed, 60 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 68bbd3ea771b..c0379fa1ccfe 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -33,6 +33,7 @@
 #include "util/bpf-filter.h"
 #include "util/stat.h"
 #include "util/util.h"
+#include "util/env.h"
 #include "util/intel-tpebs.h"
 #include <signal.h>
 #include <unistd.h>
@@ -1265,15 +1266,67 @@ u64 evlist__combined_branch_type(struct evlist *evlist)
 	return branch_type;
 }
 
+static struct evsel *
+evlist__find_dup_event_from_prev(struct evlist *evlist, struct evsel *event)
+{
+	struct evsel *pos;
+
+	evlist__for_each_entry(evlist, pos) {
+		if (event == pos)
+			break;
+		if ((pos->core.attr.branch_sample_type & PERF_SAMPLE_BRANCH_COUNTERS) &&
+		    !strcmp(pos->name, event->name))
+			return pos;
+	}
+	return NULL;
+}
+
+#define MAX_NR_ABBR_NAME	(26 * 11)
+
+/*
+ * The abbr name is from A to Z9. If the number of event
+ * which requires the branch counter > MAX_NR_ABBR_NAME,
+ * return NA.
+ */
+static void evlist__new_abbr_name(char *name)
+{
+	static int idx;
+	int i = idx / 26;
+
+	if (idx >= MAX_NR_ABBR_NAME) {
+		name[0] = 'N';
+		name[1] = 'A';
+		name[2] = '\0';
+		return;
+	}
+
+	name[0] = 'A' + (idx % 26);
+
+	if (!i)
+		name[1] = '\0';
+	else {
+		name[1] = '0' + i - 1;
+		name[2] = '\0';
+	}
+
+	idx++;
+}
+
 void evlist__update_br_cntr(struct evlist *evlist)
 {
-	struct evsel *evsel;
+	struct evsel *evsel, *dup;
 	int i = 0;
 
 	evlist__for_each_entry(evlist, evsel) {
 		if (evsel->core.attr.branch_sample_type & PERF_SAMPLE_BRANCH_COUNTERS) {
 			evsel->br_cntr_idx = i++;
 			evsel__leader(evsel)->br_cntr_nr++;
+
+			dup = evlist__find_dup_event_from_prev(evlist, evsel);
+			if (dup)
+				memcpy(evsel->abbr_name, dup->abbr_name, 3 * sizeof(char));
+			else
+				evlist__new_abbr_name(evsel->abbr_name);
 		}
 	}
 	evlist->nr_br_cntr = i;
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index a393dae1dc96..4316992f6a69 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -153,9 +153,15 @@ struct evsel {
 	 * br_cntr_idx: The idx of the branch counter event in the evlist
 	 * br_cntr_nr:  The number of the branch counter event in the group
 	 *	        (Only available for the leader event)
+	 * abbr_name:   The abbreviation name assigned to an event which is
+	 *		logged by the branch counter.
+	 *		The abbr name is from A to Z9. NA is applied if out
+	 *		of the range.
 	 */
 	int			br_cntr_idx;
 	int			br_cntr_nr;
+	char			abbr_name[3];
+
 	/*
 	 * bpf_counter_ops serves two use cases:
 	 *   1. perf-stat -b          counting events used byBPF programs
-- 
2.38.1

