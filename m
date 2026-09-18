Received: from pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.83.148.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76B54EB848;
	Fri, 18 Sep 2026 16:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.83.148.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789747256; cv=none; b=rnsjCAjdNGBHzFYxYF4kAOGYpM6t9Iy1UufPeQsY2Vm6SwQZN95UrGa6rzSbJGHruGwPLGM/FNLsrFUgqrCCNlgoNhSK2UGnRdtxeMWm9Gjw0NODB/hJlX0zA70ulfGjHk+ZW0YSso8VBiiFxb8sAm0JzsJqKxBHxAlbyzvTLGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789747256; c=relaxed/simple;
	bh=0+NmW0yuunUN7TMYhQWcFHP4iIDHmZEoU9fdYqtJ+Sw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lm2uts3bXASN4Y2V3D3ckgfdqRJ+k6MKK0/drrRgH0MihZbK+ALILX7nXe5d6IQqgf5VzX7qy/oAWmE7T8/rmPVp/XjECzS0Jt4hRAXN3r+t2RmQFhZiyysLUNKdZL8/lIKOpxKV5qHr1at/bwMzC8p45xajX6ZkKZ2OwpsQojo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=NKJEEbCw; arc=none smtp.client-ip=35.83.148.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="NKJEEbCw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1789747253; x=1821283253;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=C3tRnEYkqajiLChdahyToqWOlutIYKfUA4+9xK4HMvY=;
  b=NKJEEbCwQKvl3AgNRkb3pwP5g04X4Y4uwtuL0G7DGnMUC/HtVYuE72O5
   y4XOubtYwPlRVEadz+ggQgyEci9+IyUcsd2Yvao7+T/qybedKWIJFwZIo
   3wTwmaFLefwmyCo7cJI9Jk16S/5AmtZgXH4qR75uVjklRRc9WfQM2Z1ay
   lSCpH01TBlAVB/2vw8l1oTY2aWFnfarEOG3g/Bkxq8Ri7j9VzIrxy2EIS
   vjMwn8nvtB0Q95XuGXDTNT/EPYZ6hzXY+VKsgyX0jENdcpb/uo6AX5rm8
   /vMBKavlP7H4Q3auMC4tk4V9vFP3NcUf9O2o0uec5iPeu3SnZLYPgJq7H
   A==;
X-CSE-ConnectionGUID: 6e71Z9pCROe9xcCptqrHsg==
X-CSE-MsgGUID: 2YjCH/zqTjS5BlqPCk/3CQ==
X-IronPort-AV: E=Sophos;i="6.27,109,1787011200"; 
   d="scan'208";a="28836459"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 16:00:51 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.51:25941]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.16.195:2525] with esmtp (Farcaster)
 id 7df2a9a6-f922-46a2-85d0-5f5d6f539dbe; Fri, 18 Sep 2026 16:00:51 +0000 (UTC)
X-Farcaster-Flow-ID: 7df2a9a6-f922-46a2-85d0-5f5d6f539dbe
Received: from EX19D001UWA002.ant.amazon.com (10.13.138.236) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.46;
 Fri, 18 Sep 2026 16:00:50 +0000
Received: from dev-dsk-absandze-1c-663c31a8.eu-west-1.amazon.com
 (172.19.91.26) by EX19D001UWA002.ant.amazon.com (10.13.138.236) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.46; Fri, 18 Sep 2026
 16:00:48 +0000
From: Luka Absandze <absandze@amazon.de>
To: <seanjc@google.com>, <pbonzini@redhat.com>
CC: <sandipan.das@amd.com>, <tglx@kernel.org>, <mingo@redhat.com>,
	<bp@alien8.de>, <dave.hansen@linux.intel.com>, <x86@kernel.org>,
	<hpa@zytor.com>, <dwmw2@infradead.org>, <kvm@vger.kernel.org>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Luka
 Absandze" <absandze@amazon.de>
Subject: [PATCH] KVM: x86/pmu: Don't retry a counter whose config was rejected
Date: Fri, 18 Sep 2026 16:00:06 +0000
Message-ID: <20260918160006.61816-1-absandze@amazon.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D035UWB003.ant.amazon.com (10.13.138.85) To
 EX19D001UWA002.ant.amazon.com (10.13.138.236)

kvm_pmu_handle_event() re-arms the reprogram bit for every failed
reprogram, on the assumption that the failure is transient and a later
refresh will succeed.  That is true for contention, e.g. the -EBUSY from
x86_reserve_hardware(), but not for a configuration the host PMU driver
rejects outright.  A rejected config can never succeed on retry, so the
counter is reprogrammed on every PMU refresh for as long as the guest
leaves it enabled, and every attempt fails the same way.

Skip the re-arm for -EINVAL, one of the errnos the x86 PMU drivers use
for a config they will never accept.  Note this becomes reachable on AMD
only with the patch linked below, which starts rejecting the Merge event
(PMCxFFF) a guest programs as part of a Large Increment per Cycle pair;
on Intel it is already reachable today via the INTEL_FIXED_VLBR_EVENT
check in intel_pmu_hw_config(), where the config is likewise a function
of fixed guest state and can never start being accepted.

Link: https://lore.kernel.org/all/20260916123315.89042-1-absandze@amazon.de/
Signed-off-by: Luka Absandze <absandze@amazon.de>
---
 arch/x86/kvm/pmu.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index a7d60c8785cd..b9945a6256ed 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -680,8 +680,14 @@ void kvm_pmu_handle_event(struct kvm_vcpu *vcpu)
 		 * reprogram bit, i.e. opportunistically try again on the next
 		 * PMU refresh.  Don't make a new request as doing so can stall
 		 * the guest if reprogramming repeatedly fails.
+		 *
+		 * -EINVAL means the event's config was rejected outright and
+		 * can never succeed on retry, so don't re-arm; the guest can
+		 * still do so itself by rewriting the event selector.
 		 */
-		if (reprogram_counter(pmc))
+		int r = reprogram_counter(pmc);
+
+		if (r && r != -EINVAL)
 			set_bit(pmc->idx, pmu->reprogram_pmi);
 	}
 
-- 
2.47.3

