Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B1A54B489D;
	Tue, 15 Sep 2026 15:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789487368; cv=none; b=KCEG13O9rqw3MWi4I6T15x39JMuiiByjfX42tggqHiY8nKeO2h3X6l8o6/FXjp1vUqlhZjR6HMDakTd+pKKWGwj25oaz+WjgnWD/1A4jJZMJHn74zj6rQaYPRwRJfceKdjFBqJKXP+1tnXA0u2BdGAXYUr5ihRCmbkQQf15ZYhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789487368; c=relaxed/simple;
	bh=rhjgu0y5asKDIU5Zxii2LNz8ZubPzlbgrZL/U/eqBEo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D1AdwLCfXTG52UJzAJVAJSDv+G0sBDIIV7SXJS4S9MMFulMWDMmUrjwvtZHsc06aQWoP1dXwUnkjDkQudxT1NL5GIAL+GGh86Zi2mNljtZJJq+NRN1E7vZYfH+6QIwSgUUX9fsuSArNyXL6WyaSLifQi00lXnrnMpc4MMBDZlRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=OduQGEJN; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="OduQGEJN"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4087B1570;
	Tue, 15 Sep 2026 08:49:21 -0700 (PDT)
Received: from e132581.arm.com (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 768E73F882;
	Tue, 15 Sep 2026 08:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789487364; bh=rhjgu0y5asKDIU5Zxii2LNz8ZubPzlbgrZL/U/eqBEo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OduQGEJNFa8tyVkY5wFKQp9SAx8Qfw3cARQ5l45VPsp2hmU7PvqLSkxDxYqHM4WoG
	 cSwrs5fcW3UNzwzdrU5euR6ktpIPxAM/s9PHOQZBl3Drbh6OsRz1lY39buhYttDxAU
	 P4YG5BQJzqOspa73JAiuAqy3+FPeRe7InIEsJDTA=
From: Leo Yan <leo.yan@arm.com>
Date: Tue, 15 Sep 2026 16:48:54 +0100
Subject: [PATCH 08/25] coresight: perf: Validate context before resuming
 trace
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-arm_cs_support_aux_sample-v1-8-35cf6f297d20@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789487340; l=1830;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=rhjgu0y5asKDIU5Zxii2LNz8ZubPzlbgrZL/U/eqBEo=;
 b=fCuwxc40dlV8yQA2S+XPYdRX5eTJanVhEXDcrqONj0/qW1wFYzGh+WPkluTb9yhSVawIdmIsO
 MEXwFEPbueCDE7JwXOlx88FVwMQHb+mO4Dw2ie6nkRPTXQKmqQc+7Yd
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

An AUX pause ends the current AUX output before trying to begin a new
one. That new beginning can fail, leaving the CoreSight path published
after the perf handle has become inactive. AUX resume may also overlap
a normal stop which clears the per-CPU context.

Pass the per-CPU ETM context to etm_event_resume() and centralize both
lifetime checks there. Use perf_get_aux() to confirm that the AUX output
handle is active and path to confirm that the context is still live.
Resume the source only when both checks succeed.

Assisted-by: Codex:gpt-6
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 drivers/hwtracing/coresight/coresight-etm-perf.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index c7454da5c881c4a8eea5cc77902c9113c297096e..e3c9d3cf84c502f357a430bc3bfa854a776618f1 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -517,11 +517,17 @@ static void *etm_setup_aux(struct perf_event *event, void **pages,
 	goto out;
 }
 
-static int etm_event_resume(struct coresight_path *path)
+static int etm_event_resume(struct etm_ctxt *ctxt)
 {
+	struct perf_output_handle *handle = &ctxt->handle;
 	struct coresight_device *source;
+	struct coresight_path *path;
 	int ret;
 
+	if (!perf_get_aux(handle))
+		return 0;
+
+	path = etm_event_get_ctxt_path(ctxt);
 	if (!path)
 		return 0;
 
@@ -547,8 +553,7 @@ static void etm_event_start(struct perf_event *event, int flags)
 	u64 hw_id;
 
 	if (flags & PERF_EF_RESUME) {
-		path = etm_event_get_ctxt_path(ctxt);
-		if (etm_event_resume(path) < 0)
+		if (etm_event_resume(ctxt) < 0)
 			goto fail;
 		return;
 	}

-- 
2.34.1

