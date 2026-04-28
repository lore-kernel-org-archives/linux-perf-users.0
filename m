Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395603CEB9B
	for <linux-perf-users@vger.kernel.org>; Tue, 28 Apr 2026 07:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777360767; cv=none; b=Xr6GKtevV1M9muiFG+Dx/NaKcjfRXKvYP44ZyNDA5TD6zBTr0Pjsljgry9AoztGdHMzpPz7/g51meqhQAuE7+8kUzTXrwPXw/E6mbnNqhPsMXo9XSSBBtt+oHoh2OW4aJHCeyY0Qn8Dbs6gvgY6bwn6fAuXFaLMlT8tYbgT8US0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777360767; c=relaxed/simple;
	bh=/h8ESLHe5S0bbxRN9MN7l0JrDETJedf6AiFuXhBylRE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QPn4bn3w71EXt1jp0n5yysfTdWsvDdIgN9EfYF+gARUfQ9WSaRWgIlLqwsx3azpVPg2N7w1vaLHjw64uC03du/CoT+8e4Ebh4Kzg5dZMnkWk9WGUTDS748j6dmK8MIFkZawGjUSj5ULrxpX5cZnvzpc9hD6e18R+B/SZosHj1vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZDprcp0p; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZDprcp0p"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2dd6fb4c867so22497354eec.0
        for <linux-perf-users@vger.kernel.org>; Tue, 28 Apr 2026 00:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777360765; x=1777965565; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mqXJIn8r4IA9Gva4etcbzr/XlHSVW6Lm8pY9GKRmyzg=;
        b=ZDprcp0ph4SYhZ5m/tq9maBAtr+/QWwQIb8v0vbtU2RiGOKnMTFtzmYkvXSu0WdOb3
         PEJBV6VM/4214oQX40yUMTuyMPX/KS42zpsoLJbtsiLiDUoJlsJD2c8XuVGOmkbjL/Ig
         Hfi+GHmLA/vTXTD48nDBoQkTdC3sz4mnu2cAwZXeXAyzoKlmAs9L+Ken0vuv10Wm1h4Z
         hld//aAY4x27ioDXUlB2kQZ2ZwgYnn3O5NkKj7JdEe88xyYtSkRKDTTzfV8JwQgftDtN
         tdAOHl92KYj2evJQ5ZNE8kmbpOTpVr52tV2z1ZZTfQ0bK0vjWuvsn++HHj++ril6yywj
         fYCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777360765; x=1777965565;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mqXJIn8r4IA9Gva4etcbzr/XlHSVW6Lm8pY9GKRmyzg=;
        b=RYrJae+vXTAypaNOyzrv1PKQon7w4yjbXRIsux0DAB/DA+PduJ9Q6ZN2zGVdHcCWzv
         cBpTp/T4MjSZIT8vr5UMsMjfRzjaY9z9gsgif/rC47jHxY39FNJ9zG3Mn7rMwSGqEOVU
         9unyTbpnMxc1ShmSF8yqisHX1MuiTBHLf0U6EAe8C3C2jj+P2PGICM2oczFWMF+rP9na
         4SLRX8Yx1Kr4jkVXCcczsfnX2f3Ih9eSkCLSfeSnvCG/2OY//A5MWOvJqI+tCMcaDFw7
         CI0KRXWkM16l44HVCllopkjHmPO+3JKcuBdFvRSSi8taVubRqisOWgMVM+fnGrL98Nbi
         MjxA==
X-Forwarded-Encrypted: i=1; AFNElJ8itjw1YgvKKarplGAYKaC06yJEkXCK8J8vmN3CNPQvAJU4Iv4AyofBDs0RMI9tU6//v7umF2Pt9KBznPrnhOWt@vger.kernel.org
X-Gm-Message-State: AOJu0YzgosxvsXqLVD+2kTxvRaluMtfPF6KCHs0Pmwat7rfql+mh6OJb
	yjG1Jif4eAYwnjwJ7W+0yVymDq7i46Ipnn8EyafQZ4FRM8+BYsu2JjfQWXqp8lA4zTKuPNF/GS2
	zMM6yL39Pcg==
X-Received: from dycnm7.prod.google.com ([2002:a05:7300:d187:b0:2d8:fc66:cd7b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:678b:b0:2e2:3381:2fba
 with SMTP id 5a478bee46e88-2ed0a003e77mr1018917eec.3.1777360765045; Tue, 28
 Apr 2026 00:19:25 -0700 (PDT)
Date: Tue, 28 Apr 2026 00:18:08 -0700
In-Reply-To: <20260428071903.1886173-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260425224951.174663-1-irogers@google.com> <20260428071903.1886173-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260428071903.1886173-4-irogers@google.com>
Subject: [PATCH v8 03/58] perf tests: Sort includes and add missed explicit dependencies
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

