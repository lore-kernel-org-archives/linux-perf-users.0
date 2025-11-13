Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1B62D3738
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Nov 2025 01:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762998427; cv=none; b=qCpEUsWiz0gDQCEyug0I3Ipz10DQSwN67SCjhWZzMUOxtyAWWu1Jt2t07y7gJeJNjv/BhK3KJEDl1Ous1epS5QvN3lcb48qVAbBnA1FI7YufZ74n8gJU0lyyheEjsE8qEJ+MJ/NVL7RcPwZmAt643vVNfrDzlR/6iPImmcx9KnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762998427; c=relaxed/simple;
	bh=eKBqONdiSsBUuobmEdY1mAtYTYL7O9m2hVGhf0V16mA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T3RdltlpdSCuhkL+2fm49I9o1OXclXyRN1l9QLoKRLHSaDGJ5QpMx2+qq8XlaWN6qOU5RJSjMhWrwZUW+3djDqgmJUwg+Oa9lNj348+PfEJx4CrmxI/dSTiVk63CclwzClzjVErk46i03EiaQE9l7OIECxDoRT9at7d3vElO58g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=KG7OcXl7; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="KG7OcXl7"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b994baabfcfso183080a12.3
        for <linux-perf-users@vger.kernel.org>; Wed, 12 Nov 2025 17:47:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1762998425; x=1763603225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7sKtwP//OgsTzC5xxNl/Xd6UYX/1wT9VConzzoLFoks=;
        b=KG7OcXl7nxmT2EksNPHe/AKIJuk5Vy9O35FpuQ2rjXW5WqrT3/YWNFJ6h/1s6Tws8P
         KFQ5IzmnR0fKvxLQLB9y31oIJLHsdKqLRbM9ixCzRIx5rZSlidMXLFPZu06zUzf9lnU8
         HNxkrzksKrwM9iIddJ3vSGeqaUXPoeWnHbcLFRBho8/jVB4PFqZXiDY48UWX+w4dUe6s
         KnQm6JsaoEmdBWrw268jdp05SZhLPEKLyGyBXula8iLNwedZK8GXQ1moW8snzTgx2yje
         OH/PxclioA4yXk5wUhRmI9m+9nbPLjlvfZClqjPUuMIQGMigZ0FyWEQTStKYBSYq/zoB
         0nbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762998425; x=1763603225;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7sKtwP//OgsTzC5xxNl/Xd6UYX/1wT9VConzzoLFoks=;
        b=DqNKTciGYNCI/i/3bIiqemtnIqz/dNnlCDSL+xIyPBLfFRJePec45kVCEviiEK06BU
         SYk+kWgp+aQVhfIpWCH4Yz/Bsela0OJjz17tBSaxf8Qi2YNS3SCD0Pl1S06puEJR4ZxN
         V4+jL+C8sNOMnQeJUterzEng9N80Jwq2ORu5mtXA0dRKAt26EyQQbKu/dt8CVVv0Q8Az
         KBXVrtIMVT3rwrJTr8GhyE7tYjoiaPkmICSc4qbYNwXIYIPXtJCJm8ftTM0MSn1+98sO
         56wEAoghh0VG8kH71c1QsWAWs0yl0t3WkI0mYIquxxw1Be8OByuNjIa8iE6NeEOygxbo
         G4Wg==
X-Forwarded-Encrypted: i=1; AJvYcCXFJX5BS86sOuiTXdpSu44l71UBSq9vNT2y5BdO0uXERvNOxbbYfQfImB9b1VsB4Eu8jd3rRSdrH8FLosKqrDMd@vger.kernel.org
X-Gm-Message-State: AOJu0Yxkx2BIwKRHUrH8LYs+aEqt/x4hTnuMCNyQuo24/kobaBBOCkyg
	fPRNT12V0J09G/gytmQk8zf81PXssyFaXaTBGlSTxau6/LmRFwczO9Fl/73YLLlrFQs=
X-Gm-Gg: ASbGncuYT+ZDlnDJMEmR/Ld8hdGMVoQ84HzM80SclbPooE6A5EXVxRePHWPRQMZ7Znm
	Ulm86/pRVxS4XrnWXRPgqBmV/UFkaSZpA4BAlwkaCT33kZQUmzawOZZ/5vjN4oyxBXsutkr+Rhs
	CLntbQQMDDf7egYhzkwUJQ+Bz6Q7Kw8mJLwssHU82kgRnZUciQR8QUF7pmqk20s9bbT7RvsIsMz
	Bv4HL2g+13JLqIiBF+n2kgnBCKSfFi7MGqZ7g6bD/LpGXMkzwp1dH5Tlyz/Jcv4Q249iMXWPrUg
	i7wh/eHrhCt/bIZqmrz4vOzZ81LwtrkXPSK0SmymeqYqUnNbyGUZEoMyOy83hVfN9ePpZbozeF1
	tWebPhbBlyoD4+HZIbOT9dpyJx2OGgNIW84UY+UAjsctlatBdtBaHeHZTesSMKux0sEV6z8d+2O
	P5kUWsxUSBR5moVERehHTUnQ==
X-Google-Smtp-Source: AGHT+IFyAjw4zT369i2V/HQmfngUMRA4j/oLD3IR8XNvQ6Htb0EplxsCGv5RKISA4ePCqfHnQtITTg==
X-Received: by 2002:a17:902:e788:b0:297:d4c4:4d99 with SMTP id d9443c01a7336-2984ed30d02mr63149505ad.6.1762998425114;
        Wed, 12 Nov 2025 17:47:05 -0800 (PST)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2ccae8sm4986485ad.98.2025.11.12.17.47.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 17:47:04 -0800 (PST)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <pjw@kernel.org>,
	linux-riscv@lists.infradead.org,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	linux-mm@kvack.org
Cc: devicetree@vger.kernel.org,
	Suren Baghdasaryan <surenb@google.com>,
	linux-kernel@vger.kernel.org,
	Mike Rapoport <rppt@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Conor Dooley <conor@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Rob Herring <robh+dt@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	linux-perf-users@vger.kernel.org,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v3 04/22] perf/events: replace READ_ONCE() with standard page table accessors
Date: Wed, 12 Nov 2025 17:45:17 -0800
Message-ID: <20251113014656.2605447-5-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20251113014656.2605447-1-samuel.holland@sifive.com>
References: <20251113014656.2605447-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Anshuman Khandual <anshuman.khandual@arm.com>

Replace READ_ONCE() with standard page table accessors i.e pxdp_get() which
anyways default into READ_ONCE() in cases where platform does not override.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
Link: https://lore.kernel.org/r/20251006042622.1743675-1-anshuman.khandual@arm.com/
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

Changes in v3:
 - Replace my patch with Anshuman Khandual's patch from LKML

Changes in v2:
 - New patch for v2

 kernel/events/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 1fd347da9026..fa4f9165bd94 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -8122,7 +8122,7 @@ static u64 perf_get_pgtable_size(struct mm_struct *mm, unsigned long addr)
 	pte_t *ptep, pte;
 
 	pgdp = pgd_offset(mm, addr);
-	pgd = READ_ONCE(*pgdp);
+	pgd = pgdp_get(pgdp);
 	if (pgd_none(pgd))
 		return 0;
 
@@ -8130,7 +8130,7 @@ static u64 perf_get_pgtable_size(struct mm_struct *mm, unsigned long addr)
 		return pgd_leaf_size(pgd);
 
 	p4dp = p4d_offset_lockless(pgdp, pgd, addr);
-	p4d = READ_ONCE(*p4dp);
+	p4d = p4dp_get(p4dp);
 	if (!p4d_present(p4d))
 		return 0;
 
@@ -8138,7 +8138,7 @@ static u64 perf_get_pgtable_size(struct mm_struct *mm, unsigned long addr)
 		return p4d_leaf_size(p4d);
 
 	pudp = pud_offset_lockless(p4dp, p4d, addr);
-	pud = READ_ONCE(*pudp);
+	pud = pudp_get(pudp);
 	if (!pud_present(pud))
 		return 0;
 
-- 
2.47.2

