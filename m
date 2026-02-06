Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE9A2EBB81;
	Fri,  6 Feb 2026 19:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770407022; cv=none; b=GdKxwdfKV55MDQCPbm7uz9nvrR8DTl4z2ZgAC6OX2rvcgmhHBV/tA76spkuf9DL8zSKc8d55aRcwhS8r7XKDtLpEfhnNrsJE9nvaIVQ8eCBInBLR/XX0tXn1xHOji4Lbm34lQ7bpV7CpmpXU1Btp5qFEiwIsLKVHyRIqPx6d+7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770407022; c=relaxed/simple;
	bh=uIQCEKUfbORVdTi93lTmNICimgCE+j9FqLkKKJj/6go=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SMUJVd0gOiEH++1Nni6CwmjxAtcJwIIacp0RyTeVdYxGytYx728uFaa9k6wSMwoL31pJNiNAw++NgXTiH3jw54kB0a/boQQ/18GY3aUHfv33vDhiPR7mRHL64qqb+5C8PtOtr344UPctMkgzRLfli5mVlV5N9AdPyplvOofITyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fi01jPY+; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fi01jPY+"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770407020;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=W9cZfthmjsgFe/vPcvXa2/n0sqDNdb7yKYE0a/3lgLs=;
	b=fi01jPY+/GEX7sx1yzXgXxiEfqxKlXqjMbn+T9biX2XWS+kLmNMkppPZIA9lVs1wFx2J3w
	d2NE6AaKFoOduYr2bcY/fMQpcj2rIPNdSHkkHrmbut1zLDFbCpI+HQTKjPrwy7AdBIpY2T
	jlxhu6FXMW7cJ0O5UOPVPSDsg8n2eVM=
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
Subject: [PATCH] perf/x86/intel/uncore: Use sysfs_emit in uncore_event_show
Date: Fri,  6 Feb 2026 20:42:54 +0100
Message-ID: <20260206194254.36105-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Replace sprintf() with sysfs_emit() in uncore_event_show(). sysfs_emit()
is preferred to format sysfs output as it provides better bounds
checking.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
checkpatch warns about a missing terminating newline. Please let me know
if this should be added.
---
 arch/x86/events/intel/uncore.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index e228e564b15e..532eb68d950b 100644
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
+	return sysfs_emit(buf, "%s", event->config);
 }
 
 struct intel_uncore_box *uncore_pmu_to_box(struct intel_uncore_pmu *pmu, int cpu)
-- 
Thorsten Blum <thorsten.blum@linux.dev>
GPG: 1D60 735E 8AEF 3BE4 73B6  9D84 7336 78FD 8DFE EAD4

