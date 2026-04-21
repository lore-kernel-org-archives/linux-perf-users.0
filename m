Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097C23D8906
	for <linux-perf-users@vger.kernel.org>; Tue, 21 Apr 2026 15:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776783910; cv=none; b=XY0C2YcGJ/j0779iRm2NO4ek+PnY9Sa1EO5Kdv8eEkXhm/Vo00VrJHIAsx+hGSSDJQzARXl+y+BdjGjp3oAQgfEJs4bFz0FKJC3F8LO26rtnCcCe+CC8MQ6RwL2AXmjvN5AS3+yW/5fkroNBBRhB4WRJ9d/a05R6+tHq2CypA2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776783910; c=relaxed/simple;
	bh=ZNJJJOK/V9Tgpg06Q+ffyOBylEIdv2ytASj0D2FYNZY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dYyKRP/P/WZ81731QfdyHwUhiasU0XqfAcx/ibj9VVysxvshP02FWC40PoWaOJVVJfZrnARBVjKMJSer5M078pAYkRbkmxVlmU01+SU0yXaTbjX0V74Eqyt2OCC7lRpEbNzX1S00whuQ31SsxP0EELpH2aGSj5k+OkmKN54Py4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IRm6cA7b; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IRm6cA7b"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776783897;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4vHtWCAFcJs/RCuXazO/QZoIeeGgGBH5nBDwY37GHG4=;
	b=IRm6cA7bhL7MJYipSq/gHYTyC2A2/mXUlp3aZrAokS+qpTzA/lVfKBxmuz8Ri9MQcNEbR8
	UgjQbGobfBWEIwcV+/p57Rx2U4E8Dy5Ts5tODD0hvsaxXecUDk2jS1f4RvDPmQcDMe93k2
	xN9YgJpF+0xiSlau1kP99k+xximDIyo=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] perf/x86/intel/uncore: Use sysfs_emit() in uncore_event_show()
Date: Tue, 21 Apr 2026 17:04:50 +0200
Message-ID: <20260421150449.59720-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1269; i=thorsten.blum@linux.dev; h=from:subject; bh=ZNJJJOK/V9Tgpg06Q+ffyOBylEIdv2ytASj0D2FYNZY=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDJnPJwk+36Iud/ac+7G3x3/Upma3X4wzq7i9dn9/Sp5j4 RXr8gurOkpZGMS4GGTFFFkezPoxw7e0pnKTScROmDmsTCBDGLg4BWAiR7cx/BXzvuPyzlf6w1x3 vn3Xb8dLeVz/dOVi69vcnZohIv/OcIgyMixu+PHg7tHa5ERX9ekJik9Xftl/okX1nOnmQ6qiq+N d13IDAA==
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Replace sprintf() with sysfs_emit() in uncore_event_show(). sysfs_emit()
is preferred for formatting sysfs output because it provides safer
bounds checking.

Add a terminating newline as suggested by checkpatch.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
Changes in v2:
- Add a terminating newline as suggested by checkpatch
- Link to v1: https://lore.kernel.org/lkml/20260206194254.36105-2-thorsten.blum@linux.dev/
---
 arch/x86/events/intel/uncore.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 4684649109d9..86bc1c03b64a 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 #include <linux/module.h>
+#include <linux/sysfs.h>
 
 #include <asm/cpu_device_id.h>
 #include <asm/intel-family.h>
@@ -133,7 +134,7 @@ ssize_t uncore_event_show(struct device *dev,
 {
 	struct uncore_event_desc *event =
 		container_of(attr, struct uncore_event_desc, attr);
-	return sprintf(buf, "%s", event->config);
+	return sysfs_emit(buf, "%s\n", event->config);
 }
 
 struct intel_uncore_box *uncore_pmu_to_box(struct intel_uncore_pmu *pmu, int cpu)
