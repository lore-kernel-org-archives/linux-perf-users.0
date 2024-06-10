Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC2915A8;
	Mon, 10 Jun 2024 14:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718028314; cv=none; b=EY1PG1iSqqiRfdsG4etkuiNYS3O7CYw2RKsCEEdG0+6kmDEhO347bgn4pPBg0/Ai6NW7bwa96zxPBdaJkSDI+fjGTqi5j3VjSXn9w1eNMWl4YpHDUiTfnqDKDT89nEuvlrr8onXfcaUJICodCJ7fFNY3/IBsHPISbF2HOjlMrfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718028314; c=relaxed/simple;
	bh=cMr0Z4iLJPU4OKj2F6FbEhLlNCxwYw1FCX8zFi2Jo1M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j37UzrZMRxpQ6whENu8YcXPnMDKEOfA+hXb/KoUrhJ1Y3tYZflFBLTfPME3mvM4ne5IBfT76SfZ0VPLmiwW2JQ/8j+EoeAAy7z5IaA5TlccvPT968QjlVxYal0R+yJS+zjmbV7UGsn3Mc8i+vOLZgs98uRWo3Yi2QqLIR3C+yLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E5686106F;
	Mon, 10 Jun 2024 07:05:34 -0700 (PDT)
Received: from [10.57.42.97] (unknown [10.57.42.97])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3FEED3F73B;
	Mon, 10 Jun 2024 07:05:06 -0700 (PDT)
Message-ID: <56a60219-1440-425f-8680-8eaae2bb42c1@arm.com>
Date: Mon, 10 Jun 2024 15:05:04 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 15/16] coresight: Re-emit trace IDs when the sink
 changes in per-thread mode
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
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com, linux-perf-users@vger.kernel.org,
 coresight@lists.linaro.org, gankulkarni@os.amperecomputing.com,
 mike.leach@linaro.org, leo.yan@linux.dev, anshuman.khandual@arm.com
References: <20240604143030.519906-1-james.clark@arm.com>
 <20240604143030.519906-16-james.clark@arm.com>
 <a697111a-ec64-451a-aee1-3709bd08e73e@arm.com>
Content-Language: en-US
From: James Clark <james.clark@arm.com>
In-Reply-To: <a697111a-ec64-451a-aee1-3709bd08e73e@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 10/06/2024 11:29, Suzuki K Poulose wrote:
> On 04/06/2024 15:30, James Clark wrote:
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
>> index 17cafa1a7f18..b6f505b50e67 100644
>> --- a/drivers/hwtracing/coresight/coresight-etm-perf.c
>> +++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
>> @@ -499,6 +499,20 @@ static void etm_event_start(struct perf_event
>> *event, int flags)
>>                         &sink->perf_sink_id_map))
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
> 
> I am wondering if we really need this patch, as we have the sinkid in
> the HWID already ? We would emit the packet for each CPU only once and
> that wouldn't change the HWID ?
> 
> Suzuki
> 
> 

It would be needed for per-thread mode if we didn't have the CPU sample
bit set on AUX records. Because otherwise you wouldn't know when the
process had moved to a new sink with new mappings. But I suppose this is
redundant information now that the CPU bit is set on AUX records so I
can remove this.

I was thinking it might be nice if a tool _only_ wanted to look at HWIDs
then it could do the decode correctly with just that. If we remove this
then tools will always have to set the CPU sample bit, but it's pretty
much required anyway and Perf was already doing it.

James

