Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4961DE3DA;
	Sat, 19 Oct 2024 07:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729324720; cv=none; b=VAgyokjE57vGnrKMWXVALhKhqm2qQiUM2f+WmwBPyWnkPAOW3bhGxKVN28aE6+M3JeCStU2e3qxTAmzzgvw8bLDWjU50Hlsh7OLhk9hyZyHNHCaR9QPdPfxAK+tsvlRntWfo+r7ZX8BmPpejaQGVjO9Qia7tNgH84Hz9cOpZazw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729324720; c=relaxed/simple;
	bh=P/s3hcwhHI2Z6CEJK9ZA38QhjkWKNG5xCrtk7qDc0As=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FGWqqju44pzOYvKJoRY7sR4Txt/igHJi/SR4gmU7Yl3e6oxlAgDsLng8DcYQcve5efn5e2eR9MmlElaSNMvL9i4e7lJrLodAhmj+hDRcCrwp0IxDRVBtv0lDe5fvzxfZCozvHvMBu2XnO7g0yqaYmgLDGt0VMqR/B4OxqClgfS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4XVtjX5xZJzfcsC;
	Sat, 19 Oct 2024 15:38:40 +0800 (CST)
Received: from kwepemf500004.china.huawei.com (unknown [7.202.181.242])
	by mail.maildlp.com (Postfix) with ESMTPS id 39EDA1800A5;
	Sat, 19 Oct 2024 15:41:09 +0800 (CST)
Received: from lihuafei.huawei.com (10.90.53.74) by
 kwepemf500004.china.huawei.com (7.202.181.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 19 Oct 2024 15:41:08 +0800
From: Li Huafei <lihuafei1@huawei.com>
To: <namhyung@kernel.org>, <atrajeev@linux.vnet.ibm.com>
CC: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
	<jolsa@kernel.org>, <irogers@google.com>, <adrian.hunter@intel.com>,
	<kan.liang@linux.intel.com>, <kjain@linux.ibm.com>, <sesse@google.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lihuafei1@huawei.com>
Subject: [PATCH v2 2/3] perf disasm: Use disasm_line__free() to properly free disasm_line
Date: Sat, 19 Oct 2024 23:41:56 +0800
Message-ID: <20241019154157.282038-2-lihuafei1@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241019154157.282038-1-lihuafei1@huawei.com>
References: <20241019154157.282038-1-lihuafei1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemf500004.china.huawei.com (7.202.181.242)

symbol__disassemble_capstone_powerpc() goto the 'err' label when it
failed in the loop that created disasm_line, and then used free()
directly to free disasm_line. Since the structure disasm_line contains
members that allocate memory dynamically, this can result in a memory
leak. In fact, we can simply break the loop when it fails in the middle
of the loop, and disasm_line__free() will then be called to properly
free the created line. Other error paths do not need to consider freeing
disasm_line.

Fixes: c5d60de1813a ("perf annotate: Add support to use libcapstone in powerpc")
Signed-off-by: Li Huafei <lihuafei1@huawei.com>
---
Changes in v2:
 - Break directly in the loop when it fails, then free disasm_line.
 - Remove the free under the 'err' label.
---
 tools/perf/util/disasm.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
index 42222d61ceb5..8a24e31a1534 100644
--- a/tools/perf/util/disasm.c
+++ b/tools/perf/util/disasm.c
@@ -1573,7 +1573,7 @@ static int symbol__disassemble_capstone_powerpc(char *filename, struct symbol *s
 
 		dl = disasm_line__new(args);
 		if (dl == NULL)
-			goto err;
+			break;
 
 		annotation_line__add(&dl->al, &notes->src->source);
 
@@ -1603,18 +1603,6 @@ static int symbol__disassemble_capstone_powerpc(char *filename, struct symbol *s
 err:
 	if (fd >= 0)
 		close(fd);
-	if (needs_cs_close) {
-		struct disasm_line *tmp;
-
-		/*
-		 * It probably failed in the middle of the above loop.
-		 * Release any resources it might add.
-		 */
-		list_for_each_entry_safe(dl, tmp, &notes->src->source, al.node) {
-			list_del(&dl->al.node);
-			free(dl);
-		}
-	}
 	count = -1;
 	goto out;
 }
-- 
2.25.1

