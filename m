Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32681BC46
	for <linux-perf-users@vger.kernel.org>; Sat, 31 Jan 2026 12:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769862067; cv=none; b=iEGESVLTOY4WuTVshNUjKqjsKneo/vz9qrhMHUxHE8lBgPLjfCuUUlL3tx5MQwKdU3FRq4b4atBji2e0Cx6sASCJJA3/lWpoquWRx8QmD719CxFz/Fz5owiKRDDeSBD+vpxhxBJmVkASC9B9zq+0ijNsl0xC7ld60+XsuOSO41U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769862067; c=relaxed/simple;
	bh=ce+xZ0tVIkPAsDh+t2U2zmU9Shn59VfM21GmyPRjCO8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uQYO/DZHrsV1K5bguBQZo73rRG4bnPG1xetCb8Yu4/p834yeHHONdoZT4hz/Esz4a364qg2o4P7R6DQocYX35LfT56HrVXaggUuI4mxjR/y/rO6g0Y/2yIJ1alnJmNKQKBiMfJ0YucQ9kzbv0hfHtH55HOAy2TMLIGSVjKQMX6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ot6gdGQE; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ot6gdGQE"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769862061;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RdCu0tG0qwMotI16SIbFepy6PpQ5BtE+3HxR03F4TJg=;
	b=ot6gdGQE77PG9bjPil/3NSmkZ7SJvW22m555LF1c2ok2mZWSiSm8Xd5NzyBzo/C5ZSEQFH
	oZvzlTz1ivHjP1BM8vPXadt9fHKyWnoEYUimIO3ay4CXbs/eK4n9t4On9w/RSU1qBJJSfx
	5EOtomPgPFzpK6KcChw55uMVQR1W6iY=
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
Subject: [PATCH] perf/x86/intel: Replace snprintf with strscpy in intel_pmu_init
Date: Sat, 31 Jan 2026 13:20:11 +0100
Message-ID: <20260131122011.492961-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Replace snprintf("%s", ...) with the faster and more direct strscpy().

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/x86/events/intel/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index bdf3f0d0fe21..025971ab6341 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -12,6 +12,7 @@
 #include <linux/types.h>
 #include <linux/init.h>
 #include <linux/slab.h>
+#include <linux/string.h>
 #include <linux/export.h>
 #include <linux/nmi.h>
 #include <linux/kvm_host.h>
@@ -8077,7 +8078,7 @@ __init int intel_pmu_init(void)
 		}
 	}
 
-	snprintf(pmu_name_str, sizeof(pmu_name_str), "%s", name);
+	strscpy(pmu_name_str, name);
 
 	if (!is_hybrid()) {
 		group_events_td.attrs  = td_attr;
-- 
Thorsten Blum <thorsten.blum@linux.dev>
GPG: 1D60 735E 8AEF 3BE4 73B6  9D84 7336 78FD 8DFE EAD4

