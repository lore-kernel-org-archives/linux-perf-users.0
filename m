Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D07C3D5257
	for <linux-perf-users@vger.kernel.org>; Sun, 20 Sep 2026 05:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789881781; cv=none; b=ZitrC5SPi/nVvYwGUszJP9516aBnv57Qgxria9nhQfNw+gEqVuza1uY8NgbQi2VP8xk30K2WPznBoQKn3WwR+ImBrAB2LZ2KF2oMyO2X/XpFPVyUNeByYAMzpACviK6bBC8u9f1NYXH9ESDvN6nAT/F370RzqLlcFPqJFNchzDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789881781; c=relaxed/simple;
	bh=I+/F6Lf272wJ/FSJ8JJf6FA0fzMKbbtKGOoiTg12V5M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UYYDZnr/qITIifsYyOM2h2OFSmqLVVONcIUMUAkRVmK/D+n2XHbgle18jQCwbqsU1ZLk7eQAr00zLVPSi+iIAfne4FaxNQHNeEJEQoawyFGiw0pBBBWDk3JFkc3xs1p68cILzNXIuiJAxDUWY7aqBaF4PBqcoIYp/ejc6eQHbhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MZRDdgvV; arc=none smtp.client-ip=209.85.215.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MZRDdgvV"
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c89704da8c7so2609854a12.0
        for <linux-perf-users@vger.kernel.org>; Sat, 19 Sep 2026 22:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789881770; x=1790486570; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CsSfIgYZYlBwQ/QFRNukihIBFvet4HE3Ok6+/k+W1p0=;
        b=MZRDdgvVyev3Onpolp8gXqXo83GCqT0OwtbWRlK8qot2QJhD9II1Qvp9bJJFl0eVNU
         q/rVeC68pM7JmF1YaaI6jhdJ/y2NU354RSzAtZQ6oQIwXmXTx/o9enxu2i2GSdOKW3Iu
         /z/ku9LeaTgS9vqFFlDOdnZcMDMX/Z2/VwjhjqXMrkWNvunkwJ/fQJhQIkna3Z3o+4FC
         0Y6/GNwLOmzKwIJmPfVtoqCAbw4C1jZrJAmbEN9vy4vZozPEQtLSUPYuOIazF2xtgJiK
         J8Sl5VjgL/rOJu58aQlmlfTZtFqf1Sds1+/vKSklO93tzVTOii8aq6RY8wlKlfRm2jBy
         OpVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789881770; x=1790486570;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CsSfIgYZYlBwQ/QFRNukihIBFvet4HE3Ok6+/k+W1p0=;
        b=Jsr9+gYm3Si+U/MNhZLONqehuLzeEI6Czo9Pe/0z0Nzo6bPKW7q5QP/2ah0O7GOtwp
         Wb34ya0/zb+keisiJQ7KsODkOJ7V+DhP4/MMLfwyLbOFjDb97foKEvdAy9uQm2hoqas4
         DFsQpSpwy5Wo1SZ6zb4ONehXB74N3HgeQs2uDWaXovjkfa0kUK9vmJ5h/7VsxRVvvXuD
         hzHHvi+VQV31bzcL1DN6q22U6BGvnDXcJADman1Efknzis+hQnGgkWlD6kS5NrGnPlXw
         sy/rfMZn0iGoX6mYWyWzjQy5YGgLuEgDL3mr7FZrqgnKvUlhX18WU3DBqQRQoyO8B0vW
         BHWA==
X-Forwarded-Encrypted: i=1; AKwUvBzgVGHKFoZbpU6MEYK/uWr7WE8vSvQ+2PztQPbv0SAk0vStJhVqS3oD4ziZIg6ojhFKvjsuUoTP9v/YiA+VJV2l@vger.kernel.org
X-Gm-Message-State: AFuF++nKvyEL5R0pRyMT/hWso5LnLLoJ2SVUCHRiE/GUvynTQg6NI8/U
	K/7r3n3YHC1HCyHt2OGFLF7lPzR/f5H+Gieh+amjuP6El1Nv6wBb04FJrv4Lt1cV7q4wM5dOWhC
	RkC1h3WO6pQ==
X-Received: from dled9-n1.prod.google.com ([2002:a05:701b:42c9:10b0:143:8a67:84b5])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:9185:b0:3dd:a196:5394
 with SMTP id adf61e73a8af0-3dda196544dmr5536802637.54.1789881770336; Sat, 19
 Sep 2026 22:22:50 -0700 (PDT)
Date: Sat, 19 Sep 2026 22:20:59 -0700
In-Reply-To: <cover.1789880842.git.irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1789880842.git.irogers@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <03a0ba15a5d53b66d6ec2202ceb5d422e3e9432c.1789880842.git.irogers@google.com>
Subject: [PATCH v1 07/49] perf python: Improve perf script -l descriptions
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, adrian.hunter@intel.com, 
	alice.mei.rogers@gmail.com, james.clark@linaro.org, 
	linux-perf-users@vger.kernel.org, namhyung@kernel.org
Cc: dapeng1.mi@linux.intel.com, leo.yan@linux.dev, 
	linux-kernel@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Add module docstrings to counting.py, tracepoint.py, and twatch.py so
that 'perf script -l' displays concise descriptions for all available
standalone scripts:

```
$ perf script -l
List of available scripts:
...
  counting
    Example for counting perf events.
...
  tracepoint
    Example showing how to enable a tracepoint and access its fields.
  twatch
    Example to show how to enable a software event and track
    context switches.
...
```

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/python/counting.py   | 1 +
 tools/perf/python/tracepoint.py | 1 +
 tools/perf/python/twatch.py     | 1 +
 3 files changed, 3 insertions(+)

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
 
diff --git a/tools/perf/python/tracepoint.py b/tools/perf/python/tracepoint.py
index 9d49a25b3b1e..faa5311b8418 100755
--- a/tools/perf/python/tracepoint.py
+++ b/tools/perf/python/tracepoint.py
@@ -1,5 +1,6 @@
 #! /usr/bin/env python
 # SPDX-License-Identifier: GPL-2.0
+"""Example showing how to enable a tracepoint and access its fields."""
 # -*- python -*-
 # -*- coding: utf-8 -*-
 
diff --git a/tools/perf/python/twatch.py b/tools/perf/python/twatch.py
index ad35b1620781..b0f1bf113162 100755
--- a/tools/perf/python/twatch.py
+++ b/tools/perf/python/twatch.py
@@ -1,5 +1,6 @@
 #! /usr/bin/env python
 # SPDX-License-Identifier: GPL-2.0-only
+"""Example to show how to enable a software event and track context switches."""
 # -*- python -*-
 # -*- coding: utf-8 -*-
 #   twatch - Experimental use of the perf python interface
-- 
2.55.0.1082.g2b9226bbc0-goog

