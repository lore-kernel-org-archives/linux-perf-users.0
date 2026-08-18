Received: from mailgw1.hygon.cn (unknown [101.204.27.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F20DD5474F;
	Tue, 18 Aug 2026 10:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.204.27.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787047318; cv=none; b=NmvmN18f+hhC/BM5Rh8a6poXcmc9LDdN8EPHjhUBBRR/isYygCjGZ2H3YpvYwguIyXhMJ7NpPcomSxp4+3mNeXH/QPbd3ipy7fGiwJsET2Om3PbxgV3xQtJu/L0U7P1BfINMRv+oMKXBgiHsrujOXoA32iavyq87O6rhVzx/ZAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787047318; c=relaxed/simple;
	bh=fb+u7eGtQhw1rnhVJ/thw1irkn4WUSegCW7z8+nYXEM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZQPb3DP/Yku1lHyPhydXoIDKRm3Z9CSX+aV6guR+puqKppw3ROg17vU/m3XJ4UCmRDZ40o9i7HkeV3TlDPLHnlGyUTKkTpxBq7Hxp4P9r0QNie6eMLcA5XzCve7k1n8TL8t+/n6mM9dhPGmw2fXamXJVS2YTeIwNFaY+cfbUjdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn; spf=pass smtp.mailfrom=hygon.cn; arc=none smtp.client-ip=101.204.27.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hygon.cn
Received: from maildlp2.hygon.cn (unknown [127.0.0.1])
	by mailgw1.hygon.cn (Postfix) with ESMTP id 4hPQG902npz1Sl2J;
	Tue, 18 Aug 2026 18:01:37 +0800 (CST)
Received: from maildlp2.hygon.cn (unknown [172.23.18.61])
	by mailgw1.hygon.cn (Postfix) with ESMTP id 4hPQG76QBBz1Sl2J;
	Tue, 18 Aug 2026 18:01:35 +0800 (CST)
Received: from cncheex04.Hygon.cn (unknown [172.23.18.114])
	by maildlp2.hygon.cn (Postfix) with ESMTPS id 016EA300D1E7;
	Tue, 18 Aug 2026 17:58:09 +0800 (CST)
Received: from neptune.hygon.cn (172.22.228.106) by cncheex04.Hygon.cn
 (172.23.18.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Tue, 18 Aug
 2026 18:01:35 +0800
From: Qi Liu <liuqi@hygon.cn>
To: <peterz@infradead.org>, <mingo@redhat.com>, <namhyung@kernel.org>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<sandipan.das@amd.com>, <ravi.bangoria@amd.com>, <irogers@google.com>,
	<x86@kernel.org>
CC: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lijing@hygon.cn>, <liuqi@hygon.cn>
Subject: [PATCH v5 0/2] perf/x86/amd/uncore: Add Hygon uncore PMU and JSON events
Date: Tue, 18 Aug 2026 10:01:16 +0000
Message-ID: <20260818100118.12944-1-liuqi@hygon.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: cncheex05.Hygon.cn (172.23.18.115) To cncheex04.Hygon.cn
 (172.23.18.114)

This series adds initial uncore PMU support for Hygon Family 18h
processors.

Hygon uncore PMUs use a programming model similar to AMD's, but
differ in MSR base addresses, event encodings, and counter allocation
semantics. Rather than embedding Hygon support in the AMD uncore
driver with vendor checks, a dedicated driver is introduced to keep
both drivers clean and independently maintainable.

The new driver provides hygon_df and hygon_df_iod PMUs covering the
Data Fabric on both the CPU die and the IO Die, together with perf
JSON events and metrics for three processor models. A per-context
hrtimer handles counter reads, and CPU hotplug callbacks manage
context lifecycle.

Changes since RFC:
  - Address sashiko bot review.
Changes since v1:
  - Rename the helper namespace to amd_uncore_common_* to avoid
    an generic uncore_common_* prefix, and to keep it distinct
    from the existing amd_uncore_* names.
Changes since v2:
  - Drop the common helpers refactoring. Keep the Hygon driver
    self-contained instead, avoiding unnecessary changes in the AMD
    uncore driver.
Changes since v3:
  - Address sashiko bot review.
Changes since v4:
  - Improve Hygon Data Fabric PMU event naming, descriptions, and scaling.

Qi Liu (2):
  perf/x86/amd/uncore: Add Hygon uncore PMU support
  perf vendor events hygon: Add Hygon Data Fabric PMU events and metrics

 arch/x86/events/Kconfig                       |  11 +
 arch/x86/events/amd/Makefile                  |   2 +
 arch/x86/events/amd/hygon_uncore.c            | 872 ++++++++++++++++++
 arch/x86/events/amd/uncore.c                  |  11 +-
 arch/x86/include/asm/msr-index.h              |   2 +
 arch/x86/include/asm/perf_event.h             |  20 +
 include/linux/cpuhotplug.h                    |   3 +
 tools/perf/pmu-events/Build                   |   2 +-
 .../arch/x86/hygonm1/data-fabric.json         |  95 ++
 .../arch/x86/hygonm4/data-fabric.json         | 134 +++
 .../arch/x86/hygonm6/data-fabric.json         | 170 ++++
 tools/perf/pmu-events/arch/x86/mapfile.csv    |   3 +
 tools/perf/pmu-events/jevents.py              |   2 +
 13 files changed, 1318 insertions(+), 9 deletions(-)
 create mode 100644 arch/x86/events/amd/hygon_uncore.c
 create mode 100644 tools/perf/pmu-events/arch/x86/hygonm1/data-fabric.json
 create mode 100644 tools/perf/pmu-events/arch/x86/hygonm4/data-fabric.json
 create mode 100644 tools/perf/pmu-events/arch/x86/hygonm6/data-fabric.json

-- 
2.34.1


