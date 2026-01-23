Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3559C32470E;
	Fri, 23 Jan 2026 13:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769175138; cv=none; b=sDikZ9Wzs/9ks5UIiaLZRbZEHiIxy5lQW87qjYsDAItYfmiUj2y4BxZ+QeTBvRVeTimRhvAKFv5wkhv3ZCTnpR3YJ9BNHIi5/18u24TkPmEzsVHMn+6mTOlIBte+5Py38Etm+8jLLqPqJOTyt4CSQ+zPVNHa2m4TOTUDgM3xuMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769175138; c=relaxed/simple;
	bh=ZxHX4YkPlbx4BRnksFGZAsZa9BN1G5reRF7wQzkIwgQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HFLyOV1fsyTJ6/qQrTVfkyI6xB71TeI4UBTVxTDdgeLMBYLQFJ6rTxckIdUbrq+0EXrCzgNie3jk03HAlPsxwDQ40PEihLj+1muKduiZG2VAzmGIQppPbiO9QmvZNDy1hSS8x/6zyaYJCgko5gUE2Tis8WfXUwWEdMmKPW/8rKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 14DDC1476;
	Fri, 23 Jan 2026 05:32:10 -0800 (PST)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 54E483F632;
	Fri, 23 Jan 2026 05:32:15 -0800 (PST)
From: Leo Yan <leo.yan@arm.com>
Date: Fri, 23 Jan 2026 13:32:04 +0000
Subject: [PATCH v2 2/2] perf: Remove redundant kernel.h include
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260123-perf_fix_bitfield-h-v2-2-cc8f8752607c@arm.com>
References: <20260123-perf_fix_bitfield-h-v2-0-cc8f8752607c@arm.com>
In-Reply-To: <20260123-perf_fix_bitfield-h-v2-0-cc8f8752607c@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
 James Clark <james.clark@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 coresight@lists.linaro.org, Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769175130; l=1148;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=ZxHX4YkPlbx4BRnksFGZAsZa9BN1G5reRF7wQzkIwgQ=;
 b=l0WzgVj0aO+ezMUxHOueM9x7z9S/26BHYyBSNU6MuGZ4aPJALLx6cf8KSom+sTH3lZb6ctzPz
 lyROXNagZShAq9zjchDAen74Jj2fGpbt5FEWMS5BPbSnL+kKAcR0Rbe
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

Now that the bitfield dependency is resolved, the explicit inclusion of
kernel.h is no longer needed.  Remove the redundant include.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/arch/arm64/util/header.c | 1 -
 tools/perf/util/cs-etm.c            | 1 -
 2 files changed, 2 deletions(-)

diff --git a/tools/perf/arch/arm64/util/header.c b/tools/perf/arch/arm64/util/header.c
index f445a2dd6293442645404d7c42c3f7a2992bd9c9..cbc0ba101636bf275101385c662f5f3881c8f7c4 100644
--- a/tools/perf/arch/arm64/util/header.c
+++ b/tools/perf/arch/arm64/util/header.c
@@ -1,4 +1,3 @@
-#include <linux/kernel.h>
 #include <linux/bits.h>
 #include <linux/bitfield.h>
 #include <stdio.h>
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 12b55c2bc2ca4f5d7df6b26ddbffc18b7904800e..95f439c96180d354f2bc08356a844c1a79d5a148 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -6,7 +6,6 @@
  * Author: Mathieu Poirier <mathieu.poirier@linaro.org>
  */
 
-#include <linux/kernel.h>
 #include <linux/bitfield.h>
 #include <linux/bitops.h>
 #include <linux/coresight-pmu.h>

-- 
2.34.1

