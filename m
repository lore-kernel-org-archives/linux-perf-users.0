Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764D520E71E;
	Wed,  4 Jun 2025 17:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749057396; cv=none; b=S+gQZ/5LAbDKTO9CytwWCyuVbVHBxEfWHVMQjY8iQaGdj+U/7kEhtiJDf1z8RFMLEiV55FXoKXbU37HICffw8ILOa5rnTqL1gCqr6wX2cMoXb4aQK4wbk0ih0YQwRIGukMqtp1e9KDwvQyEOQNpn5tH/ybtAKj++QzGXCdyOm3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749057396; c=relaxed/simple;
	bh=kjLd+ddb6deYgxmwwC4dNdpjsazgtApHNAXz/v7lLt8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PCB4sC2ppWu5qPbetl2eP3aTS4fV2SejgaeGc2ij1FrA37arYUSFc/aiCeeZKddmhmkeL25L2gzwEvdAKsrJv2ul7hfNBk7D/wppOrYnZxqUto+p6/HW5Q8qpGY0xJB5H2GGXLbUO9rzRgi0bgfELWCDg12H1vNvkUJQDA4ALZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=legGlQyY; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="legGlQyY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749057395; x=1780593395;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kjLd+ddb6deYgxmwwC4dNdpjsazgtApHNAXz/v7lLt8=;
  b=legGlQyYqZ7wxYWTwPRMTZaVe0QEqWVC8quKGA/qgUVoDIbU/M2aKNzy
   I4C1XB0ujiNene7+hUzIXrPsU36IH0m4KX0P7eKcXYBTkzVLx0ma3WE8b
   mqqBD7gGrG7ftne46kQOvooCNzE6DJvEIQp5Ghg2RXfQe0PYEj/jXhclk
   uta3xWHgFzP5Yd5fCUzvNNMPQpDqNq8rrEYXlinCYwfjTwUv50sSls3Pj
   fkJdh7d1mBk5DOVQCWIBRr45rYpVLv8imJ103XHNurNcmnnPipKo0MvyX
   /a9/B3P/ywjsStUMopEAikoyJz5Z4OLqzG/YF10rIh8iECxMmdY5eiNH8
   A==;
X-CSE-ConnectionGUID: bR2ajoBlTrag82TUZHL8QA==
X-CSE-MsgGUID: +Wyx6HpCSta1UpApgE6Ihg==
X-IronPort-AV: E=McAfee;i="6800,10657,11454"; a="73688075"
X-IronPort-AV: E=Sophos;i="6.16,209,1744095600"; 
   d="scan'208";a="73688075"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2025 10:16:30 -0700
X-CSE-ConnectionGUID: FJy0HTRgQwOQUcGRKNBd1Q==
X-CSE-MsgGUID: kUg5iJ9+TZO17cpeoK7Jdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,209,1744095600"; 
   d="scan'208";a="145594823"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmviesa008.fm.intel.com with ESMTP; 04 Jun 2025 10:16:28 -0700
From: kan.liang@linux.intel.com
To: peterz@infradead.org,
	mingo@redhat.com,
	namhyung@kernel.org,
	irogers@google.com,
	mark.rutland@arm.com,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: eranian@google.com,
	ctshao@google.com,
	tmricht@linux.ibm.com,
	Kan Liang <kan.liang@linux.intel.com>,
	Leo Yan <leo.yan@arm.com>,
	Aishwarya TCV <aishwarya.tcv@arm.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: [PATCH V3] perf: Fix the throttle error of some clock events
Date: Wed,  4 Jun 2025 10:15:54 -0700
Message-Id: <20250604171554.3909897-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

Both ARM and IBM CI reports RCU stall, which can be reproduced by the
below perf command.
  perf record -a -e cpu-clock -- sleep 2

The issue is introduced by the generic throttle patch set, which
unconditionally invoke the event_stop() when throttle is triggered.

The cpu-clock and task-clock are two special SW events, which rely on
the hrtimer. The throttle is invoked in the hrtimer handler. The
event_stop()->hrtimer_cancel() waits for the handler to finish, which is
a deadlock. Instead of invoking the stop(), the HRTIMER_NORESTART should
be used to stop the timer.

There may be two ways to fix it.
- Introduce a PMU flag to track the case. Avoid the event_stop in
  perf_event_throttle() if the flag is detected.
  It has been implemented in the
  https://lore.kernel.org/lkml/20250528175832.2999139-1-kan.liang@linux.intel.com/
  The new flag was thought to be an overkill for the issue.
- Add a check in the event_stop. Return immediately if the throttle is
  invoked in the hrtimer handler. Rely on the existing HRTIMER_NORESTART
  method to stop the timer.

The latter is implemented here.

Move event->hw.interrupts = MAX_INTERRUPTS before the stop(). It makes
the order the same as perf_event_unthrottle(). Except the patch, no one
checks the hw.interrupts in the stop(). There is no impact from the
order change.

Reported-by: Leo Yan <leo.yan@arm.com>
Reported-by: Aishwarya TCV <aishwarya.tcv@arm.com>
Closes: https://lore.kernel.org/lkml/20250527161656.GJ2566836@e132581.arm.com/
Reported-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Closes: https://lore.kernel.org/lkml/djxlh5fx326gcenwrr52ry3pk4wxmugu4jccdjysza7tlc5fef@ktp4rffawgcw/
Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Closes: https://lore.kernel.org/lkml/8e8f51d8-af64-4d9e-934b-c0ee9f131293@linux.ibm.com/
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

Changes since V2:
- Apply a different way to fix the issue.
  Remove all Tested-by since a different way is applied
- Update the change log
- Add more Reported-by

 kernel/events/core.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index f34c99f8ce8f..46441c23475d 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2656,8 +2656,8 @@ static void perf_event_unthrottle(struct perf_event *event, bool start)
 
 static void perf_event_throttle(struct perf_event *event)
 {
-	event->pmu->stop(event, 0);
 	event->hw.interrupts = MAX_INTERRUPTS;
+	event->pmu->stop(event, 0);
 	if (event == event->group_leader)
 		perf_log_throttle(event, 0);
 }
@@ -11749,7 +11749,12 @@ static void perf_swevent_cancel_hrtimer(struct perf_event *event)
 {
 	struct hw_perf_event *hwc = &event->hw;
 
-	if (is_sampling_event(event)) {
+	/*
+	 * The throttle can be triggered in the hrtimer handler.
+	 * The HRTIMER_NORESTART should be used to stop the timer,
+	 * rather than hrtimer_cancel(). See perf_swevent_hrtimer()
+	 */
+	if (is_sampling_event(event) && (hwc->interrupts != MAX_INTERRUPTS)) {
 		ktime_t remaining = hrtimer_get_remaining(&hwc->hrtimer);
 		local64_set(&hwc->period_left, ktime_to_ns(remaining));
 
-- 
2.38.1

