Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625103DA7C0;
	Fri, 29 May 2026 11:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780054983; cv=none; b=utgWQeskmJEuvs/TfkS/1Pr8L8L58YKJbCYtMYw7aBbRteMSAABMGRDulvDZTQwFUuq1RDbv0fHq5j5tE+SBjTYRh867y7Pjw4aGXhnAEDu3jngoWGcu+aWvmeamdbS1q6wV8BCyCH3lVX3m5jHUEeMZsB2WAvX3bqVXBSWWCzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780054983; c=relaxed/simple;
	bh=6Ps7LwcXzIsKFn2j7/JgWEaKTHuv9FOznRkKrzzV8AY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GYW7HZ3Hr/8rXIQZTFzUMNtWfTnQNrZZgi84yPSCDUUZQJcMsRJnKEri8IZc/OrYIl+oJrn0DT/CjDMVVTurqCSURTzVTDXVDKFcwAs9EaiFebAhW8UpWO24sYYRi8WhMQHVMlpxR5YY6Qj9Kp9KlGo6FEXUNc/IKILKxCo26IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dUZQatVB; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dUZQatVB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ZhkLQrU/HoIkRb8/otieVf5f5BohgCFjSbZmA01UB8M=; b=dUZQatVBE6vduaEwpVsppCnYQW
	OE567NSdgUAMFGb4uGkHOxvPmm7ux8UKdfgzpFNiSbmSLOjzflVL3gc7FLQFjL/JcomFVs3fq0wE7
	3Jm2Z1Il4KhTG6TcQA6II2GwMK9pHCbmDhLE2+FpwqpJpEXeZ+u3OzByM2T8lM8mhTFqfdZe3parW
	/WRcHtbWuUzh88QdONmJIGEG/UvDJHMtxZWWEU+64ruEiIvmyTXOzR/k+SnmMJwmvGr4/hxn0Gqs8
	zuwDPd1b5W2svBKmXXFvTYh+lXpW/Tg6TXl8uPenFr1Klq9QV3ahAJLaMX3IzCZmfX+PaWGibnz0g
	NhkN/CJg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSvc7-00000006323-2JJE;
	Fri, 29 May 2026 11:42:55 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 16BB530036F; Fri, 29 May 2026 13:42:55 +0200 (CEST)
Date: Fri, 29 May 2026 13:42:55 +0200
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
Subject: Re: [Patch v8 11/23] perf/x86: Enable XMM register sampling for
 REGS_USER case
Message-ID: <20260529114255.GL3493090@noisy.programming.kicks-ass.net>
References: <20260529075645.580362-1-dapeng1.mi@linux.intel.com>
 <20260529075645.580362-12-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260529075645.580362-12-dapeng1.mi@linux.intel.com>

On Fri, May 29, 2026 at 03:56:33PM +0800, Dapeng Mi wrote:
> This patch adds support for XMM register sampling in the REGS_USER case.
> 
> To handle simultaneous sampling of XMM registers for both REGS_INTR and
> REGS_USER cases, a per-CPU `x86_user_regs` is introduced to store
> REGS_USER-specific XMM registers. This prevents REGS_USER-specific XMM
> register data from being overwritten by REGS_INTR-specific data if they
> share the same `x86_perf_regs` structure.
> 
> To sample user-space XMM registers, the `x86_pmu_update_user_xregs()`
> helper function is added. It checks if the `TIF_NEED_FPU_LOAD` flag is
> set. If so, the user-space XMM register data can be directly retrieved
> from the cached task FPU state, as the corresponding hardware registers
> have been cleared or switched to kernel-space data. Otherwise, the data
> must be read from the hardware registers using the `xsaves` instruction.
> 
> For PEBS events, `x86_pmu_update_user_xregs()` checks if the PEBS-sampled
> XMM register data belongs to user-space. If so, no further action is
> needed. Otherwise, the user-space XMM register data needs to be
> re-sampled using the same method as for non-PEBS events.
> 
> Co-developed-by: Kan Liang <kan.liang@linux.intel.com>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Sashiko has fun comments; I don't think we care about the cross-vm data
leak, that's not worse than we already have on the regular regs. In
fact, it might be considered correct behaviour ;-)

It does have a point about noxsaves; or xsaves being masked by a VM.
