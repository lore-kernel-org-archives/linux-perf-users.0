Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA80941F37C
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Jul 2026 12:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784205900; cv=none; b=UVUUeej3v1WBZB2vgct/ZbsEhfKtvzDkQJmy9COODwQPY3YOoB7YSrMg6eE8n9yd355l6SVhGfztxFifRVrvdTjgWSB5xhEz4EgmkubKb/kQBJM81qUYSc0dgucWwA7g5Po5Pgh6VNySPTAPUM9DjeUKyZF9yeH455QeKDvf0DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784205900; c=relaxed/simple;
	bh=ybAp/Hmnc3TAueG66xnodqF9+Bp3yZdy6u6JbQGTD4E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i967Y7jEv4q4ZJBLhV5I3PeQd4u2hX04WOpvZgaY3pe1CsVc0ZhWN41x+z0coK00m2q208Oy9Ids7Tolmh4RTapYWIxHd075bWP7e8sGF1euap2MR5JARl/+365x8F4G2xy2ydF24O161AMsVK7npBYktcbPkAULa1VcsJ50iPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=MUbSTRUR; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="MUbSTRUR"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2caed617615so74436495ad.3
        for <linux-perf-users@vger.kernel.org>; Thu, 16 Jul 2026 05:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1784205898; x=1784810698; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=igNuDXnwdUCT2dm/vIcI/M9kQJ6fMwWaxma7wgKaCpI=;
        b=MUbSTRURVANI8QAKE7ELCYR0rI7ExejRVAjeV9XMDIhl5okUOjsWO4JBdblNUhYmtH
         ppZCrNRxUk/330nLIPhHo+fI5J7cJCukbhaGP807E9LqxMy/bkaVJlicpb5Hjf8yXYl+
         PTpc2IF71XhO4uJ5QPFicMgiSMYwV3BPjtsF6IntBi05yOsDRQJq8vh0d2fD+NxHLidh
         wqbdlz3QrVgO2dw/WO7ATLh3cBaJ5YUZHLaM0eGXOPLxS3VCeRW3IVMv/kiull43rv0F
         UqXNjc7ykwlt10+k986cuFuk1GZ6hnGni/37BVT4BjOQxTvkEWmsyFXXWca6MZ4ce/v3
         Cc7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784205898; x=1784810698;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=igNuDXnwdUCT2dm/vIcI/M9kQJ6fMwWaxma7wgKaCpI=;
        b=GkMFjfv8OqLLf8XzAv5+xLUJYEDUmgQs9OJsn7NgF+FHfTR3hxbJ7soafhblygV/Hw
         uZJctWbdTKeOll40DtEqkjRdNBJaGaJbc1/BsCBhKkv10a6agYh677cXfY3nECbDQXgp
         yzUtTy88rs1ahcvG1U+xJGjOscz/JyeLNe6I79nsfN5PdOg1QVwBDUghtwM1LWobPLS5
         zJ+qGpioIz1zfBzOne1IJia0NA7Y/Obr5MErFQxclsDBIigzl1UxgVpPxs8mGLrp8aAo
         gVK9DYEQNNrdV9x/dW5s2SIa8sSyuo1y9+Dq/E8NJDc0tjlWk9a4+5db2UDB0+zAizKs
         MdFQ==
X-Forwarded-Encrypted: i=1; AHgh+RqnJ1awcY/dXp6t698L2i4ZPtbjph/cB2S7O5/o5Jo0Xr4xZ2XfSI0+iENgPOAxuTQbXtDO/W9ZNdogvBKJIB0I@vger.kernel.org
X-Gm-Message-State: AOJu0YwAzDdJPnNVVibfuJVqzubNlhVVQpstSg+Co2GQ6lmSuxsen/BW
	1ImGeqSO+MURzTJtuFLWWV9YFtBMrSTJAHexPrTgjIFJbWUocSjNs2KaMm+8tY3TuLc=
X-Gm-Gg: AfdE7cneFDNgtJCdovdsrzF/6WE8hm/62Wuqe3/kTU+zNW/6VVQProkmcvCWECzz7Zx
	pk7U+uB5vJ2JqRtJd34EnudwplFKJL33fEXxuZQRYLoXRvC20ILZSlz5s3r7dLRNthdOcIF+0vY
	nqNaOB/m6ALL6RXjWIfYsnjB28sI0rhCYEPvtW3FGMmcaMhxaXILgKSO/+EU4JcZzkX34QgdfxW
	LQIZcM/TxaJw6F40CSP5c/kNAxJ5dh/Jrm6ENTsjF6WyCUCx1b0uVAIGComyqrXjAyeb90YsKNR
	KCVnFu06qfMh8487TQqzKU6O+EAtb3otVMyScFzP9iOPT53CJ6mHbMzjp3E/08fQISMyuvDwyRr
	+RzraZg/W9AEzarXJryB5gRdHdIrA8+Cbs+r72Cd+QzdCJckE1Q2T0ArJTDsrj3SNQszs1KLf63
	pN0FmhXd8JU9ZQZDGCvm1RBgs=
X-Received: by 2002:a05:6a21:7318:b0:3bf:a881:4094 with SMTP id adf61e73a8af0-3c36c35d245mr7182183637.50.1784205898111;
        Thu, 16 Jul 2026 05:44:58 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([2408:8606:1800:501::2:f])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cb258eeaba2sm1730793a12.12.2026.07.16.05.44.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 16 Jul 2026 05:44:57 -0700 (PDT)
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
Subject: [PATCH v2 15/15] riscv: mm: Request large exec folios for Svnapot
Date: Thu, 16 Jul 2026 20:41:50 +0800
Message-Id: <88438f09b79ceab1548aff17384814b7f699a43d.1784201104.git.cuiyunhui@bytedance.com>
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

The Svnapot MM support in this series allows generic MM paths to operate
on folded 64KB executable mappings while preserving a per-page public PTE
view. To benefit from that more often, executable file-backed mappings
should be faulted in with a folio size that can be folded into a Svnapot
range.

Request 64KB executable folios when Svnapot is available, so executable
text mappings are more likely to be installed as folded Svnapot blocks
and benefit from lower iTLB pressure. Keep the default order-0 behavior
when Svnapot is unavailable.

Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
---
 arch/riscv/include/asm/pgtable.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index b546e6614c558..6801ba135c483 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -296,6 +296,14 @@ static __always_inline bool has_svnapot(void)
 	return riscv_has_extension_likely(RISCV_ISA_EXT_SVNAPOT);
 }
 
+/*
+ * Request executable file-backed mappings to be read into 64KB folios when
+ * Svnapot is available. A naturally aligned 64KB folio can be folded into a
+ * Svnapot PTE range, reducing iTLB pressure for executable text.
+ */
+#define exec_folio_order() \
+	(has_svnapot() ? NAPOT_CONT64KB_ORDER : 0)
+
 static inline unsigned long pte_napot(pte_t pte)
 {
 	return pte_val(pte) & _PAGE_NAPOT;
-- 
2.39.5

