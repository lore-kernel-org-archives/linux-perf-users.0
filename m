Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D055E31E849
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Jul 2026 12:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784205865; cv=none; b=uNL0WWiJ2VzzMd74uZ7t1UWXIHBQjrgoS/onYnYUwyihLPhHUm6CXpe1bFhMZhxXRkbYqNUB7hCB2EkUpx0rAaCdZWqrM6UCgEoyOz6rObJ36CNdigFdms/HYUdPf7mNXkxjqSIF0akFoXsS2CbW8vBQ0sDG1qav6ebsWmiFrOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784205865; c=relaxed/simple;
	bh=rftdHtLNV98O/408NnTvtHdmuZ/zkcn7vT2O02oj0qc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NVst4jS7lcszRCbOg9SNESJf79Cn1C9S+saAZjgpFgXL0M8dt/3pkrVpzvL4aZTJLxXbUp/tGejjtxjhoR3eYAHcvmoYVCu4zmSwHpjG0eY5F3ceNhoRX8tha1K4xM7xDO5GNeknEeblXpw09KCs4LQwyAm+t3bYwnjMuYuk7bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=St7eDzRl; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="St7eDzRl"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8487b7b3fc7so2994775b3a.0
        for <linux-perf-users@vger.kernel.org>; Thu, 16 Jul 2026 05:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1784205863; x=1784810663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MW3VkNC58mnWKcn8BtrFop2mUDTlw3bfVwg/aYM+yrM=;
        b=St7eDzRlxPTWCxHLHWoBJomIpw2Aw3SH5gTQBQlCcxnQd4tuAszGXCMIZDPuSq4VbB
         LkL5Y7Wzu2Tmvl54F6R9RdKK3SHWkuxSxiuEaZoTouaqTni1jlHo9cDKTwRnvaDkVgSA
         qnwyncSsWLdJsm1InJCJ9cBGs5XNR9HjzIqUNReUUweHUYEb995UrPL8kZCJxom3ocSW
         u9LOmPUwngXgZADEAMCOD7PT+wtybezb37fKnHAR5zDLVV3eBpRsFDmS5jM5BLeIAY2v
         kFLeZx7WZEubSA8oog8n1GUMtv0gjDuQNqKrVXuAQmI+krN7QhPNrQk/PJz0P299kqpI
         laJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784205863; x=1784810663;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MW3VkNC58mnWKcn8BtrFop2mUDTlw3bfVwg/aYM+yrM=;
        b=fqVP0Llgcrf47VdxAxaLqJcthtFsDLhW8+ZUQzEu4JduU3gDUrt99xOBGpd9eaJvNs
         yzWZDA7YlAcP84COA+7YtGWFcuFIMh/2Fayl2UxXguaf8M+D6GmC7Cok0RUwCC7/DEcG
         6nPsrFSGl5AWMhFNyVhgUiWNarIzVjhFnpDbz8P7zG6746VSeomOQ1Mh3sXFZftOFU/2
         SjGsR93ZGxjxul4P9F8O1lw/vZQY42t+n3686HggCdYoWH2PUbm+uvSd69EVeavZmATK
         ElxvakoMCDOW/lb8GjrRAidXacMldHOd08315r9D4Nj/QMcIAn6pDRJr8zn6KTiecqSM
         InGQ==
X-Forwarded-Encrypted: i=1; AHgh+RpGaWBrTRinJ1vciO/mbINlWoZQ/0fiVql7exXJtK7ohV/wRgX+SfqbqHJXSzZoXGKUiuT/5vXqStKfy4JW6nme@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0ySbP+uHalJUw+sK5XRDNIqHmfbejOc/x28wmI6+87YxkmQqL
	n/F+XtJLkNy3GbK+azOpjDrLA5OVk+LT0JMzkktOKq7MRmGrzwCIKFVmE+ngOtNr4Lg=
X-Gm-Gg: AfdE7cnk+XEckLHTYo0Hxxr5RNZnJ/EoA5VZeDOleeYNpuDXHzSPmgUbb4JAhnVx8JF
	Dq3uSoRAxCAQW5OnRRfZq41ACY2vOJ/uaTGNZ2G7bhe0RFj5lvWkfdGcB9mZ1FrQ9oPTjCEogFp
	4cY1cUnjLI4rdKMuSHDCmUz5hg7svZ+WkVtemKU2zriEXZqSldJPgG1/dXK3cfgBTjFX2W70weU
	qAaGlVZivw615KWprJHA0ppLKyLQL23vmCVJ8em00ViU3GhRQ7qvPvVQiw8GW/241nRCLXSjP0Y
	GvmsgiiBcTeAcVTz2TtKnD6KnyoYSMyMbmvC7VFe2iPF5NmqyfX4L8gFuRPQ7yC9jkfUQ9/jnJI
	KpLlnAMWHiaKtR2o9/g7gwBxshIZX/kCmpUNkwQyMphQnG2lYBXSk2/bdiys33bxtl2x6s5qzYd
	PDnUjpZqfzhxGgglImLX7zfxg=
X-Received: by 2002:a05:6a00:4c98:b0:848:4b27:36ce with SMTP id d2e1a72fcca58-84a673c79a1mr6078389b3a.73.1784205863094;
        Thu, 16 Jul 2026 05:44:23 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([2408:8606:1800:501::2:f])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cb258eeaba2sm1730793a12.12.2026.07.16.05.44.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 16 Jul 2026 05:44:21 -0700 (PDT)
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
Subject: [PATCH v2 11/15] riscv: mm: avoid Svnapot A/D aggregation in fast-GUP
Date: Thu, 16 Jul 2026 20:41:46 +0800
Message-Id: <95699db9c9b90fd1f95310e9d95b000eb8cfc616.1784201104.git.cuiyunhui@bytedance.com>
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

fast-GUP only needs the PTE state for the current virtual address and
revalidates the raw PTE after pinning the page. It does not consume the
block-wide accessed/dirty aggregation provided by the public Svnapot
lockless getter.

Override the fast-GUP PTE helpers to translate a NAPOT PTE into the
current sub-PTE without scanning the whole NAPOT block. Keep the public
ptep_get_lockless() semantics unchanged for other lockless users.

With 64K THP enabled in always mode, fio 4K random direct read
throughput improves by about 10% over the previous implementation on the
same system, from 2.615M to 2.874M IOPS and from 9.97GiB/s to 11.0GiB/s,
while average clat drops from 95.54 usec to 86.97 usec.

Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
---
 arch/riscv/include/asm/pgtable.h | 20 ++++++++++++++++++++
 arch/riscv/mm/contpte.c          |  9 +++++++++
 2 files changed, 29 insertions(+)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index dd56c20a817bb..3727c148fa0fc 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -597,6 +597,7 @@ void __napotpte_try_unfold(struct mm_struct *mm, unsigned long addr,
 			   pte_t *ptep, pte_t pte);
 pte_t napotpte_ptep_get(pte_t *ptep, pte_t orig_pte);
 pte_t napotpte_ptep_get_lockless(pte_t *ptep);
+pte_t napotpte_ptep_get_gup_fast(pte_t *ptep, pte_t orig_pte);
 void napotpte_set_ptes(struct mm_struct *mm, unsigned long addr,
 		       pte_t *ptep, pte_t pte, unsigned int nr);
 void napotpte_clear_full_ptes(struct mm_struct *mm, unsigned long addr,
@@ -956,6 +957,25 @@ static inline pte_t ptep_get_lockless(pte_t *ptep)
 	return napotpte_ptep_get_lockless(ptep);
 }
 
+#define gup_ptep_get_lockless gup_ptep_get_lockless
+static inline pte_t gup_ptep_get_lockless(pte_t *ptep, pte_t *rawp)
+{
+	pte_t pte = __ptep_get_lockless(ptep);
+
+	*rawp = pte;
+
+	if (likely(!pte_present_napot(pte)))
+		return pte;
+
+	return napotpte_ptep_get_gup_fast(ptep, pte);
+}
+
+#define gup_ptep_revalidate gup_ptep_revalidate
+static inline bool gup_ptep_revalidate(pte_t *ptep, pte_t raw_pte)
+{
+	return pte_val(raw_pte) == pte_val(__ptep_get_lockless(ptep));
+}
+
 #define set_ptes set_ptes
 static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
 			    pte_t *ptep, pte_t pteval, unsigned int nr)
diff --git a/arch/riscv/mm/contpte.c b/arch/riscv/mm/contpte.c
index 0f66426b0ecfd..b0b8ff0aade3a 100644
--- a/arch/riscv/mm/contpte.c
+++ b/arch/riscv/mm/contpte.c
@@ -413,6 +413,15 @@ pte_t napotpte_ptep_get_lockless(pte_t *orig_ptep)
 }
 EXPORT_SYMBOL(napotpte_ptep_get_lockless);
 
+pte_t napotpte_ptep_get_gup_fast(pte_t *orig_ptep, pte_t orig_pte)
+{
+	if (!napot_hw_supported() || !pte_present_napot(orig_pte))
+		return orig_pte;
+
+	return napotpte_subpte(orig_ptep, orig_pte);
+}
+EXPORT_SYMBOL(napotpte_ptep_get_gup_fast);
+
 unsigned int napotpte_pte_batch_hint_from_pte(pte_t *ptep, pte_t orig_pte,
 					      fpb_t flags)
 {
-- 
2.39.5

