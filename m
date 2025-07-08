Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A50E2D838B
	for <linux-perf-users@vger.kernel.org>; Tue,  8 Jul 2025 10:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751971254; cv=none; b=mWDqGvbsFMip/tALKuQQ+31shrkVX5fKFo8ei3Y/XQGFdz77UCUoCj8hqYR+jIsHWpehqSUZ0I0QGUOGCSEIfEzsrd10FElV1z7GmBqhbR2uH5rkFVKXcnS903n7+Y+zFYsRZcYGMaJXl+ywZUtOq7omfneZYJ8f7unGYWAKzfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751971254; c=relaxed/simple;
	bh=h9ffOMpprHtUlA4KIyfZI6VRD+DRW1c4F7q6RurLTgo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 References; b=YLr36TcJ3JuyBSMcEm3ELhQp27De1Obi6zjvS9AK01uMLrF5tgtPmIoYmvD7gWfDw0MqfiXhHYL6W86VUn3t3kyGtZqAHbjQgtal0rU+O7P93mWPsuG37H/6FIuYwfUar3Npr4AjGjK+cgVpzxuSeBwVX26+OH5Tq7J8Kxf7rA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=m+tJ9zxj; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="m+tJ9zxj"
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20250708104043epoutp0320ceee7d04c367b8776deabf1fa82a7f~QQJAs5LC42777027770epoutp03T
	for <linux-perf-users@vger.kernel.org>; Tue,  8 Jul 2025 10:40:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20250708104043epoutp0320ceee7d04c367b8776deabf1fa82a7f~QQJAs5LC42777027770epoutp03T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1751971243;
	bh=RZMbreJckeTZ7d9E/bDbGIS9B9tPEE2bV8tHwU4GBm0=;
	h=From:To:Cc:Subject:Date:References:From;
	b=m+tJ9zxjg3e2Ppo0qDrAkOwfLyyRAVGPWb266MqgxZTHik1/opyBbw9mz6NK7+8iu
	 AKsyb3KfUa6VsdOxZKOC/AT7hdg9XqDDUJANHhl22lbjDZql12zf53nbUGqvfXZdYB
	 /f49nqAah0LckRS7tF2oAk1A1lQNyh+hLQtyeP4A=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20250708104042epcas5p33bd592360cafe5d32801a3b6f3a0732c~QQJAFd4LA0190201902epcas5p3s;
	Tue,  8 Jul 2025 10:40:42 +0000 (GMT)
Received: from epcas5p3.samsung.com (unknown [182.195.38.179]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4bbyLd0vbqz6B9m7; Tue,  8 Jul
	2025 10:40:41 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20250708103228epcas5p27886821d1ff225f2e5cdd4d948d03a66~QQBzzm5CC0702607026epcas5p29;
	Tue,  8 Jul 2025 10:32:28 +0000 (GMT)
Received: from cheetah.samsungds.net (unknown [107.109.115.53]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250708103225epsmtip179cdbb1505bb6b730e052501f82e992d~QQBxLrGTX2131221312epsmtip1V;
	Tue,  8 Jul 2025 10:32:25 +0000 (GMT)
From: Vivek Yadav <vivek.2311@samsung.com>
To: pankaj.dubey@samsung.com, ravi.patel@samsung.com, shradha.t@samsung.com,
	mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org, krzk@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, will@kernel.org,
	mark.rutland@arm.com, s.nawrocki@samsung.com, cw00.choi@samsung.com,
	alim.akhtar@samsung.com, linux-fsd@tesla.com
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Vivek
	Yadav <vivek.2311@samsung.com>
Subject: [PATCH 0/6] Add PPMU support for Tesla FSD 
Date: Tue,  8 Jul 2025 16:02:02 +0530
Message-ID: <20250708103208.79444-1-vivek.2311@samsung.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250708103228epcas5p27886821d1ff225f2e5cdd4d948d03a66
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-541,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250708103228epcas5p27886821d1ff225f2e5cdd4d948d03a66
References: <CGME20250708103228epcas5p27886821d1ff225f2e5cdd4d948d03a66@epcas5p2.samsung.com>

The Platform Performance Measuring Unit (PPMU) is an AMBA-compliant
performance measurement tool designed to provide observability into
system-level operations. It provides performance statistics such as
as bandwidth, read and write request, transactions count for AXI masters.

FSD platform has two instances of PPMU IP in MFC. This patch series
contains PPMU clock binding definitions, device tree binding
documentation, PPMU24 driver support which configures the
PPMU24 hardware and the PPMU device tree node support
for Tesla FSD platform.

Vivek Yadav (6):
  dt-bindings: clock: Add PPMU clock definitions for FSD platform
  clk: samsung: fsd: Use clock IDs for PPMU MFC block
  dt-bindings: perf: Add devicetree binding for custom PPMU
  drivers: perf: samsung: Add PPMU driver support
  arm64: dts: fsd: Add PPMU support for MFC block of FSD SoC
  MAINTAINERS: Add maintainers for Samsung PPMU driver

 .../bindings/perf/samsung,ppmu-v2.yaml        |  62 +++
 MAINTAINERS                                   |   7 +
 arch/arm64/boot/dts/tesla/fsd-evb.dts         |   8 +
 arch/arm64/boot/dts/tesla/fsd.dtsi            |  20 +
 drivers/clk/samsung/clk-fsd.c                 |  10 +-
 drivers/perf/Kconfig                          |   2 +
 drivers/perf/Makefile                         |   1 +
 drivers/perf/samsung/Kconfig                  |  13 +
 drivers/perf/samsung/Makefile                 |   2 +
 drivers/perf/samsung/ppmu.c                   | 494 ++++++++++++++++++
 drivers/perf/samsung/ppmu_platform.c          | 338 ++++++++++++
 drivers/perf/samsung/samsung_ppmu.h           | 128 +++++
 include/dt-bindings/clock/fsd-clk.h           |   4 +
 13 files changed, 1084 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/perf/samsung,ppmu-v2.yaml
 create mode 100644 drivers/perf/samsung/Kconfig
 create mode 100644 drivers/perf/samsung/Makefile
 create mode 100644 drivers/perf/samsung/ppmu.c
 create mode 100644 drivers/perf/samsung/ppmu_platform.c
 create mode 100644 drivers/perf/samsung/samsung_ppmu.h

-- 
2.49.0

