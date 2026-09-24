Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9734AE8B9
	for <linux-perf-users@vger.kernel.org>; Thu, 24 Sep 2026 17:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790269494; cv=none; b=prY3VT07rI9mZ8ChIsoc8TjoxXUQrMdMvP27AJ2HfKEbEEqn1HZLikHstbNsWBCkm+dR/o3+4X9yJeavQWanFot9eG4UHZx+YATUNSYnSK9gHQZRlDx1WuJSkMwgqf3LAchx5w1q7ivZA/X4Y1SgN62kdlLbjgc4kNrk5PEUBPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790269494; c=relaxed/simple;
	bh=vRGzqGIlueLNWtQ8mBqOPzucPtt/EnskvKASwmARJEg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=McAoajLtXTXJOdTKV/VS4ItuMpuISHZmPY0Lt/jtYR8NePAx6/7m0Afov7S8MJgWO5veaPta4uMaqL962eQ0Ki4CHlzf9DDT2GzQe8gotaPhvLi/x+qajJ7Q/8o59Cdf82Fb8wRpHGgRmTAVbBGA+WqIYbZdjU9lLESB9jRxbu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n2JP6X04; arc=none smtp.client-ip=74.125.82.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n2JP6X04"
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-1437272611eso14211c88.1
        for <linux-perf-users@vger.kernel.org>; Thu, 24 Sep 2026 10:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790269491; x=1790874291; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8lcIs7RyJTfuHtKg0oQjtOQnslTm8POjmTtQi8k9Ex4=;
        b=n2JP6X045MG63dSYnczW2BMKIHFW2cR/RBLft7HMqe9JurRWxIM0LDIoDgbpAL+h1i
         bXjUM6fAFp/KPvXq1dbieR+Rd7Kvzo6HLET2ewI8xDnUocEZs4zR+Omp8Aq7bBnomdsM
         +75pGMdj6f4cq/d8gFfQbfdC6PSOHpkTRVd426yvaDEOkw6PHz3Hj8b021jGAy1cMTgf
         T53JZC4iTIBPrxuQlrQu2ZStmQwcmI+AW4ZTGgN9BJLujWZw5qavB655BTv6ldhSyDTm
         dq1Ynps8m7ZjSQ3lffs+iyY+CSAgjZAhHMh5fSTuABqcKHQCPx9BqVNU1grDiUky7X6R
         fetw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790269491; x=1790874291;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8lcIs7RyJTfuHtKg0oQjtOQnslTm8POjmTtQi8k9Ex4=;
        b=P0Ojgr0hPzQtzGeg+IdR3r/1PN1Yyut5N5mmrnP+sbI897J8+VnjT/FNcI/gPpyts5
         kY/dikY04A7p506GZHWrVhM00BWrOKlr2eQafYjvVX2zkAsLHOyl7uATnljlcGNGWn79
         VSfgFkdg5CnIgmbNSvuBLBUfmwnBlbxvnNu94A2Chnvu8w6U8FlsxJ52nvOdu4SGHbRa
         BN2MmG4HnIxhp1xib286m2sq2alLjv34WcUj2mUtY/3spdM+4Y3r/nd94mSysfUWvwsw
         hffuGPNCWiU7Z1HDko5lpbjmu8aCQ96Cy1qiwnZU5uWraoLZ5DBvmUJbbfvMVyarZwU7
         uhWw==
X-Forwarded-Encrypted: i=1; AKwUvBwB1Z7wS3HzkshffDwb0pQqPyUbvajCztsEERtuAhNQZV+Q9GNpZFqc0BSRf1mYhoIMop/xVjiJxxUJW7zMCSS4@vger.kernel.org
X-Gm-Message-State: AFuF++ndByTsK2/ojR1s4NThLm/DbQpQBBdr7tMncLWmGksXK2AdfGpP
	IjNuug3idR9nhHjjEYtdwhRsqz6OqifqMifjGsR3NrmX2/FfU81f6mrGEmWHniVIsk1iZ9hrYW6
	Vu4wSFNHGtQ==
X-Received: from dlbsn1.prod.google.com ([2002:a05:7022:b901:b0:144:c2b6:8f47])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:1304:b0:143:39a0:19b5
 with SMTP id a92af1059eb24-14503fb84cfmr2574842c88.22.1790269490054; Thu, 24
 Sep 2026 10:04:50 -0700 (PDT)
Date: Thu, 24 Sep 2026 10:03:42 -0700
In-Reply-To: <20260924170346.3872848-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260924053645.3555041-1-irogers@google.com> <20260924170346.3872848-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260924170346.3872848-23-irogers@google.com>
Subject: [PATCH v2 22/26] perf vendor events intel: Fix clearwaterforest umask encoding.
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, dapeng1.mi@linux.intel.com, 
	namhyung@kernel.org, edward.baker@intel.com, perry.taylor@intel.com, 
	eranian@google.com
Cc: adrian.hunter@intel.com, afaerber@suse.de, ctshao@google.com, 
	james.clark@linaro.org, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mani@kernel.org, mingo@redhat.com, 
	peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

Fix UMaskExt that was wrongly encoded when the UMask was 0.

Fixes: 1a5c515eae7c ("perf vendor events intel: Update clearwaterforest events and metrics from 1.00 to 1.02")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../perf/pmu-events/arch/x86/clearwaterforest/pipeline.json  | 3 ++-
 .../pmu-events/arch/x86/clearwaterforest/uncore-cache.json   | 5 +++++
 .../arch/x86/clearwaterforest/uncore-interconnect.json       | 2 ++
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/arch/x86/clearwaterforest/pipeline.json b/tools/perf/pmu-events/arch/x86/clearwaterforest/pipeline.json
index f73686174af9..6cea91277d5c 100644
--- a/tools/perf/pmu-events/arch/x86/clearwaterforest/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/clearwaterforest/pipeline.json
@@ -934,6 +934,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc2",
         "EventName": "UOPS_RETIRED.X87",
-        "SampleAfterValue": "1000003"
+        "SampleAfterValue": "1000003",
+        "UMask": "0x100"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/clearwaterforest/uncore-cache.json b/tools/perf/pmu-events/arch/x86/clearwaterforest/uncore-cache.json
index 278837f2068a..e065236e9525 100644
--- a/tools/perf/pmu-events/arch/x86/clearwaterforest/uncore-cache.json
+++ b/tools/perf/pmu-events/arch/x86/clearwaterforest/uncore-cache.json
@@ -700,6 +700,7 @@
         "EventName": "UNC_CHA_REMOTE_SF.DIRBACKED_ONLY",
         "Experimental": "1",
         "PerPkg": "1",
+        "UMask": "0x4000",
         "Unit": "CHA"
     },
     {
@@ -729,6 +730,7 @@
         "EventName": "UNC_CHA_REMOTE_SF.INCLUSIVE_ONLY",
         "Experimental": "1",
         "PerPkg": "1",
+        "UMask": "0x2000",
         "Unit": "CHA"
     },
     {
@@ -747,6 +749,7 @@
         "EventName": "UNC_CHA_REMOTE_SF.UPDATE_EXCLUSIVE",
         "Experimental": "1",
         "PerPkg": "1",
+        "UMask": "0x100",
         "Unit": "CHA"
     },
     {
@@ -766,6 +769,7 @@
         "EventName": "UNC_CHA_REMOTE_SF.VICTIM_EXCLUSIVE",
         "Experimental": "1",
         "PerPkg": "1",
+        "UMask": "0x400",
         "Unit": "CHA"
     },
     {
@@ -775,6 +779,7 @@
         "EventName": "UNC_CHA_REMOTE_SF.VICTIM_SHARED",
         "Experimental": "1",
         "PerPkg": "1",
+        "UMask": "0x200",
         "Unit": "CHA"
     },
     {
diff --git a/tools/perf/pmu-events/arch/x86/clearwaterforest/uncore-interconnect.json b/tools/perf/pmu-events/arch/x86/clearwaterforest/uncore-interconnect.json
index 1f6e0970141a..7fa6def25379 100644
--- a/tools/perf/pmu-events/arch/x86/clearwaterforest/uncore-interconnect.json
+++ b/tools/perf/pmu-events/arch/x86/clearwaterforest/uncore-interconnect.json
@@ -515,6 +515,7 @@
         "EventName": "UNC_B2CMI_IMC_WRITES.NI",
         "Experimental": "1",
         "PerPkg": "1",
+        "UMask": "0x300",
         "Unit": "B2CMI"
     },
     {
@@ -524,6 +525,7 @@
         "EventName": "UNC_B2CMI_IMC_WRITES.NI_MISS",
         "Experimental": "1",
         "PerPkg": "1",
+        "UMask": "0x500",
         "Unit": "B2CMI"
     },
     {
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

