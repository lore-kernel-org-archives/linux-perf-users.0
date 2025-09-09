Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963F92F3C30;
	Tue,  9 Sep 2025 10:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757412743; cv=none; b=lrSOu81pd1BJvWjrEP+hBE4rqfH2SnnjrY6rDNAs+Xu00pM16kyo+uSdY7186lmjnhoUXBZVyuQQmx6TkskxT/i7GscCpi3lM1iS96EWLKxoOvK9rFa45m21EqCNAHoKD4cBIfDDchJNnGf6rQDSLkfAN/uaVuE09QCZs9IVDoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757412743; c=relaxed/simple;
	bh=f+p6Hi8Bq/0XParmq+GNXSTJ8BCIU7MW/q9t0C9h1mM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ggAeBmS9bumrouXr+QBBuPTc+9HQRTHKyQuF/HkvwCSM5LCic6WQhVlMafu0gmLg7v8qW04D8DezstiBqwuOZ2K7rgZALiiOwYazEWp8hKxkf+vYUwYBi9+s4B4FclgnZOGvUm0bPefwEyjtCGv+y+kU+EcgGr1CGWiNFr5UcZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=asgwzWwn; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="asgwzWwn"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3e4b5aee522so1772492f8f.1;
        Tue, 09 Sep 2025 03:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757412740; x=1758017540; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2DVZjA2xzBpsspRxmBhscCQ8qNTTD3WeHWSgLWWar2Y=;
        b=asgwzWwnvSxIwEY7f7A7efk/p50ZzoJk8c+C6P8YSNZLqgoZUj3WDFCDFWYW8TwDYn
         VSz7PqlKKkoha7Bu31m/7FH0Vg6ewF99L29+Driu4kqQ+zRKwD9y57XIEoydVZ4M8D68
         JFQNQD3H/y1Xz4Z8fIwsRb/0G3V6OWnIN9+YZoGGQbZQPX9t83uw0C8fVCPl9ti3399H
         TWmpYEuSm2dbOoAHkRF5As3Wf9dJedfmKKzw2uyb2WAxcU6+ckQ55jDSiFzeg8Gxe5r1
         CcWb8tT+9epX2W3InbTyaByIb+6Zyjr+Sufblk80uQS90dLmhgsEK9oYVkJBQcAasSlI
         5hBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757412740; x=1758017540;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2DVZjA2xzBpsspRxmBhscCQ8qNTTD3WeHWSgLWWar2Y=;
        b=Hel0c9NB7f3/NO70THebtEA6zGn6JClBKQJMU125nO4ck1g5Du/c5zgnNDZisUWjOy
         /+ZbgoF5NvXXr1tFPkmh3I8lL1jk/oyQP59cau8MJCpwU/90XJvZsR4b9CAxkDm+cDBb
         MGtYVdsvm+D6Xh6NQ1yVvhFyz+eIyJvb6IudmcOJESlb/qbYjuM64GmVovwa6lCSXneP
         DXqkeXAo+5kP043OYxBGcj7Yxm+J2pvATf5agkgc+SW8rTTG5QOQk7EX2eWf9XW0lwXS
         4oIFsuwZDL59/jucCzMRMI9y+g/cFOzLG4bJMBLQvnP6yQn5oKBbMZiolY/5dwojk5KE
         VmoQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpTFuLn9UeDtXvw6j12e1+An9FBIV4n7QMdoGw7H6HHstldDVS4ptCiTmyTHLM75kEEmTw0uhrOcEr@vger.kernel.org, AJvYcCVCT7VBD96/SpUZOqP0o4HGy0RAAGUguoFrCUJ98fOJCXGR99KGbaJ8CP3oi3XfFCnJuTOEofr7igClTrJ1@vger.kernel.org, AJvYcCW9Qwzrj5lLXKzd7tA0sE53SYYg4YRUi84zO1WppMGCLRkrYphkb4ytUBYR4Eieiuk/j9I3lZDPH482@vger.kernel.org, AJvYcCX16vhQdJoT65eIzX2TzjbCghsv0siAmdDO7CQPTsLosJJQTbeM55nwaNS/l/hCyb2szUnai1S6VGgH@vger.kernel.org, AJvYcCXlFemWpn855YLL5BZ6ul2pvcH8CCTor37elrqJEgEjCONgmxUIUoxkZ0nCeyx6KzDylnaTDmFm4VhzLZVHy+EkHw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzMKZh1a7IrTxMD4dQ0YBYudPWwZ7QOxIqHaV9fHSgbDPyNiES+
	Nzghr4z0qeC6yKLUrPAfITG76Xi1F6ht+JiBSslK5mCUO7neGFC3niJn
X-Gm-Gg: ASbGncvPtcYVGPBu7QkYira6nv4b8ABcd0yFnimq1IbmIAJjUFhj6HBdtwfbc0XJyTX
	OyoLGAVQ9g7DqXdGtM6fgIKlWn8xaiXjPxb7jfU1DtfLHJ1rhkO973Oh9v5Svr41it9vaSBsmdO
	63ay1Q8mZEh+5nisVG4a50iYnsLEqsGSlYlRDzZKHvLA9RpW0fJyY+UzMjqZd8iSUAmLPhIzX0A
	+Kzhq56Ew2h2jLi47Ctzj21ER+hTQ7+W1+qXdmy368om5YdEMBnCFd5yhkQu/bnS+valiglrFqK
	BsxIbeF7b2Oa3NJfEhshQfzVki/wXvPn71RcEdxM0NgUfxuRvTXAzkcb9IMiOEhoUtEStTMCLry
	d9GNSbju9eHtVaEn1rOJGNyk6zHb8C0xK2Dp0MYTlYECNdYROFEEtbt2RBim3QXD0JzSLlDF2M1
	/BxNtuT5h6KsmbpV2lNV+GBLh1eg==
X-Google-Smtp-Source: AGHT+IHWtrZ9/XJ8g8wPILz5HBJiKdiHip6k2Y7nAmAFrkuZKlueXTzkqAL0OsGQ2MntX2372cUV3g==
X-Received: by 2002:a05:6000:1846:b0:3e7:441e:ca19 with SMTP id ffacd0b85a97d-3e7441ecdcemr7240561f8f.43.1757412739533;
        Tue, 09 Sep 2025 03:12:19 -0700 (PDT)
Received: from localhost (2a02-8440-7136-74e7-5ebf-4282-0e1a-b885.rev.sfr.net. [2a02:8440:7136:74e7:5ebf:4282:e1a:b885])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7521bf610sm2035518f8f.9.2025.09.09.03.12.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 03:12:19 -0700 (PDT)
From: =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <legoffic.clement@gmail.com>
Subject: [PATCH v6 00/20] Introduce STM32 DDR PMU for STM32MP platforms
Date: Tue, 09 Sep 2025 12:12:07 +0200
Message-Id: <20250909-b4-ddrperfm-upstream-v6-0-ce082cc801b5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAHj9v2gC/x3MQQ5AMBBA0avIrE1ClZSriEW1g1mgmSIScXeN5
 Vv8/0AkYYrQZQ8IXRx53xKaPAO32G0mZJ8MqlB1YcoKR43eSyCZVjxDPITsimS0VqNzpmobSGk
 Qmvj+t/3wvh94tKr2ZgAAAA==
X-Change-ID: 20250813-b4-ddrperfm-upstream-e8442bcc8396
To: Gatien Chevallier <gatien.chevallier@foss.st.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, Julius Werner <jwerner@chromium.org>, 
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, linux-doc@vger.kernel.org, 
 =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <clement.legoffic@foss.st.com>, 
 =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <legoffic.clement@gmail.com>
X-Mailer: b4 0.15-dev-dfb17

This patch series introduces the DDR Performance Monitor (DDRPERFM) support
for STM32MP platforms.

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
Signed-off-by: Clément Le Goffic <legoffic.clement@gmail.com>
---
Changes in v6:
Use personnal mail account
dt_bindings:
  - Improve sdram-props's compatible and revision ID description
  - Fix DDR4 compatible regex pattern and remove a DDR3 string
driver:
  - Add io.h include for writel_relaxed and readl_relaxed symbols
- Link to v5: https://lore.kernel.org/r/20250728-ddrperfm-upstream-v5-0-03f1be8ad396@foss.st.com

Changes in v5:
driver:
  - Remove one more trailing comma
  - Include right includes and not more than needed.
  - Fix the counter deletion for loop exit condition
  - Fix a dev_err_probe error log
dt_bindings:
  - rcc:
    - Fix commit message:
      's/access_controller_cell/#access_controller_cells/g'
  - sdram props
    - Few fixes properties description (compatible, io-width and
      density):
      - fix SPD bytes number for density
      - add manufacturer part number in compatible for DDR SDRAM
      - improve description sentences
- Link to v4: https://lore.kernel.org/r/20250723-ddrperfm-upstream-v4-0-1aa53ca319f4@foss.st.com

Changes in v4:
- Fix DDRPERFM dt-binding example with a DDR4 channel instead of DDR3
- s/memory/sdram/ for factorising patches.
- Improve properties description for the new SDRAM props binding by
  adding information on compatible generation, revision-id, density and
  io-width for DDR that comes with an SPD module.
- Add a patch to standardise sdram channel node name.
- Improve DDR4 compatible pattern.
- Link to v3: https://lore.kernel.org/r/20250722-ddrperfm-upstream-v3-0-7b7a4f3dc8a0@foss.st.com

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
Clément Le Goffic (20):
      bus: firewall: move stm32_firewall header file in include folder
      dt-bindings: stm32: stm32mp25: add `#access-controller-cells` property
      clk: stm32mp25: add firewall grant_access ops
      arm64: dts: st: set rcc as an access-controller
      dt-bindings: memory: factorise LPDDR props into SDRAM props
      dt-bindings: memory: introduce DDR4
      dt-bindings: memory: factorise LPDDR channel binding into SDRAM channel
      dt-binding: memory: add DDR4 channel compatible
      dt-bindings: memory: SDRAM channel: standardise node name
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
 .../memory-controllers/ddr/jedec,lpddr-props.yaml  |  74 --
 .../memory-controllers/ddr/jedec,lpddr2.yaml       |   2 +-
 .../memory-controllers/ddr/jedec,lpddr3.yaml       |   2 +-
 .../memory-controllers/ddr/jedec,lpddr4.yaml       |   2 +-
 .../memory-controllers/ddr/jedec,lpddr5.yaml       |   2 +-
 ...lpddr-channel.yaml => jedec,sdram-channel.yaml} |  40 +-
 .../memory-controllers/ddr/jedec,sdram-props.yaml  |  94 +++
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
 drivers/perf/stm32_ddr_pmu.c                       | 897 +++++++++++++++++++++
 {drivers => include/linux}/bus/stm32_firewall.h    |   0
 26 files changed, 1351 insertions(+), 98 deletions(-)
---
base-commit: f777d1112ee597d7f7dd3ca232220873a34ad0c8
change-id: 20250813-b4-ddrperfm-upstream-e8442bcc8396

Best regards,
--  
Clément Le Goffic <legoffic.clement@gmail.com>

