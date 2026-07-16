Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8114F41F5DA
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Jul 2026 12:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784205874; cv=none; b=ugG7xz58DSFxawMoUZ4VDW3UQ39JRxk7HZyRXZkMCJhDiVeTD9BhpUcslTcAWhmI530D+MGIqHyxYSYqo0th6fbqHanzh/mA8VYwPMcK5wdv4T4sdVHXrLOv6llFbM1XGdrwxeQAJggfxaCMSXYlrFz/M5qYC9sQRuUGY9rHHI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784205874; c=relaxed/simple;
	bh=z8jC4aCjR+Oesc+bLFA5i5JVDTkwm+Fh6FK3DV0FuyQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TiJ9VckJGp7zbIzIWIROw9jrmSlv6+dXkRO6EfzUgC8Is9JnwyOwGyKLERU562J6WQen25V+K7VWt/RpbQoJ1A7BLGF1zpYcd+ZpZaSiurgLHcXdpgASN1jf5N/diiIBpkxo0voiWuIYcd7dtGfOWFMJOi61W6VK51X1OWdsiqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=C45IRpyv; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="C45IRpyv"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-84864086bfeso6951342b3a.1
        for <linux-perf-users@vger.kernel.org>; Thu, 16 Jul 2026 05:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1784205872; x=1784810672; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s0haKjxFEA+XqfWLiPeMGRklJhvkZG2bsdABvuKjaV0=;
        b=C45IRpyvX6HmHdRZR3ZZ+1wy3BA5jkkEbDBp8+0GIb3o9EyyKPwbNvHw2gGop+WH2c
         pJiaNzVp6Tniz9si9bxp1FJoCGkPE8k84euMkqm9kHAOFakSHiXZCDq0Q+XNGenmtk0X
         AcNSdJFQzBIV3POW6J76B1U56B9a2HCGgTukkQN1LtUpyVMDf+QoJHwDHIP6cYbYhScP
         4Dl8WlrRhjr4kPy3MarWxpCJp9GcpM6nLT8uYIJ1cgPvf+qJwvLg+0bPsQ6qcGg1d3A1
         k+9C/SiPoGlnyNUZlQMiavpIldAGPonCUQBrMKCOqletZW6U9r8Ivbrkc7cDS/RvKyUG
         xz0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784205872; x=1784810672;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=s0haKjxFEA+XqfWLiPeMGRklJhvkZG2bsdABvuKjaV0=;
        b=bubqFeNp41xOetETnzzPgKBkes8sCYbbLmiBOt8Gu6sCjY22bSfxZB23GNn5IqUj0b
         BX5PSGbqnpp/jxytQJFsy7h+FeC0JjOBEg+Gnal0+yO6hfuwwJDbWkERuyE0tjRdSerg
         r/I7sADTBAmDN5SsiFPZsvpSRURK0mVumVsLKx+xfuWbPYEajvaGMnaAUE0O+YiOjKNv
         qP8iVcOQ1H/FN/CGUsTWUZRZijFIHiQUdtOeVHpp77UPOS0Gpf9JIJ44fpGum6tsfGeD
         4OlUoq2+450wOLmoHAmjoLzWL8rkHqwn5sb6VWV94mOFeIItJ2yDDu5/iy1hGFN65rsI
         CLbA==
X-Forwarded-Encrypted: i=1; AHgh+RpGFneEINStNgVNevnAPNehwPWuNejh3QAbQ5lpmUFiW2yLe6CEDEbMvYYeM1KtNGpF/LFAtTi3g/bUIpOPnaUr@vger.kernel.org
X-Gm-Message-State: AOJu0YzKgy7r11/xwTbeExX/9UTyQI1ydUmyboaHiY14euWWMkxFl3Jz
	XJFnu4OIy18f2cVkZ+Z5aE2pkJ2FeYT9swBRxkaiDd8wy/EnfSruzW2j6u7vatpyQYw=
X-Gm-Gg: AfdE7cmi3XDUa4fJgRo8LDaLKkkpqjmmaHlyedCqHyAkF5hvucGKzJ3fkc3fQHwLny5
	tUDYz5/eUiFBJJLairPVZE+WgNB2s61luZJ1f9EL3RRukULcYdQHeiJYT7gfqTZ0YqjD3MXDx12
	HNCtAjXCIgOkYRp3pvYRniqZfZD3yZi8kXPrJjA5e3P0DBK+qoHJIEwVhQUP6rtPhS8vAyvLxY5
	9PB/GVo4g17QYMy/UlG81pk4fIwJ5gKxzTo/r2dHfnHfxZHaEjGFfA1NF2x0YXb56ALSwHy68p3
	48D5FJVifJgj6mqb8HP/PA4LaPpUKSjPotl8rS/Wwki7B4PNQteYniNv4t+ttoY3t37YP2amFgH
	HryNqN7n/rOGYLG9+8yrPLyIGifyc+g9qmWwDw9gvhI07oAh+DWnpcEjUJuV023EaVS+nYH6bBz
	PNZN4ceRs+nCM1GyWK/Hv9Jo1TrLFSGdIJPA==
X-Received: by 2002:a05:6a20:e615:b0:3c0:9c19:6590 with SMTP id adf61e73a8af0-3c3576c37f6mr12235735637.74.1784205871769;
        Thu, 16 Jul 2026 05:44:31 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([2408:8606:1800:501::2:f])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cb258eeaba2sm1730793a12.12.2026.07.16.05.44.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 16 Jul 2026 05:44:31 -0700 (PDT)
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
Subject: [PATCH v2 12/15] arm64: mm: avoid contpte A/D aggregation in fast-GUP
Date: Thu, 16 Jul 2026 20:41:47 +0800
Message-Id: <92fbae3247b4bf0d7989ba20a8763ecb836d0279.1784201104.git.cuiyunhui@bytedance.com>
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
contpte block-wide accessed/dirty aggregation provided by the public
lockless getter.

Override the fast-GUP PTE helpers to use the raw PTE for the current
entry and raw revalidation. Keep the public ptep_get_lockless() semantics
unchanged for other lockless users.

Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
---
 arch/arm64/include/asm/pgtable.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 018781a1fcbee..d1e08dce9f7c5 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -1760,6 +1760,22 @@ static inline pte_t ptep_get_lockless(pte_t *ptep)
 	return contpte_ptep_get_lockless(ptep);
 }
 
+#define gup_ptep_get_lockless gup_ptep_get_lockless
+static inline pte_t gup_ptep_get_lockless(pte_t *ptep, pte_t *rawp)
+{
+	pte_t pte = __ptep_get(ptep);
+
+	*rawp = pte;
+
+	return pte;
+}
+
+#define gup_ptep_revalidate gup_ptep_revalidate
+static inline bool gup_ptep_revalidate(pte_t *ptep, pte_t raw_pte)
+{
+	return pte_val(raw_pte) == pte_val(__ptep_get(ptep));
+}
+
 static inline void set_pte(pte_t *ptep, pte_t pte)
 {
 	/*
-- 
2.39.5

