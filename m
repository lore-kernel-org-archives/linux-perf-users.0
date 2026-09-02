Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A820480947;
	Wed,  2 Sep 2026 11:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788350246; cv=none; b=WORAF/NEEI24/fvQB4/IwV19sa7NJim2FasGiAl5CzFDi9/51rsvP8NdcS67CZtjZgzF0nGgjDSDBXVPq335Aqg0yO9RXcIHqMnHPl3u1nGkDYPByRey18F1wyBy0mlrEXGEhARqMNmJU9mbFozY9yLS2fhsMTsyV0Nyhs8KjiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788350246; c=relaxed/simple;
	bh=TdiKqUQIhGYEbH6BYa9MBWqVcRex0i2yHAQjxbYrcNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q78KeIUTLJpIq9NdOoXxlshGv8H0zNenofCmug0mQr+ndBBmuwRLJ0ARfyGCXvuClFY5560R28/OWu8jDlnFsqMw3etI0o0sOhVmmpLqmyRTl7+8BddoiA8YaIr46fr8CMEmbJuTbzNLEVZOIZJY4YJxadF9WdE31HaxGt6qfwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CJyXDMN7; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CJyXDMN7"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=Sf9SbXB9hC/hxtAMh4dJIfYI3gNBvVXFs3PBsjYW0K8=; b=CJyXDMN74jU0hiWXEjYQxDgXRd
	PMnWOlFk4vCpsJ3KKFaQ9S23RUAvcAikPK3jt9FAGFawTo1pQgSU+nE0DNeQsydmmQxQBnPHscP1y
	toG0SVIc3zkW2GqAQdOVWhHoBAjpTyaP1ArPZZPC/k8PZ5LBwL6RVEvc0S0JC3D10Mih/TEBXLCHu
	NbrgxRh1LLIIvON22OrXGJUJ3SSJjXc+nSgSzuaTT7dkUHegEbuLjhTjZlSkyoi9ZFtRP6rpWBL1Y
	6TbZvccTd40TAuA+mF4lQAVQsw0Qxjhbr06ysGN6NPcgfNhiiYO1Esu6+Aa4pgoK5TlbO2VxQIkXA
	G5Tsusog==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1x1jaO-0000000BvXp-2r3w;
	Wed, 02 Sep 2026 11:57:00 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id D80E83008E2; Wed, 02 Sep 2026 13:56:58 +0200 (CEST)
Date: Wed, 2 Sep 2026 13:56:58 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>,
	Mark Rutland <mark.rutland@arm.com>, broonie@kernel.org,
	Ravi Bangoria <ravi.bangoria@amd.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Dapeng Mi <dapeng1.mi@intel.com>, Xudong Hao <xudong.hao@intel.com>
Subject: Re: [RESEND Patch v10 00/23] Support SIMD/eGPRs/SSP registers
 sampling for perf
Message-ID: <20260902115658.GK4121339@noisy.programming.kicks-ass.net>
References: <20260824082731.1013973-1-dapeng1.mi@linux.intel.com>
 <e80b6588-1ac7-48df-a8f1-8305cffcd14a@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e80b6588-1ac7-48df-a8f1-8305cffcd14a@linux.intel.com>

On Tue, Sep 01, 2026 at 04:55:27PM +0800, Mi, Dapeng wrote:
> Hi Peter,
> 
> Kindly ping ... Not sure if you have bandwidth to review this patch series? 
> 
> Currently all review comments are addressed and finally Sashiko can't find
> issues. :)

Ok, so I started going through things and the only bit I've found so far
is that I'm not sure about the below bits.

Is that really something we want to expose as UAPI? It seems to me
userspace that is interested in SIMD stuff knows this stuff already.

Anyway, let me continue looking.


---
diff --git a/arch/x86/include/uapi/asm/perf_regs.h b/arch/x86/include/uapi/asm/perf_regs.h
index 7c9d2bb3833b..faaa82df688d 100644
--- a/arch/x86/include/uapi/asm/perf_regs.h
+++ b/arch/x86/include/uapi/asm/perf_regs.h
@@ -2,6 +2,8 @@
 #ifndef _ASM_X86_PERF_REGS_H
 #define _ASM_X86_PERF_REGS_H
 
+#include <linux/bits.h>
+
 enum perf_event_x86_regs {
 	PERF_REG_X86_AX,
 	PERF_REG_X86_BX,
@@ -54,5 +82,30 @@ enum perf_event_x86_regs {
 };
 
 #define PERF_REG_EXTENDED_MASK	(~((1ULL << PERF_REG_X86_XMM0) - 1))
+#define PERF_X86_EGPRS_MASK	__GENMASK_ULL(PERF_REG_X86_R31, PERF_REG_X86_R16)
+
+enum {
+	PERF_X86_SIMD_XMM_REGS      = 16,
+	PERF_X86_SIMD_YMM_REGS      = 16,
+	PERF_X86_SIMD_ZMM_REGS      = 32,
+	PERF_X86_SIMD_VEC_REGS_MAX  = PERF_X86_SIMD_ZMM_REGS,
+
+	PERF_X86_SIMD_OPMASK_REGS   = 8,
+	PERF_X86_SIMD_PRED_REGS_MAX = PERF_X86_SIMD_OPMASK_REGS,
+};
+
+#define PERF_X86_SIMD_PRED_MASK	__GENMASK(PERF_X86_SIMD_PRED_REGS_MAX - 1, 0)
+#define PERF_X86_SIMD_VEC_MASK	__GENMASK_ULL(PERF_X86_SIMD_VEC_REGS_MAX - 1, 0)
+
+#define PERF_X86_H16ZMM_BASE		16
+
+enum {
+	/* 1 qword = 8 bytes */
+	PERF_X86_OPMASK_QWORDS   = 1,
+	PERF_X86_XMM_QWORDS      = 2,
+	PERF_X86_YMM_QWORDS      = 4,
+	PERF_X86_ZMM_QWORDS      = 8,
+	PERF_X86_SIMD_QWORDS_MAX = PERF_X86_ZMM_QWORDS,
+};
 
 #endif /* _ASM_X86_PERF_REGS_H */
