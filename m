Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD55364BE;
	Fri, 17 May 2024 10:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715942749; cv=none; b=hpgeJR1Vu8/2gXlElHIMxafXpB+xgnYefcm7Ocso8/seUJ5aQ4LBNfjEEy2o+BLlWE1CBlRGYMRz/4veTkiwMBFgAErhXuuj6NTB0zDqZvDmEtBWseTzwL3IUk4ITrjwViBknHcB6dC70/D/YjsChU5RQbdvUv3EMHyGVBG6sog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715942749; c=relaxed/simple;
	bh=C8v1h21ZRXXxONXZxQQk5g6d1cPj0Ob1g3zhUbkap3Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U6GyxtVSAKFDsBsX2gMH0FdC16NuHyMCWiQrVXGh2CvPEu51khX6g7SxG7wIf0ia2I7rf5I01NzkOSVDVkyblwPAHtevrqHtM+UCkOono7I7oaYDFdwIpkYJnLkGBE1Pc+Bakb3g2KvgQ5Cj7VNh5+hD3CyrrQQUS22xHVNnU1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E28001424;
	Fri, 17 May 2024 03:46:09 -0700 (PDT)
Received: from [10.91.2.16] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F2BCB3F762;
	Fri, 17 May 2024 03:45:42 -0700 (PDT)
Message-ID: <05c0c55c-5758-408b-a0d5-6d535cec3f7b@arm.com>
Date: Fri, 17 May 2024 12:45:41 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/17] coresight: Use per-sink trace ID maps for Perf
 sessions
To: Mike Leach <mike.leach@linaro.org>
Cc: linux-perf-users@vger.kernel.org, gankulkarni@os.amperecomputing.com,
 scclevenger@os.amperecomputing.com, coresight@lists.linaro.org,
 suzuki.poulose@arm.com,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
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
 <CAJ9a7Vi7P3kBG5x_JC6AxDL-AvPc5=48eEC0gH3CHceVtSNmOQ@mail.gmail.com>
Content-Language: en-US
From: James Clark <james.clark@arm.com>
In-Reply-To: <CAJ9a7Vi7P3kBG5x_JC6AxDL-AvPc5=48eEC0gH3CHceVtSNmOQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 03/05/2024 14:40, Mike Leach wrote:
> Hi James
> 
> On Mon, 29 Apr 2024 at 16:23, James Clark <james.clark@arm.com> wrote:
>>
>> This will allow sessions with more than CORESIGHT_TRACE_IDS_MAX ETMs
>> as long as there are fewer than that many ETMs connected to each sink.
>>
>> Each sink owns its own trace ID map, and any Perf session connecting to
>> that sink will allocate from it, even if the sink is currently in use by
>> other users. This is similar to the existing behavior where the dynamic
>> trace IDs are constant as long as there is any concurrent Perf session
>> active. It's not completely optimal because slightly more IDs will be
>> used than necessary, but the optimal solution involves tracking the PIDs
>> of each session and allocating ID maps based on the session owner. This
>> is difficult to do with the combination of per-thread and per-cpu modes
>> and some scheduling issues. The complexity of this isn't likely to worth
>> it because even with multiple users they'd just see a difference in the
>> ordering of ID allocations rather than hitting any limits (unless the
>> hardware does have too many ETMs connected to one sink).
>>
>> Per-thread mode works but only until there are any overlapping IDs, at
>> which point Perf will error out. Both per-thread mode and sysfs mode are
>> left to future changes, but both can be added on top of this initial
>> implementation and only sysfs mode requires further driver changes.
>>
>> The HW_ID version field hasn't been bumped in order to not break Perf
>> which already has an error condition for other values of that field.
>> Instead a new minor version has been added which signifies that there
>> are new fields but the old fields are backwards compatible.
>>
> 
> Looking at this overall - would it not be better to introduce the
> concept of a "sink ID" to allow the detection of multiple sources into
> the single sink that is now done by emitting multiple AUX_HWID packets
> with the CPU+ID extra data?

I think it's worth trying so I'll give it a go and see if it ends up
being cleaner. One of the reasons for emitting multiple packets was to
tie events and sinks together that may not have been created when the
first set of HW_IDs were output. It seems like static sink IDs could
solve this with less repetition.

> This sink ID could be part of the sink csdev struct - or even the
> id_map struct - a simple count of sinks as the per sink maps are
> created would be sufficient. If this sink ID replaced the CPU+ID extra

We could also use the existing sink IDs that are used to select the sink
on the perf commandline: coresight_get_sink_by_id().

> data in the HWID packets, then each packet could be emitted just once,
> and perf can then collate based on the sink id.
> 
> Moreover, once we are ready to address the per-thread issues - then
> the overlap would not matter. Generate OpenCSD decode trees per sink
> ID, add docoders to the tree per Trace ID. Thus if a buffer has data
> from sink 1 trace id 5, ans sink 2, trace ID 5, then pick the right
> decoder for the combo.

The issue is more about trace in a single buffer with overlapping IDs.
Whether we use a sink ID or the CPU+ID mappings, Perf still needs to
know when to change the tree. In either case we'd have to re-emit the
mappings to prompt the decoder change.

So yes with either solution there would be multiple decode trees, it's
just knowing which fragments to send to which tree that's the issue.

> 
> Finally in systems with ETE+TRBE were there is no use of trace IDs, a
> sink ID of 0x0 could potentially indicate that 1:1 relationship.
> 

This is already indicated with the PERF_AUX_FLAG_CORESIGHT_FORMAT_RAW
flag on the AUX record. But I suppose we could add sink ID 0x0 as well
for consistency with the new HW_ID packets. For backwards compatibility
it probably makes sense to continue using the AUX flag in Perf, but I'll
see how it looks with the sink ID implementation.

James

> Regards
> 
> Mike
> 
>>
>> James Clark (17):
>>   perf cs-etm: Print error for new PERF_RECORD_AUX_OUTPUT_HW_ID versions
>>   perf auxtrace: Allow number of queues to be specified
>>   perf: cs-etm: Create decoders after both AUX and HW_ID search passes
>>   perf: cs-etm: Allocate queues for all CPUs
>>   perf: cs-etm: Move traceid_list to each queue
>>   perf: cs-etm: Create decoders based on the trace ID mappings
>>   perf: cs-etm: Support version 0.1 of HW_ID packets
>>   coresight: Remove unused stubs
>>   coresight: Clarify comments around the PID of the sink owner
>>   coresight: Move struct coresight_trace_id_map to common header
>>   coresight: Expose map argument in trace ID API
>>   coresight: Make CPU id map a property of a trace ID map
>>   coresight: Pass trace ID map into source enable
>>   coresight: Use per-sink trace ID maps for Perf sessions
>>   coresight: Remove pending trace ID release mechanism
>>   coresight: Re-emit trace IDs when the sink changes in per-thread mode
>>   coresight: Emit HW_IDs for all ETMs that are using the sink
>>
>>  drivers/hwtracing/coresight/coresight-core.c  |  10 +
>>  drivers/hwtracing/coresight/coresight-dummy.c |   3 +-
>>  .../hwtracing/coresight/coresight-etm-perf.c  |  82 ++-
>>  .../hwtracing/coresight/coresight-etm-perf.h  |  20 +-
>>  .../coresight/coresight-etm3x-core.c          |  14 +-
>>  .../coresight/coresight-etm4x-core.c          |  14 +-
>>  drivers/hwtracing/coresight/coresight-stm.c   |   3 +-
>>  drivers/hwtracing/coresight/coresight-sysfs.c |   3 +-
>>  .../hwtracing/coresight/coresight-tmc-etr.c   |   5 +-
>>  drivers/hwtracing/coresight/coresight-tmc.h   |   5 +-
>>  drivers/hwtracing/coresight/coresight-tpdm.c  |   3 +-
>>  .../hwtracing/coresight/coresight-trace-id.c  | 107 +--
>>  .../hwtracing/coresight/coresight-trace-id.h  |  57 +-
>>  include/linux/coresight-pmu.h                 |  17 +-
>>  include/linux/coresight.h                     |  20 +-
>>  tools/include/linux/coresight-pmu.h           |  17 +-
>>  tools/perf/util/auxtrace.c                    |   9 +-
>>  tools/perf/util/auxtrace.h                    |   1 +
>>  .../perf/util/cs-etm-decoder/cs-etm-decoder.c |  28 +-
>>  tools/perf/util/cs-etm.c                      | 617 ++++++++++++------
>>  tools/perf/util/cs-etm.h                      |   2 +-
>>  21 files changed, 633 insertions(+), 404 deletions(-)
>>
>> --
>> 2.34.1
>>
> 
> 
