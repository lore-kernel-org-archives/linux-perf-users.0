Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793624175;
	b=HeNE5MCwEz9pvIrN9QGvlar1jM82ogDZSQvZXwyviseJPYh8Oaj1l1m6nqXC0U+zWoJA
	 Cd1q9NtDByUj/1x/doLMWogjfz6RXSm11inxfosG+85dTKPxFH1O9E4LLw6Wf8kOyIX+U
	 HbAf+Qw68zXwzO6p5YR01yVskEBqW11XJHgsKM4JdTutL9avunWRR1YWTkt2rRdfDwjIQ
	 S1XnYx0m5VS0xTg1dVzrb++95KUbmBEE9OF8Tc/UgGUOCJ1A1knmx+VF7MpPJHNFxVdM6
	 EkBxECtQbzHU9ylYvLR64UMtdYkiHici6lDt3XMlKPP5W0UwaNRsj3sltGsMNXiOVCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793624175;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=7feqypzkFTwtbPgjElm3kiRnEaQuqXiolkniaWY6h6I=;
	b=sKvXDHDuea9/TFF3TbIb6whAKTYaNunbXnnLmj1eoJqYU4srJnhpvukrgaKl5o+duJVS
	 f7ql1rhQbgDjLlZWpJewPFxYPbcIBj9llz/SWS5X7X01DANFkC34HAUrDdXjqMTGRHhaf
	 JAm7t9ArPQTYht6KIQEKprtl3dn4l/gZkVKfVfdWvTVdvSUZKDdcyYcWIqPtG81bT/C/j
	 S63oNxGUXrEP10vW4zEiIUJWxg05u7L01M2h6mLuTfcHz8ekd4BTzSHCI4sb0DSyXLROX
	 K12Wd7gI1w8MHLHpE/mJ4HT1U8CymrvmiG26r2kN/Jdwo2WGF5TOMIaFQI+tvNNEmtg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=LA0PZhnd;
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A76606A324;
	Mon,  2 Nov 2026 12:56:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63A76606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=LA0PZhnd
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=7feqypzkFTwtbPgjElm3kiRnEaQuqXiolkniaWY6h6I=; b=LA0PZhnd9MuswtIu5dz1vi85Ch
	L4dU4YPzzP5WZmNsKcKb6XHsbtDgxxvyx7PbKknKrQ/6P5L0MPkjEEz/0+4jpvOAGzCn0jqlsA53y
	yaItw88PQIt4P+ZYBvy4ociph6v26quANqeqRybaZ4z5/IalgA3VS9pQOBCbG1J8YIQeWMjE68fOh
	73fIaujDBmP9yiHlUtuDDVlPONzwTtepTwpTFN02e0ggL2uzkVG6FjIt0HzVBzV+/tqDoK61UdH4q
	DdDRiGnKndmafr0YeYVL3ciK2xlbw0sCUpAkkpC5aVKjfhJqEOgl3lrKnZK/tdLKnMuypteiEhd3c
	6nRsfOpA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNrZg-00000002Wga-3uwY;
	Mon, 02 Nov 2026 12:55:51 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 2C2BC300322; Mon, 02 Nov 2026 13:55:43 +0100 (CET)
Date: Mon, 2 Nov 2026 13:55:43 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Sandipan Das <sandipan.das@amd.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Ananth Narayan <ananth.narayan@amd.com>
Subject: Re: [PATCH] perf/x86/amd/uncore: Avoid context migration from
 non-owners
Message-ID: <20261102125543.GH1813469@noisy.programming.kicks-ass.net>
References: <273135a6d33a40f442fb18e140a90689fae7cd32.1793614726.git.sandipan.das@amd.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <273135a6d33a40f442fb18e140a90689fae7cd32.1793614726.git.sandipan.das@amd.com>

On Mon, Nov 02, 2026 at 03:52:07PM +0530, Sandipan Das wrote:
> Each uncore context is owned by a single CPU that hosts all events for
> the corresponding uncore domain and is advertised through the sysfs
> cpumask attribute. When a CPU goes offline, the context is migrated to
> an online sibling if the departing CPU is the owner.
> 
> Before commit d6389d3ccc13 ("perf/x86/amd/uncore: Refactor uncore
> management"), uncore_down_prepare() checked whether the CPU going
> offline owned the context. The check was lost when the function was
> replaced by amd_uncore_ctx_move(). Hence, when a CPU that is not the
> owner goes offline, ownership is always handed over to the first online
> sibling in the uncore domain irrespective of whether another sibling
> already owns it. This goes unnoticed as long as the owner is the
> lowest-numbered online CPU in the domain, since the first online
> sibling is then the owner itself. Once ownership has moved, that no
> longer holds.
> 
> For example, consider an L3 domain spanning CPUs 8-15,136-143 and owned
> by CPU 8.
> 
>   $ cat /sys/bus/event_source/devices/amd_l3/cpumask
>   0,8,16,24,32,40,48,56,64,72,80,88,96,104,112,120
> 
>   $ echo 0 | sudo tee /sys/devices/system/cpu/cpu8/online
>   $ cat /sys/bus/event_source/devices/amd_l3/cpumask
>   0,9,16,24,32,40,48,56,64,72,80,88,96,104,112,120
> 
>   $ echo 1 | sudo tee /sys/devices/system/cpu/cpu8/online
>   $ cat /sys/bus/event_source/devices/amd_l3/cpumask
>   0,9,16,24,32,40,48,56,64,72,80,88,96,104,112,120
> 
>   $ echo 0 | sudo tee /sys/devices/system/cpu/cpu10/online
>   $ cat /sys/bus/event_source/devices/amd_l3/cpumask
>   0,8-9,16,24,32,40,48,56,64,72,80,88,96,104,112,120
> 
> Offlining CPU 8 correctly moves ownership to CPU 9 and onlining it
> again leaves CPU 9 as the owner. However, offlining CPU 10 then makes
> CPU 8 the owner while existing events remain on CPU 9. Both CPUs are
> now advertised for the same domain, so tools that open an event on
> every CPU in the cpumask count the domain twice, and the context gets
> modified from two CPUs without any synchronization.
> 
> Restore the ownership check that was lost during the refactor.
> 
> Fixes: d6389d3ccc13 ("perf/x86/amd/uncore: Refactor uncore management")
> Signed-off-by: Sandipan Das <sandipan.das@amd.com>
> ---
>  arch/x86/events/amd/uncore.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
> index 7aa5a5b652a2..c307323f6390 100644
> --- a/arch/x86/events/amd/uncore.c
> +++ b/arch/x86/events/amd/uncore.c
> @@ -595,7 +595,7 @@ static void amd_uncore_ctx_move(struct amd_uncore *uncore, unsigned int cpu)
>  	for (i = 0; i < uncore->num_pmus; i++) {
>  		pmu = &uncore->pmus[i];
>  		curr = *per_cpu_ptr(pmu->ctx, cpu);
> -		if (!curr)
> +		if (!curr || curr->cpu != cpu)
>  			continue;
>  
>  		/* Migrate to a shared sibling if possible */

Now, I see the Intel stuff cancels the hrtimer here; but AFAICT the AMD
bits tie the hrtimer to the ctx, and when the ctx goes empty -- due to
__perf_pmu_remove() it will get stopped there, right?
