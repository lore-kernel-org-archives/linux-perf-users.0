Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3AC61CB329;
	Thu, 22 Aug 2024 14:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724337314; cv=none; b=gqlm77vCpMfblkHpzhZPs3HGETn7kPsUNGKLqgzvy0yXdwRDpTw4vN0Aa6rEcYUl4FUNZkElj1vFkmTPhYXm9GOBG43rdqLl0OyMVml/Z1SCh1z+pQUzBDY7Pp1OIgl2/l4IIOd1uTRiMfw1rdWNExvj72XnPTkWjzXtBd5k3ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724337314; c=relaxed/simple;
	bh=Yrbud2/p+d0nyomNYkBZ+AczxiW0KfleN4GvLDqchV4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E3DSU+yys1prxTr0D1od691RCMbHE2HyYv41k0D4AKzf9V3Ai0Sg3EVEWLZpG87alQ2hxzhtImXiCKhi33ns2gDHxaO/R5HQQ2bWhAXC8/6dGB/Uqbu6uBRCswcslwEpztSXjnSvUoQdAU71NZmR72HYS4Xj9B/WhiG7cm29HBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 071C3DA7;
	Thu, 22 Aug 2024 07:35:38 -0700 (PDT)
Received: from [10.57.72.240] (unknown [10.57.72.240])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 49AD23F66E;
	Thu, 22 Aug 2024 07:35:08 -0700 (PDT)
Message-ID: <aab886f3-ebbf-4853-b26b-5cf70c801683@arm.com>
Date: Thu, 22 Aug 2024 15:35:06 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/17] coresight: Use per-sink trace ID maps for Perf
 sessions
Content-Language: en-GB
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: James Clark <james.clark@linaro.org>, coresight@lists.linaro.org,
 gankulkarni@os.amperecomputing.com, mike.leach@linaro.org,
 leo.yan@linux.dev, anshuman.khandual@arm.com,
 James Clark <james.clark@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, linux-perf-users@vger.kernel.org
References: <20240722101202.26915-1-james.clark@linaro.org>
 <ZqOwGWcYosGe9ru4@x1> <6476a228-847b-4804-9229-c11a881663c7@arm.com>
 <ZqOzio8Oco9ZFsDm@x1> <8068c8ff-a8ce-4bcd-bb19-2c25b45cf6f3@arm.com>
 <ZqO3gPcCCVh1r5WM@x1>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <ZqO3gPcCCVh1r5WM@x1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Arnaldo,

On 26/07/2024 15:49, Arnaldo Carvalho de Melo wrote:
> On Fri, Jul 26, 2024 at 03:38:13PM +0100, Suzuki K Poulose wrote:
>> On 26/07/2024 15:32, Arnaldo Carvalho de Melo wrote:
>>> On Fri, Jul 26, 2024 at 03:26:04PM +0100, Suzuki K Poulose wrote:
>>>> On 26/07/2024 15:18, Arnaldo Carvalho de Melo wrote:
>>>>> On Mon, Jul 22, 2024 at 11:11:42AM +0100, James Clark wrote:
>>>>>> This will allow sessions with more than CORESIGHT_TRACE_IDS_MAX ETMs
>>>>>> as long as there are fewer than that many ETMs connected to each sink.
>>>>>
>>>>> Hey, may I take the tools part, i.e. patches 0-7 and someone on the ARM
>>>>> kernel team pick the driver bits?
> 
>>>> I plan to pick the kernel driver bits for v6.12
> 
>>> Perhaps it is better for me to wait for that?
> 
>> Yes, please.
> 
> Please let me know when you do so so that I can merge the tooling bits.

I have now merged the driver changes to coresight/next, they will be
sent to Greg for v6.12. [0]

You may go ahead and merge the tool bits.

Thanks
Suzuki

[0] 
https://lkml.kernel.org/r/172433479466.350842.6920589600831615538.b4-ty@arm.com


> 
> Thanks,
> 
> - Arnaldo

