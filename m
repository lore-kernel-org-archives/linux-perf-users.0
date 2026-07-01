Received: from mailgw1.hygon.cn (unknown [101.204.27.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 300013F39C2;
	Wed,  1 Jul 2026 09:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.204.27.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782898490; cv=none; b=AN7UqQzIy3GHU4TFt6haAHP47i1LdavEomfXbg+auJcIBOyHRucppPXBvydmjeLQB03jv86M5se3Gmv1tEu9dKzM4zYoc1gEjwO93FXLJgiYyPzKBnWxe6Xxg5JGcIIpEAKDZZhjvQ5toQJ2FCnNGT8vtx17YLGIwyICy4RWd6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782898490; c=relaxed/simple;
	bh=u48VYgkihDHwFxKladTXKlXCbqZuhgm4u8qRQgVl3nY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=otk3Fkf/FlJjRnIhYGb1D5HxZD8uUCRimxjB64b7oRbaYBc+LZq3BT3G9R9BuePfveVcgSv3sJFYtHyCfU3C96JYutLGWbPnFcNOr2fsM5fwKcyAAT8Ui4lEv5S1R+M+wRhA5+6xUB2hvtAXxMZ6QFW+j/JpXA+dTOwYvi+5leo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn; spf=pass smtp.mailfrom=hygon.cn; arc=none smtp.client-ip=101.204.27.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hygon.cn
Received: from maildlp1.hygon.cn (unknown [127.0.0.1])
	by mailgw1.hygon.cn (Postfix) with ESMTP id 4gqvx238qszT0bc;
	Wed,  1 Jul 2026 17:34:30 +0800 (CST)
Received: from maildlp1.hygon.cn (unknown [172.23.18.60])
	by mailgw1.hygon.cn (Postfix) with ESMTP id 4gqvx12DntzT0bc;
	Wed,  1 Jul 2026 17:34:29 +0800 (CST)
Received: from cncheex04.Hygon.cn (unknown [172.23.18.114])
	by maildlp1.hygon.cn (Postfix) with ESMTPS id 8BDD2594B;
	Wed,  1 Jul 2026 17:34:22 +0800 (CST)
Received: from neptune.hygon.cn (172.22.228.106) by cncheex04.Hygon.cn
 (172.23.18.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Wed, 1 Jul
 2026 17:34:28 +0800
From: Qi Liu <liuqi@hygon.cn>
To: <peterz@infradead.org>, <mingo@redhat.com>, <namhyung@kernel.org>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>, <x86@kernel.org>
CC: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lijing@hygon.cn>, <liuqi@hygon.cn>
Subject: [PATCH v2 0/3] perf/x86/amd/uncore: Add common helpers and Hygon support
Date: Wed, 1 Jul 2026 09:34:14 +0000
Message-ID: <20260701093417.1312443-1-liuqi@hygon.cn>
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

This series adds initial Hygon uncore PMU support.

Hygon uncore PMUs use a programming model close to the AMD uncore PMU,
so this series factors out a small set of common helpers for perf event
handling, counter assignment and per-CPU context management.

The Hygon-specific support is kept in the Hygon driver. This series
supports the Hygon DF and DF IOD PMUs. No Hygon-specific logic is
added to the AMD driver.

Changes since RFC:
  - Address sashiko bot review.
Changes since v1:
  - Rename the helper namespace to amd_uncore_common_* to avoid
    an generic uncore_common_* prefix, and to keep it distinct
    from the existing amd_uncore_* names.


Qi Liu (3):
  perf/x86/amd/uncore: Add common PMU helper functions
  perf/x86/amd/uncore: Convert AMD driver to common PMU helpers
  perf/x86/amd/uncore: Add Hygon uncore PMU support

 arch/x86/events/Kconfig                 |  17 +
 arch/x86/events/amd/Makefile            |   4 +
 arch/x86/events/amd/amd_uncore_common.c | 403 +++++++++++++++++
 arch/x86/events/amd/amd_uncore_common.h | 114 +++++
 arch/x86/events/amd/hygon_uncore.c      | 556 +++++++++++++++++++++++
 arch/x86/events/amd/uncore.c            | 578 +++---------------------
 arch/x86/include/asm/msr-index.h        |   2 +
 arch/x86/include/asm/perf_event.h       |  20 +
 include/linux/cpuhotplug.h              |   3 +
 9 files changed, 1192 insertions(+), 505 deletions(-)
 create mode 100644 arch/x86/events/amd/amd_uncore_common.c
 create mode 100644 arch/x86/events/amd/amd_uncore_common.h
 create mode 100644 arch/x86/events/amd/hygon_uncore.c

-- 
2.34.1


