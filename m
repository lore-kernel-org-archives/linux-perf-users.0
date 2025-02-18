Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33C15243380;
	Tue, 18 Feb 2025 12:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739881876; cv=none; b=r66ZYTMNJCNby4+cdqNoCcRv5QXtSSg5fEBdMcGvIvkJZ4CNVx8ESKFGMEKgdE/34eKAVl2K1jRulOYFBkNOHUpVWmfaOOnKe/o6Thf96augkzu7PNBE0l4heCIrXLx0zF3z+WCIgDBb67e44xMqXzA6ZbFUEtXxWCtLK4YhJ+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739881876; c=relaxed/simple;
	bh=UREQx1QiFfaY2UPNb9bjho5eHty8COPp2aRUNeqKbZk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c6U+lKbWClYGduAj697doMQaFMRIum9gr3t/kkzBHB7GoD19C9rGAVP0NE8zqCoS41iraN56j7aGJVOlp8kkONF2x4iNykVUVkdg7j438MwWcEc3wCQatSaBWCpUyM3HnwT8N1JRerAQXmsY8+w0OlILqSotQo0HlaB1SeyITIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6B98D152B;
	Tue, 18 Feb 2025 04:31:32 -0800 (PST)
Received: from [10.1.39.25] (010265703453.arm.com [10.1.39.25])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 52AD63F59E;
	Tue, 18 Feb 2025 04:31:12 -0800 (PST)
Message-ID: <73af368a-52a9-4922-876b-7a6e2d32a94e@arm.com>
Date: Tue, 18 Feb 2025 12:31:10 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/arm-cmn: don't claim resource during ioremap() for
 CMN700 with ACPI
To: YinFengwei <fengwei_yin@linux.alibaba.com>
Cc: will@kernel.org, mark.rutland@arm.com,
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, jie.li.linux@linux.alibaba.com
References: <20250218012111.30068-1-fengwei_yin@linux.alibaba.com_quarantine>
 <d5040b5c-564d-4abf-be22-d2aa1183b633@arm.com>
 <hfip42i45jkumuvgdthxm2bk6qylqyqh6erzaq43yiqygvn6uu@dcui675lwtkm>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <hfip42i45jkumuvgdthxm2bk6qylqyqh6erzaq43yiqygvn6uu@dcui675lwtkm>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-02-18 10:58 am, YinFengwei wrote:
> On Tue, Feb 18, 2025 at 10:31:42AM +0800, Robin Murphy wrote:
>> On 2025-02-18 1:21 am, Yin Fengwei wrote:
>>> Currently, arm-cmn PMU driver assumes ACPI claim resource
>>> for CMN600 + ACPI. But with CMN700 + ACPI, the device probe
>>> failed because of resource claim failes when ioremap() is
>>> called:
>>> [   10.837300] arm-cmn ARMHC700:00: error -EBUSY: can't request region for resource [mem 0x40000000-0x4fffffff]
>>> [   10.847310] arm-cmn ARMHC700:00: probe with driver arm-cmn failed with error -16
>>> [   10.854726] arm-cmn ARMHC700:02: error -EBUSY: can't request region for resource [mem 0x40040000000-0x4004fffffff]
>>> [   10.865085] arm-cmn ARMHC700:02: probe with driver arm-cmn failed with error -16
>>>
>>> Let CMN700 + ACPI do same as CMN600 + ACPI to allow CMN700
>>> work in ACPI env.
>>
>> No, the CMN-600 routine is a special case for CMN-600 having two nested
>> memory resources of its own. CMN-700 and everything else only have one
>> memory resource, so that is not appropriate. What else is claiming the
>> region to cause a conflict?
> Sorry. Forgot the link for the new proposed fix:
> https://lore.kernel.org/all/Z7QYlUP6nfBNMXsv@U-V2QX163P-2032.local/

Yes, I saw that. It's a broken diff that won't even compile, with no 
explanation of what it's supposed to be trying to achieve or why. I'm 
not sure what you're asking me to comment on.

> My understanding is that there are two problems here:
> 1. ACPI claim the memory range and that's why we see this -EBUSY error
>     with correct code path for CMN700 + ACPI table.

No, it's fine to claim the exact *same* range that the ACPI companion 
owns; the identical requests just nest inside each other. I don't have a 
CMN-700 to hand but here's a selection of other drivers doing just that 
from /proc/iomem on my system:

12600000-12600fff : ARMH0011:00
   12600000-12600fff : ARMH0011:00 ARMH0011:00
12610000-12610fff : ARMH0011:01
   12610000-12610fff : ARMH0011:01 ARMH0011:01
126b0000-126b0fff : APMC0D0F:00
   126b0000-126b0fff : APMC0D0F:00 APMC0D0F:00
126f0000-126f0fff : APMC0D81:00
   126f0000-126f0fff : APMC0D81:00 APMC0D81:00

And I know people are using the CMN-700 PMU on other ACPI systems 
without issue, so there's nothing wrong with the binding or the driver 
in general.

The resource conflict only arises when a request overlaps an existing 
region inexactly. Either your firmware is describing the CMN 
incorrectly, or some other driver is claiming conflicting iomem regions 
for some reason.

Thanks,
Robin.

> 2. It's not correct to apply CMN600 probe method to CMN700 because
>     CMN600 has two nested memory resouces while CMN700 should only have
>     one memory resource. And you don't want to introduce trick to handle
>     incorect ACPI DSDT.
> 
> Regards
> Yin, Fengwei
> 
>>
>> Thanks,
>> Robin.

