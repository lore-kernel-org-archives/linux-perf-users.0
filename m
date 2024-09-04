Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE7361EB44;
	Wed,  4 Sep 2024 14:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725461493; cv=none; b=sHUelnoXvkfjZ2n2xh5LUP0ACsfp+Qsmjr/JViNnnwmnHJ342jopQnoD1XHGcc+Nst3LiAP0kqtUc80CUR/OOzRHQ3SyNfiVZcTsAt5KUFoXJuDmZrepRcO/cVb69p2Fi4Q4JMd9RtWfycfEAnO6LZaFdPzbCAykyB6dH+FyPyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725461493; c=relaxed/simple;
	bh=o8v/rQNAQIK86jePZEox/Q5xxIeCYH9BaBX2L+kOPx8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tGpEzEdta+uZmU0dfL13ZFEa9gY3R692DRgzOOdDXxwqEoVOWWpboK98o3s73m6JWo4sF4RK6mKcuJmXqBx7iWVUwt3IxmLA8eTfUrIfFriZ+ATJN2De06Dc3YZ0CGJgVEM6RoVopNqJdDIYS+tGsrvuvbWvrJLCPodx+hDBb08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5EAECFEC;
	Wed,  4 Sep 2024 07:51:50 -0700 (PDT)
Received: from [10.57.74.1] (unknown [10.57.74.1])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8A1E43F73F;
	Wed,  4 Sep 2024 07:51:20 -0700 (PDT)
Message-ID: <21e9e78e-f25c-40e9-8131-17478b6b717f@arm.com>
Date: Wed, 4 Sep 2024 15:51:19 +0100
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
To: James Clark <james.clark@linaro.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: coresight@lists.linaro.org, gankulkarni@os.amperecomputing.com,
 mike.leach@linaro.org, leo.yan@linux.dev, anshuman.khandual@arm.com,
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
 <ZqO3gPcCCVh1r5WM@x1> <aab886f3-ebbf-4853-b26b-5cf70c801683@arm.com>
 <7b96894c-f5df-473b-be50-ee118ce3cfaf@linaro.org> <ZtCUUsJNj9Z1CRLK@x1>
 <8afae0a6-5322-47a8-a189-68629ea1991f@linaro.org>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <8afae0a6-5322-47a8-a189-68629ea1991f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30/08/2024 09:37, James Clark wrote:
> 
> 
> On 29/08/2024 4:31 pm, Arnaldo Carvalho de Melo wrote:
>> On Thu, Aug 29, 2024 at 10:05:02AM +0100, James Clark wrote:
>>>
>>>
>>> On 22/08/2024 3:35 pm, Suzuki K Poulose wrote:
>>>> Hi Arnaldo,
>>>>
>>>> On 26/07/2024 15:49, Arnaldo Carvalho de Melo wrote:
>>>>> On Fri, Jul 26, 2024 at 03:38:13PM +0100, Suzuki K Poulose wrote:
>>>>>> On 26/07/2024 15:32, Arnaldo Carvalho de Melo wrote:
>>>>>>> On Fri, Jul 26, 2024 at 03:26:04PM +0100, Suzuki K Poulose wrote:
>>>>>>>> On 26/07/2024 15:18, Arnaldo Carvalho de Melo wrote:
>>>>>>>>> On Mon, Jul 22, 2024 at 11:11:42AM +0100, James Clark wrote:
>>>>>>>>>> This will allow sessions with more than 
>>>>>>>>>> CORESIGHT_TRACE_IDS_MAX ETMs
>>>>>>>>>> as long as there are fewer than that many ETMs
>>>>>>>>>> connected to each sink.
>>>>>>>>>
>>>>>>>>> Hey, may I take the tools part, i.e. patches 0-7 and
>>>>>>>>> someone on the ARM
>>>>>>>>> kernel team pick the driver bits?
>>>>>
>>>>>>>> I plan to pick the kernel driver bits for v6.12
>>>>>
>>>>>>> Perhaps it is better for me to wait for that?
>>>>>
>>>>>> Yes, please.
>>>>>
>>>>> Please let me know when you do so so that I can merge the tooling 
>>>>> bits.
>>>>
>>>> I have now merged the driver changes to coresight/next, they will be
>>>> sent to Greg for v6.12. [0]
>>>>
>>>> You may go ahead and merge the tool bits.
>>
>> I'm taking this as an Acked-by: Suzuki, ok?


>>
> 
> Suzuki is out of office at the moment and can't email but he said it was 
> ok for the acked-by.

Thanks James for conveying the message.

For the record:

For patches 1-8:

Acked-by: Suzuki K Poulose <suzuki.poulose@arm.com>

