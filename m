Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9769E3E40F1
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 04:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789620842; cv=none; b=tdk6AJSy3c+gCp+ALSMqHGucv13jovxqv1cWiwmPSE7a7D931LZPov3I9eq9wYHzi0+5x0+DDgjnf2myT/E6SI4+b5tZWIzr8oJ9jcP+KAFHbteiW/3uqWv+w1+KyDv/0VwuWzF/jhcmxrac3bY4K/MCMKia3BenVWXIxDwS6r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789620842; c=relaxed/simple;
	bh=3ZLzdVtnwtR5aJqjTSHs54s5O2HaM5Ff5GC1mlFXoPg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nHXkliM9SCRr2mYL5yP+r1PIvcLcmpJen9kwGAMTfxK0oOQcKAKPqt7QGTkNR8G/J2pXGytNlbEgWORohzL3DWTIQ4DjTCMsoh1N+UTJQa7VY769dsZffPK5SVOWkhqAlsUnSItDjwJZQc0paI+xziBKNUifHseq/55W9lmr2DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M9U9vkIG; arc=none smtp.client-ip=209.85.215.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M9U9vkIG"
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cc4b524ce78so314709a12.2
        for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 21:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789620837; x=1790225637; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hnOsEAwGk9LqixLfhLOT7XTvSRQ2plZCSBS+V/wJMfQ=;
        b=M9U9vkIGB/mGMiCsudAUYITs6OVvBNv6GRtl3r8MFNAHfDn6pddNVa8WJib75Eodtv
         gwIwgYuW2rRkL36nwEAb2r+68rIiDG3cWeikgk7r64pbJ0SZ9Rjotfa2fXoWInH0dd3z
         ZiBzW8GUCBY7ET27fcGdl2bzeMVJZlq1bl5Ke3AMeen5GZItxu7MMDWJtdsepLNGLiP0
         R+X0hSF9pM5V6sjIm2ZkdEfyx4goJTbPyOJzF8e4OZ9k0PfGILYTMgYCZCuustNiukLq
         lvM9GjBsI3QiK/smZV2gy8jE1hhVnj5R5NFj9Ij4iBOVhe/AvJnbL24X1lI5IR+4Pbze
         embQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789620837; x=1790225637;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hnOsEAwGk9LqixLfhLOT7XTvSRQ2plZCSBS+V/wJMfQ=;
        b=w0TLm22heIe2DvC7NNJYqPZNJNdNssSFg50g91EOzuV7kikPwISic1Hea5gEuTBys2
         HJ8NFIJ2YuB6+4sXs8IewS5955hq3JuXk4r+Gplnl5bbBSVB/O0COuLp+VgoyLqGdEbP
         czVaXIYWy8r973AH1kSBY1i51LnrDZRELccpQI/dn8BCL44Rk0GymX5kXSLns+s3bz1G
         GHC2q6fgS/K48+GRBiHIvdXrnhMi3VWLABEq0EJ4LXWvS1PuTKrpsfjJx0unYtRI+4C2
         DZ59Ah5TEKbgaYeudwbywxHNBUhM2IwqXX6yUKVKtqLiZ2uD65rRjcKZs3YaAg8uUDVP
         TbEA==
X-Forwarded-Encrypted: i=1; AKwUvBw1F4dWc7yoz0rb7ntjc9R+T7L8Sx8PsRHZMhqGMhrDBMEiBpU+PsBH/5s5WYY8iozDzMQJX2c1MpOZbW8Gk1hz@vger.kernel.org
X-Gm-Message-State: AFuF++kR6CjRTYSkN7yCBu7399WDhQZ73Qii87IN2AHIPE0quy2GlFly
	BMrLP2xZbSgvJU6WeVUZEDQJVAmWQjXiHdFpuoIk54HNWbFXy5MPNw7/+6aRKf6qIKU2lM3Tr7T
	12IP1ealRgw==
X-Received: from dybme47.prod.google.com ([2002:a05:7301:18af:b0:33b:ece2:d254])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:46:b0:39e:35a0:9c0f
 with SMTP id 98e67ed59e1d1-39e35a0a211mr5638388a91.14.1789620836744; Wed, 16
 Sep 2026 21:53:56 -0700 (PDT)
Date: Wed, 16 Sep 2026 21:53:26 -0700
In-Reply-To: <20260917045326.63601-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260917045326.63601-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260917045326.63601-11-irogers@google.com>
Subject: [PATCH v1 11/11] perf mem: missing standard POSIX headers in builtin-mem.c
From: Ian Rogers <irogers@google.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: sashiko-bot@kernel.org
Content-Type: text/plain; charset="UTF-8"

Sashiko reported:

  When compiling the perf tool with musl libc, the build fails in
  tools/perf/builtin-mem.c due to missing explicit include directives
  for standard POSIX headers.

  The source file directly invokes standard libc functions, including
  calloc() and free() (from stdlib.h), strcmp() and strdup() (from
  string.h), and printf-family functions (from stdio.h). While glibc
  often provides these declarations implicitly by pulling them
  transitively through other headers like <unistd.h>, musl libc
  strictly enforces POSIX namespace boundaries and does not expose
  them implicitly.

  Because tools/perf/builtin-mem.c lacks explicit #include directives
  for <stdlib.h>, <string.h>, and <stdio.h>, compiling against musl
  libc results in undeclared identifier and implicit function
  declaration errors for these standard library routines, causing a
  fatal build failure.

Add the header files and use git clang-format to sort.

Reported-by: sashiko-bot@kernel.org
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-mem.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/tools/perf/builtin-mem.c b/tools/perf/builtin-mem.c
index 6101a26b3a78..265264a1bdad 100644
--- a/tools/perf/builtin-mem.c
+++ b/tools/perf/builtin-mem.c
@@ -1,30 +1,35 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <errno.h>
 #include <inttypes.h>
-#include <sys/types.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+
+#include <linux/err.h>
 #include <sys/stat.h>
+#include <sys/types.h>
 #include <unistd.h>
-#include "builtin.h"
-#include "perf.h"
 
 #include <subcmd/parse-options.h>
+
+#include "builtin.h"
+#include "perf.h"
 #include "util/auxtrace.h"
-#include "util/trace-event.h"
-#include "util/tool.h"
-#include "util/session.h"
 #include "util/data.h"
-#include "util/map_symbol.h"
-#include "util/mem-events.h"
 #include "util/debug.h"
 #include "util/dso.h"
 #include "util/map.h"
-#include "util/symbol.h"
+#include "util/map_symbol.h"
+#include "util/mem-events.h"
 #include "util/pmus.h"
 #include "util/sample.h"
+#include "util/session.h"
 #include "util/sort.h"
 #include "util/string2.h"
+#include "util/symbol.h"
+#include "util/tool.h"
+#include "util/trace-event.h"
 #include "util/util.h"
-#include <linux/err.h>
 
 #define MEM_OPERATION_LOAD	0x1
 #define MEM_OPERATION_STORE	0x2
-- 
2.55.0.1082.g2b9226bbc0-goog

