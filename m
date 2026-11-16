Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794853366;
	b=j+xp6WjURL9gHfaSgVaxadg3G0sT0tHBWzzpHwr8rVFqeSC1qI45GGwCFP/0s4k7g+3N
	 EloV4B4Qkw1cVnt2jZnRbpfJmzuBSFT1ZmTqtW4TdBjedDtMYqy+rmcTbVwaLv29jLVJQ
	 +v5SJDwjIJ+VCYWU6ZUDXPDceo3jvihIGXLxTK0s+Ftfo014j4oLibSLvUVV52ofYBp6Z
	 dOzW/KJwSWKe/TR4U+4KtuCNuNJK57vVBIN+YKF5InbGVCmw0H7i+nUqhJwVyLvm4JPWN
	 V/5Xz4IjXMUzaCDjIq2POYfVL/tqQfZxqzW8T4XE/ltPzWegJ3Vyp/OuMwJ9fAgIInA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794853366;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=bqJvB6enP/okPPxSerhwa6fogTBDV5fNQyKcgjywQTM=;
	b=B9dv5+YXt+ufHZkN2kVxrWMssElVGssL9n1MqN1ugqVK/ypHpQPABapCj5wRuj9tSpNU
	 wPy4xBWs530xcdS6CIGEj4XH4wwrrMCuf1W2Z62oIgVV10yx3HjSgixkcvDp9cY2xKYNG
	 Nai6flhInhtfwl+g/q1Wg945CDRCwpbClOWuTm5euh92sOT1sNtCzPbvaLxWPK+TrlDuD
	 LQtdG7qRRF2Kh4fV2GzB4HPD3o/Y5+WuaCRBWvC+YR1foDJ5lBdN9g/HQF5DwXwa8IFdX
	 XbygmAmJesSZ2F7NGjQMOWGI3VzhzEI9Hdje5D3MF7mCB8OtPxKQQWlOSkPBvCnyiuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=vJjzGIwh;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A09606A884;
	Mon, 16 Nov 2026 18:22:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70A09606A884
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=vJjzGIwh
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0B63F1684;
	Mon, 16 Nov 2026 10:22:43 -0800 (PST)
Received: from e132581.arm.com (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F247C3F632;
	Mon, 16 Nov 2026 10:22:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794853366; bh=3HQbqbNQTpF6lOh0eDAnhrgV5w1oEbiu/SzFYvPoCoQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=vJjzGIwhpoGP+617+yXgzDJiFrNJCUg8COsq6eqpx7JRpW6wo53CMiGuWRAHhQQR7
	 VtywxfvpEAkxZAwI7M9ljvphkHEfNAritXEXLAelFAf4kAm7r+qY0z6YlkSS6GskKZ
	 OZJ9KBKWXxiwyUEcLbjbhPe8zs5erqg9i1StmMdQ=
From: Leo Yan <leo.yan@arm.com>
Date: Mon, 16 Nov 2026 18:21:35 +0000
Subject: [PATCH 8/8] ACPI: arm64: Move PMU device registration to
 drivers/acpi/arm64/
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
Message-Id: <20261116-acpi_arm_pmu_registration_hmp-v1-8-0371d4eca626@arm.com>
References: <20261116-acpi_arm_pmu_registration_hmp-v1-0-0371d4eca626@arm.com>
In-Reply-To: <20261116-acpi_arm_pmu_registration_hmp-v1-0-0371d4eca626@arm.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Danilo Krummrich <dakr@kernel.org>, Johan Hovold <johan@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Daniel Scally <djrscally@gmail.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Bartosz Golaszewski <brgl@kernel.org>, 
 Saravana Kannan <saravanak@kernel.org>, Will Deacon <will@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 Hanjun Guo <guohanjun@huawei.com>, Jeremy Linton <jeremy.linton@arm.com>, 
 Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Sudeep Holla <sudeep.holla@kernel.org>, Rob Herring <robh@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@arm.com>, James Clark <james.clark@linaro.org>, 
 Anshuman Khandual <anshuman.khandual@arm.com>, Al Grant <al.grant@arm.com>, 
 "Johnny.Fan" <johnny.fan@cixtech.com>, linux-acpi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, driver-core@lists.linux.dev, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-perf-users@vger.kernel.org, Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794853327; l=3632;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=3HQbqbNQTpF6lOh0eDAnhrgV5w1oEbiu/SzFYvPoCoQ=;
 b=X1LNld2n0QV0BE/yEJT3EFjRd/pSftFLxS6q+LckxMovIMspt6ojlw4avaXkuq6s/KkLjpzCC
 We8c6U5F43KAt6ZSBQrXO1VU2Z3enb4zhQKneze/7rbzX+WkYWT6n+A
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

The ACPI PMU code now registers platform devices for the CPU PMU, SPE
and TRBE. Move it to drivers/acpi/arm64/pmu.c with the other Arm ACPI
device enumeration code.

Move its Kconfig entry alongside it and rename the hidden ARM_PMU_ACPI
symbol to ACPI_PMU. Drop the ARM_PMU dependency: enumeration does not
use the CPU PMU framework, and each device type is guarded by its driver
configuration. This allows SPE and TRBE enumeration with ARM_PMU disabled.

Keep the default-y setting, update the build guard and retain PMU
maintainer coverage for the new path.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 MAINTAINERS                                       | 1 +
 drivers/acpi/arm64/Kconfig                        | 4 ++++
 drivers/acpi/arm64/Makefile                       | 1 +
 drivers/{perf/arm_pmu_acpi.c => acpi/arm64/pmu.c} | 0
 drivers/perf/Kconfig                              | 4 ----
 drivers/perf/Makefile                             | 1 -
 6 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index ccbcdc0799b9fb8cc2b4dc139906e1584e096c46..f12a37cf20e13583c949b6fa7d9f5eb08e260566 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2445,6 +2445,7 @@ F:	arch/arm*/include/asm/hw_breakpoint.h
 F:	arch/arm*/include/asm/perf_event.h
 F:	arch/arm*/kernel/hw_breakpoint.c
 F:	arch/arm*/kernel/perf_*
+F:	drivers/acpi/arm64/pmu.c
 F:	drivers/perf/
 F:	include/linux/perf/arm_pmu*.h
 
diff --git a/drivers/acpi/arm64/Kconfig b/drivers/acpi/arm64/Kconfig
index f2fd79f22e7d836b07401eb055725b2632ba624c..b4dd7f4d257e005b32d34012169ac595dcdee468 100644
--- a/drivers/acpi/arm64/Kconfig
+++ b/drivers/acpi/arm64/Kconfig
@@ -24,3 +24,7 @@ config ACPI_APMT
 
 config ACPI_MPAM
 	bool
+
+config ACPI_PMU
+	depends on ACPI
+	def_bool y
diff --git a/drivers/acpi/arm64/Makefile b/drivers/acpi/arm64/Makefile
index 9390b57cb56481c547ebb896c58cf3e37a980827..f09e4506954d897caa44481a83f81ca65cfb7d96 100644
--- a/drivers/acpi/arm64/Makefile
+++ b/drivers/acpi/arm64/Makefile
@@ -5,6 +5,7 @@ obj-$(CONFIG_ACPI_FFH)		+= ffh.o
 obj-$(CONFIG_ACPI_GTDT) 	+= gtdt.o
 obj-$(CONFIG_ACPI_IORT) 	+= iort.o
 obj-$(CONFIG_ACPI_MPAM) 	+= mpam.o
+obj-$(CONFIG_ACPI_PMU)		+= pmu.o
 obj-$(CONFIG_ACPI_PROCESSOR_IDLE) += cpuidle.o
 obj-$(CONFIG_ARM_AMBA)		+= amba.o
 obj-y				+= dma.o init.o
diff --git a/drivers/perf/arm_pmu_acpi.c b/drivers/acpi/arm64/pmu.c
similarity index 100%
rename from drivers/perf/arm_pmu_acpi.c
rename to drivers/acpi/arm64/pmu.c
diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
index 245e7bb763b9947afc0330689b15d1b73d567f25..e9d61d5dbd1f174cc3862cf7f7823896df9d07d6 100644
--- a/drivers/perf/Kconfig
+++ b/drivers/perf/Kconfig
@@ -129,10 +129,6 @@ config ANDES_CUSTOM_PMU
 
 	  If you don't know what to do here, say "Y".
 
-config ARM_PMU_ACPI
-	depends on ARM_PMU && ACPI
-	def_bool y
-
 config ARM_SMMU_V3_PMU
 	 tristate "ARM SMMUv3 Performance Monitors Extension"
 	 depends on ARM64 || (COMPILE_TEST && 64BIT)
diff --git a/drivers/perf/Makefile b/drivers/perf/Makefile
index eb8a022dad9a7a78433d42e9424c632d187debea..ddbae5f627ad8bcbe9d7e6c29293429562d85037 100644
--- a/drivers/perf/Makefile
+++ b/drivers/perf/Makefile
@@ -5,7 +5,6 @@ obj-$(CONFIG_ARM_CMN) += arm-cmn.o
 obj-$(CONFIG_ARM_DSU_PMU) += arm_dsu_pmu.o
 obj-$(CONFIG_ARM_NI) += arm-ni.o
 obj-$(CONFIG_ARM_PMU) += arm_pmu.o arm_pmu_platform.o
-obj-$(CONFIG_ARM_PMU_ACPI) += arm_pmu_acpi.o
 obj-$(CONFIG_ARM_PMUV3) += arm_pmuv3.o
 obj-$(CONFIG_ARM_V6_PMU) += arm_v6_pmu.o
 obj-$(CONFIG_ARM_V7_PMU) += arm_v7_pmu.o

-- 
2.34.1

