Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8405D383C88
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 22:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777157414; cv=none; b=IJs8IFDyINmSpmio17ceBV1ITQsXgPyWWhN1p8tNEf4x4cWIiLBS4KSUB8KKgtdi7Cass2ziCgJ9kMBO2IrE5wUhshKE5mm43atFI4NlCwnYwke7WoaT9zHJWTfzASVLt0UT/QF/5/+ted1jNbJTGK8EdpGNCXWifL7TaPCZ10k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777157414; c=relaxed/simple;
	bh=bITPVK77ksbOupCd8yIPNfKlXiQAinH05MI73w7M+5Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WeXLdedDtk/QmvuTgpnEj4cHnj6/8ojgKzjmjKCNObouQsvbe4jtGxBvpGnJXejQRRqQt1MYPhkEQzjvTwkS2OopI5uSUAh3I1DWhPx+uBvm5L4JQI6vrCOWs8D7YylltVVVD8i2kO/MfWezqDXZClvc6n0UmtqffrRgwWbQ7ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LFgyv/t5; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LFgyv/t5"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2d8a677cdfaso9577370eec.1
        for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 15:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777157412; x=1777762212; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=K/xS7q5C5QGMJMPDSriSnCglCHYvD9rGLYFUY/AUodE=;
        b=LFgyv/t5T1uAHZG+z6tVJg1BfW7SvVNkFPY1uC28F1ihATnkHOdQuRxH1vfg563F7s
         b2y+TxFFctVQ9cU3XPLdgQGBIujGoX8GAABPiSHqPVLzb9RjysARwN8/D4EaoyCffVUf
         kN8Xu/iMPuhJqVXn/uV/9VNWLG7nIXOX/IPJ2eD3y7jZoxXhMAfFO1iX0kV1qPLWIKpb
         wWMtTF/ghcHDCpz55lpcRfdO3J5kATVyVKevLxMK/tUNUh3Ym1YGFCXr32rc5pBVqFHe
         LeNv4VcPp47TAmRLJMnuw4T1Sps00tZEgWWXt1vc70o51c1A27vRq/lh/U+bAJB3opED
         bx3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777157412; x=1777762212;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K/xS7q5C5QGMJMPDSriSnCglCHYvD9rGLYFUY/AUodE=;
        b=HXDciaWHbQUzDjvYb54eoIeJM3s38jLC9iWY9Urt/oh7/4P7oTBXYzA6r4Mea1P0Vn
         pbPc+yCbI77bk3OMyBjyC6+haSBZ9hhEzvDZEe9diN9JULj0XZYZiPO4xrR7SewxK0Iq
         8jaltJyT0tJb0q+VEbR6cgo/uEHbB1OhWHA7RWL6RT1MogK2iiUJaethnv/CIyG33kIw
         wPR/QJ82mMZzfXm9FAZxeSs+RaRGx3ZM3HEyXsQZlEM1qZAaq7NEIw9BN86yObFfMlCA
         vOdDDhFLuFlWOieheBQuHVPKpcUUH99a0fAMw6wyxr4H16jER2d59F6qsm3KHJiVnG+c
         eUPA==
X-Forwarded-Encrypted: i=1; AFNElJ/vMoLRbPBz0QXiuhIL9SMK5bbIOfAp3zJUDvAp8Visg0SVL6efN2rCfujX0v+YjQzZPWcZMt3medM/QYCXvubJ@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq3GjNZNobGvjo9WR/vhg4JepZsLrkwwvJVRQfK5DO6sS2s8HT
	bvAfOCfIFcvg2C1LE3DA6rRUIInyCHBlYJSbWcNyVeShVVqTgV5zhrGUXhLKKTEyjr8wv0A9lOr
	w7BX+HVtXbw==
X-Received: from dybnj1.prod.google.com ([2002:a05:7300:d081:b0:2da:5e63:c8e4])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:3108:b0:2d8:df01:d9f6
 with SMTP id 5a478bee46e88-2e478c20551mr20278918eec.23.1777157411417; Sat, 25
 Apr 2026 15:50:11 -0700 (PDT)
Date: Sat, 25 Apr 2026 15:48:54 -0700
In-Reply-To: <20260425224951.174663-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260425174858.3922152-1-irogers@google.com> <20260425224951.174663-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260425224951.174663-3-irogers@google.com>
Subject: [PATCH v7 02/59] perf arch arm: Sort includes and add missed explicit dependencies
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, adrian.hunter@intel.com, james.clark@linaro.org, 
	leo.yan@linux.dev, namhyung@kernel.org, tmricht@linux.ibm.com
Cc: alice.mei.rogers@gmail.com, dapeng1.mi@linux.intel.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	Ian Rogers <irogers@google.com>
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
2.54.0.545.g6539524ca2-goog

