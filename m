Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECD538F922
	for <linux-perf-users@vger.kernel.org>; Fri, 22 May 2026 22:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779487484; cv=none; b=H/380pyMjq8yu0CJR0EUwXpJxAoc0znrYdM8xUQY/wKwD3J/Zz9bsqaV/ZzANLJeOCdgp6zauBpYLX/IP68/uWXTAgJkCtSGB7Wvv6O1ilTHKVPJY2N7xk12KemKR21YjY17W0qliDpPodscwszVn4k/ed8V2UDj+ttob1AAZbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779487484; c=relaxed/simple;
	bh=m5R+sCCXKM4jnUfwhDHD5GSN9hBWZMwmWUd1WWzWGVk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=I2oVRgJ33pOfCfmH/yoNKKBnSGFWEaKQtuNVLeEEncMsiWbjLPZz86I026jy2WGyfC82KSKD+v8cJtiePFSDm7K9Rw+2j6+T8+WejrisqNxspOC8NlN5HtcSx8DawJe2FLyo+pMarCj/QmtVDmUWjXnXf692k6pDoKISi68k4g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uT6hyeOP; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uT6hyeOP"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-1353bfdbf99so10479347c88.0
        for <linux-perf-users@vger.kernel.org>; Fri, 22 May 2026 15:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779487482; x=1780092282; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+PYEbQ/Ax7WxxTaHLwQ4Nrd/42MyXIVdzUn7wSkN0kc=;
        b=uT6hyeOP+mt53cxLyep3yvO6bA95QJ7SOH+AYeFtXfuMz9g5r7V/6yTE5O2epFn5/h
         vc+ZZTPqb3AjtQ3D3mb7zARuc+ik67B0/R+WrfQDLwaXoyb8uM7eh4Cm4jeqdEKSX3ZD
         kfybbl0oQYuv78Tivy9U5tKTU943lv3WLSj4NqSXMCeuM08x0Qn/bJh7bgu5M1BprGAg
         htkQPlQIU39Jzs/4pSpr9+nAL+OxBk01qaUJM4fQ5ZOxJ6ndz3ec7lbN6A/Rx2vUzyjP
         e/9Feiq39cdyNtVNeMJYCR07fJv0nDfou5mQjVdJwgO/SIUHHEktliqRJMhYF3egd8kc
         xm9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779487482; x=1780092282;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+PYEbQ/Ax7WxxTaHLwQ4Nrd/42MyXIVdzUn7wSkN0kc=;
        b=OqeEIfreVRoUshbIoDNDftVWLAZ6UXcfy0d5b3ujJ5QKN/FX22JBuFLMRugmukSx91
         Q2jLcoGo7+4W4uPLQTCOgXQEtdo/8hTAUyoGsp4JeiXIiqKrRtF5/h1ChCFcPyTEu6Ku
         KmGCbvl2RTyXF55ZhxYLghBOe12se/s/EBee7/wcQMVXE2I9Sm/iaqnWnXBo6sYzeHrX
         LjNTpOGHOSWVTyEIcv30bDy5ndCNz9tM2BPvqPwlon9RwTJlVb0sPGFHs572jV/6b2jv
         d2pbKnEmNsvKaKqsz9/qkJNULI0/nrHG5qdmDJDRUNvuC1CsuA+TTGWCJmHvAmCCpC9U
         tX5Q==
X-Forwarded-Encrypted: i=1; AFNElJ8QWLv1mZ3vItfkJmf2UIG9Vt0HE3YfOIsqnjHP+JVwxBd80lLj9CEEIAR2MuLGxtj2WBrDXMp69uwjcePhiSKG@vger.kernel.org
X-Gm-Message-State: AOJu0YwiFH9wOOjleMdeItRT3iJnq7qh5IJQUtpy0uCx2QdWD0VI4/F2
	JANBD80UAaSG1wY6c6hw2a5bz/4ZyhkIkmTaE9h29NeHDV/FRzDF0i5Un7AvGgPczpKWDk02Bnm
	xX0wWu2KRnA==
X-Received: from dlbpk9.prod.google.com ([2002:a05:7022:3849:b0:136:1858:9f25])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:62b:b0:12a:68cc:3efb
 with SMTP id a92af1059eb24-1365f821dc7mr2239685c88.16.1779487481501; Fri, 22
 May 2026 15:04:41 -0700 (PDT)
Date: Fri, 22 May 2026 15:04:12 -0700
In-Reply-To: <20260522220435.2378363-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260428071903.1886173-1-irogers@google.com> <20260522220435.2378363-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <20260522220435.2378363-2-irogers@google.com>
Subject: [PATCH v9 01/23] perf arch arm: Sort includes and add missed explicit dependencies
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, alice.mei.rogers@gmail.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org, leo.yan@linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Fix missing #includes found while cleaning the evsel/evlist header
files. Sort the remaining header files for consistency with the rest
of the code.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/arm/util/cs-etm.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index b7a839de8707..cdf8e3e60606 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -3,10 +3,13 @@
  * Copyright(C) 2015 Linaro Limited. All rights reserved.
  * Author: Mathieu Poirier <mathieu.poirier@linaro.org>
  */
+#include "../../../util/cs-etm.h"
+
+#include <errno.h>
+#include <stdlib.h>
 
-#include <api/fs/fs.h>
-#include <linux/bits.h>
 #include <linux/bitops.h>
+#include <linux/bits.h>
 #include <linux/compiler.h>
 #include <linux/coresight-pmu.h>
 #include <linux/kernel.h>
@@ -14,25 +17,24 @@
 #include <linux/string.h>
 #include <linux/types.h>
 #include <linux/zalloc.h>
+#include <sys/stat.h>
+
+#include <api/fs/fs.h>
+#include <internal/lib.h> // page_size
 
-#include "cs-etm.h"
-#include "../../../util/debug.h"
-#include "../../../util/record.h"
 #include "../../../util/auxtrace.h"
 #include "../../../util/cpumap.h"
+#include "../../../util/debug.h"
 #include "../../../util/event.h"
 #include "../../../util/evlist.h"
 #include "../../../util/evsel.h"
-#include "../../../util/perf_api_probe.h"
 #include "../../../util/evsel_config.h"
+#include "../../../util/perf_api_probe.h"
+#include "../../../util/pmu.h"
 #include "../../../util/pmus.h"
-#include "../../../util/cs-etm.h"
-#include <internal/lib.h> // page_size
+#include "../../../util/record.h"
 #include "../../../util/session.h"
-
-#include <errno.h>
-#include <stdlib.h>
-#include <sys/stat.h>
+#include "cs-etm.h"
 
 struct cs_etm_recording {
 	struct auxtrace_record	itr;
-- 
2.54.0.794.g4f17f83d09-goog

