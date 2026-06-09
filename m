Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E02442B726;
	Tue,  9 Jun 2026 14:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781016580; cv=none; b=qol1gKXtuSSizjYFSvy3jb5nQZp9ymVk6C7AnrM3HduE/r7mJs50Wdz860PqelUvsv07Sglpb6woRyKS2OTBLJ5WDgCUlxB8Wod2T6sd0SPRWGCo0lXOb5Oe9sZVrBX5Vnd026gWENABs71J8Yx07QCLnIJKxgg9pPFnqZk4i8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781016580; c=relaxed/simple;
	bh=2ewCUcI0flCYBaT4s4mcQNn2iJDvL75/thKr5TjX+AQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NHod9JYp8Nc49Ljir/FtnnzmtbKVH+BtntlEDZXqIwiF4Dr3yIBqFbwDDXRqXAKtvzdUBwL1VUC3DBSNsJqB1dvogwgxUvpMTKKoK9VmFQ7DbW3jZnH9SNRnYayHlqzQhCmKWOJMzbDKpCFQXy50c1ts5oCvhENvWb2QCWavE80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=omDM8BUS; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="omDM8BUS"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=8azqwIzrz4burRhjLAjxRI5rm1Ojsv3uZVbseUdmtYk=; b=omDM8BUS44ngqbX1NeOHM3Ksya
	J9m6tV6NhUVERSwxvBsNK+mE4vAoHlLnoP0RtMiQ1ECY9NrydfOVUY5kTtQ01lJ4PFqrRSfqzVkkz
	cav2wgA881lKdnH94tQkzHKBvB/W83Q2xCUdcrN55+fyuy59YVZ90BJdXgepvgTP/A46XVj9HNjLT
	S3vCbM4tjFDsP865OI83dUTIUvIp0899BEhUYANMLhGyTdYFP/WqpP5IL3MHq3OYtdlodxsD3oor+
	kZ83T1Q5/S/rWXik9/a/kwdx7rfxxwAIDYVHwyj2U2hBz6Wbxvq9C5iedY3VJZaxnMZJVqKQXYg7s
	0ojB4JPw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWxlm-0000000Fslv-1Vj9;
	Tue, 09 Jun 2026 14:49:34 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 552FA30025D; Tue, 09 Jun 2026 16:49:34 +0200 (CEST)
Date: Tue, 9 Jun 2026 16:49:34 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, Dapeng Mi <dapeng1.mi@intel.com>,
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Xudong Hao <xudong.hao@intel.com>
Subject: Re: [Patch v2 4/9] perf/x86/intel: Fallback to sw branch type
 decoding if no hw decoding
Message-ID: <20260609144934.GC49951@noisy.programming.kicks-ass.net>
References: <20260609050222.2458129-1-dapeng1.mi@linux.intel.com>
 <20260609050222.2458129-5-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260609050222.2458129-5-dapeng1.mi@linux.intel.com>

On Tue, Jun 09, 2026 at 01:02:17PM +0800, Dapeng Mi wrote:
> intel_pmu_lbr_filter() currently assumes Arch LBR provides hardware
> branch-type decoding and skips software decoding on that path.
> 
> However, Arch LBR may not always expose branch-type information. In
> that case, treating entries as hardware-decoded can misclassify sampled
> branches (for example, defaulting to JCC), which breaks branch-type
> filtering results.
> 
> Fix this by using software branch-type decoding when hardware
> branch-type decoding is unavailable (that is, when x86_lbr_type is not
> enabled). This keeps branch classification and filtering behavior
> correct across Arch LBR configurations.
> 
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> ---
>  arch/x86/events/intel/lbr.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
> index 72f2adcda7c6..d4c0ed85e1fb 100644
> --- a/arch/x86/events/intel/lbr.c
> +++ b/arch/x86/events/intel/lbr.c
> @@ -1232,6 +1232,7 @@ intel_pmu_lbr_filter(struct cpu_hw_events *cpuc)
>  		 * OTHER_BRANCH branch type still rely on software decoding.
>  		 */
>  		if (static_cpu_has(X86_FEATURE_ARCH_LBR) &&
> +		    static_branch_likely(&x86_lbr_type) &&
>  		    type <= ARCH_LBR_BR_TYPE_KNOWN_MAX) {
>  			to_plm = kernel_ip(to) ? X86_BR_KERNEL : X86_BR_USER;
>  			type = arch_lbr_br_type_map[type] | to_plm;

Now you have two static branches in concert. Best to make sure
x86_lbr_type covers both conditions, no?
