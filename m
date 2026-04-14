Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00DC13BED18;
	Tue, 14 Apr 2026 09:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776159171; cv=none; b=QuNeuNt8hODxJXolGhXLVH1nM2Yi2QqrrkYLaMQ1bsg4bHZAeinQ1EljWQjoXQTkU+wGMd3I4ZZNIIRw3RPMY8yqm2nFKE6zwsoImj5ihfbTUoSwLJMY8ihzYu1wdLFpxrYR/CITkO7csCfLZhIpgqHyW6ULxkETUxN3K6VVjGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776159171; c=relaxed/simple;
	bh=jTWzlRycGRpVWiKNXzA9qh3yTm1b3S1Q+nrZUipHBtI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kr7fjGM2O8fPyYoQn3qLv5v7E2GEct+HfhH3X+D5TWHSa3CxycdGElF57cV59THlx77ft7EjWX5Ukk9BxsQ3M74D935K6Vgqcizm7qfrcCJMYewC4aS6FPN6VWkmUUmZo0/5lXhTujwfcVBoEJ4foXHVOCCpVli8DHhWWwA+q2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=LCTzENxW; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="LCTzENxW"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B3F8B4ECD;
	Tue, 14 Apr 2026 02:32:40 -0700 (PDT)
Received: from [10.57.88.167] (unknown [10.57.88.167])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AFF293F7B4;
	Tue, 14 Apr 2026 02:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1776159166; bh=jTWzlRycGRpVWiKNXzA9qh3yTm1b3S1Q+nrZUipHBtI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LCTzENxWnWTYJde+K6dRWwtBKjvZj0Cebfia5XXWv2bCQlUKRgr+TmvN5yvRu1TZV
	 f15gaSehy9FlrMM9uWnPkl6z6TNHc4uMt+gvap1DeYMei7GMq7+yQy0fbJC7x/ok0v
	 aSy5rOSFG8Azu4jR/s2PuuRRhiaCd4QGYuKeZFDo=
Message-ID: <ba1c2728-218e-4f53-9b20-eebf26274ccc@arm.com>
Date: Tue, 14 Apr 2026 10:32:35 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] arm-smmu-v3: Add PMCG child support and update PMU
 MMIO mapping
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
References: <20260408-smmu-perf-v1-0-d75dac96e828@nxp.com>
 <2c1a1694-9597-400d-b441-714225b5377b@arm.com> <adZcaEKm3vIYSy3N@shlinux89>
 <65629411-0e1c-4c9c-bc9f-6488097bd77f@arm.com> <ad3w/P1vA2uKsV/o@shlinux89>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <ad3w/P1vA2uKsV/o@shlinux89>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-04-14 8:47 am, Peng Fan wrote:
> Hi Robin,
> 
> On Fri, Apr 10, 2026 at 01:07:29PM +0100, Robin Murphy wrote:
>> On 08/04/2026 2:47 pm, Peng Fan wrote:
>>> On Wed, Apr 08, 2026 at 12:15:31PM +0100, Robin Murphy wrote:
>>>> On 2026-04-08 8:51 am, Peng Fan (OSS) wrote:
>>>>> This patch series adds proper support for describing and probing the
>>>>> Arm SMMU v3 PMCG (Performance Monitor Control Group) as a child node of
>>>>> the SMMU in Devicetree, and updates the relevant drivers accordingly.
>>>>>
>>>>> The SMMU v3 architecture allows an optional PMCG block, typically
>>>>> associated with TCUs, to be implemented within the SMMU register
>>>>> address space. For example, mmu700 PMCG is at the offset 0x2000 of the
>>>>> TCU page 0.
>>>>
>>>> But what's wrong with the existing binding? Especially given that it even has
>>>> an upstream user already:
>>>>
>>>> https://git.kernel.org/torvalds/c/aef9703dcbf8
>>>>
>>>>> Patch 1 updates the SMMU v3 Devicetree binding to allow PMCG child nodes,
>>>>> referencing the existing arm,smmu-v3-pmcg binding.
>>>>>
>>>>> Patch 2 updates the arm-smmu-v3 driver to populate platform devices for
>>>>> child nodes described in DT once the SMMU probe succeeds.
>>>>>
>>>>> Patch 3 updates the SMMUv3 PMU driver to correctly handle MMIO mapping when
>>>>> PMCG is described as a child node. The PMCG registers occupy a sub-region
>>>>> of the parent SMMU MMIO window, which is already requested by the SMMU
>>>>
>>>> That has not been the case since 52f3fab0067d ("iommu/arm-smmu-v3: Don't
>>>> reserve implementation defined register space") nearly 6 years ago, where the
>>>> whole purpose was to support Arm's PMCG implementation properly. What kernel
>>>> is this based on?
>>>
>>> Seems I am wrong. I thought PMCG is in page 0, so there were resource
>>> conflicts. I just retest without this patchset, all goes well.
>>>
>>> But from dt perspective, should the TCU PMCG node be child node of
>>> SMMU node?
>>
>> No. PMCGs can be used entirely independently of the SMMU itself, and while
>> most of the events do relate to SMMU translation and thus aren't necessarily
>> meaningful if it's not in use, there are still some which can be useful for
>> basic traffic counting, monitoring GPT/translation activity from _other_
>> security states (if observation is delegated to Non-Secure) and possibly
>> other things, even if the "main" Non-Secure SMMU interface isn't advertised
>> at all. It would be unreasonable to require the SMMU node to be present and
>> enabled *and* have a driver to populate PMCGs, to monitor events which are
>> outside the scope of that driver.
> 
> Thanks for explaining this in detail.
> 
> Just have one more question, we are using mmu-700, but MMU-700 implementation
> defined TCU and TBU events are not supported.
> 
> Should we introduce a compatible string saying "arm,mmu700-tcu-pmcg" or
> "arm,mmu700-tbu-pmcg"? TBH, I have not checked MMU600(AE) or else.

MMU-700 and all other Arm implementations are still fully compatible 
with "arm,mmu-600-pmcg" in terms of what that means. That lets the 
driver correctly construct the "identifier" attribute, which then allows 
userspace to know what exact PMU implementation it is.

We don't maintain ever-growing lists of aliases for imp-def events in 
the kernel driver, same as we don't for CPU PMUs either. Generally, 
anyone who has reason to go near those is likely to already have the TRM 
to hand and thus have the encodings anyway, but I suppose you could add 
jevents with the proper meaningful descriptions if you really wanted to.

Thanks,
Robin.
