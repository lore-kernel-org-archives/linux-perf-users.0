Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A660C4B3364;
	Tue, 15 Sep 2026 15:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789487365; cv=none; b=TRQ/uCYDHGWS+6Tju3xGFUQ9ibOlPCG2Ssrv7Zus6bqI9on1rYBRtteG2QSNgRZOanA5Aodj/8R3wGmodxQyb892F/DCXSaYBL5bac67QDpCrE+cAgVGe9nxR6ZXrvbSRy2rXAuUOU3tlTtagrp0n5p8Hv2WXpTYAKO/mll//wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789487365; c=relaxed/simple;
	bh=e9fTX9+bNoGVkOFH4Qc5xPv659tjBz3BDwn9aDSMUtw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QGmfVPnAvDXd3FLCZOt9NBIhS/ltyi6V45NYiED5FG56DTjFjS6mkZJ/ZQRLx/GMEtopuVoSHfqdXXVth4KAjZtQrcgvO92WVAPjwCgcGMF4FEg1YNZZVfBUjFCOboQYUWqK4tI5gMGdDbDhqfS0Oeb9TpC5E5OgIyKfFF/Fcy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=OcpG6wCu; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="OcpG6wCu"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9562E1BF3;
	Tue, 15 Sep 2026 08:49:18 -0700 (PDT)
Received: from e132581.arm.com (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CA7D43F882;
	Tue, 15 Sep 2026 08:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789487362; bh=e9fTX9+bNoGVkOFH4Qc5xPv659tjBz3BDwn9aDSMUtw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OcpG6wCuLJZbJyoRHTAmFgIhDIqBD427Ejsgpg1A/PC01RCeX1KEH+dva5tye+j3J
	 XpczWbIXuuBXKCvtgua8QL/HvBW7dc/jbKnvcCvBwFGzRv6EFyx9mbIws9nH9VERl+
	 tf3l3wEQyP2CYcPmbGHQfJ9BVp6CdEpkblYnp7Vw=
From: Leo Yan <leo.yan@arm.com>
Date: Tue, 15 Sep 2026 16:48:53 +0100
Subject: [PATCH 07/25] coresight: perf: Validate the live context through
 its path
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-arm_cs_support_aux_sample-v1-7-35cf6f297d20@arm.com>
References: <20260915-arm_cs_support_aux_sample-v1-0-35cf6f297d20@arm.com>
In-Reply-To: <20260915-arm_cs_support_aux_sample-v1-0-35cf6f297d20@arm.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@arm.com>, 
 Anshuman Khandual <anshuman.khandual@arm.com>, 
 Yeoreum Yun <yeoreum.yun@arm.com>, Jonathan Corbet <corbet@lwn.net>, 
 Suyash Mahar <smahar@meta.com>, Amir Ayupov <aaupov@fb.com>
Cc: Ingo Molnar <mingo@kernel.org>, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, coresight@lists.linaro.org, 
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
 Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789487340; l=2724;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=e9fTX9+bNoGVkOFH4Qc5xPv659tjBz3BDwn9aDSMUtw=;
 b=lAdf8oZUCVNhZymCOH1NZ4X3CSaEiL4HcJYo0fhzXenTJ7he1VwNMBIwQjGySYJvN/gS0w8Cv
 cpstf1Hx1ohDR7sa43msEv1h/iZY9/3BfcDYV2SEEmv71gVGkNuVTvL
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

etm_event_get_ctxt_path() returns a path only when the per-CPU
context has published event data and that data contains a path for the
current CPU. Perf PMU callbacks run on the same CPU in atomic context,
and only the normal stop clears the event data. A returned path therefore
establishes that the pause and stop callbacks have a live ETM context.

The AUX handle has a separate lifetime. It can be absent after an AUX
transaction could not be restarted while the CoreSight path still needs
to be paused or disabled. The handle is acquired for the callback event
before event data is published, and another ETM event cannot replace it
while the published context remains live. Thus any active handle belongs
to that context, and etm_event_update_buffer() uses perf_get_aux() to
determine whether it remains valid.

Remove the redundant comparisons of the handle with the event and event
data, together with the redundant event_data check. Use the path to
validate the ETM context lifetime and perf_get_aux() to validate the AUX
handle lifetime.

Assisted-by: Codex:gpt-6
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 drivers/hwtracing/coresight/coresight-etm-perf.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index afd22fd4a851e600ab69fd5b6883e6f8518b2cab..c7454da5c881c4a8eea5cc77902c9113c297096e 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -698,9 +698,6 @@ static void etm_event_pause(struct coresight_path *path,
 	if (coresight_is_percpu_sink(sink))
 		return;
 
-	if (WARN_ON_ONCE(handle->event != event))
-		return;
-
 	event_data = READ_ONCE(ctxt->event_data);
 	etm_event_update_buffer(handle, event_data, sink, PERF_EF_UPDATE);
 
@@ -728,14 +725,6 @@ static void etm_event_stop(struct perf_event *event, int mode)
 		return;
 	}
 
-	/*
-	 * If we still have access to the event_data via handle,
-	 * confirm that we haven't messed up the tracking.
-	 */
-	if (handle->event &&
-	    WARN_ON(perf_get_aux(handle) != ctxt->event_data))
-		return;
-
 	event_data = READ_ONCE(ctxt->event_data);
 	/* Clear the event_data as this ETM is stopping the trace. */
 	WRITE_ONCE(ctxt->event_data, NULL);
@@ -743,10 +732,6 @@ static void etm_event_stop(struct perf_event *event, int mode)
 	if (event->hw.state == PERF_HES_STOPPED)
 		return;
 
-	/* We must have a valid event_data for a running event */
-	if (WARN_ON(!event_data))
-		return;
-
 	source = coresight_get_source(path);
 	sink = coresight_get_sink(path);
 	if (!source || !sink)

-- 
2.34.1

