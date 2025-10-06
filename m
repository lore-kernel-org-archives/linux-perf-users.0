Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF84D34BA4B;
	Mon,  6 Oct 2025 04:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759724803; cv=none; b=mqV5wGRkoI3K9sG6dzkbCCTdI9sTlyzfxzzjifQePW59VsjAmpkg6WGn3CIaWpp8FPsGiMJqTplf+D0RHu2zR8eumDVjAt6KNNRlVquJw9pdDJOxcuWApzKf0KFsBnaZKo70ya4BrYP7AkRu9bjToQDcGh/k2FbUkchBt9X+jXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759724803; c=relaxed/simple;
	bh=2nzYjvGIFu8psbcqnk+YGYnoYohJvp6urVvOGRvpTAU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Fru4qJqdyeslqegNYZbTIQ+9EX5ppAF9sT305XbvjnYyFXYePpK/D2sQRRmOPxIihOwuBuB642XacYcto+UMR0BXRFjZPMcdTSJnghcuHMc9SgsoGhqFxgbqScKfjsMQ+GlR6XDHlch2C5PQc04winCLMl+1AeECDr76Qcs5HQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 37B8C1516;
	Sun,  5 Oct 2025 21:26:26 -0700 (PDT)
Received: from ergosum.cambridge.arm.com (ergosum.cambridge.arm.com [10.1.196.45])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D44AA3F59E;
	Sun,  5 Oct 2025 21:26:32 -0700 (PDT)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-perf-users@vger.kernel.org
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] perf/events: replace READ_ONCE() with standard page table accessors
Date: Mon,  6 Oct 2025 05:26:22 +0100
Message-Id: <20251006042622.1743675-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace READ_ONCE() with standard page table accessors i.e pxdp_get() which
anyways default into READ_ONCE() in cases where platform does not override.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 kernel/events/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 820127536e62..952ba4e3d881 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -8110,7 +8110,7 @@ static u64 perf_get_pgtable_size(struct mm_struct *mm, unsigned long addr)
 	pte_t *ptep, pte;
 
 	pgdp = pgd_offset(mm, addr);
-	pgd = READ_ONCE(*pgdp);
+	pgd = pgdp_get(pgdp);
 	if (pgd_none(pgd))
 		return 0;
 
@@ -8118,7 +8118,7 @@ static u64 perf_get_pgtable_size(struct mm_struct *mm, unsigned long addr)
 		return pgd_leaf_size(pgd);
 
 	p4dp = p4d_offset_lockless(pgdp, pgd, addr);
-	p4d = READ_ONCE(*p4dp);
+	p4d = p4dp_get(p4dp);
 	if (!p4d_present(p4d))
 		return 0;
 
@@ -8126,7 +8126,7 @@ static u64 perf_get_pgtable_size(struct mm_struct *mm, unsigned long addr)
 		return p4d_leaf_size(p4d);
 
 	pudp = pud_offset_lockless(p4dp, p4d, addr);
-	pud = READ_ONCE(*pudp);
+	pud = pudp_get(pudp);
 	if (!pud_present(pud))
 		return 0;
 
-- 
2.30.2

