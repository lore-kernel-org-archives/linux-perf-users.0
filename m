Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8278C4A99C6
	for <linux-perf-users@vger.kernel.org>; Wed,  2 Sep 2026 15:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788364150; cv=none; b=fyDxHc65Nrcmvgu0SPFdMCHoJdvmaudu6k5vSr3yLRWv4MpmgrN+kz/PFAt8USSZ1l9qr7MQQyATCzu1X6e2Ye+ZIxvA1D7814l0IgBnspRwHy3KHHJzVILnY1uvGbl78SPFpJDlcIQw1xMAv1BUFE9JG7yRfEmvOdbCqqih/iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788364150; c=relaxed/simple;
	bh=MXekJXZ5T2i1lOP5yjKvUmgkVu177dnr4EEiTiMxEyo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=uaf7TDAzWIzawBoodPtxXINBF//qhOvw+B5GbXteCVvCeldlGu2mrlzBy2ynvOGO6TynenYiI18YU0yxTHNL7T26rFpRSk91FHBuVyF9VbPoazNFjQMFXpYBvS/ByXzFZ8hDf5go0a6z10nGHc8T7bunKKFgM/ibmV+ZMVXLd64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZgTayEbk; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZgTayEbk"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3968bb86fb7so1678014a91.2
        for <linux-perf-users@vger.kernel.org>; Wed, 02 Sep 2026 08:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788364148; x=1788968948; darn=vger.kernel.org;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tUrm+ROxdJ59YfAdcXGaIH4WCqzrRXNZfGKynOJVM1Q=;
        b=ZgTayEbk4mi76BuvDGlNvumMkosB0pvqVbWpfSIZJwLEip9T0WHsg3NYqzrDn1GNRF
         YcaXoSfjJU+13X50nRtA9Im1Si/S76ncNtofn3PzlZWL7Wceo2fUJWIGKkerwAEp5xJC
         RRpl+QHy0psxeuOB1PKGPuOHH7tZM03T9GyoHqEEaLWDVpBtkqMzdLaTnAH6rnjxgwYm
         a/oaaTRHg2mjECEmO8uIFWhYMog/qdR9wB/bT4jSb2cw01uY6xRbYOjJLJVMhyswi4i+
         IKzGNAjw5eA7638LRuhHHPnO6l87bx1cppnN3DpkfIvvn/eLremswpfs5P2VX8uq5oZz
         YuUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788364148; x=1788968948;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tUrm+ROxdJ59YfAdcXGaIH4WCqzrRXNZfGKynOJVM1Q=;
        b=S0cXvY/TuGlOP/DFap0omadKCSq5kez4CjWZghg2pSgrhySbZzhbBPAOsQ4DbJOi4j
         6H3ORg4p7BmUzfA0UJP/gr/L3RBi7sHy+JXhhoBZ6rZNKG5ts+S3RAyGb4UJDFDzuMNk
         xr9kJlDsn8lLMX+9XlE5cxKCsfXrHapHPt0Et3Km6s5DQ5NoPRuTFy1KvZ8HStLVhHtb
         z7DdbMmLin12facAagetsEXCOPonNRylIGYsUogoa5fcPupfD+g1aWYKB5/Lcb8wdL2U
         BEgSKdJ/IXT2RqmrTDvSC7wm2EJSJ7jkiNdzTkQqsgmWtKlHmCpAqinSmkawFmEHFveL
         z/oA==
X-Forwarded-Encrypted: i=1; AKwUvByeKTNbxN7moNWcDiHY8cbxZ3ZOGi58w+9VLys55rZOFV9Dfj4f+UceYedHKrxib4IkJm2X8F0ymnG0g9kIsP9x@vger.kernel.org
X-Gm-Message-State: AFuF++mNNsuTbMFji42qjowPbAhdmBCwNrKsL51n/UR5L9YqODg1ttwZ
	6arOtqCt/Qo5leOPR4VJ9jA9NjywJ9h2ATDmvve7a0OkuClHBxo2z7HxTjgKgYOXdhXl1RjajO3
	mgb7ftsR8gw==
X-Received: from dybmh46.prod.google.com ([2002:a05:7301:f2e:b0:30f:2f43:117b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2d4f:b0:37f:e1b6:4c7d
 with SMTP id 98e67ed59e1d1-39aedf1aec2mr9151888a91.6.1788364147549; Wed, 02
 Sep 2026 08:49:07 -0700 (PDT)
Date: Wed,  2 Sep 2026 08:48:55 -0700
In-Reply-To: <20260902154858.2078885-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260902154858.2078885-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.966.g6673acef38-goog
Message-ID: <20260902154858.2078885-4-irogers@google.com>
Subject: [PATCH v3 3/6] perf tool: Remove unused includes in perf.c
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Tianyou Li <tianyou.li@intel.com>, 
	Jiebin Sun <jiebin.sun@intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Eric Biggers <ebiggers@kernel.org>, Thomas Richter <tmricht@linux.ibm.com>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, Swapnil Sapkal <swapnil.sapkal@amd.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Remove perf-sys.h, internal/lib.h (page_size), signal.h, and perf.h
since their exports are not used directly in perf.c.

Signed-off-by: Ian Rogers <irogers@google.com>
Assisted-by: Antigravity:gemini-3.1-pro
---
 tools/perf/perf.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/tools/perf/perf.c b/tools/perf/perf.c
index 53c50cfd92d6..7e2e667b011f 100644
--- a/tools/perf/perf.c
+++ b/tools/perf/perf.c
@@ -6,10 +6,8 @@
  * This is the main hub from which the sub-commands (perf stat,
  * perf top, perf record, perf report, etc.) are started.
  */
-#include "perf.h"
 
 #include <errno.h>
-#include <signal.h>
 #include <stdbool.h>
 #include <stdio.h>
 #include <stdlib.h>
@@ -21,7 +19,6 @@
 #include <sys/stat.h>
 
 #include <api/fs/tracing_path.h>
-#include <internal/lib.h> // page_size
 #include <perf/core.h>
 #include <subcmd/exec-cmd.h>
 #include <subcmd/help.h>
@@ -30,7 +27,6 @@
 #include <subcmd/run-command.h>
 
 #include "builtin.h"
-#include "perf-sys.h"
 #include "ui/ui.h"
 #include "util/build-id.h"
 #include "util/config.h"
-- 
2.55.0.966.g6673acef38-goog

