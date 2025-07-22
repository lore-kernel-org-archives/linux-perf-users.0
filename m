Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB752EBBA1;
	Tue, 22 Jul 2025 14:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753193226; cv=none; b=Pje8r6ZoZfIDvqsrPiXAASNe0KjxOmL4qVnuYjTZ+l8KILDJUJxI9HnS7yh3dFFClotq99ivDouq1APfiN0S4lv+WkzJYFIMblv/Q/fZF2xgCCzD8+0mC2dda/oz4nry0ZbcNDilsRBY6q6tJ2EkFtExZFa4U+cXUg1qJhHV8jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753193226; c=relaxed/simple;
	bh=mg6fFUoOqdxNmiawjQ8njjV8F1W25uYsPGezNXnfzSQ=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=GokjtloqDmWDLpmNVHXVpbMhVOHJVR5gCZ/3qd8vKbjAbedRzPhpox5GX+XpLcLGNDuIbZJcF6v7CGFeI4T+qeZfOSY9XjvgJCb+p8mnG3Q00OCFoyq/5UspNM1VUu5Qbw4aOdrXbqlJg6jgIxkilXGt1aXEcbYyc21YhAWibAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=2fapeX4B; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="2fapeX4B"
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56ME1oNY009466;
	Tue, 22 Jul 2025 16:06:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=selector1; bh=ibN3D5KFd0DY0HGihGpNxP
	n6zt4eLguB92lFSdyHJss=; b=2fapeX4BOfmz6wdcm2zebSIkp2hqSKn7luTzNE
	bQGdDRyJTDheqnozK/gEgYEx610ucf1NomA8EPlY7dGOcpEJfgiGg+u7kraKo3At
	YIyEEwlv4U2Q4ugeeeEuwW8rMlwJWEHsRlU4XfFcQGe7C/76f4mSufJp1jeNNCOc
	BaGZFVQVpRfvLlqFzmCAns2GGEejXjkspa8rzQhXBE++rq8tjRio7pRkUn+m+WfL
	AXncTwW1LToXivUZLPZnOcp/jL9nwwEtpZsQvNJ582WqezWmIug4fSsml/eHQf1Y
	oL54b5xQYuhAJxwLmT4RC+ALcphOJuUqtfWaWmrMwmHR6KNw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 48028g63ap-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Jul 2025 16:06:46 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 1C0644002D;
	Tue, 22 Jul 2025 16:05:08 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 52202761AE4;
	Tue, 22 Jul 2025 16:03:49 +0200 (CEST)
Received: from localhost (10.48.86.185) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Jul
 2025 16:03:49 +0200
From: =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <clement.legoffic@foss.st.com>
Subject: [PATCH v3 00/19] Introduce STM32 DDR PMU for STM32MP platforms
Date: Tue, 22 Jul 2025 16:03:17 +0200
Message-ID: <20250722-ddrperfm-upstream-v3-0-7b7a4f3dc8a0@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIACWaf2gC/23NwQ6CMAyA4VchOzuyDUfRk+9hPODWyQ4wsuKiI
 by7Aw/GhN7+Jv06M8Lokdi5mFnE5MmHIUd1KJjp2uGB3NvcTAmlhVY1tzaOGF3PnyNNEdue350
 ApwFA25bluzGi86/NvN5yd56mEN/biyTX7VerVbWjJckFB+vyyLoRJ3FxgaikqTShZ6uX1M8AK
 fcMlQ1j0SAoUR0b928sy/IBxdqAP/gAAAA=
X-Change-ID: 20250526-ddrperfm-upstream-bf07f57775da
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Rob
 Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor
 Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Philipp Zabel
	<p.zabel@pengutronix.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Gatien Chevallier
	<gatien.chevallier@foss.st.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Gabriel Fernandez
	<gabriel.fernandez@foss.st.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Le
 Goffic <legoffic.clement@gmail.com>,
        Julius Werner <jwerner@chromium.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-perf-users@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-clk@vger.kernel.org>,
        =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <clement.legoffic@foss.st.com>
X-Mailer: b4 0.15-dev-8018a
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-22_02,2025-07-21_02,2025-03-28_01

This patch series introduces the DDR Performance Monitor (DDRPERFM) support for
STM32MP platforms.

The series improves the STM32MP25 RCC driver to make it usable
as an access controller, needed for driver probe.

The series introduces support of DDR channel through dt-binding and
devicetree entries.

It also includes the addition of DDRPERFM device tree bindings,
the DDRPERFM driver, the documentation and updates to the device tree files
for STM32MP13, STM32MP15, STM32MP25 SoCs and stm32mp257f-dk and
stm32mp257f-ev1 boards.
The series also updates the MAINTAINERS file to include myself as the
maintainer for the STM32 DDR PMU driver.

Signed-off-by: Clément Le Goffic <clement.legoffic@foss.st.com>
---
Changes in v3:
- dt-bindings:
  - perf:
    - fix compatible conditions and dtbs_check/dt_binding_check errors
  - memory:
    - Remove ddr-channel binding added in v2
    - Generalise lpddr-props binding into memory-props binding
    - Add ddr4 binding
    - Generalise lpddr-channel binding into memory-channel-binding
- devicetree:
    - update stm32mp257f-ev1 board devicetree as per new ddr4-channel
      binding
- driver:
    - Remove unneeded pmu and event pointer tests in
      `stm32_ddr_pmu_get_counter()` as it would break before if they are
      NULL
    - Rename macro to be more driver specific
    - Fix few trailing commas in array and enum last entries
    - Stick to the use of `pmu->dev` in the probe instead of
      `&pdev->dev`
    - s/devm_clk_get_optional_prepared/devm_clk_get_optional_enabled/ to
      fix unwinding issue and remove the `clk_enable()` of the probe.
    - Move the `perf_pmu_register()` at the end of the probe
    - Add lacking spaces in regspec structs
    - Use DEFINE_SIMPLE_DEV_PM_OPS instead of SET_SYSTEM_SLEEP_PM_OPS
- Link to v2: https://lore.kernel.org/r/20250711-ddrperfm-upstream-v2-0-cdece720348f@foss.st.com

Changes in v2:
- MAINTAINERS:
    Due to reorganisation, my contract with ST ends at the end of this month
    and I will no longer have access to this mailbox.
    Therefore, I will be available for any mission related to embedded and
    kernel linux.
    Change email address in MAINTAINERS file for STM32 DDR PMU driver.
- devicetrees:
  -stm32mp257f-dk: add LPDDR4 channel
  -stm32mp257f-ev1: add DDR4 channel
- dt-bindings:
  - perf:
    - Change Maintainer email address
    - Drop obvious descriptions (clocks and reset property)
    - Drop redundant "bindings" in commit message
    - Drop unneedded "stm32mp151-ddr-pmu" compatible
    - s/st,dram-type/memory-channel/, memory-channel property is not in
      dtschema library so it will produce an error in the v2.
  - rcc:
    - Add required "access-controller-cells" property in example
  - ddr-channel:
    - Add bindings as per jedec,lpddrX-channel bindings
- driver:
  - Substitute the parsing of the 'st,dram-type' vendor devicetree
    property value with the parsing of the [lp]ddr channel compatible
  - Remove unneeded "stm32mp151-ddr-pmu" compatible
  - Use dev_err_probe when possible
  - Assert and deassert reset line unconditionnaly
  - Use `devm_reset_control_get_optional_exclusive` instead of
    `of_property_present` then `devm_reset_control_get`
  - Use `devm_clk_get_optional_prepared` instead of `of_property_present`
    then `devm_clk_get_prepared`
  - Disable and unprepare the clock at end of probe
  - Add io.h include as per LKP test report
  - Removed `of_match_ptr` reference in `platform_driver` struct
  - Add `pm_sleep_ptr` macro for `platform_driver` struct's `pm` field
  - Link to v1: https://lore.kernel.org/r/20250623-ddrperfm-upstream-v1-0-7dffff168090@foss.st.com

---
Clément Le Goffic (19):
      bus: firewall: move stm32_firewall header file in include folder
      dt-bindings: stm32: stm32mp25: add `access-controller-cell` property
      clk: stm32mp25: add firewall grant_access ops
      arm64: dts: st: set rcc as an access-controller
      dt-bindings: memory: factorise LPDDR props into memory props
      dt-bindings: memory: introduce DDR4
      dt-bindings: memory: factorise LPDDR channel binding into memory channel
      dt-binding: memory: add DDR4 channel compatible
      arm64: dts: st: add LPDDR channel to stm32mp257f-dk board
      arm64: dts: st: add DDR channel to stm32mp257f-ev1 board
      dt-bindings: perf: stm32: introduce DDRPERFM dt-bindings
      perf: stm32: introduce DDRPERFM driver
      Documentation: perf: stm32: add ddrperfm support
      MAINTAINERS: add myself as STM32 DDR PMU maintainer
      ARM: dts: stm32: add ddrperfm on stm32mp131
      ARM: dts: stm32: add ddrperfm on stm32mp151
      arm64: dts: st: add ddrperfm on stm32mp251
      arm64: dts: st: support ddrperfm on stm32mp257f-dk
      arm64: dts: st: support ddrperfm on stm32mp257f-ev1

 Documentation/admin-guide/perf/index.rst           |   1 +
 Documentation/admin-guide/perf/stm32-ddr-pmu.rst   |  86 ++
 .../bindings/clock/st,stm32mp25-rcc.yaml           |   7 +
 .../memory-controllers/ddr/jedec,ddr4.yaml         |  34 +
 .../memory-controllers/ddr/jedec,lpddr2.yaml       |   2 +-
 .../memory-controllers/ddr/jedec,lpddr3.yaml       |   2 +-
 .../memory-controllers/ddr/jedec,lpddr4.yaml       |   2 +-
 .../memory-controllers/ddr/jedec,lpddr5.yaml       |   2 +-
 ...pddr-channel.yaml => jedec,memory-channel.yaml} |  36 +-
 ...ec,lpddr-props.yaml => jedec,memory-props.yaml} |  24 +-
 .../devicetree/bindings/perf/st,stm32-ddr-pmu.yaml |  94 +++
 MAINTAINERS                                        |   7 +
 arch/arm/boot/dts/st/stm32mp131.dtsi               |   7 +
 arch/arm/boot/dts/st/stm32mp151.dtsi               |   7 +
 arch/arm64/boot/dts/st/stm32mp251.dtsi             |   8 +
 arch/arm64/boot/dts/st/stm32mp257f-dk.dts          |  12 +
 arch/arm64/boot/dts/st/stm32mp257f-ev1.dts         |  12 +
 drivers/bus/stm32_etzpc.c                          |   3 +-
 drivers/bus/stm32_firewall.c                       |   3 +-
 drivers/bus/stm32_rifsc.c                          |   3 +-
 drivers/clk/stm32/clk-stm32mp25.c                  |  40 +-
 drivers/perf/Kconfig                               |  11 +
 drivers/perf/Makefile                              |   1 +
 drivers/perf/stm32_ddr_pmu.c                       | 896 +++++++++++++++++++++
 {drivers => include/linux}/bus/stm32_firewall.h    |   0
 25 files changed, 1266 insertions(+), 34 deletions(-)
---
base-commit: 89be9a83ccf1f88522317ce02f854f30d6115c41
change-id: 20250526-ddrperfm-upstream-bf07f57775da

Best regards,
--  
Clément Le Goffic <clement.legoffic@foss.st.com>

