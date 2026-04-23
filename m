Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D2E3D5238
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 03:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776916668; cv=none; b=oRI1gfcwr2FhDZ1/P9jgWQvDpc3qkze4gdQXY2c360VbQZDjp5xggl1sD8aRJU/+4As/RZYyxn4igFb4R6aJddPXDw7uB8h2MN7QmzRzupxC5jtpc4akt/+P0SRqk9JTn+LR2StXuIp6xTH3bYNByYqvi8Bp9NRDtPG2cOVF8cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776916668; c=relaxed/simple;
	bh=ixIpiyAQEh86HVyHEgijaz614XhC5iAorfHlz5ePDqQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sI/Hef3YisVgtlgYXa9IEUxfOGHFUeAWgazC5t2j0QI77mUpFmp20oqE12kRysM7McXLzNBo6OgGI+PPGINobVPGSUHcrYXIaRQ0VyGz22k8A0afVYB2k603OX+w9CNiQZGmQW5vczP3knpNE+EzZeZ+w/cRjlryxP/FK5Sv64s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lkXJgGRE; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lkXJgGRE"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-12c8de02a4dso7489253c88.1
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Apr 2026 20:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776916665; x=1777521465; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=viPumMBuDTQWvprQTsdXT5x1SbwZUO7Fc0Q0wpaXm6g=;
        b=lkXJgGREc4f0R/yySXfx4xH6fpKyhH3o5oaHcSsNSgfod+WNq6D6aS1JcuFDGmB7y4
         E4IgXGxhz6+BIGbnyaem7Q9D2T5hiQyP6n2BQ2IT26dMPlFDtHoD1/k6kP7sladSN6xD
         GVskwAd1HEOH1ZUi7JTw+iNuywVbRyCbdBEJ5R8hf+quqMvlFWbaZ4p/S8XsN8gqKUWi
         rY56FaS++l0Vy9o/HlicLb5QkPg64BOaH96lxTEP9dLbxkSqCEcUgRqKp1VpAu+53Hrn
         GujCz2RrnaReAEyxaAKYGkXYy8enhw2KhEV703NDC7iRaSTybVACpHbVI244GfpK9Z6s
         qToA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776916665; x=1777521465;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=viPumMBuDTQWvprQTsdXT5x1SbwZUO7Fc0Q0wpaXm6g=;
        b=KRi7vwIkdl9zBxPWIPuxZG6WJ/F4LwWG3hyC7f5YM/H0lFVk6Iah0g2NKxyR7+f4L0
         OAjbyrgKmpYS4vMEq69vAUVzCBtCVmP/azbIYtFp9NFOkIFSZJj1v7XGBXLalHPbuDTm
         I9WPzDYryrLt1lkFxkkKWaEUOXz3iVtA/wEJtrR/Jhj7R76OpotkI+mAuLYfbzcyRYmc
         zU6rx2sstMjUZwLnNZ7UQXFmsHuw6hcl5t7OJ7E9Lv47olrUdzmhTeUk9aL6clirS2ho
         SoJTX/uywqOsd9K7GydWIusHADFuWgYJW2EOHTNSCaGsZHQ8KkQPxshxo671faOzg/W0
         OA6g==
X-Forwarded-Encrypted: i=1; AFNElJ/kIFfOK1Y0MhQnQhhyGDWHNd/fRgIA5vU+QXIeY2uw0YPq3+x1ugKj9H5ZSA1Dbbx1bJIv6mIR6uEouC8WFtna@vger.kernel.org
X-Gm-Message-State: AOJu0YwhhX6IKaPDUgSjBvaKcJprE1Im0IWNNe5N0V5sr9BhFwAQep6/
	vnVtnQuu3KCYjBynFPdZxFD4XlRbQQkPzWVzIjvu+Mxcxp9IXjn7HQCvxsZfuBE41K3GCLJSv6f
	QMzErHq+jGA==
X-Received: from dlbrh5.prod.google.com ([2002:a05:7022:f305:b0:12c:4c5f:243d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:103:b0:128:cf86:d1cb
 with SMTP id a92af1059eb24-12c73fae206mr14081949c88.31.1776916664971; Wed, 22
 Apr 2026 20:57:44 -0700 (PDT)
Date: Wed, 22 Apr 2026 20:55:25 -0700
In-Reply-To: <20260423035526.1537178-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260419235911.2186050-27-irogers@google.com> <20260423035526.1537178-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.rc2.533.g4f5dca5207-goog
Message-ID: <20260423035526.1537178-59-irogers@google.com>
Subject: [PATCH v2 58/58] perf python: Improve perf script -l descriptions
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, adrian.hunter@intel.com, 
	james.clark@linaro.org, leo.yan@linux.dev, namhyung@kernel.org, 
	tmricht@linux.ibm.com
Cc: 9erthalion6@gmail.com, adityab1@linux.ibm.com, 
	alexandre.chartre@oracle.com, alice.mei.rogers@gmail.com, 
	ankur.a.arora@oracle.com, ashelat@redhat.com, atrajeev@linux.ibm.com, 
	blakejones@google.com, changbin.du@huawei.com, chuck.lever@oracle.com, 
	collin.funk1@gmail.com, coresight@lists.linaro.org, ctshao@google.com, 
	dapeng1.mi@linux.intel.com, derek.foreman@collabora.com, dsterba@suse.com, 
	gautam@linux.ibm.com, howardchu95@gmail.com, john.g.garry@oracle.com, 
	jolsa@kernel.org, jonathan.cameron@huawei.com, justinstitt@google.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mike.leach@arm.com, mingo@redhat.com, 
	morbo@google.com, nathan@kernel.org, nichen@iscas.ac.cn, 
	nick.desaulniers+lkml@gmail.com, pan.deng@intel.com, peterz@infradead.org, 
	ravi.bangoria@amd.com, ricky.ringler@proton.me, stephen.s.brennan@oracle.com, 
	sun.jian.kdev@gmail.com, suzuki.poulose@arm.com, swapnil.sapkal@amd.com, 
	tanze@kylinos.cn, terrelln@fb.com, thomas.falcon@intel.com, 
	tianyou.li@intel.com, tycho@kernel.org, wangyang.guo@intel.com, 
	xiaqinxin@huawei.com, yang.lee@linux.alibaba.com, yuzhuo@google.com, 
	zhiguo.zhou@intel.com, zli94@ncsu.edu
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
2.54.0.rc2.533.g4f5dca5207-goog

