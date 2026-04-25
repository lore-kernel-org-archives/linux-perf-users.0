Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8108A38F248
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 22:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777157418; cv=none; b=ByLa523h3hRHKdOW2v7SVxQN079kh3MrD3SxRDaBEFQnuYiNvSETwN8BkXjzbpw3IgcFNsnrBU7reC+qrLwoXyUUctqyo1ztghu9hGir2jXn+esDHiRUBk7HJkwWOi2ptwvIJ1w2GX9qUk6Tg2Rixg5tQhrBPKkXEvkyvqwcTWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777157418; c=relaxed/simple;
	bh=/h8ESLHe5S0bbxRN9MN7l0JrDETJedf6AiFuXhBylRE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WoBbGx5kS0LCOwYvUnnHFX+RvdTmkyqO8qwPhH4FiV8xol5MQyEqQ9CEFxAchlC+JeqMiUsMaAeioXhgpyX6h1YWu6VpDmvM9t9EFCkx31i0DcISRaNay7D1o7RuEekv+ib3c8lekBLb8hMyDg1fTY1nAwgLfKPoI9EgJg6xmwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DTs4fc5I; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DTs4fc5I"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2dd6fb4c867so15663877eec.0
        for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 15:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777157416; x=1777762216; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mqXJIn8r4IA9Gva4etcbzr/XlHSVW6Lm8pY9GKRmyzg=;
        b=DTs4fc5IwqpJTTAlQc91lMtkTr9RsPuUvpB0STRaw2TG3J6lVXRpuEhlO5Xa5dgJFQ
         ojd995w56/Ig140Tm2zl1SBlE/rgmLmLKKUW63GcAqs+2UyfOOFndz9hRqOdMMCNSgTC
         MmS0ljymi15gb2IS/w6xNq96af5SQzp+wP2Q+AgLz47Z7138ceqYX6tjSzA/vwLMsLCh
         9AyJkQG+sCSlrdmavcCDgrGektTRt3SPoujJywLjPLbaBb1JoCyHc6PLjNI3m08+l8ET
         mp58Y5hYW3HDMkJ8J8WIRVK2/iZLImuLpZnq8qb/Aen4U9jRKRqEECC5UsIKEK/gnEpD
         sEGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777157416; x=1777762216;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mqXJIn8r4IA9Gva4etcbzr/XlHSVW6Lm8pY9GKRmyzg=;
        b=FfVHkt+hvdIaoxvqdmjaWyI+vCAkoeAcUH3d9qgrpLvVFjIsZr1a7CWz791fRr8W4u
         NSBtjr+hjNUlS2RSNiyYoOpCok/UNUKTu1bODQ/LDOhD+5mOZTOMhlPGzhau09cOlRdU
         ALXZ1NvGiH1lN/ehXqTojKdBw3SgDR9RiBkrVZE4mp6bXllk/5uMa7ilvxxmaeC/0M6a
         I18EQkpXWaPre9LUiEKsMKvfNrHpbOkW7u9TyqlaM8/uyFACT4EK/VC1YfINk59OEJJ3
         DtcXQIqOvJDfFKh5qIRZEJKgb3PBOdPpSt+Lo8uXn5i4N58km/BhOqaKP9y8hfCEv97+
         Ky1Q==
X-Forwarded-Encrypted: i=1; AFNElJ8vNAgN+7x7xUfkWEKKdLOEH3JU1IO5VV/s29U5eKMirfRxFtTMN6CiJ48YSmVN/SlWw8iUjoBdEJR5agf15IkA@vger.kernel.org
X-Gm-Message-State: AOJu0YwiKaNtX3Ha7+J6dbyLUI8cOn1BvkPq6FLr/zaEFhkST8El+bfI
	nz913vjSWk5oAwxwOGiDxIJ5VsAlAmYk8dTFXTgHr56OEVsIojjPH+z0R+JquQJoHvgSS4Td4cm
	cg5LbDVASdw==
X-Received: from dycqb7.prod.google.com ([2002:a05:7300:fe87:b0:2df:9320:a159])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:d517:b0:2e0:4edd:64e8
 with SMTP id 5a478bee46e88-2e47a2faf4amr23570921eec.24.1777157415407; Sat, 25
 Apr 2026 15:50:15 -0700 (PDT)
Date: Sat, 25 Apr 2026 15:48:56 -0700
In-Reply-To: <20260425224951.174663-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260425174858.3922152-1-irogers@google.com> <20260425224951.174663-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260425224951.174663-5-irogers@google.com>
Subject: [PATCH v7 04/59] perf tests: Sort includes and add missed explicit dependencies
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
 tools/perf/tests/hwmon_pmu.c  | 14 +++++++++-----
 tools/perf/tests/mmap-basic.c | 18 +++++++++++-------
 2 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/tools/perf/tests/hwmon_pmu.c b/tools/perf/tests/hwmon_pmu.c
index 4aa4aac94f09..ada6e445c4c4 100644
--- a/tools/perf/tests/hwmon_pmu.c
+++ b/tools/perf/tests/hwmon_pmu.c
@@ -1,15 +1,19 @@
 // SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
-#include "debug.h"
-#include "evlist.h"
 #include "hwmon_pmu.h"
-#include "parse-events.h"
-#include "tests.h"
+
 #include <errno.h>
+
 #include <fcntl.h>
-#include <sys/stat.h>
 #include <linux/compiler.h>
 #include <linux/kernel.h>
 #include <linux/string.h>
+#include <sys/stat.h>
+
+#include "debug.h"
+#include "evlist.h"
+#include "parse-events.h"
+#include "pmus.h"
+#include "tests.h"
 
 static const struct test_event {
 	const char *name;
diff --git a/tools/perf/tests/mmap-basic.c b/tools/perf/tests/mmap-basic.c
index 3313c236104e..8d04f6edb004 100644
--- a/tools/perf/tests/mmap-basic.c
+++ b/tools/perf/tests/mmap-basic.c
@@ -1,25 +1,29 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <errno.h>
-#include <fcntl.h>
 #include <inttypes.h>
 #include <stdlib.h>
+
+#include <fcntl.h>
+#include <linux/err.h>
+#include <linux/kernel.h>
+#include <linux/string.h>
+
 #include <perf/cpumap.h>
+#include <perf/evlist.h>
+#include <perf/mmap.h>
 
 #include "cpumap.h"
 #include "debug.h"
 #include "event.h"
 #include "evlist.h"
 #include "evsel.h"
-#include "thread_map.h"
+#include "pmu.h"
+#include "pmus.h"
 #include "tests.h"
+#include "thread_map.h"
 #include "util/affinity.h"
 #include "util/mmap.h"
 #include "util/sample.h"
-#include <linux/err.h>
-#include <linux/kernel.h>
-#include <linux/string.h>
-#include <perf/evlist.h>
-#include <perf/mmap.h>
 
 /*
  * This test will generate random numbers of calls to some getpid syscalls,
-- 
2.54.0.545.g6539524ca2-goog

