Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A20A78F2A;
	Mon,  6 Jan 2025 12:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736164964; cv=none; b=tvjBLidTsfYkqfzUPmEgYU4baWlGy6YG6kmz6nRiGemudXeRnPzkyyNZAZ4FLlfE0TXQoRdXlR5aquAqojQZe3aAKy3D91iDuEonoOMOMz3zq1Ifhicuh/fgzGmIDV+Sp4SWM7mkMsg3fbO0QbnzKNvUsVl9xkkNKpMu+G5SVeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736164964; c=relaxed/simple;
	bh=jnkbXDfQqvJxjwBIAz/OpbtW0H5tE9BDBYD+6iKKu48=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eEMX/w58s100YisCBj+ci4gKK5+1uFuRlkYM5rnCUoAC24AX47sXAV8yt2iTeAFhA1InLn/84zbusYaR6pARfow5ttLbp4VPMTPMS9ut2wn6q6PQiloPu7/V6I9n9/9/ttTgS9o0iw6XT3+XecauTe6iwr7aJBvIt3meVrDFE3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AE99122BE;
	Mon,  6 Jan 2025 04:03:08 -0800 (PST)
Received: from e128066.arm.com (unknown [10.57.93.133])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3B4C23F673;
	Mon,  6 Jan 2025 04:02:36 -0800 (PST)
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
Subject: [PATCH v2 2/5] perf: Allow adding fixed random jitter to the alternate sampling period
Date: Mon,  6 Jan 2025 12:01:53 +0000
Message-Id: <20250106120156.227273-3-mark.barnett@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250106120156.227273-1-mark.barnett@arm.com>
References: <20250106120156.227273-1-mark.barnett@arm.com>
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
index 7e339d12363a..c5480965df32 100644
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
@@ -9878,7 +9879,10 @@ static int __perf_event_overflow(struct perf_event *event,
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
@@ -12803,6 +12807,9 @@ SYSCALL_DEFINE5(perf_event_open,
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

