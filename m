Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B258DAD5D;
	Tue,  7 May 2024 11:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715079951; cv=none; b=FD4Mdr4vqwL3orfo1fk9d55CCrTTKEvBRVMYuGIqwlKVz2kGhmmMUDeqHBRkWXZEopNdw7R9PGs2mWR4qdaQMCNHC8/MK7fPtuBkj8kjav7LLAk02HbE4jGAz35WAglkkRq5guU/O7WcluPZqykBtIzMz6IiHeXmg0/oeuGwstg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715079951; c=relaxed/simple;
	bh=vBaCcJ5JJ3DWlgDYYKqw/OHbVKxZn9vOtoPAl8vKR84=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AT5WjQCzoM9lgj2cDjyTYKZj+mu42lIWXteQvHfyUvdxnp6XN+K4FUclrMWXoboiLfThBNonhYSYAqRu0HJ+8G130+EkzKlkv2YFsOxQF5qUSM0iW8cY1cpew7WB9zg2AlnFWs2Xmb4UJ1tNGKWhEP27M+3OKqioedA1ZOkeyRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D9D1D1063;
	Tue,  7 May 2024 04:06:14 -0700 (PDT)
Received: from [10.1.197.1] (ewhatever.cambridge.arm.com [10.1.197.1])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 41DA83F587;
	Tue,  7 May 2024 04:05:46 -0700 (PDT)
Message-ID: <0d433917-f638-4ca6-ba6a-1d5e85895024@arm.com>
Date: Tue, 7 May 2024 12:05:44 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/17] coresight: Re-emit trace IDs when the sink changes
 in per-thread mode
To: James Clark <james.clark@arm.com>, linux-perf-users@vger.kernel.org,
 gankulkarni@os.amperecomputing.com, scclevenger@os.amperecomputing.com,
 coresight@lists.linaro.org, mike.leach@linaro.org
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
 <20240429152207.479221-18-james.clark@arm.com>
Content-Language: en-US
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20240429152207.479221-18-james.clark@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29/04/2024 16:22, James Clark wrote:
> In per-cpu mode there are multiple aux buffers and each one has a
> fixed sink, so the hw ID mappings which only need to be emitted once
> for each buffer, even with the new per-sink trace ID pools.
> 
> But in per-thread mode there is only a single buffer which can be
> written to from any sink with now potentially overlapping trace IDs, so
> hw ID mappings need to be re-emitted every time the sink changes.
> 
> This will require a change in Perf to track this so it knows which
> decode tree to use for each segment of the buffer. In theory it's also
> possible to look at the CPU ID on the AUX records, but this is more
> consistent with the existing system, and allows for correct decode using
> either mechanism.
> 
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>   drivers/hwtracing/coresight/coresight-etm-perf.c | 14 ++++++++++++++
>   drivers/hwtracing/coresight/coresight-etm-perf.h |  2 ++
>   2 files changed, 16 insertions(+)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
> index f07173aa4d66..08f3958f9367 100644
> --- a/drivers/hwtracing/coresight/coresight-etm-perf.c
> +++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
> @@ -499,6 +499,20 @@ static void etm_event_start(struct perf_event *event, int flags)
>   				      &sink->perf_id_map))
>   		goto fail_disable_path;
>   
> +	/*
> +	 * In per-cpu mode there are multiple aux buffers and each one has a
> +	 * fixed sink, so the hw ID mappings which only need to be emitted once
> +	 * for each buffer.
> +	 *
> +	 * But in per-thread mode there is only a single buffer which can be
> +	 * written to from any sink with potentially overlapping trace IDs, so
> +	 * hw ID mappings need to be re-emitted every time the sink changes.
> +	 */
> +	if (event->cpu == -1 && event_data->last_sink_hwid != sink) {
> +		cpumask_clear(&event_data->aux_hwid_done);
> +		event_data->last_sink_hwid = sink;
> +	}
> +

With the traceid caching in the event_data per-cpu , we could avoid this 
step ?

Suzuki

