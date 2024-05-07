Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C104B14D71E;
	Tue,  7 May 2024 10:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715076075; cv=none; b=qWKraPWnCa9asB+o8gjUSQl9mqm2pQPOuC1dU/Vc5DAHtfrkBW36IQ1vzmAlVdjbauLQxt7fM/8zQOXBNuvzxX0Nk3ngmU/V6yJLJlPugXNy3hV/HX6jIm+EU9Oe4wFUwqDyJXQyAun3G0SbUN4FUzpH9OJYfexQsN0E/I5mrgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715076075; c=relaxed/simple;
	bh=w9jRrLGbjxfF2wcuhDg39S1ISD1cICwlpuGu2v10UBg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uMPc3Q2/QaRy7oR6iLxNb0xUO0gBLG9gPq6Ik9zymJwxVdduuHaLtXImrdtkka8b9IZq6KpmmcPMuu/KRExt2f45mIi4AeXn2lr8cNuqVxyehQX5OD/w8kyDLs+wNWfB9hdbWUow/rniQkq27ps0ty8NBr7YF7FMiv/nSISsBH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0F2D51063;
	Tue,  7 May 2024 03:01:38 -0700 (PDT)
Received: from [192.168.1.100] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 51D093F587;
	Tue,  7 May 2024 03:01:09 -0700 (PDT)
Message-ID: <4ab27bea-ac94-48c3-827c-9f2eddcdd50a@arm.com>
Date: Tue, 7 May 2024 11:01:07 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/17] coresight: Use per-sink trace ID maps for Perf
 sessions
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org, gankulkarni@os.amperecomputing.com,
 scclevenger@os.amperecomputing.com, coresight@lists.linaro.org,
 suzuki.poulose@arm.com, mike.leach@linaro.org,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, John Garry
 <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
 Leo Yan <leo.yan@linux.dev>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com
References: <20240429152207.479221-1-james.clark@arm.com>
 <ZjVH118DtAdZKo2v@x1>
Content-Language: en-US
From: James Clark <james.clark@arm.com>
In-Reply-To: <ZjVH118DtAdZKo2v@x1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 03/05/2024 21:23, Arnaldo Carvalho de Melo wrote:
> On Mon, Apr 29, 2024 at 04:21:45PM +0100, James Clark wrote:
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
> 
> I guess I can pick the tooling part now, right? Further reviewing would
> be nice tho.
> 
> - Arnaldo

Is it ok if we wait for the driver changes to be merged first? There
might some review comments which need a format change to the packets and
then a re-write of the tool changes.

You could take 1 and 2 though because they're unrelated.

Thanks
James
