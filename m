Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8414BDDAB;
	Mon,  2 Jun 2025 18:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748889756; cv=none; b=KzEO/ODompL0g1DiPqf9XWii96R1AHugjePP5SlY1nedgopsyGEUzaQaXxmXNuSDxbKsuFENsJ01N7Izpocj/kFLW6Ju8wmmtwCsCcaXYCKdkdyS6MMaKAyIELpWJXSFTN5ASxtXMvU7wxahqo+V4i3xUu3v1aHvL5CipDxzAl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748889756; c=relaxed/simple;
	bh=JXUGtBxMmZ3qxADNC8z55VEIcDThXMmxnX/W1hjZciU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GN5R64Uba+f0/qHU6NWBp6QkPvU1upfZ7lbwSj/ku1PeKb+XnuaKP55s1Hk7VNonKUDaSd+2XVocH2cWD9/0Vgv1ndB3TWvmt/E2/xwLZrt27DgHzU/1SjFmhOy7cK2ev7cwysLzhDPVv1nMAY8Hgo/zSBDCO43AG1teMux94TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 04D801424;
	Mon,  2 Jun 2025 11:42:17 -0700 (PDT)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3B0073F59E;
	Mon,  2 Jun 2025 11:42:31 -0700 (PDT)
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	mingo@kernel.org,
	acme@kernel.org,
	namhyung@kernel.org,
	leo.yan@arm.com,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yeoreum Yun <yeoreum.yun@arm.com>,
	David Wang <00107082@163.com>
Subject: [PATCH 1/1] perf/core: fix dangling cgroup pointer in cpuctx
Date: Mon,  2 Jun 2025 19:40:49 +0100
Message-Id: <20250602184049.4010919-1-yeoreum.yun@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit a3c3c6667("perf/core: Fix child_total_time_enabled accounting bug at task exit")
changes the event->state update before list_del_event().
This change prevents calling perf_cgroup_event_disable() as a result,
cpuctx->cgrp can't be cleared properly and point to dangling point of cgroup.

Because of this problem, some machin meets the below panic[0]:

863.881960] sysved_call_function_sing le+0x4c/0xc0
863.881301] asm_sysvec_call_function_single+0x16/0x20
869.881344] RIP: 0633:0x7f9alcea3367
663.681373] Code: 00 66 99 b8 ff ff ff ff c3 66 ....
863.881524] RSP: 002b:00007fffa526fcf8 EFLAGS: 00000246
869.881567] RAX: 0000562060c962d0 RBX: 0000000000000002 RCX: 00007f9a1cff1c60
863.881625] RDX: 00007f9a0c000030 RSI: 00007f9alcff1c60 RDI: 00007f9a1ca91c20
863.081682] RBP: 0000000000000001 R08: 0000000000000000 R09: 00007f9a1d6217a0
869.881740] R10: 00007f9alca91c10 R11: 0000000000000246 R12: 00007f9a1d70c020
869.881798] R13: 00007fffa5270030 R14: 00007fffa526fd00 R15: 0000000000000000
863.881860] </TASK>
863.881876) Modules linked in: snd_seq_dummy (E) snd_hrtimer (E)...
...
863.887142] button (E)
863.912127] CR2: ffffe4afcc079650
863.914593] --- [ end trace 0000000000000000 1--
864.042750] RIP: 0010:ctx_sched_out+0x1ce/0x210
864.045214] Code: 89 c6 4c 8b b9 de 00 00 00 48 ...
864.050343] RSP: 0000:ffffaa4ec0f3fe60 EFLAGS: 00010086
864.052929] RAX: 0000000000000002 RBX: ffff8e8eeed2a580 RCX: ffff8e8bded9bf00
864.055518] RDX: 000000c92340b051 RSI: 000000c92340b051 RDI: ffff
864.058093] RBP: 0000000000000000 R08: 0000000000000002 R09: 00
864.060654] R10: 0000000000000000 R11: 0000000000000000 R12: 000
864.063183] R13: ffff8e8eeed2a580 R14: 0000000000000007 R15: ffffe4afcc079650
864.065729] FS: 00007f9a1ca91940 (0000) GS:ffff8e8f6b1c3000(0000) knIGS:0000000000000000
864.068312] CS: 0010 DS: 0000 ES: 0000 CRO: 0000000080050033
864.070898] CR2: ffffe4afcc079650 CR3: 00000001136d8000 CR4: 0000000000350ef0
864.673523] Kernel panic - not syncing: Fatal exception in interrupt
864.076410] Kernel Offset: 0xc00000 from 0xffffffff81000000 (relocation range: 0xff
864.205401] --- [ end Kernel panic - not syncing: Fatal exception in interrupt ]---

To address this call the perf_cgroup_event_disable() properly before
list_del_event() in __perf_remove_from_context().

Link: https://lore.kernel.org/all/aD2TspKH%2F7yvfYoO@e129823.arm.com/ [0]
Fixes: a3c3c6667("perf/core: Fix child_total_time_enabled accounting bug at task exit")
Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
Tested-by: David Wang <00107082@163.com>
---
 kernel/events/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index f34c99f8ce8f..909b9d5a65c1 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2498,6 +2498,10 @@ __perf_remove_from_context(struct perf_event *event,
 		state = PERF_EVENT_STATE_DEAD;
 	}
 	event_sched_out(event, ctx);
+
+	if (event->state > PERF_EVENT_STATE_OFF)
+		perf_cgroup_event_disable(event, ctx);
+
 	perf_event_set_state(event, min(event->state, state));
 
 	if (flags & DETACH_GROUP)
-- 
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}

