Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20831482E8;
	Wed, 18 Dec 2024 15:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734534974; cv=none; b=YsxFiw/6rUqYo/um9OJz1BwqKcZ+HsY3zSZMt9YNPJA6YvAAoUOMKBC0AivbYqk0CjdXw6WBMHxzq9fqWaPkuQmd/AKicAUDwbfj7F1SwYbHZUBOhr+Jp8H40OaC2nTnFOrrOJV8NqnJRYa/SQ2kIStwTCVTbVEI28q/iMGXG/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734534974; c=relaxed/simple;
	bh=NE4xbzM6/14n45AjxVZKRsVRhhAd7c8SFjEeZSfayas=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qHRQmR1ar/WQcMK1S3u4qA9+3suTEFOxB5u5p7sgrAigOEOwzQi6mSV0Na7kw/ZWRYFiTkJdTXo7UUMO8nDATt5LWOE2A+hpgTMjHPCfR6Uo2N5YBd4BuF/B8YKiDc4jgcJYoIC9mt379EptpLq7ZdRCipEoii3K4wQ8dDwyrpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nqPTWHhC; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nqPTWHhC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734534972; x=1766070972;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NE4xbzM6/14n45AjxVZKRsVRhhAd7c8SFjEeZSfayas=;
  b=nqPTWHhCsW+2wQz5w5mX1/HrvSO+NOWzyBrAD5iOOZti14u/CBCyWhkv
   5QkLi7vZwKbVsRHMQkSeDYmMgOSrFLFmoRPSA8H8jFlsmGNR5cBeWsd13
   sav0p21YEVhaZLjM36tetrMVobDiYU0ovG38VTdFcwbwaNRHrpqiIk6Ez
   qNxjdzpAMn3qmDYA6PvhKZctF6EmS5TyvVEOmIe3qhKZtnUWcBa5Qozq9
   PNQiCijCnwgO6OWoEnvA7SlplhloJ+ivX9DKOrd2nmIegy5P/cue432Ny
   nDOy2GqlRETqibFetTwkNVgr4m5SauZ52fXlEObWBTVrzchpm2aGYIFdH
   A==;
X-CSE-ConnectionGUID: ulTMRVRnTZ+jE3PjJHEF0g==
X-CSE-MsgGUID: bAkaXQbERSKmNpl7F4UYEQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11290"; a="35047709"
X-IronPort-AV: E=Sophos;i="6.12,244,1728975600"; 
   d="scan'208";a="35047709"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2024 07:16:08 -0800
X-CSE-ConnectionGUID: u7SspeomSPypeKv3zl8SRQ==
X-CSE-MsgGUID: u+Ki/9XySsGOkhm40DzjlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,244,1728975600"; 
   d="scan'208";a="97687792"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmviesa006.fm.intel.com with ESMTP; 18 Dec 2024 07:16:08 -0800
From: kan.liang@linux.intel.com
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: ak@linux.intel.com,
	eranian@google.com,
	dapeng1.mi@linux.intel.com,
	Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V6 2/3] perf: Extend perf_output_read
Date: Wed, 18 Dec 2024 07:16:42 -0800
Message-Id: <20241218151643.1031659-2-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20241218151643.1031659-1-kan.liang@linux.intel.com>
References: <20241218151643.1031659-1-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

The event may have been updated in the PMU-specific implementation,
e.g., Intel PEBS counters snapshotting. The common code should not
read and overwrite the value.

The PERF_SAMPLE_READ in the data->sample_type can be used to detect
whether the PMU-specific value is available. If yes, avoid the
pmu->read() in the common code.

Reviewed-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

No changes since V5

 kernel/events/core.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 684d631e78da..e2045403521a 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7422,7 +7422,7 @@ static void perf_output_read_one(struct perf_output_handle *handle,
 
 static void perf_output_read_group(struct perf_output_handle *handle,
 				   struct perf_event *event,
-				   u64 enabled, u64 running)
+				   u64 enabled, u64 running, bool read)
 {
 	struct perf_event *leader = event->group_leader, *sub;
 	u64 read_format = event->attr.read_format;
@@ -7445,7 +7445,7 @@ static void perf_output_read_group(struct perf_output_handle *handle,
 	if (read_format & PERF_FORMAT_TOTAL_TIME_RUNNING)
 		values[n++] = running;
 
-	if ((leader != event) &&
+	if ((leader != event) && read &&
 	    (leader->state == PERF_EVENT_STATE_ACTIVE))
 		leader->pmu->read(leader);
 
@@ -7460,7 +7460,7 @@ static void perf_output_read_group(struct perf_output_handle *handle,
 	for_each_sibling_event(sub, leader) {
 		n = 0;
 
-		if ((sub != event) &&
+		if ((sub != event) && read &&
 		    (sub->state == PERF_EVENT_STATE_ACTIVE))
 			sub->pmu->read(sub);
 
@@ -7491,7 +7491,8 @@ static void perf_output_read_group(struct perf_output_handle *handle,
  * all cores.
  */
 static void perf_output_read(struct perf_output_handle *handle,
-			     struct perf_event *event)
+			     struct perf_event *event,
+			     bool read)
 {
 	u64 enabled = 0, running = 0, now;
 	u64 read_format = event->attr.read_format;
@@ -7509,7 +7510,7 @@ static void perf_output_read(struct perf_output_handle *handle,
 		calc_timer_values(event, &now, &enabled, &running);
 
 	if (event->attr.read_format & PERF_FORMAT_GROUP)
-		perf_output_read_group(handle, event, enabled, running);
+		perf_output_read_group(handle, event, enabled, running, read);
 	else
 		perf_output_read_one(handle, event, enabled, running);
 }
@@ -7551,7 +7552,7 @@ void perf_output_sample(struct perf_output_handle *handle,
 		perf_output_put(handle, data->period);
 
 	if (sample_type & PERF_SAMPLE_READ)
-		perf_output_read(handle, event);
+		perf_output_read(handle, event, !(data->sample_flags & PERF_SAMPLE_READ));
 
 	if (sample_type & PERF_SAMPLE_CALLCHAIN) {
 		int size = 1;
@@ -8195,7 +8196,7 @@ perf_event_read_event(struct perf_event *event,
 		return;
 
 	perf_output_put(&handle, read_event);
-	perf_output_read(&handle, event);
+	perf_output_read(&handle, event, true);
 	perf_event__output_id_sample(event, &handle, &sample);
 
 	perf_output_end(&handle);
-- 
2.38.1

