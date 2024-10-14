Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CC6231CA6;
	Mon, 14 Oct 2024 03:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728877343; cv=none; b=B5Zqhf8GUR1cYuGd7x8Bp/DIsPTNEVynPACzSYWMxQ9l4fLe2yWz61Pa2KkR4igldEypZeEYfioQaqsr8HF4ycee0E7LL3xjzZFh4AtGUXmIWfAo3fC0QK2ssSHL80BBraA+foka65KPCU5UAlGlraQ5rsCB8jL3V7Q7L9bWVgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728877343; c=relaxed/simple;
	bh=ZJ5ogckYMccQ182afl7uMmAuafSGOq5THxK+uUkXlJo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Cl8tgiHw2I/SW4dbQMV2zwWTNwieZHdtgATflrIqrOmYJ/yMvJnOjSYfs/EPGwdG+iayIV0eEH/PsK3SC5fK5xwn0ulhoekLjUaIl5d1FRGhzOkUwGyvHlTG3JY1Kw0k+Ep46eNcsj6V8WDHJtz1dGRD3GyGCtrg7L/n5fxb/CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4XRjgd6sZWz1S9xH;
	Mon, 14 Oct 2024 11:41:01 +0800 (CST)
Received: from kwepemf500004.china.huawei.com (unknown [7.202.181.242])
	by mail.maildlp.com (Postfix) with ESMTPS id CAC6F1A016C;
	Mon, 14 Oct 2024 11:42:13 +0800 (CST)
Received: from lihuafei.huawei.com (10.90.53.74) by
 kwepemf500004.china.huawei.com (7.202.181.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 14 Oct 2024 11:42:13 +0800
From: Li Huafei <lihuafei1@huawei.com>
To: <atrajeev@linux.vnet.ibm.com>, <namhyung@kernel.org>
CC: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
	<jolsa@kernel.org>, <irogers@google.com>, <adrian.hunter@intel.com>,
	<kan.liang@linux.intel.com>, <kjain@linux.ibm.com>, <sesse@google.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lihuafei1@huawei.com>
Subject: [PATCH 1/3] perf disasm: Use disasm_line__free() to properly free disasm_line
Date: Mon, 14 Oct 2024 19:42:46 +0800
Message-ID: <20241014114248.212711-1-lihuafei1@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemf500004.china.huawei.com (7.202.181.242)

The structure disasm_line contains members that require dynamically
allocated memory and need to be freed correctly using
disasm_line__free().

This patch fixes the incorrect release in
symbol__disassemble_capstone().

Fixes: 6d17edc113de ("perf annotate: Use libcapstone to disassemble")
Signed-off-by: Li Huafei <lihuafei1@huawei.com>
---
 tools/perf/util/disasm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
index f05ba7739c1e..42222d61ceb5 100644
--- a/tools/perf/util/disasm.c
+++ b/tools/perf/util/disasm.c
@@ -1717,7 +1717,7 @@ static int symbol__disassemble_capstone(char *filename, struct symbol *sym,
 		 */
 		list_for_each_entry_safe(dl, tmp, &notes->src->source, al.node) {
 			list_del(&dl->al.node);
-			free(dl);
+			disasm_line__free(dl);
 		}
 	}
 	count = -1;
-- 
2.25.1

