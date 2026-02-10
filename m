Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960AD32D438;
	Tue, 10 Feb 2026 18:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770748828; cv=none; b=PHC8j6RfWx+9qcEW3Q3wx9MK8SOjxDB2VhNCmVuJ/ZSdP8K4KtNDkDfYpF2dGCdlDuDzMTTJD67cnOGKCyMdl+l8cD5iTkvqv1iXxJFXALefYA2e6HN/OCPtqvLVba3IT8xPPpDvw7cGPuiH77GSHQlBs0XcnxWdiCOALnFzROM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770748828; c=relaxed/simple;
	bh=cKjLBMvna5XFNi4DtmbHgmSsGOjCXHCfz85JNbtOlt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kSnlslf/FitRWN+PzMY6cch16NCqidu7gML/fQMVGS8gNKGhgYmqmjObTelkEmWaywbkHD++QG1XrX2Qh33VydXHHTp0efk6S6ckfbimQiUctqwLlYXtRu8HuiaQ78BPeXj1mDiT+DziKccrgeuFl1MIa4W5CLoEX0ZM4yOCVnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nY5T7npR; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nY5T7npR"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=P18BdS0PR7UFMaGrmThIFgBJHkBfdTDBL7ZE6GIX/K0=; b=nY5T7npRR4q2pL13/4C+dXesrN
	vzSCzBbqA7kNM9oZ5ZLJaFp0fpqWjquHhDU1jZ11apxdsDIR2LEWZgjM2065A89H444B4qsyn8IUC
	hg+HmhGwh/RTiZxsMYE0W29WOHN72A3zH8TkrNC/fllca5waYI3J4zHTXMAAHOdpr9GXAiKdHccuR
	LdcI7U+l/aESmUB7ULz38Gw89g9TL85Bp1z3p3seA1+78B1tMtLYamYxed+aSUiKhNlxywpiQaZkb
	FVjFGB0P2O1KsQJa3mikXWTkJc34Jx5kKi3NWV+6wVDjka4qTvMHEIdgRnEBTY9HAKKZOYfmGR+VA
	X0O6zxww==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vpsen-00000008mYz-21d8;
	Tue, 10 Feb 2026 18:40:17 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 4D193300754; Tue, 10 Feb 2026 19:40:16 +0100 (CET)
Date: Tue, 10 Feb 2026 19:40:16 +0100
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
Subject: Re: [Patch v6 05/22] perf/x86: Use x86_perf_regs in the x86 nmi
 handler
Message-ID: <20260210184016.GP2995752@noisy.programming.kicks-ass.net>
References: <20260209072047.2180332-1-dapeng1.mi@linux.intel.com>
 <20260209072047.2180332-6-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260209072047.2180332-6-dapeng1.mi@linux.intel.com>

On Mon, Feb 09, 2026 at 03:20:30PM +0800, Dapeng Mi wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> More and more regs will be supported in the overflow, e.g., more vector
> registers, SSP, etc. The generic pt_regs struct cannot store all of
> them. Use a X86 specific x86_perf_regs instead.
> 
> The struct pt_regs *regs is still passed to x86_pmu_handle_irq(). There
> is no functional change for the existing code.
> 
> AMD IBS's NMI handler doesn't utilize the static call
> x86_pmu_handle_irq(). The x86_perf_regs struct doesn't apply to the AMD
> IBS. It can be added separately later when AMD IBS supports more regs.
> 
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> ---
>  arch/x86/events/core.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index 6df73e8398cd..8c80d22864d8 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -1785,6 +1785,7 @@ EXPORT_SYMBOL_FOR_KVM(perf_put_guest_lvtpc);
>  static int
>  perf_event_nmi_handler(unsigned int cmd, struct pt_regs *regs)
>  {
> +	struct x86_perf_regs x86_regs;
>  	u64 start_clock;

So a few patches ago you pulled this off stack because too large, and
then here you stick it on stack again.

That is a wee bit inconsistent.

Furthermore, I think you can re-purpose that same off-stack copy. After
all, the pebs_drain thing can only happen:

 - from NMI (like here);
 - from context switch, when PMU is disabled (and thus no NMIs).
