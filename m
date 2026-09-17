Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46DE3E40EC
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 04:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789620819; cv=none; b=LD4WTYay8cA2ocn0hNwvyMi3CPv5NFg4X4LjiNCzcc5m3ReHUnbH4oBz2Hj5X6HGfh7J4JgJu2TDNFGvpOKGPhyUtA2B5/29zIEy7h1MtjAnCAXZtDmlFS+wGXo82sVl+YOuW5YVu+s1tinloApr4ZiXzALokkQwgvnRSBClegU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789620819; c=relaxed/simple;
	bh=ibELKQVAYhSfge9/lsSfuKL+EgcxyDwO7B03A8+Cc/8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=T0sXgl2dXxzxDBGuRCAvVXxMfy1s9U5YBEWQL9er0/UEGUXJ7Y0Tpn7iIQ86jShtCzdjrpguttTojx6OJ2TsyR+UwKMMzBz6sIbsHttjnq0jZsBEMD6wf+PyQDqpkujWB9i/I972w9ZN+g0btBCXgSyc+zsTxTzM9iXr5CAcn3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VFg/U6jw; arc=none smtp.client-ip=209.85.210.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VFg/U6jw"
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-86917d18880so790721b3a.0
        for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 21:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789620817; x=1790225617; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=72CSLnQbeA4ZEEUcuYiv0dIvEEceHpo0qmSlWpbBICc=;
        b=VFg/U6jwUsfZCeetBFWOO0VvChN3JlEJdLopNSdYUO3TvmwYvyY+16j8ER0eAMzcRF
         YN5ax+JWk9KOv0u4L7TKLtNFZsWQ2T9X7bVWWGpJ1onu8FcxkQVBZaIG7lgtzs/dhK9V
         nQVOrRX9Dh8LLcwLMy2cfHuSt3e9LM103d4uAzPYwM5RBKKv1b9RZq4rqAnwBoHodI8P
         D+Hwrp6vOvoCjVWK/QKNX9AbzpgX6kSpqkgpo+t9IXEsrIh2oz+LglY4cekybT5N685a
         MxNgfviQMAiQMUaU2D+grNyB7NEvtILbVgzzVQr9Lz/qxUxtvvBAI2J/kdIeanBonbJw
         0m4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789620817; x=1790225617;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=72CSLnQbeA4ZEEUcuYiv0dIvEEceHpo0qmSlWpbBICc=;
        b=U56gVJLPN9otvS4d3/10Sdl9AVJhhNXhz6sGMfaoFjOlbpCBtjYJyneENLYa3uRDW1
         ERqTWg3uCI8a+0uAx7Q8dUpftKpZfgQxkNoVF7Y4WuQSEnzZzaPg1GE4nGzTga1yW60n
         upvtwctv93rYKBmPdvpqKjEZZscng2Uk423a96XT2UPc09TmBkBfMxhmzmBdM7EL7MKp
         FD2StnsOqLjy8aPHcIRZ89iwE11DTFX9uxKYChz/D/KPr0pWc9D0ERrWUNHuO9Efhb5U
         YmIOdsGzrBGCTFYyDdes5WHrUHkKK8FE9pvCc8dvvzGL64MEs7FeiBw07bYmIYBjWN2F
         rRfA==
X-Forwarded-Encrypted: i=1; AKwUvBzvIGajaMN8WCk/SwCQanyEpPReFrMRJj5SfsQ9cHg3R9JhfDeWpwZ/PQ2zpNRutbkyzkpm2LABHOMB2PfnYdMT@vger.kernel.org
X-Gm-Message-State: AFuF++lCwvIUodnNf3XNFlMF9Lr4W5uM0i6T91FolvL9bgMY7Pzo98kN
	mefVVVY26tG3/o8OWT1JLoMUzpgAgsPwURWJXOcyV0v48JVHt8BfRIPz10Dy/Nif6VVEd9g7Jnp
	fUNTaqV8TTQ==
X-Received: from dycnr8-n2.prod.google.com ([2002:a05:7300:e9c8:20b0:32e:3955:bc8d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:e290:b0:3d3:ae40:51e7
 with SMTP id adf61e73a8af0-3dd5f7add8fmr11957483637.27.1789620816834; Wed, 16
 Sep 2026 21:53:36 -0700 (PDT)
Date: Wed, 16 Sep 2026 21:53:17 -0700
In-Reply-To: <20260917045326.63601-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260917045326.63601-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260917045326.63601-2-irogers@google.com>
Subject: [PATCH v1 02/11] perf bench messaging: Add missing includes and sort headers
From: Ian Rogers <irogers@google.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: sashiko-bot@kernel.org
Content-Type: text/plain; charset="UTF-8"

Sashiko reported:

  When building the perf tool on systems using musl libc, compilation
  of tools/perf/bench/sched-messaging.c fails due to missing
  signal-related header declarations.

  The POSIX signal API and associated constants (SIGKILL, SIGINT,
  SIGTERM) are referenced in sig_handler() and bench_sched_messaging()
  but require an explicit inclusion of <signal.h>. While builds on
  glibc succeed because the header is implicitly pulled in via other
  includes, strict libc environments like musl do not provide this
  implicit namespace pollution.  This results in undeclared identifier
  errors for kill() and signal() during the build process.

Add the header files and use git clang-format to sort.

Reported-by: sashiko-bot@kernel.org
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/bench/sched-messaging.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/tools/perf/bench/sched-messaging.c b/tools/perf/bench/sched-messaging.c
index 4fb6657fc826..5bdcc0595367 100644
--- a/tools/perf/bench/sched-messaging.c
+++ b/tools/perf/bench/sched-messaging.c
@@ -14,21 +14,23 @@
 #include "bench.h"
 
 /* Test groups of 20 processes spraying to 20 receivers */
-#include <pthread.h>
+#include <errno.h>
+#include <limits.h>
+#include <signal.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
-#include <errno.h>
-#include <unistd.h>
-#include <sys/types.h>
-#include <sys/socket.h>
-#include <sys/wait.h>
-#include <sys/time.h>
-#include <poll.h>
-#include <limits.h>
+
 #include <err.h>
 #include <linux/list.h>
 #include <linux/time64.h>
+#include <poll.h>
+#include <pthread.h>
+#include <sys/socket.h>
+#include <sys/time.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <unistd.h>
 
 #define DATASIZE 100
 
-- 
2.55.0.1082.g2b9226bbc0-goog

