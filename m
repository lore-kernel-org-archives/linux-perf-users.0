Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 751912ECE86;
	Thu, 14 May 2026 16:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778775703; cv=none; b=SLPQ4qdiTHKa1K/vWtCsKw92GuRC/cfU3k3zka319n9ufFCSzIWNX5MweSfI678tK/hmo5677oQueIV4d0CPMn0KbYPp6BjtcxSuCnq64Jl5E9aKSUW20TAWjmkOqV+HAv9JQBQuuw3crJR4cvDMyCoaPLkwSbx6nE7bN4NF40Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778775703; c=relaxed/simple;
	bh=Xxgk45qwU+WCmfkeGuB4S+yq9+//OSXkQdw5WDMTR/M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hxxWBZGFDgs6AEjj+yxm34h6ZtrIUnxalnRz4GDsNjYrdM9vS49p3dcbr6zZo+dxqA9DKhZR177rk5t8iRrdZxF+GkGwuh7u9wsIN5dmxz1y/05MY78hM/BGwnBXTqKsj0PRm+R9+8GDZaSKfyJbTUpgxafty2EzTgx1GynnvPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=okszwaUc; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="okszwaUc"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 29E8C3541;
	Thu, 14 May 2026 09:21:35 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AF0393F7B4;
	Thu, 14 May 2026 09:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1778775700; bh=Xxgk45qwU+WCmfkeGuB4S+yq9+//OSXkQdw5WDMTR/M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=okszwaUc3T6zgEsGj7+bX8Jd480YMPxwi9w5rDiLLT7NYp6Lr9Ls8WjTKOujLFyGb
	 vrReqkvNA1QWgTzQ6epN1VyYW8byXbl57pu4CBtbLrBZGfjNaqapd8e+dg3di6WcJV
	 LSsOM0otqeepN36nR25D2n+Y+MtAwsYF/oVfh+Xc=
From: Leo Yan <leo.yan@arm.com>
Date: Thu, 14 May 2026 17:21:20 +0100
Subject: [PATCH v2 2/2] perf/core: Ignore overflows while disable is
 pending
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260514-arm_cs_clean_perf_handle-v2-2-cbb29c3b3661@arm.com>
References: <20260514-arm_cs_clean_perf_handle-v2-0-cbb29c3b3661@arm.com>
In-Reply-To: <20260514-arm_cs_clean_perf_handle-v2-0-cbb29c3b3661@arm.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, 
 Sumanth Korikkar <sumanthk@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778775688; l=2541;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=Xxgk45qwU+WCmfkeGuB4S+yq9+//OSXkQdw5WDMTR/M=;
 b=ZwgRkYC3lAPP88th6sRyc1zkSSIvc/9ICW8M0m474ZL2YUsRiue9PE1ZwFwweLH5J4UZGtCWU
 eypqW1hjJywBqNRqlOdrs+drA6CiQJnro7OjDdAIqNn7hpWhZ/MMa6r
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

Commit 18dbcbfabfff ("perf: Fix the POLL_HUP delivery breakage") added a
direct pmu->stop(event, 0) call when the refresh limit reaches zero.

That change was based on a report [1] using SIGIO to receive POLL_HUP.
Since SIGIO is a standard signal, multiple notifications can be
coalesced and userspace may miss a signal even though the perf core
generated. Using a real-time signal avoids that coalescing and shows
that POLL_HUP is delivered reliably without directly stopping the PMU
from the overflow path.

There is still a race to handle. For a high frequency event, another
overflow can arrive after perf_event_disable_inatomic() has queued the
disable irq_work but before that irq_work has run. If overflow
processing continues, pending_kill can be overwritten from POLL_HUP
back to POLL_IN and samples can be recorded after the refresh limit has
been reached.

The direct PMU stop avoids this by stopping the hardware immediately,
but the event still relies on perf_event_disable_inatomic() to complete
the disable state transition. This is redundant that it might inject
unnecessary stop operations in the middle. More importantly, the
throttling mechanism already exists for stopping high frequency
overflows.

Make the overflow path explicitly check pending_disable instead of the
PMU stop. Once disable is pending, skip further overflow processing so
the pending POLL_HUP is preserved and no samples are recorded for an
event that is already waiting to be disabled.

[1] https://lore.kernel.org/lkml/aICYAqM5EQUlTqtX@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com/

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 kernel/events/core.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 7935d5663944ee1cbaf38cf8018c3347635e8d31..0fadb53e5d79cab8cb52a08d7656b0064a77ef55 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -10745,12 +10745,18 @@ static int __perf_event_overflow(struct perf_event *event,
 	 * events
 	 */
 
+	/*
+	 * Disable is pending, skip further overflow processing so the pending
+	 * POLL_HUP is preserved and no samples are recorded beyond the limit.
+	 */
+	if (event->pending_disable)
+		goto out;
+
 	event->pending_kill = POLL_IN;
 	if (events && atomic_dec_and_test(&event->event_limit)) {
 		ret = 1;
 		event->pending_kill = POLL_HUP;
 		perf_event_disable_inatomic(event);
-		event->pmu->stop(event, 0);
 	}
 
 	if (event->attr.sigtrap) {

-- 
2.34.1

