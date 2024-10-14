Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E322A2A1B2;
	Mon, 14 Oct 2024 03:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728877344; cv=none; b=V/0KC6QnQJywZxQ7BiIEoOFUVQ8cJ+jY2cR7aSVlbt76FfCZQsnI5/B7PgGyCHcKI+gQ4vPVkLQlXTEmXzD0EObD+rURayyjmxubbOalwGifOFh30lnrHPl5u8vKo5DhqkvGtehVaQGNCeI62DeKeCUVtEdmCikqTCEc4LqLbRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728877344; c=relaxed/simple;
	bh=CmBn8k6OhH95qA0L3pVDjkEWVT106s0/JwIzjZpBJBk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KEykBUiEYIwJ//fL4AjLnxV32E2H8vkqSsPsiTzbcxTKL/LiYtgB/tPHwSwzOon3KJa2ZI7ISNY4XIfD/ur/WV/FpaGSCCYsmbBqrsXzyD2pjvnJ4oOK9+btwxfIlk97Hkqlukt1Z3iPV767rpcm3ewPfmJ48rsragUKHcSQYss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4XRjg30s0Zz1T8bP;
	Mon, 14 Oct 2024 11:40:31 +0800 (CST)
Received: from kwepemf500004.china.huawei.com (unknown [7.202.181.242])
	by mail.maildlp.com (Postfix) with ESMTPS id 95A1B140361;
	Mon, 14 Oct 2024 11:42:20 +0800 (CST)
Received: from lihuafei.huawei.com (10.90.53.74) by
 kwepemf500004.china.huawei.com (7.202.181.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 14 Oct 2024 11:42:19 +0800
From: Li Huafei <lihuafei1@huawei.com>
To: <atrajeev@linux.vnet.ibm.com>, <namhyung@kernel.org>
CC: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
	<jolsa@kernel.org>, <irogers@google.com>, <adrian.hunter@intel.com>,
	<kan.liang@linux.intel.com>, <kjain@linux.ibm.com>, <sesse@google.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lihuafei1@huawei.com>
Subject: [PATCH 3/3] perf disasm: Fix not cleaning up disasm_line in symbol__disassemble_raw()
Date: Mon, 14 Oct 2024 19:42:48 +0800
Message-ID: <20241014114248.212711-3-lihuafei1@huawei.com>
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

In symbol__disassemble_raw(), the created disasm_line should be
discarded before returning an error.

Fixes: 0b971e6bf1c3 ("perf annotate: Add support to capture and parse raw instruction in powerpc using dso__data_read_offset utility")
Signed-off-by: Li Huafei <lihuafei1@huawei.com>
---
 tools/perf/util/disasm.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
index 40d99f4d5cc7..4e5becd5eca6 100644
--- a/tools/perf/util/disasm.c
+++ b/tools/perf/util/disasm.c
@@ -1774,25 +1774,23 @@ static int symbol__disassemble_raw(char *filename, struct symbol *sym,
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
 	free(buf);
 	return count < 0 ? count : 0;
 
 err:
+	if (!list_empty(&notes->src->source)) {
+		struct disasm_line *tmp;
+
+		/*
+		 * It probably failed in the middle of the above loop.
+		 * Release any resources it might add.
+		 */
+		list_for_each_entry_safe(dl, tmp, &notes->src->source, al.node) {
+			list_del(&dl->al.node);
+			disasm_line__free(dl);
+		}
+	}
 	count = -1;
 	goto out;
 }
-- 
2.25.1

