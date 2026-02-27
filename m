Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A40B21D5151;
	Fri, 27 Feb 2026 06:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772173675; cv=none; b=MjLo7DcXjEvr8kTJdkOZmitaofRbBoVGgeLeUs5vmJC6nRuJHojfaNfbPnnmZ0GNi9ol4cC2crpjVWN0/0Z0+/7ylaySShU2r2t824pEjy0XvfzKoy8VCB+YOc6Nr/TTk7u5dnHyDyRcEK1mIZgZWWBhqKiYMFWscZiNglPsDZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772173675; c=relaxed/simple;
	bh=IACqxOFO3lhuib14dLvwo7JFKKgTQadtKl4NuJjBe4I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OI+9g54jpkYPL9emmTP7EtaNxkvqyWicB8vWRTpkT1wCm5+1J+S003vmaupf0mjvFihfgedg380QnsWujXysuvuWF5Ohxpj5XOwxBSlyaJ/pZBD4yz2f0DNlbkAs+6a2BiWBgVRQp1k6bEgnJHJRKYXX2Bx3aAPB30gfrBOsmM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A57B214BF;
	Thu, 26 Feb 2026 22:27:46 -0800 (PST)
Received: from ergosum.cambridge.arm.com (ergosum.cambridge.arm.com [10.1.196.45])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 39CA23F7BD;
	Thu, 26 Feb 2026 22:27:51 -0800 (PST)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-mm@kvack.org
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] perf/events: Replace READ_ONCE() with standard pgtable accessors
Date: Fri, 27 Feb 2026 06:27:44 +0000
Message-Id: <20260227062744.2215491-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace raw READ_ONCE() dereferences of pgtable entries with corresponding
standard page table accessors pxdp_get() in perf_get_pgtable_size(). These
accessors default to READ_ONCE() on platforms that don't override them. So
there is no functional change on such platforms.

However arm64 platform is being extended to support 128 bit page tables via
a new architecture feature i.e FEAT_D128 in which case READ_ONCE() will not
provide required single copy atomic access for 128 bit page table entries.
Although pxdp_get() accessors can later be overridden on arm64 platform to
extend required single copy atomicity support on 128 bit entries.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
This patch applies both on v7.0-rc1 and mm-unstable.

Part of the D128 series but independent. Hence could be considered on its own.

https://lore.kernel.org/all/20260224051153.3150613-5-anshuman.khandual@arm.com/

Collected Peter's tag from an off list conversation.

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
2.30.2

