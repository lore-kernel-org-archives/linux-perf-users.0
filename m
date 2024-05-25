Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7023C138E;
	Sat, 25 May 2024 09:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716629401; cv=none; b=UyYX9lldZKcZxBJRuuNenrZJX/SnVwD4KkcplaGj8cG5MTJLirJ1noLnSCVl6iG+gab2Jzkg7Je7qJwsjVKAMaE0x9S5VKeqBQKzK945sZwLktEIRVI1nnkponoEChmu7N94b+MW2KF72S7qp9ATWTI2J+ZBeq6sb2vAOflfR1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716629401; c=relaxed/simple;
	bh=b1OJCXMUNGZ5CqkObxi4L1NfyClQcLFRQhFPOz4S2xU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=sOhK/RV6X8pDB2jJZWCK72vl7VBDCubVidsLFiERLWabrcKDq13nawdHqIjy2wa7C779ainHkTZ/lU5XoPKcJaX3/C6uwc+dfe9CJFnCj7adA+OvCCAo5OD94FhbrYuXVyaFnAR0rk2uxMklcribX1Ajc90NVO540HWWNtG++DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8B58A339;
	Sat, 25 May 2024 02:30:21 -0700 (PDT)
Received: from [10.57.68.224] (unknown [10.57.68.224])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CBD3D3F641;
	Sat, 25 May 2024 02:29:55 -0700 (PDT)
Message-ID: <02fbb30f-19cf-4822-9676-35d3e51d99b1@arm.com>
Date: Sat, 25 May 2024 10:29:08 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] perf maps: Sort kcore maps
To: Adrian Hunter <adrian.hunter@intel.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>,
 Namhyung Kim <namhyung@kernel.org>, James Clark <james.clark@arm.com>,
 Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240520090647.949371-1-leo.yan@arm.com>
 <20240520090647.949371-2-leo.yan@arm.com>
 <2f4fce9f-6283-40ad-8adc-c370e98627da@intel.com>
Content-Language: en-US
From: Leo Yan <leo.yan@arm.com>
In-Reply-To: <2f4fce9f-6283-40ad-8adc-c370e98627da@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Adrian,

On 5/22/2024 11:31 AM, Adrian Hunter wrote:
> On 20/05/24 12:06, Leo Yan wrote:
>> When merging kcore maps into the kernel maps, it has an implicit
>> requirement for the kcore maps ordering, otherwise, some sections
>> delivered by the kcore maps will be ignored.
> 
> perf treats the kernel text map as a special case.  The problem
> is that the kcore loading logic did not cater for there being 2
> maps that covered the kernel mapping.
> 
> The workaround was to choose the smaller mapping, but then that
> still only worked if that was the first.

You could see below are Kcore maps dumped on Arm64:

kore map start: ffff000000000000 end: ffff00001ac00000 name: [kernel.kallsyms]
refcnt: 1
kore map start: ffff00001ad88000 end: ffff000032000000 name: [kernel.kallsyms]
refcnt: 1
kore map start: ffff000032101000 end: ffff00003e000000 name: [kernel.kallsyms]
refcnt: 1
kore map start: ffff000040000000 end: ffff000089b80000 name: [kernel.kallsyms]
refcnt: 1
kore map start: ffff000089cc0000 end: ffff0000b9ab0000 name: [kernel.kallsyms]
refcnt: 1
kore map start: ffff0000b9ad0000 end: ffff0000b9bb0000 name: [kernel.kallsyms]
refcnt: 1
kore map start: ffff0000b9c50000 end: ffff0000b9d50000 name: [kernel.kallsyms]
refcnt: 1
kore map start: ffff0000ba114000 end: ffff0000bf130000 name: [kernel.kallsyms]
refcnt: 1
kore map start: ffff0000bf180000 end: ffff0000e0000000 name: [kernel.kallsyms]
refcnt: 1
kore map start: ffff000200000000 end: ffff000220000000 name: [kernel.kallsyms]
refcnt: 1
kore map start: ffff800000000000 end: ffff800080000000 name: [kernel.kallsyms]
refcnt: 1
kore map start: ffff800080000000 end: ffff8000822f0000 name: [kernel.kallsyms]
refcnt: 1
kore map start: ffff800080000000 end: fffffdffbf800000 name: [kernel.kallsyms]
refcnt: 1
kore map start: fffffdffc0000000 end: fffffdffc06b0000 name: [kernel.kallsyms]
refcnt: 1
kore map start: fffffdffc06b6000 end: fffffdffc0c80000 name: [kernel.kallsyms]
refcnt: 1
kore map start: fffffdffc0c84000 end: fffffdffc0f80000 name: [kernel.kallsyms]
refcnt: 1
kore map start: fffffdffc1000000 end: fffffdffc226e000 name: [kernel.kallsyms]
refcnt: 1
kore map start: fffffdffc2273000 end: fffffdffc2e6b000 name: [kernel.kallsyms]
refcnt: 1
kore map start: fffffdffc2e6b000 end: fffffdffc2e6f000 name: [kernel.kallsyms]
refcnt: 1
kore map start: fffffdffc2e71000 end: fffffdffc2e76000 name: [kernel.kallsyms]
refcnt: 1
kore map start: fffffdffc2e84000 end: fffffdffc2fc5000 name: [kernel.kallsyms]
refcnt: 1
kore map start: fffffdffc2fc6000 end: fffffdffc3800000 name: [kernel.kallsyms]
refcnt: 1
kore map start: fffffdffc8000000 end: fffffdffc8800000 name: [kernel.kallsyms]
refcnt: 1

You could see it's much more complex rather than only for kernel text section
and vmalloc region. We cannot only handle the case for the overlapping between
the text section and vmalloc region, it is possible for other maps to be
overlapping with each other.

And different arches have their own definition for the Kcore maps. This is why
I want to sort maps in this patch, it can allow us to find a reliable way to
append the kcore maps.

> James essentially fixed that by ensuring the kernel "replacement"
> map is inserted first.

Yeah, I agreed James' patch has fixed the kernel "replacement" map. But as I
elaborated above, there still have other maps might overlap with each other,
my understanding is we don't handle all cases.
> In other respects, the ordering of the maps does not matter, so
> I am not sure it is worth this extra processing.

To sell my patch, I have another point for why we need sorting Kcore maps.

Now Perf verifies the map in the function check_invariants(), this function
reports the broken issue, but we still have no clue how the broken issue happens.

If we can sort the Kcore maps in kcore_mapfn(), then we have chance to detect
the overlapping within maps, and then it can reports the overlapping in the
first place and this would be helpful for debugging and locating the failures.

So I have another patch for printing overlapping maps in kcore_mapfn(). I did
not send out the patch, as I found there have other logs in maps.c and
symbol.c should be improved a bit. So I am planning to send out a separate
patch series.

Please let me know if you still think this patch is not useful or not.

Thanks,
Leo
