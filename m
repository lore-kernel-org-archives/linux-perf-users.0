Received: from pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com [34.218.115.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E810C397332;
	Wed, 16 Sep 2026 12:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.218.115.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789562045; cv=none; b=aImVY4r294lyVf5NKHdui4JDM1ggwsRfpiwTX1q//XHdmMSed88r5FTfEP1XN/dGuhpNgYBOrGDlMcfSzebGQAyeawlj6WZX3dp3PxtJjTVAVoNkzCLmy4Ad9pD5vveVIRhFfmQFKzEuoxY3Lku77L7d6xbGg9LfKa8w1YFSeD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789562045; c=relaxed/simple;
	bh=CTYpGLfzf06i6XjDq87lF0QNPY4CEguC68xK62qqZGA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LpVEXUr+3J4mxFZXfKMx6JoywDO/s+uhWRrnoxVrRkWOVlwBy9HHoW0oQ2QdZqRsF1DesVU+1S4jg2zFCh7vZKQ3AmTbjAXyo2Cfy5ljyUrF8R+AHJsY2oyyLShadUuIKKr4Vi7enkuafob4h6RVLanXhljISc1mb96OuVyG0x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=Mrd98u5p; arc=none smtp.client-ip=34.218.115.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="Mrd98u5p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1789562043; x=1821098043;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5NxDUihJPHiGDRQYSDDtVC+R4CeSGVyeXtq6Wtw8UtQ=;
  b=Mrd98u5p0fKGpX4kTHKmY/4M6SEyvB5i3rQdQEx8wqs4q5R930F9R9/p
   1P9lHRIMHdMO+pM5I5Xs6YIiNgZKLIm5L3aS5UyjDoby5Ja67AQDBFzHR
   vduLhAK68nqv5eZgn8Y2FRWns/1YHM2Fr0Z/DaQNUg2IzRnou197DyUUD
   L7rXMXQTewKMgX9YMBwwN2TRH9zqteWXzDnj0L30is4j1y4sldXIGUSiA
   S7y1oVQ17zfUGQzA7E9BNnMzxMeBItd25/SLT5BA+j+LhyH4SWfntyCaD
   zPuzObXdUjRqOM04J2AA8A/Mgf/Pp2NISzxTczbPJonLBVwfSmc0JG29X
   A==;
X-CSE-ConnectionGUID: P2CMm6IrRJiqbYeIRza5gg==
X-CSE-MsgGUID: 2bgfVeYvQUin65kJlC7fLg==
X-IronPort-AV: E=Sophos;i="6.27,103,1787011200"; 
   d="scan'208";a="28611434"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 12:34:01 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.178:2947]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.5.10:2525] with esmtp (Farcaster)
 id 430a1dff-0731-4995-8b18-068a5ea79f19; Wed, 16 Sep 2026 12:34:00 +0000 (UTC)
X-Farcaster-Flow-ID: 430a1dff-0731-4995-8b18-068a5ea79f19
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.46;
 Wed, 16 Sep 2026 12:34:00 +0000
Received: from dev-dsk-absandze-1c-663c31a8.eu-west-1.amazon.com
 (172.19.91.26) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.46; Wed, 16 Sep 2026
 12:33:58 +0000
From: Luka Absandze <absandze@amazon.de>
To: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <tglx@kernel.org>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <yaoz@meta.com>,
	<dwmw2@infradead.org>
CC: <kim.phillips@amd.com>, <kvm@vger.kernel.org>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Luka
 Absandze" <absandze@amazon.de>
Subject: [PATCH] perf/x86/amd: Reject AMD Merge event as a countable event
Date: Wed, 16 Sep 2026 12:33:15 +0000
Message-ID: <20260916123315.89042-1-absandze@amazon.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWA002.ant.amazon.com (10.13.139.32) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

AMD event select 0xFFF (Merge) is the hardware control encoding used by
Large Increment per Cycle (LIPC) pairs.  When written into an odd
counter's PerfCtl it turns that counter into the upper 16 bits of a
64-bit merged accumulator; any subsequent arming write (-(2^47-1)) is
silently truncated to its low 16 bits, while hwc->prev_count retains the
full value.

This is particularly problematic with a KVM guest, which will program
the Merge encoding into its own odd vPMC as a normal part of scheduling
a LIPC event.  KVM intercepts that write and faithfully forwards it to
the host as a raw event carrying the Merge encoding, where it is
accepted as an ordinary countable event. Once a counter's PerfCtl holds
the Merge encoding, every later user of that counter gets a first delta
inflated by 2^47

Reject Merge (AMD_MERGE_EVENT) in amd_core_hw_config() so it cannot be
submitted as a user-visible event.  The pair mechanism programs it
itself via x86_pmu.perf_ctr_pair_en; nothing else should do so.

Fixes: 5738891229a2 ("perf/x86/amd: Add support for Large Increment per Cycle Events")
Reported-by: Yao Zhou <yaoz@meta.com>
Signed-off-by: Luka Absandze <absandze@amazon.de>
---
 arch/x86/events/amd/core.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index 49b6b8fce566..cb655c751e5b 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -380,8 +380,12 @@ static int amd_core_hw_config(struct perf_event *event)
 	else if (event->attr.exclude_guest)
 		event->hw.config |= AMD64_EVENTSEL_HOSTONLY;
 
-	if ((x86_pmu.flags & PMU_FL_PAIR) && amd_is_pair_event_code(&event->hw))
-		event->hw.flags |= PERF_X86_EVENT_PAIR;
+	if (x86_pmu.flags & PMU_FL_PAIR) {
+		if ((event->hw.config & AMD64_EVENTSEL_EVENT) == AMD_MERGE_EVENT)
+			return -EINVAL;
+		if (amd_is_pair_event_code(&event->hw))
+			event->hw.flags |= PERF_X86_EVENT_PAIR;
+	}
 
 	if (has_branch_stack(event))
 		return static_call(amd_pmu_branch_hw_config)(event);
-- 
2.47.3

