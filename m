Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2763148DC
	for <linux-perf-users@vger.kernel.org>; Thu,  4 Dec 2025 22:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764888931; cv=none; b=tBwyclf5+fC3juRRP7ie16cj8dSJ9eK3tvqPPS7ajJsKH3h/zamA4jUAfqElSFNgB769LRc69khgqMQvybM6duhFTOMzdWrfNpBFw5X6TFkjpsP68mj854aQHoJ4fa/2uGg1BNZ66lkEiwIMBQXemWDKskzEfylH23l6r/aeyhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764888931; c=relaxed/simple;
	bh=DGe9Vy9zmgdGUoBEH3MWfQwClG5qTDX4JxU/pQMq5q8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=TPIRxN+HDadmF1vyETJl7lfq9uEkSSnkhusMzozpplIVjbvtyF39IuA+YSS+wxtkZod5lvt8hkYmN9km6FhSowrkeorMuZJj14lyonTGXGtfbBj472wgZWZ1dDUyfF7PMg84y0KiwVqfmVsC9t/61At/HLw8bDDuggw6BXcB1qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BUOf59/R; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BUOf59/R"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b993eb2701bso1441766a12.0
        for <linux-perf-users@vger.kernel.org>; Thu, 04 Dec 2025 14:55:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764888927; x=1765493727; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=axSruUIa9K6T1U3yaJmf1l5NCwp2YA+Fi+pd6Guv0ds=;
        b=BUOf59/RvKvJJCb3pfs/eSo3yg8+fJdSOgrJ0/Q+HX+iWalE5On9au/jhZ1CgX9ghZ
         aCdmwisdxO/6XY0I1DAL47tb13W6ymEu34hjwHp66xV4dwwvf+4lKN3BKxmLbJD2Gb9Z
         RcMymjjzw32z0Erh0wFiOfcWY5Omwh3Dsbnt0nuEBsv7YwlCuzAtYWy+rYCcKm7eYVxm
         vL9xyF6zYZM2y2NF4DFxUDDPYkP/z84wN7/3dyJvteTqJghSCEem+e0AFUHMMRxnHzS/
         OjAvrFnZMEI5EzGCvvMNmvLhWYvOFnnBdvOJ6OGhciP7OTpLhsRJ95JGamJ767j4H0CC
         FBfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764888927; x=1765493727;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=axSruUIa9K6T1U3yaJmf1l5NCwp2YA+Fi+pd6Guv0ds=;
        b=LTl4ZTX2BDXTILT7KWPBWUc7xejxyEItGQRIssp0r+1N1PKpzkfX1Pp2e7d9GfhFhh
         JdbL5009lYDjBqggy/Xyfu+XxO8zh1Os1bB5ExFieWiD4eSiKaKZBBKISnTEN6BBfLSe
         4RlzyyasKGGMWG36IXPsiTtkb0dFCn0HEtGlFcg3gBav339nyouFZyYPpzBfvMAljFIT
         JDgugAW7aHoeWJVkoXB9tqqMAhMd0DEMuDhSvLYlB2sC1Tg+psHqIKsnrmOwNRG6i5jd
         2cO61ACRvoyhU07rPplcyf1Gj759fujl+UcK+Qmjamj7O7eTkoE5qgNBko40nExCZyhE
         uD+A==
X-Forwarded-Encrypted: i=1; AJvYcCW6HLw4tNEur4DEbnIqiPc6PzgC2udG/KaJn4PCtsA+CbMpgsWRSfcgN3bfS/6WC8Izm4THRTS+89QE6bONHSZE@vger.kernel.org
X-Gm-Message-State: AOJu0YyAEoKy7vrN4gxWmhUNRotVv5MALk07xWLCp8VbVkrPEutP9JNG
	WZT6y6jidqALJCsug7vS3TXYFDyjzSU9qBo8HLT3Cyc6PJu0OvcEdXEZxG4dhjc8oc0oFNFubcX
	DbtGEfh3IUA==
X-Google-Smtp-Source: AGHT+IEbr1TuqBCnDak4BdpM2SJzdGSWGgdo4k5+WJkWtcc8N0l3li025IA4GRsP3qLuKDO7dBU6efwg0yBI
X-Received: from dybmj48.prod.google.com ([2002:a05:7301:e30:b0:2a2:318c:8559])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:4716:b0:2a6:a099:b8de
 with SMTP id 5a478bee46e88-2aba451be1bmr2412174eec.30.1764888927536; Thu, 04
 Dec 2025 14:55:27 -0800 (PST)
Date: Thu,  4 Dec 2025 14:55:22 -0800
In-Reply-To: <20251204225522.648456-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251204225522.648456-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.223.gf5cc29aaa4-goog
Message-ID: <20251204225522.648456-2-irogers@google.com>
Subject: [PATCH v2 2/2] perf tests top: Make the test exclusive
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

With sufficient tests running the load causes the top test fails with:
```
123: perf top tests                                                  : FAILED!
 --- start ---
test child forked, pid 629856
Basic perf top test
Basic perf top test [Failed: no sample percentage found]
 ---- end(-1) ----
```
Mark the test exclusive to avoid flakes.

Fixes: 75e961730b9e ("perf tests top: Add basic perf top coverage test")
Signed-off-by: Ian Rogers <irogers@google.com>
---
v2; Tweak commit message  log lines starting "---".
---
 tools/perf/tests/shell/top.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/top.sh b/tools/perf/tests/shell/top.sh
index 768ebcf7a89c..ad7fccd09025 100755
--- a/tools/perf/tests/shell/top.sh
+++ b/tools/perf/tests/shell/top.sh
@@ -1,5 +1,5 @@
 #!/bin/bash
-# perf top tests
+# perf top tests (exclusive)
 # SPDX-License-Identifier: GPL-2.0
 
 set -e
-- 
2.52.0.223.gf5cc29aaa4-goog

