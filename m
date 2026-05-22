Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8484438947E
	for <linux-perf-users@vger.kernel.org>; Fri, 22 May 2026 22:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779487496; cv=none; b=ktSjLb6PhSxMGfG42nIw4UQ4NyBsRPJAoGD6Up3s+kK+OrYDjpSF91HaEH3DezHw5IrU8Srsl+e/U5ivyRarHdPPaorsHZg6vCzrNmk7O3NYvJ48Axb68hDNzqU3EDdwqbPnP6nJA1UADSWaTlu7X+uKkc48clfAX5r+NNXZ2Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779487496; c=relaxed/simple;
	bh=AVq3snyWrKDDoDuCNejXayYqVthYN3vXW6RfemKwgqA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=px1QwqV9sl17BxLlgT0/Z35gQtc2AnwfBmXcs+WzfQz7e+Izc4awvr0ppinYXIPlseWsjFXK54QoFdw+6FOvCqLCcSeFZJ0IECkW3I/lMp70tKPPuZq/kJqrbh9tlfT9i7cpZE4oebmSp+htgKWgAH+DRo6X8bh91vCXxcbcRcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AUmqksuR; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AUmqksuR"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-3041ab826ddso5854246eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 22 May 2026 15:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779487493; x=1780092293; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=p+Ps4mCr8gi146N9Gz5RD0kRPKapXZPgmaFKoDB0Lgo=;
        b=AUmqksuRJUGy0gTrHAO0+iv9LdLMCdwqXcqJgXNyd/DmA9dcZJE9Q6BxOcA4rvo4VV
         t7t1RksZ7RRs4ed1Z0MyBRdQiBV/gznT8wTgV4iXFj8nRZWPMHTvpTCUB/DqHUlr9s9z
         A5Ay2iGET7pWBoZ2P06BfFWZihaiZKH1Cwm7yBQBfX48K65vC89y2UdUG9W7KnvrhqgW
         jg6YZ86norwgMLJ4cSLC+pNE7NBJa0VkJqYzBW/ly8SPcGIPfxLn4ibHJxBEr4AffgrQ
         BuRjMHOa2tEJtDDyR+obJdaRROyqpxGEmsjQddClSui19prB/ZyB5a5dd5fdGqX4ut3e
         AGgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779487493; x=1780092293;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p+Ps4mCr8gi146N9Gz5RD0kRPKapXZPgmaFKoDB0Lgo=;
        b=qW2iI7hvM/CsCQInqaFm+nTVp+NP8YQY/NW4mqaDjjzYX2ltAw5SEbQJWadeXaC9Li
         SGYOGLMFOpyybMPoUaJ9GCmqsmo1FJgSuLaFqNgp3AfYLHZEOWOa8FOxLpHQPcDJlyLc
         mF33us2evikWFP0gxrFS+2RNqEbS004f9554OklBxV0v6dLyCx7cDfTsf+FMVC+OfuWC
         X1NNi1kVA8y+YLTnqub6w/Z0Tjj3sYp0TK/Ti3t19VTUsIq9IoagHGUkbfE99TKv5tiS
         8ZXWCFOZJ6oPwk11zpLDq2dYz7PeRn0TX2gAMLuxXYiLptg3d5FzS1bSnRJprGmdw/v6
         g6Zw==
X-Forwarded-Encrypted: i=1; AFNElJ8QkvJJzJGIg+aL5/vr796GOpyNyEDE49aRPRLWFrcOySaEHyZuNaJEadaSj4M7XLKZ2XZbnEDE+eZemwIaSiWP@vger.kernel.org
X-Gm-Message-State: AOJu0YwqKh+SS/3E7euOpqJ6woErZhVrTthfRP+o9HmU8UK56lg6dnTV
	GnVyC+jHCfSu1gEXSrkH+i1bUSoKRu6mGxuBmbQoRQnki9Wtbf5G5JNZVqPXFNJpttebzezqUnW
	Xh6Zhsfbv2A==
X-Received: from dyjt24.prod.google.com ([2002:a05:7300:7b18:b0:2f2:fc0:8869])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:6446:b0:2f8:42b0:e63d
 with SMTP id 5a478bee46e88-30448f363demr2843328eec.2.1779487492324; Fri, 22
 May 2026 15:04:52 -0700 (PDT)
Date: Fri, 22 May 2026 15:04:17 -0700
In-Reply-To: <20260522220435.2378363-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260428071903.1886173-1-irogers@google.com> <20260522220435.2378363-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <20260522220435.2378363-7-irogers@google.com>
Subject: [PATCH v9 06/23] perf python: Add missed explicit dependencies
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, alice.mei.rogers@gmail.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org, leo.yan@linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Fix missing #include of pmus.h found while cleaning the evsel/evlist
header files.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/python.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index cc1019d29a5d..dd937d714e99 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -1,30 +1,35 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <Python.h>
-#include <structmember.h>
 #include <inttypes.h>
-#include <poll.h>
+
 #include <linux/err.h>
+#include <poll.h>
+
+#include <Python.h>
+#include <internal/lib.h>
 #include <perf/cpumap.h>
-#ifdef HAVE_LIBTRACEEVENT
-#include <event-parse.h>
-#endif
 #include <perf/mmap.h>
+#include <structmember.h>
+
 #include "callchain.h"
 #include "counts.h"
+#include "event.h"
 #include "evlist.h"
 #include "evsel.h"
-#include "event.h"
 #include "expr.h"
+#include "metricgroup.h"
+#include "mmap.h"
+#include "pmus.h"
 #include "print_binary.h"
 #include "record.h"
 #include "strbuf.h"
 #include "thread_map.h"
 #include "tp_pmu.h"
 #include "trace-event.h"
-#include "metricgroup.h"
-#include "mmap.h"
 #include "util/sample.h"
-#include <internal/lib.h>
+
+#ifdef HAVE_LIBTRACEEVENT
+#include <event-parse.h>
+#endif
 
 PyMODINIT_FUNC PyInit_perf(void);
 
-- 
2.54.0.794.g4f17f83d09-goog

