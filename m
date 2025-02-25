Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85589267B14;
	Tue, 25 Feb 2025 11:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740484364; cv=none; b=pf/0kbrWp7ylkEZDn6A13t0VWml3amnFnTK459sCT/dezarSkZGl+gQcVpKruOpAVVdhTFrXZi873WzkAD7KQw1WnEw44j4un3VWJbiVX6i/7kDxLfqkxFgdywtzRVPN0YesmWj2Ch8/GLuJzepvWX1Y8MIKTxbhOm8Znewsf1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740484364; c=relaxed/simple;
	bh=Uq3JsbSWeE7bXtdd8QBhOL64aZ4wubBKzjD2kSi205M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A9vJJW8eravoSHolIsFk5VsKC9YRc/h0OvxbNN34TsuIU5MwyeUcKjT5SiGd1czqGr5AA61Bi7xPHSR88Ex/+KBR+5wrndPb5t3quxY+Y6DGA8T0+gX+tLWtMRbcHMyC5EziGpGS83tJk7aBgtFw3KN6BnvJ10mMX/iqtyrCSPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=E4g9jOPG; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="E4g9jOPG"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=xtFaTUHxKJW7L05UduUsh00omyWJq+zYzPlNt38BgYU=; b=E4g9jOPGyd04pwfl9laE3iJNLf
	+FsmykAK2A6R7XBn6LSr8pP2Q60kqJK6+3VHOO3GCclnui93cOV8Uwzonj81qSitzjUX9aPyfo1g1
	FbjvfVnweund0r7/4lgB5aS1bCPg+qroTDWAsZMerQ59OIeNKsaPVz3yrikvF5bIuaElQFcL2FCeq
	rXrER6zqKh8JCDObbhymDUBryUQ9q94xKJ/D9ATgxcN/erwMFumPJ0fennOSWl9LVOO1pwohBMMzd
	VFudRG/8vSoHFmGHWkNKPomTMq1n3tKX4tuxBGZktBYTTo+yXTruQFhU91p11HVqmUsqbABNxw3DW
	l5WGAqGw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tmtUE-00000003L0H-04Pt;
	Tue, 25 Feb 2025 11:52:30 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 4559A300472; Tue, 25 Feb 2025 12:52:29 +0100 (CET)
Date: Tue, 25 Feb 2025 12:52:29 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, Dapeng Mi <dapeng1.mi@intel.com>
Subject: Re: [Patch v2 15/24] perf/x86/intel: Add SSP register support for
 arch-PEBS
Message-ID: <20250225115229.GN11590@noisy.programming.kicks-ass.net>
References: <20250218152818.158614-1-dapeng1.mi@linux.intel.com>
 <20250218152818.158614-16-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218152818.158614-16-dapeng1.mi@linux.intel.com>

On Tue, Feb 18, 2025 at 03:28:09PM +0000, Dapeng Mi wrote:

> +	if (unlikely(event->attr.sample_regs_intr & BIT_ULL(PERF_REG_X86_SSP))) {
> +		/* Only arch-PEBS supports to capture SSP register. */
> +		if (!x86_pmu.arch_pebs || !event->attr.precise_ip)
> +			return -EINVAL;
> +	}

> @@ -27,9 +27,11 @@ enum perf_event_x86_regs {
>  	PERF_REG_X86_R13,
>  	PERF_REG_X86_R14,
>  	PERF_REG_X86_R15,
> +	/* Shadow stack pointer (SSP) present on Clearwater Forest and newer models. */
> +	PERF_REG_X86_SSP,

The first comment makes more sense. Nobody knows of cares what a
clearwater forest is, but ARCH-PEBS is something you can check.

Also, this hard implies that anything exposing ARCH-PEBS exposes
CET-SS. Does virt complicate this?
