Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DA5D17CA06;
	Thu, 30 May 2024 12:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717073685; cv=none; b=QLOhCR4ML4o+7IdfqvZVGpHZrMY4ntSxqhLeQ9kzuwkk8RZzghO3FZiat9n41agxbMgfRx4bO65qD6d+A+ZjXH4V8S/5+IRwvD+qeYshfzN6vUQloMkmVhby+AQy9pYYPJs5K0FnCx8ciyHc1zxGJ+8lnTW1bsrI9X5XoPNCVq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717073685; c=relaxed/simple;
	bh=bIrMEs5NYdtb9T9UOCr6ZAsNT8glRmdAXyGs2MUvXok=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yn7zUG00PG7OtiHv0D2vKhWJXKp7Ave/KHcX0agnET7SXG46fOe6iEmOJntD8W31JcMZy6+W+nCocagrB+8Ucf/cSvH21fasfJOnVuHJyVZMYbWB2TItZGWNUWdLQFYGhnSURi54ZFxpFpAQbAzKjn2klh/a/88bIBrJ//nwnPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1BD35339;
	Thu, 30 May 2024 05:55:06 -0700 (PDT)
Received: from [192.168.1.100] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 628EF3F792;
	Thu, 30 May 2024 05:54:40 -0700 (PDT)
Message-ID: <193884e6-0911-4a5f-9676-74e1630f9a28@arm.com>
Date: Thu, 30 May 2024 13:54:42 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/4] tools/perf: Allow inherit + PERF_SAMPLE_READ when
 opening events
To: Namhyung Kim <namhyung@kernel.org>, Ben Gainey <Ben.Gainey@arm.com>
Cc: "alexander.shishkin@linux.intel.com"
 <alexander.shishkin@linux.intel.com>,
 "peterz@infradead.org" <peterz@infradead.org>,
 "acme@kernel.org" <acme@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
 "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
 "irogers@google.com" <irogers@google.com>,
 "jolsa@kernel.org" <jolsa@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
 Mark Rutland <Mark.Rutland@arm.com>
References: <20240521133029.83654-1-ben.gainey@arm.com>
 <20240521133029.83654-5-ben.gainey@arm.com>
 <CAM9d7chssov_fW3ZbpYqGRyhS=xuHLyJ7=rkxTNnJ6fkgEdGJQ@mail.gmail.com>
 <a12573d18f7c8bf73c24c572e43965e3f250acea.camel@arm.com>
 <e114bf8d2e7b6c0874fffdf8867c954a08772da3.camel@arm.com>
 <CAM9d7cjmH=nkEt-z_XpZ1J0oL-EY2d52oz70-KpN+uzM5SEk6A@mail.gmail.com>
Content-Language: en-US
From: James Clark <james.clark@arm.com>
In-Reply-To: <CAM9d7cjmH=nkEt-z_XpZ1J0oL-EY2d52oz70-KpN+uzM5SEk6A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 29/05/2024 20:18, Namhyung Kim wrote:
> Hello,
> 
> On Wed, May 29, 2024 at 10:48 AM Ben Gainey <Ben.Gainey@arm.com> wrote:
>>
>> On Mon, 2024-05-27 at 18:47 +0100, Ben Gainey wrote:
>>> On Thu, 2024-05-23 at 18:41 -0700, Namhyung Kim wrote:
>>>> On Tue, May 21, 2024 at 6:30 AM Ben Gainey <ben.gainey@arm.com>
>>>> wrote:
>>>>>
>>>>> The tool will now default to this new mode if the user specifies
>>>>> a
>>>>> sampling group when not in system-wide mode, and when --no-
>>>>> inherit
>>>>> is not specified.
>>>>>
>>>>> This change updates evsel to allow the combination of inherit
>>>>> and PERF_SAMPLE_READ.
>>>>>
>>>>> A fallback is implemented for kernel versions where this feature
>>>>> is
>>>>> not
>>>>> supported.
>>>>
>>>> But I'm afraid the test would fail on old kernels.  Maybe we need
>>>> to
>>>> put it in the selftests.
>>>>
>>>
>>> Sorry, not clear what you mean?
>>>
>>> Is the issue that the fallback on older kernels fails, or that the
>>> "perf test" tests fail?
>>>
>>> Thanks
>>> Ben
>>
>> Just to follow up, I've rechecked the fallback on an unmodified 6.9.1
>> kernel with the following:
>>
>>     perf record -vv -e '{cycles,instructions}:S' ls
>>
>> With an unpatched version of perf running on an unpatched kernel, the
>> cycles event is opened as:
>>
>>     ------------------------------------------------------------
>>     perf_event_attr:
>>       type                             0 (PERF_TYPE_HARDWARE)
>>       size                             136
>>       config                           0 (PERF_COUNT_HW_CPU_CYCLES)
>>       { sample_period, sample_freq }   4000
>>       sample_type                      IP|TID|TIME|READ|ID|PERIOD
>>       read_format                      ID|GROUP|LOST
>>       disabled                         1
>>       exclude_kernel                   1
>>       exclude_hv                       1
>>       mmap                             1
>>       comm                             1
>>       freq                             1
>>       enable_on_exec                   1
>>       task                             1
>>       sample_id_all                    1
>>       exclude_guest                    1
>>       mmap2                            1
>>       comm_exec                        1
>>       ksymbol                          1
>>       bpf_event                        1
>>     ------------------------------------------------------------
>>
>> whereas with these patches applied to perf, on an unpatched kernel, the
>> output is as follows
>>
>>     ------------------------------------------------------------
>>     perf_event_attr:
>>       type                             0 (PERF_TYPE_HARDWARE)
>>       size                             136
>>       config                           0 (PERF_COUNT_HW_CPU_CYCLES)
>>       { sample_period, sample_freq }   4000
>>       sample_type                      IP|TID|TIME|READ|ID|PERIOD
>>       read_format                      ID|GROUP|LOST
>>       disabled                         1
>>       inherit                          1
>>       exclude_kernel                   1
>>       exclude_hv                       1
>>       mmap                             1
>>       comm                             1
>>       freq                             1
>>       enable_on_exec                   1
>>       task                             1
>>       sample_id_all                    1
>>       exclude_guest                    1
>>       mmap2                            1
>>       comm_exec                        1
>>       ksymbol                          1
>>       bpf_event                        1
>>     ------------------------------------------------------------
>>     sys_perf_event_open: pid 3442954  cpu 0  group_fd -1  flags 0x8
>>     sys_perf_event_open failed, error -22
>>     Using PERF_SAMPLE_READ / :S modifier is not compatible with
>> inherit, falling back to no-inherit.
>>     ------------------------------------------------------------
>>     perf_event_attr:
>>       type                             0 (PERF_TYPE_HARDWARE)
>>       size                             136
>>       config                           0 (PERF_COUNT_HW_CPU_CYCLES)
>>       { sample_period, sample_freq }   4000
>>       sample_type                      IP|TID|TIME|READ|ID|PERIOD
>>       read_format                      ID|GROUP|LOST
>>       disabled                         1
>>       exclude_kernel                   1
>>       exclude_hv                       1
>>       mmap                             1
>>       comm                             1
>>       freq                             1
>>       enable_on_exec                   1
>>       task                             1
>>       sample_id_all                    1
>>       exclude_guest                    1
>>       mmap2                            1
>>       comm_exec                        1
>>       ksymbol                          1
>>       bpf_event                        1
>>     ------------------------------------------------------------
>>
>> The command falls back to the same configuration as was previously
>> used. The same is true for the instructions event.
>>
>> `perf test` fails on an unpatched kernel in "15: Setup struct
>> perf_event_attr" for the test "test-record-group-sampling1" but that is
>> surely expected for unpatched kernels?
>>
>> Is there some very-old kernel version where this would be expected to
>> succeed by accident?
> 
> I don't think so but I don't want the test to fail depending on the
> kernel version.  Maybe we can check the allowed combination
> first and skip the test if perf_event_open() fails.  And then it can
> verify if the kernel rejects the unsupported combinations.  Not
> sure if it's easy to do that in the current attr test framework.
> 
> Thanks,
> Namhyung

I added the kernel version feature to the attr tests. Seems like you can
add two tests, one for before and one for after.

Search "kernel_until" in tests/attr
