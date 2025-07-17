Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A2C2FD592;
	Thu, 17 Jul 2025 17:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752771653; cv=none; b=EdJlgNB7bgDO9cn9J7IDOjzdgdI8BTK/Wc9/llpBTNQjEz3sq4e+4S36ItdITETq+ifoHvJ49RPhYVDmPynnpzL2wj1jd3FF8q6QTcKU1W3oNPrtfFXvCuVIQRSmqVhshxjNizKipxFnUuFiucvF6Debd95kkKnhO6brRO57taM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752771653; c=relaxed/simple;
	bh=liaFGidYVLjXLMjJq2TgiaFPgWZ7yuecTZN6udCP75E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uVZRoXuAdueP62evZd8rYbaRtgF+F94VTJ3rLmm75BamiVL90rHrCN01rKBwXG65aJZrk1HvdPwXesCygwb0apLEQlyxgOO+gDq5PJFZQoG0CV2D3WRkBRmZ7jjAr7qPD9aGTVX86xWEjDspHNER7SXFtqsi7/EcaXMRHCtL/c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tmu0i4aY; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tmu0i4aY"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-74b27c1481bso871509b3a.2;
        Thu, 17 Jul 2025 10:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752771652; x=1753376452; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DOniWzPOxX9jgReodjZJuovKYF0NJcq9l0SRTKIVr/w=;
        b=Tmu0i4aYPfVxpHxy2TBK+CJr8ONIUrlHzfZyRbMhOv/cA/PBNXcYgHkmwBcNJpyUZz
         TSPCzG1EFFwGGSYrWtYQPGx7wdF37qI7HdRKJbgs4HBBFYOPLY+qKHhj3IgLVpoOFk34
         widOQMSZq++Taa48kjA/zwWU3HfN2uiEVgbUCc37jx9szzXf+KELpLv23786BzCAuOOn
         /vIH6M0ioRV6xe7NDd0TZCz9tHeMGdTqS89gKV+2PSPYvQvgdr7doXzJulpgxd9wt+7k
         y0VFxKSz48dyTjVuZ6D0pgLmpDGpzowYMlEyCdwf3M47+YSiDoffz+9Xjn5cAmQcUHvD
         rW2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752771652; x=1753376452;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DOniWzPOxX9jgReodjZJuovKYF0NJcq9l0SRTKIVr/w=;
        b=R9jbFFLo/4G/uLSUu4M0j4uPUq63l6jINkNdHzJkivrOkgaWGLlH33FkmPwExU250u
         GSnsnCaCu0cUoB8dXux60hpWrK518un3zB/YqsYUoUD7c2eCCyhR/sWj8QVGuLHJ2IP8
         Qrilb+DCAVNI5mFA/8jhU3uDJCDyC9BDcg+NorBnTC4Ob4UYRyOq4020kyhqUrEAPoF2
         cbAWiw1NaC/uivfraX8SfXaUac8eL2SvAFWdBxfiqgEzrslli2rDtvvyKrzwKXEXHmCt
         wk2U64NBrnU4ZizyKuxe66hxI1bmjq4QQSSCcpYgUG4lG3id6U2rYiGzUEM6qOXH+FC3
         V+8w==
X-Forwarded-Encrypted: i=1; AJvYcCVaB4xGoUffRVsAEy3OufO3gm5YUj7rWdeg1izGFj2edOxqVQ3w/qCJQqb9oOE0iBEpJTOS/UApqC9Ba4Mr@vger.kernel.org, AJvYcCVhEddboVZpASb4IjJ+LKJ4FiNBVmp4GidtnRuNTcc9p/6KvtESXQfPk6Kbg+pNNSW43CyYFkkagF15@vger.kernel.org, AJvYcCXUBYW4Jrd69p3tEcBz/ZJDmblTXUyXjx6vNjKi8dzHJbZ4IeFaSvtLwNARIoBU1YCx/xJ9kLWrc3eInhoKIik8hQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzeSkN3d7llenDBElgZsZoiGjOf+o7PYcOTX9WRJEu+nRPjBCN2
	4+biofZG4E8DN2/PeQv4Uwp53XDrE5IJhN5OF/fJmb2uWIOuq6A0nZ+i
X-Gm-Gg: ASbGnctJiGXqdbR8pTbdZURxhtqvD90dTlAAD55Bcvqas589SOpL6O53imB+lL3WKP8
	+WWN59NJe7RHBo+OrJruvygXNfvQlegGbZK3CAZTT9YqQqcgeuqCip37bGh8TjVK3d/gQ5xRON1
	q7PhO4j/sRu/gj97mNhl1iypCaBmwTmecKHf4cVZteutuK052iyTTN4nRvvAEZbrOR298vz3PEG
	Z5CuTLIvIu//PJ8juHF2ZOM8qq49pUkPhfBiI3UEM6FsdrShQQGXsktQXEAK92QzUgqethl4Nvg
	VQ51/rRrK8nwb6vNekESSEimD45ZWCVJXwlZmKeBztEmyt8b/3gtkFFhH/LBMtC9y/l1vM4pivV
	tSK4SfOK0uK5unWcZh4aLgc5Fy0AzbE4OnJ23WlrFiEu0T6BO4HXS
X-Google-Smtp-Source: AGHT+IGyNwD+GplSMpIC4979Lc0tZ79C1WbX1oV52D7ggC14zrY8YjV3rk07eXSBZ3Eq+1KJC2sDsA==
X-Received: by 2002:a05:6a00:3e0a:b0:742:aecc:c46b with SMTP id d2e1a72fcca58-756e99fc423mr10406870b3a.15.1752771651493;
        Thu, 17 Jul 2025 10:00:51 -0700 (PDT)
Received: from [192.168.0.113] (061092221177.ctinets.com. [61.92.221.177])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9dd59f1sm15902818b3a.3.2025.07.17.10.00.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 10:00:50 -0700 (PDT)
Message-ID: <705f1dfb-7e1b-4930-a1a9-c763299a4305@gmail.com>
Date: Fri, 18 Jul 2025 01:00:45 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v7 00/21] drivers/perf: apple_m1: Add Apple A7-A11,
 T2 SoC support
To: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Janne Grunau <j@jannau.net>, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
 Neal Gompa <neal@gompa.dev>, Sven Peter <sven@kernel.org>,
 Marc Zyngier <maz@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org,
 asahi@lists.linux.dev, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20250616-apple-cpmu-v7-0-df2778a44d5c@gmail.com>
 <aHUeUMmn_19EayL1@willie-the-truck>
 <be327242-ad55-476a-bed4-44c33c263962@gmail.com>
 <aHkRJdAuvhS2mNQj@J2N7QTR9R3>
Content-Language: en-MW
From: Nick Chan <towinchenmi@gmail.com>
In-Reply-To: <aHkRJdAuvhS2mNQj@J2N7QTR9R3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 17/7/2025 23:05, Mark Rutland wrote:
> On Mon, Jul 14, 2025 at 11:59:36PM +0800, Nick Chan wrote:
>>
>> Will Deacon 於 2025/7/14 夜晚11:12 寫道:
>>> On Mon, Jun 16, 2025 at 09:31:49AM +0800, Nick Chan wrote:
>>>> This series adds support for the CPU PMU in the older Apple A7-A11, T2
>>>> SoCs. These PMUs may have a different event layout, less counters, or
>>>> deliver their interrupts via IRQ instead of a FIQ. Since some of those
>>>> older SoCs support 32-bit EL0, counting for 32-bit EL0 also need to
>>>> be enabled by the driver where applicable.
>>>>
>>>> Patch 1 adds the DT bindings.
>>>> Patch 2-7 prepares the driver to allow adding support for those
>>>> older SoCs.
>>> Modulo my nits, the patches look alright to this point...
>>>
>>>> Patch 8-12 adds support for the older SoCs.
>>> ... but I'm not sure if anybody actually cares about these older SoCs
>>> and, even if they do, what the state of the rest of Linux is on those
>>> parts. I recall horror stories about the OS being quietly migrated
>>> between CPUs with incompatible features, at which point I think we have
>>> to question whether we actually care about supporting this hardware.
>> The "horror" story you mentioned is about Apple A10/A10X/T2, which
>> has a big little switcher integrated into the cpufreq block, so when the
>> cpufreq driver switch between states in the same way as on other
>> SoCs, on these SoCs that would silently cause a CPU migration. There
>> is only one incompatible feature that I am aware of which is 32-bit EL0
>> support.
> 
> Surely the MIDR/REVIDR/AIDR also change?
They do not change. ID_AA64PFR0_EL1 also does not change (fixed 0x12).
What *does* change however is MPIDR. (P-cores has bit 16 set while
E-cores do not)

> 
> In general, silent migration isn't acceptable for the kernel, even if
> you largely happen to get away with that today. It is not acceptable for
> architectural feature support to change dynamically.
> 
>> However, since the CPUs in these SoCs does not support
>> 4K pages anyways in practice this is not an issue for as long as
>> CONFIG_EXPERT is disabled.
> 
> Do these parts have EL2?
No.

> 
>>> On the other hand, if it all works swimmingly and it's just the PMU
>>> driver that needs updating, then I could get on board with it.
>>
>> As mentioned above, it does all work fine when CONFIG_EXPERT is not
>> enabled, and if it is enabled, then 32-bit process may crash with illegal
>> instruction but everything else will still works fine.
> 
> I don't think that's quite true, unless these parts are also violating
> the architecture.
> 
> If the CPU doesn't implement AArch32, then an ERET to AArch32 is
> illegal. The way illegal exception returns are handled means that this
> will result in a (fatal) illegal execution state exception being taken
> from the exception return code in the kernel, not an UNDEF being taken
> from userspace that would result in a SIGILL.
Speaking from experience, when testing with the userspace cpufreq governor,
trying to run AArch32 code on the ecores really does result in illegal
instruction for that process while everything else remains fine.

Referencing ID_AA64PFR0_EL1, the E-cores does claim to support
AArch32 EL0, even though they could not execute it for real.

> 
> I do not think that we should pretend to support hardware with silent
> microarchitectural migration. So at the very least, we do not care about
> A10/A10X/T2.
As explained above, what actually happens on the hardware is different
from what you believed, so please do reconsider.

> 
> Mark.

Nick Chan

