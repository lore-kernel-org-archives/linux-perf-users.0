Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6952EEE60;
	Tue, 13 Oct 2026 08:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791880737; cv=none; b=NI+El1HgjaWVBEaid/2R1IVpQtPFYeocJxotqYxFJIfeCkeFq3kgjkkAuaocqcGWzB7qz6Xky2DBZRUIO912tLQQ3i7r7sw6ZEU3iMMbOPIxJO09fCjoYIMts00CzTSDboMK0yqz1k8uX9k4awFp9kTl6uF28Y+7Z9FOuYtKdLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791880737; c=relaxed/simple;
	bh=lT3gtRtlhYRZWcSc3voXXeA/2wWqbB8uQUpk1M5gZIM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fpOw5Gr8Qh3ImMGHzkuKeSEu5WkpvyIvt+80qQaPddfPPojAQ6Ps/Ss8VE4L0yQnbmPr6jeQcxXBRn5nCh+HrdVQG0UDqukc5AVnXNXv4v5rSYt1+1+DhTcGS7ErE2VTmgDjh/FIZsgL1P+c2oCUXxOy0VGBtk6TsupLr7f5FLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD5E51F00898;
	Tue, 13 Oct 2026 08:38:53 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Conor Dooley <conor.dooley@microchip.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: linux-riscv@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] perf/renesas: Remove remaining RISCV_ALTERNATIVE references
Date: Tue, 13 Oct 2026 10:38:39 +0200
Message-ID: <fe117dd44728fe7c96f3e4b3ec88c6ca83c5da9b.1791880574.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As riscv always selects RISCV_ALTERNATIVE, the option was removed.
However, a few references were left, making it impossible to enable
RZ/Five support (ARCH_R9A07G043).

Fix this by removing all remaining references.

Fixes: b924210f542e13c7 ("riscv: remove RISCV_ALTERNATIVE Kconfig option")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
To be applied to riscv/for-next, or folded into the original commit.
---
 drivers/perf/Kconfig        | 2 +-
 drivers/soc/renesas/Kconfig | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
index 245e7bb763b9947a..8cef4bdef76aecab 100644
--- a/drivers/perf/Kconfig
+++ b/drivers/perf/Kconfig
@@ -117,7 +117,7 @@ config STARFIVE_STARLINK_PMU
 
 config ANDES_CUSTOM_PMU
 	bool "Andes custom PMU support"
-	depends on ARCH_RENESAS && RISCV_ALTERNATIVE && RISCV_PMU_SBI
+	depends on ARCH_RENESAS && RISCV_PMU_SBI
 	default y
 	help
 	  The Andes cores implement the PMU overflow extension very
diff --git a/drivers/soc/renesas/Kconfig b/drivers/soc/renesas/Kconfig
index a63df28df3b5e7c7..0b6876ef6dca228b 100644
--- a/drivers/soc/renesas/Kconfig
+++ b/drivers/soc/renesas/Kconfig
@@ -461,7 +461,6 @@ config ARCH_R9A07G043
 	bool "RISC-V Platform support for R9A07G043F (RZ/Five)"
 	depends on NONPORTABLE
 	depends on !DMA_DIRECT_REMAP
-	depends on RISCV_ALTERNATIVE
 	depends on !RISCV_ISA_ZICBOM
 	depends on RISCV_SBI
 	select ARCH_RZG2L
-- 
2.43.0

