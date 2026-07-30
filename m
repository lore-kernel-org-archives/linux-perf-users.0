Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA54B477E3A;
	Thu, 30 Jul 2026 23:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785454473; cv=none; b=HaA26tf7NMleTY043DFZuHKjQL9B0YywXWA0zdbLee5U0laRV6ihicHYZk9Iir2j5axQVSGZH+yUrQZ5Yar5jADLcwTECtJ4oArSsDbVsDZwEtkALlzUEYVGVCiD3DDy0TT00/ccd/68KRPLpX4ge/nP4Z5uljtLfAhEbR2qUEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785454473; c=relaxed/simple;
	bh=pghY57qcgcZvrl6KH1UxUr+D0kd8Iuo5aILhiUUkxd0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aa4j5nK8SSdLuxWL4gGqqtV8b0unuTnfu0/iyYZzMy370Wb/1J8ttC02A+EE1kdmHalO/sU0lDg44+X81a0EM/pgfLf79x/X202OPuv4KHqbboBKNn9tc7MDOF7fwbdeyQHsLDkmkmcLo8yf5p26AiQY3PsVn5GeHNolwXj8SYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=eLET2Ekh; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eLET2Ekh"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=dvPJ52fgIMGTmnjF5pBYGganUiGNj+LbNvx1+D/IU1o=; b=eLET2EkhHgHtAYP0/Xy2fCkeLE
	HeueJi1pFkXJ4HwELtPZxdK4OsekodnWP2ApkpZsL3noUoufxgNYmjQSQaRfVx6IAqjHX6B3xIU7z
	/CFm+83mPZDzynKzUT95LBV33hMImR8j6GAr0NTWJ80KxtMcopJXaKaFhlGeH3jXT+g2cMf1LmeaD
	rAwmz0x+QqxG3av4Pn49G2pCRovVFPKEzL/urbitMPRqTBmfVTvuqOLJbdVZ4aAyRQOxt5KsXxPA0
	UwKtfQrXpi9Htwh4dRBgI+xyiMhGp3UxjaWk+vFoZY75kbNdz9IOL940qMftzViFNH4VK+FmuLWf3
	6EeqplrQ==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpaGl-0000000BViq-1XKl;
	Thu, 30 Jul 2026 23:34:31 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	x86@kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 2/5 RESEND] x86/barrier: use correct parameter names in kernel-doc
Date: Thu, 30 Jul 2026 16:34:26 -0700
Message-ID: <20260730233429.285788-3-rdunlap@infradead.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260730233429.285788-1-rdunlap@infradead.org>
References: <20260730233429.285788-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the correct macro parameter names in the kernel-doc comments
to avoid kernel-doc warnings:

Warning: arch/x86/include/asm/barrier.h:35 function parameter 'idx' not
 described in 'array_index_mask_nospec'
Warning: arch/x86/include/asm/barrier.h:35 function parameter 'sz' not
 described in 'array_index_mask_nospec'
Warning: arch/x86/include/asm/barrier.h:35 Excess function parameter
 'index' description in 'array_index_mask_nospec'
Warning: arch/x86/include/asm/barrier.h:35 Excess function parameter
 'size' description in 'array_index_mask_nospec'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Thomas Gleixner <tglx@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org

 arch/x86/include/asm/barrier.h |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- linux-next-20260717.orig/arch/x86/include/asm/barrier.h
+++ linux-next-20260717/arch/x86/include/asm/barrier.h
@@ -27,11 +27,11 @@
 /**
  * array_index_mask_nospec() - generate a mask that is ~0UL when the
  * 	bounds check succeeds and 0 otherwise
- * @index: array element index
- * @size: number of elements in array
+ * @idx: array element index
+ * @sz: number of elements in array
  *
  * Returns:
- *     0 - (index < size)
+ *     0 - (@idx < @sz)
  */
 #define array_index_mask_nospec(idx,sz) ({	\
 	typeof((idx)+(sz)) __idx = (idx);	\
