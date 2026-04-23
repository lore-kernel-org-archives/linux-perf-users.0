Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D34535F5E3
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 15:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776956631; cv=none; b=o0NUFh3nEhtuColZ8A7Sz8/R0N4+e9qEO730DD7nKzYV5ZbVzbc/MB7L1f82JcYGiiFEY94NBMsB5k8f/KJMy3qOmPP+zpLe9rvl0wst8sLubq3rcYI1DKl3A02BRqEcHajET23v0oeKChiC8RV6GsNPBgBXmmFCgiCCiEgZbVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776956631; c=relaxed/simple;
	bh=Qq+a1DlHnsbnGt0qwZoOkE6eAMMyZT69FHNC3qdZqpA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hx+mUdtcVF/j4ET0Wk3UdcNiwHUpSU1vpksoj+agGw12fD32R5IJANIShie1KGQ6tBmepb3Rp4PDOxvqH08Uru28G5lpajPfmf/LvDOMD1QUn8jop8AcL0OnwiKSXENV5Jlzyv18KjlrRiStiGassUXxoReGAVGZVD7eofA6lMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YuZZs/B1; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YuZZs/B1"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c797d8c9c2dso7042066a12.2
        for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 08:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776956630; x=1777561430; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=Aj9Le9dSw7rMaT45LUpduHxRBjTdQmy+Rvmt2ooyxYY=;
        b=YuZZs/B1kl28xdh7IROcrI5qPNfRCKiTanK5eSe71mgY1tRaw/DSUsM3TB9d3zT3Sp
         XXs3+xBoh1PCXxEloBAdeRDMGQB2yEKrUnRud0fiSaTp7w6cVWuflGrxkfrLE6yA4CM5
         rVKlJar0pPbT/NWdWx8sw+QCltfSLnTmg+YdDFytzqWhTmjXxz2oVLWojk5hXvNYUTZ0
         CBf14XpJ3rnfphIC5iW6+E9+3Ymv7NPWr91F7LJKLqYgcsoCVP9x/oVQ8dphQnp22AbC
         /5qPP9sNobAqbUrOkKvNMKYIythBGA8gyAQdZ47DTB+u6H1vmJLf3bhHQmp/NoViRrv6
         IAWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776956630; x=1777561430;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Aj9Le9dSw7rMaT45LUpduHxRBjTdQmy+Rvmt2ooyxYY=;
        b=g7nMTgRf4Y+dHapXMC+4NHCm0JnBEZb4nFb3y9WhU1K82P5FZxtC4GOu0S6AEunPRZ
         9tkghJGvKGmCYJNWKorAGMKp+tU4v+G8sJCHraq2L9t7Z/WvC14eJfLCQg3ATOJB2D8l
         tksgpUaA6vV72+MzjYb6MZhL95aou3kHLck5EEXbi56fL7Zhxpbp2MsqYJPPdN+lytVH
         46yJx/d43AcE34F5F7FT7tH8jMXiRyegQLpeMgw2hTTPnkBSLhcwSZ16jkxNhtQ3Q/py
         uBXOIvM9jwl9Euj6CjK5ormiKdnGh5DztzwTeWmO5HFFKLAp3zMnTJvvzuf9VQHn1Mrr
         C8xg==
X-Gm-Message-State: AOJu0Ywi/jf0bkU5Yq5FqMD+wD2jehEkWEA/dkcAAnineQaHyQtqmsTC
	TxLo7QLFkhJSzNncSnCtySuTrBKxc+ncK8f92ErohqHbyiQVoaks9Vk/odMBHU0UF7h+aN97+UK
	gFY8MqQ==
X-Received: from pfbho17.prod.google.com ([2002:a05:6a00:8811:b0:82f:7833:9aa9])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:9996:b0:39b:bee4:2952
 with SMTP id adf61e73a8af0-3a08d908020mr32339418637.45.1776956629325; Thu, 23
 Apr 2026 08:03:49 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 23 Apr 2026 08:03:39 -0700
In-Reply-To: <20260423150340.463896-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260423150340.463896-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260423150340.463896-4-seanjc@google.com>
Subject: [PATCH v2 3/4] perf/x86/intel: Make @data a mandatory param for intel_guest_get_msrs()
From: Sean Christopherson <seanjc@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, Jim Mattson <jmattson@google.com>, 
	Mingwei Zhang <mizhang@google.com>, Stephane Eranian <eranian@google.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

Drop "support" for passing a NULL @data/@kvm_pmu param when getting guest
MSRs.  KVM, the only in-tree user, unconditionally passes a non-NULL
pointer, and carrying code that suggests @data may be NULL is confusing,
e.g. incorrectly implies that there are scenarios where KVM doesn't pass
a PMU context.

Fixes: 8183a538cd95 ("KVM: x86/pmu: Add IA32_DS_AREA MSR emulation to support guest DS")
Cc: Jim Mattson <jmattson@google.com>
Cc: Mingwei Zhang <mizhang@google.com>
Cc: Stephane Eranian <eranian@google.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/events/intel/core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 407fd392fd46..7403ca721b6a 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -5038,11 +5038,11 @@ static struct perf_guest_switch_msr *intel_guest_get_msrs(int *nr, void *data)
 	}
 
 	/*
-	 * If the guest won't use PEBS or the CPU doesn't support PEBS in the
-	 * guest, then there's nothing more to do as disabling PMCs via
-	 * PERF_GLOBAL_CTRL is sufficient on CPUs with guest/host isolation.
+	 * If the CPU doesn't support PEBS in the guest, then there's nothing
+	 * more to do as disabling PMCs via PERF_GLOBAL_CTRL is sufficient on
+	 * CPUs with guest/host isolation.
 	 */
-	if (!kvm_pmu || !x86_pmu.pebs_ept)
+	if (!x86_pmu.pebs_ept)
 		return arr;
 
 	/*
-- 
2.54.0.545.g6539524ca2-goog

