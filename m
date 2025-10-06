Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E203E223DED;
	Mon,  6 Oct 2025 08:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759738964; cv=none; b=Lde+7JQAEOog2VD8qx1yu6SaKZkrE3xQIbxNYS/6Cwnpq+XVv8gI3mL+D3KXZbqfNSFM7N5MgqsqFj1JyEGQHnnQOFG53uDb+6o8Abz7AQmF51D4ttT/xiyPuNZfLeNKpNiGEt4qjIHU5Q59Z/YNGOlM07JDh1PK7DIM88XcvXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759738964; c=relaxed/simple;
	bh=TRozN4AkVHNS643uev2vttUK93EmrcMcBZHnd2VsoUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JqgXHf5pb77YvH1PXUCRSriB1E5T8rJrNM699P3wjP799hK158BrOAGAc5Nc0tfwDZ8q762kYSAc59aqt9XlCo7yghgvDS9yDXIqd91ZeqUoCN8pykWOAnUbggmQHJ19ageFwsJaPlQb809ZNSTP+OessdN8ietf6V/hGYWfYG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gEE2azDC; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gEE2azDC"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=vXAnmWNGdjCkoluz5OPpyVXAyj8svxHC44InLHCVtJw=; b=gEE2azDCjsco3KRFLdk4M4yeQP
	oC47spRIMXgs+p6kyntVmdKMD1Vgdc9P0PhE8Q02/T0BO7/l3tyavb33DN/u8awko61OtC0QjEFLb
	3l9uSFfYnAHLjK8G+n5IzZGJ0JZwZGvAdIraBQa3OSj9Q5JVa44y7h4k8Y0G6ITSJe6/+y4XwklZi
	o31pmSmXykoJnmw+KdAFF/Kxh9AuHnW4pqhiq96TIiTGXfUD09mEAD3xpHgRk+ZuOB0y3WsRoQVDI
	UI1La2Rb9NFBjlraXc7S9yS72H5J1fwhoF/C3UrhFkIOnHXlUipKlqVCTCAMEQTMszExvQLZO5BXb
	qHLPBvNA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v5gUR-0000000GnQC-0o7F;
	Mon, 06 Oct 2025 08:22:39 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 3C7CF300289; Mon, 06 Oct 2025 10:22:38 +0200 (CEST)
Date: Mon, 6 Oct 2025 10:22:38 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-perf-users@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf/events: replace READ_ONCE() with standard page
 table accessors
Message-ID: <20251006082238.GQ3245006@noisy.programming.kicks-ass.net>
References: <20251006042622.1743675-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251006042622.1743675-1-anshuman.khandual@arm.com>

On Mon, Oct 06, 2025 at 05:26:22AM +0100, Anshuman Khandual wrote:
> Replace READ_ONCE() with standard page table accessors i.e pxdp_get() which
> anyways default into READ_ONCE() in cases where platform does not override.

Note that these accessors are more recent than the code in question.

Furthermore, I can only find two pointless overrides and suggest the
below.

This then raises the question of the purpose of these accessors; why
isn't a plain READ_ONCE() preferred if that is really all it is?

[ this skips over the ptep_get() issue, which does seem a little more
involved -- but also has some definite want of cleanups ]

---
diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
index 86378eec7757..c4c23dc4dc77 100644
--- a/arch/arm/include/asm/pgtable.h
+++ b/arch/arm/include/asm/pgtable.h
@@ -150,8 +150,6 @@ extern pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
 
 extern pgd_t swapper_pg_dir[PTRS_PER_PGD];
 
-#define pgdp_get(pgpd)		READ_ONCE(*pgdp)
-
 #define pud_page(pud)		pmd_page(__pmd(pud_val(pud)))
 #define pud_write(pud)		pmd_write(__pmd(pud_val(pud)))
 
diff --git a/arch/loongarch/include/asm/pgtable.h b/arch/loongarch/include/asm/pgtable.h
index bd128696e96d..8184e8c44db6 100644
--- a/arch/loongarch/include/asm/pgtable.h
+++ b/arch/loongarch/include/asm/pgtable.h
@@ -107,7 +107,6 @@ extern unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)];
 #define KFENCE_AREA_END		(KFENCE_AREA_START + KFENCE_AREA_SIZE - 1)
 
 #define ptep_get(ptep) READ_ONCE(*(ptep))
-#define pmdp_get(pmdp) READ_ONCE(*(pmdp))
 
 #define pte_ERROR(e) \
 	pr_err("%s:%d: bad pte %016lx.\n", __FILE__, __LINE__, pte_val(e))
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 25a7257052ff..bc76db9974e4 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -341,33 +341,25 @@ static inline pte_t ptep_get(pte_t *ptep)
 }
 #endif
 
-#ifndef pmdp_get
 static inline pmd_t pmdp_get(pmd_t *pmdp)
 {
 	return READ_ONCE(*pmdp);
 }
-#endif
 
-#ifndef pudp_get
 static inline pud_t pudp_get(pud_t *pudp)
 {
 	return READ_ONCE(*pudp);
 }
-#endif
 
-#ifndef p4dp_get
 static inline p4d_t p4dp_get(p4d_t *p4dp)
 {
 	return READ_ONCE(*p4dp);
 }
-#endif
 
-#ifndef pgdp_get
 static inline pgd_t pgdp_get(pgd_t *pgdp)
 {
 	return READ_ONCE(*pgdp);
 }
-#endif
 
 #ifndef __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG
 static inline int ptep_test_and_clear_young(struct vm_area_struct *vma,
