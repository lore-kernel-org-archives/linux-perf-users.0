Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F103E40F1
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 04:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789620817; cv=none; b=m+ommXTOFeqZ5Mibijc0Rduj4ShjG13PjUu4Paq8JWRWFAxcXpSFgoLf+CnRxhV8ZU5zShymZLXiTdTmKbDLwwtmkh8f+PZrnJm7MFLh5lSfDM0ccZHEdHXQCtS5Z7RMYmQgBSy5zdI3O5kQCRr1/KXKywUbaC9V5RunDls0xyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789620817; c=relaxed/simple;
	bh=4KvZJH6YRwPglA9o3nI6z1rEnSsw3vH+LveBOSJFiwY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=r+/fiBOnsgjcHZOiIQZAQqAAsgHfDgWNaxafhRPwfftkRlCZOHpKr8cVvp7ra+DNPKjE3PForfv8jdECSo8peeM+whEYrX9w2pFRidT07JWfsC9DRNZnYOaEjV9kGvNUVXthqesxsmI3LG+gakUJvwShlQ2yqM4das7TZq0Jby4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W8oTM/0X; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W8oTM/0X"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-39d8646b10eso524153a91.1
        for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 21:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789620815; x=1790225615; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bOKipafnbhub0qpZgGArEWzHEFMMWCTscOxRR7YZKWY=;
        b=W8oTM/0XH6Zp//oJTh4UyX1ZAtHHqVGx3CBsHuKRF/mdpkbcbhGBBh24vy7YiYjdxW
         0biKZIDZmdQFBdGpuJe9CQ9b1yJ3X3uiAkzXnS372njNo9z67eACinoWCjyOznxiu9Gd
         V1JsAPS0Gq4bdQKWtjeJ++lB8cKs38K75DQn+ae2k3iChRR1orYwfSl9hy4k2OsemQnJ
         Qr9WzFxciimRT13gv/qWgxdSfqI8xOsn+Kr6+y8W9z3Sp6KLiBE9QX4DMSFsCVyitpZ8
         5WVpmrAW58Jp0M3wunBKsvfn6NVd+5VAzxJ4ysCSU1aoXdLWseFw1no/xOJrqKRevdub
         syWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789620815; x=1790225615;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bOKipafnbhub0qpZgGArEWzHEFMMWCTscOxRR7YZKWY=;
        b=U98TZ2IhYUL+Kfmqcazmb0Wtp7FhvxQnqz3o+/RmGOVGbPbmAywVE+C1RaK2dIiXWc
         AoxZOibrRHH8Z6fLAYgNzx6vw8Zj0nE59+bFas4h0HdD57j5y2iXkYvY66FJgd6rXiyR
         u1Bzvy3wt+ljMXky8vwxmT+vxcbP77vBlGgn26qw6zO/G+ap3qOPS38VhA2FSYmosGLv
         M2hkYda83N5XyldtSJDmo4C/srsGjWj4fIW6UwVHguLkj5uSHd47Zii6InXidX5aBPfq
         U3P2zIwC07TwdY7OMTOTGCuH6QYb5UFV8J0IP+PdKE7RRUHICozIi24L6ynv8wmwYGqT
         fgdg==
X-Forwarded-Encrypted: i=1; AKwUvBxj9su5PIJr4ukXzvMmm5vruePmvWQgHxfXI+u93mU4+bflBYdYcdN9WjxeEFkgyD6wVdSTZKBvkbJ0V2DOI6nj@vger.kernel.org
X-Gm-Message-State: AFuF++l3IMtrseyWmkvwwEWnUSCgXlVUF4p3bC0gz+uL35Ipp9nasPiS
	Xvk0L1sVmLMwR1lhFjnOcvQM/pPOdyq0jnhDLWV9WN5OROi9bPfnAnJgOqhKBa8NWR5sLsTWqmQ
	ZZod+nLElig==
X-Received: from dli5-n1.prod.google.com ([2002:a05:7022:285:10b0:144:c0e8:a153])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4a51:b0:39d:ee20:1e28
 with SMTP id 98e67ed59e1d1-39e1e510f73mr15259716a91.21.1789620814920; Wed, 16
 Sep 2026 21:53:34 -0700 (PDT)
Date: Wed, 16 Sep 2026 21:53:16 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260917045326.63601-1-irogers@google.com>
Subject: [PATCH v1 01/11] perf aslr: Add missing includes and sort headers
From: Ian Rogers <irogers@google.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: sashiko-bot@kernel.org
Content-Type: text/plain; charset="UTF-8"

Sashiko reported:

  When building the perf utility against strict C standard libraries
  such as musl libc, compilation fails in tools/perf/util/aslr.c due
  to missing explicit inclusions of <stdlib.h> and <string.h>.

  The implementation relies on standard memory management and string
  functions like malloc(), free(), memcpy(), and memset() in routines
  such as aslr_tool__findnew_mapping(), aslr_tool__process_sample(),
  and aslr_tool__delete(). Because the required headers are omitted,
  the compiler must resolve these calls via implicit function
  declarations. While glibc may transitively provide these definitions
  via other headers, musl libc does not. This violates strict C99+
  standard compliance and triggers fatal build errors under modern
  compiler configurations.

Add the header files and use git clang-format to sort.

Reported-by: sashiko-bot@kernel.org
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/aslr.c | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/tools/perf/util/aslr.c b/tools/perf/util/aslr.c
index 027695d96779..f49e965243aa 100644
--- a/tools/perf/util/aslr.c
+++ b/tools/perf/util/aslr.c
@@ -1,28 +1,32 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "aslr.h"
 
+#include <errno.h>
+#include <inttypes.h>
+#include <stdlib.h>
+#include <string.h>
+
+#include <byteswap.h>
+#include <linux/compiler.h>
+#include <linux/zalloc.h>
+#include <unistd.h>
+
+#include <internal/lib.h> /* page_size */
+
 #include "addr_location.h"
+#include "data.h"
 #include "debug.h"
+#include "dso.h"
 #include "event.h"
-#include "evsel.h"
 #include "evlist.h"
+#include "evsel.h"
 #include "machine.h"
 #include "map.h"
-#include "thread.h"
-#include "tool.h"
-#include "session.h"
-#include "data.h"
-#include "dso.h"
 #include "pmu.h"
 #include "pmus.h"
-
-#include <internal/lib.h>  /* page_size */
-#include <linux/compiler.h>
-#include <linux/zalloc.h>
-#include <errno.h>
-#include <inttypes.h>
-#include <unistd.h>
-#include <byteswap.h>
+#include "session.h"
+#include "thread.h"
+#include "tool.h"
 
 /**
  * struct remap_addresses_key - Key for mapping original addresses to remapped ones.
-- 
2.55.0.1082.g2b9226bbc0-goog

