Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3881214F9DE;
	Tue,  7 May 2024 10:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715079454; cv=none; b=nvNdvP/SHCd/0DDSBTKrDDHTEC2h03c4TrQjVKG4TY6F6a5sBqbxpHwakQ6B1NaPMfxLkf0HfFCPm94XihrSVmKZTkNStADydzrgqXO76RQ8HFolAJeVPwCV95XAnP0WE5NWZ0+StIREHzsoCPhQb6WNj/RNhJb3GUdFMQS5HY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715079454; c=relaxed/simple;
	bh=njXfh2vlNt8e02BLkhSMu8rI1c4JuveTMOFghreNkOc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YO4eN2ubfCeMyJgIaqMNXkssV2m7gyuJ0Lj1QlYcymYAHG5t6o1IW1/iXN1Ut5s81HhX9YqtJqiNW3NDSnbgFOyvMC4FPVe5UuTgTPmZ6AwB8xlu2WeHGwk1cWLtuWcZkmH0xwvUHsSGoLo+MRA6ulyxwwVqSzqLx0BQ6zN3a4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7B5191063;
	Tue,  7 May 2024 03:57:58 -0700 (PDT)
Received: from [10.163.37.41] (unknown [10.163.37.41])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 31DEF3F587;
	Tue,  7 May 2024 03:57:23 -0700 (PDT)
Message-ID: <ecb16ad9-7c91-4cf6-ab7e-4b4b5be7165c@arm.com>
Date: Tue, 7 May 2024 16:27:25 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/17] perf cs-etm: Print error for new
 PERF_RECORD_AUX_OUTPUT_HW_ID versions
Content-Language: en-US
To: James Clark <james.clark@arm.com>
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
 <20240429152207.479221-2-james.clark@arm.com>
 <08bcd616-5006-45df-b8cc-45cf3a1dd762@arm.com>
 <de635db0-6510-452f-91be-4fc5f7fdf671@arm.com>
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <de635db0-6510-452f-91be-4fc5f7fdf671@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/7/24 15:36, James Clark wrote:
> 
> 
> On 07/05/2024 04:47, Anshuman Khandual wrote:
>>
>>
>> On 4/29/24 20:51, James Clark wrote:
>>> The likely fix for this is to update Perf so print a helpful message.
>>>
>>> Signed-off-by: James Clark <james.clark@arm.com>
>>> ---
>>>  tools/perf/util/cs-etm.c | 5 ++++-
>>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
>>> index d65d7485886c..32818bd7cd17 100644
>>> --- a/tools/perf/util/cs-etm.c
>>> +++ b/tools/perf/util/cs-etm.c
>>> @@ -335,8 +335,11 @@ static int cs_etm__process_aux_output_hw_id(struct perf_session *session,
>>>  	trace_chan_id = FIELD_GET(CS_AUX_HW_ID_TRACE_ID_MASK, hw_id);
>>>  
>>>  	/* check that we can handle this version */
>>> -	if (version > CS_AUX_HW_ID_CURR_VERSION)
>>> +	if (version > CS_AUX_HW_ID_CURR_VERSION) {
>>> +		pr_err("CS ETM Trace: PERF_RECORD_AUX_OUTPUT_HW_ID version %d not supported. Please update Perf.\n",
>>
>> Is not this bit misleading ? PERF_RECORD_AUX_OUTPUT_HW_ID is just the perf record
>> format identifier. The record version here, is derived from the platform specific
>> hardware ID information embedded in this perf record.
> 
> Not sure I follow what you mean here. 'version' is something that's
> output by the kernel. It's saved into a perf.data file, and if Perf
> can't handle version 2 for example, you need to update Perf.

Got it.

> 
>>
>> Should not this be just s/PERF_RECORD_AUX_OUTPUT_HW_ID/hardware ID/ instead ?
>>
> 
> It's just a way to go from the error message to the part of the code or
> docs that you need to look at. "hardware ID" wouldn't lead you anywhere
> so I don't think it would be useful.

Sure, fair enough.

> 
>>> +		       version);
>>>  		return -EINVAL;
>>> +	}
>>>  
>>>  	/* get access to the etm metadata */
>>>  	etm = container_of(session->auxtrace, struct cs_etm_auxtrace, auxtrace);
>>
> _______________________________________________
> CoreSight mailing list -- coresight@lists.linaro.org
> To unsubscribe send an email to coresight-leave@lists.linaro.org
