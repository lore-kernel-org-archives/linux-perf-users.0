Received: from mailgw1.hygon.cn (unknown [101.204.27.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8A029ACC5;
	Tue, 19 May 2026 03:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.204.27.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779161586; cv=none; b=NUXjHTqBqSOqOeoFj6ZlVeT0jxVvylDJ+lZYjrNn7UkerLM+J3J4Rn+qDtOfKtFez3OkayMrwGUtAMpBsoPGQ7NEnKqlBZBj+9Bd2t4UhNDE3922q2N0IPr7cjPZqT+oLYVgKF8tJpe9EeFCAw0HrHLSasP3ULNizFdKCfeRGT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779161586; c=relaxed/simple;
	bh=JJ/FBfHZWGGDPtINZf8GfzhqdfL42bYPdCgBhJe7lfE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=k5yR83BPUd6C0ntlTKFsyPoob5DFzvmoerzNiGoohV5Yh9sUYlIyKfWzSkwQOtjvxPxFG6AJPRh9ARz6iOJDZ0EVNh7Rl3fk2YR5e1X7pKZNmBE5quVvbPsvR1q/YlwK3zqmBXHYvXO2Lo+hE6jz7jbUQ5dQUfz8FMpYEV3iOXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn; spf=pass smtp.mailfrom=hygon.cn; arc=none smtp.client-ip=101.204.27.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hygon.cn
Received: from maildlp2.hygon.cn (unknown [127.0.0.1])
	by mailgw1.hygon.cn (Postfix) with ESMTP id 4gKKxN3KQYzTNfK;
	Tue, 19 May 2026 11:32:40 +0800 (CST)
Received: from maildlp2.hygon.cn (unknown [172.23.18.61])
	by mailgw1.hygon.cn (Postfix) with ESMTP id 4gKKxL35TZzTNfK;
	Tue, 19 May 2026 11:32:38 +0800 (CST)
Received: from cncheex04.Hygon.cn (unknown [172.23.18.114])
	by maildlp2.hygon.cn (Postfix) with ESMTPS id CF3E5315ECBE;
	Tue, 19 May 2026 11:31:53 +0800 (CST)
Received: from neptune.hygon.cn (172.22.228.106) by cncheex04.Hygon.cn
 (172.23.18.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Tue, 19 May
 2026 11:32:37 +0800
From: Qi Liu <liuqi@hygon.cn>
To: <peterz@infradead.org>, <mingo@redhat.com>, <namhyung@kernel.org>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>, <x86@kernel.org>
CC: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lijing@hygon.cn>, <liuqi@hygon.cn>
Subject: [RFC PATCH 0/3] perf/x86/amd/uncore: Add common helpers and Hygon support
Date: Tue, 19 May 2026 03:32:22 +0000
Message-ID: <20260519033225.1479907-1-liuqi@hygon.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: cncheex06.Hygon.cn (172.23.18.116) To cncheex04.Hygon.cn
 (172.23.18.114)

This series adds initial Hygon uncore PMU support.

Hygon uncore PMUs use a programming model close to the AMD uncore PMU,
so this series factors out a small set of common helpers for perf event
handling, counter assignment and per-CPU context management.

The Hygon-specific support is kept in the Hygon driver. This RFC
currently includes support for the Hygon DF and DF IOD PMUs. No
Hygon-specific logic is added to the AMD driver.

There is also an Hygon L3 PMU patch currently under review:
https://lore.kernel.org/lkml/9a4731a46cc0a7645838bd848a40a6574a97bad6.1775548724.git.fuhao@open-hieco.net/
If the overall approach in this RFC looks acceptable, that support can
be rebased onto this common helper structure in follow-up patches.

This is an RFC. Comments on the helper boundaries and file placement
are welcome.

Qi Liu (3):
  perf/x86/amd/uncore: Add common PMU helper functions
  perf/x86/amd/uncore: Convert AMD driver to common PMU helpers
  perf/x86/amd/uncore: Add Hygon uncore PMU support

 arch/x86/events/Kconfig             |  11 +
 arch/x86/events/amd/Makefile        |   4 +-
 arch/x86/events/amd/hygon_uncore.c  | 567 +++++++++++++++++++++++++++
 arch/x86/events/amd/uncore.c        | 585 ++++------------------------
 arch/x86/events/amd/uncore_common.c | 390 +++++++++++++++++++
 arch/x86/events/amd/uncore_common.h | 113 ++++++
 arch/x86/include/asm/msr-index.h    |   2 +
 arch/x86/include/asm/perf_event.h   |  20 +
 include/linux/cpuhotplug.h          |   3 +
 9 files changed, 1184 insertions(+), 511 deletions(-)
 create mode 100644 arch/x86/events/amd/hygon_uncore.c
 create mode 100644 arch/x86/events/amd/uncore_common.c
 create mode 100644 arch/x86/events/amd/uncore_common.h

-- 
2.34.1


