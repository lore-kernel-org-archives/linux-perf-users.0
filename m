Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080233E40EF
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 04:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789620825; cv=none; b=OtqjroX2n+zLDxnkyEJmLlJi5D/ZPAuub4aEtrId7LmSy7AcukY1oMvUCZXKdR+DEJmTMQuKV1D0C+oF4cV7TOaJKfmew7IbqqhDd1i7AsT8MCDXMTlG4RbPN/2odBjtUezKnBVWEbPxmGLWIs2BSMObl1zNhmHqY8h7JdY6S8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789620825; c=relaxed/simple;
	bh=ctgAKO83gsTv8gTCuaPIepnWz72t4D2/QM8/mKVOa2Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QQi20+DCK4F2uD3LDguDGE+XNqfQdrbSUZjc6yUjtIr+WTkDjjAZAI8sSEbgnuVhPnZ3ogL5sEySErxKPdRQUZG9YdsF9zCxYUcY18E0kgrziFfdHL8E9ag+RhQ1Qjb4C+1MZaM7dpmpia0B25nZTtnkJEHLCugimxce+ROzW38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NgmzRS0j; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NgmzRS0j"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-39de4e72b33so813967a91.2
        for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 21:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789620823; x=1790225623; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t4bGGtl8mviDTYAje/z76N2WSQvQmolwBPcSYqlFs3A=;
        b=NgmzRS0jgzt4shBmpurPsr1K+VSSesM88BjKNKBJTVNuip7vZBQmZ5RxXxOqdEKY/i
         ftuu5Q4WI8Wf0Nc9qUQxTypginai+uqO904mgyirCIgayAY3pxWf7yPPLQeG3gmth+QA
         DUsKFjdptfNEqdVnnQYEmxNv+UPUYDlist7dB7Gaa04YMwDNg9qD/pZS1xlCkQ+LGh0v
         1EOhVww3aIRQMvxaGUTIP9Kk0zwMDc47cT2FAhpeX/c1hqppOYp+RM+5imlB4tU5L/Uv
         72c8Wcyh5yPUbPtzNpbdFfkUOtnDbPdbeIIMGdn36+XIFFGgbUcGk+rnnNgnhqJRrnUj
         NfyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789620823; x=1790225623;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t4bGGtl8mviDTYAje/z76N2WSQvQmolwBPcSYqlFs3A=;
        b=Ry1bYAPOKPJce47x94vf6fZrtMycZYuIm+KzGXVpjopSsgeR3ffNT6N5VZhdePpP0I
         kw22acEqyqkRzPOakdXa2rvbtPSnfEZM3sww+PKyt+vaAcvCPpvCdeBTn3UN97YUfus1
         E2LLLS8h6kCZgJECUJ8o/un4JP6nbE9Unynqrdp01skaIzvbkhB29xRGYrgiGCD0LLiB
         8/uExArn7uenfEJCVLU49A5drkQxxJ/VhKJUNG5+FtQ+wvb0vXbhVzvDpS+Kod3vRU/j
         NC1mYN+vEp9FcP7dThHnPeYOzMeqDz3Mc6rTRpwDJoXnqmsUyW224+AxOUOLReA1YmX3
         EmbQ==
X-Forwarded-Encrypted: i=1; AKwUvBwuBiOif/J8pdogpQPwAffWKA+UDNr3oBorrmeDY7HlEe+pVKj/HvF2tT8RiIKE5tNIG3emYKJgsDhPVcljKore@vger.kernel.org
X-Gm-Message-State: AFuF++m6wEgbGaGYEXwWFYZVUEzt1bEJfBxlFff7BWU23xkGUqa15mF7
	P3Hvheev3+vd3mLDJLmcxqLIp1q2jWWD037gBvwQlafrTyADxAwKgX/mQQh4b1y0j+Tp1Ga1SBY
	oIn57GILzRw==
X-Received: from dlec16-n1.prod.google.com ([2002:a05:701b:4290:10b0:144:be75:f389])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:54cb:b0:37f:c22a:c188
 with SMTP id 98e67ed59e1d1-39e1e25ac28mr12048608a91.4.1789620823042; Wed, 16
 Sep 2026 21:53:43 -0700 (PDT)
Date: Wed, 16 Sep 2026 21:53:20 -0700
In-Reply-To: <20260917045326.63601-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260917045326.63601-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260917045326.63601-5-irogers@google.com>
Subject: [PATCH v1 05/11] perf dso: missing POSIX headers string.h and limits.h
From: Ian Rogers <irogers@google.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: sashiko-bot@kernel.org
Content-Type: text/plain; charset="UTF-8"

Sashiko reported:

  When building the perf tool on a system using the musl C library,
  compilation of tools/perf/util/dso.c fails because it utilizes
  standard string operations and the PATH_MAX macro without explicitly
  including <string.h> and <limits.h>.

  Functions like dso__read_binary_type_filename() allocate arrays
  sized by PATH_MAX and perform string manipulations using strncpy(),
  strlen(), and strdup(). While glibc implicitly exposes these POSIX
  definitions via other included standard library headers such as
  <stdlib.h>, musl enforces strict header dependency
  boundaries. Consequently, these macros and functions remain
  undeclared during preprocessing, resulting in a fatal compiler
  error.

Add the header files and use git clang-format to sort.

Reported-by: sashiko-bot@kernel.org
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/dso.c | 47 +++++++++++++++++++++++++------------------
 1 file changed, 27 insertions(+), 20 deletions(-)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 42bfe30a3b51..592fb971ffaa 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -1,38 +1,45 @@
 // SPDX-License-Identifier: GPL-2.0
+#include "dso.h"
+
+#include <errno.h>
+#include <limits.h>
+#include <stdlib.h>
+#include <string.h>
+
 #include <asm/bug.h>
+#include <fcntl.h>
 #include <linux/kernel.h>
 #include <linux/string.h>
 #include <linux/zalloc.h>
-#include <sys/time.h>
 #include <sys/resource.h>
-#include <sys/types.h>
 #include <sys/stat.h>
+#include <sys/time.h>
+#include <sys/types.h>
 #include <unistd.h>
-#include <errno.h>
-#include <fcntl.h>
-#include <stdlib.h>
-#ifdef HAVE_LIBBPF_SUPPORT
-#include <bpf/libbpf.h>
-#include "bpf-event.h"
-#include "bpf-utils.h"
-#endif
+
+#include "annotate-data.h"
+#include "auxtrace.h"
 #include "compress.h"
+#include "debug.h"
+#include "dsos.h"
 #include "env.h"
+#include "libdw.h"
+#include "machine.h"
+#include "map.h"
 #include "namespaces.h"
 #include "path.h"
-#include "map.h"
-#include "symbol.h"
 #include "srcline.h"
-#include "dso.h"
-#include "dsos.h"
-#include "machine.h"
-#include "auxtrace.h"
-#include "util.h" /* O_CLOEXEC for older systems */
-#include "debug.h"
 #include "string2.h"
+#include "symbol.h"
+#include "util.h" /* O_CLOEXEC for older systems */
 #include "vdso.h"
-#include "annotate-data.h"
-#include "libdw.h"
+
+#ifdef HAVE_LIBBPF_SUPPORT
+#include <bpf/libbpf.h>
+
+#include "bpf-event.h"
+#include "bpf-utils.h"
+#endif
 
 static const char * const debuglink_paths[] = {
 	"%.0s%s",
-- 
2.55.0.1082.g2b9226bbc0-goog

