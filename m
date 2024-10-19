Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6548E1EA73;
	Sat, 19 Oct 2024 07:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729324716; cv=none; b=tjcMeQ649bJ4HPE01sY1ktoZPYFl3bisW+et1vfwKOcJ8xK2X89eFtN8UOKVRHII2SvEpcm/9rmuGg6he0N4AYYH5Q+lFDc6lXH7fFMKl+IdaEJ0mQUduhNVyol9qhcOlACKn4STQmFmrXfIyDIbXAlOXD+2k8q5C28MadGpzkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729324716; c=relaxed/simple;
	bh=ZJ5ogckYMccQ182afl7uMmAuafSGOq5THxK+uUkXlJo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MwlsNRUNSx3oNxi9LZI3voFrBEGOhANPvYUYbPglL7YIerspz6mB3c/oFCY70nYHdE65maVugxBfoenVopQckMIxy2TFH9ogXPVYZecHrYD/A9C/Jz3r6NgcHIdPn+7WGsYRo/n1V3BIu5y7ABEEvPfLPvH08wnpA82um/4CPrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4XVtk65n2kzpWfr;
	Sat, 19 Oct 2024 15:39:10 +0800 (CST)
Received: from kwepemf500004.china.huawei.com (unknown [7.202.181.242])
	by mail.maildlp.com (Postfix) with ESMTPS id 97AD8140134;
	Sat, 19 Oct 2024 15:41:08 +0800 (CST)
Received: from lihuafei.huawei.com (10.90.53.74) by
 kwepemf500004.china.huawei.com (7.202.181.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 19 Oct 2024 15:41:07 +0800
From: Li Huafei <lihuafei1@huawei.com>
To: <namhyung@kernel.org>, <atrajeev@linux.vnet.ibm.com>
CC: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
	<jolsa@kernel.org>, <irogers@google.com>, <adrian.hunter@intel.com>,
	<kan.liang@linux.intel.com>, <kjain@linux.ibm.com>, <sesse@google.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lihuafei1@huawei.com>
Subject: [PATCH v2 1/3] perf disasm: Use disasm_line__free() to properly free disasm_line
Date: Sat, 19 Oct 2024 23:41:55 +0800
Message-ID: <20241019154157.282038-1-lihuafei1@huawei.com>
X-Mailer: git-send-email 2.25.1
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

