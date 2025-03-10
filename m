Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A592E1C54B2;
	Mon, 10 Mar 2025 19:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741635950; cv=none; b=FZb9mewM3HaR/O0IxvMWYDqj2FtR61O/OHSiKWlYDaL1XAm+5D2gcYJzUoLTPtPVtOHPMfjgDC5wSNlUTIHGLS8VQPNe27/iY4aMZN6Z0KUnxf6+XwyVbFhvmjHkUVhAE5jAIE+7EU6g/hrG7tb5bYVo/YX7mxrcWZqkj0buPr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741635950; c=relaxed/simple;
	bh=eWMNKQXpfEBHkUD356t+edleLweO0zbR+YCN2pmhSoU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c14MPQ6AWOi1grXIOXnYBheV+2fD/VwvlVMQSb32EzXFiDP8GgWUxp72n9IdJ/VtuY+tqba/+GnXQHtykLpCqJmRLEV54sVYnV+oDqsr2glKwT9cNZDvWSI6Cp+jJAEEagKrqX+5ck4SPwgOVU+tN/XsB7T2kEnm6vJYQeGciqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fbpr7KuQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fbpr7KuQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52603C4CEEC;
	Mon, 10 Mar 2025 19:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741635950;
	bh=eWMNKQXpfEBHkUD356t+edleLweO0zbR+YCN2pmhSoU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fbpr7KuQpkAPVuF6BHJjglrczjMo72vIWGnyysEbBaxp3tJbO7tddCb6u2saAKRGV
	 twvgDS5Sa/ig9WQyyV6MJzq6fegQ2qmTZUA471xlBEL1ORRYGyEqASh6HdKSXhNZDJ
	 hZYThQUotFdSdpo7yryrJTlPHSxyR5PJmVonTN049lGW74wM7nzmzieZab5OUgCDyT
	 OkHVI4MAPMKvOG9J6NgI8AvNGzddmMBgguTQ09WBvery/uyJEdpp2Jc0k+nbCBIKiI
	 vqaa0+yHTbK8M3RJAz4uS1ADD2K4meqkbfQEAYe29pqR1mxhWLPXO5FKJ90x2W1/v6
	 sUkHdnr1/v2vw==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 3/3] perf hist stdio: Do bounds check when printing callchains to avoid UB with new gcc versions
Date: Mon, 10 Mar 2025 16:45:33 -0300
Message-ID: <20250310194534.265487-4-acme@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250310194534.265487-1-acme@kernel.org>
References: <20250310194534.265487-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Do a simple bounds check to avoid this on new gcc versions:

  31    15.81 fedora:rawhide                : FAIL gcc version 15.0.1 20250225 (Red Hat 15.0.1-0) (GCC)
    In function 'callchain__fprintf_left_margin',
        inlined from 'callchain__fprintf_graph.constprop' at ui/stdio/hist.c:246:12:
    ui/stdio/hist.c:27:39: error: iteration 2147483647 invokes undefined behavior [-Werror=aggressive-loop-optimizations]
       27 |         for (i = 0; i < left_margin; i++)
          |                                      ~^~
    ui/stdio/hist.c:27:23: note: within this loop
       27 |         for (i = 0; i < left_margin; i++)
          |                     ~~^~~~~~~~~~~~~
    cc1: all warnings being treated as errors
    --
    util/units.c: In function 'unit_number__scnprintf':
    util/units.c:67:24: error: initializer-string for array of 'char' is too long [-Werror=unterminated-string-initialization]
       67 |         char unit[4] = "BKMG";
          |                        ^~~~~~
    cc1: all warnings being treated as errors

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/stdio/hist.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/ui/stdio/hist.c b/tools/perf/ui/stdio/hist.c
index 74b2c619c56c8ba3..7ac4b98e28bca82e 100644
--- a/tools/perf/ui/stdio/hist.c
+++ b/tools/perf/ui/stdio/hist.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <limits.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <linux/string.h>
@@ -24,6 +25,9 @@ static size_t callchain__fprintf_left_margin(FILE *fp, int left_margin)
 	int i;
 	int ret = fprintf(fp, "            ");
 
+	if (left_margin > USHRT_MAX)
+		left_margin = USHRT_MAX;
+
 	for (i = 0; i < left_margin; i++)
 		ret += fprintf(fp, " ");
 
-- 
2.48.1

