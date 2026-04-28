Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267A63BC68A
	for <linux-perf-users@vger.kernel.org>; Tue, 28 Apr 2026 07:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777360764; cv=none; b=Gga8GkRbyxn/fik4JgKTmrFi4BKhHCNcDYQQCVmm/wjDEum7lrZ829bQsxcfJ5iR7hPrQiL+zUA7SZ1o+JNmzirsLUcx2yCphOzTFEhBkkA64G6VRTX6AUww6gF94HgalYBLsUFvkWfdEdAs0YFaBb3HvFhSO/KdZxv1X7hLCQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777360764; c=relaxed/simple;
	bh=bITPVK77ksbOupCd8yIPNfKlXiQAinH05MI73w7M+5Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KKyhE6qU6Or+uTu13raPKXlyv+BDXkUHMOqIw2k6HqgOxMyzujGZu1xLHA/QcoEnWBX+0H7JnSn4jvjtZqqQs0D9ve/ruxoTCaAqm8LFslI+OPOTjappejqdqvSnQKCuixUj2qqo+diEJDAnxuagGrA0i1PivUbrAoUBykuUeTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BoNm6A6f; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BoNm6A6f"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2e60238adb1so27751503eec.0
        for <linux-perf-users@vger.kernel.org>; Tue, 28 Apr 2026 00:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777360761; x=1777965561; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=K/xS7q5C5QGMJMPDSriSnCglCHYvD9rGLYFUY/AUodE=;
        b=BoNm6A6fYzgKCqloEzNoxL8d3d9KAwNhtoo84ATdub10O3jwNLmKfO6QQ2mauoF6KH
         5dmto5o4M9ttK6LZgM6NYnDlXhba4iwKqpW9xAJPyzQWLswBHXvEMOnk0haSdrpNH+Ci
         2e5j5myVVBJjerWP0u5g3V1FxufP9/zaerz+AXW80wUV+QpF7KAjrm+G0sPtYrk5ue+2
         pG6jMwSCUvaNDSxffAFc0fTiNBzoMkeopFc3gfYCnlVz5h6pkiDyzcNH3tetMeXIGMYp
         2qdbNr6mhgYJqeVfixUlAcQyAdouPmR8RUTRnmX3TBZtvv/xNS7gbvVLp7+y+qa3cVfj
         8qNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777360761; x=1777965561;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K/xS7q5C5QGMJMPDSriSnCglCHYvD9rGLYFUY/AUodE=;
        b=FoIOC7q1K1iRBAGyBpfmFJgv9lrAPl+aAmIXl/xZ0e48s7wCO3MZxIV+SYvg/C1OER
         AL/ToTFXeXHiHQYSeEaHY4WBQgr+uS8IhBH+ndJMG5j751mcVvK/C+Aj++vtCNX4FNBM
         0OBOb287LgXkh+QMEsx2PrVsY5ESrclU3ZTXBw9jUX8HS3378bau1O3kzNsYre9fIg2D
         nJZ58RC8dSsaGAXCaM5elxAd1yMO1+oSyx8nFeEra42ll9Oz7CJS6fg8nwcAY4xKlc0Y
         Py8sNv5LjvKWy0YGF4+iuDC5mEXbm1X9P+zt492i0IAvyJopBHhbLJHcecd1czmzEqA1
         JcaA==
X-Forwarded-Encrypted: i=1; AFNElJ9p9HPmINEVWKTE/SQfLA1NB+8LamflljY5rauy4bz0wUPX/dUhMS5e9iUruPVVwaoOBhU1K2D8uSzgzdwpmC1Y@vger.kernel.org
X-Gm-Message-State: AOJu0YxEJ1r1j1SwtQEg/ULGKZHVrqB5oh4R9wYqXlL7mLvel529kEIm
	K1S26l8Y8tTiJ7yXMc95XiSsNx32r9aGnPGydKDOwnOLoPY9WquTxFN+brvDMr/ZnDJh/WVQFzo
	T9dZv8CGmkA==
X-Received: from dyji40.prod.google.com ([2002:a05:7300:7a28:b0:2d8:dd18:baee])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:fd07:b0:2ed:e16:6b4a
 with SMTP id 5a478bee46e88-2ed0e16f02amr534432eec.32.1777360761061; Tue, 28
 Apr 2026 00:19:21 -0700 (PDT)
Date: Tue, 28 Apr 2026 00:18:06 -0700
In-Reply-To: <20260428071903.1886173-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260425224951.174663-1-irogers@google.com> <20260428071903.1886173-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260428071903.1886173-2-irogers@google.com>
Subject: [PATCH v8 01/58] perf arch arm: Sort includes and add missed explicit dependencies
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, alice.mei.rogers@gmail.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org, leo.yan@linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	tmricht@linux.ibm.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Fix missing #includes found while cleaning the evsel/evlist header
files. Sort the remaining header files for consistency with the rest
of the code.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/arm/util/cs-etm.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index b7a839de8707..cdf8e3e60606 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -3,10 +3,13 @@
  * Copyright(C) 2015 Linaro Limited. All rights reserved.
  * Author: Mathieu Poirier <mathieu.poirier@linaro.org>
  */
+#include "../../../util/cs-etm.h"
+
+#include <errno.h>
+#include <stdlib.h>
 
-#include <api/fs/fs.h>
-#include <linux/bits.h>
 #include <linux/bitops.h>
+#include <linux/bits.h>
 #include <linux/compiler.h>
 #include <linux/coresight-pmu.h>
 #include <linux/kernel.h>
@@ -14,25 +17,24 @@
 #include <linux/string.h>
 #include <linux/types.h>
 #include <linux/zalloc.h>
+#include <sys/stat.h>
+
+#include <api/fs/fs.h>
+#include <internal/lib.h> // page_size
 
-#include "cs-etm.h"
-#include "../../../util/debug.h"
-#include "../../../util/record.h"
 #include "../../../util/auxtrace.h"
 #include "../../../util/cpumap.h"
+#include "../../../util/debug.h"
 #include "../../../util/event.h"
 #include "../../../util/evlist.h"
 #include "../../../util/evsel.h"
-#include "../../../util/perf_api_probe.h"
 #include "../../../util/evsel_config.h"
+#include "../../../util/perf_api_probe.h"
+#include "../../../util/pmu.h"
 #include "../../../util/pmus.h"
-#include "../../../util/cs-etm.h"
-#include <internal/lib.h> // page_size
+#include "../../../util/record.h"
 #include "../../../util/session.h"
-
-#include <errno.h>
-#include <stdlib.h>
-#include <sys/stat.h>
+#include "cs-etm.h"
 
 struct cs_etm_recording {
 	struct auxtrace_record	itr;
-- 
2.54.0.545.g6539524ca2-goog

