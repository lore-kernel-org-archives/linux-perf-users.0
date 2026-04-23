Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD14C39B49A
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 16:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776960731; cv=none; b=peYDNiEBQAsiCpVuhPleDM0JdUZ68ygSPDtUFPTpI4qMcdNyz6QQyd0FnndMYJZdjQ522D2REP3r1jkPgkrNIGmYcQ//Rb9BdVVwzl5n/w2R+rcuMNwuwlcFllYVW1OKH6AwCNl7UsAyDdwA7vZdxbHb7O9ThYf9KqzDdQgDovI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776960731; c=relaxed/simple;
	bh=ixIpiyAQEh86HVyHEgijaz614XhC5iAorfHlz5ePDqQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ada1+Z6chr32pfRZw4t4oQ7xcdGbUH5A5rgrJbNFQp3X2pGQ5mvZWUnKkkCeRQr8beRRa6g9cvbSxobg9Cums60LFCidoJ4oJsPEFmjW4moUfVPHzDHJXc2/5gP0yClqSL9OcFvUdCpLxvkvQ0SRJ9IFUUjaFZTUxD9S3WDKwng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kRXfE8Xv; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kRXfE8Xv"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2ba8013a9e3so7366056eec.0
        for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 09:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776960729; x=1777565529; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=viPumMBuDTQWvprQTsdXT5x1SbwZUO7Fc0Q0wpaXm6g=;
        b=kRXfE8Xv06/Npr+4jLL1ulJ2R96TdHRSFuBz27eNVTvw6q5cjC22U4Zr9doux7WERk
         b4yyKNbgNfwkDLlmZ75iYKHiCB81J95oWAtNoHF+KN3kGDsvxia1513yPCF9xJ8pKs6D
         FkYanozY5nct2VTnBJSr9L4LK5Cavrdnt9gAHojX3z/MkrBJPth3wALOHyG/jAOeLI/t
         Og+LFdQrOFkJCNoexrb8iMGLWaXsaw3/Sukf2wcQGOFxDU8IsFnfrG+S9uBt2BIKe8WB
         gqEx1vicXywrTWN0sWF1tI1jL93O5lvjfhw0q10BL5mcWM+VFVUHOm1jRv2qyylObrpj
         XW5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776960729; x=1777565529;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=viPumMBuDTQWvprQTsdXT5x1SbwZUO7Fc0Q0wpaXm6g=;
        b=E41KnruXmIr7Xq+1H+u+yQmQ+ZKPQeb7ugVzYWu+GIgVR0ULej3nRQjGwuXOsMNNhd
         kGX3lX+ez+/i4lLumSm4cUvM2rJ2R7rag9bhYYRp6tr7FaQVwC19lkOY1tMRcWgAQdDk
         DzLQMX/pLzrY8mPtmNiA5YKWj+x/vG11pgPjlDtpiO+rlOhGpzp65gTwVI515R+eUfzP
         vTGIM6RpvWLzNiC+dbwsVyecyRyZP3onbNqnPd+CuSvMaBmbtE1OYN61a/kPthF+mAuy
         D4BMnXa52VZO/SUuX0MYiUYWPQxcaqc+8Any45hM3MPEPz/CcmbY9J2ZwvOkzZF9848s
         oDxw==
X-Forwarded-Encrypted: i=1; AFNElJ9V4xG8wls93Ul/iZ9PSidQpBnw+bvtYQ39hmSOjMjuMS+S1iNxIWsDuFo8APDQOAxZumA7hSXjEyYfKggnlAcq@vger.kernel.org
X-Gm-Message-State: AOJu0YzTDqk7vFUHwC85vRWeohZIPtfrD3ApKKb6AO2NbJiQPoYFygld
	sFd56lwZeli8ryBUb1EQi95ZLGDbm8x/s2UTn3LPVw12Cv6ijsJ+0OD1NvriWzvdVIhatKcfhlS
	UPjU3LyogBA==
X-Received: from dyblz34.prod.google.com ([2002:a05:7301:1622:b0:2e6:f22b:f849])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:2c0f:b0:2d3:4252:b127
 with SMTP id 5a478bee46e88-2e479017537mr14691983eec.26.1776960728452; Thu, 23
 Apr 2026 09:12:08 -0700 (PDT)
Date: Thu, 23 Apr 2026 09:10:04 -0700
In-Reply-To: <20260423161006.1762700-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260423035526.1537178-1-irogers@google.com> <20260423161006.1762700-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.rc2.533.g4f5dca5207-goog
Message-ID: <20260423161006.1762700-58-irogers@google.com>
Subject: [PATCH v3 57/58] perf python: Improve perf script -l descriptions
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

