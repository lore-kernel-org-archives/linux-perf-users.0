Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52BB3749E8
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Jun 2026 21:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781041852; cv=none; b=mIBs9n6Vj4dIxK3YpjGXR5ZlaeMtrAn4JxCSN2nGFSyviRVuBG6RFh0StVX1qubpeGJs/Zqk3+ISgdY2QI0lynNqHxdxqVJoOc+n2Tt6j5snuOsNecp4YPUUALyTCTI21404CTHR6/RXOYTz+MHoMvhPEELaP3ypgwwJjcyP/Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781041852; c=relaxed/simple;
	bh=82goZWYErTBOqea7+//2fOMx3xz9QPsMKMIUcwKs0/8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=I4sPFKZ6Z2vIMQrMZQBRUy1GPqrWE0/sPJzSSknnP5FF7dcxvS/SA4JmiFtIOacI+20zbW19jKDoRAYflIleb/xcxsmcMUfxOOsV9kVfdrOT4zt+qhUwa2FMgm+xOkjzRzxkICIkJOBafV7T5x3JJxyWVJtE1ozjKao9El3642U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Un/S6JWU; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Un/S6JWU"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2c2b64850easo9003295ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 09 Jun 2026 14:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781041851; x=1781646651; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vD6M+PWiN+Y/gqC8odOLN0+OnegpcgUZO20uPCwVPYw=;
        b=Un/S6JWU7EXKuDfNvuDOSGsbuLrTvCWbMBTdCsCGpA24avgTLqATNXRL+dC9mXw4ot
         YlxLIyjCQjKNVxJg/VtKlr9uFXfMcWOfrbRfKToyaYFnGYbl4/Rbjf8GCAvoycwY5lC9
         RCdsgWKWAgQq8j46tcRtrKuUK3IBduAsCRgy3qhMtKWiIhstqgQTO+mxq1RMuI8jav+l
         fLsZR97sFNjOIZ0+LeihiOPwNqU52YeqfLcnOHNMi6l9swkk0q3qwZZmpIZksgXZ4pDk
         Lwd8keLK+S9fNC0nW4a23LhVxgc1VUuMrNZxBonjVucVcMCWijmsYHR9PmVn3PyjIgG2
         XzuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781041851; x=1781646651;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vD6M+PWiN+Y/gqC8odOLN0+OnegpcgUZO20uPCwVPYw=;
        b=RlZulTareaWQIM0Yv22KuYYhhvu3AJXNmC+t2I3B83XZLanFzy0Fb//vNEXweUlgqf
         /Dt7iE8Gqtxyad0AIWxNIYobwLbqOvVTDpNuGfRAxroX7A7wddojZZsyJplzfnzLEFfo
         okEeaj1UNiJXdXz+hvXtbsBpsWzxS7JnygzzJDFzAPFLa6D1RMevrLC0zJvlQTssV1qY
         blos3u8ReMSdVZiDx/sNo82drFK9eedcUfv/znwZbWSgTEo9kTlUlOCU6t1n7CNzlVZN
         ceqPx4oh9VzxnBbsJ+JJ0XtyLgfXvZDUu0SU1VT3Hp8XKqRNXdQeFOuxw3xEgFD+epy7
         D+fA==
X-Forwarded-Encrypted: i=1; AFNElJ/1IsdNYVylThesLsb709Ii6wBDCiz9QF0Y67MDIzSiWBQOr/+xZmBNP6p2fzbnxSd8YXWcx2spZFLE3ltuGK/6@vger.kernel.org
X-Gm-Message-State: AOJu0YzBbvFodbVEezg0gi3JO7qbphFNyAjFAwOBp2nqJgL9Zk5fN2r/
	7gLMuMoO6wO/jOl4C3RYILRcNpYvRYVJ+7EOg5JwZgrJoXgeT/CB4F8kbixFJ5BOpQvQ1RLTGYa
	MGiQ39Q==
X-Received: from plblh6.prod.google.com ([2002:a17:903:2906:b0:2bd:c5f9:e27b])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ef0a:b0:2bf:2e28:db28
 with SMTP id d9443c01a7336-2c1e8232ec8mr275652575ad.29.1781041850759; Tue, 09
 Jun 2026 14:50:50 -0700 (PDT)
Date: Tue,  9 Jun 2026 14:50:41 -0700
In-Reply-To: <20260609215046.2391903-1-ctshao@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260609215046.2391903-1-ctshao@google.com>
X-Mailer: git-send-email 2.54.0.1099.g489fc7bff1-goog
Message-ID: <20260609215046.2391903-3-ctshao@google.com>
Subject: [PATCH v1 2/6] perf vendor events intel: Update emeraldrapids events
 from 1.23 to 1.24
From: Chun-Tse Shao <ctshao@google.com>
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org
Cc: alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
	adrian.hunter@intel.com, james.clark@linaro.org, afaerber@suse.de, 
	mani@kernel.org, dapeng1.mi@linux.intel.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-actions@lists.infradead.org, Chun-Tse Shao <ctshao@google.com>
Content-Type: text/plain; charset="UTF-8"

The updated events were published in:
https://github.com/intel/perfmon/commit/3f1d40d1953193e75c6b5a559638cf1f67bacaed

Signed-off-by: Chun-Tse Shao <ctshao@google.com>
---
 tools/perf/pmu-events/arch/x86/emeraldrapids/cache.json | 9 +++++++++
 tools/perf/pmu-events/arch/x86/mapfile.csv              | 2 +-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/arch/x86/emeraldrapids/cache.json b/tools/perf/pmu-events/arch/x86/emeraldrapids/cache.json
index ff6071d7728e..a44e1f027c1d 100644
--- a/tools/perf/pmu-events/arch/x86/emeraldrapids/cache.json
+++ b/tools/perf/pmu-events/arch/x86/emeraldrapids/cache.json
@@ -368,6 +368,15 @@
         "SampleAfterValue": "200003",
         "UMask": "0x40"
     },
+    {
+        "BriefDescription": "Cycles when L1D is locked",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x42",
+        "EventName": "LOCK_CYCLES.CACHE_LOCK_DURATION",
+        "PublicDescription": "This event counts the number of cycles when the L1D is locked. It is a superset of the 0x1 mask (BUS_LOCK_CLOCKS.BUS_LOCK_DURATION).",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x2"
+    },
     {
         "BriefDescription": "Core-originated cacheable requests that missed L3  (Except hardware prefetches to the L3)",
         "Counter": "0,1,2,3,4,5,6,7",
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-events/arch/x86/mapfile.csv
index 613881d04a9a..0f39073805ba 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -9,7 +9,7 @@ GenuineIntel-6-4F,v23,broadwellx,core
 GenuineIntel-6-55-[56789ABCDEF],v1.25,cascadelakex,core
 GenuineIntel-6-DD,v1.02,clearwaterforest,core
 GenuineIntel-6-9[6C],v1.05,elkhartlake,core
-GenuineIntel-6-CF,v1.23,emeraldrapids,core
+GenuineIntel-6-CF,v1.24,emeraldrapids,core
 GenuineIntel-6-5[CF],v13,goldmont,core
 GenuineIntel-6-7A,v1.01,goldmontplus,core
 GenuineIntel-6-B6,v1.12,grandridge,core
-- 
2.54.0.1099.g489fc7bff1-goog

