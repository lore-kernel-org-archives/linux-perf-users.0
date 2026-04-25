Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2976346FDA
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 17:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777139348; cv=none; b=BTlaVW5zNTtZKUoIKgqpSV+Kl6vWBD0FxvpGRvWYRaXhc4muzyF8YvAceCfYXzGJp6cXaNScK5nribppddKzgH93gv1y421tr+8BXBBxOPQCkWjGKcQDSkyxEuu6Uy0caYo3UcK4B6vp5O/iwfnGJLp1LER5zzt6CrYA1Qf2Ba4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777139348; c=relaxed/simple;
	bh=bITPVK77ksbOupCd8yIPNfKlXiQAinH05MI73w7M+5Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CGVzrN5DhBR3ZCHZfUb5jutZdYkZaYA8rs8m7r46NMZTsuueXBPgIH9LcGydtjyF8NL8NRnZrsooDswZcyf7b6PHeR05bR+NSBhHNUi0qFR7r6BbNdDCjbGLhblj4c6YMCT+/ZJpdVPg01s5cRZT2wyIWWyrELu4oFjUskA2D+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cBpgz2MG; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cBpgz2MG"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-12dbf4f678eso17389792c88.0
        for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 10:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777139345; x=1777744145; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=K/xS7q5C5QGMJMPDSriSnCglCHYvD9rGLYFUY/AUodE=;
        b=cBpgz2MGnKYV0Wlltiw0LNs/QAS42KSMdrNS3W+tJmNc59Mq1bB91Movgxj3Slx4nN
         NIhHajcWSz6eXv78XE6JWR93g3au5AOHG7IDQks41I3OBROw/M8Uyx3vXxvmnQLwqY/h
         tm1Heu2jETtTOpXTkkkYLjVfAtgqJheYfOGHEznO667iUBNWfEDSdEQvNQqCgMQNTVSV
         UMVUTN4Ff9+G/3E2039ZcvUYLcc6yYPNyrx2pU9CAwDPTsXBd+zx0ZOplWMVjyC/TmPq
         yEFcBteGgGNz/hWb2O5dREAcUFphd7KpNAt55Rg12sy6+M4BPm0V0JNCzsONNoYDDdfN
         1+lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777139345; x=1777744145;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K/xS7q5C5QGMJMPDSriSnCglCHYvD9rGLYFUY/AUodE=;
        b=TzeZRXMlO4MgBaNSXixr4rzf5Lo3Qxuz11VOPGa15QkCdTnXUMg3Q5QrfBXPzIpUoN
         JSVMsm4LCfcAU7NKzqI8J24qtrx+LWC/2OGeUOf7kbfalULh0YGCoVI4mzQF4RscnGw5
         G0RJjISt5dFfrgym4C0TicHC5xyX8P9EpChrIsBfX04RjLzZ9KVXyCUHJRlT/qZDnHSY
         ByBrvCxVAZc821z1Y8/hmmC/eYmTeJePNO7R2bYUOYkQZfu9miuQ9fqBCPOdhf+/UINJ
         XQwjhhq0khHyMwpZ3D+CWrOEveZmjfOnyOkxa7acfGHL0UugmIkQiEzfwhJi7D0HAl/e
         a9qg==
X-Forwarded-Encrypted: i=1; AFNElJ+Z576wMIShaUcDbMBzz8VKnl/I9od2OFsvNvyWS3BQbxCPgWCGxytt5KZTO0Q1lqtNSp57p+ShnnV2WuF6sQSd@vger.kernel.org
X-Gm-Message-State: AOJu0YxA5iEqlPg3IBqpNkIrEVVrnuh9mJggO+ImIXFOcwEIPYrdrraz
	w65sa2N4B+XUhLf5FSe2x1TajtfyQO2WgvIn074u1vvTHF1h5Sv9YjgHrULRPvtWQ3q2tkmV9Sh
	gEIAxZ1ZPGQ==
X-Received: from dlbur7-n1.prod.google.com ([2002:a05:7022:ea47:10b0:12c:4a54:8b0d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:50d:b0:121:dea2:d54d
 with SMTP id a92af1059eb24-12c73f996bemr20453442c88.20.1777139345239; Sat, 25
 Apr 2026 10:49:05 -0700 (PDT)
Date: Sat, 25 Apr 2026 10:48:00 -0700
In-Reply-To: <20260425174858.3922152-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260424164721.2229025-1-irogers@google.com> <20260425174858.3922152-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260425174858.3922152-3-irogers@google.com>
Subject: [PATCH v6 02/59] perf arch arm: Sort includes and add missed explicit dependencies
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, adrian.hunter@intel.com, james.clark@linaro.org, 
	leo.yan@linux.dev, namhyung@kernel.org, tmricht@linux.ibm.com
Cc: alice.mei.rogers@gmail.com, dapeng1.mi@linux.intel.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	Ian Rogers <irogers@google.com>
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

