Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BEFC1DE3A3;
	Wed, 19 Feb 2025 13:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739970980; cv=none; b=jorri6wAPUG1IeB0+rSrdSOD4M9ff8hbc+Cz5LZ1chXZtRmBVK8TgUMOh697JiybFJHeECFTCCuPf0DXpeUD5dZjQ2OQvyhghEiScwePR5WE1Ui0+zIG+0Qc7uTczrzyy51QGy3fZ5CnRoTW9zlbhaPP1+a6N1rCKiuMfcv8H/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739970980; c=relaxed/simple;
	bh=r8blyfKkoBgz4CM/Mt3oOpqJ2xEDBrmHNX5i0zDp4Io=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TwlFHIK0nE3UF0QTus7pXVKA44UP7QrZm62cWfpzEa1RaVomPc+33WV8BE0Gz01aWR9w6WzlpRw2bgTchxSzrIB4hI8s35THIX4073kZjPDIIuwebL4inotHvthLC8Cs/6dWpghtqJ5QVF0GnCPCzRRXFzq6NpX3G2XORLXb4Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DAFC51682;
	Wed, 19 Feb 2025 05:16:35 -0800 (PST)
Received: from [10.57.36.80] (unknown [10.57.36.80])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 038E53F59E;
	Wed, 19 Feb 2025 05:16:15 -0800 (PST)
Message-ID: <a94c0622-ae31-46f1-b51e-a344b86aa47c@arm.com>
Date: Wed, 19 Feb 2025 13:16:13 +0000
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
 linux-kernel@vger.kernel.org, jie.li.linux@linux.alibaba.com,
 renyu.zj@linux.alibaba.com
References: <20250218012111.30068-1-fengwei_yin@linux.alibaba.com_quarantine>
 <d5040b5c-564d-4abf-be22-d2aa1183b633@arm.com>
 <hfip42i45jkumuvgdthxm2bk6qylqyqh6erzaq43yiqygvn6uu@dcui675lwtkm>
 <73af368a-52a9-4922-876b-7a6e2d32a94e@arm.com>
 <gfgtxwe3fmh4unleypyrp2qxchrqcz7wqzyoy7om2zjqev6ggf@gnnqnmusecc3>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <gfgtxwe3fmh4unleypyrp2qxchrqcz7wqzyoy7om2zjqev6ggf@gnnqnmusecc3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-02-19 1:50 am, YinFengwei wrote:
> Add Jing Zhang as we will continue discussion in this thread.
> 
> On Tue, Feb 18, 2025 at 12:31:10PM +0800, Robin Murphy wrote:
>> On 2025-02-18 10:58 am, YinFengwei wrote:
>>> On Tue, Feb 18, 2025 at 10:31:42AM +0800, Robin Murphy wrote:
>>>> On 2025-02-18 1:21 am, Yin Fengwei wrote:
>>>>> Currently, arm-cmn PMU driver assumes ACPI claim resource
>>>>> for CMN600 + ACPI. But with CMN700 + ACPI, the device probe
>>>>> failed because of resource claim failes when ioremap() is
>>>>> called:
>>>>> [   10.837300] arm-cmn ARMHC700:00: error -EBUSY: can't request region for resource [mem 0x40000000-0x4fffffff]
>>>>> [   10.847310] arm-cmn ARMHC700:00: probe with driver arm-cmn failed with error -16
>>>>> [   10.854726] arm-cmn ARMHC700:02: error -EBUSY: can't request region for resource [mem 0x40040000000-0x4004fffffff]
>>>>> [   10.865085] arm-cmn ARMHC700:02: probe with driver arm-cmn failed with error -16
>>>>>
>>>>> Let CMN700 + ACPI do same as CMN600 + ACPI to allow CMN700
>>>>> work in ACPI env.
>>>>
>>>> No, the CMN-600 routine is a special case for CMN-600 having two nested
>>>> memory resources of its own. CMN-700 and everything else only have one
>>>> memory resource, so that is not appropriate. What else is claiming the
>>>> region to cause a conflict?
>>> Sorry. Forgot the link for the new proposed fix:
>>> https://lore.kernel.org/all/Z7QYlUP6nfBNMXsv@U-V2QX163P-2032.local/
>>
>> Yes, I saw that. It's a broken diff that won't even compile, with no
>> explanation of what it's supposed to be trying to achieve or why. I'm not
>> sure what you're asking me to comment on.
> My bad. I will attatch the full patch at the end of this mail.
> 
>>
>>> My understanding is that there are two problems here:
>>> 1. ACPI claim the memory range and that's why we see this -EBUSY error
>>>      with correct code path for CMN700 + ACPI table.
>>
>> No, it's fine to claim the exact *same* range that the ACPI companion owns;
>> the identical requests just nest inside each other. I don't have a CMN-700
>> to hand but here's a selection of other drivers doing just that from
>> /proc/iomem on my system:
>>
>> 12600000-12600fff : ARMH0011:00
>>    12600000-12600fff : ARMH0011:00 ARMH0011:00
>> 12610000-12610fff : ARMH0011:01
>>    12610000-12610fff : ARMH0011:01 ARMH0011:01
>> 126b0000-126b0fff : APMC0D0F:00
>>    126b0000-126b0fff : APMC0D0F:00 APMC0D0F:00
>> 126f0000-126f0fff : APMC0D81:00
>>    126f0000-126f0fff : APMC0D81:00 APMC0D81:00
> I believe this works only for parents/children resource node. Otherwise,
> there will be conflict.

I don't understand what you mean by that. The point here is that these
are simple devices with a single memory resource (just like CMN-700),
where in each case, a driver using devm_{platform_}ioremap_resource()
(just like arm-cmn) has happily claimed (2nd line) the same resource
already defined by the ACPI layer (1st line). Admittedly it's a little
unclear since they both use the same name, but still.

>>
>> And I know people are using the CMN-700 PMU on other ACPI systems without
>> issue, so there's nothing wrong with the binding or the driver in general.
>>
>> The resource conflict only arises when a request overlaps an existing region
>> inexactly. Either your firmware is describing the CMN incorrectly, or some
>> other driver is claiming conflicting iomem regions for some reason.
> No. It's not ACPI table problem. The problem is mentioned in comments of
> function arm_cmn600_acpi_probe():
>          /*
>           * Note that devm_ioremap_resource() is dumb and won't let the platform
>           * device claim cfg when the ACPI companion device has already claimed
>           * root within it. But since they *are* already both claimed in the
>           * appropriate name, we don't really need to do it again here anyway.
>           */

Sigh... No, this is unique to CMN-600, because only the CMN-600 ACPI
binding depends on nested resources, such that the resource tree
starts off looking like this:

50000000-5fffffff : ARMHC600:00
   50d00000-50d03fff : ARMHC600:00

If we wanted to, we can still quite happily claim the root node
resource:

--- a/drivers/perf/arm-cmn.c
+++ b/drivers/perf/arm-cmn.c
@@ -2410,6 +2410,8 @@ static int arm_cmn600_acpi_probe(struct platform_device *pdev, struct arm_cmn *c

         if (!resource_contains(cfg, root))
                 swap(cfg, root);
+
+       devm_request_mem_region(cmn->dev, root->start, resource_size(root), "arm-cmn!");
         /*
          * Note that devm_ioremap_resource() is dumb and won't let the platform
          * device claim cfg when the ACPI companion device has already claimed


...which then nests like so:

50000000-5fffffff : ARMHC600:00
   50d00000-50d03fff : ARMHC600:00
     50d00000-50d03fff : arm-cmn!

but what we cannot do is claim the whole 50000000-5fffffff region again
because that cannot nest within the existing 50d00000-50d03fff region.

> So I suppose for ACPI env, we should use devm_ioremap() as cmn600 does.
> And make CMN700 handling follow spec exactly.

As I said, the driver already supports the CMN-700 APCI binding
perfectly well. If your CMN is described correctly then you need to
answer my question of what *other* driver is claiming conflicting
resources and why (and if so, also why that should be specific to ACPI).

Thanks,
Robin.
