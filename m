Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A971E0DCB;
	Fri, 18 Jul 2025 20:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752871566; cv=none; b=t7TXZH8yKRT2uiE1UXQHOYB8AqKf1/n5rh7GeCiCML1ym0lDOTtLkwbBJo+wjpXD3QM3yj+G13kEfDC60bvGnVtC6agRp8TrcWAMR+U+rGi45YKEt4+Xn7WJjt4Ced5I5iOTGxivme/O0jErMSI2a0MAh3l+aJvTXPbQPQwEA+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752871566; c=relaxed/simple;
	bh=uXAK2LcN+D1aB2LwqkwZRyXZHRbBhvjT7o6KbAa+ppk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GY0HganyK4cEcXLq2FdEuR7eixw3bjYmgA844XVYm6ec74kzw4nYnyFscPiKq/i5T6ZOE9du3yVrU/0yhsTWtbXDIdvm5jbIUFZkRoZVGnKvqzE2oDtEKv/A+o8xbW2WQvdMIOZjY4TK7fcv957vyQlCf2QDUT6fcUg3NpExBx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T+BRTgRM; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T+BRTgRM"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2352400344aso23545195ad.2;
        Fri, 18 Jul 2025 13:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752871564; x=1753476364; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uXAK2LcN+D1aB2LwqkwZRyXZHRbBhvjT7o6KbAa+ppk=;
        b=T+BRTgRMn94IrvUTdoX2H+Zsu1XQkEFi6rSIwZ6rU+JiM9vcQLljDWtHcaTLLTOKls
         PDUEdU++7SSgjtuKHXEFLMt//1HsQiUNqc88lsqDZtHF+FLGRxXGJ9i577a+TuuIp9fi
         CpmpOPvnIgoix1wXHtnZFz2Y2+r+GAz8YGDIX3Nz1WptJ7S9jeIae3M9jcAx8v9tyHHE
         UvP5mk6qZNhZxOgvjsXtcllri0rn2se4dt3qr3+n0mfCKB9EdW69rHBHuuPnNaEd7XsD
         asEwNy7Uiq9hqNK8Zyo/5rLGnQGSqrnRa821MfVujRUvBUm6HTf9JbcF55t5FJv0aNdk
         o7JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752871564; x=1753476364;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uXAK2LcN+D1aB2LwqkwZRyXZHRbBhvjT7o6KbAa+ppk=;
        b=PdxzQV+GFaeYr2z2JZh7WuufzJUVXyatnEZQymqXDNM1vGFxKQrylQW7gpQlRoXw9T
         HBptBdRgDVfVEt9YHYg8D7sKqjZgQtEnolemC1SqP1PFBXaAbro20Qh/6cpdklN/Uczr
         M/EFzqorR3WgwLdNTqJrmQC6GNDKgQpKxRwtwsL8USXEtnmeXBwqo0/dzBCsneGw96ep
         mzdKwG74EhcFc4mQnfGajFfeMzZA7Dy9Gd38bAZeVtN5hzD7/Q35uJvSkYLKRmJFNhvW
         xotSBv2KVSJ8pI9eUcBUNXMIOqguMVAshTgPFvertHV4rueAG+T7GoOYKqq9TyKrLOX6
         EHPw==
X-Forwarded-Encrypted: i=1; AJvYcCW/jFb385JOhFAR+OxIQDe6IaEM7lM1pzS8n4TmHTgg8slO+sjPvJAvEzvhPwzpLUQ2luRgLSj5yf71ojE9@vger.kernel.org, AJvYcCXKV0MUkMFWqvJYJeY3udCWl3Fqg59ttzAF6NgAOhOnGzjONFkfD4Oyaa5u0s0zLLKugwV8d2LfCqDp@vger.kernel.org, AJvYcCXxXD6z0lHert2a+IyreLLixvGuiF0UKX2JxMCnuY/2tsfwrVffeSbXiwy8sOyS75isDEOJLz1HrVWO8uEf8Sd26w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxFKhUtJJIkL7AA5rHufSmstDOpwe5GSF4XEHj+lk9puyrWqkIE
	b+TX7ga/q6WGCq1hCFHYL3Qu6nMVbl7HKBzpp/7VOx/IwNeGEdC3TYGr
X-Gm-Gg: ASbGncsK2TYXSmUhd8g58u72nCGWUhn8/KGzj+6vZrVlc0K5AiwFNMTyY8/z8MMtmGF
	Ky78VRduDTyUT3AE7/dUfMuSHOoqMY5kcrQBDus5RBRm1u3CdE+iFLXeU5tZcjWWV9REQDtp/xs
	K6XHgNCj3HZLKQsq/I7Yj/4sOmMIL/FbRsKTdeeu81Ka1XEAFani1DXSTZwufdwNmqNUwHiPWBa
	jXSkntJHQVJP1NjTHFJ6Nnw1WMEui/p6mkb94/G4P18+2x3K5VkroW6FMXy5YYAFoZcHytVjHj7
	WmUqdnlA6M70guXFzIU/shFtKTjRMiijTFJiMsn9yWXTorQNpIi5/Bg5GhpGsnN8PLa5wjgoDhx
	P3GuQtIRoAJ6Xpe3aZpnpnqDW+TRAv8ErTqmxZ6iMbCHYnbUN59CUOVVAHe1fpYE=
X-Google-Smtp-Source: AGHT+IFfAzmfpnYky0WJeFj+PkACVQRkUKSaLnIxhEt/NV8Uzws4ecq5iTsonExxyL5PHW/z3ZTr5A==
X-Received: by 2002:a17:90b:3cc6:b0:30a:4874:5397 with SMTP id 98e67ed59e1d1-31c9e6fbb09mr17031670a91.9.1752871563843;
        Fri, 18 Jul 2025 13:46:03 -0700 (PDT)
Received: from [192.168.0.109] (061092221177.ctinets.com. [61.92.221.177])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b61566bsm17746325ad.81.2025.07.18.13.46.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jul 2025 13:46:03 -0700 (PDT)
Message-ID: <2b69fbd1-067e-4ff4-8ea4-88e32763209a@gmail.com>
Date: Sat, 19 Jul 2025 04:45:58 +0800
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
 <705f1dfb-7e1b-4930-a1a9-c763299a4305@gmail.com>
 <aHph5u4-b6mfggPv@J2N7QTR9R3>
Content-Language: en-US
From: Nick Chan <towinchenmi@gmail.com>
In-Reply-To: <aHph5u4-b6mfggPv@J2N7QTR9R3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


Mark Rutland 於 2025/7/18 夜晚11:01 寫道:
> On Fri, Jul 18, 2025 at 01:00:45AM +0800, Nick Chan wrote:
>> On 17/7/2025 23:05, Mark Rutland wrote:
>>> On Mon, Jul 14, 2025 at 11:59:36PM +0800, Nick Chan wrote:
>>>> Will Deacon 於 2025/7/14 夜晚11:12 寫道:
>>>>> On Mon, Jun 16, 2025 at 09:31:49AM +0800, Nick Chan wrote:
>>>>>> Patch 8-12 adds support for the older SoCs.
>>>>> ... but I'm not sure if anybody actually cares about these older SoCs
>>>>> and, even if they do, what the state of the rest of Linux is on those
>>>>> parts. I recall horror stories about the OS being quietly migrated
>>>>> between CPUs with incompatible features, at which point I think we have
>>>>> to question whether we actually care about supporting this hardware.
>>>> The "horror" story you mentioned is about Apple A10/A10X/T2, which
>>>> has a big little switcher integrated into the cpufreq block, so when the
>>>> cpufreq driver switch between states in the same way as on other
>>>> SoCs, on these SoCs that would silently cause a CPU migration. There
>>>> is only one incompatible feature that I am aware of which is 32-bit EL0
>>>> support.
>>> Surely the MIDR/REVIDR/AIDR also change?
>> They do not change. ID_AA64PFR0_EL1 also does not change (fixed 0x12).
>> What *does* change however is MPIDR. (P-cores has bit 16 set while
>> E-cores do not)
> The MPIDR changing isn't ok either. You might get away with that today,
> but that's not supposed to change behind the back of the kernel.
>
> Is there anything else that can change, or are we absolutley certain
> that *only* MPIDR changes?

Only MPIDR changes, and the state of bit 16 in MPIDR is consistent across all PEs. (At any
given moment, either all PEs are backed by efficiency cores, or all backed by performance
cores)

>
>>>> As mentioned above, it does all work fine when CONFIG_EXPERT is not
>>>> enabled, and if it is enabled, then 32-bit process may crash with illegal
>>>> instruction but everything else will still works fine.
>>> I don't think that's quite true, unless these parts are also violating
>>> the architecture.
>>>
>>> If the CPU doesn't implement AArch32, then an ERET to AArch32 is
>>> illegal. The way illegal exception returns are handled means that this
>>> will result in a (fatal) illegal execution state exception being taken
>>> from the exception return code in the kernel, not an UNDEF being taken
>>> from userspace that would result in a SIGILL.
>> Speaking from experience, when testing with the userspace cpufreq governor,
>> trying to run AArch32 code on the ecores really does result in illegal
>> instruction for that process while everything else remains fine.
>>
>> Referencing ID_AA64PFR0_EL1, the E-cores does claim to support
>> AArch32 EL0, even though they could not execute it for real.
> Ok, so that's a clear violation of the architecture, and doesn't fill me
> with confidence about anything else.

Regarding this, the hardware also needs to handle the case where the PE is already in AArch32
EL0 and migration to E-cores is attempted. In this case there is no exception return happening so
the behavior of the hardware is not as bad as it sounds.


>
>>> I do not think that we should pretend to support hardware with silent
>>> microarchitectural migration. So at the very least, we do not care about
>>> A10/A10X/T2.
>> As explained above, what actually happens on the hardware is different
>> from what you believed, so please do reconsider.
> Different certainly, but still problematic.
>
> I maintain that we should not pretend to support this hardware.
>
> Mark.
>
Nick Chan
