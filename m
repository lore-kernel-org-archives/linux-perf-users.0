Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC462FB6;
	Mon,  8 Jul 2024 03:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720409090; cv=none; b=UZSTEIicQa5BZK+dDnps9N9cOPhmZQq4SrkX02BAzlXvLwGGE8D63pbVLJTs2BZSTRX9nVOD9KgMvFwT3drZIBqWpB8EOh90VOU91PmwR0K7NtXKNRaCe53TzVczWYpOWPaOli3ncC5gyRLuvXeZt1d/j/Y7g2kIGkYKOAyZ3c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720409090; c=relaxed/simple;
	bh=42UueihsMDWcffcCOXGpkM191DzqBLn5DOidjuQx6sY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Z/VB4MQVX3qE2o+dL5s/mkLRZJIN0wxUjLxPIV8S5CP/iJSiIlvZBN85uYsbsVq8odIOoZ2hI1iCi7qzwcTYxFDqdI5vd0OraSCDFU5KlIv0EG//TK/tMX4yin0uyYVJmcwraHq011+i11ODaZYAf43z9CecF6BN/ovrlCSzLkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WHTrr1MVJzxQ7S;
	Mon,  8 Jul 2024 11:20:12 +0800 (CST)
Received: from kwepemi100008.china.huawei.com (unknown [7.221.188.57])
	by mail.maildlp.com (Postfix) with ESMTPS id CCFB114037E;
	Mon,  8 Jul 2024 11:24:44 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi100008.china.huawei.com
 (7.221.188.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 8 Jul
 2024 11:24:44 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <bjorn@kernel.org>, <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
	<aou@eecs.berkeley.edu>, <peterz@infradead.org>, <mingo@redhat.com>,
	<acme@kernel.org>, <namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
	<dev.mbstr@gmail.com>, <samuel.holland@sifive.com>,
	<linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-perf-users@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH v3 0/2] riscv: stacktrace: Add USER_STACKTRACE support
Date: Mon, 8 Jul 2024 11:28:45 +0800
Message-ID: <20240708032847.2998158-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi100008.china.huawei.com (7.221.188.57)

Add RISC-V USER_STACKTRACE support, and fix the fp alignment bug
in perf_callchain_user() by the way as Björn pointed out.

Changes in v3:
- Fix the fp alignment bug in perf_callchain_user().
- Remove the LTP message as Björn suggested.
- Add the userstack trace test info.

Jinjie Ruan (2):
  riscv: Fix fp alignment bug in perf_callchain_user()
  riscv: stacktrace: Add USER_STACKTRACE support

 arch/riscv/Kconfig                 |  1 +
 arch/riscv/kernel/perf_callchain.c | 46 ++----------------------------
 arch/riscv/kernel/stacktrace.c     | 43 ++++++++++++++++++++++++++++
 3 files changed, 47 insertions(+), 43 deletions(-)

-- 
2.34.1

