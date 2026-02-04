Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6905819D074;
	Wed,  4 Feb 2026 09:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770196176; cv=none; b=emN/XGDZoSuTWcTEPj5ITB63os4XrrMTBponWmC/FcN+I6ILqIOqX1pWq1lVe2BOu8U6t9zdnFUT08NWBHEAHG9Jjtcesx4keT3EW+SWXVx0jll2G16zK9VgaJJ7SpVcNR6cqB9ap5yKVMgwhKQQoL9uXwD7FDlb7iJI8w9Y8MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770196176; c=relaxed/simple;
	bh=UDJKu6TLZFsNvK/qJEvfwJi1S+NJR8Fs9OkuI3hLRcs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ClvJHa645BdKmMdJMBw9tKMmC5mY+GGIskUU/wSlnJvOq6S9YGCrsU/xM7jIpECYvm9gqcY0ENzcBDsK6P0iujGmzDzb7WyeLQfEftRdyNSghEGQSVqLtYF8dgO8gt9UKTv0+Q2K5S6n8vQt0P1yT6o1FMcmCFVPlStdGZcffP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=U/RFvZO4; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="U/RFvZO4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1770196117;
	bh=7ZuMw0aQly17hASOLNtnfsuLRFEAsjJjbUhrNvIUsVY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=U/RFvZO4HG6wBmETcvb3+jPzNigmYwBRloHG6fqG8Hsdzscy1jBPqVKf0Ge02Z9WK
	 b8kSmlc5oDXqk0r/5Ya929qHvI8Eh6c/geFYHqyWP/o9Z7BO2ExPNfcPMzqibKK6G1
	 d8Z+69MAW/lhsdkMBf/RdNGci1eiztRoN21jtTZ4=
X-QQ-mid: esmtpsz16t1770196115t30b0e720
X-QQ-Originating-IP: B58uKBjvV/rf2o6+mC3RVsaz6JIpIozYKaP2j7Fq5yo=
Received: from SurfaceBook2-B.localdomain ( [101.70.125.34])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 04 Feb 2026 17:08:31 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2290105156502900697
EX-QQ-RecipientCnt: 19
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
	Alexandre Ghiti <alex@ghiti.fr>
Cc: Jingyu Li <joey.li@spacemit.com>,
	Lv Zheng <lv.zheng@linux.spacemit.com>,
	Zhijian Chen <zhijian@spacemit.com>,
	iommu@lists.linux.dev,
	linux-perf-users@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	devicetree@vger.kernel.org
Subject: [PATCH v3 0/8] iommu/riscv: Add HPM support for RISC-V IOMMU
Date: Wed,  4 Feb 2026 17:08:19 +0800
Message-ID: <F9748E3984D2A6F9+cover.1770195980.git.lv.zheng@linux.spacemit.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1769562575.git.lv.zheng@spacemit.com>
References: <cover.1769562575.git.lv.zheng@spacemit.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: NYlggeZuI0UG/KlMlGBUTrf77Lgf/zsjGw76oNLG6XNRXDUfkhzJl9D3
	guMM4f3/Q6CqEP+N8NhTXSJgNBDbZVLpW05tUY4im5HEouteKRRHDkCvY0ISinGDiLWQbqV
	nie+vb5VTVRzkHg0o3QqSiAQ34sf8JP76goCOszAeFiQPlFC7EItyEbP1kJVzLUH1n9t+5Y
	IWgG9/3Od7N5KMTj3bULPZr54hJHQfqL8pn7xM0BYqNj5tGE0GjpSypN6XPhaRJT7N6ivlj
	wUutk8IYA4AyHAP0k1YIHHWcNWRd4LDogKYMhf6jznpMEqNHoAKBqXadomn+lLytVPiVRGt
	hq3vmRgL9eMnr99sNaFNqd9VnueKq29o4hkwvMLReh3m8ISZNKlpP7zB5BNV5x/u6Wl61B9
	p3Sx+AJgWuXWI+soTlu3xVayjOnix32SNP9sGLKFOLHIyoqs8YzzJ5+pxAymQv9BmK9NHdp
	ZiuNuJHRBHo0yBHLqC7EwTZW2yE80X3tibNxfSpYpWiegKpqHJIEcP1f+Lf1xnkRDzFFBLX
	/nwgU1MsNQ0Ux1al+nKJnlyYzioeEYJzUUPTgR2ZI5Jlv5WGo2Qjw8NY9j17ooNIQDsyrv8
	dulcWygrRmiizQHuPE/BlKIqYWJw96ENbmFo9JbeHiMgHbpT9IO+6Ssr5LZKINeMCbvYhU3
	Ekxn8+XGddq9gr6PUJG53Eef529BjpkvQdJe3j5rNyBPdjRxod5DVhzUesasCwiw5tipymA
	VPXxXfnoRs+VUi8fE9UA1/ik1O+cedENUgh+YrXo6JSwdErs324aWqzUBSJQOI2EK4S+7Ot
	Hc03OSyOCJPgrY9Yv9ghDwZ6YQ05nRLmBzfh0Gq1BJZExhdKgRBHqeQKNCG35AsR+D3S8Th
	/AVS3F2frAc1DG0O8a00se4IYxrf78PHPDVPnOKkZC4RxKLe2yoTlx2jRnA9Ypg/7gNbuXj
	GS6SWkr1HHi4G2bfKGgDZNkmohJs6MUhgaKCpdA2yt7y/dwVAuYbLlfkY
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
X-QQ-RECHKSPAM: 0

Includes HPM support for RISC-V IOMMU. The HPM hardware mechanism can be
found in the recent announced SpacemiT SoCs (K3, V100), where T100
(SpacemiT distributed IOMMU) is shipped. 

Revisions:
v1
 Initial release.
v2 (sent as v1.1)
 Split and cleanup DT-bindings.
v3
 Refactor using vendor specific compatible.

The tested result can be found as follows:

 root@sdfirm:~# perf stat --timeout 5000 -a -e spacemit_ioats_hpm_00/dd_walk,config1=0x20c0010000000000/ dmatest; sleep 1
 [  145.630224] dmatest: Started 1 threads using dma0chan0
 [  145.644896] dmatest: dma0chan0-copy0: summary 1 tests, 0 failures 123.60 iops 123 KB/s (0)

  Performance counter stats for 'system wide':

                  3      spacemit_ioats_hpm_00/dd_walk,config1=0x20c0010000000000/                                      

        0.193108000 seconds time elapsed

 root@sdfirm:~# echo dma0chan1 > /sys/module/dmatest/parameters/channel 
 [  327.001820] dmatest: Added 1 threads using dma0chan1
 root@sdfirm:~# perf stat --timeout 5000 -a -e spacemit_ioats_hpm_00/s_walk,config1=0x20c0011000000000/ dmatest; sleep 1
 [  484.037180] dmatest: Started 1 threads using dma0chan1
 [  484.048832] dmatest: dma0chan1-copy0: summary 1 tests, 0 failures 172.11 iops 172 KB/s (0)

  Performance counter stats for 'system wide':

                  6      spacemit_ioats_hpm_00/s_walk,config1=0x20c0011000000000/                                      

        0.191970000 seconds time elapsed

 root@sdfirm:~# perf stat --timeout 5000 -a -e spacemit_ioatc_hpm_0003/tlb_mis,config1=0x20c0011000000000/ dmatest; sleep 1
 [  546.332494] dmatest: No channels configured, continue with any
 [  546.363062] dmatest: Added 1 threads using dma0chan1
 [  546.377994] dmatest: Started 1 threads using dma0chan1
 [  546.388376] dmatest: dma0chan1-copy0: summary 1 tests, 0 failures 213.94 iops 213 KB/s (0)

  Performance counter stats for 'system wide':

                  3      spacemit_ioatc_hpm_0003/tlb_mis,config1=0x20c0011000000000/                                      

        0.225062000 seconds time elapsed

Jingyu Li (3):
  iommu/riscv: Enable IOMMU DMA mapping support
  iommu/riscv: Fix WSI mode IRQ number handling
  iommu/riscv: Add HPM support for performance monitoring

Lv Zheng (5):
  dt-bindings: iommu: Add spacemit/t100 features
  riscv/iommu: Add vendor event support for RISC-V IOMMU HPM
  spacemit/t100: Add global filter awareness for RISC-V IOMMU HPM
  spacemit/t100: Add SpacemiT T100 IOATC HPM support
  perf vendor events riscv:: Add support for spacemit,riscv-iommu HPM
    aliasing

 .../bindings/iommu/riscv,iommu.yaml           |   37 +
 MAINTAINERS                                   |    3 +
 drivers/iommu/Kconfig                         |    2 +-
 drivers/iommu/riscv/Kconfig                   |    9 +
 drivers/iommu/riscv/Makefile                  |    1 +
 drivers/iommu/riscv/iommu-bits.h              |   18 +
 drivers/iommu/riscv/iommu-hpm.c               | 1122 +++++++++++++++++
 drivers/iommu/riscv/iommu-pci.c               |   13 +-
 drivers/iommu/riscv/iommu-platform.c          |   12 +-
 drivers/iommu/riscv/iommu.c                   |   25 +-
 drivers/iommu/riscv/iommu.h                   |   46 +-
 .../arch/riscv/spacemit/iommu/sys/ioatc.json  |   30 +
 .../arch/riscv/spacemit/iommu/sys/ioats.json  |  163 +++
 13 files changed, 1469 insertions(+), 12 deletions(-)
 create mode 100644 drivers/iommu/riscv/iommu-hpm.c
 create mode 100644 tools/perf/pmu-events/arch/riscv/spacemit/iommu/sys/ioatc.json
 create mode 100644 tools/perf/pmu-events/arch/riscv/spacemit/iommu/sys/ioats.json

-- 
2.43.0

