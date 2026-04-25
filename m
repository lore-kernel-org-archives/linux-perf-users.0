Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E9F38F648
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 22:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777156907; cv=none; b=EVgn6XGbp+dqyZ0R11ciEyM5q/sYPfOFzjgewyhLVdqrISg9asM/t+csZOkocNeqriM1th3rMdj3u6rpNShvWytIY2+z6F5l/v5jDyYJaU0w/5zjjaNeE/vlENTK0QY/RJK/bdBIYLP3dAA21iRIQnZszQBqp+COqw/ao2iWj5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777156907; c=relaxed/simple;
	bh=E1A9rOUkigl47RQgwxPU7BZg+a2AkxhYpc7Hpry26ZU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TUYKfGF6rThfG3j09Dkl9KmU69Xr+CNilJV/RnWLYqXpZkY1z5YvuVHh9ul3OhS5U5CgFhd1mMDsZTMLMyc8OhwJbXxYwivDNSNW7hGSXyZKvHHdPg1HqCOfPUTxJdQhy4ABa0O+s8aG4o+B8ncDuw50v64NgMiRCyqkbnXqen0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AYP+6DpZ; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AYP+6DpZ"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2ba9a744f7dso11746713eec.0
        for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 15:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777156905; x=1777761705; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Pih4PvjlzSX23VUBfhxJgrdaziaLdcdiDaL3PE08L8Q=;
        b=AYP+6DpZcWLni8N07lsiOLhdxZD5Yy+Rhys2N6Z2IjsmKY4E60375YmXQChISae2md
         K/jN5eljw8o8SQ1/quPXkT0j5YbE9PbttXFcrHuCMJSZIBE7b/Qp0pWOh+KOlLY87V2V
         bA1cgCZuayCWoCzLKxQ+2Rt/vaBpavQTmQA8V4dAlUfmIitVlCTHCV9RD4qsBu8paWDl
         8oO3K1MCzBHpth4kWv30B7vOsZILxGFkRpmRhmY7vTis/pLsN4Vlp+Gf1ZrQ+OW/wujs
         Lsl+LnNHiMkuv35hmm7H8YI0TD70ukFC2TxOVdM4B01T45R30zrVhD8nrCDVpiTe9vA4
         tYwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777156905; x=1777761705;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pih4PvjlzSX23VUBfhxJgrdaziaLdcdiDaL3PE08L8Q=;
        b=q0s/uZEngZQlg3JY3GZYT2K0KvPewksVmk8hjIupjf+yttahf5sm3HRFy58U+XbAoC
         /veZXkFUvMrxreBnvro0MZ1ypU/wyouXS8tTD5S5KfHDYx9En9WmkKjXL9NxkT3+JdIT
         PPu3GiJzsvaeAu1fS+BvtRUJeliEUPtuXit8JHeMutmcsqb6pYBsXNFsoFkZKh2mAzsF
         8GqzVTIIftajVsJUzyhALDFlaipWZX3XfFm9a51FgzM1Vm4R5FsKrpiAF4cK8Gny3Q+J
         aw2HCRhuq1P1+nxXxZW4SoOjUJEAuy9CX6y33AGUvZVADhBIpBKOJ8svJmrmnQl7DSUh
         ic0w==
X-Forwarded-Encrypted: i=1; AFNElJ+9S1MOaBKIqHPMrxJTiA0Q+L4EgrQN1CkrLnuUgk4XB0MDM6F0YIV6LJMPy5UY5wHeDjvl4MdPYIUQjeqirtJm@vger.kernel.org
X-Gm-Message-State: AOJu0YzC2I0JWpH9LHxoUF1HUR5M8zVZfT8dDU8V5TB5n34R+d1yAEhv
	64CNbfSK9R+bMTSl4b0S+dRuviiSSJ3jpgZ+beoJa/BGtRFElvPaVvmE0ZHzfwFeFoHOLu7JYW+
	3sdMNeMNz2A==
X-Received: from dybb21.prod.google.com ([2002:a05:693c:6095:b0:2d9:61d4:4d0e])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:300c:b0:2d9:3616:d897
 with SMTP id 5a478bee46e88-2e478a338c8mr19801407eec.22.1777156904906; Sat, 25
 Apr 2026 15:41:44 -0700 (PDT)
Date: Sat, 25 Apr 2026 15:40:32 -0700
In-Reply-To: <20260425224125.160890-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260425174858.3922152-1-irogers@google.com> <20260425224125.160890-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260425224125.160890-8-irogers@google.com>
Subject: [PATCH v7 07/59] perf python: Add missed explicit dependencies
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, adrian.hunter@intel.com, james.clark@linaro.org, 
	leo.yan@linux.dev, namhyung@kernel.org, tmricht@linux.ibm.com
Cc: alice.mei.rogers@gmail.com, dapeng1.mi@linux.intel.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Fix missing #include of pmus.h found while cleaning the evsel/evlist
header files.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/python.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index cc1019d29a5d..1e6c99efff90 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -5,26 +5,29 @@
 #include <poll.h>
 #include <linux/err.h>
 #include <perf/cpumap.h>
-#ifdef HAVE_LIBTRACEEVENT
-#include <event-parse.h>
-#endif
+#include <internal/lib.h>
 #include <perf/mmap.h>
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
2.54.0.545.g6539524ca2-goog

