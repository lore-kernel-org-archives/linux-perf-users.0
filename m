Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E45633A6E9
	for <linux-perf-users@vger.kernel.org>; Fri, 24 Apr 2026 16:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777049251; cv=none; b=kyeuSpSTYr6IK3F269RtfIJxSVC4dbUreEFKeh3xQG31mAJzzErKFZ+/5WMn+lfM5omBq2ud6HDhoi14U+oMKy/H1h9o8Zt082xpkHuXicxXX7pr7iQG5EOGu4XE+GziDmG4SzTYV4CCDUJn099LINIenCKD6qbX058gkaY0itk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777049251; c=relaxed/simple;
	bh=bITPVK77ksbOupCd8yIPNfKlXiQAinH05MI73w7M+5Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=O/lpqWTfwXT8yh0XWR7Dnaxt91YK9jhfthq1HPCvOMXyWEEDyNSP2UuVzJMB4MEhw/JD2zAVhGMhvo56fuuLPgWWUSeNRF1ON+0Cs5nmtKgq52FwtS8zo4dsIhlLCVvOzPLq4+KOHnbXHHTecSmMHiHzI41agGbJeBr8Pf9m1Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nmicYZDr; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nmicYZDr"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c76c6280732so9039705a12.0
        for <linux-perf-users@vger.kernel.org>; Fri, 24 Apr 2026 09:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777049250; x=1777654050; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=K/xS7q5C5QGMJMPDSriSnCglCHYvD9rGLYFUY/AUodE=;
        b=nmicYZDrkp8SEBKkUWxJaCUzqmcyTuj6oSuGaFw92poh33+rO+r/VflYk3sk0z3tMK
         yT5iKc/FosGFy192WUBR9oN53YLG3vXAPZZTSgNfrGcMNx3IqfNFC2hQY+CdrmMwry+U
         AUujpiOux1337c5WZNHWn1OR6EkTEsbV7R+3kXtSeSItoPZqmzZAy1c3BLqOqMgaAfu5
         mpMUpQLUT0P4owp6zqbdq/SIG6SwEb8IeNGFlnvxRa83MD3pHSaa0oC+eiipE/oy9J6R
         CSZZjheDlt08+yzRKNISVYeyOSlJjNt+zlbmwG40iwgnjqbuuYr9qPmiHi/pRrlHeOud
         ubzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777049250; x=1777654050;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K/xS7q5C5QGMJMPDSriSnCglCHYvD9rGLYFUY/AUodE=;
        b=IdX5wDjrAQ9dxLkldJHokZASYLVY+sBIXkbVjx1p3UAg0FidK8eQ5hgI1Gd7OW9Dxb
         5wf+njOYgq2/8bLNRq4ZvsxWhHoXo52hqxxls9R0h/rDZZmNec68cZwHC5eis+DvVp61
         c2a2j2Cjmt/iwg0qQz48OefUzB0rTgrga8/ZPc8HXf00pxQLverts3ZmRjYpEOinEKRW
         QCGVA6NQROrdrxNtBxVq4HeBxo8Tz+LsIY5mvGvFDdpTyubLlziVxGpCGrpBqbaNfz26
         bJl8HMJoiCex68n7INvtAdLo5zEebxsIeUgW0ASUMAuNE853YLynk20qO1ZIOPTZ3c/n
         Dz7A==
X-Forwarded-Encrypted: i=1; AFNElJ9Ix4f06OXtk88JG68AJEP96M1HwTDkTXQC5n1si41Wz6Glwv1by1TShZB1JVF/Ko9X/O88EitEyXtfj6IQU58j@vger.kernel.org
X-Gm-Message-State: AOJu0YzaU0gllNKSqnoyOLxmEJNGslD3GD5BYakDkfjymggDtw7WyCV8
	OxXdm2LfctAKI+TpPF9SjRrIDqZGVaZ6LLu595+zH5niqUuNS0Bk1COULcNgs7ICYjXd3ouKiwb
	AXq9eAbwP3g==
X-Received: from pgbfq1.prod.google.com ([2002:a05:6a02:2981:b0:bac:6acd:818b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:7f85:b0:3a1:76d3:c1b4
 with SMTP id adf61e73a8af0-3a176d45d70mr27186517637.30.1777049249361; Fri, 24
 Apr 2026 09:47:29 -0700 (PDT)
Date: Fri, 24 Apr 2026 09:46:24 -0700
In-Reply-To: <20260424164721.2229025-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260423163406.1779809-1-irogers@google.com> <20260424164721.2229025-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260424164721.2229025-3-irogers@google.com>
Subject: [PATCH v5 02/58] perf arch arm: Sort includes and add missed explicit dependencies
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

