Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D593CD8CA
	for <linux-perf-users@vger.kernel.org>; Tue, 28 Apr 2026 07:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777360877; cv=none; b=X5XufgBHJaTrzr2sw+8qTntoD8pkQD/w0frmnfH43ZSAMfS+fHc+2lpyNE5zLQAmK3lbaSy/H7gNRtOgkUOcP6q0NigRJscWGjPPrHti01zKUgPdq09ygGAInHKhRafCgIKPwIxzPuT/V5RPws5RABGv54EuOv7IljGTtIlINDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777360877; c=relaxed/simple;
	bh=69fXFPVzN5elAVO1zZMw/xvGFsOIcH51j5L0belO4IE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JUHd7i2UZcwMKDfkaF/OsTxchlZFgn7/hFHulEnBWxeanA4NZVZOhxe0AZ/IF2NJlxaDbddDroVb7+Eypx7dyKUMVXSBEKenT3H+B5IukgfK2GFVGe1j/81ycP+rtaGdZ8gIM1oP/lKTwlGNz+/KXWCq1Ry5YobmjmhyJdwDKp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iAVXa5na; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iAVXa5na"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2b2eba42b8dso99469295ad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 28 Apr 2026 00:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777360875; x=1777965675; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=l4V5NPppnOwBca93KfwrOU1gh2Bqmr4SRvd044JdzTk=;
        b=iAVXa5naS7yTAq5uTb5RgB05HMNhVsgLF+C8BRvO138aS443WIlfpVSiBaZHNU9tsB
         oo4sV7b7vwoKD0ZxjOIw30enNv/VvjApCZ5QhK6FjWRYZhpr+69fcxbHyeDMnzZnEeEe
         aZBMP5simdP5Rz8sufW9BHttwS8Ek8ZYnZwDdsNUaKeQinQdyExxeoWsVrZKVL93te3y
         MmfhO5jHCP4bZv4kpgwRq5npB9727ScnloC1hiEnKx3KV6MvWgEl3WoJejOcybxVfkf6
         EsdlFFyfYHdnMISTONnYTYt82075FA4MRl5jw1BLZQtIQYdIEkfJBeTy7OrAPiQQ3uGo
         sMIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777360875; x=1777965675;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l4V5NPppnOwBca93KfwrOU1gh2Bqmr4SRvd044JdzTk=;
        b=qW9DavtPBhXK32dQbDawRDIPLyt6j68y6WItJ3r4PehT8Jpy/s7KMv3NXpLDBOr2ck
         asTye3EBSyYbA6jDanXB/CqRQA6OyjprPpR9xw6hqNOKJpuMxNJ5m6mxIT/SUEn3zZcu
         HtLbukrCKpThXoZbFV5pqGIxjMxZByWMcCPB9DTHYtIA5jri2jlyJeDkbJjmQHDGknCA
         K5GS1K3PSRd0nFTRz06ndVN7yxheOOYHwW7vgw6cVcHFieGMro4kQHNTYTF6dq7LmXUC
         pES2dL4K/o8/X4cMs8QwgUwMPFT6AYtgc7oafDq55dkxXOU8uf/dddwwMYNIP8TaLJnn
         qH3Q==
X-Forwarded-Encrypted: i=1; AFNElJ8a66LVTrj+CwLml06iyEuaJq/A8n5uhjKFFmlqlZwp+i/XSaYRLKTRHYwIaRwhdgNdSyaStDGzLOCHvRP0tq7u@vger.kernel.org
X-Gm-Message-State: AOJu0YwM5RiS6vZeQLaYXX2tamxT0VF1pgP6+Y9WLZOmsDCGcLCqq5V7
	Llk/H728oXFOwIpGu9m+oTT/HTawHpm2GA7G1eavtKCYmr5egutRwl/y8Fafc8sSN7XCnAk02z4
	evGX9sMNBQg==
X-Received: from plbaz10.prod.google.com ([2002:a17:902:a58a:b0:2b0:6314:419b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f54e:b0:2b0:ac1e:9737
 with SMTP id d9443c01a7336-2b97c40025dmr20426165ad.12.1777360874920; Tue, 28
 Apr 2026 00:21:14 -0700 (PDT)
Date: Tue, 28 Apr 2026 00:19:03 -0700
In-Reply-To: <20260428071903.1886173-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260425224951.174663-1-irogers@google.com> <20260428071903.1886173-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260428071903.1886173-59-irogers@google.com>
Subject: [PATCH v8 58/58] perf python: Improve perf script -l descriptions
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, alice.mei.rogers@gmail.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org, leo.yan@linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	tmricht@linux.ibm.com, Ian Rogers <irogers@google.com>
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

