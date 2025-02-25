Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3D715B980;
	Tue, 25 Feb 2025 11:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740482293; cv=none; b=FYZVsOrCjzocNFmyEeaoTPB0WE453TavGn+suLJIU5RCr1JNnCmmfBHYFvaeIJtYMH29AVFgzcNmnnrQXvqKudMpx80B/w2uJvEK9p1t8f4x1ZqdaRVjPQQWm1woQH3J5FLKGryTUFF/pKxwZe6b/S/VDWelG7yV270Xnvfod0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740482293; c=relaxed/simple;
	bh=rS5A7G2PPNZ64d4wsZYQSjrh/llTleB0yD7V7HiWEOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CyXJycnPt5BowzedlSqqJD8so+hKjgSo4HhcSSD4vjIMUuZpfNWtXqWgKlAUFVeL1NrlVl41Hyio+TSi+E0ommwQSdx7mxVP2YV/dP9Uxee86DXPPALbtLTSKmHFtbQYx5XGD5MF1xfHRkwaB3IlVYme6hvqiyNH8ps47KfzG9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=EsTZvl69; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EsTZvl69"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=PG5kCQLkC4Qdt9FOaQJJ0ba0zTFUJgKo/opSo8xQitE=; b=EsTZvl69dRJtWaMQoshZ9unPem
	aZqIQoyY5z69yMu9hVoi+QvSDzlut1naIQEezFg81teH5p1nCtHTfrq6qLeu0jED0zb/dJFSY2DIz
	sCi/R0d1pj/GFcJS5DobEjs65pzdosDn2OCCuipWHmwmca7sjRKV6OkGgs5p2z9k+7tAkkZ3zYI9X
	jdJExG1EtmcKyo9CgIR1gk/i/Vctr2cGw0X2R14lIbzU3yUU1hGX3Zoiqk+WuNrf5pkX3cpk+MV5v
	b6j/BMp9T+zVzByZw5suLJkegEKCwWXT9LDWPX2w7xKVnlgyfciwdhd3/gniWmZU0KWB4hfRJwbSz
	5VwUvINw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tmsww-0000000B3IX-0CLx;
	Tue, 25 Feb 2025 11:18:06 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 568B8300472; Tue, 25 Feb 2025 12:18:05 +0100 (CET)
Date: Tue, 25 Feb 2025 12:18:05 +0100
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
Subject: Re: [Patch v2 12/24] perf/x86/intel: Allocate arch-PEBS buffer and
 initialize PEBS_BASE MSR
Message-ID: <20250225111805.GL11590@noisy.programming.kicks-ass.net>
References: <20250218152818.158614-1-dapeng1.mi@linux.intel.com>
 <20250218152818.158614-13-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218152818.158614-13-dapeng1.mi@linux.intel.com>

On Tue, Feb 18, 2025 at 03:28:06PM +0000, Dapeng Mi wrote:
> Arch-PEBS introduces a new MSR IA32_PEBS_BASE to store the arch-PEBS
> buffer physical address. This patch allocates arch-PEBS buffer and then
> initialize IA32_PEBS_BASE MSR with the buffer physical address.

Not loving how this patch obscures the whole DS area thing and naming.


> @@ -624,13 +604,18 @@ static int alloc_pebs_buffer(int cpu)
>  	int max, node = cpu_to_node(cpu);
>  	void *buffer, *insn_buff, *cea;
>  
> -	if (!x86_pmu.ds_pebs)
> +	if (!intel_pmu_has_pebs())
>  		return 0;
>  
> -	buffer = dsalloc_pages(bsiz, GFP_KERNEL, cpu);
> +	buffer = dsalloc_pages(bsiz, preemptible() ? GFP_KERNEL : GFP_ATOMIC, cpu);

But this plain smells bad, what is this about?

>  	if (unlikely(!buffer))
>  		return -ENOMEM;
>  
> +	if (x86_pmu.arch_pebs) {
> +		hwev->pebs_vaddr = buffer;
> +		return 0;
> +	}
> +
>  	/*
>  	 * HSW+ already provides us the eventing ip; no need to allocate this
>  	 * buffer then.
