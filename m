Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5765E15B541;
	Wed, 24 Jul 2024 15:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721835357; cv=none; b=u49I1uH13ioJY4I+qOLZsvVFI2CWLpI3ZsT3ixlCwaSu6K2tVfKdzeaRg0JXtMxlg3NSioSFGfruswIYRrNBQRH4gdvi9hSaApekn6n2kVK4wglPYa6/WcV2+7EovuD0Bam+UYPbCclqS/D9+HNdZz+jjbTtY6u/6sfU1LWDhus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721835357; c=relaxed/simple;
	bh=x2M2EORzNWm631G097ZLRlP04kLY2CYa4nt3ijt5p9Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ahzV+JGwA5YwrBeH6IqU0R08rlTtY33FBThhDA+qDRD8Nxlvw9R9Ul00SXZlkSXgTBoBZP4cbmQKkjVz2x9cTlp0lRAzfr8f40yAZIN9VnJ/vUlubi4mPafg0Z2ZSIfGREIFVsHYYYlX7d4ymYlrNfeSz8iVhPOqkX+6PskM3aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 16006106F;
	Wed, 24 Jul 2024 08:36:20 -0700 (PDT)
Received: from [10.1.25.15] (PF4Q20KV.arm.com [10.1.25.15])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EE4ED3F766;
	Wed, 24 Jul 2024 08:35:51 -0700 (PDT)
Message-ID: <918e5562-1523-4793-93c7-94ee143ff87c@arm.com>
Date: Wed, 24 Jul 2024 16:35:50 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf scripts python: cs-etm: Update example to provide
 vmlinux path to Perf
To: James Clark <james.clark@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>,
 Ruidong Tian <tianruidong@linux.alibaba.com>,
 Benjamin Gray <bgray@linux.ibm.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
 gankulkarni@os.amperecomputing.com, mike.leach@linaro.org,
 suzuki.poulose@arm.com
References: <20240724143319.169745-1-james.clark@linaro.org>
 <225ff37c-0e50-48d5-bb4c-e8a63e72991a@arm.com>
 <50b78571-34b5-4ad9-abc3-0416b3d9b917@linaro.org>
Content-Language: en-US
From: Leo Yan <leo.yan@arm.com>
In-Reply-To: <50b78571-34b5-4ad9-abc3-0416b3d9b917@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/24/2024 4:23 PM, James Clark wrote:

[...]

>> The change makes senses to me.  Just check a bit, does it need to add the same
>> option for the command "only source line and symbols"?
> 
> I assumed that because that one didn't have vmlinux at all then it's
> just for userspace tracing.
For the only source and symbols case, I expect it will can be used for kernel
tracing as well, as this can save much time if someone doesn't care about
disassembly.

Maybe it is good to add the same option for it, even though it is not used for
user space tracing. Either is fine for me:

Reviewed-by: Leo Yan <leo.yan@arm.com>

> I think it's good to have an example without
> vmlinux to show that it's not a strict requirement.

>>> ---
>>>   tools/perf/scripts/python/arm-cs-trace-disasm.py | 4 ++--
>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/tools/perf/scripts/python/arm-cs-trace-disasm.py
>>> b/tools/perf/scripts/python/arm-cs-trace-disasm.py
>>> index 7aff02d84ffb..4aeb9b497f7a 100755
>>> --- a/tools/perf/scripts/python/arm-cs-trace-disasm.py
>>> +++ b/tools/perf/scripts/python/arm-cs-trace-disasm.py
>>> @@ -19,10 +19,10 @@ from perf_trace_context import perf_set_itrace_options, \
>>>   # Below are some example commands for using this script.
>>>   #
>>>   # Output disassembly with objdump:
>>> -#  perf script -s scripts/python/arm-cs-trace-disasm.py \
>>> +#  perf script -k path/to/vmlinux -s scripts/python/arm-cs-trace-disasm.py \
>>>   #              -- -d objdump -k path/to/vmlinux
>>>   # Output disassembly with llvm-objdump:
>>> -#  perf script -s scripts/python/arm-cs-trace-disasm.py \
>>> +#  perf script -k path/to/vmlinux -s scripts/python/arm-cs-trace-disasm.py \
>>>   #              -- -d llvm-objdump-11 -k path/to/vmlinux
>>>   # Output only source line and symbols:
>>>   #  perf script -s scripts/python/arm-cs-trace-disasm.py
>>> -- 
>>> 2.34.1
>>>
