Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D05EB2566EE;
	Fri,  7 Mar 2025 20:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741379061; cv=none; b=kfZUpwVOQb1CG6Xkl/kufOYevQ7NPQR8D1pmVU7N/jbQBSEJuIn45Dde2DJy2KNynnQtnluxA5TCJ1g1sSo1nXkMzmeMXscZEZZBBjkxOUt7exTzK8Kg3yumMHHGwpPk6Gg9yErUHpxuc1noFOFVgVl3dim6Mt2LVEnqWxH4BmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741379061; c=relaxed/simple;
	bh=ALUhcw8bsGBM3q18Yh7w86MVDJIo8B6eJEyv1MY8iC0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OT7pYqWPtVP/LOirJl/xhFUMyWCPovCmD2cdwh/X3cmSkhVrZnJYNkJ9+hV/+nmtlhHzntAahh68X1lL5SvU2xSdowaO2wQXEf1/P76587fSyZ40ZZNlHMeHk97N+hIAby4lRZKwp8hrogjAsz92NAx8OaAMRXmp6XHXRTEnvRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B20631A2D;
	Fri,  7 Mar 2025 12:24:31 -0800 (PST)
Received: from e128066.arm.com (unknown [10.57.40.70])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 453603F5A1;
	Fri,  7 Mar 2025 12:24:15 -0800 (PST)
From: mark.barnett@arm.com
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	irogers@google.com
Cc: ben.gainey@arm.com,
	deepak.surti@arm.com,
	ak@linux.intel.com,
	will@kernel.org,
	james.clark@arm.com,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	adrian.hunter@intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Mark Barnett <mark.barnett@arm.com>
Subject: [PATCH v3 3/5] perf: Allow adding fixed random jitter to the alternate sampling period
Date: Fri,  7 Mar 2025 20:22:45 +0000
Message-Id: <20250307202247.648633-4-mark.barnett@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250307202247.648633-1-mark.barnett@arm.com>
References: <20250307202247.648633-1-mark.barnett@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ben Gainey <ben.gainey@arm.com>

This change modifies the core perf overflow handler, adding some small
random jitter to each sample period whenever an event switches between the
two alternate sample periods. A new flag is added to perf_event_attr to
opt into this behaviour.

This change follows the discussion in [1], where it is recognized that it
may be possible for certain patterns of execution to end up with biased
results.

[1] https://lore.kernel.org/linux-perf-users/Zc24eLqZycmIg3d2@tassilo/

Signed-off-by: Ben Gainey <ben.gainey@arm.com>
Signed-off-by: Mark Barnett <mark.barnett@arm.com>
---
 include/uapi/linux/perf_event.h | 7 ++++++-
 kernel/events/core.c            | 9 ++++++++-
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index 499a8673df8e..c0076ce8f80a 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -461,7 +461,12 @@ struct perf_event_attr {
 				inherit_thread :  1, /* children only inherit if cloned with CLONE_THREAD */
 				remove_on_exec :  1, /* event is removed from task on exec */
 				sigtrap        :  1, /* send synchronous SIGTRAP on event */
-				__reserved_1   : 26;
+				/*
+				 * Add a limited amount of jitter on each alternate period, where
+				 * the jitter is between [0, (2<<jitter_alt_period) - 1]
+				 */
+				jitter_alt_period : 3,
+				__reserved_1   : 23;
 
 	union {
 		__u32		wakeup_events;	  /* wakeup every n events */
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 7ec8ec6ba7ef..be271e21cd06 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -15,6 +15,7 @@
 #include <linux/idr.h>
 #include <linux/file.h>
 #include <linux/poll.h>
+#include <linux/random.h>
 #include <linux/slab.h>
 #include <linux/hash.h>
 #include <linux/tick.h>
@@ -9922,7 +9923,10 @@ static int __perf_event_overflow(struct perf_event *event,
 	if (event->attr.alt_sample_period) {
 		bool using_alt = hwc->using_alt_sample_period;
 		u64 sample_period = (using_alt ? event->attr.sample_period
-					       : event->attr.alt_sample_period);
+					       : event->attr.alt_sample_period)
+				  + (event->attr.jitter_alt_period
+					? get_random_u32_below(2 << event->attr.jitter_alt_period)
+					: 0);
 
 		hwc->sample_period = sample_period;
 		hwc->using_alt_sample_period = !using_alt;
@@ -12849,6 +12853,9 @@ SYSCALL_DEFINE5(perf_event_open,
 		}
 	}
 
+	if (attr.jitter_alt_period && !attr.alt_sample_period)
+		return -EINVAL;
+
 	/* Only privileged users can get physical addresses */
 	if ((attr.sample_type & PERF_SAMPLE_PHYS_ADDR)) {
 		err = perf_allow_kernel(&attr);
-- 
2.43.0

