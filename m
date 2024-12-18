Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D61F2158538;
	Wed, 18 Dec 2024 08:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734511623; cv=none; b=f3OZghyMwYwOP2gMHkchFsLJaW+6nIZteZB7ARYXTpibhvCR1vMkPSDAXd4DDM8oh+2i3uq+FQpU153PJjjWnLOHzhEVTnsaj533mVst0JHRxALuRbTY2ufSsC5U35ErMhMKDFrsR54h8ojG9OcOlll4g3850E6xLgQAdTWUXWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734511623; c=relaxed/simple;
	bh=J1y4LG33rWLSVnLlMWXOE/fKy5e82QMEZ4MGl0DmJ6o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SeTDpLjl2zQb/VuxgpomVBriV3CUkK4hX0MAzWZIlCHqb4QCuYKg95H1O6dbTALedjzo3nzRcYXxXog0K2xGk67hHCRDzga94fig/4oPRno1X8R4j6KH189cuK4zxCa3i2tJlBPryo+FNS8x8qhwFkwZ/UcCe4bF6iDD99bsmJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 452DFFEC;
	Wed, 18 Dec 2024 00:47:29 -0800 (PST)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E92C33F720;
	Wed, 18 Dec 2024 00:46:58 -0800 (PST)
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	amhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	james.clark@linaro.org
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nd@arm.com,
	Yeoreum Yun <yeoreum.yun@arm.com>
Subject: [PATCH 1/1] events/core: fix error run/enable ratio display
Date: Wed, 18 Dec 2024 08:46:56 +0000
Message-Id: <20241218084656.609764-1-yeoreum.yun@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

when runs below command (with core pmu) sometime perf prints error
ratio for each perf.

sudo ./perf stat -vvv -e armv8_pmuv3_0/event=0x08/ -e armv8_pmuv3_1/event=0x08/ -- stress-ng --pthread=2 -t 2s
...
armv8_pmuv3_0/event=0x08/: -1: 1081702126 2289429840 2174835740
armv8_pmuv3_1/event=0x08/: -1: 794080238 1950025700 847648440
armv8_pmuv3_0/event=0x08/: 1138698008 2289429840 2174835740
armv8_pmuv3_1/event=0x08/: 1826791390 1950025700 847648440

 Performance counter stats for 'stress-ng --pthread=2 -t 2s':

     1,138,698,008      armv8_pmuv3_0/event=0x08/                                               (94.99%)
     1,826,791,390      armv8_pmuv3_1/event=0x08/                                               (43.47%)

This happens because of missing total_enable_time of inactivate event.
it's enabled time doesn't update at the event_sched_out() because state
isn't PERF_EVENT_STATE_ACTIVE but PERF_EVENT_STATE_INACTIVE.

For example, Suppose there're two events:
    e0: with pmu0 which supports only cpu0
    e1: with pmu1 which supports only cpu1.
then

               CPU0                  CPU1                     CPU0
          |  in | out |       | in | out     |       | in      | out (exit)   |
------------------------------------------------------------------------------
ctx->time |  0  | t1  |       | t1 | t1 + t2 |       | t1 + t2 | t1 + t2 + t3 |
------------------------------------------------------------------------------
e0->ena   |  0  | t1  |       | t1 | t1      |       | t1 + t2 | t1 + t2 + t3 |
------------------------------------------------------------------------------
e0->run   |  0  | t1  |       | t1 | t1 + t2 |       | t1 + t2 | t1 + t3      |
------------------------------------------------------------------------------
e1->ena   |  0  | 0   |       | t1 | t1 + t2 |       | t1 + t2 | t1 + t2      |
------------------------------------------------------------------------------
e1->run   |  0  | 0   |       | 0  | t2      |       | t1 + t2 | t2           |
------------------------------------------------------------------------------

at the CPU0, state of e1 is PERF_EVENT_STATE_INACTIVE since it doesn't
support on CPU0. So when event_sched_out() it failed to update its
total_enable_time and it makes error print of run/ena ratio.

To address this, update total_enable_time in event_sched_out() when event state
is PERF_EVENT_STATE_INACTIVE.

After this patch, this problem is gone like:

sudo ./perf stat -vvv -e armv8_pmuv3_0/event=0x08/ -e armv8_pmuv3_1/event=0x08/ -- stress-ng --pthread=2 -t 2s
...
armv8_pmuv3_0/event=0x08/: -1: 10484528214 32157963940 21898169000
armv8_pmuv3_1/event=0x08/: -1: 7155819373 32157963940 10259794940
armv8_pmuv3_0/event=0x08/: 15396770398 32157963940 21898169000
armv8_pmuv3_1/event=0x08/: 22428964974 32157963940 10259794940

 Performance counter stats for 'stress-ng --pthread=2 -t 10s':

    15,396,770,398      armv8_pmuv3_0/event=0x08/                                               (68.10%)
    22,428,964,974      armv8_pmuv3_1/event=0x08/                                               (31.90%)

Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
---
 kernel/events/core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 065f9188b44a..f40cca02636d 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2311,6 +2311,11 @@ event_sched_out(struct perf_event *event, struct perf_event_context *ctx)
 	WARN_ON_ONCE(event->ctx != ctx);
 	lockdep_assert_held(&ctx->lock);
 
+	if (event->state == PERF_EVENT_STATE_INACTIVE) {
+		perf_event_update_time(event);
+		return ;
+	}
+
 	if (event->state != PERF_EVENT_STATE_ACTIVE)
 		return;
 
-- 
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}

