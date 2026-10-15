Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C8C55C304;
	Thu, 15 Oct 2026 15:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792079917; cv=none; b=gWynKu3aRkXHkhDiqx+KMoMMm5H2QRlbpm46RyZ09JhUlNpaBQ0wcNtOEaqNzGn1diWWMf8KoFkJTrJ/UUG1Mx0wN1cw/32znuSoMeRle44svI69LA1OzW1Z67IVDTZwnV7+nMsEH97xxzZafg2gJhJL2drx0vmH8p67kXaj0kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792079917; c=relaxed/simple;
	bh=RwSvBW+5qY6o5GnUvl5eXAsWejcZRilDh8Rf5t5xz/4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Npoaqc5cQv3CRxLyOTqQxdsSY67q0jlLj8nDRQuXuOFpVFOTIFKd44hYgnBlcaNxpE+fZEoRFvQH/Nst0dQ7TCnR0kK7OZUsia3qXXitexwa8ASdBSqK6Vf2EEr68N0c+7oZgGhkEsGX2UzypGgRP0xvkpAXweOy2i9N6ylG+Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=NALJudrA; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="NALJudrA"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A18FD14BF;
	Thu, 15 Oct 2026 08:58:13 -0700 (PDT)
Received: from [172.29.20.205] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 62F583F7B4;
	Thu, 15 Oct 2026 08:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1792079896; bh=RwSvBW+5qY6o5GnUvl5eXAsWejcZRilDh8Rf5t5xz/4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NALJudrA4lgJCcD7bslUebtXL7OvBjAGi+CO8Ba2Y8hqJZODH17lbJCHoP/3KN4w9
	 n9EHXDnmE0SLze7joM8Fvv8V7AHUTQq6z1qhMLfhgGy7QKO84pNrCLm4FJ7RoPdssm
	 3mxoLY3x9XplYQpm8Mn0H8WOfEV+Zmkh6ByFBO/M=
Message-ID: <14d16970-915b-4c86-afeb-bfc3058564df@arm.com>
Date: Thu, 15 Oct 2026 10:58:10 -0500
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf: arm_spe: Support heterogeneous ACPI systems
To: Johnny Fan <johnny.fan@cixtech.com>, Marc Zyngier <maz@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, will@kernel.org, mark.rutland@arm.com,
 james.clark@linaro.org, leo.yan@arm.com, cix-kernel-upstream@cixtech.com,
 bob.zhang@cixtech.com, jie.fu@cixtech.com, fugang.duan@cixtech.com
References: <20261015062908.3565761-1-johnny.fan@cixtech.com>
 <86mrsf1bnv.wl-maz@kernel.org> <atC+lsWALy6ueGAB@JohnnyFan>
Content-Language: en-US
From: Jeremy Linton <jeremy.linton@arm.com>
In-Reply-To: <atC+lsWALy6ueGAB@JohnnyFan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 10/15/26 6:52 AM, Johnny Fan wrote:
> On Thu, Oct 15, 2026 at 11:49:24AM +0100, Marc Zyngier wrote:
>> This is a bit odd: at the beginning, you are stating that the SPE
>> interrupt being 0 is an indication of SPE not being supported. Then
>> you check for PMSVer for the same properly. This seems pretty wrong.
>>
>> It should be possible to build the mask of SPE-enabled CPUs without
>> IPI-ing the other CPUs, and only rely on the firmware table.
> 
> Agreed. The MADT walk already tells us which CPUs implement SPE, so the
> whole PMSVer probing (including the hotplug compensation for CPUs that
> were offline at probe time) can go away: the driver already consumes
> platform_get_irq_affinity(), so once the mask comes from the GICC
> entries it needs no changes at all.

I don't think the GICC is sufficient, you have to consider actual 
heterogeneous machines that have differing SPE implementations with the 
same PMSVer, which mean you have to keep the PPTT hetid check, and set 
the mask based on both it and the GSIV. Then, like DT create multiple 
platform devices. Which is true with the current patch as well, the 
hetid still needs to be there even if you have differing PPI's because 
it could have more than two differing implementations.


> 
>> This "optional" parameter feels very wrong. We now have an
>> infrastructure to get a set of affinities for an interrupt (see
>> 5324fe21ba9b7 and following patches). What this needs is ACPI to be
>> plumbed into this.
>>
>> Unfortunately, ACPI is awkward and very badly abstracted in this area,
>> but that doesn't mean we should make the driver code more bizarre.
>>
>> Treating SPE and TRBE differently is just as odd, and there is no
>> reason to do other than suiting your particular platform.
> 
> Also agreed -- the TRBE overflow interrupt has the same per-CPU
> semantics in the GICC, so both devices can share one code path: build
> the mask of CPUs reporting a non-zero interrupt, and require a single
> GSI across that mask. The current hetid check is replaced by the GSI
> consistency check.
> 
> The part I'm unsure about is how to convey the MADT-derived mask to
> platform_get_irq_affinity() for these devices: they are synthesized by
> arm_pmu_acpi.c without an fwnode, so neither the of_node path nor the
> _CRS-based ACPI path can reach them. Would you rather see the mask
> registered with the GIC domain keyed by GSI, with a fallback in
> get_irq_affinity() that resolves by IRQ number, or something simpler at
> the platform_device level?
> 
> Happy to implement whichever shape you prefer.
> 
> Thanks,
> 
> Johnny

