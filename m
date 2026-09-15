Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 806FC4BD0FD;
	Tue, 15 Sep 2026 15:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789487383; cv=none; b=bZSQUPfCXpPnSugt6ox9R+wIesQOl7SW+D8PDEMEwRHYJazoE1nBqWlYskS68gx3AUFP9ufizJ+fvMojOXTEfGgmHNcp6tyjdAaGzhx0jSDn7/JxfZx5WcR3dmbUJ1XaodhfK1Xly5SjCTvwSwuV7YI00Y2OfWKB+SWvD0/KgNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789487383; c=relaxed/simple;
	bh=ZLhP9+hk4aabaXSGT54lI6NuOvSPZUJCkdIwDLOtAu4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d0hFTr+ahiZOtl5rkqpU7S6K+bzcfoQI7wRcBNiwid6/XFb+N1mtI5prulLBnPqiE3nDyyKYrzdbMKSraifrqqi32goCYmWoTciZ4u9/cMLYMMg5b3qbvBgHqfBhrX1pu1ImZxMZy+FStdXs41R5io9aNb1bR7Q8W0uLSYXxswQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=BdAXaQPh; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="BdAXaQPh"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2E9DF1570;
	Tue, 15 Sep 2026 08:49:37 -0700 (PDT)
Received: from e132581.arm.com (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 640363F882;
	Tue, 15 Sep 2026 08:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789487380; bh=ZLhP9+hk4aabaXSGT54lI6NuOvSPZUJCkdIwDLOtAu4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=BdAXaQPhr83OQa7dCtrINo7V0Ik022DcCN3ePCCAPmH0rPYM2/ka84ZuMHgCI0Nj7
	 79/IvJE6eiWpBtG7rAU3MfDfD2yRisiHh3S6xevjvez5+zw3oui0mqnqIhhWqQNkcs
	 pzR8eFyE9xwoyT+/G2Kry12YSH7rPk0hUdw1k5mQ=
From: Leo Yan <leo.yan@arm.com>
Date: Tue, 15 Sep 2026 16:49:00 +0100
Subject: [PATCH 14/25] coresight: perf: Look up the trace path in
 etm_event_pause()
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-arm_cs_support_aux_sample-v1-14-35cf6f297d20@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789487340; l=2117;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=ZLhP9+hk4aabaXSGT54lI6NuOvSPZUJCkdIwDLOtAu4=;
 b=xElk10YnXyUhppvLhUxoiFU+LW5Fv+8kQIwvgFAKzhUuLDJByQtapb0TsuCyCt6DtEpgYaPHC
 SD9k9LTKFx+B2aE3gtHt8F8WAVaE/zrwGnWOwU4xe+wyxQRCPwyqehr
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

Have etm_event_pause() retrieve the active path from the event context
instead of passing the path from etm_event_stop(). Move the stop path
lookup after the pause dispatch so each operation resolves its own path.

This prepares etm_event_stop() to coordinate hardware access before
looking up the active context.

Assisted-by: Codex:gpt-6
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 drivers/hwtracing/coresight/coresight-etm-perf.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index f66c99b26e1862ab04105704276c901b21728207..8f803914e9abfb18e080ff68371ad8b32042f180 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -694,10 +694,10 @@ static void etm_event_update_buffer(struct perf_event *event,
 	perf_aux_output_end(handle, 0);
 }
 
-static void etm_event_pause(struct coresight_path *path,
-			    struct perf_event *event,
+static void etm_event_pause(struct perf_event *event,
 			    struct etm_ctxt *ctxt)
 {
+	struct coresight_path *path = etm_event_get_ctxt_path(ctxt);
 	struct perf_output_handle *handle = &ctxt->handle;
 	struct coresight_device *source, *sink;
 	struct etm_event_data *event_data;
@@ -735,7 +735,7 @@ static void etm_event_stop(struct perf_event *event, int mode)
 	struct coresight_device *source, *sink;
 	struct etm_ctxt *ctxt = this_cpu_ptr(&etm_ctxt);
 	struct perf_output_handle *handle = &ctxt->handle;
-	struct coresight_path *path = etm_event_get_ctxt_path(ctxt);
+	struct coresight_path *path;
 	struct hw_perf_event *hwc = &event->hw;
 	struct etm_event_data *event_data;
 
@@ -744,7 +744,9 @@ static void etm_event_stop(struct perf_event *event, int mode)
 		return;
 
 	if (mode & PERF_EF_PAUSE)
-		return etm_event_pause(path, event, ctxt);
+		return etm_event_pause(event, ctxt);
+
+	path = etm_event_get_ctxt_path(ctxt);
 
 	/*
 	 * With no path enabled, there is no hardware to stop or trace data

-- 
2.34.1

