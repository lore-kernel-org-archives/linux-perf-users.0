Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9802E19CCFA;
	Tue, 18 Jun 2024 03:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718681042; cv=none; b=kQMliGCJuCW11aCEOc8qWyjMPRRw32JzmxShFdhW9YaA6WlrkmTYG22us8M2zSq4biOEeo1bDoIYn8AF/5W4LQkLTytnxVHHDEzP7qaetks1/+Erf+9IdJUtW+dJAcAwYQsWdokD3U/XmaT9r6G1LvKJ/CgMfy66XitASnsYkF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718681042; c=relaxed/simple;
	bh=IR5Dnh2yxlJC52kii/laGbwEZ959XlTDR+eUpfYN320=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cYySb4/j1s9Elao9GnP2br3cq7w5LCWdxauJpU7WYnwo+AeqdErHOUSolNLpvmVSkgatKPwIOnhm5SRM9hsgaaemQ9xq6VKoLrVVKA4qUlJEf733kfkkhYxxOnatXWAhNQkgtVZ4o45HzH6vmyxgFTPrXoookK0Tq6BZperzXCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4W3BnS01Wvz1S8XV;
	Tue, 18 Jun 2024 11:19:40 +0800 (CST)
Received: from kwepemi100008.china.huawei.com (unknown [7.221.188.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 282B6140361;
	Tue, 18 Jun 2024 11:23:53 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi100008.china.huawei.com
 (7.221.188.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 18 Jun
 2024 11:23:52 +0800
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
Subject: [PATCH 1/2] ARM: 9258/1: Fix callchain_trace() return value
Date: Tue, 18 Jun 2024 11:26:19 +0800
Message-ID: <20240618032620.2445395-2-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240618032620.2445395-1-ruanjinjie@huawei.com>
References: <20240618032620.2445395-1-ruanjinjie@huawei.com>
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

perf_callchain_store() return 0 on success, -1 otherwise, fix
callchain_trace() to return correct bool value. So walk_stackframe() can
have a chance to stop walking the stack ahead.

Fixes: 70ccc7c0667b ("ARM: 9258/1: stacktrace: Make stack walk callback consistent with generic code")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/arm/kernel/perf_callchain.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/kernel/perf_callchain.c b/arch/arm/kernel/perf_callchain.c
index 7147edbe56c6..1d230ac9d0eb 100644
--- a/arch/arm/kernel/perf_callchain.c
+++ b/arch/arm/kernel/perf_callchain.c
@@ -85,8 +85,7 @@ static bool
 callchain_trace(void *data, unsigned long pc)
 {
 	struct perf_callchain_entry_ctx *entry = data;
-	perf_callchain_store(entry, pc);
-	return true;
+	return perf_callchain_store(entry, pc) == 0;
 }
 
 void
-- 
2.34.1

