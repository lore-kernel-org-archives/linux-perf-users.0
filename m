Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C62F1094E;
	Tue, 28 May 2024 15:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716908443; cv=none; b=ewedt+CrrbHf/rwrxhU/45B2+VyHuGB6xa3M66Cc/yl8Fpxtu7ui7ophWzWo2l2G49dGgEgbuQ4tZ5AYv282nLjG9a6HK1LRXz3P4DnmuMorhs+jHGv99AgcmP4FsDen1jnPkfRDQSHG1JLHrPK7P1e7YcPOfR6ZaBU1ADrTjlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716908443; c=relaxed/simple;
	bh=vVMIytHSqDzGQIHQa79FWs3ijJZgV/ZUXRTkNM6Pl4w=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=gRG5ueTak4uMISHPZ0cwcBhx+MSuJRaOXHUXwrL0uOBexuD8icvKnZQjvx6kDO1aoc7fHIgF7Au0LxdugRXn4m0+HvxEWj+SAN+co3vXQIQKfGUZLewfFGUQ+3waqdH6AgL5TnhFB/dGtjclgmfU8TXRglGHMfCe93jGmUIc/nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1FC2F339;
	Tue, 28 May 2024 08:01:02 -0700 (PDT)
Received: from [192.168.1.100] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 267863F762;
	Tue, 28 May 2024 08:00:36 -0700 (PDT)
Message-ID: <1f5f1eed-1feb-4a51-92b7-12c1fd195708@arm.com>
Date: Tue, 28 May 2024 16:00:37 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] perf maps: Sort kcore maps
To: Leo Yan <leo.yan@arm.com>, Adrian Hunter <adrian.hunter@intel.com>
References: <20240520090647.949371-1-leo.yan@arm.com>
 <20240520090647.949371-2-leo.yan@arm.com>
 <2f4fce9f-6283-40ad-8adc-c370e98627da@intel.com>
 <02fbb30f-19cf-4822-9676-35d3e51d99b1@arm.com>
Content-Language: en-US
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>,
 Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
From: James Clark <james.clark@arm.com>
In-Reply-To: <02fbb30f-19cf-4822-9676-35d3e51d99b1@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 25/05/2024 10:29, Leo Yan wrote:
> Hi Adrian,
> 
> On 5/22/2024 11:31 AM, Adrian Hunter wrote:
>> On 20/05/24 12:06, Leo Yan wrote:
>>> When merging kcore maps into the kernel maps, it has an implicit
>>> requirement for the kcore maps ordering, otherwise, some sections
>>> delivered by the kcore maps will be ignored.
>>
>> perf treats the kernel text map as a special case.  The problem
>> is that the kcore loading logic did not cater for there being 2
>> maps that covered the kernel mapping.
>>
>> The workaround was to choose the smaller mapping, but then that
>> still only worked if that was the first.
> 
> You could see below are Kcore maps dumped on Arm64:
> 
> kore map start: ffff000000000000 end: ffff00001ac00000 name: [kernel.kallsyms]
> refcnt: 1
> kore map start: ffff00001ad88000 end: ffff000032000000 name: [kernel.kallsyms]
> refcnt: 1
> kore map start: ffff000032101000 end: ffff00003e000000 name: [kernel.kallsyms]
> refcnt: 1
> kore map start: ffff000040000000 end: ffff000089b80000 name: [kernel.kallsyms]
> refcnt: 1
> kore map start: ffff000089cc0000 end: ffff0000b9ab0000 name: [kernel.kallsyms]
> refcnt: 1
> kore map start: ffff0000b9ad0000 end: ffff0000b9bb0000 name: [kernel.kallsyms]
> refcnt: 1
> kore map start: ffff0000b9c50000 end: ffff0000b9d50000 name: [kernel.kallsyms]
> refcnt: 1
> kore map start: ffff0000ba114000 end: ffff0000bf130000 name: [kernel.kallsyms]
> refcnt: 1
> kore map start: ffff0000bf180000 end: ffff0000e0000000 name: [kernel.kallsyms]
> refcnt: 1
> kore map start: ffff000200000000 end: ffff000220000000 name: [kernel.kallsyms]
> refcnt: 1
> kore map start: ffff800000000000 end: ffff800080000000 name: [kernel.kallsyms]
> refcnt: 1
> kore map start: ffff800080000000 end: ffff8000822f0000 name: [kernel.kallsyms]
> refcnt: 1
> kore map start: ffff800080000000 end: fffffdffbf800000 name: [kernel.kallsyms]
> refcnt: 1
> kore map start: fffffdffc0000000 end: fffffdffc06b0000 name: [kernel.kallsyms]
> refcnt: 1
> kore map start: fffffdffc06b6000 end: fffffdffc0c80000 name: [kernel.kallsyms]
> refcnt: 1
> kore map start: fffffdffc0c84000 end: fffffdffc0f80000 name: [kernel.kallsyms]
> refcnt: 1
> kore map start: fffffdffc1000000 end: fffffdffc226e000 name: [kernel.kallsyms]
> refcnt: 1
> kore map start: fffffdffc2273000 end: fffffdffc2e6b000 name: [kernel.kallsyms]
> refcnt: 1
> kore map start: fffffdffc2e6b000 end: fffffdffc2e6f000 name: [kernel.kallsyms]
> refcnt: 1
> kore map start: fffffdffc2e71000 end: fffffdffc2e76000 name: [kernel.kallsyms]
> refcnt: 1
> kore map start: fffffdffc2e84000 end: fffffdffc2fc5000 name: [kernel.kallsyms]
> refcnt: 1
> kore map start: fffffdffc2fc6000 end: fffffdffc3800000 name: [kernel.kallsyms]
> refcnt: 1
> kore map start: fffffdffc8000000 end: fffffdffc8800000 name: [kernel.kallsyms]
> refcnt: 1
> 
> You could see it's much more complex rather than only for kernel text section
> and vmalloc region. We cannot only handle the case for the overlapping between
> the text section and vmalloc region, it is possible for other maps to be
> overlapping with each other.
> 
> And different arches have their own definition for the Kcore maps. This is why
> I want to sort maps in this patch, it can allow us to find a reliable way to
> append the kcore maps.
> 
>> James essentially fixed that by ensuring the kernel "replacement"
>> map is inserted first.
> 
> Yeah, I agreed James' patch has fixed the kernel "replacement" map. But as I
> elaborated above, there still have other maps might overlap with each other,
> my understanding is we don't handle all cases.
>> In other respects, the ordering of the maps does not matter, so
>> I am not sure it is worth this extra processing.
> 
> To sell my patch, I have another point for why we need sorting Kcore maps.
> 
> Now Perf verifies the map in the function check_invariants(), this function
> reports the broken issue, but we still have no clue how the broken issue happens.
> 
> If we can sort the Kcore maps in kcore_mapfn(), then we have chance to detect
> the overlapping within maps, and then it can reports the overlapping in the
> first place and this would be helpful for debugging and locating the failures.
> 

+1 for this point. If check_invariants() insists on sorted maps, then
keeping them sorted as early as possible is better.

Debugging future issues will be easier if the assert is closer to the
source of the problem.

James
