Received: from esa5.hc1455-7.c3s2.iphmx.com (esa5.hc1455-7.c3s2.iphmx.com [68.232.139.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E5D33B6F4;
	Fri,  2 Oct 2026 10:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.139.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790936951; cv=none; b=IONTXM0BCQHG19tMSlq2v3wxfNQME3ed2Imh6L32AS3ssI8cvdFYeMS5FtRDl5Ic2SlTfAJmFYYdKImgTTy7JwWyJfgRTkOag1lUTibm6AOorsuGzxkvQWLJtYt4isxp5op5yS5DYxGsql+5GYHcM72u1ko3eCQ/iNbqPpudiJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790936951; c=relaxed/simple;
	bh=kdP8Y85+YAlHHNn6trn0SUbhnmJE4tAcNHP5fu0/54w=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=SxlmWrsYprBphUzu98zXcD7C2cngQLxRLwg96XRESw3GRaEI2h8cNg/4XkFNQWD03X/VvNOvK0W5FZvCSYkmwhXApkqbbnXPuinyyTmKWDF3baVHkkfPMB0n3o+3QVmj7MsJqvkb/drYlybNgE0mIsEM2z/n0dCyGvX7neghvuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=o0lZjKGq; arc=none smtp.client-ip=68.232.139.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="o0lZjKGq"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1790936950; x=1822472950;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=kdP8Y85+YAlHHNn6trn0SUbhnmJE4tAcNHP5fu0/54w=;
  b=o0lZjKGqzZTqmvhEa5Cty7OnjiTyjryZnbUuni55csbJNYp8wd/cdMG5
   6y5KPNDH3QSek0AhxaHKPHOeygEI2t3JkD8e2MrMRAi4TEbw4uDZXwQjU
   hDXgX5KSJEmq2oxrz2k70PtFyQx9CiwUfd7s+tR6l4m4rHRIKPe4nKUGv
   GE8TSTMxmdjbdlGayEJkISDoWL59K6LJQ0ou6+2brvDqEMg1bvVHTSbIj
   lYOmh2rJ2iX6SY955BAuUC0ohO8Ql9gRjfSTbrePKc3NDsKtl43OHgw3f
   xZH2WZDtjwTLjvoo0ioq/aC0PTGg3wL0spjrUHolqeJrZc0iJ+7w1sJx0
   g==;
X-CSE-ConnectionGUID: FFQTJ/7UTQCK9Q3fhJjG+w==
X-CSE-MsgGUID: WUOEgRicQ2ySwV+HWqD9SQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="255159819"
X-IronPort-AV: E=Sophos;i="6.27,136,1786978800"; 
   d="scan'208";a="255159819"
Received: from gmgwnl01.global.fujitsu.com ([52.143.17.124])
  by esa5.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 19:27:59 +0900
Received: from az2nlsmgm2.o.css.fujitsu.com (unknown [10.150.26.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by gmgwnl01.global.fujitsu.com (Postfix) with ESMTPS id 0D5FF404C1A;
	Fri,  2 Oct 2026 10:27:59 +0000 (UTC)
Received: from az2nlsmom4.fujitsu.com (unknown [10.150.26.201])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2nlsmgm2.o.css.fujitsu.com (Postfix) with ESMTPS id AEDF51C00CFA;
	Fri,  2 Oct 2026 10:27:58 +0000 (UTC)
Received: from [127.0.1.1] (unknown [10.124.178.20])
	by az2nlsmom4.fujitsu.com (Postfix) with ESMTP id 8EC86201F381;
	Fri,  2 Oct 2026 10:27:53 +0000 (UTC)
From: Tomohiro Misono <misono.tomohiro@fujitsu.com>
Subject: [PATCH 0/4] arm64: Add workarounds for FUJITSU-MONAKA CPU
Date: Fri, 02 Oct 2026 19:26:48 +0900
Message-Id: <20261002-monaka-fix-for-upstream-v1-0-4aec0b0cbe34@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOiGv2oC/x2MQQqEMAwAvyI5G0h7EPUrsoegqQaxlXQVQfy7x
 ePAzNyQxVQy9NUNJqdmTbGAqysYF46zoE6FwZNvHJHHLUVeGYNeGJLhsee/CW/YtNSSm4Q7H6D
 Uu0lxvvPwe54XQNQKVmkAAAA=
To: Tomohiro Misono <misono.tomohiro@fujitsu.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, Marc Zyngier <maz@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>
Cc: Kohei Enju <enju.kohei@fujitsu.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-perf-users@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790936872; l=1846;
 i=misono.tomohiro@fujitsu.com; s=20261002; h=from:subject:message-id;
 bh=kdP8Y85+YAlHHNn6trn0SUbhnmJE4tAcNHP5fu0/54w=;
 b=sMutH7OhtOq9k8VTtMz1y5NNO9KUJbCPf4Nd0TQrXpxEWC6mWnCE+o/3Ek4YSISS8eN23cuDP
 2UTe6+Jim/LBwZPXzq96h44pnE+cODni8I5OEpQSzWxKYPPMkAV+7Ui
X-Developer-Key: i=misono.tomohiro@fujitsu.com; a=ed25519;
 pk=VLRxj5y4GJrHLmj3e2NBg30fX2U//ydi7c2G2qiNo10=

This series adds three workarounds for the FUJITSU-MONAKA CPU.
 - Patch 1 ... Add the FUJITSU-MONAKA CPU type definition
 - Patch 2 ... Add a workaround for TLBI operation on 64k page size
 - Patch 3 ... Add a workaround for perf operation
 - Patch 4 ... Add a workaround for GIC operation

Although the three workarounds do not depend on each other functionally,
I have combined them into one series because patch 2 and 3
use the CPU type definition added by the first patch, and
all the workarounds update silicon-errata.rst.

If preferred, I will resend them as separate patches.

This series is based on v7.3-rc5.

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
 arch/arm64/Kconfig                          | 36 ++++++++++++++++++++++
 arch/arm64/include/asm/cpucaps.h            |  4 +++
 arch/arm64/include/asm/cputype.h            |  2 ++
 arch/arm64/include/asm/tlbflush.h           | 33 ++++++++++++++++++++
 arch/arm64/kernel/cpu_errata.c              | 20 ++++++++++++
 arch/arm64/tools/cpucaps                    |  2 ++
 drivers/irqchip/irq-gic-v3.c                | 48 +++++++++++++++++++++++++++++
 drivers/perf/arm_pmu.c                      | 13 ++++++++
 9 files changed, 164 insertions(+)
---
base-commit: 72d3fcf802c45d00b300f25b848a93c3a2bd7c7e
change-id: 20261002-monaka-fix-for-upstream-680801dea92f

Best regards,
-- 
Tomohiro Misono <misono.tomohiro@fujitsu.com>

