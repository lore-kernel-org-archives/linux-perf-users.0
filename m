Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC4539D6F8
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 17:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777139461; cv=none; b=YXx7xUEK9kd2NpVFLjFPOZXNOB3sAxcAxeKjZhF9Lu14FG3yuG9sfih7a1ULarpjDzN/K+utIKLv/Y3gN9n+GUGsfQmfxi4GYUV7cu7sJO7Ub4RrXiUabrVEU8xb9bXUAVuALTTbndJ1lw9a0at937lc+K//Eub9eeglCDQjp3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777139461; c=relaxed/simple;
	bh=69fXFPVzN5elAVO1zZMw/xvGFsOIcH51j5L0belO4IE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jrGlWt1DNbavPK66r6jkOZxT8Q5lgZCfBVb60XMAhw+UEGLnu5s50cmwQ7TyS8cdYq1vQgv5vWQY9NOJ88HpjZU1/V0NbmiR4xoRtNp508uhuK5mHjjAt5mn+DhZ+Cug/JFBs+J91ywfVhSB3wn3sIAtcpij2vMHKD9De12uzg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=elH7PlAE; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="elH7PlAE"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-12dbf4f678eso17395048c88.0
        for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 10:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777139457; x=1777744257; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=l4V5NPppnOwBca93KfwrOU1gh2Bqmr4SRvd044JdzTk=;
        b=elH7PlAEplW78AYhVIT7btMrf4g6GBmqFpe/xCDoFM5dQLdVrJLM9/8RdwPY63o8pP
         grNFIJod8unvQeS6kzmGwBiPkAv5IAl3KlwhBqbMlbwocOW12DzuEAUeaOlB9P65EdIV
         wCbMbkTvLSBu9+guw/lb4ZLuICLEO5Uw9Rdf+f6s7vzbA6TANN2l+6QLRkGNEaRKyr3o
         RTo0xz/6Ee2ta3CIrhXEQ0PYDL64dBkbLBOHBGoSwAf7ZhexM6G+FNPnYxg4RHlSsNj2
         8eWo1sThI2ztrRgPFtnQpNsYo2H4NCt4oUkK/yUmI07snVy8MFHyyyRgGOjR9SEnlz52
         UU4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777139457; x=1777744257;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l4V5NPppnOwBca93KfwrOU1gh2Bqmr4SRvd044JdzTk=;
        b=HFFtuhqEtlajNODLJKpmP0sEZzD42J1xOS37hEnDcbT45e9p+8m6vWawrO66djRTqT
         svNKOjbQucjNGrJn38FmN+qleW3vRqkjHkmlfScNPpQIgSPiBmi3z+VSmjRp/HPec8AE
         M/fWTIMpmEWSupOBMMcVRYB8GRVJufsPYUeML7NgUVHkON+fnVojd+wxLUtX8yzMqpOD
         5K4wLH1flc32FXFFf3V2klXQqHI1F+TYIt43G+YKrM6M2Airhk/QNxSkS9wyN1dU+OE5
         gV/7Qvct8PRdpl1hGFvgIOz1UBGj8YH73Vd+zRLVZRxlKmTsqXbPakBLVUWBeSEfRIJA
         pWCQ==
X-Forwarded-Encrypted: i=1; AFNElJ8YyUDkG68KVnUup06p/LJcm34k1hC6MrenaRItOtZ+e068LpfrCCC18ys2NYJ6XdLO/Mqf16RnhUJ6fX0yqgoP@vger.kernel.org
X-Gm-Message-State: AOJu0YxCH266qm5CNw4OTJ8eYC3s3WspfxeVrOsOmOho+BXotJoXWDtR
	ttCDAGEm8k8/98bo3+NnaE4A54uZ3d7+ko/x5R8koXBPRq2tPxyzzBg+z30H4cOlN4N9EnizyjR
	mnd87S4tMhQ==
X-Received: from dlbqq1.prod.google.com ([2002:a05:7022:ed01:b0:12c:8bfc:84e3])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:12b:b0:11b:ec5f:1c37
 with SMTP id a92af1059eb24-12c73f996d4mr21334956c88.18.1777139457260; Sat, 25
 Apr 2026 10:50:57 -0700 (PDT)
Date: Sat, 25 Apr 2026 10:48:56 -0700
In-Reply-To: <20260425174858.3922152-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260424164721.2229025-1-irogers@google.com> <20260425174858.3922152-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260425174858.3922152-59-irogers@google.com>
Subject: [PATCH v6 58/59] perf python: Improve perf script -l descriptions
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

