Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ACB84779BB;
	Thu, 30 Jul 2026 23:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785454473; cv=none; b=n77n+Ko9RK6gwTpN+fuy8CT2lNjZUplCAryGCQP/5fT5/ZKgFRObHeYiiSbuPZSmrmpTAqvRLIBMZXULmalqCW+8y0Esq9i3pXo4/+L9Ou5KEKKGzkpU6xG64U9Dd9QNRPjoImuCQ6tb/lVao/GBjlCaMl7f6xQiivI/2Xa7JTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785454473; c=relaxed/simple;
	bh=X+NL8iI60GaAeZtxSALjdcMuw+9fJvViDZaApw0pX14=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UvEj3ed8UYXybR3PXSt8TdN9vkL15o4ppIB3bIliFilNmqRkH86Ajv+U3zpmhBuShsLJ+8Jyv59VNDEzTrVmBY5kxcRJZBdm+v334lSrAUe4K59Q8COZ/tSFXPc69KE+pSiX2e0qVRJj+TeRLMvYLgJLJ8SOyODC59Wz0IVLeGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=zWweAbvC; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="zWweAbvC"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=WSnUXtzk/IAMW2FmLOZfHRFAdW0dhihRTBKbHPsoNO4=; b=zWweAbvC4iMSZkao9/8mJkN6jL
	AU4BQkNncwHZ4erawZ1xS5qAqepfysBvn0WQnytH9yYOxN/VeMqaPFLbnZvJknC4ZLfEsaz2h7Pmv
	VbU+p47tQsTq8ybc+6Kj3fJWTozFKEMLXpKxF9Q3sco4Mrv65cjnAzESF/t71239xf1Az61YSQwTZ
	AvlMNL1GKsfjVpYdaWwa/M/xkDnL4zHn5G58BBWuQTmVGkhzr1pOaXA+Vdgl4IZoBppOELh9wPmbT
	FDcN8OzX2K9vpGpPk2kLRvTZ0Fvu4Cbf6jCGFAL2/hCqscz5zuT+lA2jznoXQTmzk3POtzGkaPgtR
	XQtb14qA==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpaGk-0000000BViq-1z3b;
	Thu, 30 Jul 2026 23:34:30 +0000
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
Subject: [PATCH 0/5] x86: clean up some kernel-doc comments
Date: Thu, 30 Jul 2026 16:34:24 -0700
Message-ID: <20260730233429.285788-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patches 1, 4, and 5 are new.

 [PATCH 1/5] perf/x86/intel/pt: drop kernel-doc for deleted struct members
 [PATCH 2/5 RESEND] x86/barrier: use correct parameter names in kernel-doc
 [PATCH 3/5 RESEND] x86/lib: checksum_64.h: eliminate all kernel-doc warnings
 [PATCH 4/5] x86/speculation: drop Excess function parameter descriptions
 [PATCH 5/5] x86/intel/quark: clean up function kernel-doc

 arch/x86/events/intel/pt.h                   |    2 -
 arch/x86/include/asm/barrier.h               |    6 +--
 arch/x86/include/asm/checksum_64.h           |   29 +++++++++--------
 arch/x86/include/asm/spec-ctrl.h             |    2 -
 arch/x86/platform/intel-quark/imr_selftest.c |    7 ----
 5 files changed, 21 insertions(+), 25 deletions(-)


Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Thomas Gleixner <tglx@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org
Cc: linux-perf-users@vger.kernel.org
