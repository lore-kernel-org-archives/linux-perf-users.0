Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13F525B0AD
	for <linux-perf-users@vger.kernel.org>; Sat, 23 May 2026 01:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779499165; cv=none; b=WPlZSI+vhSeqNPcKqbfvS4nlQt2goBI/iD13z72vRQ896V6JQB51JwczDmpv8VjApnmSVDQ3PyotFIRdOREbDKxHEZiWoh+Tixlk9gu6QmI1FpspVbyqtv/+y1LypRllEmNyBwoDupgialt4TG67zPHKoppeykPDxgKctMfhD+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779499165; c=relaxed/simple;
	bh=DzzFqOliTYt+AVUs3TQyRDSDH8E27xB3aEdwmPGAlgw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=thiKxBZeepoDwtN7bx0qPdrioSx9p8Gw4/1q6iAdR24HyuNZIt3ybe+wTudxGbJDrATm6BfLGm+rB559xcmP/gIJM4P8KnCaxDGGOmzHWmf8e343E8KR3k/RJZt5Dz0vli+dZlu4knb8A7jhybNlnQtLz3JRK8C8mPeUG4u24Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mYxfusMY; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mYxfusMY"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2bc85eda6b6so40037945ad.1
        for <linux-perf-users@vger.kernel.org>; Fri, 22 May 2026 18:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779499163; x=1780103963; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EHhj9hY1DpnCN0woSlOTUtwUQw1k2Y+/7qDhFgxma3E=;
        b=mYxfusMYC36G4Q+JXXjTf2V5j0GcFaAxgQoQcvMW4YrVY87mtJDExgSTKfIGhevqE/
         /j35W0gvpN7CPvh9VVYXwAN0gC34RcFAEX2IqSrqavZpocHR931z5c2IJV2ENmUIhxaz
         VweNM5zgNxz56hu0iDK/uQ4FfWp66LCg9klnp5UaNiWG5BAcLknlB+1JCHwTpPLOMEKq
         m+pQJ4MKu7au5+hz7dKNVtbsGv0LOl656utEH3GbeO43vFrtP2O4R460NAF9rg3IAnCs
         8YDq4V3JUGmvTD5cAhWUhVZ33nFeuxQ0xJpULlhuxOy9cOjsoGGgqYu8j7KKYdtvBBgt
         gJ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779499163; x=1780103963;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EHhj9hY1DpnCN0woSlOTUtwUQw1k2Y+/7qDhFgxma3E=;
        b=ablHh/yIVCY0hCmtyZsq0t1CdJV8bqmapdhFAFBdnAalAROqGjHW7So+FsfBSOBoIz
         CdI8Imym/bNXPd9AXiEojGi5ZOOCYq9Lv/rY2NMlT1jtWhSdX3/eFz3UPr15vN3U58R/
         nK8PibJvATUdls/7d1HEIxZvxpmWBxwjb9iLQ7srl/PRbNaPoGbCZMUndl6zJ4wzQBAz
         0xW2VzRnz6gyZSPabai61y9jiYTrrA8Fic2pLHKvNwgnenJJRFe53jmdro/dATnKmL1N
         a1QRKpGh1h9w9+1/AcR1CYIbrZFzTaxcXRAiWwREa86rHM3j0oM3ihSKPrGrt98d9OwC
         uOQg==
X-Gm-Message-State: AOJu0Yw5b1sLNZFvwlFM/IChI/fRCuKD9lYUM9k9JB2EoHBglfbs9TAK
	0TOr5wiNUNhh3aZOsTJFTHGEYDYcMkhYFaCKtKnMWpBycO3HS+9DzBnGWLLh6lhr
X-Gm-Gg: Acq92OHRPLwUH4M2NzUqb8TpkV9bYBHUtL2DNYhfCJsWKkU/hVQqNypUL4y1oTpvQi1
	p0aF/wiLQ+LjfOm10+x69MM+c1AFHbufa8zYjNs7fLbtB/k2UHenrRFp74S5wTHARFuCJ6sPxlM
	jd+CHubxaBJVa+Amr+qI6cTWfoi+qzVhlIdLCdp5mMAzOksN8oG/2nZpsUWBSgR2kcxdehbtOoE
	5fGi0QDshUsoe5uvSH5y7xG+aireaYTSDhAQJQ3UpTyIduH5TEwU2m+T1MQu/TSovhsrRFPEHbc
	lyd7mZjX1Vp4wYK/4rJapvbtjJ0oZGogxUvSdQ33TKleI8VUTsPixqt1+PbjcCL3ktWHOg5U5PV
	3ozepNzerlI/fQw8NWNXJmi5tJ7sx18fEIP4gHzVModvE7ok8Mid0tNWDzwRWznsClQYr4BfSI5
	W5WMCu1LdrnikL2zxpdKCdpNsxzdETEWLK+BkUX8OIVZj4r0usNBARwvFln0Ha8GArJxRFTQD4z
	I40atA1YJyS4eBCtjkQHdO2FsktfsUaYg7w7ysNH/i7YQ==
X-Received: by 2002:a17:903:4405:b0:2bd:8822:d8c2 with SMTP id d9443c01a7336-2beb06bc0a9mr60851405ad.36.1779499162766;
        Fri, 22 May 2026 18:19:22 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb56ce4easm27209615ad.30.2026.05.22.18.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 18:19:22 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-perf-users@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	"H. Peter Anvin" <hpa@zytor.com>,
	linux-kernel@vger.kernel.org (open list:PERFORMANCE EVENTS SUBSYSTEM)
Subject: [PATCH] perf/x86/amd/uncore: turn amd_uncore_ctx events into a flexible array
Date: Fri, 22 May 2026 18:19:04 -0700
Message-ID: <20260523011904.101720-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The events pointer was kzalloc_node()'d immediately after the parent
struct allocation, with the count (pmu->num_counters) trivially
available beforehand.  Move events to the struct tail as a flexible
array member and fold the two allocations into a single kzalloc_node()
with struct_size(), dropping the separate kfree(ctx->events) in the
free path.

Assisted-by: Claude:Opus-4.7
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 arch/x86/events/amd/uncore.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
index 05cff39968ec..0e265fc1fef8 100644
--- a/arch/x86/events/amd/uncore.c
+++ b/arch/x86/events/amd/uncore.c
@@ -39,11 +39,11 @@ static int pmu_version;
 struct amd_uncore_ctx {
 	int refcnt;
 	int cpu;
-	struct perf_event **events;
 	unsigned long active_mask[BITS_TO_LONGS(NUM_COUNTERS_MAX)];
 	int nr_active;
 	struct hrtimer hrtimer;
 	u64 hrtimer_duration;
+	struct perf_event *events[];
 };
 
 struct amd_uncore_pmu {
@@ -488,10 +488,8 @@ static void amd_uncore_ctx_free(struct amd_uncore *uncore, unsigned int cpu)
 		if (cpu == ctx->cpu)
 			cpumask_clear_cpu(cpu, &pmu->active_mask);
 
-		if (!--ctx->refcnt) {
-			kfree(ctx->events);
+		if (!--ctx->refcnt)
 			kfree(ctx);
-		}
 
 		*per_cpu_ptr(pmu->ctx, cpu) = NULL;
 	}
@@ -536,18 +534,11 @@ static int amd_uncore_ctx_init(struct amd_uncore *uncore, unsigned int cpu)
 		/* Allocate context if sibling does not exist */
 		if (!curr) {
 			node = cpu_to_node(cpu);
-			curr = kzalloc_node(sizeof(*curr), GFP_KERNEL, node);
+			curr = kzalloc_node(struct_size(curr, events, pmu->num_counters), GFP_KERNEL, node);
 			if (!curr)
 				goto fail;
 
 			curr->cpu = cpu;
-			curr->events = kzalloc_node(sizeof(*curr->events) *
-						    pmu->num_counters,
-						    GFP_KERNEL, node);
-			if (!curr->events) {
-				kfree(curr);
-				goto fail;
-			}
 
 			amd_uncore_init_hrtimer(curr);
 			curr->hrtimer_duration = (u64)update_interval * NSEC_PER_MSEC;
-- 
2.54.0

