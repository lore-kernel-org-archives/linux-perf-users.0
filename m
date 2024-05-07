Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395994A12;
	Tue,  7 May 2024 04:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715055978; cv=none; b=lAyEDkMnoksNVWlA8L+ULlS7L9+wCZXWXmuRZBjUXPuFO6MzRlQ83bM18LaNBlji2WmLV1PssUzRZwe+dWUkQZt0Rwa93Fu3TsDB50P3LuPkjTE+ML9Z4Z5z24UsAYibjd+W+hbyyGW92SpJmU9lG0ah6HSLiVQOZwyyjOXtSZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715055978; c=relaxed/simple;
	bh=pSBUf1dK/6EsyOZ7Wud4+U1Sfmzs2Lcwsbd1Oxjjb8c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZVDBA66cyhwcDGReUUrMbTxusYDHYARW16UKSwgVPMvvTMy3ai0uOdZaTg/EjWLa8o8ci28wDyawKZotuu5YzPInxrlPKfDwkcHMPFdU20aHeY9hnJZ9t2YuyF0I8FGFGUaVYsSPd6X6QwK2eVeBDSkxIxIRtnenBsxPZTR6vrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AB28D1042;
	Mon,  6 May 2024 21:26:42 -0700 (PDT)
Received: from [10.163.33.37] (unknown [10.163.33.37])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7AD963F762;
	Mon,  6 May 2024 21:26:08 -0700 (PDT)
Message-ID: <9896e877-276e-4c43-9368-f13cf7f2b25d@arm.com>
Date: Tue, 7 May 2024 09:56:13 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/17] perf auxtrace: Allow number of queues to be
 specified
Content-Language: en-US
To: James Clark <james.clark@arm.com>, linux-perf-users@vger.kernel.org,
 gankulkarni@os.amperecomputing.com, scclevenger@os.amperecomputing.com,
 coresight@lists.linaro.org, suzuki.poulose@arm.com, mike.leach@linaro.org
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, John Garry
 <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
 Leo Yan <leo.yan@linux.dev>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com
References: <20240429152207.479221-1-james.clark@arm.com>
 <20240429152207.479221-3-james.clark@arm.com>
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20240429152207.479221-3-james.clark@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/29/24 20:51, James Clark wrote:
> Currently it's only possible to initialize with the default number of
> queues and then use auxtrace_queues__add_event() to grow the array. But
> that's problematic if you don't have a real event to pass into that
> function yet.
> 
> The queues hold a void *priv member to store custom state, and for
> Coresight we want to create decoders upfront before receiving data, so
> add a new function that allows pre-allocating queues. One reason to do
> this is because we might need to store metadata (HW_ID events) that
> effects other queues, but never actually receive auxtrace data on that
> queue.
> 
> Signed-off-by: James Clark <james.clark@arm.com>

LGTM

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

> ---
>  tools/perf/util/auxtrace.c | 9 +++++++--
>  tools/perf/util/auxtrace.h | 1 +
>  2 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
> index 3684e6009b63..563b6c4fca31 100644
> --- a/tools/perf/util/auxtrace.c
> +++ b/tools/perf/util/auxtrace.c
> @@ -218,15 +218,20 @@ static struct auxtrace_queue *auxtrace_alloc_queue_array(unsigned int nr_queues)
>  	return queue_array;
>  }
>  
> -int auxtrace_queues__init(struct auxtrace_queues *queues)
> +int auxtrace_queues__init_nr(struct auxtrace_queues *queues, int nr_queues)
>  {
> -	queues->nr_queues = AUXTRACE_INIT_NR_QUEUES;
> +	queues->nr_queues = nr_queues;
>  	queues->queue_array = auxtrace_alloc_queue_array(queues->nr_queues);
>  	if (!queues->queue_array)
>  		return -ENOMEM;
>  	return 0;
>  }
>  
> +int auxtrace_queues__init(struct auxtrace_queues *queues)
> +{
> +	return auxtrace_queues__init_nr(queues, AUXTRACE_INIT_NR_QUEUES);
> +}
> +
>  static int auxtrace_queues__grow(struct auxtrace_queues *queues,
>  				 unsigned int new_nr_queues)
>  {
> diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
> index 55702215a82d..8a6ec9565835 100644
> --- a/tools/perf/util/auxtrace.h
> +++ b/tools/perf/util/auxtrace.h
> @@ -521,6 +521,7 @@ int auxtrace_mmap__read_snapshot(struct mmap *map,
>  				 struct perf_tool *tool, process_auxtrace_t fn,
>  				 size_t snapshot_size);
>  
> +int auxtrace_queues__init_nr(struct auxtrace_queues *queues, int nr_queues);
>  int auxtrace_queues__init(struct auxtrace_queues *queues);
>  int auxtrace_queues__add_event(struct auxtrace_queues *queues,
>  			       struct perf_session *session,
