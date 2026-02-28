Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5952143E9DF;
	Sat, 28 Feb 2026 14:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772290044; cv=none; b=Yzm06WTpWi/19U3myQ67C0GmKe2Ypn3bfut+3hflbz4dyyLugHJx3beGaBpXy48c+uSYGOsPN0GLFf3rOTLUvAS2/eBckuRCSogNO5FjVMsWgNzMg/GO00+7k0Edp5BGGrL3L7VRi8b4PJnaVenPT4kGpaS4kA7L2W3aOXC3NQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772290044; c=relaxed/simple;
	bh=AsKvI+ijqHjQa3sgDY1PPryHZxIup6q2dSFasj6EQXI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G7p/fzXeRMtZKqrg3r3pLYWIyaLl6QIZBfg78fmTGtGCeJJAoON7wcJPFfq18VuJscsu2tvkN61M+QfOi+PvJr3WF9gf0oNzhBXFRDrT5GrRaYnudvO5TVtJXAD9lZ6GuGdfuB+Xsl9I6bIgIpXOH9/Hf0wXTzrsvCfWYUDHO+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=cdUhVrAn; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="cdUhVrAn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1772289841;
	bh=VFpZj6jKARnaID1I10ixu24mzXdyy5SN61+au0Q3ZPc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=cdUhVrAnVOsRvbB2eYzrKAnB/tna4valCaKOwSU3723n/f9Z3LaOK2hkRHthFr7G2
	 m8/LKDODnIeHfcQq+/lWH70XKFuH6we3HHbboG3dtEBDwqhXC20xILcCepsow2D7Qv
	 1kgzcewL/SUKNm3jYn0/nxIUzOxrj58QsMOXNOUM=
X-QQ-mid: zesmtpsz3t1772289839t48d62097
X-QQ-Originating-IP: +vVQa2LLG+FVJ/e80s+itn7Z14UcwpwT8kcqAcUN2/M=
Received: from SurfaceBook2-B.localdomain ( [183.193.112.19])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 28 Feb 2026 22:43:54 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10233903411919513478
EX-QQ-RecipientCnt: 33
From: Lv Zheng <lv.zheng@linux.spacemit.com>
To: Tomasz Jeznach <tjeznach@rivosinc.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Yixun Lan <dlan@kernel.org>
Cc: Jingyu Li <joey.li@spacemit.com>,
	Lv Zheng <lv.zheng@linux.spacemit.com>,
	Zong Li <zong.li@sifive.com>,
	Yaxing Guo <guoyaxing@bosc.ac.cn>,
	Zhijian Chen <zhijian@spacemit.com>,
	iommu@lists.linux.dev,
	linux-perf-users@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/8] iommu/riscv: Add HPM support for RISC-V IOMMU
Date: Sat, 28 Feb 2026 22:43:38 +0800
Message-ID: <0CA1C3965143B3A7+cover.1772289741.git.lv.zheng@linux.spacemit.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: MSZecc01IPj5diyjRvIOeQg2lFZZ003e583DDRseQoWTiEz7vBEAgPMa
	noYsdDxSZUPD3IL+brT+9sNb90GW/OpWvOsDs+wGGZ/TPvf6+igYfwXB4Kegqbu9ajzlR7S
	tjb2jXOUPxDJptG8lb1jIqrJPzFMMgPF/l+JGpeHWAQkAe6AqrU08FmJ0xim2GfqwuEBvtt
	Zsh9WjeTV9m7f53sU4JgMPg0suHsIGbW/+yR3ltOFZg/bj6QR/eDHyMhSbgIS8X4RucXugZ
	/MgqVNPmALUqsZ4Eld/ACd+dZLva9CoOaLHxjgfPr4xu7sSWIflrUErPYhS7sCs5jt+d4dd
	CgUlo4Sl+8erx8vj7G1QWC6gd4jsphwmv0OeUxhYRZhQ57cCoOR1Y33RNKt/xdIUxQjcjmF
	EOQL/XGo+YNheCz7fMzaCF59PiL+QgZ/uagWD6k3lkEWjuckdHZeP4FdkxMSMVWb5/KmlgT
	QI5IFishcGXozF54/G2PurI128vQebvTEk0u4qkY1WJFH4HUwoids+5h0XSJpXQAuJ5qc5m
	6IKHb8PIvxgwE1UHFUopRICPA/qYSM3bCcSMvsZ0fwfAiakqdfF8JEUy08gEvci6FPWwi/L
	14UQRsHdvzTsqdkovmFKd40kfi6N9RKmIXi6H228dEHh3yK3fiTRmceaI0HYMLDSokKdM4c
	+DrsO38KmiGkkgZPox+YZWrPrprAUvmIG3yWjUEQtSLtm8RgvwEKslLLoNwxHSPp6c2T0wJ
	WXt8aHfV8fRsuo105LAh/6Dh1yqMlBRzReZa6VSiqx/lbgK12Ox1ryV+MJvNaapUIccMQw7
	njXtnZSqJjBVJjtb1woNipOX+PP5vwiwifXfy+D0lLDsTcANvndIjDh1irGdlZs5yItXu73
	xKdhdr4QRdXriJdG5Q1vJqrvczlaS4Ap6pGDtzM51i6Z8wlDA9dJ1UotCc7nW75cF24qMP2
	y6adiLIEulIWFWpBs9Oq5ZI7gu6cNqRzfWZIi3EXAeV3j7vi09Ghyr9j0pLw0cfZTudgzi2
	7gBIhFCFFvnwMLggx5ZXf1HVfEPkELJJbOLJGgfQTXSef1tVTqkB7CubBFjhFn7JJ4fFr0H
	nra7bdb2udXyF1/iE8KxGOx0Bz4E2kYiJSOJ6g5oSb0
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-RECHKSPAM: 0

Includes HPM support for RISC-V IOMMU. The HPM hardware mechanism can be
found in the recent announced SpacemiT SoCs (K3, V100), where T100
(SpacemiT distributed IOMMU) is shipped. 

The RISC-V IOMMU specification defines optional HPM registers (IOHPMEVT,
IOHPMCTR, etc.) for performance monitoring of transactions through the
IOMMU. SpacemiT T100 implements this specification with a distributed
architecture: the main IOMMU (IOATS) is complemented by up to 64 IOATC
units that cache IOTLBs adjacent to DMA masters. Each IOATC has its own
HPM counters and PMIV interrupt.

This series introduces an auxiliary bus framework to allow the HPM
functionality to be implemented as a separate perf driver, keeping the
IOMMU core focused on translation. Vendor-specific extensions (SpacemiT
T100) are layered on top of the generic HPM infrastructure.

History:
The first revision of this series is posted without the awareness of
other on-going discussions. There are other postings providing same
functionality as [PATCH 2-3] in this thread:
1. Zong Li:
   https://lore.kernel.org/all/20250115030306.29735-1-zong.li@sifive.com/
   We aligned with Zong in the community here:
   https://lore.kernel.org/all/CANXhq0q8N5eHx9ytabZR97Y7AULKwgS2-uEGhcaOOGp9mvbtRQ@mail.gmail.com/
   >> Perhaps I can first post my next revision to the mailing list (hope
   >> it won't waste the community resource), so that you could have a
   >> chance to review it and see whether that version is architecturally
   >> closer to what the community is looking for, while also addressing
   >> your issue. If you also feel that my next revision meets your needs,
   >> perhaps you could append your additional implementations on top of
   >> it.
   >> Of course, if the community would prefer to go your version, I'm
   >> perfectly fine with that as well.
   His newest version can be found here:
   https://lore.kernel.org/all/20260208063848.3547817-1-zong.li@sifive.com/
2. Yaxing Guo:
   https://lore.kernel.org/all/20250915020911.1313-1-guoyaxing@bosc.ac.cn/
   Yaxing and Zong aligned each other in the community here:
   https://lore.kernel.org/linux-iommu/2ce9d8be-10b3-48dd-b99e-7358347fc171@bosc.ac.cn/
   >> Hi Zong Li,
   >> Of course yes, absolutely - I wasn't aware of your earlier
   >> submission. Please go ahead with your version.
This is the newest revision of this patchset, and [PATCH 2-3] is the one
that is competing with other contributions.

Revisions:
v1
 Initial release.
v2 (sent as v1.1)
 Split and cleanup DT-bindings.
v3
 1. Refactor using vendor specific compatible.
 2. Implement vendor events with a userspace identifier.
v4
 1. Drop ICVEC check which is not that usful as WSI device tree can use
    only 1 vector for IOATS CIV/FIV/PIV/PMIV.
 2. Solve DT binding check of "interrupts/maxItems" attribute.
 3. Address Robin's comments for an old revision sent by "Zong Li".
 4. Limit IOATC enumeration by referencing spacemit,riscv-iommu.
v5:
 1. Use correct style SoC/IP specific compatible.
 2. Address all on-going comments in other threads.
 3. Split compatible into SoC specific and IP specific.
 4. Switch to use auxiliary device framework.

The tested result can be found as follows:

 root@sdfirm:# perf stat --timeout 5000 -a -e spacemit_ioats_hpm_0/dd_walk,config1=0x20c0010000000000/ dmatest; sleep 1
 [  453.426404] dmatest: Started 1 threads using dma0chan0
 [  453.437152] dmatest: dma0chan0-copy0: summary 1 tests, 0 failures 212.04 iops 212 KB/s (0)
 
  Performance counter stats for 'system wide':
 
                  3      spacemit_ioats_hpm_0/dd_walk,config1=0x20c0010000000000/                                      
 
        0.190412000 seconds time elapsed
 
 root@sdfirm:~# perf stat --timeout 5000 -a -e spacemit_ioatc_hpm_1/tlb_mis,config1=0x20c0010000000000/ dmatest; sleep 1
 [  117.599620] dmatest: Started 1 threads using dma0chan0
 [  117.610698] dmatest: dma0chan0-copy0: summary 1 tests, 0 failures 186.07 iops 186 KB/s (0)
 
  Performance counter stats for 'system wide':
 
                  7      spacemit_ioatc_hpm_1/tlb_mis,config1=0x20c0010000000000/                                      
 
        0.196982000 seconds time elapsed

Jingyu Li (3):
  iommu/riscv: Enable IOMMU DMA mapping support
  iommu/riscv: Add auxiliary bus framework and HPM device support
  iommu/riscv: Add HPM support for performance monitoring

Lv Zheng (5):
  dt-bindings: iommu: Add spacemit/t100 features
  spacemit/t100: Add global filter awareness for RISC-V IOMMU HPM
  iommu/riscv: Add SpacemiT T100 IOATC HPM support
  iommu/riscv: Add vendor event support for RISC-V IOMMU HPM
  perf vendor events riscv: Add SpacemiT T100 HPM event aliases

 .../bindings/iommu/riscv,iommu.yaml           |   58 +-
 MAINTAINERS                                   |    5 +
 drivers/iommu/Kconfig                         |    2 +-
 drivers/iommu/riscv/Kconfig                   |    1 +
 drivers/iommu/riscv/iommu-bits.h              |   12 +
 drivers/iommu/riscv/iommu-pci.c               |    8 +-
 drivers/iommu/riscv/iommu-platform.c          |    7 +-
 drivers/iommu/riscv/iommu.c                   |  306 +++++
 drivers/iommu/riscv/iommu.h                   |   25 +-
 drivers/perf/Kconfig                          |    9 +
 drivers/perf/Makefile                         |    1 +
 drivers/perf/riscv_iommu_hpm.c                | 1012 +++++++++++++++++
 include/linux/riscv_iommu.h                   |   83 ++
 .../arch/riscv/spacemit/iommu/sys/ioatc.json  |   30 +
 .../arch/riscv/spacemit/iommu/sys/ioats.json  |  163 +++
 15 files changed, 1715 insertions(+), 7 deletions(-)
 create mode 100644 drivers/perf/riscv_iommu_hpm.c
 create mode 100644 include/linux/riscv_iommu.h
 create mode 100644 tools/perf/pmu-events/arch/riscv/spacemit/iommu/sys/ioatc.json
 create mode 100644 tools/perf/pmu-events/arch/riscv/spacemit/iommu/sys/ioats.json

-- 
2.43.0

