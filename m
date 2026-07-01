Received: from mailgw1.hygon.cn (unknown [101.204.27.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5740036A01E;
	Wed,  1 Jul 2026 03:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.204.27.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782877516; cv=none; b=LsACdJ7j5hFZ/7n1nuY7J9K51exzOX41CO8bIBjr0joYJkhUSQ36MsZd+TkmJHm/33RVO0chxNWzWJ7JMGeg/dNweGOveAHIZFDV48BPPZDtagS8cffMYJlasmMeaXVK+IBDE/hZPsu1Cbb5WzOxrMvjuljr6BaA0RtKvksVdCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782877516; c=relaxed/simple;
	bh=e+T3MMvJEr6KSY5DFPW6QwUxjx/bBzIk7zT34WPCVVw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lmYapNvqs4nGbeKijJ7E4Z0r+ZkU8/Av7JdqoR9Sf8fx4TQqi1NU6cg0d3h45u99EV7415VE1aadR4xR7SW+r9GTd7++XHf5hym6e/ksnjHiYHewZx9mkoaNcAzwjvz/sVeuwh9EGxdr2hIDgcp/gdba/ZrIZPzEl92/9dUefOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn; spf=pass smtp.mailfrom=hygon.cn; arc=none smtp.client-ip=101.204.27.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hygon.cn
Received: from maildlp1.hygon.cn (unknown [127.0.0.1])
	by mailgw1.hygon.cn (Postfix) with ESMTP id 4gqm9g3xpjztq84;
	Wed,  1 Jul 2026 11:44:55 +0800 (CST)
Received: from maildlp1.hygon.cn (unknown [172.23.18.60])
	by mailgw1.hygon.cn (Postfix) with ESMTP id 4gqm9c5y9Hztq84;
	Wed,  1 Jul 2026 11:44:52 +0800 (CST)
Received: from cncheex04.Hygon.cn (unknown [172.23.18.114])
	by maildlp1.hygon.cn (Postfix) with ESMTPS id 7F4431549;
	Wed,  1 Jul 2026 11:44:46 +0800 (CST)
Received: from neptune.hygon.cn (172.22.228.106) by cncheex04.Hygon.cn
 (172.23.18.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Wed, 1 Jul
 2026 11:44:52 +0800
From: Qi Liu <liuqi@hygon.cn>
To: <peterz@infradead.org>, <mingo@redhat.com>, <namhyung@kernel.org>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>, <x86@kernel.org>
CC: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lijing@hygon.cn>, <liuqi@hygon.cn>
Subject: [PATCH 0/3] perf/x86/amd/uncore: Add common helpers and Hygon support
Date: Wed, 1 Jul 2026 03:44:10 +0000
Message-ID: <20260701034413.718872-1-liuqi@hygon.cn>
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

The Hygon-specific support is kept in the Hygon driver. This series
supports the Hygon DF and DF IOD PMUs. No Hygon-specific logic is
added to the AMD driver.

There is also an Hygon L3 PMU patch currently under review:
https://lore.kernel.org/lkml/9a4731a46cc0a7645838bd848a40a6574a97bad6.1775548724.git.fuhao@open-hieco.net/
That support can be rebased onto this common helper structure in
follow-up patches.

Changes since RFC:
  - Address sashiko bot review.

Qi Liu (3):
  perf/x86/amd/uncore: Add common PMU helper functions
  perf/x86/amd/uncore: Convert AMD driver to common PMU helpers
  perf/x86/amd/uncore: Add Hygon uncore PMU support

 arch/x86/events/Kconfig             |  17 +
 arch/x86/events/amd/Makefile        |   4 +
 arch/x86/events/amd/hygon_uncore.c  | 551 ++++++++++++++++++++++++++
 arch/x86/events/amd/uncore.c        | 578 ++++------------------------
 arch/x86/events/amd/uncore_common.c | 403 +++++++++++++++++++
 arch/x86/events/amd/uncore_common.h | 114 ++++++
 arch/x86/include/asm/msr-index.h    |   2 +
 arch/x86/include/asm/perf_event.h   |  20 +
 include/linux/cpuhotplug.h          |   3 +
 9 files changed, 1187 insertions(+), 505 deletions(-)
 create mode 100644 arch/x86/events/amd/hygon_uncore.c
 create mode 100644 arch/x86/events/amd/uncore_common.c
 create mode 100644 arch/x86/events/amd/uncore_common.h

-- 
2.34.1


