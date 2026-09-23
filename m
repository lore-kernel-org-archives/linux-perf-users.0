Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43096496D49
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 18:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790187185; cv=none; b=AQHSfssomgQf6sBwqaeAMq5c1OjOFF486EKsDg6IgnCbZo0Zlc6y39mdO9RSZ7u3ZUC2JhBudq4uVyxVFsZEePxYzOdcNgN80IRZej3k4dqh91+qw0pRnUmf57l+Y5kOaxeUlPDqXLT8KJsEoDqEoYRiZVPRAeE1aXISZ11h8KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790187185; c=relaxed/simple;
	bh=Nn88fZFShXx5JVerGrjugPmKxeDP+fqMvhrMzHOf10U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uZ90xj3njKg7+WPnJg0aj/invBEnpxpUOXeRo0dT+qMPn3rb/O96o0jFLLAoahNy5EPbJHGTaz+hiHV/O7ce6aAX/dmVQC0+hQd2KRRzSVItFPOjgzI7I0HPz93T4d4RdS6RZYCWyOqgy627F5ghLZGAGjxwo9/VvHq4Kxis1Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ik9O6FA5; arc=none smtp.client-ip=74.125.82.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ik9O6FA5"
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-313d1015161so253716eec.1
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 11:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790187179; x=1790791979; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IuxfrqxTwwBqV3BAkBSM2g9sz6L6oZXb2glj2NAemZw=;
        b=Ik9O6FA5m/3+waIz+2zQJRv4fusRrEkIdGJ9D27O36/3LJA5J4xAJQcsIvYqxlsEPu
         p2rIdKjn7STc5NueDVYmjjkC2a5O15jusrqKCMYYhEtRiKkx812A18MHSQpG7VGu5GNz
         BhEWx5+iL0fZF3M/MmfkePi9xobozht50WCey6YINyZFhv6MFhx1ljLF6SPi0Vcewd7q
         V5UvK3/AmsQSPzNfC36Di8tq1KmGzPCsBpBRUT+DkdJehwahNiao35DTX711EFThIXvt
         D7hApCHcwZxCjd1f9Tf995BBBhpN6wTio1k4+LWAd73tJlneWmKUP8oYYeOVqshBEi8u
         n3nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790187179; x=1790791979;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IuxfrqxTwwBqV3BAkBSM2g9sz6L6oZXb2glj2NAemZw=;
        b=e0dwwGQY+m8tRTrdIwz+lRw8DsoEWmuMv8+ldSkFqxxRHbc+YXbmwWql/bewSRmjuh
         wF4m1JVgvtJwLbYaJTq45oB+vYorQsuZ7hsSCEufTDSispGaNorckr9PwEVeu9YUNHlP
         9x9vmWFwKrMo45EYhXiO5IhzumjTmCDj1Bu/X65gf8z25tNzb9FVcr/Xww8o2JMB8iLi
         Wd44NhzGxEq8RnSUlxvOvOSgTpf7pfePjY7ozvHnZ3403rai2nccXBY2ozM/iV7YOxdQ
         8jY6CyLbIyP3yjUtQ2IH+ZWZcD/lG0ANrPnChF4LdqnY2MH42W8jrmljsCCCQ+fMWjUv
         oYSQ==
X-Forwarded-Encrypted: i=1; AKwUvByguD5AMYpA/PYlvXcY4of7ib4PD7hUbAjin8he1VY1Fg9IhZ3lh1jAYiFG7q6yEszqOdsnsvCCnS2rNF+Hdu5w@vger.kernel.org
X-Gm-Message-State: AFuF++m1pUp/Axz51kRlaH1+/QuhlfKuEdiMlWmI/kh8IHbH6CypFBWU
	IVlHi2MFXlcPEbMP84ygLs4I76XN4BJGefjLgpFJpZlx5kyioyV7Xef/71gH2fpfya32iOpPVtK
	RGCqKVGn8uA==
X-Received: from dycnl8.prod.google.com ([2002:a05:7300:d108:b0:33b:f23f:e95e])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:e3b5:b0:33b:fe7b:460e
 with SMTP id 5a478bee46e88-33e8bc75a7amr2865160eec.7.1790187178811; Wed, 23
 Sep 2026 11:12:58 -0700 (PDT)
Date: Wed, 23 Sep 2026 11:11:30 -0700
In-Reply-To: <20260923181213.3032038-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1789966896.git.irogers@google.com> <20260923181213.3032038-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.310.g51773c2048-goog
Message-ID: <20260923181213.3032038-8-irogers@google.com>
Subject: [PATCH v3 07/49] perf python: Improve perf script -l descriptions
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, alice.mei.rogers@gmail.com, 
	namhyung@kernel.org
Cc: adrian.hunter@intel.com, dapeng1.mi@linux.intel.com, 
	james.clark@linaro.org, leo.yan@linux.dev, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Add module docstrings to counting.py, tracepoint.py, and twatch.py. This
satisfies pylint's missing-module-docstring check and prepares these
existing standalone scripts in tools/perf/python/ for the later commit
in this series ("perf script: Support standalone scripts and remove
embedded scripting"), which updates 'perf script -l' to scan
tools/perf/python/ and display each script's module docstring:

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

Assisted-by: Antigravity:gemini-3.1-pro
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
2.56.0.rc1.310.g51773c2048-goog

