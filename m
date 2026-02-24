Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 753AE203710;
	Tue, 24 Feb 2026 05:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771909967; cv=none; b=a1t2T6czuxg5p+YsVB8GZAqyewysfqTJc/n793OViH8hYHCp05SdW2dj0v9orA7Dl1+fBv5UgmQEOx9gAGKJgexjysn2Uq7TchP2fuDqmUJPHvLVWWKlH5vQIoSVU2YEt9QO//8KUdsV8DWwPtiHTml6FSVcjd5FqTschap0SNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771909967; c=relaxed/simple;
	bh=Er8zMgmKU3694HnC0jKaQjKFf8SIa37aK6uoxd9JPGo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dp1L+5YSl3LkM9SVe5zEeXDgJH8WrqnI+i4WhXNncN6v6hAoc1bd7IR7ICZXqwxuv12nqZOoKLaasvfYdNtKAjbeDkXP7awxYuNPVdROgw5MDwUpnctBMs0cJwG+5Jo2Z52GuPRg8G0QebzJGXrBmYilSOef3DmkP/pSSGi7ET0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AA859339;
	Mon, 23 Feb 2026 21:12:39 -0800 (PST)
Received: from a085714.blr.arm.com (a085714.arm.com [10.164.18.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 63A333F7BD;
	Mon, 23 Feb 2026 21:12:40 -0800 (PST)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Linu Cherian <linu.cherian@arm.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [RFC V1 04/16] perf/events: Replace READ_ONCE() with standard pgtable accessors
Date: Tue, 24 Feb 2026 10:41:41 +0530
Message-ID: <20260224051153.3150613-5-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260224051153.3150613-1-anshuman.khandual@arm.com>
References: <20260224051153.3150613-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace READ_ONCE() with standard page table accessors i.e pxdp_get() which
anyways default into READ_ONCE() in cases where platform do not override.

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
index ac70d68217b6..4ee151cd2c6d 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -8422,7 +8422,7 @@ static u64 perf_get_pgtable_size(struct mm_struct *mm, unsigned long addr)
 	pte_t *ptep, pte;
 
 	pgdp = pgd_offset(mm, addr);
-	pgd = READ_ONCE(*pgdp);
+	pgd = pgdp_get(pgdp);
 	if (pgd_none(pgd))
 		return 0;
 
@@ -8430,7 +8430,7 @@ static u64 perf_get_pgtable_size(struct mm_struct *mm, unsigned long addr)
 		return pgd_leaf_size(pgd);
 
 	p4dp = p4d_offset_lockless(pgdp, pgd, addr);
-	p4d = READ_ONCE(*p4dp);
+	p4d = p4dp_get(p4dp);
 	if (!p4d_present(p4d))
 		return 0;
 
@@ -8438,7 +8438,7 @@ static u64 perf_get_pgtable_size(struct mm_struct *mm, unsigned long addr)
 		return p4d_leaf_size(p4d);
 
 	pudp = pud_offset_lockless(p4dp, p4d, addr);
-	pud = READ_ONCE(*pudp);
+	pud = pudp_get(pudp);
 	if (!pud_present(pud))
 		return 0;
 
-- 
2.43.0

