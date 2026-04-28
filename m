Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2A83B5826
	for <linux-perf-users@vger.kernel.org>; Tue, 28 Apr 2026 07:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777360773; cv=none; b=eod+o8vKxh0uk0gVwk0IwYPmZm+PoLKRDN4FNE5Yu0yGOb+vn93Jg5MITqkRFOQqi4J1dIhDZ4Oc0eVWQC8t9wjyEpT7ESW6rAiRkWAbHPOpN45mniqIoZElD2NzTlzcm5Y4HkT0LCdegJT3g/IrGobUOpCfh8J8lVyjQoeZKvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777360773; c=relaxed/simple;
	bh=E1A9rOUkigl47RQgwxPU7BZg+a2AkxhYpc7Hpry26ZU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MJZCm6onLyfxD9emLpo48sc4DFSbf9C9HqA9eztIM2ZEDI+b6NfoNjef831RobVK046ePAE3OIHmXxYo9d0xKKq0HvWdn7sW8HyGXK+QyR4haMGFah0DI+bnqtph9WFbU2D+EtIPtI1KwMer5LlUJgcTfVkx8KbbokEqbCgifng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=awTidIZO; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="awTidIZO"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2bdf6fe90a9so17674252eec.1
        for <linux-perf-users@vger.kernel.org>; Tue, 28 Apr 2026 00:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777360771; x=1777965571; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Pih4PvjlzSX23VUBfhxJgrdaziaLdcdiDaL3PE08L8Q=;
        b=awTidIZONyilydFSOvzfPrxYkqEC3dgM68aMpRmSHWDlcxDWGl8sX5WJDl3Vukli0Q
         f1UnzHc7lqq4Pd0QqECMxhwST2340SbljUdM2LxtG/+uQqzqXLJRQBi39mtwS7c+0mVk
         uHdeZOJMXjoc9w8ra726AeTB+qJkVBP/btXsAlXDfBychb1tHmBlxTLUEIZkG+YgA5kJ
         /+INBXEIHFSEuhpSRm+PEMs35EhC0FMs5fzRsR/j8UoCtG0e2lGrN7GyG9t9y2/Z/jBH
         QyG5xZhVV/xzzQ/ujNQ3Df4U6WRvQe1FvgUZkWZe+jhuaJxofwoxuRhH3bIZBsLIfS8N
         ejGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777360771; x=1777965571;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pih4PvjlzSX23VUBfhxJgrdaziaLdcdiDaL3PE08L8Q=;
        b=D7y8I87g9Z140SFnX61NWrMPsVg8xy0+SUDSXRKMMIWFVx7di3txqdbkRy+dwW3gbq
         W2yv/A948n6lugzDTlG4WhbRwIpVHCJkVRa7yrQu5p9Sq3Ev3Js1ggsby4JCDM5o28Ce
         K0xe4D7qQ548ApqYOdr3wzV8xmLaIb9c8R7stpc/xAu/PyoBMOiwAdYTwC1Ogb4cBrrp
         1j9X6BrgM/z/2KFcozkH9Bk3MY3x0wJUTx4q7l/JqVDLYWuY+aulDe2ObSEf9gw+CRvL
         +VEmcQhirD+x2aYxeiC8BKFmE586HOrBD9X9bG/OMnooW1axmw53ldxWB/GbKwe7LFWq
         DpiQ==
X-Forwarded-Encrypted: i=1; AFNElJ+5as+1flLZji2hp5g8+YlVGAo9foFGdXzEINF0pbqXHsav8nt5NiY9U8jNZ0AiMMczmicx4KAbzPFdw7AnxAA1@vger.kernel.org
X-Gm-Message-State: AOJu0Ywhc+y/jhUDCJa0AnEM+tB6XUZqkp1z+H1d95ksUEJ2hurYAHNM
	ww4Y1jBDxEGXpDyzljvPVwMe1wBAfYnDzwqDYUmL8jTNWlIMsXoQN5eOBbrbTD8DWT8gMaR1T7S
	F9DYqvppILA==
X-Received: from dyblf37.prod.google.com ([2002:a05:7301:a25:b0:2da:4e8f:1752])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:d706:b0:2ed:e14:7f54
 with SMTP id 5a478bee46e88-2ed0e1484d5mr414992eec.30.1777360771072; Tue, 28
 Apr 2026 00:19:31 -0700 (PDT)
Date: Tue, 28 Apr 2026 00:18:11 -0700
In-Reply-To: <20260428071903.1886173-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260425224951.174663-1-irogers@google.com> <20260428071903.1886173-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260428071903.1886173-7-irogers@google.com>
Subject: [PATCH v8 06/58] perf python: Add missed explicit dependencies
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, alice.mei.rogers@gmail.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org, leo.yan@linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	tmricht@linux.ibm.com, Ian Rogers <irogers@google.com>
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

