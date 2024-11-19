Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001411CC178;
	Tue, 19 Nov 2024 12:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732018832; cv=none; b=uz+LIJO6ae8kLgI5NCzvxBBKVDITY7yokoavhu3cZV9I6joKYt7T12hzntdF4jsVqu0DwAKmYNNPPwti9BWWpAQGzTXQL+tl+5OM/ia6ap+stgTWFmyJYlT9W5XdjERY05ZRFjxJU9ycMKRC8gj2nhD/LArPmf1wvCHJaFF+CX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732018832; c=relaxed/simple;
	bh=XyTqHUhZY4N6x5MdjjtRva1G3ecyBo4smINi26keHfM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CpJl5p5bKtsrEYTKcZQ3X4l5qIa2Yi2+vRpA6Fkup6cMAqw5cIS+pU8iHqSd9k64eUevsSiMYp4KN/Pc6OIiYOg7kPGQOA+H+ENgjiOtMF9X7yRX8ASjZyEWAynLQpDltVJQRPd5bQvyjlW/4cmnmc2EnVyOxo0NSOOjWxm/edY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UadMDcH3; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UadMDcH3"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=mAgmsyibCrflk0YoFAdZcVk08twsC/j0F67GQbMmSV4=; b=UadMDcH3UVFf5+XskhpAoWJY/n
	HSxZoirZ4f7rpKxNUBEmRJ+nYpAnT+xPFlKLIzMYQMBDe2cuJLULnpLevqhK5W0feixmyZl/kbnJ8
	IoUoM5wnuWqakS3RBGyxy4Jr7RjOD4nNrO31BlNWEEaeomB8wwP2nIrvpvU/19Uvebx+7I5IGRSYZ
	ABQX/NrQJCWA9sLjrBE94Vqm6lfKmG51kSdMNO5DHwdvwuP3v39WM24EByv6SpXnAmfIbqRUGF6c7
	7lVUQXAUAUxIiPS23RI4J7gqPxyIn1r0SexpaPghQO9HKFl/44ubKvwDGzkzEJt77HApe/UVKduav
	5r2pPdGw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tDNDR-000000043de-31gy;
	Tue, 19 Nov 2024 12:20:23 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id BECAC3006AB; Tue, 19 Nov 2024 13:20:21 +0100 (CET)
Date: Tue, 19 Nov 2024 13:20:21 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Cc: mingo@redhat.com, rui.zhang@intel.com, irogers@google.com,
	kan.liang@linux.intel.com, tglx@linutronix.de, bp@alien8.dei,
	gautham.shenoy@amd.com, kprateek.nayak@amd.com,
	ravi.bangoria@amd.com, x86@kernel.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 00/10] Add RAPL core energy counter support for AMD
 CPUs
Message-ID: <20241119122021.GE2328@noisy.programming.kicks-ass.net>
References: <20241115060805.447565-1-Dhananjay.Ugwekar@amd.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241115060805.447565-1-Dhananjay.Ugwekar@amd.com>

On Fri, Nov 15, 2024 at 06:07:56AM +0000, Dhananjay Ugwekar wrote:
> 
> Dhananjay Ugwekar (9):
>   perf/x86/rapl: Remove the unused get_rapl_pmu_cpumask() function
>   perf/x86/rapl: Remove the cpu_to_rapl_pmu() function
>   perf/x86/rapl: Rename rapl_pmu variables
>   perf/x86/rapl: Make rapl_model struct global
>   perf/x86/rapl: Add arguments to the init and cleanup functions
>   perf/x86/rapl: Modify the generic variable names to *_pkg*
>   perf/x86/rapl: Remove the global variable rapl_msrs
>   perf/x86/rapl: Move the cntr_mask to rapl_pmus struct
>   perf/x86/rapl: Add core energy counter support for AMD CPUs
> 
> K Prateek Nayak (1):
>   x86/topology: Introduce topology_logical_core_id()
> 
>  Documentation/arch/x86/topology.rst   |   4 +
>  arch/x86/events/rapl.c                | 414 ++++++++++++++++----------
>  arch/x86/include/asm/processor.h      |   1 +
>  arch/x86/include/asm/topology.h       |   1 +
>  arch/x86/kernel/cpu/debugfs.c         |   1 +
>  arch/x86/kernel/cpu/topology_common.c |   1 +
>  6 files changed, 272 insertions(+), 150 deletions(-)

Thanks, I'll stick them in a tree post -rc1.
