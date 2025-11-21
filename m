Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F3D1E0DFE;
	Fri, 21 Nov 2025 06:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763706910; cv=none; b=KS+zTgWIpJ0pvcNApkac8QNYvYINDg9/ScaWhTyfZVDCdmH+I4YexoIZAGZhPBr8MbsCjf7ZpRXVuHkZAe9gHBuZLZ72u4UOVNS3GaPkWW0PIwOAnVW3oDZ4aVRta95Bc7GYmDZU4uMb3PdkQxDWYiRNMptuDt6Ydtrfa/SE72E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763706910; c=relaxed/simple;
	bh=zMSDDLDUe8c4wD5uDNfH5p1DEY8d5Ax+YGvcHudNLiM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XNFsONAw5OzJqlA0bljmL3s3eIz95A4ws1MJzujZJO7g2q3KXVXuOmwneTOwlUmLxoVWd0PZ3PFusCnExtfRtCm8VncbIxIxa7Z+evAK190s2LeQtxoQQ6xKuOJDSPj7nBg1DpxcnbSAFb+jVuAsxyIRlKe2svC/EoQuIUA0Ygw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Q/kShyQn; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Q/kShyQn"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1763706900; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=UmXbqM0JY6kjsKySz34atLgV4D046f4p8ol4pZE44Vo=;
	b=Q/kShyQnIcKKaT99GWYB5ctiS9zdpFKT/T33r5Wy3lZP92MvfReo0MNwQeutTChPh390J4R+n0GA9IxUaeaVelXBO5uMHv+r8+BD4VP2JvuFC41YflaURJhCDaA0FFQLa5txCjsbXmWETmL9Ggfyj1Dy8mpACJE7ljNupiKfjH4=
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0Wt-RZCZ_1763706884 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 21 Nov 2025 14:34:58 +0800
From: cp0613@linux.alibaba.com
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	james.clark@linaro.org,
	guoren@kernel.org
Cc: devicetree@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Chen Pei <cp0613@linux.alibaba.com>
Subject: [PATCH v2 0/4] perf vendor events riscv: Add XuanTie C930 JSON files
Date: Fri, 21 Nov 2025 14:34:35 +0800
Message-ID: <20251121063439.2545-1-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen Pei <cp0613@linux.alibaba.com>

XuanTie[1] is the RISC-V processor brand of C-SKY Microsystems Co., Ltd.
This patch series first adds vendor XuanTie, then adds XuanTie C930 CPU
compatible, and finally adds pmu json files for XuanTie C930, including
topdown and some other metric groups.

Note:
According to the "Standard Manufacturer's IDENTIFICATION CODE"[2], the
manufacturer of Code '0x5b7' has changed to C-SKY Microsystems Co., Ltd.

[1] https://www.xrvm.com/
[2] https://www.jedec.org/standards-documents/docs/jep-106ab

Chen Pei (4):
  dt-bindings: vendor-prefixes: Add prefix for XuanTie
  dt-bindings: riscv: Add XuanTie C930 CPU compatible
  perf vendor events riscv: Add XuanTie C930 JSON file
  perf vendor events riscv: Add XuanTie C930 metrics

 .../devicetree/bindings/riscv/cpus.yaml       |   1 +
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 tools/perf/pmu-events/arch/riscv/mapfile.csv  |   1 +
 .../arch/riscv/xuantie/c930/basic.json        | 117 ++++
 .../arch/riscv/xuantie/c930/ieu.json          |  97 ++++
 .../arch/riscv/xuantie/c930/ifu.json          |  62 ++
 .../arch/riscv/xuantie/c930/l2c.json          |  87 +++
 .../arch/riscv/xuantie/c930/lsu.json          | 182 ++++++
 .../arch/riscv/xuantie/c930/metrics.json      | 538 ++++++++++++++++++
 .../arch/riscv/xuantie/c930/vfpu.json         | 177 ++++++
 10 files changed, 1264 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/riscv/xuantie/c930/basic.json
 create mode 100644 tools/perf/pmu-events/arch/riscv/xuantie/c930/ieu.json
 create mode 100644 tools/perf/pmu-events/arch/riscv/xuantie/c930/ifu.json
 create mode 100644 tools/perf/pmu-events/arch/riscv/xuantie/c930/l2c.json
 create mode 100644 tools/perf/pmu-events/arch/riscv/xuantie/c930/lsu.json
 create mode 100644 tools/perf/pmu-events/arch/riscv/xuantie/c930/metrics.json
 create mode 100644 tools/perf/pmu-events/arch/riscv/xuantie/c930/vfpu.json

-- 
2.50.1

