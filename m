Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BB3466B00;
	Mon, 28 Sep 2026 07:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790581886; cv=none; b=CDmz4xXypAtFNW21Dko13onQ7opACyJOBqgMqKAs/5uZDRRLiriY1EUkouas/izL88NVO6FztIzinRs6yTIQKzM4CoOZIvuVXKK4mzp6raemb+EqW2USBnowyqcjnBGVJ0BmErP3fNpXIwPCkvQ2nyugy7k6ZPh3NL7IYjuMr/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790581886; c=relaxed/simple;
	bh=ecrL/4xuo15JW0uPHaTcNYGs77A+2PvICKir9lRJCX4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cUtPPtw9eJLBEraOSA220Zbp2s58VJlMMuorsOajbvLKUAoFlOSo4tTBfJmS8aowp1mDufq9cZUPNbKsS/tCmxPP1YFQqKR+0tt7WrNeaQYtIugrpZmUzXYhKQRCO4PZzjq6CHaw3uA4Xv87WMKAXg2NVSDTbx0Nt3fIJPvFc4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HemgkKT1; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HemgkKT1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790581885; x=1822117885;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ecrL/4xuo15JW0uPHaTcNYGs77A+2PvICKir9lRJCX4=;
  b=HemgkKT1dYW0DsYW1fTYrxCHCvE4eOLpDqH3Nu0SksKEAqY4kta379yb
   SpKOXHmq97HE+FTsMCpbpdhX3fmhR0Izoa1JPDERySJeSTkpOUhFuyB1K
   dho7pYZIdWN61bPJOXCuCzQcrKSWDTWj8/BQvFT2pi3Ms2kZLhYkCeLew
   6t5CPXlRhiY+EeRniR0lHydpV7NRbFCQUEu8vcaZ4ePnPrQlYzN6awBTQ
   sNLIGzyjdHiDZ3wm7en3bs5VdV2yEyqljwyVoYiYk67cTFCctv2/doBD1
   woKqS9lcKKcg9Ocz2D0ZDtkBZ0ombHHfjf7cTt/FwqAEKiu/fsW1hB+BR
   g==;
X-CSE-ConnectionGUID: LwJELkxJRZa57IIQIY5bDw==
X-CSE-MsgGUID: GRUzQLzVQf2Cu/W34ddNDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11918"; a="90141504"
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="90141504"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 00:51:24 -0700
X-CSE-ConnectionGUID: Vuk+BD07Q5yge0/S/ZZ/hA==
X-CSE-MsgGUID: XhojjUq/TXWsFRffOwoj7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="275025069"
Received: from spr.sh.intel.com ([10.112.229.196])
  by orviesa009.jf.intel.com with ESMTP; 28 Sep 2026 00:51:21 -0700
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Xudong Hao <xudong.hao@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [PATCH 14/15] perf/core: Add event_caps dependency flags
Date: Mon, 28 Sep 2026 15:43:08 +0800
Message-Id: <20260928074309.898043-15-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260928074309.898043-1-dapeng1.mi@linux.intel.com>
References: <20260928074309.898043-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add two new event capability flags:
- PERF_EV_CAP_RELIED_ON: An event that other group events rely on. Must
  not be set on a group leader.
- PERF_EV_CAP_RELIANT: An event that relies on a group event carrying
  PERF_EV_CAP_RELIED_ON. Must not be combined with PERF_EV_CAP_RELIED_ON.
  If the dependency is on the group leader, use PERF_EV_CAP_SIBLING
  instead of PERF_EV_CAP_RELIANT.

When an event with PERF_EV_CAP_RELIED_ON is detached from the group, all
events in the group carrying PERF_EV_CAP_RELIANT can no longer function
and must be transitioned to the ERROR state.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 include/linux/perf_event.h |  8 ++++++
 kernel/events/core.c       | 52 +++++++++++++++++++++++++++++++++-----
 2 files changed, 53 insertions(+), 7 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 7797ce207555..3031fe8dab37 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -706,11 +706,19 @@ typedef void (*perf_overflow_handler_t)(struct perf_event *,
  * group it is scheduled out and moved into an unrecoverable ERROR state.
  * PERF_EV_CAP_READ_SCOPE: A CPU event that can be read from any CPU of the
  * PMU scope where it is active.
+ * PERF_EV_CAP_RELIED_ON: An event on which other group members depend.
+ * This flag must not be set on a group leader.
+ * PERF_EV_CAP_RELIANT: A member that depends on another group event carrying
+ * PERF_EV_CAP_RELIED_ON. It must not be combined with PERF_EV_CAP_RELIED_ON
+ * and must not be set on a group leader. If the dependency is on the group
+ * leader, use PERF_EV_CAP_SIBLING instead.
  */
 #define PERF_EV_CAP_SOFTWARE		BIT(0)
 #define PERF_EV_CAP_READ_ACTIVE_PKG	BIT(1)
 #define PERF_EV_CAP_SIBLING		BIT(2)
 #define PERF_EV_CAP_READ_SCOPE		BIT(3)
+#define PERF_EV_CAP_RELIED_ON		BIT(4)
+#define PERF_EV_CAP_RELIANT		BIT(5)
 
 #define SWEVENT_HLIST_BITS		8
 #define SWEVENT_HLIST_SIZE		(1 << SWEVENT_HLIST_BITS)
diff --git a/kernel/events/core.c b/kernel/events/core.c
index de05df65ab3d..55db0ad8b93a 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2349,13 +2349,12 @@ static void perf_promote_sibling_to_leader(struct perf_event *sibling,
 					   int group_caps)
 {
 	/*
-	 * Events that have PERF_EV_CAP_SIBLING require being part of
-	 * a group and cannot exist on their own, schedule them out
-	 * and move them into the ERROR state. Also see
-	 * _perf_event_enable(), it will not be able to recover this
-	 * ERROR state.
+	 * Events with PERF_EV_CAP_SIBLING or PERF_EV_CAP_RELIANT
+	 * must stay in a group or depend on another event in the
+	 * group; otherwise schedule them out and move them to ERROR.
+	 * _perf_event_enable() cannot recover from this state.
 	 */
-	if (sibling->event_caps & PERF_EV_CAP_SIBLING)
+	if (sibling->event_caps & (PERF_EV_CAP_SIBLING | PERF_EV_CAP_RELIANT))
 		__event_disable(sibling, ctx, PERF_EVENT_STATE_ERROR);
 
 	sibling->group_leader = sibling;
@@ -2371,6 +2370,43 @@ static void perf_promote_sibling_to_leader(struct perf_event *sibling,
 	perf_event__header_size(sibling);
 }
 
+static void perf_group_disable_reliants(struct perf_event *event)
+{
+	struct perf_event *leader = event->group_leader;
+	struct perf_event *sibling, *tmp;
+	struct perf_event_context *ctx = event->ctx;
+	u32 mask = PERF_EV_CAP_RELIED_ON | PERF_EV_CAP_RELIANT;
+
+	if (!(event->event_caps & PERF_EV_CAP_RELIED_ON))
+		return;
+
+	/* Group leader should not carry PERF_EV_CAP_RELIED_ON. */
+	WARN_ON_ONCE(leader->event_caps & PERF_EV_CAP_RELIED_ON);
+	/* Group leader should not carry PERF_EV_CAP_RELIANT. */
+	WARN_ON_ONCE(leader->event_caps & PERF_EV_CAP_RELIANT);
+
+	/*
+	 * Disable all siblings that rely on this event. Without it,
+	 * they cannot function and would otherwise fall into ERROR state.
+	 */
+	list_for_each_entry_safe(sibling, tmp, &leader->sibling_list, sibling_list) {
+		if (!(sibling->event_caps & PERF_EV_CAP_RELIANT))
+			continue;
+
+		/*
+		 * An event must not set both PERF_EV_CAP_RELIED_ON and
+		 * PERF_EV_CAP_RELIANT simultaneously.
+		 */
+		if (WARN_ON_ONCE((sibling->event_caps & mask) == mask))
+			continue;
+
+		list_del_init(&sibling->sibling_list);
+		leader->nr_siblings--;
+		leader->group_generation++;
+		perf_promote_sibling_to_leader(sibling, ctx, leader->group_caps);
+	}
+}
+
 static void perf_group_detach(struct perf_event *event)
 {
 	struct perf_event *leader = event->group_leader;
@@ -2393,6 +2429,7 @@ static void perf_group_detach(struct perf_event *event)
 	 * If this is a sibling, remove it from its group.
 	 */
 	if (leader != event) {
+		perf_group_disable_reliants(event);
 		list_del_init(&event->sibling_list);
 		leader->nr_siblings--;
 		leader->group_generation++;
@@ -3305,7 +3342,8 @@ static void _perf_event_enable(struct perf_event *event)
 		/*
 		 * Detached SIBLING events cannot leave ERROR state.
 		 */
-		if (event->event_caps & PERF_EV_CAP_SIBLING &&
+		if (event->event_caps &
+		    (PERF_EV_CAP_SIBLING | PERF_EV_CAP_RELIANT) &&
 		    event->group_leader == event)
 			goto out;
 
-- 
2.34.1

