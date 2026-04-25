Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1962439DBC9
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 22:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777157141; cv=none; b=faGx3MlrQk6FuNcgwwHZPxFYk6diLtDi7XQgZzDX2z6Netw2HlktLGspZPkk/rX7UlCUXIKbChGm2nMvTS8Cp367ebm+g4aoaOaatKy6wKJnfFibeyX64rfLrJYOhIPHQMrtwStSQlxukL+I7Z7sAf59WWTRwatHBfglKcEJIks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777157141; c=relaxed/simple;
	bh=69fXFPVzN5elAVO1zZMw/xvGFsOIcH51j5L0belO4IE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XVRuoSidx5tSsX35HHZ23qlUFa353IQNzhjzRq/KFTyFcjyPTgXVW0G3+QGyoZ/vUJ8lfe5K4msA6faUOOPPSi/6NbBkg+T7a0jMebk+hyezu/sul/x8640LERemd4pY+dTZKgM+RgC9g2XQJuzd1xvF1tspMMDad6G6c2NGT68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DrdC2NMx; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DrdC2NMx"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2c16233ee11so12490083eec.1
        for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 15:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777157138; x=1777761938; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=l4V5NPppnOwBca93KfwrOU1gh2Bqmr4SRvd044JdzTk=;
        b=DrdC2NMxMrQJjb47FXsmlfpVvsxmY1kuGNvH47sfhClH86f9ZeBVLtuV/ykD7BNPoE
         T8g5WN9mQ5wiFXgY1XtP7mGB5oCa/eCtsM7oD7jwWahfLsa7QjjJKLQl0Xg4Neh6zg6V
         pz2rDffGYNOw3yLyijSa0fGQvzfpTS33sQY7kv7ioIUzGEtDXt0KBH8sHSHkgo/HgE3D
         5NIKRgtbaSYy8flNpCYkfzdyOgxraYViL3ZVFEybV00nqtS58nWPIizseSM7wAf75n12
         1ZnT9aiAVpW9Y7aIxNA7Rb4KwuevRt8yCMp7TdOGOeVHS/6BMcgbl1HQ2m+6DlWmLKEG
         yleA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777157138; x=1777761938;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l4V5NPppnOwBca93KfwrOU1gh2Bqmr4SRvd044JdzTk=;
        b=Z5chd6cfl0Yf0Pp21PG/gOj0c4UezFIbS2VXYGpt9AS37yCfLgJTh1RHgOUgbmVajY
         F9reYZ9JZmknz2kkQw1iIRxSQeW6GmbqbEusIhs32Wskyxxij4LOu+AN/NWiFS/shJD9
         /oFaM9P0ko6+U01X8rakGf/RTRNSD/jQRtS+8J+XvHQqNZiKIBYHViGgUEYXIwzPI80Y
         W6N21hwakMNzdNGdFj9BpNH4VTDtXs1HgkA6aqUBzqNUh6f1/s8bWnVBtNKCcxD82HX6
         EhHTPlmSKH+GhWDpLk9ls0kItDt3yrrC6B/ui7XvNe7u9jj40VPVpbrWmvUQk356UEQd
         uUWw==
X-Forwarded-Encrypted: i=1; AFNElJ+c3i9rniLQhlmv6LxbYUiT+CCrMuG18dcy7nTJmT4Q3IZdlvZZAguVB7YQ+9UtInQfwvicxWz0f1GINWg9x/f9@vger.kernel.org
X-Gm-Message-State: AOJu0YxwqA4i6v7cXk+GIJG6sgClE4rlonYOA7NHO0Zg2bxGpAM3UyWV
	1D/0Iz0R+n7RtjrxVwfrRWpUyM0dnKdGdqvmUusPHYny5I4wKMgbb3QqQBrVh69RHxK/Qfhw7A5
	6WjyLCiifWw==
X-Received: from dycai17.prod.google.com ([2002:a05:7300:fb11:b0:2d9:3459:1de6])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:214e:b0:2c4:dd55:ffc1
 with SMTP id 5a478bee46e88-2e464ea4fffmr19490662eec.2.1777157137979; Sat, 25
 Apr 2026 15:45:37 -0700 (PDT)
Date: Sat, 25 Apr 2026 15:45:02 -0700
In-Reply-To: <20260425224503.170337-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260425174858.3922152-1-irogers@google.com> <20260425224503.170337-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260425224503.170337-16-irogers@google.com>
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

