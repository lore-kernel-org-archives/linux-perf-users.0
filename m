Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F56A7DA62;
	Mon, 27 Jan 2025 16:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737995219; cv=none; b=dc8aYhQZ1hCU5k8gXWIxXC6wiJ2pKdd99TSeR0pqFyHvk7lz5vuznJpfGJI4Ulp05EPHLcVOSBZAbpgzbr2sI4aQpnF4awGPNLsolWn3zGr6XqoTQboYWo6Vm06TZmsjsIh7ILutDBLy2C6phQbm8PiKmxlFyE3r1SHjDhM7UMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737995219; c=relaxed/simple;
	bh=RWjPntgqsKmrS3tYWGhkitFo3ueyhpggtfwaqHTWCwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m7ufgYPA9UQCsZOt0n59Y932qkquBPzWQAQ1A+pkHUvUMS9UcL/7NQuvUUUOYP20Gtm8ewvad6ynZ316tU8CQ0HAH8AunCB3N1NS3Q1bZvODPWmRaO5d6Xytv57CgwjDcGVQBwB115vnwdpwDBsohNjISz783MBSGY+F2Dl4wYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=d78LS2yd; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="d78LS2yd"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=K1SPi19Af5vYxPWbmomFrQfn4cShj4noETiNlX/t8a8=; b=d78LS2ydlEaFALXckUXeHV9grd
	rlxzwTP92m0KOjo+ZT9+YimpUHRi2SAjdi/k1UvPRXQw7ihrq/d4l88FnmJcAi2O05R0kEcmKOZ57
	g5/dIj56EF43W0tZKUMpezyBQE73JbwLR/MnPFul3UyqEyYRZ0pjngJlEPeIgKiPcUHwTmj3EqmgO
	q1Yr4ulEcxbNRMKlBi8jLNJpZlcqcTdsk7uDLndNCOgtK3t8MV2v241d9SDkjM0nqj3jXbkPg/ihA
	tNQJLuw1R6+bWKAUxtfyPbY4qmK/js7Q8TKQKQc6opQHbzKpFOn0+pInAPkzrUVeUnFCqesyxdTYv
	dfOr8XdQ==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tcRwq-00000009e2S-0OK2;
	Mon, 27 Jan 2025 16:26:52 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 5E6763004DE; Mon, 27 Jan 2025 17:26:51 +0100 (CET)
Date: Mon, 27 Jan 2025 17:26:51 +0100
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
Subject: Re: [PATCH 01/20] perf/x86/intel: Add PMU support for Clearwater
 Forest
Message-ID: <20250127162651.GL16742@noisy.programming.kicks-ass.net>
References: <20250123140721.2496639-1-dapeng1.mi@linux.intel.com>
 <20250123140721.2496639-2-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250123140721.2496639-2-dapeng1.mi@linux.intel.com>

On Thu, Jan 23, 2025 at 02:07:02PM +0000, Dapeng Mi wrote:
> From PMU's perspective, Clearwater Forest is similar to the previous
> generation Sierra Forest.
> 
> The key differences are the ARCH PEBS feature and the new added 3 fixed
> counters for topdown L1 metrics events.
> 
> The ARCH PEBS is supported in the following patches. This patch provides
> support for basic perfmon features and 3 new added fixed counters.
> 
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> ---
>  arch/x86/events/intel/core.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index b140c1473a9d..5e8521a54474 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -2220,6 +2220,18 @@ static struct extra_reg intel_cmt_extra_regs[] __read_mostly = {
>  	EVENT_EXTRA_END
>  };
>  
> +EVENT_ATTR_STR(topdown-fe-bound,       td_fe_bound_skt,        "event=0x9c,umask=0x01");
> +EVENT_ATTR_STR(topdown-retiring,       td_retiring_skt,        "event=0xc2,umask=0x02");
> +EVENT_ATTR_STR(topdown-be-bound,       td_be_bound_skt,        "event=0xa4,umask=0x02");
> +
> +static struct attribute *skt_events_attrs[] = {
> +	EVENT_PTR(td_fe_bound_skt),
> +	EVENT_PTR(td_retiring_skt),
> +	EVENT_PTR(td_bad_spec_cmt),
> +	EVENT_PTR(td_be_bound_skt),
> +	NULL,
> +};

The skt here is skymont, which is what Sierra Forest was based on, and
you just said that these counters are new with Darkmont, and as such the
lot should be called: dmt or whatever the proper trigraph is.

