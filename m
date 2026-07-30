Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15944772B7;
	Thu, 30 Jul 2026 23:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785454475; cv=none; b=LX864CSLA9vdravke1dw5+T50hWAsFhBm7QOPfChp5+rrMMpRmndv1KwNjs5Z35UypWNxj1+XErO64HadCiMau0KQbZWy8+DX+z3sOQSFtn6dMhyfJFTpLX+qijeOVslS1FvWJpRiMaYCLXQkN12Rw53Zne1O1QvGx+n/t+I1oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785454475; c=relaxed/simple;
	bh=+JYg44rITioasahMuedytXCjnJC4RUEzBBJdrrabxjI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DzymD2hxNrhoQ6jwsxohTYC/yRtkIX2CBXAsmVJ+ZqxB9lZy1RRTIHLNP1172iPLeyyNWTTYewr9UNwAjYHLS0QQ78AlSKMS9Ye6lCq+4xjfaM+dVK6nfafXon7enxhueuBSDrrtqKLhTfs8bhdr10NMUK+jvAFtfm6tL+cKk90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BX7tlXqb; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BX7tlXqb"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=H9D28D6eKPjyW9ST8CTBKhT0P6oaOZJjVDxJuIOmLWA=; b=BX7tlXqbyX21+JnRdfymPaDDPV
	/abbpsfskwT/LXLUeNJlgnyQa9Wfc1p/OcFVXPxU7AwIiLwdwjihbwL2IMjL9xgEV39tCnlzzsY71
	MHRiPrQRo3ed4yOlcongwo0SEn9RqN/PfzCQaFqM1Bvknnk9PtfYOvfLHuroVpfhAt3pFZZZPDgNo
	1hZStodk5ljgWmwdEtdFMFT6tn4yyKNRjqMcwmcQRZpIxMaA+lb6f/rsQe4Wp8An391qeUpE+A8lx
	B/3gIufXpicv+4M/UoZaGcAV2ICwe5a5aJA4TNMEAurUksS01ezfNxOhdwFItQLrcAw2Tb4FR7H4a
	4fDt2i8g==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpaGm-0000000BViq-188A;
	Thu, 30 Jul 2026 23:34:32 +0000
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
Subject: [PATCH 4/5] x86/speculation: drop Excess function parameter descriptions
Date: Thu, 30 Jul 2026 16:34:28 -0700
Message-ID: <20260730233429.285788-5-rdunlap@infradead.org>
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

These function parameters don't exist so drop them to avoid kernel-doc
warnings:

Warning: ../arch/x86/include/asm/spec-ctrl.h:28 Excess function parameter
 'guest_spec_ctrl' description in 'x86_spec_ctrl_set_guest'
Warning: ../arch/x86/include/asm/spec-ctrl.h:42 Excess function parameter
 'guest_spec_ctrl' description in 'x86_spec_ctrl_restore_host'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
New patch.

Cc: Thomas Gleixner <tglx@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org

 arch/x86/include/asm/spec-ctrl.h |    2 --
 1 file changed, 2 deletions(-)

--- linux-next-20260722.orig/arch/x86/include/asm/spec-ctrl.h
+++ linux-next-20260722/arch/x86/include/asm/spec-ctrl.h
@@ -18,7 +18,6 @@ extern void x86_virt_spec_ctrl(u64 guest
 
 /**
  * x86_spec_ctrl_set_guest - Set speculation control registers for the guest
- * @guest_spec_ctrl:		The guest content of MSR_SPEC_CTRL
  * @guest_virt_spec_ctrl:	The guest controlled bits of MSR_VIRT_SPEC_CTRL
  *				(may get translated to MSR_AMD64_LS_CFG bits)
  *
@@ -32,7 +31,6 @@ void x86_spec_ctrl_set_guest(u64 guest_v
 
 /**
  * x86_spec_ctrl_restore_host - Restore host speculation control registers
- * @guest_spec_ctrl:		The guest content of MSR_SPEC_CTRL
  * @guest_virt_spec_ctrl:	The guest controlled bits of MSR_VIRT_SPEC_CTRL
  *				(may get translated to MSR_AMD64_LS_CFG bits)
  *
