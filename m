Received: from pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.12.53.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DEB26656D;
	Sun, 20 Sep 2026 15:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.12.53.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789919721; cv=none; b=XbkED7GpR7Hic6Iic2ZM+oRtcW8A6JQP/Rv++kbLgDcP6xzF052Y7W577dpDq+Dq6kPQHy9LEFGLzEkh2jtS1+GfetardGHCPvyyCi6aOKmf2Ow0oLgMjhF4P1dVmxaOzNYKjyfyOFUpUXkvoDWFu4TYdEwrqCdJQ7NlknLI8A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789919721; c=relaxed/simple;
	bh=rLgv7qLwYF3dMOMdbJjYPHQL2tgAOi+0YYvwz2I+FOw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YzUYZQ41Pq5LYjqk7NqylmfGZTM0WfQhh9xcQK9kKbp1+8oBdfdKNIrFYRK1neNQGwLGsP80oGko112kWN8LkZxGia8vWLOs9y3KU7uk4ADr/m3aiZIgM1Nu9G+xJRBkjeJORtr5aq+GmwuN1YKcQQIYNtKk0aoWzD7+snBGsG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=WHnKcvfA; arc=none smtp.client-ip=52.12.53.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="WHnKcvfA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1789919719; x=1821455719;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ufv8hTRDzIpkbawQnoy9gAIou0Vkaqlh5g4ks7UjcMk=;
  b=WHnKcvfASrF3L7YlUFobNN+TvWJCzsysoGwy9Hwp2w1a0UXAncrK8qnm
   q45uS2KcFJmknQQDQdoICzGT1mmTSFqVH79jA7kw3PBqj24nxCRaj8QEX
   WkCE+tdFT5AuP/Ha9MLYfiNufXAdanvnvToQPY3E12hwBuN2sZg9fU7Ji
   0pbf1VlUUm1QoUgZYEF94ArLd0toQDJW0+AgjK7PMscWTGnJkleEwAlEO
   TUmEMCZIHmqiAnTPva7siIiEYcs7XC68WK4PYUJCVnbGBwD6e9pnFBkMJ
   vUcRnGMNNo5B2iu16FQPAb3K5+vFIn9FsVDV8wMjH8ReVetisFBVan9mt
   g==;
X-CSE-ConnectionGUID: 5EdVn7vYTQW72Vhp7R0EbQ==
X-CSE-MsgGUID: c7W7ESYMRwCFzSANolGQaw==
X-IronPort-AV: E=Sophos;i="6.27,112,1787011200"; 
   d="scan'208";a="29037785"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2026 15:55:17 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.51:18235]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.1.232:2525] with esmtp (Farcaster)
 id 2d9365d5-3058-4889-a10a-9159270bf15a; Sun, 20 Sep 2026 15:55:17 +0000 (UTC)
X-Farcaster-Flow-ID: 2d9365d5-3058-4889-a10a-9159270bf15a
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.46;
 Sun, 20 Sep 2026 15:55:16 +0000
Received: from dev-dsk-absandze-1c-663c31a8.eu-west-1.amazon.com
 (172.19.91.26) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49; Sun, 20 Sep 2026
 15:55:14 +0000
From: Luka Absandze <absandze@amazon.de>
To: <seanjc@google.com>, <pbonzini@redhat.com>
CC: <sandipan.das@amd.com>, <tglx@kernel.org>, <mingo@redhat.com>,
	<bp@alien8.de>, <dave.hansen@linux.intel.com>, <x86@kernel.org>,
	<hpa@zytor.com>, <dwmw2@infradead.org>, <kvm@vger.kernel.org>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Luka
 Absandze" <absandze@amazon.de>
Subject: [PATCH v2] KVM: x86/pmu: Don't retry a counter whose config was rejected
Date: Sun, 20 Sep 2026 15:54:53 +0000
Message-ID: <20260920155453.10836-1-absandze@amazon.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWB002.ant.amazon.com (10.13.138.79) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

kvm_pmu_handle_event() re-arms the reprogram bit for every failed
reprogram, on the assumption that the failure is transient and a later
refresh will succeed.  That is true for contention, e.g. the -EBUSY from
x86_reserve_hardware(), but not for a configuration the host PMU driver
rejects outright.  A rejected config can never succeed on retry, so the
counter is reprogrammed on every PMU refresh for as long as the guest
leaves it enabled, and every attempt fails the same way.

Re-arm only for the errnos that indicate a transient condition, i.e.
-EBUSY and -ENOMEM.

Suggested-by: Sean Christopherson <seanjc@google.com>
Link: https://lore.kernel.org/all/20260916123315.89042-1-absandze@amazon.de/
Signed-off-by: Luka Absandze <absandze@amazon.de>
---
v2:
 - Use an allow-list of transient errnos (-EBUSY, -ENOMEM) rather than
   excluding -EINVAL, and hoist 'r' out of the loop.  Diff taken from
   Sean's suggestion verbatim. [Sean]
 - Reword the comment to say "fails on a transient condition". [Sean]
 - v1: https://lore.kernel.org/all/20260918160006.61816-1-absandze@amazon.de/

diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index a7d60c8785cd..03a470c49a74 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -662,7 +662,7 @@ void kvm_pmu_handle_event(struct kvm_vcpu *vcpu)
 	DECLARE_BITMAP(bitmap, X86_PMC_IDX_MAX);
 	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
 	struct kvm_pmc *pmc;
-	int bit;
+	int bit, r;
 
 	bitmap_copy(bitmap, pmu->reprogram_pmi, X86_PMC_IDX_MAX);
 
@@ -676,12 +676,14 @@ void kvm_pmu_handle_event(struct kvm_vcpu *vcpu)
 
 	kvm_for_each_pmc(pmu, pmc, bit, bitmap) {
 		/*
-		 * If reprogramming fails, e.g. due to contention, re-set the
-		 * reprogram bit, i.e. opportunistically try again on the next
-		 * PMU refresh.  Don't make a new request as doing so can stall
-		 * the guest if reprogramming repeatedly fails.
+		 * If reprogramming fails on a transient condition, e.g. due to
+		 * contention, re-set the reprogram bit, i.e. opportunistically
+		 * try again on the next PMU refresh.  Don't make a new request
+		 * as doing so can stall the guest if reprogramming repeatedly
+		 * fails.
 		 */
-		if (reprogram_counter(pmc))
+		r = reprogram_counter(pmc);
+		if (r == -EBUSY || r == -ENOMEM)
 			set_bit(pmc->idx, pmu->reprogram_pmi);
 	}
 
-- 
2.47.3

