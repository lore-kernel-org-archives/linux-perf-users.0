Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19AB523816C;
	Fri,  5 Dec 2025 12:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764937027; cv=none; b=PBreoZG75Hzgg9SLfCMMtshieHQPMMmEhFeVaAwrSSd63m50Jo5BjMb2W39J+bNME4ru1cdGPzPicSUPS6VylumpMTiTeW17Gsl196zUo/pt2Gwxw1PFpuxBAjfp+kzEXNoTGJLL4zxPSt4T1m9Pep/9jUFBbrNKmXGt+LUozww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764937027; c=relaxed/simple;
	bh=xa5qUJnlzyXQqZ41Fwjuj4jXLQc51waqXeyUKV4LIA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V1cYwe+KT+We7Je2d/EbbnSRl+6/9eAgJkdyMa1IYcEmE1uPxHL4re4mfcWUDC8FyMXbKFJw2etrm8C7iIrApZeBPHigBFLa8xzx22g9r9Cz/EqnciqIK9Fbip3L3cewUTMAf2xXDT0g0WdDXTIXc1T9XEcKKhu3r3dcBN0X7UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YW6CX/NT; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YW6CX/NT"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=iFRcPQvCVn31il7oDYjfCtsnNcZewHcoM5ejIBWypM0=; b=YW6CX/NT4KsU3PpFK8YBR+ewfq
	ZKXkjjsRbTnR4gBOMGp7YRV6HDIMNDoHfIpzpyld9F5pfmRIN19efNo0TIsamj3aAenbJ0VM+jfDM
	awVBHlTMx247uYU7CSXktwRkUg+lAUqZsCxxXXzZnDymNkD2gjIHCQKIqxHkTSrqURL+FQU9KHJ6F
	HXNXGkGNEgsQpai6KEqVuiSYHwMKASLbcfYVjuBY88Mdhp+wnIPNCURpcPS7T5cKomNzOuyLR5BpU
	ZpX8baiEABZeS4L2hDa9SDfO6i4EoVKycGaQhxvTEpjRACFj66CAxUXr7OgvDQSsYcBAZwKddFYe/
	WRIjkNaA==;
Received: from 2001-1c00-8d85-5700-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:5700:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vRTsT-00000005ynp-2uXa;
	Fri, 05 Dec 2025 11:21:33 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 9DD2A30027B; Fri, 05 Dec 2025 13:16:51 +0100 (CET)
Date: Fri, 5 Dec 2025 13:16:51 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Dapeng Mi <dapeng1.mi@linux.intel.com>
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
	Dapeng Mi <dapeng1.mi@intel.com>, Xudong Hao <xudong.hao@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>
Subject: Re: [Patch v5 12/19] perf/x86: Enable eGPRs sampling using
 sample_regs_* fields
Message-ID: <20251205121651.GW2528459@noisy.programming.kicks-ass.net>
References: <20251203065500.2597594-1-dapeng1.mi@linux.intel.com>
 <20251203065500.2597594-13-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251203065500.2597594-13-dapeng1.mi@linux.intel.com>

On Wed, Dec 03, 2025 at 02:54:53PM +0800, Dapeng Mi wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> This patch enables sampling of APX eGPRs (R16 ~ R31) via the
> sample_regs_* fields.
> 
> To sample eGPRs, the sample_simd_regs_enabled field must be set. This
> allows the spare space (reclaimed from the original XMM space) in the
> sample_regs_* fields to be used for representing eGPRs.
> 
> The perf_reg_value() function needs to check if the
> PERF_SAMPLE_REGS_ABI_SIMD flag is set first, and then determine whether
> to output eGPRs or legacy XMM registers to userspace.
> 
> The perf_reg_validate() function is enhanced to validate the eGPRs bitmap
> by adding a new argument, "simd_enabled".
> 
> Currently, eGPRs sampling is only supported on the x86_64 architecture, as
> APX is only available on x86_64 platforms.
> 
> Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> Co-developed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> ---
>  arch/arm/kernel/perf_regs.c           |  2 +-
>  arch/arm64/kernel/perf_regs.c         |  2 +-
>  arch/csky/kernel/perf_regs.c          |  2 +-
>  arch/loongarch/kernel/perf_regs.c     |  2 +-
>  arch/mips/kernel/perf_regs.c          |  2 +-
>  arch/parisc/kernel/perf_regs.c        |  2 +-
>  arch/powerpc/perf/perf_regs.c         |  2 +-
>  arch/riscv/kernel/perf_regs.c         |  2 +-
>  arch/s390/kernel/perf_regs.c          |  2 +-

Perhaps split out the part where you modify the arch function interface?
