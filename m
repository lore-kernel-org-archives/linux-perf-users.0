Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6418B21ADBC;
	Fri, 28 Mar 2025 12:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743164824; cv=none; b=m1hYGKfDYJGgbTGsnM+k/WYxG1BSwnDaaL8YBBCq9Y+8gzDZ0oenWIdujv/PkhdTdNHTeWCI69LsyuaIX8kzrl+Pi3daGdAmS3OTike9Q7903vQcLiktw/PRuPUz/LUkuEcKYTEU9ihfrmj38qrVRktxKhlpi8PSr2EIYs132sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743164824; c=relaxed/simple;
	bh=4A51r4J4k6fvL8K9vhlNLWy+yBPtoZPbbeUliBdFZmQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jptIqgbC/gY6VS0GyQlyaI/z8p2X86jrgIfnrdjXkVX5emMJoAAhiahHUKjQcw9L1dzxdXgAcg4EnkTkAa95XtQSgkT6H1d43aQ/oXIoRxPmBDNNgS7QGwMndxD0s2vi6bDIbbDH7VB1Wu1O3zbyZYJaNcB5wUxGBiRmBeA/DF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6D585169C;
	Fri, 28 Mar 2025 05:27:06 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2D64E3F58B;
	Fri, 28 Mar 2025 05:27:00 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH 2/2] perf hist: Refine signed integer checking
Date: Fri, 28 Mar 2025 12:26:44 +0000
Message-Id: <20250328122644.2383698-3-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250328122644.2383698-1-leo.yan@arm.com>
References: <20250328122644.2383698-1-leo.yan@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To avoid any issues caused by overflow in a signed integer, and since
the limit to USHRT_MAX is not necessary, this patch simply decrements
the signed integer and checks that it is greater than 0.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/ui/stdio/hist.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/tools/perf/ui/stdio/hist.c b/tools/perf/ui/stdio/hist.c
index 7ac4b98e28bc..6da624309fab 100644
--- a/tools/perf/ui/stdio/hist.c
+++ b/tools/perf/ui/stdio/hist.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <limits.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <linux/string.h>
@@ -25,10 +24,7 @@ static size_t callchain__fprintf_left_margin(FILE *fp, int left_margin)
 	int i;
 	int ret = fprintf(fp, "            ");
 
-	if (left_margin > USHRT_MAX)
-		left_margin = USHRT_MAX;
-
-	for (i = 0; i < left_margin; i++)
+	for (i = left_margin; i > 0; i--)
 		ret += fprintf(fp, " ");
 
 	return ret;
-- 
2.34.1

