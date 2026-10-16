Received: from esa3.hc1455-7.c3s2.iphmx.com (esa3.hc1455-7.c3s2.iphmx.com [207.54.90.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389AA3C3428;
	Fri, 16 Oct 2026 10:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.90.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792144956; cv=none; b=KH4bbByRZ+xuZZU1o2wCtfDFxxoogoqnEobpIBAOTAoYDIfUp7TMEQMnH+TBncITTzDLqmp2lr47NhwsKP9sxmTH3Ymb4NwzsgggO3J14WXJBW/R5atMPNGJHknBNJl6INivkawqtHkUSP93R40L6UVcU/lKTL5ktOffrX397Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792144956; c=relaxed/simple;
	bh=Kb1L0Jz22Bdu0wiudnLgsasoZRk2+Y5lFCpZprecvXE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=c0j1s/UZfdsfIo/NS2C+GpikmWlAl71rKi8fJBy/vPFjIVOkQbvkuQpHersydt+t/nCsOTCw0t33RzwfD7JbBn0ycU6F55BYF59a80KDc4Rwxim7BrwH4ATiopat7YRMAlrb1poxzUKF7ZxAw8oODQfJqLPm78WyVekb9C6BBSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=cUaCT8tK; arc=none smtp.client-ip=207.54.90.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="cUaCT8tK"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1792144954; x=1823680954;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=Kb1L0Jz22Bdu0wiudnLgsasoZRk2+Y5lFCpZprecvXE=;
  b=cUaCT8tKXTa0sUqpW7aquZ5WhwNT8C8YB+Qd+cNDCoD3Y7aF7YS//mFD
   nhst2OAR+ElUKTWagndMnDfYNqf3JjmIkGVkh2g/ZhxJialb0LhgOXEyI
   NnBVviojEgtaXMSJPCyiXIZ0UjWhsx/gd0NH537KEMScFsjcGHdYK9aA6
   psCHvoxR/cUyRJROcOLeSp0jp6nUtC1Kh5chYaCROKGmAr9PCof3GJ/rS
   X2jxgxF+clLvMnNwzjNn8sq5JgdBw07XjWRQXXXwvhUg9sqWO+mqJppbd
   jKoIdeII7XsO7ikpQ+aVj9P1fW+buvd6r9cZWZlrr5srIriuKuMa+QIR5
   w==;
X-CSE-ConnectionGUID: i4BvcWNxQbqS/M7xnKzFTg==
X-CSE-MsgGUID: J8veyzjPSJmQbjogKIJoFA==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="258361324"
X-IronPort-AV: E=Sophos;i="6.27,161,1786978800"; 
   d="scan'208";a="258361324"
Received: from gmgwnl01.global.fujitsu.com ([52.143.17.124])
  by esa3.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2026 19:01:24 +0900
Received: from az2nlsmgm3.fujitsu.com (unknown [10.150.26.205])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by gmgwnl01.global.fujitsu.com (Postfix) with ESMTPS id CD54742A306;
	Fri, 16 Oct 2026 10:01:23 +0000 (UTC)
Received: from az2nlsmom3.fujitsu.com (unknown [10.150.26.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2nlsmgm3.fujitsu.com (Postfix) with ESMTPS id 7CF3B1802AE1;
	Fri, 16 Oct 2026 10:01:23 +0000 (UTC)
Received: from [127.0.1.1] (unknown [10.124.178.20])
	by az2nlsmom3.fujitsu.com (Postfix) with ESMTP id 2229010005E9;
	Fri, 16 Oct 2026 10:01:15 +0000 (UTC)
From: Tomohiro Misono <misono.tomohiro@fujitsu.com>
Subject: [PATCH v2 0/4] arm64: Add workarounds for FUJITSU-MONAKA CPU
Date: Fri, 16 Oct 2026 19:00:44 +0900
Message-Id: <20261016-monaka-fix-for-upstream-v2-0-fc7ede7f9f48@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMz10WoC/4WNQQ6CMBBFr0Jm7ZhpJQRdeQ/CopSpjAZK2kI0h
 LtbuYDL9/P/+xtEDsIRbsUGgVeJ4qcM+lSAHcz0YJQ+M2jSlSLSOPrJvAw6eaPzAZc5psBmxKq
 mmlTP5qod5PUcOHcOc9NmHiQmHz7H0ap+6X/nqpCwNGypI9vxpby75SkpLmfrR2j3ff8Crj7Q1
 sAAAAA=
To: Tomohiro Misono <misono.tomohiro@fujitsu.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, Marc Zyngier <maz@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>, 
 Oliver Upton <oupton@kernel.org>, Fuad Tabba <fuad.tabba@linux.dev>, 
 Joey Gouly <joey.gouly@arm.com>, Steffen Eiden <seiden@linux.ibm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Zenghui Yu <yuzenghui@huawei.com>
Cc: Kohei Enju <enju.kohei@fujitsu.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 kvmarm@lists.linux.dev
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792144875; l=2143;
 i=misono.tomohiro@fujitsu.com; s=20261002; h=from:subject:message-id;
 bh=Kb1L0Jz22Bdu0wiudnLgsasoZRk2+Y5lFCpZprecvXE=;
 b=yAQ9E8iiX3yBD0SZ7Tof0begEfs+mYDP9Y1rcSqpF+YhaoajTyR1fNFANXIVL3EGum+8JuYHL
 osQZgXOAnddCuDZl4ELCmSlJn8yZa2ucVnECEriaEBDdl5VWjblmA8y
X-Developer-Key: i=misono.tomohiro@fujitsu.com; a=ed25519;
 pk=VLRxj5y4GJrHLmj3e2NBg30fX2U//ydi7c2G2qiNo10=

Changes in v2:
 - Address review comments in patch 2-4. See each commits for the details
 - rebased on 7.3-rc7
 - Link to v1: https://lore.kernel.org/r/20261002-monaka-fix-for-upstream-v1-0-4aec0b0cbe34@fujitsu.com

This series adds three workarounds for the FUJITSU-MONAKA CPU.
 - Patch 1 ... Add the FUJITSU-MONAKA CPU type definition
 - Patch 2 ... Add a workaround for TLBI operation on 64k page size
 - Patch 3 ... Add a workaround for perf operation
 - Patch 4 ... Add a workaround for GIC operation

Although the three workarounds do not depend on each other functionally,
I have combined them into one series because patch 2-4
use the CPU type definition added by the first patch,
and all the workarounds update silicon-errata.rst.

If preferred, I will resend them as separate patches.

This series is based on v7.3-rc7.

Best Regards,
Tomohiro Misono

Signed-off-by: Tomohiro Misono <misono.tomohiro@fujitsu.com>
---
Kohei Enju (1):
      irqchip/gicv3: Add workaround for FUJITSU-MONAKA erratum E#030003

Tomohiro Misono (3):
      arm64: cputype: Add FUJITSU MONAKA definition
      arm64: tlb: Add tlbi workaround for FUJITSU-MONAKA Erratum E#030001
      perf: arm_pmu: Add workaround for FUJITSU-MONAKA Erratum E#030002

 Documentation/arch/arm64/silicon-errata.rst |  6 ++++
 arch/arm64/Kconfig                          | 36 +++++++++++++++++++++++
 arch/arm64/include/asm/cpucaps.h            |  4 +++
 arch/arm64/include/asm/cputype.h            |  2 ++
 arch/arm64/include/asm/tlbflush.h           | 35 +++++++++++++++++++++++
 arch/arm64/kernel/cpu_errata.c              | 20 +++++++++++++
 arch/arm64/kvm/hyp/vhe/tlb.c                | 44 +++++++++++++++++++++++++++++
 arch/arm64/tools/cpucaps                    |  2 ++
 drivers/irqchip/irq-gic-v3.c                | 32 +++++++++++++++++++++
 drivers/perf/arm_pmu.c                      | 13 +++++++++
 10 files changed, 194 insertions(+)
---
base-commit: 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907
change-id: 20261002-monaka-fix-for-upstream-680801dea92f

Best regards,
-- 
Tomohiro Misono <misono.tomohiro@fujitsu.com>

