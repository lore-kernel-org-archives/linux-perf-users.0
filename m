Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C89B26281;
	Fri,  3 Jan 2025 20:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735936614; cv=none; b=oA+xjnghF++Q3TgHxVCQKS8DbHlkDLjIoAw6msmAMEGpejynIHp0270AJ4QxFzip2+MuA3zw7yIfQlxEn63Vf1TQm4dqpdEW/5b1OIxxLWT46pHKJxQjpJca3aoGru97FfyWyXN/UO37TbnU0pzmlOh7aNF7DWFjE7IGXkW13D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735936614; c=relaxed/simple;
	bh=mCtfy5uJAaCajLUrE5G8vQyO2NpDsuY9wDS9hBQpVCg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L+/W4K2wGhldIpnoaxs1shY0RsVSnz+unc9KFv9voE+f9NmIUHDTUcf2IpxSSOcpG0bc+8HpRy/FPepGAdfHH3XI1QZHveXbfXCuGM6lYHJBIQ6hTk4rHvf1H9clG5+5bfevN61t0rbpCJpQVb2pkrKOCxZh67BTSkdHDq8c2/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e7SY43V0; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e7SY43V0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735936612; x=1767472612;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=mCtfy5uJAaCajLUrE5G8vQyO2NpDsuY9wDS9hBQpVCg=;
  b=e7SY43V0gg1bKsG/FXsMPcXJMY0ykLkPdyIndDy5ct3N927FKGoN6Fu2
   AvEKjf7JTKlyjPhutzjp2V757TBlHEH3Ue0b8IGhwkGwDrM5mc4T4knjL
   ZgbC3+qu7PbWNy5SHGvms7qJNz6tGjxqye0qfhhpsykJTIg7AdtzmXCjs
   NQpecHFD7Fwp8nfHv0r5gCxkw9YlHEbbqjdtvoDB9hMpZjuTVYhi9QE0V
   r/VYyB7dWvIfblEJFmV9+OtvnVOFuXs2bI5aPDAqJTyaijCPj5g22vwkE
   R7rK6hgpOADQXS8VrSs9C5bNL6xzFIV05+Hl8oaK1vDdWFbEDBKRbDYFQ
   w==;
X-CSE-ConnectionGUID: Ilebsl2PRqSe+WeKrlHi3g==
X-CSE-MsgGUID: YXdlp/0tR4qHnmiHjgZFfw==
X-IronPort-AV: E=McAfee;i="6700,10204,11304"; a="35426431"
X-IronPort-AV: E=Sophos;i="6.12,286,1728975600"; 
   d="scan'208";a="35426431"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2025 12:36:51 -0800
X-CSE-ConnectionGUID: YN/5v/1XSEmBWLeUXna3JA==
X-CSE-MsgGUID: M8g81aPcQ0mX/8DJq0Q3MA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="106921252"
Received: from soc-cp83kr3.clients.intel.com (HELO [10.24.8.92]) ([10.24.8.92])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2025 12:36:51 -0800
Message-ID: <a4ef5e31-551e-481e-8da1-1476ca827f97@intel.com>
Date: Fri, 3 Jan 2025 12:36:52 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] perf: map pages in advance
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 David Hildenbrand <david@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Matthew Wilcox <willy@infradead.org>, Yi Lai <yi1.lai@linux.intel.com>
References: <20241205082948.56212-1-lorenzo.stoakes@oracle.com>
 <65a04f0d-668b-47b6-a532-d1e11ef4835a@intel.com>
 <4ded2d63-03dd-498e-9810-690a9eff0c22@lucifer.local>
 <860a1ef0-678d-414d-8511-9695b90c3ca0@redhat.com>
 <74fd8a75-66c6-40a8-9ec3-d7aa74469755@intel.com>
 <ebaa9d2e-c5f3-4a93-9def-caadae92acc6@redhat.com>
 <e489e48d-f9ef-453d-9b88-91368b9534d7@redhat.com>
 <f4299bff-3448-4095-b573-243f1fca834c@lucifer.local>
 <2cb3d067-fe92-4bdf-ae79-b24810a4bc2e@redhat.com>
 <0d99b80e-0ae1-4d74-97b9-68fdc0029fb5@lucifer.local>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <0d99b80e-0ae1-4d74-97b9-68fdc0029fb5@lucifer.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/3/2025 6:45 AM, Lorenzo Stoakes wrote:
> On Mon, Dec 23, 2024 at 10:12:42PM +0100, David Hildenbrand wrote:
>> On 23.12.24 12:10, Lorenzo Stoakes wrote:
>>> Peter - could you drop this patch for now until I have a chance to take a
>>> look at this issue on my return on 2nd Jan?
>>>
>>> On Fri, Dec 20, 2024 at 10:53:14PM +0100, David Hildenbrand wrote:
>>>> On 20.12.24 22:29, David Hildenbrand wrote:
>>>>> On 20.12.24 20:36, Chen, Zide wrote:
>>>>>>
>>>>>>
>>>>>> On 12/20/2024 1:56 AM, David Hildenbrand wrote:
>>>>>>> On 20.12.24 10:31, Lorenzo Stoakes wrote:
>>>>>>>> On Thu, Dec 19, 2024 at 01:17:44PM -0800, Chen, Zide wrote:
>>>>>>>>
>>>>>>>>> With this patch, it seems perf tool has some problems in capturing the
>>>>>>>>> kernel data with Intel PT.
>>>>>>>>>
>>>>>>>>> Running the following commands, the size of perf.data is very small, and
>>>>>>>>> perf script can't find any valid records.
>>>>>>>>>
>>>>>>>>> perf record -e intel_pt//u -- /bin/ls
>>>>>>>>> perf script --insn-trace
>>>>>>>>>
>>>>>>>>>
>>>>>>>>
>>>>>>>> Hi,
>>>>>>>>
>>>>>>>> I'm on leave (and should really go back to relaxing :>), returning on 2nd
>>>>>>>> Jan so can't really dig into this.
>>>>>>>>
>>>>>>>> But I tried it on my intel box and it 'works on my machine' with and
>>>>>>>> without patch with commands provided, so I'm not sure this is actually a
>>>>>>>> product of this change (which shouldn't impact this).
>>>>>>>
>>>>>>> Zide Chen, can you try with and without this patch to see if it
>>>>>>> introduces the issue?
>>>>>>
>>>>>> Yes, I re-did the test on a SPR server, and the result is same. Without
>>>>>> the patch, it went well; But with it, "perf script --insn-trace" doesn't
>>>>>> show valid records.
>>>>>>
>>>>>> This time I tested it on the clean 6.13-rc1 tag, base commit
>>>>>> 40384c840ea1944d7c5a392e8975ed088ecf0b37
>>>>>>
>>>>>> Also, with this patch, running tools/perf/tests/shell/test_intel_pt.sh:
>>>>>>
>>>>>> Error:
>>>>>> The - data has no samples!
>>>>>
>>>>> I just tested it on 6.13-rc1  vs. 6.13-rc1  with this patch.
>>>>>
>>>>> Indeed, there is quite difference. Below are the main parts that changed, only.
>>>>>
>>>>> We seem to be recording data, but maybe what we record gets corrupted somehow?
>>>>
>>>> Huge parts of the new file are full of 0s. Either we are mapping the wrong
>>>> pages, or reading from the pages (via PFNMAP) does not work as expected.
>>>>
>>>
>>> Thanks David, and apologies Zide, appears there is an issue here clearly.
>>>
>>> Could you try this with sudo operations? I was doing this locally and I
>>> wonder if there is now a permissioning error?
>>
>> I ran it under root.
>>
>>>
>>> I'd be surprised if pfn map would cause an issue here as it should just
>>> directly map the kernel memory, however if the PT code assumes there will
>>> be faults there could be an issue. I did take a brief look at this last
>>> week and it seems the PT stuff relies on the aux functionality, so that
>>> could also be a source of problems here.
>>
>> I started a bit at that code, no clue yet what's happening.
>>
>> I was wondering if we end up mapping the wrong pages, meaning: the pages at
>> mmap time end up being different to the pages later at fault time. The code
>> is a bit confusing, but I thought we cannot change the effective event/pages
>> while we have an active mmap. Maybe there is some corner case ...
> 
> OK I figured it out... it's a very silly mistake on my part (oh how this is so
> often the case :).
> 
> When we map the pages, we do not offset by vma->vm_pgoff when looking up the
> page, so if you map with an offset (as presumably the intel pt stuff is), it is
> then retrieving the wrong pages).
> 
> This also resolves the apparent need for sudo...
> 
> Very silly mistake. Apologies :>)
> 
> I will send a v4 in a second.
> 
> Zide - could you give v4 a test when I send it out just to confirm it resolves
> your issue? I will cc- you on this.
> 
> Thanks again for your report, and apologies for the noise!

I can confirm that v4 works for my Intel PT tests!

-Zide


>>
>> Nothing else really jumped at me ... moving the mapping og pages after the
>> event_mapped() callback also didn't change anything.
>>
>>>
>>> I am on leave at the moment returning on 2nd Jan, I will look at this as a
>>> priority when I return, as you can see above I've asked Peter to drop this
>>> for now.
>>
>> Enjoy your time off an Happy Holidays!
>>
>> --
>> Cheers,
>>
>> David / dhildenb
>>
> 
> Cheers, Lorenzo

