Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018843B3BEB
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 22:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777157539; cv=none; b=o9BU26C9Jk/i/OxlR9l3+8GZ+/y1lJ5WCjzCWofoXHdQywqEqt2phY0CaA46CoFDFH3zx5ZnrPrFvDF73Wi/Ud5kexHv1Rk28tdUINxWFFU0sLXMTmRSBWFJWOPVU4ivKajzHZmi4EBByqoPEENMxN7EGkytj6W/e4G4r4HS2kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777157539; c=relaxed/simple;
	bh=69fXFPVzN5elAVO1zZMw/xvGFsOIcH51j5L0belO4IE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=q/zlgwkPoosOJ6fg/IGj91c1j4KTwPmAc7bg/b4LJ4vMZ6sJCY6sNMBsUV1vk1PTp56esg3j8lzPFOl/I3z57TZnTqnVZrWyN/RXGN75iRuNTudV+i8KDeuwJOoQUvkZcIrDeXWBBGxMlligfDxzJp+KWbOlI1LBkMM098N/cDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rwnbe6l7; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rwnbe6l7"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-12c87ba0890so30475691c88.0
        for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 15:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777157535; x=1777762335; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=l4V5NPppnOwBca93KfwrOU1gh2Bqmr4SRvd044JdzTk=;
        b=rwnbe6l7i06Jn4d9F78dUlMDNk/ffvQV7l4OIg+QlbzlqO/52oCPa+7yOYL+gjl3p5
         TGhKLV+4Qa2/BLaWtUWtAX+pKAJTuUtKE0wusUfKe26ethfoRarokbZagj9rRz5ypP57
         XX/W7O/hep+DWP3B5FONPYLpBtUl2e3jUa4Xdf6PTkemRQMuoemoKHrQ4/IQEPtw2+bx
         Kj8RuK41OaeuFM8bXsvLKA1K8PISdS1XXUawqzadF8hLaHcQ2I7T7uN5xr6GnWxzhnq6
         +aVsCuGMzwKJ5RV1yheuIgX6/ngg3cY8zkpfCG3fNO4rl3Agwxcpeg12zJS71kb6f1dv
         huqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777157535; x=1777762335;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l4V5NPppnOwBca93KfwrOU1gh2Bqmr4SRvd044JdzTk=;
        b=D+Zpbl5tpB17zTQZs7CRyEaJqsIOI7CFyWbSIquLhhBKpIQRUzJsM/e8niQklwh2Ck
         eJ+0bewM/ATSq7XwZT1z+h9+EUmKv3l2Gisoa69KjkKu+r/K4NbMWZ6+0nguWJaEnszL
         Ux0blIP+3EvIcyaHwWe0/EIGwxuIlRa/6Ldkq5hXIed/nzcPZUoSQDRsAbnBUL5ug+gp
         QbaDV+IYQ9Ip1AlONqftTI/7sokg12kbKNl7Dat+0CyD8P6JZ6gC3vYK/SlSDMiH3ox2
         9Y2rxQlbbd2d/U33JrtsUmy9Q8mHXmrQkrD41Wy/8ssozT8SzXcHHuMuXqwpWdKUtXfy
         9Y2Q==
X-Forwarded-Encrypted: i=1; AFNElJ9equP0xOpnguwn/ouMUEtSHVIX8vseocmiLrq0xFLXN0uIdZbE/1AAVMghedRRIQhr/MlMrfj2e2TiG1pWQ1Y2@vger.kernel.org
X-Gm-Message-State: AOJu0YylxC7bgA/9JxSuVA+gRwIxdGb9/4NYtF4Efgqt9UrG0jYLina8
	YTTg5KGwfg4ciYD0lnoGsnguNw+851ebqu47DbZ0RrvHXwBgCHV7ckIKw4HDeC+xLNgUROwAOCy
	oXTjq2BhYgw==
X-Received: from dlbec10.prod.google.com ([2002:a05:7022:d8a:b0:12c:34da:e06e])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:689b:b0:12c:8cb9:fc7
 with SMTP id a92af1059eb24-12c8cb91328mr15865741c88.11.1777157534750; Sat, 25
 Apr 2026 15:52:14 -0700 (PDT)
Date: Sat, 25 Apr 2026 15:49:50 -0700
In-Reply-To: <20260425224951.174663-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260425174858.3922152-1-irogers@google.com> <20260425224951.174663-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260425224951.174663-59-irogers@google.com>
Subject: [PATCH v7 58/59] perf python: Improve perf script -l descriptions
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, adrian.hunter@intel.com, james.clark@linaro.org, 
	leo.yan@linux.dev, namhyung@kernel.org, tmricht@linux.ibm.com
Cc: alice.mei.rogers@gmail.com, dapeng1.mi@linux.intel.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Improve the description when running "perf script -l":
```
$ perf script -l
List of available scripts:
...
  counting                             Example for counting perf events.
...
  exported-sql-viewer                  exported-sql-viewer.py: view data from sql database.
...
  tracepoint                           Example showing how to enable a tracepoint and access its fields.
  twatch                               Example to show how to enable a tracepoint and access its fields.
...
```

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/python/counting.py            | 1 +
 tools/perf/python/exported-sql-viewer.py | 2 +-
 tools/perf/python/tracepoint.py          | 1 +
 tools/perf/python/twatch.py              | 1 +
 4 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/python/counting.py b/tools/perf/python/counting.py
index 02121d2bb11d..9adbbeccdacd 100755
--- a/tools/perf/python/counting.py
+++ b/tools/perf/python/counting.py
@@ -1,5 +1,6 @@
 #!/usr/bin/env python3
 # SPDX-License-Identifier: GPL-2.0
+"""Example for counting perf events."""
 # -*- python -*-
 # -*- coding: utf-8 -*-
 
diff --git a/tools/perf/python/exported-sql-viewer.py b/tools/perf/python/exported-sql-viewer.py
index f3ac96ada1f5..6d526a2502ca 100755
--- a/tools/perf/python/exported-sql-viewer.py
+++ b/tools/perf/python/exported-sql-viewer.py
@@ -1,6 +1,6 @@
 #!/usr/bin/env python
 # SPDX-License-Identifier: GPL-2.0
-# exported-sql-viewer.py: view data from sql database
+"""exported-sql-viewer.py: view data from sql database."""
 # Copyright (c) 2014-2018, Intel Corporation.
 
 # To use this script you will need to have exported data using either the
diff --git a/tools/perf/python/tracepoint.py b/tools/perf/python/tracepoint.py
index 15b0c8268996..d3bc22628ef7 100755
--- a/tools/perf/python/tracepoint.py
+++ b/tools/perf/python/tracepoint.py
@@ -1,5 +1,6 @@
 #! /usr/bin/env python
 # SPDX-License-Identifier: GPL-2.0
+"""Example showing how to enable a tracepoint and access its fields."""
 # -*- python -*-
 # -*- coding: utf-8 -*-
 
diff --git a/tools/perf/python/twatch.py b/tools/perf/python/twatch.py
index 04f3db29b9bc..e50cc2feb58a 100755
--- a/tools/perf/python/twatch.py
+++ b/tools/perf/python/twatch.py
@@ -1,5 +1,6 @@
 #! /usr/bin/env python
 # SPDX-License-Identifier: GPL-2.0-only
+"""Example to show how to enable a tracepoint and access its fields."""
 # -*- python -*-
 # -*- coding: utf-8 -*-
 #   twatch - Experimental use of the perf python interface
-- 
2.54.0.545.g6539524ca2-goog

