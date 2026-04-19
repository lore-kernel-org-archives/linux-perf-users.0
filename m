Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018CA32AADC
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Apr 2026 00:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776643298; cv=none; b=h4QIZZJPUnfUfYZX0ZvmVM+GUHRE1rF2Pf0mcvV7pEH8tCQ1JOcKxTVEcwm4SL08NIon50dFr65rVakDosuzBOcxM0CYXUYuyNxcdxNS0KaDnEmmxW4ZP3ZYFtxiL3fpiW68sdiG8zZSjw1APe462vrKQKtb1uMnNSxCR10CdTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776643298; c=relaxed/simple;
	bh=Z2rNaUAijo0tYzu21S4eAIIWN1JSi/04Zc5fOvPcmlA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rTuqxTHxGQ0tHdvP2mjRYMmcGkRY0ceNHRB6WxTMoAjSkvRzJ3vQoE2ljHyfmntwDXk9LbHQSTWvrQ7THh3tjmbU4UbHXPxPLk9NpFm7HM3QavLm2KhvmCIeOYz4ISFtT6JSI97ocSdzghhyEC56KqNq7jy4Y3Js9z3Z4pumfM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WugCBPXs; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WugCBPXs"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2d93379001eso820581eec.1
        for <linux-perf-users@vger.kernel.org>; Sun, 19 Apr 2026 17:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776643296; x=1777248096; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pyuJ3cVp7+aTEtaDxTm9nPiOrMZM1BQUNTKgwP6033Y=;
        b=WugCBPXsRMAUBJ/M0BmWx9o53awvanQJS+BKFh9OQezLVjo6GS+H+4mAIcoSTv9Ylu
         mAN+9HLWy5xUZDNt5QLjmszZPXFEAzjd+7ksb+0RZqgw0+s9VRaLGB+pyoABYPq02Iu1
         Jp1klGNpZ+OK6N6j0toi9w9R/qxNTEyUbTwx6c9sRbH5U4yp9q3TYkboHmRjIPGiV56N
         Ces59jX8ruglQOAM81jsVQ8tq1QJAhxmMx0riR/45NJDzoUYkFA/x8kfzHEIEmmhA3jz
         3APOmIAIXy2qgaqzZFfFRbEo1aU+7nhAL/EUF9K6xdEWHKOwZ2n6oBGHVe2XTdCKW5Ji
         kN2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776643296; x=1777248096;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pyuJ3cVp7+aTEtaDxTm9nPiOrMZM1BQUNTKgwP6033Y=;
        b=kKD2V5R6fdOdZxrKy5ILzQbfxSSDvI+Hq0kgE9+joxekr6iGg7KSXEq9Nag4fUr4NF
         z4qD/E1ZvVEDqaKwiq8kBLzIBgmqhL2UuQ86wHygL+UVFB63vaL5Tnruk7Elq9tqHLRg
         1hewV8w3+BibiVhA+JKpX5Jr5UblZb1I3uMkVc3pQK9gMnHXMl8O9KXPdqIyWfiO8BwD
         RMbhXPcE9DO/B4H8YfoM5U45+Mdoxue9SW/eXNp11YsOsCTIXghBP477kD1rbRMX2KDD
         0/U7R+g4vFcQP8HlcSW6LVjY9XSbC1yT0WCm5W43E/VHioPbqDVie7mQYYLorBBfe6+p
         nucg==
X-Forwarded-Encrypted: i=1; AFNElJ++MmsIwwRivfgXsYUO/Hfms75hKIx8nFNA2Ctrj+NrGUxbJTZYrXnRs+MLudAQGXH/3JrkvVH3LYborxWAvxUQ@vger.kernel.org
X-Gm-Message-State: AOJu0YwogGP+ZCrgVP7U7BwSTNghXMMgPcU3GkgVbD83947XXyPt9voT
	I9nO2/DipEg45CCMZws7lkpnFp3YTeZkNRyfuej+kTcKwRPOIjMnHSLF4yiK1tmgjDQuhhovAwa
	45nm4vO8YXQ==
X-Received: from dybeb10.prod.google.com ([2002:a05:7300:a2ca:b0:2d5:d26c:d4bc])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:310b:b0:2c7:ea98:d94
 with SMTP id 5a478bee46e88-2e464ea8a4cmr5006163eec.2.1776643294235; Sun, 19
 Apr 2026 17:01:34 -0700 (PDT)
Date: Sun, 19 Apr 2026 16:59:10 -0700
In-Reply-To: <20260419235911.2186050-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260419235911.2186050-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.rc1.513.gad8abe7a5a-goog
Message-ID: <20260419235911.2186050-59-irogers@google.com>
Subject: [PATCH v1 58/58] perf python: Improve perf script -l descriptions
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Alice Rogers <alice.mei.rogers@gmail.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Mike Leach <mike.leach@arm.com>, John Garry <john.g.garry@oracle.com>, 
	Leo Yan <leo.yan@linux.dev>, Yicong Yang <yangyicong@hisilicon.com>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Nick Terrell <terrelln@fb.com>, 
	David Sterba <dsterba@suse.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Alexandre Chartre <alexandre.chartre@oracle.com>, 
	Dmitrii Dolgov <9erthalion6@gmail.com>, Yuzhuo Jing <yuzhuo@google.com>, 
	Blake Jones <blakejones@google.com>, Changbin Du <changbin.du@huawei.com>, 
	Gautam Menghani <gautam@linux.ibm.com>, Wangyang Guo <wangyang.guo@intel.com>, 
	Pan Deng <pan.deng@intel.com>, Zhiguo Zhou <zhiguo.zhou@intel.com>, 
	Tianyou Li <tianyou.li@intel.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, Collin Funk <collin.funk1@gmail.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Zecheng Li <zli94@ncsu.edu>, tanze <tanze@kylinos.cn>, 
	Thomas Richter <tmricht@linux.ibm.com>, Ankur Arora <ankur.a.arora@oracle.com>, 
	"Tycho Andersen (AMD)" <tycho@kernel.org>, Howard Chu <howardchu95@gmail.com>, 
	Sun Jian <sun.jian.kdev@gmail.com>, Derek Foreman <derek.foreman@collabora.com>, 
	Swapnil Sapkal <swapnil.sapkal@amd.com>, Anubhav Shelat <ashelat@redhat.com>, 
	Ricky Ringler <ricky.ringler@proton.me>, Qinxin Xia <xiaqinxin@huawei.com>, 
	Aditya Bodkhe <adityab1@linux.ibm.com>, Chun-Tse Shao <ctshao@google.com>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, Yang Li <yang.lee@linux.alibaba.com>, 
	Chuck Lever <chuck.lever@oracle.com>, Chen Ni <nichen@iscas.ac.cn>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org
Cc: Ian Rogers <irogers@google.com>
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
index e0b2e7268ef6..6cb3101d0d3e 100755
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
2.54.0.rc1.513.gad8abe7a5a-goog

