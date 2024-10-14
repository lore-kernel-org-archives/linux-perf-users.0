Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B82461FD7;
	Mon, 14 Oct 2024 03:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728877345; cv=none; b=B2afNw2J46zM915mIv5SwJ4z1RKPuisg3p47y3zsROb0c1KkVdqfWpFeFwcH92uGFolDLJ/FY/pgpjqgr++GVHForOH0UQakJo/8EDq9KxSMDOClkOcFoiMoChA5IXdP5zSdnfX7e5cGqpDWaahXV+suQk2pC+dXL3V6Memdf/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728877345; c=relaxed/simple;
	bh=N641RsZNhrgqANLu9gCSZFQzX4mLyMm/4xaWcCToa5g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZY4Z0fL7FjvbgZQ6NORduI4MduwKFcqy5tZ+wkVYIz0x71ic9eAdnTyNRs476Azj/+ggb63gcLNLTcnqupZ6vECdC8puuKxK7qDy3fG/UHaUncrdeCsQZGKDBCyxvH0jyxbJXvZ2G2wHuSsrOLSvzYpAaBzZtrTWdn0aJRRSlsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4XRjg21MW9z10N2w;
	Mon, 14 Oct 2024 11:40:30 +0800 (CST)
Received: from kwepemf500004.china.huawei.com (unknown [7.202.181.242])
	by mail.maildlp.com (Postfix) with ESMTPS id EC627140361;
	Mon, 14 Oct 2024 11:42:19 +0800 (CST)
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
Subject: [PATCH 2/3] perf disasm: Use disasm_line__free() to properly free disasm_line
Date: Mon, 14 Oct 2024 19:42:47 +0800
Message-ID: <20241014114248.212711-2-lihuafei1@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241014114248.212711-1-lihuafei1@huawei.com>
References: <20241014114248.212711-1-lihuafei1@huawei.com>
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

This patch fixes the incorrect freeing in
symbol__disassemble_capstone_powerpc().  Also, since cs_disasm is not
enabled, it does not need to handle the situation described in
symbol__disassemble_capstone() where "offset != len" may occur due to
unknown instructions.

Fixes: c5d60de1813a ("perf annotate: Add support to use libcapstone in powerpc")
Signed-off-by: Li Huafei <lihuafei1@huawei.com>
---
 tools/perf/util/disasm.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
index 42222d61ceb5..40d99f4d5cc7 100644
--- a/tools/perf/util/disasm.c
+++ b/tools/perf/util/disasm.c
@@ -1580,20 +1580,6 @@ static int symbol__disassemble_capstone_powerpc(char *filename, struct symbol *s
 		offset += 4;
 	}
 
-	/* It failed in the middle */
-	if (offset != len) {
-		struct list_head *list = &notes->src->source;
-
-		/* Discard all lines and fallback to objdump */
-		while (!list_empty(list)) {
-			dl = list_first_entry(list, struct disasm_line, al.node);
-
-			list_del_init(&dl->al.node);
-			disasm_line__free(dl);
-		}
-		count = -1;
-	}
-
 out:
 	if (needs_cs_close)
 		cs_close(&handle);
@@ -1612,7 +1598,7 @@ static int symbol__disassemble_capstone_powerpc(char *filename, struct symbol *s
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

