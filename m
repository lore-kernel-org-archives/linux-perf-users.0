Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D787323770;
	Fri, 17 May 2024 10:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715940077; cv=none; b=alSFO4hipDNtNre7NTQ3bLlWNSUGwZiU9PIq+MEq4S0Gou4Y6cIAFFipIuXUdvXgkceAtCaR0iANc+YrfU72jRHcX8yXrC3IihpMJvPjCENC4zubpvz2asb0SjiLd8pSpt8jJHaVnZ0a4owwx0ATZtUYHdFGUvhizN9TbNeyBl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715940077; c=relaxed/simple;
	bh=DIGYKbma4xgmMvhulhhTVRwTtUsbtMcm/O0rYLgnZSc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e/cjGQY5OGyKG28CEO63r59oJGDLgOIIwhs2+fsyoN6QQXc8IIqhEkQum5gTzmoBPPZPQ3j3WMg22m1gFglql3/u/29b2QSKx7KPYOA4yP30hgSDbASs7GswV2KPCrlvQ9gZIS0tNFE695zWJAvyovaT/SZxtGzvd/lh7zgI9j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AA9C21424;
	Fri, 17 May 2024 03:01:31 -0700 (PDT)
Received: from [10.91.2.16] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D98DF3F762;
	Fri, 17 May 2024 03:01:04 -0700 (PDT)
Message-ID: <02bec885-5fd7-42dd-b85c-9547be7d3211@arm.com>
Date: Fri, 17 May 2024 12:01:02 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/17] coresight: Re-emit trace IDs when the sink changes
 in per-thread mode
To: Suzuki K Poulose <suzuki.poulose@arm.com>
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
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-perf-users@vger.kernel.org, gankulkarni@os.amperecomputing.com,
 scclevenger@os.amperecomputing.com, coresight@lists.linaro.org,
 mike.leach@linaro.org
References: <20240429152207.479221-1-james.clark@arm.com>
 <20240429152207.479221-18-james.clark@arm.com>
 <0d433917-f638-4ca6-ba6a-1d5e85895024@arm.com>
Content-Language: en-US
From: James Clark <james.clark@arm.com>
In-Reply-To: <0d433917-f638-4ca6-ba6a-1d5e85895024@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 07/05/2024 13:05, Suzuki K Poulose wrote:
> On 29/04/2024 16:22, James Clark wrote:
>> In per-cpu mode there are multiple aux buffers and each one has a
>> fixed sink, so the hw ID mappings which only need to be emitted once
>> for each buffer, even with the new per-sink trace ID pools.
>>
>> But in per-thread mode there is only a single buffer which can be
>> written to from any sink with now potentially overlapping trace IDs, so
>> hw ID mappings need to be re-emitted every time the sink changes.
>>
>> This will require a change in Perf to track this so it knows which
>> decode tree to use for each segment of the buffer. In theory it's also
>> possible to look at the CPU ID on the AUX records, but this is more
>> consistent with the existing system, and allows for correct decode using
>> either mechanism.
>>
>> Signed-off-by: James Clark <james.clark@arm.com>
>> ---
>>   drivers/hwtracing/coresight/coresight-etm-perf.c | 14 ++++++++++++++
>>   drivers/hwtracing/coresight/coresight-etm-perf.h |  2 ++
>>   2 files changed, 16 insertions(+)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c
>> b/drivers/hwtracing/coresight/coresight-etm-perf.c
>> index f07173aa4d66..08f3958f9367 100644
>> --- a/drivers/hwtracing/coresight/coresight-etm-perf.c
>> +++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
>> @@ -499,6 +499,20 @@ static void etm_event_start(struct perf_event
>> *event, int flags)
>>                         &sink->perf_id_map))
>>           goto fail_disable_path;
>>   +    /*
>> +     * In per-cpu mode there are multiple aux buffers and each one has a
>> +     * fixed sink, so the hw ID mappings which only need to be
>> emitted once
>> +     * for each buffer.
>> +     *
>> +     * But in per-thread mode there is only a single buffer which can be
>> +     * written to from any sink with potentially overlapping trace
>> IDs, so
>> +     * hw ID mappings need to be re-emitted every time the sink changes.
>> +     */
>> +    if (event->cpu == -1 && event_data->last_sink_hwid != sink) {
>> +        cpumask_clear(&event_data->aux_hwid_done);
>> +        event_data->last_sink_hwid = sink;
>> +    }
>> +
> 
> With the traceid caching in the event_data per-cpu , we could avoid this
> step ?
> 
> Suzuki
> 
> 

I don't think so, this is to inform the tool that the mappings have
changed if the tool doesn't want to follow switch events.

Unless I'm missing something, moving where the trace ids are stored
doesn't mean that they will be re-sent when the mappings change?
