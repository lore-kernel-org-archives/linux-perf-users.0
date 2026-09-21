Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D30518132
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Sep 2026 19:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790018076; cv=none; b=J6xQg2GguRxx5T1Y6lwmYzeuMtH+Cfbkqm3L7FBaMJK+uWro/DnkWXTTvxU2CKYjwN0HBL0J/CJBCOVNKoK22AT6x4aNJhCUJhyMeN9f6b/j3w0ZVbnF37f6cFhQTvT0cEszvt1vtR7p5eCNVgBfdiQBjjosexoASrt93Z7E/ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790018076; c=relaxed/simple;
	bh=O7cl1f+Ku4ElVI+j9QzehZwaOw2RzUkvNTSUsc1KYbg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QMhYmCe4f4KVdNNOY9dOrINW/iM/29IysHXAskZgHTD8LVSBNZUa2p4wmxpHvhmEFg75L8gDfDAME3j3y2ttM8ZHwf3ZQKTf0Utvq+JnZj0s+Z+aqZ4HcJLmN38u0ktrhG7zuulVzPDaWRAZ1XzcgkN8Ltcubsq2rauh0rUZ7B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PZ6cGLIG; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PZ6cGLIG"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38e54b6556aso4351144a91.2
        for <linux-perf-users@vger.kernel.org>; Mon, 21 Sep 2026 12:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790018072; x=1790622872; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ASz4Q0ucM2e9v/JxsDfEs/Vr8jUfdWFu4QQmoSAdRYc=;
        b=PZ6cGLIGuVvxXa1ARyc/vwXvNwlnRNXrREQwzmJxgzWecsX2qDYMYjdrPE+8UD0NcG
         yUV8dUjg0Zucs+i3pRDFjPvDQKskh4t9h6PJZD4jmvemNOA06FJ/amW59RrXjIKxj7w3
         wyxpK1Kxj5ai998/QH3T81Tu336KfExrl47YHJy+B+MvircdUCp56sea54zez+bPIu/Y
         jNMxbe3gGNmO0QnJaO5iX38emTUsuWkb+mB+thge79kEc1ySB008T5ws1Rs19ZJB/EDT
         96miQZR3YgzkSWjaBttT4sj4h3dF0pKan6zkZUtDVYcE0BbOwhCE8m+FuSjicecIFHjY
         ta7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790018072; x=1790622872;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ASz4Q0ucM2e9v/JxsDfEs/Vr8jUfdWFu4QQmoSAdRYc=;
        b=FRS0nST4nLIjpa9+k62stpAILKSAdDkfIuHgyb9f3agishVAVxIwp/U6a/WGXDxknF
         Op2rPXVIyqyeq42GtiDzt6Lqy36n17lODil0GYBD1WwESBIEYwdy4miZUB/KWZb7DP9t
         EXcZtu5BrDQcYAIj6j1Q6Kwp8WUct0WxUyl43e4D6YFaJb0d4OOm+pJGDejO8EJqs4Ba
         YjYhN/QcGMENtGG4UkuC4EPfwQbkmA8QJKOw2l1ZuiqXCCF/gCaS80BJEZHEQR84Ix0e
         JGM7Pq64Bx8JnX81YyF7Fc2s7PLT5KRrB3eZXYMnjGNetS43R3ZbmN9TL3qggUwuRU9S
         ibNA==
X-Forwarded-Encrypted: i=1; AKwUvBxG3o34qD+BbBimVehr6cfsJ6mSEK3EoVKZSC2THOfbb2izzsNA8J3OHx90yibPx2cB5CY++8XyC+td+OnuwOGO@vger.kernel.org
X-Gm-Message-State: AFuF++kGzJbrOPPS11NgBY3bo1zx/2d4hc37zDZeitF2JO16I9n1mXQA
	DuQp2Yy4SdigV+VMqX6KTon6b/IECsBWOuBwF7PFhZPzBDwbPobfr2YC9YZGixlEvmqm2J4T6UJ
	KOV718Q==
X-Received: from pjbml8.prod.google.com ([2002:a17:90b:3608:b0:3a0:40b2:70ad])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:d648:b0:39e:6c6a:4b6e
 with SMTP id 98e67ed59e1d1-39e6c6a549dmr10605450a91.56.1790018071987; Mon, 21
 Sep 2026 12:14:31 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Mon, 21 Sep 2026 12:14:18 -0700
In-Reply-To: <20260921191418.950933-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260921191418.950933-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260921191418.950933-11-seanjc@google.com>
Subject: [PATCH v4 10/10] perf/x86/intel: Check only PMC bits in PEBS_ENABLED
 when detecting host PEBS usage
From: Sean Christopherson <seanjc@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Jim Mattson <jmattson@google.com>, 
	Mingwei Zhang <mizhang@google.com>, Stephane Eranian <eranian@google.com>, 
	Sashiko Bot <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"

When checking to see if guest PEBS usage should be disabled due to host
PEBS usage, filter out non-counter bits in PEBS_ENABLE to avoid getting
false positives in the unlikely scenario that "Enable Precise Store" is
enabled without PEBS actually being active for any PMCs.

Note, the other "hidden" usage of pebs_mask is already explicitly masked
with intel_ctrl:

  .guest = intel_ctrl & ~cpuc->intel_ctrl_exclude_guest_mask & ~pebs_mask,

I.e. removing the non-counter bits from pebs_mask doesn't change the value
that is loaded into arr[global_ctrl].guest.

Fixes: 854250329c02 ("KVM: x86/pmu: Disable guest PEBS temporarily in two rare situations")
Suggested-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Reported-by: Sashiko Bot <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/20260508234018.F06AEC2BCB0@smtp.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/events/intel/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index d9315bb2f221..1ff0586c7b71 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -5323,7 +5323,7 @@ static struct perf_guest_switch_msr *intel_guest_get_msrs(int *nr,
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	struct perf_guest_switch_msr *arr = cpuc->guest_switch_msrs;
 	u64 intel_ctrl = hybrid(cpuc->pmu, intel_ctrl);
-	u64 pebs_mask = cpuc->pebs_enabled & x86_pmu.pebs_capable;
+	u64 pebs_mask = intel_ctrl & cpuc->pebs_enabled & x86_pmu.pebs_capable;
 	u64 guest_pebs_mask;
 	int global_ctrl;
 
@@ -5375,7 +5375,7 @@ static struct perf_guest_switch_msr *intel_guest_get_msrs(int *nr,
 	 * the guest wants to use for PEBS, (c) are not excluded from counting
 	 * in the guest, and (d) _are_ excluded from counting in the host.
 	 */
-	guest_pebs_mask = pebs_mask & intel_ctrl & guest_pebs->enable &
+	guest_pebs_mask = pebs_mask & guest_pebs->enable &
 			  ~cpuc->intel_ctrl_exclude_guest_mask &
 			  cpuc->intel_ctrl_exclude_host_mask;
 
-- 
2.55.0.1082.g2b9226bbc0-goog

