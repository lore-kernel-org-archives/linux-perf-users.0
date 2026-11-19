Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=139.138.37.100
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795079112;
	b=qSCPqWr8uFErLSmU7nOBeBbB+/0t6p7A+5GQ82MGYi40vIFW7OzyTOtKuwf/SHA1VWX+
	 egX+HulllU1MII+VPADpcdWADYYmTYMCQ9aPvTvk7Zd5Fa0U8nmH34lPZty79mD5eHyJ9
	 GxEPSOWmm2GheKV8PbTsfqNQ7pw21TUK44Q7c2vkwkF4A7/ikw1WdBMBGVN9jFiRLFYTk
	 zG/VK21zJUx1qurOzuxpMA6Gqm+jhNgALJR4ZNVruUTMTzaoe5GmxibyutgomCDGtRUOj
	 bC1rTJnEF/wOmJfiQLdfIlh1yedRBALbl9hldC/xL7neCaCKou++ApdO/v/BA2nP+xw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795079112;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:Received:Received:Received:From:
	 Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=Yp3Hjda6lxuiEBuymF9bC8d04KPbQZvVj87ezsy2FT0=;
	b=H7I2eJ3646xoOiqPFFudsNMvz9pH8a4Iyzz/pPTdxr5WZye7YbRq0Ue8oyCONyKwAa/+
	 OUVVw+kOlcnAyEDrPWBPbb2ZDrMcmUmIOSegAtS9nr1C3eBcjAsPlNzgrTmpo0n0tZEot
	 vr9tLVK5a9zaIB3lZIXeL+riNw/6v59eTsEkewv2FSeKiClJLVXdGDLM9DKIXrAvB5ki7
	 Drbstmkh7Dv2n36UXGbUKnxYBcfPzfhEbIpCmnTz889m0BkYQ3tTMZucGL+XjTH+ygqtH
	 VIc/9Vb0vpkf4gTh8wBaQrrfW//C8W5jZD8AE/X+AHRuWdx1d1LOqL7WRxzpT+/+/Bw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fujitsu.com;
	spf=pass smtp.mailfrom=fujitsu.com;
	dkim=pass header.d=fujitsu.com header.i=@fujitsu.com header.a=rsa-sha256 header.s=fj2 header.b=fz29snwe;
	arc=none smtp.remote-ip=139.138.37.100
Received: from esa12.hc1455-7.c3s2.iphmx.com (esa12.hc1455-7.c3s2.iphmx.com [139.138.37.100])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC2D606A332;
	Thu, 19 Nov 2026 09:05:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3CC2D606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.a=rsa-sha256 header.s=fj2 header.b=fz29snwe
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1795079117; x=1826615117;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=K6eWaA+Bi5PWcZzJp9RtBNoBV6QsuWOUzHii7RlhKM4=;
  b=fz29snwemQI4xL8ulxMGTPPLG7hVJAQl/k2fyLQzGYmvVoM28M2ni+Na
   KGDFdOeH1SuqNCm3sSM1TrMYHVhma+oay34ShVm6kGq+lr3wsTjCAXm1y
   NWA2TjBbwzPdwzqi6riT8iPAao5osMZcQC3DJm6iekh/SQtnKCyyCdx1k
   LYtIN0MkB/FZmaBxyaDNzvEH2lsD2VLJ/h4uU0pRC+YvpaqeMAZvqoGa9
   XFHjM+XQ3BCS04FvDH//yemhb5WTNcVC5/hYSu/12XcfhznGP9iDzrp2l
   9S4Yd4/ES3T/KqDka9b6HWnu5JgDqj/meiwIvs43MHu7BvF+RXx/02plj
   Q==;
X-CSE-ConnectionGUID: 7zrbiA0rRMiKJHUNUQk/ig==
X-CSE-MsgGUID: sURXeqe0R+yI66hbSWx7ug==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="240120157"
X-IronPort-AV: E=Sophos;i="6.27,220,1786978800"; 
   d="scan'208";a="240120157"
Received: from gmgwnl01.global.fujitsu.com ([52.143.17.124])
  by esa12.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 18:05:09 +0900
Received: from az2nlsmgm2.o.css.fujitsu.com (unknown [10.150.26.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by gmgwnl01.global.fujitsu.com (Postfix) with ESMTPS id B9CDC42A315;
	Thu, 19 Nov 2026 09:05:01 +0000 (UTC)
Received: from az2uksmom3.o.css.fujitsu.com (unknown [10.151.22.205])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2nlsmgm2.o.css.fujitsu.com (Postfix) with ESMTPS id 598F71C00973;
	Thu, 19 Nov 2026 09:05:01 +0000 (UTC)
Received: from [127.0.1.1] (unknown [10.124.178.20])
	by az2uksmom3.o.css.fujitsu.com (Postfix) with ESMTP id 985B5100116B;
	Thu, 19 Nov 2026 09:04:53 +0000 (UTC)
From: Tomohiro Misono <misono.tomohiro@fujitsu.com>
Subject: [PATCH v3 0/5] arm64: Add workarounds for FUJITSU-MONAKA CPU
Date: Thu, 19 Nov 2026 18:04:32 +0900
Message-Id: <20261119-monaka-fix-for-upstream-v3-0-057df4d2ca3c@fujitsu.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKC7/moC/4XNzQ6CMAzA8VchO1vTDcKHJ9/DeBijk2lgZGOLh
 vDuDk56MB7/Tfvrwjw5Q56dsoU5isYbO6bIDxlTvRxvBKZLzQSKkiMKGOwoHxK0eYK2DsLkZ0d
 ygLLGGnlHshGapevJUdrZ5cs1dW/8bN1rfxT5Nv1vRg4IhSSFLaqW8uKsw93MPhyVHdimRvEh8
 fK3JJKkVUUdVbrRRf0trev6BrgtFHcKAQAA
To: Tomohiro Misono <misono.tomohiro@fujitsu.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, Marc Zyngier <maz@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>, 
 Oliver Upton <oupton@kernel.org>, Fuad Tabba <fuad.tabba@linux.dev>, 
 Joey Gouly <joey.gouly@arm.com>, Steffen Eiden <seiden@linux.ibm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Zenghui Yu <yuzenghui@huawei.com>, 
 Vladimir Murzin <vladimir.murzin@arm.com>
Cc: Kohei Enju <enju.kohei@fujitsu.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 kvmarm@lists.linux.dev
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795079092; l=2835;
 i=misono.tomohiro@fujitsu.com; s=20261002; h=from:subject:message-id;
 bh=K6eWaA+Bi5PWcZzJp9RtBNoBV6QsuWOUzHii7RlhKM4=;
 b=FM88/bpj1g7cCHmukWrrAYqnnWY1EmhGJyRRqcCarjKBvGgNq0pl1v7gmEFwUjvOCGHbdE3NP
 B18d+3KJmUuCa0TdNWPlkmjAOaV+3NQ4+s4B+2+EWgP+/P/TGB6aFti
X-Developer-Key: i=misono.tomohiro@fujitsu.com; a=ed25519;
 pk=VLRxj5y4GJrHLmj3e2NBg30fX2U//ydi7c2G2qiNo10=

This series adds workarounds for the FUJITSU-MONAKA CPU.
Unfortunately, another erratum has been found since v2 and
I added patch 5 for this new workaround.
 - Patch 1 ... Add the FUJITSU-MONAKA CPU type definition
 - Patch 2 ... Add a workaround for TLBI operation
 - Patch 3 ... Add a workaround for perf operation
 - Patch 4 ... Add a workaround for GIC operation
 - Patch 5 ... Add a workaround for WFE operation

Although these workarounds do not depend on each other functionally,
I have combined them into one series because patch 2-5
use the CPU type definition added by the first patch,
and all the workarounds update silicon-errata.rst.

If preferred, I will resend them as separate patches.

Best Regards,
Tomohiro Misono

Changes in v3:
 - Add new workaround for WFE as patch 5
 - Address review comments in patch 2-4.
   Especially now patch 2 disables TLBI range operations on MONAKA CPU.
   See each commits for the details
 - Add Acked-by by Mark in patch 1
 - Rebased on 7.4-rc3
 - Link to v2: https://lore.kernel.org/r/20261016-monaka-fix-for-upstream-v2-0-fc7ede7f9f48@fujitsu.com

Changes in v2:
 - Address review comments in patch 2-4. See each commits for the details
 - rebased on 7.3-rc7
 - Link to v1: https://lore.kernel.org/r/20261002-monaka-fix-for-upstream-v1-0-4aec0b0cbe34@fujitsu.com

Signed-off-by: Tomohiro Misono <misono.tomohiro@fujitsu.com>
---
Kohei Enju (1):
      irqchip/gicv3: Add workaround for FUJITSU-MONAKA Erratum E#030003

Tomohiro Misono (4):
      arm64: cputype: Add FUJITSU MONAKA definition
      arm64: tlb: Add tlbi workaround for FUJITSU-MONAKA Erratum E#030001
      perf: arm_pmu: Add workaround for FUJITSU-MONAKA Erratum E#030002
      arm64: Add workaround to replace WFE with NOP for FUJITSU-MONAKA Erratum E#030004

 Documentation/arch/arm64/silicon-errata.rst |  8 ++++
 arch/arm64/Kconfig                          | 58 +++++++++++++++++++++++++++++
 arch/arm64/include/asm/assembler.h          |  4 ++
 arch/arm64/include/asm/barrier.h            |  3 +-
 arch/arm64/include/asm/cmpxchg.h            |  4 +-
 arch/arm64/include/asm/cpucaps.h            |  6 +++
 arch/arm64/include/asm/cputype.h            |  2 +
 arch/arm64/kernel/cpu_errata.c              | 32 ++++++++++++++++
 arch/arm64/kernel/cpufeature.c              | 11 +++++-
 arch/arm64/kvm/sys_regs.c                   |  8 ++++
 arch/arm64/tools/cpucaps                    |  3 ++
 drivers/irqchip/irq-gic-v3.c                | 35 +++++++++++++++++
 drivers/perf/arm_pmu.c                      | 13 +++++++
 13 files changed, 183 insertions(+), 4 deletions(-)
---
base-commit: aebb7274476403040d582c61478df8f4a7bf9cd3
change-id: 20261002-monaka-fix-for-upstream-680801dea92f

Best regards,
-- 
Tomohiro Misono <misono.tomohiro@fujitsu.com>

