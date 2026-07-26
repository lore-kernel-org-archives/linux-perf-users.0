Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1200519D07A
	for <linux-perf-users@vger.kernel.org>; Sun, 26 Jul 2026 09:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785058921; cv=none; b=rLX8xMeJ18slYEzzTNRyL/FwiCKAkbYxXENxKgvb1eijUuRMoTKI/Pm503iVbhMSeLk/4RsYuSqRlT/ywaLF8V0YWkBgncDNwogwWqmfp5opG9k3Q+pW3dlUp1eSruZPFJ1w873cMlZsYsRUhZMjNVZP+KPvlxpr34bZYsfOjRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785058921; c=relaxed/simple;
	bh=xF0oL86VbynUVv+yHKXzx2ejlNjUD5MUNg2cUk5gJq0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dBwre8TjfxYM6leP1sKmZG2pffq67QrcIMKZEeB0dSWjqNoMeZuRj3STGjXqQekIgA9+Oh7/0PhDy9mdvGgaY3GHwiQWkROlmtPpcuhGp37Ds+2ZK12i3H+eVYBTCnKNM6j8mB0rflUXID9S4j63Yz49gkbzZkrJM6+LiUEm21g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nElLjEK+; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nElLjEK+"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785058906;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DvZYkBaevi49jyGyTfSDasDrujoxKSMJ2pn73CQX/9Q=;
	b=nElLjEK+3zGwjAoEqoeVY/Q+3WXVDV8QEb98SMZXGQD04wUMkYmp73GxwHk5rw8jVox2yT
	8/lqjnHSuMpLmSBqoty7DYeV+DTcpE2+0g8hSTbARSMUPMD4it5++Tll/cnF76MIKeuIcw
	fhwCltNif2cLoyRiteM3MoxtvpXGiB0=
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
Subject: [PATCH RESEND v2] perf/x86/intel/uncore: Use sysfs_emit() in uncore_event_show()
Date: Sun, 26 Jul 2026 11:41:22 +0200
Message-ID: <20260726094120.331668-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1312; i=thorsten.blum@linux.dev; h=from:subject; bh=xF0oL86VbynUVv+yHKXzx2ejlNjUD5MUNg2cUk5gJq0=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFmp1xzFJa7EZWVsi93RtFGmrXyryUkvneKyL+kFNQGu7 isiXd07SlkYxLgYZMUUWR7M+jHDt7SmcpNJxE6YOaxMIEMYuDgFYCKf5zIynD6Tu3/pVDcD99+T rwttba6JcGm55jGnPVYrR6HchfHhaob/yYfz3vBpcm6/7b51mXP70/1BFyyFpO5daZS9JGLDdca YEQA=
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Replace sprintf() with sysfs_emit() in uncore_event_show(). sysfs_emit()
is preferred for formatting sysfs output because it provides safer
bounds checking.

Add a terminating newline as suggested by checkpatch.

Acked-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
Changes in v2:
- Add a terminating newline as suggested by checkpatch
- Link to v1: https://lore.kernel.org/r/20260206194254.36105-2-thorsten.blum@linux.dev/
---
 arch/x86/events/intel/uncore.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 7857959c6e82..1ef4b4a5f545 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 #include <linux/module.h>
+#include <linux/sysfs.h>
 
 #include <asm/cpu_device_id.h>
 #include <asm/intel-family.h>
@@ -153,7 +154,7 @@ ssize_t uncore_event_show(struct device *dev,
 {
 	struct uncore_event_desc *event =
 		container_of(attr, struct uncore_event_desc, attr);
-	return sprintf(buf, "%s", event->config);
+	return sysfs_emit(buf, "%s\n", event->config);
 }
 
 struct intel_uncore_box *uncore_pmu_to_box(struct intel_uncore_pmu *pmu, int cpu)
