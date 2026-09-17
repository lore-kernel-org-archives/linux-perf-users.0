Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B093E410D
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 04:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789620823; cv=none; b=PeX5jClm0/lIcbCzPbj7keVpEaGl9Vz7wkl5ScCwwHiZpPTQRIJEcgsDZrV0WBJ+zJuObVqyzxsAOfuEf1P9qw2Xow4B+K4YJwMOQlJWri2qOUoXv0hvw1SFaajcpBlIP8h/EM4hpclljFqWPjspvNhbnu7C2LIrZCkMgc4lMzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789620823; c=relaxed/simple;
	bh=UFZw8ccWukYPTXWDhuLgW3RK9MncZoRZK2RoRe3blgM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=X8/+YS0s31aeYNOUi7FQpjml1tHMAKQmWlN6pxAu39EbrWLj8hb3QXkJ8P7DnlPxT4HnmZ3uxmJWAau5pnwdUKH7/CV3lLlTmzZMdOV3d7UN5xO2TLNWbH3TmreOczEPo3VdxDgN+IqDaW6tfYaN8MF/b/aNlbzE8+y6P4MgT/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aQouRKFA; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aQouRKFA"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2dd753a52bbso9224735ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 21:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789620821; x=1790225621; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FW5H/Iu2+HolG/+BtlKduLPhDgOXa5vtUBne8YJ7Hg8=;
        b=aQouRKFAVCJRi5owluvqZGmT+cV8D11I3TzY9QJzipzhQlTPbeUhXijDNFbiNeV6dN
         Q5bTmP0Q08LeFyAiFlFtV/YXTAETQEKnKH8zdSYPZ7Z6PWtypBJzk1YRBZsYpCeqxH1o
         NipLWmQ23a7TBo1Pu/goKk6jR1lx79iHbo4sC+wgYMgQ7L9unXgcVpa5EEzIT5bwu+LO
         BM5GotZpnNoCr4gbnys/6tGE/Gba3lPlQ5J6/xDa3A1TM/6/5nay+drveYuQb3tQrvcl
         b7VuNhYHfTCU1NUoV2+9pQjHFnWEJl/5SYmxzpZuFifTEj7lLoUpMKT2VhmT6w8azGA8
         otEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789620821; x=1790225621;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FW5H/Iu2+HolG/+BtlKduLPhDgOXa5vtUBne8YJ7Hg8=;
        b=hTMa68W0aLkM7rkA8C7Df1zeNcqBWZjeVBCdnVjuEDuQz1uiGbQ1MJKHicG4sBDwmi
         fS4Izp7MAoKVo6QSSrPJY7wgkPdgpbSlmKQSYWzVhCwIsIvfzT4BOywNqg4/AsfgVtRc
         rnrRU9mfyWBvKaajYgizmShQrGRQmUV4AC07Lc7Dt+ACQ8GjWI1HG7x00GfXLysAUkaw
         I9S++mN4e022sbI+nJ4vvk0l/XNL+SWpOEGBvvTzAPVNTpeFgl1ZVDz2659mBE4cmphQ
         V3AND6gC64BH1q+amg2uRmXyHcrMdzLwj5RhswjMhWNhiXtFmeyg0F3hyjWU0XQuYe6K
         icFQ==
X-Forwarded-Encrypted: i=1; AKwUvBxml3RmHW2lOueakJTXzbOBCwoEdtRAKL3syp47IBjnW5FZ6wAV5CC/yQaoTHwj+09OidTLi8/wceVnmJj+USCw@vger.kernel.org
X-Gm-Message-State: AFuF++nC9/jlsoKU1mT2gUmpObqVzsgoJRlD/zhacRpHe8UGKx5s8GSp
	vSfPxMiqczP1dWgH/eedIUOPntzLIuTAHthLSX3ynSmPl7G2XCP73Y5C8tND9WTNHblgXftCU8n
	gB5cRKFSG6Q==
X-Received: from dybzy15.prod.google.com ([2002:a05:7301:e10f:b0:336:e0f9:1b3])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:b85:b0:2dd:9b53:f9ba
 with SMTP id d9443c01a7336-2dd9b53faa9mr59334475ad.1.1789620820770; Wed, 16
 Sep 2026 21:53:40 -0700 (PDT)
Date: Wed, 16 Sep 2026 21:53:19 -0700
In-Reply-To: <20260917045326.63601-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260917045326.63601-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260917045326.63601-4-irogers@google.com>
Subject: [PATCH v1 04/11] perf llvm: missing explicit POSIX headers in symbol__disassemble_llvm()
From: Ian Rogers <irogers@google.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: sashiko-bot@kernel.org
Content-Type: text/plain; charset="UTF-8"

Sashiko reported:

  When building the perf tool in an environment utilizing a strict C
  library such as musl libc, compilation fails because
  tools/perf/util/llvm.c omits explicit inclusion of <stdlib.h> and
  <inttypes.h>.

  The function symbol__disassemble_llvm() directly invokes free() for
  memory deallocation and utilizes the PRIx64 macro for formatting
  64-bit integers.  While glibc often implicitly provides these POSIX
  definitions via other includes, relying on transitive inclusion
  creates a brittle dependency that violates perf subsystem
  portability guidelines. On environments that do not implicitly pull
  in these headers, the compiler encounters undeclared identifier and
  unknown type name errors for free() and PRIx64, preventing
  successful builds of the perf toolchain.

Add the header files and use git clang-format to sort.

Reported-by: sashiko-bot@kernel.org
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/llvm.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/llvm.c b/tools/perf/util/llvm.c
index a0deb742a733..95efd089014b 100644
--- a/tools/perf/util/llvm.c
+++ b/tools/perf/util/llvm.c
@@ -1,5 +1,14 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "llvm.h"
+
+#include <errno.h>
+#include <inttypes.h>
+#include <stdlib.h>
+
+#include <fcntl.h>
+#include <linux/zalloc.h>
+#include <unistd.h>
+
 #include "annotate.h"
 #include "debug.h"
 #include "dso.h"
@@ -7,10 +16,6 @@
 #include "namespaces.h"
 #include "srcline.h"
 #include "symbol.h"
-#include <errno.h>
-#include <fcntl.h>
-#include <unistd.h>
-#include <linux/zalloc.h>
 
 #ifdef HAVE_LIBLLVM_SUPPORT
 #include "llvm-c-helpers.h"
-- 
2.55.0.1082.g2b9226bbc0-goog

