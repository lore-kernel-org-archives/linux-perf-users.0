Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008692B9BA
	for <linux-perf-users@vger.kernel.org>; Sat, 26 Jul 2025 00:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753490429; cv=none; b=Yk9FrkZbxA1G1ngbAyZ5kDHEpeecXYrVNsJlyDLXfWh/DZhj8EHTe5WmPae3mvoIh/LIIh+eoP482z3Uxpakplsjg7rJHtkw6JTo8tKkWfbFWIBsYOdaBp0QcExX3JueX3JYTnDIjaMKbgEIPWW6/12vRnk/yB5hxso4/X1+Jt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753490429; c=relaxed/simple;
	bh=n8D/edGFZL/hgNbZYwUtmezqHxp9oRlZEQVwjzRgobQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=tjVPjLlKJ6p4yvtJE63uxK3A/SFUGkEZA12WAqr1/VTohDP4XRAjqtxN7AQO2ImJcMbDDnmDJATO/LolhF1OZiXthOUvzS58S3iBgoYkiSnO73ApvqW0dF4KnD+r7FBK7M4+dPQyiSEwy8Ly0dTSsHCSGgY77BM78o1S/OT2920=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--blakejones.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DMy1RK62; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--blakejones.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DMy1RK62"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7492da755a1so2363720b3a.1
        for <linux-perf-users@vger.kernel.org>; Fri, 25 Jul 2025 17:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753490427; x=1754095227; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9Zqr8X01SGutVjV/XNi7iN/97nh5Gk7Veb9QakNbtvc=;
        b=DMy1RK62tQPnRAgekk7WhgdtAX1l/XVigu2kmRxQCUGSpm6RU2e7WRRjsruS/swRy7
         l++hEVQ1NhI2AuMJBoeahRo/tQsLXHcjjSbs3tahT6myVe5gkxfabWdYLIMiY2QyZIbx
         HHlmA2oYBRafDPaOH6i6B6S+oKTJPnt9obQxrJOGOP/roqOZManW5E5mZyuzYa08TN96
         0QDJl5raj8JbglyqAWlb3RxzB4IIRBOCH+X6/CTUmwMRUWT8+mOQUOclFXDkpF4jHomU
         m7+z34z/SsEwFciZ/Czo4Wu1KVteVaNk/5Q6JDIzk9tPpKOZn3TzAkUDLXM1Vu271/ur
         QTEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753490427; x=1754095227;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9Zqr8X01SGutVjV/XNi7iN/97nh5Gk7Veb9QakNbtvc=;
        b=W8gZ0cddXKkwfIxXED2R3x2XQXJmC8LQW+RpyXVo8Xvh2QTqfhDVjEpzLdkk1gf+9e
         LMjiLFFXNRf6KT1i/QH0Al+XanmgUCDesPKatHkKROTWA80cK2HfGVMFtzYWsR6FimP/
         e9fZcZXaZtVPuMuL8Z4bED4XGyPDRyRtTS7J0G5Ba1KGYzbBUqc9Q+Mk3Xjh0wkLPO5q
         2ONu9uHW3oFPt3/hOc2sEDLKg8mHUeFBjKwSXt/1I67R9hRFywXmr5TZnZmsI0e5mCRq
         pdrL+ULRyDQGzNq2K4g64dlcnfGEHVoRniAkOAMrClZPlK/uzCgNEd3+YedSKOY5LaNr
         mYFw==
X-Forwarded-Encrypted: i=1; AJvYcCXbdnleoEPdJQmxlafaIXBJIcNIwJR60VCoJxoDfpjSPgeXbILiymntRsZV4zBIcJDrB540lWCcypl2NrrRmpjJ@vger.kernel.org
X-Gm-Message-State: AOJu0YykwyEXZmbzdxhcWGfULKz05wjfj2XdqomMRhSNBPXN1+kX+a8z
	pq/RywU+TUEwa/qYbv5Up5WcZ4wZvY2+cahxYUQaXR6SxnLXEa63X4xOKWWQ21i3ji0ghBfXLZ4
	APSL1pzfltS9YirW85Al3XQ==
X-Google-Smtp-Source: AGHT+IGSoo8WdGl+OGvbRnbs0+/8TM4wBhGm55waZ4GSl0VDmPb7RoWgx3X4IQSiC2YjsJugCZwIw0DRLCTKodF2
X-Received: from pfau2.prod.google.com ([2002:a05:6a00:aa82:b0:748:34d:6d4f])
 (user=blakejones job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:1953:b0:748:2cbb:be45 with SMTP id d2e1a72fcca58-7633583028dmr5161224b3a.15.1753490427032;
 Fri, 25 Jul 2025 17:40:27 -0700 (PDT)
Date: Fri, 25 Jul 2025 17:40:23 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.1.470.g6ba607880d-goog
Message-ID: <20250726004023.3466563-1-blakejones@google.com>
Subject: [PATCH] Fix comment ordering.
From: Blake Jones <blakejones@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Blake Jones <blakejones@google.com>, 
	Collin Funk <collin.funk1@gmail.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Commit edf2cadf01e8f2620af25b337d15ebc584911b46 ("perf test: add test for
BPF metadata collection") overlooked a behavior of "perf test list",
causing it to print "SPDX-License-Identifier: GPL-2.0" as a description for
that test. This reorders the comments to fix that issue.

Signed-off-by: Blake Jones <blakejones@google.com>
---
 tools/perf/tests/shell/test_bpf_metadata.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/shell/test_bpf_metadata.sh b/tools/perf/tests/shell/test_bpf_metadata.sh
index bc9aef161664..69e3c2055134 100755
--- a/tools/perf/tests/shell/test_bpf_metadata.sh
+++ b/tools/perf/tests/shell/test_bpf_metadata.sh
@@ -1,7 +1,7 @@
 #!/bin/bash
-# SPDX-License-Identifier: GPL-2.0
+# BPF metadata collection test
 #
-# BPF metadata collection test.
+# SPDX-License-Identifier: GPL-2.0
 
 set -e
 
-- 
2.50.1.470.g6ba607880d-goog

