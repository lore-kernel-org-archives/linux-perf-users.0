Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB7D37F8BC
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 22:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777157428; cv=none; b=GL2iM0jCXkziYVB3yZhR9WVQEnUOVaatKKTZPUggqQ+q079sgvo8BtH9383GYvPdnNFKpz2zwpCqEydsOTGK7RmGTQUSynWDdlNrkkkr1Vz0Vvc6hRqY5wkuql9kPLckAcoDblbMa4kdnQCeIy8sQsx7JmVs4k9KXcIhQ29GGoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777157428; c=relaxed/simple;
	bh=E1A9rOUkigl47RQgwxPU7BZg+a2AkxhYpc7Hpry26ZU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uMrJL5ytcMiPS/gbcDzjGl0zAdjbJfAV3Ww4EHTqmPuVzd0BhloBPnc0WMBGvdLZ68P+Woa4VJ5BJek/ACAuz0wb8Shm01ivtbwmIiWVPfIlapNIn/lKIkM62ps7enYeaKgfecAE3WceXSLRKsxEtPBfGzc9ni9gpdmyzj8jcMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wgCznQXf; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wgCznQXf"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2eaf70f3b5fso734204eec.0
        for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 15:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777157426; x=1777762226; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Pih4PvjlzSX23VUBfhxJgrdaziaLdcdiDaL3PE08L8Q=;
        b=wgCznQXfY6MDRwspWi9+E5grmFcCWBvVx2FAuM8RX554wVHbWbTmXBJfFpdWImUism
         UfUsxb4MDKEhFBQcIVjjTEXOgj4nerSJHg7sa+XTYpsVEx8bXNN84BJ22n4kHgScbzxP
         MY2rVNdiVhR5K4SO8MW+etCf7kQHqehgSprYaEVfTWjLKgOuSSKLwGNvaa9xQYtqAv7g
         egYrEJqNYQkmOVJl8KdHaP6pJmoTy0LNpeTwmIRsm7Vk7Td6AwBB03fs5WlCqgQ5MR+9
         o/Wf6/17eliaYkUG1EVJP/RfxTLoygzx4BWT8rfa9eaH3Hwih+HSssGEztltou43jSUa
         GUYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777157426; x=1777762226;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pih4PvjlzSX23VUBfhxJgrdaziaLdcdiDaL3PE08L8Q=;
        b=SQ628VR2xxmZWdofKzzuwDF7kKcMYystsfloUSIsJOGQ5uOalbOzzBQAmrSYbEfqCf
         kuM2YFUPWCeDYaZkI74yR/njN8FXdGwOlZmmHXf39JYiF3iXF8c93lAttfeQWJI13K1l
         QloTYJPdal8x2lFYlMs3hFlU1RR/27SZyCijEmjtyI9Os7+o6ORcTCUil1aw6VnHib7T
         s5YPffPqUyevR8vh/EsdDqkTFS04jyn1oXzMPXCDBxaKKOcYPsMa4Aw2H3v3odKq2/Ei
         R1JZgujfKLmaQDBNKpHOk6lzHFi2LMSnwYgP6t79qLsGTFePg68qFEszZQeyetvYu54y
         FNZQ==
X-Forwarded-Encrypted: i=1; AFNElJ+W3We8tl3bg4zfAwS6YeMsFSuuNG7H10fBXKerraVNPY5MmlaTna4nVZiICxxP1/jeZN2vwHGSf5RknD4jCohI@vger.kernel.org
X-Gm-Message-State: AOJu0YwcUwNMmmvm5AzayRipxOshV+sHnGPTEfCG2umk5QafqWpLdFD0
	7vsN0NkEb6U+2Iyn8rZfyIGsCgT1d6GUYcYulBkUTzcwuJ8XKAJ80+P+Dqco25uBtmyJTRROodj
	R9J4m1gUwIQ==
X-Received: from dlec6-n2.prod.google.com ([2002:a05:701b:4286:20b0:12d:bbdf:edcb])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:90a:b0:128:d715:b717
 with SMTP id a92af1059eb24-12c73f82878mr18014490c88.13.1777157425996; Sat, 25
 Apr 2026 15:50:25 -0700 (PDT)
Date: Sat, 25 Apr 2026 15:48:59 -0700
In-Reply-To: <20260425224951.174663-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260425174858.3922152-1-irogers@google.com> <20260425224951.174663-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260425224951.174663-8-irogers@google.com>
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

