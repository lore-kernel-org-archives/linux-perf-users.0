Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1133D30C60E;
	Fri, 29 May 2026 10:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780052148; cv=none; b=PMquxTEMmhEHfx45UeSfrrHYxyKqYJGy5mHgQogCkcIxIYwQcCSYJsBfoYP8x5Z1p9xotykXXnJUzLoMjGxAdTItz6ygRUszwVCCGFjjO7MBM+qEAOFfTGJNwHgLJLassgb9k9q7K8BCFR4uhtYcPJUpMNnQgWnN4gLs+5iCzos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780052148; c=relaxed/simple;
	bh=X+p3oRA2Y3yWBL50Z++96T1nOJYyyiUMZTmVHarAoJM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jkFoilW1i2sb6VP9CSoIaknTm4n1JENjz3yGxv0XDntbQpXjF6dmwKDT3T2WPEbe3o2h1Pc+vzkCXfC8W6fZ94nU1UX69465htk8RVeb09yG3E80gP8c+1EH74Oi+qzQPTLAwmUqm6Nx6IFiuWDw3QhLSPHARm3kki5iDeO8FJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=f0FJnwAA; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="f0FJnwAA"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=MLL3kiGft0RqGa4AkWwNoDmYLs8z9w/6Ig5SzK6Tx4Q=; b=f0FJnwAAPAMIGZ2Sgx7fracZ0o
	CsFeWv7DObeW3XGnXrRNUhMUh9bwRqUR64xT4XN80YcbxYR818CaReuT7N7hDvLjEzRokZ4K7j8zF
	D7p0LBUnNqnI6swWCVYgpQyz1nriA1yInn+qjYIb5XOoRzph785ua2ElkY9gjyo8eX5KJQPnFAvmF
	9SxJ90jOxVPqT/zwA9t2Cjv4VPjwEx9Dq+1VwMZo5DQ+Lb7Dwk7YAqVT2QQHOjnuU7vHeyc05KCK2
	clXcKld7jn9a7+qRNO4UhD5ERzCNqKLKGh/o3fkTcW61ZPPOFHfLW3xWoFNUFRMK2RPmvgWwIEHt2
	zvVZWY6w==;
Received: from 2001-1c00-8d85-4b00-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:4b00:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSusN-00000005zGg-0cyh;
	Fri, 29 May 2026 10:55:39 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id D229C3003DE; Fri, 29 May 2026 12:55:37 +0200 (CEST)
Date: Fri, 29 May 2026 12:55:37 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
Cc: "Chen, Zide" <zide.chen@intel.com>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH V2 7/7] perf/x86/intel/uncore: Implement global init
 callback for GNR uncore
Message-ID: <20260529105537.GG3493090@noisy.programming.kicks-ass.net>
References: <20260527151154.130505-1-zide.chen@intel.com>
 <20260527151154.130505-7-zide.chen@intel.com>
 <507feaea-25fc-4111-a39b-648ce44e3316@linux.intel.com>
 <03ad940f-747b-432c-9dca-1be305ee5cc7@intel.com>
 <93acba88-3f6a-43dc-8392-63d977fb2dfa@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93acba88-3f6a-43dc-8392-63d977fb2dfa@linux.intel.com>

On Fri, May 29, 2026 at 04:47:39PM +0800, Mi, Dapeng wrote:
> 
> On 5/29/2026 2:14 AM, Chen, Zide wrote:
> >
> > On 5/28/2026 1:46 AM, Mi, Dapeng wrote:
> >> On 5/27/2026 11:11 PM, Zide Chen wrote:
> >>> On Sierra Forest and Clearwater Forest, the FRZ_ALL bit in the global
> >>> control register defaults to 0 at boot, but UBOX PMON units do not
> >>> work until the global control register is explicitly written with 0
> >>> to trigger hardware initialization properly.
> >>>
> >>> Implement the generic uncore_msr_global_init() callback and add it to
> >>> gnr_uncore_init[], which is shared by GNR, GRR, SRF, and CWF.
> >> Need a "Fixes" tag?
> > No Fixes tag needed. This is a hardware initialization workaround rather
> > than a fix for a software bug. The register defaults to 0, but the
> > hardware requires an explicit write to trigger PMON functionality.
> 
> Zide, per my understanding, some uncore PMUs can't work for SRF and CWF
> without this change. Is it right? If so, we need to add a "Fixes" tag to
> ensure this patch is merged to the corresponding stable branches. Thanks.

If you all agree on Fixes tags, then those patches that end up getting
one should be at the front of the series.

I was about to pick this up, but if you guys want to send a new series,
let me know and I'll hold off.
