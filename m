Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF441B94F;
	Tue, 18 Jun 2024 03:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718681035; cv=none; b=QbaG5K2vqQUD7H9/Ou1OXXiH/y8qs0N8z05RrtV5i+n6MuMoJMoEIxcoj9O2HC8AZHubrcW6P18ezFHrmTnHWoMXdX0/dIYYQzqqpYuxS1fsFpSEDCWQj/hVD1zFREfG7jgqxt+b4VmfaYWzQ8E5X9Y7AlWStLdXNhBFAoen/JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718681035; c=relaxed/simple;
	bh=Y+l45UM8hj2e/jO4PRlD7W9+/iyxkKt5sUyQW6vA+U4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TaPQkDsVM4fHl0p+9y+nvn34+DbGUvV2ICVEQf+e/oc+YcErYCInZRy6kvlTmxIr/M91nwZkKAvodaP+fqfMCgAQp9sSjY6PonF6Y1nX1MDK1DM0IOkMxG3K2ZFsnwB5uBOuln208vx1CQYji+I2NymhnbVYLAhPcQovVKCjRHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4W3BpB3gcMzPr07;
	Tue, 18 Jun 2024 11:20:18 +0800 (CST)
Received: from kwepemi100008.china.huawei.com (unknown [7.221.188.57])
	by mail.maildlp.com (Postfix) with ESMTPS id BFC9518007A;
	Tue, 18 Jun 2024 11:23:49 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi100008.china.huawei.com
 (7.221.188.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 18 Jun
 2024 11:23:48 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <linux@armlinux.org.uk>, <will@kernel.org>, <mark.rutland@arm.com>,
	<peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <alexander.shishkin@linux.intel.com>,
	<jolsa@kernel.org>, <irogers@google.com>, <adrian.hunter@intel.com>,
	<kan.liang@linux.intel.com>, <arnd@arndb.de>, <afd@ti.com>,
	<akpm@linux-foundation.org>, <rmk+kernel@armlinux.org.uk>,
	<linus.walleij@linaro.org>, <eric.devolder@oracle.com>, <robh@kernel.org>,
	<ardb@kernel.org>, <broonie@kernel.org>, <lihuafei1@huawei.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-perf-users@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH 0/2] ARM: 9259/1: stacktrace: Add USER_STACKTRACE support
Date: Tue, 18 Jun 2024 11:26:18 +0800
Message-ID: <20240618032620.2445395-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi100008.china.huawei.com (7.221.188.57)

Add USER_STACKTRACE support and Fix callchain_trace() return value bug
by the way.

Jinjie Ruan (2):
  ARM: 9258/1: Fix callchain_trace() return value
  ARM: 9259/1: stacktrace: Add USER_STACKTRACE support

 arch/arm/Kconfig                 |  1 +
 arch/arm/kernel/perf_callchain.c | 73 +++-----------------------------
 arch/arm/kernel/stacktrace.c     | 65 ++++++++++++++++++++++++++++
 3 files changed, 73 insertions(+), 66 deletions(-)

-- 
2.34.1

