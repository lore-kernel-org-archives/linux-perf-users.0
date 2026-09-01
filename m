Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9469E483811;
	Tue,  1 Sep 2026 16:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788280595; cv=none; b=tba2FLOHegdckxrJvLugDzz8DgPwzndwFCbw+r0m/OZaMvdbbeYzOBlMPEn/D+NnD4NQRIHmdwkEC6sqyPcETJ9dybEgZAWentHhzMoxs0zU1nn9M7yP3qftvlbnuLWoB9VtnwXHIxw+sO7ZFcYHf1oeGEAelnGQfqyMmc52EKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788280595; c=relaxed/simple;
	bh=plbS3HrWoctD/KTUTIyQWYwlq1nvdgjH+NpGvIk01I0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dOp5ePJMKsFgn/nG3M8OHuK+x/6cV59bbnhl1+8wjstVKNDKB8xojVqf6Oc566hsFPPO7lcxgbwfQRA7YgH7fXb1ESzCJWAKwIODm5edSUI5z3Tp1XYh+1V04K3/zuimiEQBZ11DqYQzYbT15Hxa6IzRZwI5QmpxmvvaUG9QkSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Rvw1F4Jq; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Rvw1F4Jq"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 479931756;
	Tue,  1 Sep 2026 09:36:29 -0700 (PDT)
Received: from e132581.arm.com (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 436883F85F;
	Tue,  1 Sep 2026 09:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1788280593; bh=plbS3HrWoctD/KTUTIyQWYwlq1nvdgjH+NpGvIk01I0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Rvw1F4JqFT9cmvfKZRxPyC/CyJi67KrhZbPdsaRElG7OG4W1iSsG6YHGXDbveaNBr
	 GXDQuv2tEcSYrw0/EVsUH2EGMXpkB1+PETo0WQuEVIL1zRNhrics/94/sKwvuHtGPC
	 taC87RhVxDsDn+VLt0PZrzeKrPkXQAa7JTnRYDP8=
From: Leo Yan <leo.yan@arm.com>
Date: Tue, 01 Sep 2026 17:36:17 +0100
Subject: [PATCH 3/3] coresight: perf: Suppress ITRACE start records
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-perf_suppress_itrace_start_records-v1-3-c4fbc6860859@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788280584; l=1225;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=plbS3HrWoctD/KTUTIyQWYwlq1nvdgjH+NpGvIk01I0=;
 b=M2xhsj9QnStXjg3/CiMvt7fs5r0R/XWoUkx20EZFiAisrr2dCZzjJbYY5Mj6SIxtIj7qKyvHO
 VipAxQad+BbDz1TkoYFA1EA67dG2VjzHfDd/uuk+eI5PPdPX1L9B0jf
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

PERF_RECORD_ITRACE_START establishes the initial thread context at the
beginning of a trace. Afterwards, decoders track the thread context using
context packets.

Call perf_event_itrace_started() after successfully starting the event
to prevent perf core from emitting redundant PERF_RECORD_ITRACE_START
records when the event is scheduled in again.

When per-thread mode traces multiple child threads, tooling should
enable context ID tracing instead to identify each thread.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 drivers/hwtracing/coresight/coresight-etm-perf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index 09b21a711a8764ea429d712890265c84648e889e..80502e8b084074980000a039e73e1a164940011d 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -613,6 +613,8 @@ static void etm_event_start(struct perf_event *event, int flags)
 		perf_report_aux_output_id(event, hw_id);
 	}
 
+	perf_event_itrace_started(event);
+
 out:
 	/* Tell the perf core the event is alive */
 	event->hw.state = 0;

-- 
2.34.1

