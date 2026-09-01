Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97802481AAE;
	Tue,  1 Sep 2026 16:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788280593; cv=none; b=aTLa+6OaJ1Hag6KlUYhSQL7AlzIWzDSZl0NkB+x6YXHQ6jOZmuEVPMP0pOcncP7Wy19pz8PBTiXdwgs+c6hTpuyyTRqQZdsGmCBzmJyOwYH63pu2pM1avpxBIQimyj5/0JET8Ul88nyFH9RZZfryAyQFmT9flRD+T26Rx38dEns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788280593; c=relaxed/simple;
	bh=xJBbbZZo8b7Loc2wr9E8P5lEJOTEHAM+aFvWr+qdXhE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uE1qH7BOmiCmI8EOPyyUii9sxKzgMv3GeksZykFW5WaiqMlwMDWsTqkDF1Q47CkXllvhLK951/P1orfwuDRIhbyeMJo325abr/0RcqR7GQ+FjTer/hNuP+iTydZs+YQLQVYSZ+7nI8fvO7EKhnH+iKB36yX+V1mCVqRtdCCH2MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=EM8CxYAW; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="EM8CxYAW"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3B4871CDD;
	Tue,  1 Sep 2026 09:36:27 -0700 (PDT)
Received: from e132581.arm.com (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 33A033F85F;
	Tue,  1 Sep 2026 09:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1788280591; bh=xJBbbZZo8b7Loc2wr9E8P5lEJOTEHAM+aFvWr+qdXhE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=EM8CxYAWvFTLZFh0H/z6mpdd9NrmrQRe8QHmNNgz+t0RU4prsoZ6+n1K08iRTbkV3
	 F426Y2ZUqI71KqHVvGA535Y4anINcoy0PD0eimS6JVnetR3DyG/bJTM4nSv/qn5PpY
	 1bA3QrIuHlJJubkZlgZVoq/mS/wbF+15aBRp+LPc=
From: Leo Yan <leo.yan@arm.com>
Date: Tue, 01 Sep 2026 17:36:16 +0100
Subject: [PATCH 2/3] perf: arm_spe: Suppress redundant ITRACE start records
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-perf_suppress_itrace_start_records-v1-2-c4fbc6860859@arm.com>
References: <20260901-perf_suppress_itrace_start_records-v1-0-c4fbc6860859@arm.com>
In-Reply-To: <20260901-perf_suppress_itrace_start_records-v1-0-c4fbc6860859@arm.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Will Deacon <will@kernel.org>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@arm.com>, 
 Tamas Petz <tamas.petz@arm.com>, Tamas Zsoldos <tamas.zsoldos@arm.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org, 
 Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788280584; l=957;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=xJBbbZZo8b7Loc2wr9E8P5lEJOTEHAM+aFvWr+qdXhE=;
 b=U8GkIQ8Sa/aUuleZ6Wj4REIryoMRqoWn5U6OhXZpm1juwlPzaVL9WmQR05GKeh/IO7oVIrb/+
 QY4IxQxArNoAQ9NmbMz1/OF8YDj53W+3YjRXtXjfuPXpgnG5kAy8HoE
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

PERF_RECORD_ITRACE_START establishes the initial thread context at the
beginning of a trace. Afterwards, decoders track the thread context using
context packets or recorded sched_switch events.

Call perf_event_itrace_started() when event starts to prevent perf core
from emitting redundant PERF_RECORD_ITRACE_START records on later
schedule-ins.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 drivers/perf/arm_spe_pmu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
index b70f3fedf0282baba1395ce1116272ec5f961ea8..40314ef8b731e1272e02783a9e6dc7d92ec47139 100644
--- a/drivers/perf/arm_spe_pmu.c
+++ b/drivers/perf/arm_spe_pmu.c
@@ -890,6 +890,8 @@ static void arm_spe_pmu_start(struct perf_event *event, int flags)
 		return;
 	}
 
+	perf_event_itrace_started(event);
+
 	reg = arm_spe_event_to_pmsfcr(event);
 	write_sysreg_s(reg, SYS_PMSFCR_EL1);
 

-- 
2.34.1

