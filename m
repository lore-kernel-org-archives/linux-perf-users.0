Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B5981C2318;
	Thu, 30 May 2024 12:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717071749; cv=none; b=FRlSai43bhcfaHoWfipWlZw66p5Y84unEJNlUGnBnY6e+loZKgQ05oP+4ErvcWA8EoOBHManfK+f5d/YoIkRmiVV1cHl0J6UjW7kZQSsY8gepPRaA8A7mtZiFjG1gXsjAhU234l0tXRBRezKe63ITDe8a6JmPy7i1N66UmiuTyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717071749; c=relaxed/simple;
	bh=oMFibsBAcun+NdzeWhLVwKtyoTpI/pYPk8pxR1SiKFM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rf/FCIe8MULVifL766+4J0ykVUuyaWsZ7oGsBk3znhq2JKOmoj/12K/c8VU7lgqFnWyGJ7gTckMwH560ek3qrLfFYfzCykjokATo9Dnxf1bQonVbTEJKF4vyIDf0sPjex6UJQuCr5YGK9zFNPia8XT0TjdeHwfAbq+gzg2aJoog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 80BA9339;
	Thu, 30 May 2024 05:22:50 -0700 (PDT)
Received: from [192.168.1.100] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DFD273F792;
	Thu, 30 May 2024 05:22:23 -0700 (PDT)
Message-ID: <053b7aad-5c30-48d3-894e-d4db98440191@arm.com>
Date: Thu, 30 May 2024 13:22:25 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/5] perf stat: Remove evlist__add_default_attrs use
 strings
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, Ravi Bangoria
 <ravi.bangoria@amd.com>, Yang Jihong <yangjihong@bytedance.com>,
 Ze Gao <zegao2021@gmail.com>, Leo Yan <leo.yan@linux.dev>,
 Song Liu <song@kernel.org>, K Prateek Nayak <kprateek.nayak@amd.com>,
 Kaige Ye <ye@kaige.org>, Yicong Yang <yangyicong@hisilicon.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240510053705.2462258-1-irogers@google.com>
 <20240510053705.2462258-4-irogers@google.com>
 <35d6875b-9a28-4953-a187-b6659880ac66@arm.com>
 <CAP-5=fUbZRkoRN__ZE3YmzhM5HqQABZ7jHymgshZGDzT0LgqOg@mail.gmail.com>
 <CAP-5=fXxsFp9tynNhkYqrgCMtP4F-XaADz+06hTWHHFVpVhfDg@mail.gmail.com>
Content-Language: en-US
From: James Clark <james.clark@arm.com>
In-Reply-To: <CAP-5=fXxsFp9tynNhkYqrgCMtP4F-XaADz+06hTWHHFVpVhfDg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 29/05/2024 19:18, Ian Rogers wrote:
> On Wed, May 29, 2024 at 10:39 AM Ian Rogers <irogers@google.com> wrote:
>>
>> On Wed, May 29, 2024 at 8:39 AM James Clark <james.clark@arm.com> wrote:
>>>
>>>
>>>
>>> On 10/05/2024 06:37, Ian Rogers wrote:
>>>> add_default_atttributes would add evsels by having pre-created
>>>> perf_event_attr, however, this needed fixing for hybrid as the
>>>> extended PMU type was necessary for each core PMU. The logic for this
>>>> was in an arch specific x86 function and wasn't present for ARM,
>>>> meaning that default events weren't being opened on all PMUs on
>>>> ARM. Change the creation of the default events to use parse_events and
>>>> strings as that will open the events on all PMUs.
>>>>
>>>> Rather than try to detect events on PMUs before parsing, parse the
>>>> event but skip its output in stat-display.
>>>>
>>>> The previous order of hardware events was: cycles,
>>>> stalled-cycles-frontend, stalled-cycles-backend, instructions. As
>>>> instructions is a more fundamental concept the order is changed to:
>>>> instructions, cycles, stalled-cycles-frontend, stalled-cycles-backend.
>>>>
>>>> Closes: https://lore.kernel.org/lkml/CAP-5=fVABSBZnsmtRn1uF-k-G1GWM-L5SgiinhPTfHbQsKXb_g@mail.gmail.com/
>>>
>>> Taking a look at this one now. I think some example commands and outputs
>>> in the commit message would be helpful because there are quite a few
>>> different things mentioned in the closes link.
>>>
>>> But I'm assuming this is just for the command without specifying an event:
>>>
>>>   $ perf stat
>>>
>>> I didn't realise that wasn't working properly and I'd missed that Mark
>>> spotted it in that link.
>>
>> Hi James,
>>
>> Do you want to take on owning fixing this? My concern is that by using
>> event parsing:
>>
>> +                               "context-switches,"
>> +                               "cpu-migrations,"
>> +                               "page-faults,"
>> +                               "instructions,"
>> +                               "cycles,"
>> +                               "stalled-cycles-frontend,"
>> +                               "stalled-cycles-backend,"
>> +                               "branches,"
>> +                               "branch-misses",
>>
>> any of the names could conflict with something advertised on an ARM
>> PMU somewhere. Clearly cycles has already proved to be controversial
>> and broken for perf record on Neoverse.
> 
> Oh and these events are also broken on ARM M? PMUs with the revert
> that's in v6.10, so I don't know how to go about fixing this.
> 
> Thanks,
> Ian

I'll take it yep. But the fix probably needs to take into context
whatever else we decide with the other issue. Conflicting names might
not actually be an issue if we work around that with the other change.
But I'm still getting up to speed with the other one.

James

