Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58EE1F6690;
	Mon, 16 Dec 2024 20:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734381873; cv=none; b=sKbHBLHZN3DPnxB14HUBjJapoGt7LDHbupiSEYr3UwpE3hOAdC+gWUs2rfqp3NqyH62wSRMlkgSxi6BjVeoEx3/sDz0sWdYhfUtp+sUi6j/k4VTNjR4Ovx1VH8YE2JfHx95v/+jD9fXVEGxyJuUdmYnVvxvF0dwhibpX5mFSkTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734381873; c=relaxed/simple;
	bh=fpUxignr32Zw/ERcGhovyvcFxBQ5lj+AXCNUw2RMk1s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eJjQrTLDo/y7PWvOee1wTDfbLhXkm6aj5rTsDjR8WNncfjZKTbZw27uwiYN5hyXa/R/g+AhhbZ0jh6B5oQ6kdJdrE5nYE8KMOVgPQw6vrO9kkxqXAU6b15eZACJY3nU1Ps/9oIvo8p9Gx5P47WHCvj5uW9GW6T8bsA8RwINvSG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aHipZGr5; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aHipZGr5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734381872; x=1765917872;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fpUxignr32Zw/ERcGhovyvcFxBQ5lj+AXCNUw2RMk1s=;
  b=aHipZGr5e9RU8yt4WhKxqrZBpVE7saAVhaX+R7nTwBRhp/5cx76HPVcv
   clvjjBrXZZB/5H+qDFiI/zfaHMB5Qf0eI1MdjdCu/QhM7dymEdI2D6UBe
   a0xB1qxEhYjQv52JvsaZuT+xk66bwH3Ja8Ne361YkkIjqAI2Z63WQnA1E
   RZwVvmGJAZ/INxXwEb1hbIDYxLjES6mVpxp4RjSmeklM8xjxNbDk3Zohp
   WpMtOUpe88VsDwlQ8nl7aUD77n0L7Vmpi0RLtxKeDRQCB3Ue17hjmkbgY
   78Rinv8VzqRGc2ns7iAfTe66ffwpMUO0w6qhDO106U2x3awojF+nswkr7
   g==;
X-CSE-ConnectionGUID: Y6eTJgnyTCCUjHKCzAPWxQ==
X-CSE-MsgGUID: NHaJdYObSSecdEzr94vekw==
X-IronPort-AV: E=McAfee;i="6700,10204,11288"; a="38461521"
X-IronPort-AV: E=Sophos;i="6.12,239,1728975600"; 
   d="scan'208";a="38461521"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 12:44:30 -0800
X-CSE-ConnectionGUID: cvOwnw/oQ0uswH7Ps0i04Q==
X-CSE-MsgGUID: n0CL51g3RwKbX0Zk9UjBCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="101926357"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmviesa005.fm.intel.com with ESMTP; 16 Dec 2024 12:44:30 -0800
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
	Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V5 3/4] perf: Extend perf_output_read
Date: Mon, 16 Dec 2024 12:45:04 -0800
Message-Id: <20241216204505.748363-3-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20241216204505.748363-1-kan.liang@linux.intel.com>
References: <20241216204505.748363-1-kan.liang@linux.intel.com>
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

No change from V4

The V4 can be found at
https://lore.kernel.org/lkml/20240731143835.771618-1-kan.liang@linux.intel.com/

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

