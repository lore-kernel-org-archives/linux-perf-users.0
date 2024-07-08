Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC527494;
	Mon,  8 Jul 2024 03:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720409106; cv=none; b=ODJWoK9qi7KoaBcsRENKWuydC50HuD1NMk6jtOJBIJbXd46oBJSzmQVXVkj414dQ+0WJPSq7rxNXgtynPFu2UmVMXxaXxssc0zv3wwT6IJXB93Azle7E6mUZVxBeY5E1mMSS1dTTGPL2BgFliBKodc/H0Vl3twpnaYY9EWIFumg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720409106; c=relaxed/simple;
	bh=cUnV2O6AKyz5UnbKsyl6R+zngzKKJAHcApc1Y+rigdo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vFbDMg17sPZpF507jOdBPMKGxLW+WCRmiSFxUvDbWTngMuvpiQ4tbEe32tlW3nAP0uCW2SURuh2cCTGS8SrHUbe0xyxxsjvZ7Xbr4eXetyjsQ0MEGHDFJiaWIBxkQZ64cmxofekK/Eo3Bby4bfo5qG8w8Ylgee7/NzOLNbbEJ4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WHTs85hb7zxVB2;
	Mon,  8 Jul 2024 11:20:28 +0800 (CST)
Received: from kwepemi100008.china.huawei.com (unknown [7.221.188.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 6ECFF1800C7;
	Mon,  8 Jul 2024 11:24:46 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi100008.china.huawei.com
 (7.221.188.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 8 Jul
 2024 11:24:45 +0800
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
Subject: [PATCH v3 1/2] riscv: Fix fp alignment bug in perf_callchain_user()
Date: Mon, 8 Jul 2024 11:28:46 +0800
Message-ID: <20240708032847.2998158-2-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240708032847.2998158-1-ruanjinjie@huawei.com>
References: <20240708032847.2998158-1-ruanjinjie@huawei.com>
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

The standard RISC-V calling convention said:
	"The stack grows downward and the stack pointer is always
	kept 16-byte aligned".

So perf_callchain_user() should check whether 16-byte aligned for fp.

Link: https://riscv.org/wp-content/uploads/2015/01/riscv-calling.pdf

Fixes: dbeb90b0c1eb ("riscv: Add perf callchain support")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: Björn Töpel <bjorn@kernel.org>
---
 arch/riscv/kernel/perf_callchain.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/perf_callchain.c b/arch/riscv/kernel/perf_callchain.c
index 3348a61de7d9..2932791e9388 100644
--- a/arch/riscv/kernel/perf_callchain.c
+++ b/arch/riscv/kernel/perf_callchain.c
@@ -62,7 +62,7 @@ void perf_callchain_user(struct perf_callchain_entry_ctx *entry,
 	perf_callchain_store(entry, regs->epc);
 
 	fp = user_backtrace(entry, fp, regs->ra);
-	while (fp && !(fp & 0x3) && entry->nr < entry->max_stack)
+	while (fp && !(fp & 0x7) && entry->nr < entry->max_stack)
 		fp = user_backtrace(entry, fp, 0);
 }
 
-- 
2.34.1

