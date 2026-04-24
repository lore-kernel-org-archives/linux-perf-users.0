Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76DF3E717C
	for <linux-perf-users@vger.kernel.org>; Fri, 24 Apr 2026 16:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777049389; cv=none; b=iuqXjllOoO622Gi2N26x6iEHdWkXBJUMOWclZ/Ac17Yxzhe0Kl+V5nS5KJlcI+LcjzmJ/D1HszTmsJft/HWVXVeGoIqVV5CyMZ3V684HZZy8LiGJeSRhyGtZVkTLE1I693VCrpO77xv4H8p6T+5/MRKK6bXAv8xb85avuJvyM9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777049389; c=relaxed/simple;
	bh=69fXFPVzN5elAVO1zZMw/xvGFsOIcH51j5L0belO4IE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bk4W622XUtPx0PyGDsWj94Zw0hvyfqwzIwXZgUHqgjzp5NYxd14t1dhkbq8T2Qb08n3wITdS1ZcA9U0L5hR46KhDyXApa1X+mlLdaJX3UU67X90vtg2XbFVSzqs8qgXSleWlD6FQ3hAuRYIVEnJFXAleUsJyHPqYLLzxekqVrng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WmrYlphu; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WmrYlphu"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2dd6fb4c867so12069215eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 24 Apr 2026 09:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777049387; x=1777654187; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=l4V5NPppnOwBca93KfwrOU1gh2Bqmr4SRvd044JdzTk=;
        b=WmrYlphut9M056+pc/slvsTXLY4KYpuMfL4F6v9RXzA/o7mBqTjnoNy5GgQZ6OedMB
         S/tnXd5tbB7+U01yks5kL5GZVPNyaAjaOjqwtIdzvjiug+l0FvFyvd//93Tz545p39mA
         FRMbnXwzcV2VjQyWQQrvgrQyLwmUa70VQ6cNz2fuZWSyzmbYVZL/83CDN8wzZQpJaQOZ
         0NlU8I2yPB6VF4GjUa1HyrjPs47g8QCGEB0X/Ek2eAQgrP4BCDvL3VZasv5p9rFqjlRe
         uXAH1iCHwrDFQD2FFdFTQts4f/HjB7vBF6gkrWgNiaCfkHaMAdgGBaSBy0fL9JCCyEQD
         HIgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777049387; x=1777654187;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l4V5NPppnOwBca93KfwrOU1gh2Bqmr4SRvd044JdzTk=;
        b=Y/3wYvb9eJbceRCGEmY9Xu5MVE4TsH4IxwzsFGEEJCS2dywCuCxKi32gCAjrfEcmso
         O851o09tGyvt2BWEO1hMFiOJGhhT+GGndJl3a4dBfUe1A0yfSPaN0CH9uenB3DH0fapD
         oReAnGeV88/Mgbv2o3EV9/r3UzXcNdh/HKOTsKUMsJ1cqZSIy5W8SBLVkXZBQbxBzjdw
         Kuas2yDDHcXdgnmSVMgBTFJg6hRJSTrMxjyw71DoSnQo9f2NoiOAbOwSVpXkjsPzunWb
         SZBhPk1eD8DI254hNC4TnVyXRwwwGonfbF7EXi8JyM+RVRb5Q/RB5hSNbAI1Mv1fW3GV
         X3yg==
X-Forwarded-Encrypted: i=1; AFNElJ/79FUaSBwUwpR3CQ0ChGsmdruqFr+sevqzFbuL+5T2oY2DSI222yRaSBTGeOJx6XSTh6m+6rdvdceV9kwJPdkN@vger.kernel.org
X-Gm-Message-State: AOJu0YwMLLrdMyBz0BEBkI+VBhj9jxOsTzyDG3+4Pd9whLRMALs0jfGA
	VXvh/2QyWQn8wQQcVcya+5I5RAksxjqMdlhNT9AY+A/1M80dqzfHZb4BA7g2bZVyyG924hEIWIz
	ywxtE/jyXNg==
X-Received: from dycnr11-n1.prod.google.com ([2002:a05:7300:e9cb:10b0:2e5:fa99:f6e4])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:f193:b0:2df:5715:82be
 with SMTP id 5a478bee46e88-2e466044880mr17000479eec.2.1777049386687; Fri, 24
 Apr 2026 09:49:46 -0700 (PDT)
Date: Fri, 24 Apr 2026 09:47:20 -0700
In-Reply-To: <20260424164721.2229025-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260423163406.1779809-1-irogers@google.com> <20260424164721.2229025-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260424164721.2229025-59-irogers@google.com>
Subject: [PATCH v5 58/58] perf python: Improve perf script -l descriptions
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

