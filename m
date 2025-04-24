Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4FC289367;
	Thu, 24 Apr 2025 16:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745512350; cv=none; b=UPt9bF0i0JfDecJtGo5bu3EzAkKQjdI6RTiJl6+TwIHLw+hhhVVvR0YqSLAfoQ5rHk357K+9TOaEGyoADCi86c0DsZCJLQiNC+cLF1cNBNaFTCg0d9viFE42gJJbY+f8hKONYi1f9f8lD6LtPcwINWDk2E9mnm6dGuMOqbra4ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745512350; c=relaxed/simple;
	bh=crmK5stkLj7y7az47xgNqwJmDewKuyc4LFzJ3dYKNpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KfE8y2g8jiIqSgP9lUwK9PMLlRB47D/xJF6cdGBvSAKgXWLbDr79I/T4p10uCqqRMt7M0dxW/Xd0xWQkysYjqcLPvRN89e+FtABN5VM8l2TBzajRvKQ0H1RxJVx9qZUtWg87sShavq3VKoL5TaIyJNdKuYnFEPX9PXJM8j9qhlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DpFcLo1G; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DpFcLo1G"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=oWXZlpIiKZRI63Qk8gO6/jmTtti+FwrrSl2SdIyCZCs=; b=DpFcLo1G9mYc1qxK9pQyFADh1e
	moq8gtG5x4S2KMdRRH31QVfa4nZFyPvKYZ1QtFnLUFPyVJGeMXAdfpwjks67HPHzho51v9ZnojIiT
	FEj47CXP0toO7ftrLaW4rWjy6iu8rTuSosM1Tr6fVRB6oser9vZgXnMnhBxcoVJWcrZZuDcAR/odo
	6zKjY003e5JJwhEf299cSwkiXrP//Cj0PIcNAZ3Uv+XUSEsXPB/ug0YKip2raiKtanFTc4SI1jmSH
	ZijHgEZqTH9eYQKpwn0PQo2CdxyY9Ied9JfH/ujKjilPyPQO74Yo5tiLnNnr79rkcyOTeGIglMFuI
	UtrwpODA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7zUs-0000000CqQW-1SGM;
	Thu, 24 Apr 2025 16:32:22 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id F0317300642; Thu, 24 Apr 2025 18:32:21 +0200 (CEST)
Date: Thu, 24 Apr 2025 18:32:21 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 3/4] perf: Remove too early and redundant CPU hotplug
 handling
Message-ID: <20250424163221.GD18306@noisy.programming.kicks-ass.net>
References: <20250424161128.29176-1-frederic@kernel.org>
 <20250424161128.29176-4-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250424161128.29176-4-frederic@kernel.org>

On Thu, Apr 24, 2025 at 06:11:27PM +0200, Frederic Weisbecker wrote:
> The CPU hotplug handlers are called twice: at prepare and online stage.
> 
> Their role is to:
> 
> 1) Enable/disable a CPU context. This is irrelevant and even buggy at
>    the prepare stage because the CPU is still offline. On early
>    secondary CPU up, creating an event attached to that CPU might
>    silently fail because the CPU context is observed as online but the
>    context installation's IPI failure is ignored.
> 
> 2) Update the scope cpumasks and re-migrate the events accordingly in
>    the CPU down case. This is irrelevant at the prepare stage.
> 
> 3) Remove the events attached to the context of the offlining CPU. It
>    even uses an (unnecessary) IPI for it. This is also irrelevant at the
>    prepare stage.
> 
> Also none of the *_PREPARE and *_STARTING architecture perf related CPU
> hotplug callbacks rely on CPUHP_PERF_PREPARE.
> 
> CPUHP_AP_PERF_ONLINE is enough and the right place to perform the work.

Oh hey, that's curious indeed.

> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>  include/linux/cpuhotplug.h | 1 -
>  kernel/cpu.c               | 5 -----
>  2 files changed, 6 deletions(-)
> 
> diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
> index 1987400000b4..df366ee15456 100644
> --- a/include/linux/cpuhotplug.h
> +++ b/include/linux/cpuhotplug.h
> @@ -60,7 +60,6 @@ enum cpuhp_state {
>  	/* PREPARE section invoked on a control CPU */
>  	CPUHP_OFFLINE = 0,
>  	CPUHP_CREATE_THREADS,
> -	CPUHP_PERF_PREPARE,
>  	CPUHP_PERF_X86_PREPARE,
>  	CPUHP_PERF_X86_AMD_UNCORE_PREP,
>  	CPUHP_PERF_POWER,
> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index b08bb34b1718..a59e009e0be4 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -2069,11 +2069,6 @@ static struct cpuhp_step cpuhp_hp_states[] = {
>  		.teardown.single	= NULL,
>  		.cant_stop		= true,
>  	},
> -	[CPUHP_PERF_PREPARE] = {
> -		.name			= "perf:prepare",
> -		.startup.single		= perf_event_init_cpu,
> -		.teardown.single	= perf_event_exit_cpu,
> -	},
>  	[CPUHP_RANDOM_PREPARE] = {
>  		.name			= "random:prepare",
>  		.startup.single		= random_prepare_cpu,
> -- 
> 2.48.1
> 
