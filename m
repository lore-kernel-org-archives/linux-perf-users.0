Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E37125F7BF
	for <linux-perf-users@vger.kernel.org>; Mon,  4 Aug 2025 16:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754323219; cv=none; b=dUdzAyddNKk9XaavEIjdDgDkWNUuPcmpHzGYaw3z5SrkiLUJHjTkQV5ItMPucBKGVlObNptDgzc3vfmaNMxk4iBtNt1vwH+31wP/R94n/5E116LK7wG6oLtCRT3sSYEniuWN7iOCHtK79eZHnA6EvPsVQ3QkhMhv9PSC4jMH7+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754323219; c=relaxed/simple;
	bh=sO30oNJNat2gEn/DA4kZKK55EVzR2yM7U8PKO9ntHlo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I+zcnb899t5cWHyWFJ/tha2FkyrTed9oTDIvmDuosV0q/dImFoMOJ5U25ZUFs3Ivg6vRRHMT8DuMlbFvvoYSXeKHejuGYEkBlVNVHZP0QzgJtS7M3pgT9Qa5nHFqY2JdLb9Vc4/GJh2iFBO6mmtrBZP7Tk3hLiEoXYB6bOQxQrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CFeNpLQB; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CFeNpLQB"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3b783d851e6so3979144f8f.0
        for <linux-perf-users@vger.kernel.org>; Mon, 04 Aug 2025 09:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754323215; x=1754928015; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=83y9HCM1NErNHhoDJvLNstKn3l9elWApgqOnhqoLDjY=;
        b=CFeNpLQBfQy/dHPdDA+f04e7ncarAxq2rRPp/w8gqPMiZqYLzovam0CFUYVSavmMMm
         7RdVNhM1eD0/f5x6MymYgCyPVGAKpUGH6poEhckfFreY3VvP0nHaw/lHX/Ny7RY6OfFu
         K4C9h/B4qrWmval+pY372oHX+vWoBbnFFCynriEJwmUq8oDcb/LPwrj/sfAkskJL73Yc
         NZsIcoI0ZlOW55HNfnkth+J61Xh/ejeOdcpEGzl9zIhj9X0vhKQmx5LTERE7gtmBNiZ3
         +gdsz2xNi5+OOZu/TyxoU96rZfWrZxe/F5Jloki1IBCXxps9KhWFd+sA2sGX//NFTpCp
         vMlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754323215; x=1754928015;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=83y9HCM1NErNHhoDJvLNstKn3l9elWApgqOnhqoLDjY=;
        b=pKrEc1FsBb0dF1IpCfevcMPkKrnCq7y27fDh8Hu/fDrt9TxLbc3ZqcPy7GqSfGzeiQ
         52250mTrfcThwN/KffZC27sRr2vVFkSf7a1roLcTy4+ElT9eaEP1+LciKTpmNOvGBP5U
         vZdzibkuaxKzEbpVYR7idPETu8UGQWgN+lHUEOS7JoYD2bZYcQ/3BextXnejYiBoR6xY
         +YS+5IzUgPFeagneUFhKygfejA22TVbi7uVTHb/BDUie3LMQaP3kSkrQxeSiLp1zVtT7
         /0lRfNVVpLMAc3IGp0PUdUXWbjEV6pwe3CcIzs4IFQLaahvUri/V9Bki0KeM1WEQopxH
         9xcg==
X-Forwarded-Encrypted: i=1; AJvYcCXzEMyq8hrEqmRuXU3uKHq+R/Hon7gcdlv+GhLLPoO2xrZcbY+DlKhnbfGkelsV+pwhXLDkmVy9DG5MxG/lsGpz@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5OPuOpeel/VaGVD2HyvcM7GLHbUe1o5KGfiJJkdzxyllmWnhE
	utNzSIDn6NdKSvJ+IURHYKz+NgrrO156XceJzkAoD7paLi+2tCZn0Gtkcz+2AlXija8=
X-Gm-Gg: ASbGncse+oymOtvggL5LXcUYwIqCoFnNRu2uzTyULFxjzRD5re0XIp7PHh29zouZgEo
	3mUJ9MOxIMgZ9D+AJJl2oh/yjixz/X9pFJWY+5Sg28qrrS0btagPju6bkPgUh0OGZziD0bf3Whr
	H/gnZu0dWxrVyEJvZwNB6YoiNfHlxuNjmqQgGcsMj0AYkMG8TtjH5eylxL3DKNt+2oXB0Tsqu+S
	k/kQdnfludiJMbHA23tufPFhe+70cf7Aq/fEB2ONo2QiFehiKVLq8XQxeKS2FWnxHy+Wol/U7Pd
	fulDKfwvb3Jr++UfZx7lr0CNL9DbmsJt+d28JqSzL9hUWwi3wRWhTcNo27944EMw3JEFiyAkQSv
	UtMkP2X0jdcP4Urhqfnd2OjQIPe6omBI4FYtD2Q==
X-Google-Smtp-Source: AGHT+IEauvx9FJ2JC6u71NHBH4w0cTSo3NvU8GY9XFshSKS1MeESuBlXTRuD0jWRGjF7fGT+6taYMQ==
X-Received: by 2002:a05:6000:188f:b0:3b7:81a6:45c1 with SMTP id ffacd0b85a97d-3b8d946afacmr6958510f8f.6.1754323214722;
        Mon, 04 Aug 2025 09:00:14 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b8e9464f46sm1848019f8f.19.2025.08.04.09.00.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Aug 2025 09:00:14 -0700 (PDT)
Message-ID: <a492ccbf-6442-44dc-82c8-d2c8b1d5c56b@linaro.org>
Date: Mon, 4 Aug 2025 17:00:13 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] perf: arm_spe: Add support for SPE VM interface
To: Alexandru Elisei <alexandru.elisei@arm.com>
Cc: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Anshuman Khandual <Anshuman.Khandual@arm.com>,
 Rob Herring <Rob.Herring@arm.com>, Suzuki Poulose <Suzuki.Poulose@arm.com>,
 Robin Murphy <Robin.Murphy@arm.com>, linux-arm-kernel@lists.infradead.org,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>
References: <20250701-james-spe-vm-interface-v1-0-52a2cd223d00@linaro.org>
 <aIzA632hiAldjJQQ@raptor>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <aIzA632hiAldjJQQ@raptor>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 01/08/2025 2:28 pm, Alexandru Elisei wrote:
> Hi,
> 
> On Tue, Jul 01, 2025 at 04:31:56PM +0100, James Clark wrote:
>> SPE can be used from within a guest as long as the driver adheres to the
>> new VM interface spec [1]. Because the driver should behave correctly
>> whether it's running in a guest or not, the first patches are marked as
>> a fix. Furthermore, in future versions of the architecture the PE will
>> be allowed to behave in the same way.
>>
>> The last patch adds new behavior to make it easier for guests to be
>> able to reserve large buffers. It's not strictly necessary, so it's not
>> marked as a fix.
> 
> I had a look at the patches, and they all look ok to me, so for the series:
> 
> Reviewed-by: Alexandru Elisei <alexandru.elisei@arm.com>
> 
> I also tested the series by hacking SPE virtualization support in KVM:
> 
> - without these changes, the SPE driver gets into an infinite loop because it
>    clears PMBSR_EL1.S before clearing PMBLIMITR_EL.E, and the hypervisor is
>    allowed to ignore the write to PMBSR_EL1.
> 
> - with these changes, that doesn't happen.
> 
> - ran perf for about a day in a loop in a virtual machine and didn't notice
>    anything out of the ordinary.
> 
> - ran perf for about a day in a loop on baremetal and similary everything looked
>    alright.
> 
> - checked that the SPE driver correctly decodes the maximum buffer size for
>    sizes 4M, 2M (2M is right at the boundary between the two encoding schemes)
>    and 1M; that's also correctly reflected in
>    /sys/devices/platform/<spe>/arm_spe_0/caps/max_buffer_size.
> 
> - checked that perf is not allowed to use a buffer larger than the maximum.
> 
> - checked that the SPE driver correctly detects a buffer size management event.
> 
> So:
> 
> Tested-by: Alexandru Elisei <alexandru.elisei@arm.com>
> 
> While testing I noticed two things:
> 
> 1. When perf tries to use a buffer larger than the maximum, the error is EINVAL
> (22):
> 
> # cat /sys/devices/platform/spe/arm_spe_0/caps/max_buff_size
> 4194304
> # perf record -ae arm_spe// -m,16M -- sleep 10
> failed to mmap with 22 (Invalid argument)
> 
> (used 16M as the buffer size because what the driver ends up programming is half
> that).
> 
> I would have expected to get back ENOMEM (12), that seems less ambiguous to me.
> I had to hack the driver to print an error message to dmesg when the max buffer
> size is exceed to make sure that's why I was seeing the error message in perf,
> and it wasn't because of something else. I get that that's because .setup_aux()
> can only return NULL on error, but feels like there's room for improvement here.
> 

We could add an error code, rb_alloc_aux() already returns one and that 
calls setup_aux(). But the scenarios would be either EINVAL or ENOMEM 
and wouldn't give the user the exact reason ("need > 2 pages", "need 
even number of pages", etc). So I'm not sure it would be enough of an 
improvement over returning NULL to be worth it.

However I will add a warning into Perf if the user asks for more than 
caps/max_buffer_size. That would be a useful message and Perf can do it 
itself so it doesn't need to be in the driver changes.

> 2. A hypervisor is allowed to inject a buffer size event even though the buffer
> set by the guest is smaller than the maximum advertised. For example, this can
> happen if there isn't enough memory to pin the buffer, or if the limit on pinned
> memory is exceeded in the hypervisor (implementation specific behaviour, not
> mandated in DEN0154, of course).
> 
> In this situation, when the SPE driver gets a buffer size management event
> injected by the hypervisor, there is no way for the driver to communicate it to
> the perf instance, and the profiled process continues executing even though
> profiling has stopped.
> 
> That's not different from what happens today with buffer management events, but
> unlike the other events, which aren't under the control of userspace, the buffer
> size event is potentially recoverable if userspace restarts perf with a smaller
> buffer.
> 
> Do you think there's something that can be done to improve this situation?
> 
> Thanks,
> Alex
> 

It doesn't look like there's currently anything that can stop an event 
or signal to Perf that the event has gone bad.

We could add something like "__u32 error" to struct 
perf_event_mmap_page. But I'm not sure what you'd do with it. If Perf is 
the parent of the process you wouldn't want to kill it in case anything 
bad happens. So you're left with leaving it running anyway. If it's just 
an error message that you want then there's already one in dmesg for 
buffer management errors, and that string is a lot better than a single 
code. Unless these new codes were detailed PMU specific ones? Actually 
it's a whole page so why not make it a string...

It's not a case of the samples ending randomly somewhere though, you'll 
either get all of them or none of them. So it will be quite obvious to 
the user that something has gone wrong. Secondly I think the scenario of 
not being able to pin memory when asking for less than the limit would 
be very rare. It's probably fine to leave it like this for now and we 
can always add something later, maybe if people start to run into it for 
real.

James


