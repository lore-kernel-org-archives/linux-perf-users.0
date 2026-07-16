Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6304141F5E3
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Jul 2026 12:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784205828; cv=none; b=LF1+iceLDtwOID0R74Wr+JM6z/w8aJALoNJovvQ7q/5/E42yYUM14pkRNcRuamEUT3NnCI0zdwfmsgpG3SAZwsGPRKrcYDaeCekP3IB1Sz6We0MoeO7oA3t3UR/0t/mHjdUdsJB4+rxQAVlajLNI8658wZU7RhXN2U3F7PHRTcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784205828; c=relaxed/simple;
	bh=GTL7lfLqQg2oKlzbVmjbLCLKjuhCvVW9dLIhh8F61C0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LXbJiCbBYevnFUljwzlu3fv/m61khK4w+enRGkcev+HPtNKiuY2d5vT0U7QOkuqjrXlaocwEsUhqrm7KKRFaUYQC6KocFvcEHouWux8eoyysVuKLvft2YFmb7SYoqcFppTXb8jhHoe104J6WZEY2+BFl4LQxsKXpI5gSUvk0hls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=F6q0PAQX; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="F6q0PAQX"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-84830c774a0so2549234b3a.1
        for <linux-perf-users@vger.kernel.org>; Thu, 16 Jul 2026 05:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1784205826; x=1784810626; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qpVNfPM2loki1/2WSjY19UJOAg4x0MrZ4b63t+Pbr9Q=;
        b=F6q0PAQXwf5d0w1jOqLx2K0qoVg2fk8qgi+lsTSlnjUvCqj7fSXus6MPZqkQPM9Kaw
         SaDC+UrciFz7zxDe3qWf6RvsX2I/ss5sSWunCKtTFaxpkSCq9jRZR7Tat7rrixvVsYnA
         Xz00ht/xgMvKkXnJFZUYgkMr+xUnXsCLhihGDkT2BaPTEctRxiaoJiUdvNubcWyKZO5O
         bKpz0cq8h71x+3JBALKBTDw7Ku4SZxlza2f8fZLSua4FnbBaffiDTbvwKd7Z0FNJeJw7
         KqP8uF+gmXcRK+K26obDJFO9yCszjcUWWGH7QBAm7XhGhAsKMPieDsv8HM1aoj+pKARU
         pRGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784205826; x=1784810626;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qpVNfPM2loki1/2WSjY19UJOAg4x0MrZ4b63t+Pbr9Q=;
        b=nh2CEuIN1dI3I6oisNmzIPq3/ULBjtdhT1xsZw7cPlWRdo3vkijCnm/odtzCtVIw4k
         VcnjqsxQmO9tpAiOkSSgPsvxnUtnV+K6YzvDWPAsezoPzkPYvovQioK9jKcuwFtAgriH
         gpHKqGW0sFiJ7fukbbpRGZkDurfosYMMoG+YcpJlJv0QJCvH1qwJ2y/9hNlplT7tJ7Nx
         HTHCXCggi2r5yY1FQZm90waS6gEeM3ZJdHAxvz85YCbf+uoNcUiA3Jde3Ovx4mQ2I0sI
         CXg15GDFW/OPe2OQwVRjn8+x99cdSRQs+kg7oDHcd8ihr6bWL5B1rsyxuz9BLYR/NrSk
         MdkQ==
X-Forwarded-Encrypted: i=1; AHgh+RoKQ5EGylKKKfH7AX+FFzdMxFOq0Kui05o8EJ25A2LJXHhff0K7pwe9+JuHbH6SAQoseEJRGurOzYJd7ecLoltN@vger.kernel.org
X-Gm-Message-State: AOJu0Yzyu0EsYBtJzU7nMJJ2vEhNJDureQGFzmCGYWP/0xiWi8tT0+q1
	QSSY07o6Kjxq3y3Z7pR1K/EivZgiZEzJUA39yCerBbmgeKzt2+9rO3b47MgjP2kgea8=
X-Gm-Gg: AfdE7cnGN5uoN4vIZBffA20fssCzi0PonU6awnkG3+PqdMfXAL5c3MqeoRJkLGMdr6q
	m/+UMoBS6xy5p6gGOdatZU14rR5QeUZZ1RifXobQBwBn+yajxNHJnuibXdaMBF1gMKWhE4GIZqF
	PH+DeJ7TtebAnIeuXjPtjHISnj2fd1IiSX5nrPHNQUu2aaeEwFdHWU1MsiRnH6Ky9MdWpeLbR7m
	4dGuAaPDyBxljrWR4BzTNRI5b9VMCbMhdl0GRafUcKaMU6EeDk4NIGPLd/D+hdS6FZVx06K5Azr
	xahEvBQjOsKLhv+rOr3zH5t+Xzj7seQYJP46dc9SB4yvjGSbKU0DnRjH2kpufIQz7iYPsYhreWG
	/ewU5FO7MRDy4rJXD0J6OQVAhsXnDTcPjKKx9zbaZTc5iA2Xgur/iJx+6ClRSxroNuB6iUPi6tL
	WmQVhGp7Jq8F9KffyKmx4v76A=
X-Received: by 2002:a05:6a00:451c:b0:848:2f74:d8d8 with SMTP id d2e1a72fcca58-8488986dd0bmr19929855b3a.73.1784205826475;
        Thu, 16 Jul 2026 05:43:46 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([2408:8606:1800:501::2:f])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cb258eeaba2sm1730793a12.12.2026.07.16.05.43.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 16 Jul 2026 05:43:45 -0700 (PDT)
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
Subject: [PATCH v2 07/15] riscv/mm: preserve Svnapot leaf-size semantics for page-table consumers
Date: Thu, 16 Jul 2026 20:41:42 +0800
Message-Id: <180084b20de76f7ad61641e9b7abe6d103caf5f3.1784201104.git.cuiyunhui@bytedance.com>
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

Svnapot keeps a folded 64KB mapping encoded in the page table, while the
public PTE helpers may expose a logical per-page sub-PTE view to generic
MM users. That logical view is suitable for leaf-style PTE consumers, but
it must not change the effective leaf size reported for the mapping.

Use the original page-table entry for leaf-size queries, so page-table
consumers continue to observe the Svnapot leaf size instead of incorrectly
treating a folded mapping as PAGE_SIZE entries.

Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
---
 arch/riscv/include/asm/pgtable.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index da7ffea0dcd98..e4b9c05014c00 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -580,6 +580,17 @@ static inline pte_t pte_swp_clear_soft_dirty(pte_t pte)
 					napot_cont_size(napot_cont_order(pte)) :\
 					PAGE_SIZE)
 
+#define __ptep_leaf_size __ptep_leaf_size
+static inline unsigned long __ptep_leaf_size(pmd_t pmd, pte_t *ptep, pte_t pte)
+{
+	pte_t raw_pte = READ_ONCE(*ptep);
+
+	if (pte_present_napot(raw_pte))
+		return pte_leaf_size(raw_pte);
+
+	return PAGE_SIZE;
+}
+
 void __napotpte_try_fold(struct mm_struct *mm, unsigned long addr,
 			 pte_t *ptep, pte_t pte);
 void __napotpte_try_unfold(struct mm_struct *mm, unsigned long addr,
-- 
2.39.5

