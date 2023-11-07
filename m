Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D8211704
	for <linux-perf-users@vger.kernel.org>; Tue,  7 Nov 2023 09:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0CFF511A;
	Tue,  7 Nov 2023 01:36:46 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5CFBFFEC;
	Tue,  7 Nov 2023 01:37:30 -0800 (PST)
Received: from [192.168.1.3] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9E4F73F703;
	Tue,  7 Nov 2023 01:36:43 -0800 (PST)
Message-ID: <c4304ad4-0aba-9ab4-1473-0f790d011da6@arm.com>
Date: Tue, 7 Nov 2023 09:36:45 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v1 1/2] perf auxtrace: Add 'T' itrace option for timestamp
 trace
Content-Language: en-US
To: Adrian Hunter <adrian.hunter@intel.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Leo Yan <leo.yan@linaro.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
 Mike Leach <mike.leach@linaro.org>, John Garry <john.g.garry@oracle.com>,
 Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20231014074513.1668000-1-leo.yan@linaro.org>
 <20231014074513.1668000-2-leo.yan@linaro.org>
 <8a2ea58f-f835-4d1a-8bd6-3a63b3b0db94@intel.com>
 <ZUlgM8pgf19UeyM9@kernel.org>
 <2940af18-8bcd-4456-a8ed-e77cade1b160@intel.com>
From: James Clark <james.clark@arm.com>
In-Reply-To: <2940af18-8bcd-4456-a8ed-e77cade1b160@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 07/11/2023 07:19, Adrian Hunter wrote:
> On 6/11/23 23:52, Arnaldo Carvalho de Melo wrote:
>> Em Thu, Oct 19, 2023 at 01:47:15PM +0300, Adrian Hunter escreveu:
>>> On 14/10/23 10:45, Leo Yan wrote:
>>>> An AUX trace can contain timestamp, but in some situations, the hardware
>>>> trace module (e.g. Arm CoreSight) cannot decide the traced timestamp is
>>>> the same source with CPU's time, thus the decoder can not use the
>>>> timestamp trace for samples.
>>>>
>>>> This patch introduces 'T' itrace option. If users know the platforms
>>>
>>> "If users know" <- how would users know?  Could the kernel
>>> or tools also figure it out?
>>
>> Adrian, I'm trying to go all the outstanding patches, do you still have
>> any issues with this series?
> 
> No, although the question wasn't actually answered.  I presume users
> just have to try the 'T' option and see if it helps.
> 

I suppose my previous answer about discoverability was more general. To 
answer the specific question "how would users know?", it would have to 
be mentioned in the reference manual of their device that this is how 
the timers are set up.

But I don't see this being a common use case, as I mentioned before, in 
newer arm platforms this is discoverable and just works.
