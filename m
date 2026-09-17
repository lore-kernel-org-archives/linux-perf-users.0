Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06223E4110
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 04:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789620821; cv=none; b=nM0YYEW+0W4d96AhZ4O3kaIz86CJu4EespsukI86kzIxLRbbQ+rT0Z4BgehmOIDqwbFKzjdoLabA6IOJ8xmfmCEu/HBRm27JY+K0EhnptvfMce5VvfK0u2Hr/kDjvv0ueH7J+s1H0tqH/1Os75H+K1Gn1k4jmqRcFJKX8kYD0VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789620821; c=relaxed/simple;
	bh=8hrGowBYrDL6E0GI4iYQUUwS8soKw09bwUHAG4kh0nI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=h6AmS7Bb2nGBodnXDnncGrWbQ8XkXMZXgSmtA2+eSwMiL5yIGa0Q6qbnPJYiWZkn8qfxmc/o8+YTGnvJxMMLzOPTQR1liqFAFfXB6jbPPMeqAO9Y1Re7v7qgJCWqvVFpF5f8Ryz7utiW92/NwpoHGdOI2IxWA+yAXz0EznODtFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cc9SHdq2; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cc9SHdq2"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38e54b6556aso610895a91.2
        for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 21:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789620819; x=1790225619; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W7vbcGCueojnObDaRwAwcrGohFia1H9DFQY3zU9O2QE=;
        b=cc9SHdq20os6CJlJWIWCDO82s7/ecQRVUncizUaLoAXh05QVjl+gATjSID/cR45TzS
         sa4y7rRT4kGsGwMoyDJPoiAsiuO9qx3riUH27qqYJmQkjzMOfiONlGEKTEe01wdvcjql
         fsSphid8nHOSOch5LR1Y9tgDiIJTJMMOBkAcRyhYX9+HCKm7CpiuGrbPqz8zDXbdGXUn
         xgf02N3TiNwaZq6m9ejLjIfn5206vRgPGzo5Umd8qhFgdB4JIwVoct6Bndt11X9zHD4P
         LzpADSdwiHEVMykfBis70TLHaCycOOHLD11c1x6c5zP0+gGRua7Z1TD5A1JwTdF0JcIS
         Jueg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789620819; x=1790225619;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W7vbcGCueojnObDaRwAwcrGohFia1H9DFQY3zU9O2QE=;
        b=Xa+IvuVsjqdQMoT+jUX7b/+kkFShMEJFEU1IA7EyFFwtl+TodYYlVEhTsEHRYif+FR
         VENYzTX/E+OBjt8EPg5I2xQIlfeDcQkweC6XFb9DaMmBFT8GpXdmFWiYhRKnMSeVNtBq
         M9sNcA/aRTy8flEZ4AQjJvLW5EXgFhV+7nnjjERcr3kkIgCt95ACPU8NKYXl9MrjnsCK
         MVs8NvF3orzQfjRBOClEztgAmBcVZv/VV319Zznsb0WkQz6g5lHXJTBxQJIk9FvkYdKd
         83xhvj3iY9Nreubg+Mu7IIp4aFAqNPBAFrZLbH47DF7MlfbELCCBnBK3x4xcQkoJPdWL
         NqRA==
X-Forwarded-Encrypted: i=1; AKwUvByki6uHT5yjIvcnqYFUtzYtko/ru2WuTXqNlRJHLQ2bmo9X4pCl1XldK2BEKF90IQPmryDEVs4613pV19MfxoMx@vger.kernel.org
X-Gm-Message-State: AFuF++kzuCSmrB+r98+lmRr+o0s3MFA+WhtYuQfn500/28pxpPl9WwYw
	6Wqth52dMJnJaCPs1PrKYQfZyc7PElPuuhsmL+A29dd2TqChdp6QcRuBT3sxMmDBHcjWIYqjb6n
	IsYNGdTunaw==
X-Received: from dlbrj6.prod.google.com ([2002:a05:7022:f406:b0:144:c2b6:8f47])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4985:b0:39e:345b:3323
 with SMTP id 98e67ed59e1d1-39e345b3d08mr5467064a91.22.1789620818775; Wed, 16
 Sep 2026 21:53:38 -0700 (PDT)
Date: Wed, 16 Sep 2026 21:53:18 -0700
In-Reply-To: <20260917045326.63601-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260917045326.63601-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260917045326.63601-3-irogers@google.com>
Subject: [PATCH v1 03/11] perf unwind-libdw: missing <stdlib.h> in libdw_set_initial_registers()
From: Ian Rogers <irogers@google.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: sashiko-bot@kernel.org
Content-Type: text/plain; charset="UTF-8"

Sashiko reported:

  When building the perf tool against strict C standard libraries
  (such as musl libc), compilation fails in
  tools/perf/util/unwind-libdw.c due to implicit declarations of
  memory allocation functions.

  The libdw_set_initial_registers() function dynamically allocates an
  array of DWARF registers using calloc() and subsequently releases it
  with free().  However, the source file lacks an explicit #include
  <stdlib.h>. On build environments where standard headers do not
  implicitly chain-include <stdlib.h>, these functions remain
  undeclared, resulting in fatal implicit function declaration errors
  that break the build.

Add the header files and use git clang-format to sort.

Reported-by: sashiko-bot@kernel.org
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/unwind-libdw.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/unwind-libdw.c b/tools/perf/util/unwind-libdw.c
index ebea101e1001..714ff455f28b 100644
--- a/tools/perf/util/unwind-libdw.c
+++ b/tools/perf/util/unwind-libdw.c
@@ -1,24 +1,29 @@
 // SPDX-License-Identifier: GPL-2.0
+#include "unwind-libdw.h"
+
 #include <assert.h>
+#include <errno.h>
+#include <inttypes.h>
+#include <stdlib.h>
+
 #include <linux/compiler.h>
+#include <linux/types.h>
+#include <linux/zalloc.h>
+
+#include <dwarf-regs.h>
 #include <elfutils/libdw.h>
 #include <elfutils/libdwfl.h>
-#include <inttypes.h>
-#include <errno.h>
+
+#include "callchain.h"
 #include "debug.h"
 #include "dso.h"
-#include <dwarf-regs.h>
-#include "unwind.h"
-#include "unwind-libdw.h"
+#include "event.h"
 #include "machine.h"
 #include "map.h"
+#include "perf_regs.h"
 #include "symbol.h"
 #include "thread.h"
-#include <linux/types.h>
-#include <linux/zalloc.h>
-#include "event.h"
-#include "perf_regs.h"
-#include "callchain.h"
+#include "unwind.h"
 #include "util/env.h"
 
 /*
-- 
2.55.0.1082.g2b9226bbc0-goog

