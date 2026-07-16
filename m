Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53ED540D564
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Jul 2026 12:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784205882; cv=none; b=HfpvjBJEsb1Dcsl0z9G+fSHtGtqMZdOWek/Z/Cjp2geiFt7HNgtYa4KYtOzNB0xKy0B4LwkkuWruTAuiMvTujPhOh9mK9WRtIjIJZgMmJjeL7uR1dCKjHMdYiMfg/5VdiuVko+ycJvhyaQ0WXPqS+T2kuRHiOXbT5ud9WwKpO7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784205882; c=relaxed/simple;
	bh=C9vr1GpyOKZPJayEcfEUxAQT/YmOuTmwy42kU/s05EI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=otPPkLh1kp8RXN7wjfuKJyOuRNIdQuBLq7qFJoYwX+XyN1hZocdjtvBlhl1hyI0HqD7Cw34JCofipIrlY3aD3AJYems3Md7U4RBbj6ZjnucXJz8mpJHBV2xnPuveSUTFWi80SJM877F2spU+FDvDeinQApGtpuyLS8qhkCEn9RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=gyogljhk; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="gyogljhk"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-ca7c1176317so4836196a12.1
        for <linux-perf-users@vger.kernel.org>; Thu, 16 Jul 2026 05:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1784205881; x=1784810681; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xl9SXJgNY1wsw8DmDdohBTpB25DAPwcBNYqh5j7w6mI=;
        b=gyogljhkXmG1zV+1zNRnCZRoh21QCNeeGkdNQELVkKXZH4wUKLl1pSeGbO5DaqQ1xX
         EcgA2ESGbQqnTh6ou9FS172rAiOIeTOxWAgaUqRVLLmtlW0+foeAfUOQxcnYOJKHPE9l
         IeGjgzvqMPw6fgvV47OczXuexfBLjQZSOclJiYivqiPs1vMBcbwvrp8RR/2wtgXD46rD
         d8HZtq7Sv8P7vIn5DZmaTrVuICREhUejrDDon2KLJnUeGZwrNwLfw8x52DRXyICLNmSG
         7ySDml4AWSjLzOc5TTNg4h27Ia9n9pr5EfMXRmxUSxPdwi3JNFuLFjIARTLEzy9ZqQkI
         f6Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784205881; x=1784810681;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xl9SXJgNY1wsw8DmDdohBTpB25DAPwcBNYqh5j7w6mI=;
        b=d/Vt3Qya9yvDt0msswsfvmaWhnnUQC/csk/TP466edLfUklpQZe10KEU2BZXBF7kaq
         J2VsHNxetR6L9EBkwSi/5LI/1N2pEYjjYUA2wDSnWcvmrkzVNbW9fVzQOlSa1dKnMPDV
         FLfMHaDrJZh5H2yND4K+ek+KOEDWhqBoDsjvHgy+gOndscIjaof6LaLfg06LMP+Kpbxf
         LD+IUGrimK7CDHhDmoIAMuwk1pzOxdX1QFWx24zCXX1QUUrpkKCUHs6qS818o9mchtB9
         ocAcAOCwj0RjedNj0UhZ1uPoirMmyv6x0F9F6kcLoIRXjcBGaqowFQBLD6fJMwwFyZ8W
         ODIw==
X-Forwarded-Encrypted: i=1; AHgh+RplyaApsV1SPV3VxUbAmNc/bOH9a8YXh6roMCRl6NJFnS0WLOOUu7tUV+JFPixaa3h4nC50pBLXDk+O35VUQOfc@vger.kernel.org
X-Gm-Message-State: AOJu0YxLKu/+u/9xfWSctul5C0pflA9um7hLGYOG2QX9zCOOR589DpSo
	0yFj+bxucONaHT8Qi1WQdemCml7TYTC/ZrUJ+/0YW/A4HQVcIs7DwTO32YUtwDFJ6hv0FM2ATbG
	/zGoAbpc=
X-Gm-Gg: AfdE7cnzOP3oNQaZdJIxgxzi3nyVjOzx4skhLRYmz14mmPkwj+utoG5CFAgaHIBJA70
	oM0Xq/dindXg+rpqnzWasbDF2/YKc9y5c5td6urZdQ+T4391IZbzW6GcRIq37378hebM3lM1pC0
	TvAPDYX4FXC/4BaCnDRXWujTsfQ7qrWUKi4dDodPOF1jEY2lFtlXDYKOmDVmVbxvI7dRBr8Aeez
	XKHfNcP2vEowPe0MvLPAk3bQQzmy4A2XXmeiz2Dfk32EQIzeiuSsJ3jM+RAgdLR/Jkub6xRhR8B
	fytJuTEqjPq8mP4Zx8K+oyCE2jqWozqMqZZ6t8HkXx8whVGj6Xjkj2eQg4iRAOmSfU8oxfiPis4
	8HLH7GC+BkgpyKJSvOxNffcRpXoBbWn938+8+Efvwb/d+ey+HUOexz9Y08IkQ/Qh8MTZkRKLHEe
	Ws4jMqToP7qjVXZd6vR1WMXnQ=
X-Received: by 2002:a05:6a21:114c:b0:3b4:b275:c5b1 with SMTP id adf61e73a8af0-3c36c1cf118mr8945730637.26.1784205880687;
        Thu, 16 Jul 2026 05:44:40 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([2408:8606:1800:501::2:f])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cb258eeaba2sm1730793a12.12.2026.07.16.05.44.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 16 Jul 2026 05:44:39 -0700 (PDT)
From: Yunhui Cui <cuiyunhui@bytedance.com>
To: linux-riscv@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-efi@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	kasan-dev@googlegroups.com,
	Yunhui Cui <cuiyunhui@bytedance.com>
Subject: [PATCH v2 13/15] riscv/mm: remove redundant TLB flush in napotpte_convert
Date: Thu, 16 Jul 2026 20:41:48 +0800
Message-Id: <e55fb906990083b05272648f5299514a68cf8456.1784201104.git.cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <cover.1784201104.git.cuiyunhui@bytedance.com>
References: <cover.1784201104.git.cuiyunhui@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

napotpte_convert() switches a NAPOT block between the Svnapot encoding
and the equivalent set of base PTEs. The conversion itself preserves the
effective translations: PFNs and permissions are kept the same while the
page-table representation changes.

Do not issue an SFENCE.VMA in the middle of this representation change.
For partial updates, such as unfolding a writable NAPOT block before
write-protecting one subrange, a flush at conversion time would not be the
operation that enforces the final permission downgrade. Writable base-PTE
translations could still be refilled after the conversion and before the
subrange is write-protected. The required TLB maintenance belongs to the
operation that actually changes the effective mapping.

The RISC-V privileged architecture discussion clarifies that Svnapot is
an encoding of a naturally aligned range. When napotpte_convert() only
switches between the NAPOT encoding and the corresponding set of base PTEs
for the same effective translations, the conversion itself does not
require an extra TLB invalidation beyond the usual page-table update
rules.

Link: https://lists.riscv.org/g/tech-privileged/message/2950
Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
---
 arch/riscv/mm/contpte.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/mm/contpte.c b/arch/riscv/mm/contpte.c
index b0b8ff0aade3a..8289f39d6e188 100644
--- a/arch/riscv/mm/contpte.c
+++ b/arch/riscv/mm/contpte.c
@@ -129,7 +129,7 @@ static pte_t __get_and_clear_full_ptes(struct mm_struct *mm,
 static void napotpte_convert(struct mm_struct *mm, unsigned long addr,
 			     pte_t *ptep, pte_t target)
 {
-	unsigned long start_addr, end, ptent_addr;
+	unsigned long start_addr, ptent_addr;
 	pte_t *start_ptep;
 	pte_t ptent, pte;
 	unsigned int i, nr;
@@ -137,7 +137,6 @@ static void napotpte_convert(struct mm_struct *mm, unsigned long addr,
 	start_addr = napot_align_addr(addr);
 	start_ptep = napot_align_ptep(ptep);
 	nr = napotpte_pte_num();
-	end = start_addr + napotpte_size();
 
 	for (i = 0; i < nr; i++) {
 		ptent_addr = start_addr + i * PAGE_SIZE;
@@ -150,8 +149,15 @@ static void napotpte_convert(struct mm_struct *mm, unsigned long addr,
 			target = pte_mkyoung(target);
 	}
 
-	flush_tlb_mm_range(mm, start_addr, end, PAGE_SIZE);
-
+	/*
+	 * This conversion only changes the representation of the same
+	 * effective translations: NAPOT encoding <-> equivalent base PTEs.
+	 * A flush here would not replace the TLB maintenance required by a
+	 * later permission downgrade, because writable base-PTE translations
+	 * could be refilled after this conversion and before that downgrade.
+	 * Leave TLB invalidation to the operation that changes the effective
+	 * mapping.
+	 */
 	page_table_check_ptes_set(mm, start_addr, start_ptep, target, nr);
 	if (pte_napot(target)) {
 		for (i = 0; i < nr; i++)
-- 
2.39.5

