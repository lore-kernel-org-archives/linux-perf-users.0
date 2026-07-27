Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A740D3F824D
	for <linux-perf-users@vger.kernel.org>; Mon, 27 Jul 2026 11:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785150263; cv=none; b=RQRQ38kfUeDo6Lp6u4DfKsGhXVQ9LpWcUm+m1T3IXltYHXbI8tHMOEPnQ/2BAF2ItkdSVzbyeEO1iTkjYiPFwpFT7SbV6qEudG+s3w/hba/DYyP5zLmCc0gXN5kIl6zY0nthzZKD2P/lkGlXfrGSgfGTYd7uEPathv6l2XTSYEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785150263; c=relaxed/simple;
	bh=zatUq8xJHUqH++J1UZPNwFpyaWEJMdbBJNxH4Uzd7BQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lV/7CcHc+KJLbemI/7bWB5xlW+UqcFJPPOULJ/6QevXaxU1kT/oGCdxuBWruCwSeqBIqkcOMC0q8vDb/2l3Q7E3YSbeU6WAWT2uCpe49cZ2RXKvB7kvv0Gs3Qy3OQGQgf0btuBQBu0HafgL+nOYEGBtCldZBmW6lI5+IG5BViDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ObudIpib; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ObudIpib"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4921eed3fa2so17755165e9.0
        for <linux-perf-users@vger.kernel.org>; Mon, 27 Jul 2026 04:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1785150259; x=1785755059; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7nC3HrqDGZF7AOgHUOZz0pFaqYcIiLme0buP14VJS2k=;
        b=ObudIpibwWwYXv6KqHwUBeF9Hij2W+1dp3zYQz2b5eMiblwuCYNy1hAfWf9TGResvb
         jR+z+jHqPeWb/tWXNRuX9D+CZX9nYcT6zmMM/zAQjSOpfLLBQAxaYItxj6fc9+GC1hl0
         Lz6+wL4qAg8RvFvF5sq2M2AQC7GspJogSL5YtMgdi/vLdrwJArqKcwNofHsogXoT2VWr
         ejzXmB/xyhbx1QyP14uy2XeG7qX5gIzQVqgdxZUwzG55gxs9OBQsF8KWTEO+e10ddWMc
         5ib7U+9r3kebehOznpasqj4qc1BU66LTGZZngoZJUT8cdizrJhn1XLGrk7q5XltFRkpd
         /IqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785150259; x=1785755059;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7nC3HrqDGZF7AOgHUOZz0pFaqYcIiLme0buP14VJS2k=;
        b=XyXByrHT7JJSbt+wB0lbP+ETHO7IIW2kV0sPK5H7g+naKgA7n9nCCE+Ra6VykuiAKt
         1uyw8t5J6T/kdcWvSv2qB9Bd3qweFzzU2kDYkIISAYI/vkeXj5bzS+krIVjmtCLRmVp0
         aRHPaCj32NrMb7VEe1W6dqfuLh5HumTdkHhtjyB+fumst2fzfQepAebh8fmRe1L9Q204
         baaVlM3+xpXah9Z/ES2Fli3jDU2RaRGY+9FBwyZ8qx5TMT9c1siRJr8oV2c4uxFo9Qo0
         tGHUx6rmes/H9FwtGOFkgp6XXZH19SlSFFMpR9ChQuQUZm6osZUZ6/9u9Hwvuyt7zzQ6
         0I5w==
X-Forwarded-Encrypted: i=1; AHgh+RoAajYrFhfFFJWz0YB2slupPXkqMfuYKYX+usL6gtke5rbenOLVZp8mh2gJYlX2nkIdYyQ8eqM1QM2p9jdKNx+4@vger.kernel.org
X-Gm-Message-State: AOJu0YyQHSKdPt6JVNt9ufx8HehCRrA54b8Oip5mbSW+BpCgre1qWVcZ
	io8v9AA43+Zl/NPPiuC7WJ5hIFop5L9pzKfV3YhHzNtgpJuAdpLNi97TPltlD2OFZw8=
X-Gm-Gg: AR+sD12h21RahMHlQom5p5SvbUYzrK9VEPm8bIr6fhalPeVz+DLKCEdD7PqhtyM3jOw
	VKNcSx+YhzbvP3Pp54nzidt/pwwaJbJcmrJ0eob8viIjQN3TwG0i2etQIKNy/uvNw3De5s0hc6e
	ZF4Ke6nKp4F9QNe8q84tawMYlRdxbN7742PEeU7vaJ60WDo7QvLMyDmZCB1g52OBFsWh0yBZM3r
	+pVR4EC4N0nNmVJkJ41lqrGQ3A5cW2rTDrMaJATjwBw0jDx5LSfajZVvwtfPOXrsTFj5y4Ej3EC
	36hv1QsTtymBghcpwJ0EJXOIyUtjHR7w7/Aos09YoduX6MjLJFNvX5kzwi/ZHTFGxUHP7CybpS+
	5AXf8ZRalaZTgi5fKn9J29RUW7/4AOifMfjOsl7USZtNqO2lKWsqb0Q9UyoknfIPuSe/KuCcbEH
	kQhhrktpbuomWzLn/Kjg==
X-Received: by 2002:a05:600c:3113:b0:493:c8f7:3631 with SMTP id 5b1f17b1804b1-496b570dacdmr94916415e9.22.1785150259287;
        Mon, 27 Jul 2026 04:04:19 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-496b4f5f9f8sm212127145e9.9.2026.07.27.04.04.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2026 04:04:18 -0700 (PDT)
Message-ID: <2941da1a-b0b4-47a6-b57c-b28703dc0454@linaro.org>
Date: Mon, 27 Jul 2026 12:04:17 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 00/21] ARM64 PMU Partitioning
To: Colton Lewis <coltonlewis@google.com>
Cc: kvm@vger.kernel.org, alexandru.elisei@arm.com, pbonzini@redhat.com,
 corbet@lwn.net, linux@armlinux.org.uk, catalin.marinas@arm.com,
 will@kernel.org, maz@kernel.org, oliver.upton@linux.dev, mizhang@google.com,
 joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com,
 mark.rutland@arm.com, shuah@kernel.org, gankulkarni@os.amperecomputing.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
 linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <gsnt33x95sra.fsf@coltonlewis-kvm.c.googlers.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <gsnt33x95sra.fsf@coltonlewis-kvm.c.googlers.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 23/07/2026 9:57 pm, Colton Lewis wrote:
> James Clark <james.clark@linaro.org> writes:
> 
>> On 22/07/2026 12:03 am, Colton Lewis wrote:
>>> Hi James, thanks for the review.
> 
>>> James Clark <james.clark@linaro.org> writes:
>>>> Hi Colton,
> 
>>>> The existence of the parameter makes sense, but can't the default be
>>>> arm_pmuv3.reserved_host_counters=0 instead of -1 (partition disabled)?
> 
>>> How would you interpret reserved_host_counters=0? Because that would
>>> express that the host should have zero counters and the guest gets them
>>> all. I remember in early versions of this series last year I did use 0
>>> as the default but reviewers asked for a way to express the scenario of
>>> of zero counters for the host.
> 
> 
>> I think I would interpret it as it is now. Can't the host still use them
>> until the guest does and then they only get squeezed if there is a
>> collision? That doesn't sound too bad to me. And if a host wants
>> reserved counters they can set a positive number.
> 
> Yeah that makes sense. I was thinking in an old headspace when it was
> just a static reservation instead of changing when a guest is loaded.
> 
>> Is reserved_host_counters==max_counters equivalent to -1? And there's no
>> overview in the cover letter or documentation about how it interacts
>> with the dynamic guest counter reservations. A bit more detail or a few
>> paragraphs in one place would help users, maybe with examples so they
>> don't have to piece together all the commit messages to work it out.
> 
> It's not equivalent since we need a case where the guest only has access
> to the fixed-purpose counters like the dedicated cycle
> counter. reserved_host_counters specifies the number of general purpose
> counters.
> 
> I'll document the operation more clearly. In the future please feel free
> to email me to ask if you are confused about something.
> 
>>>> It's still a bit fiddly having to do two things to make it work, and
>>>> there's no documentation about what the defaults or other prerequisites
>>>> are. IMO it's not even trivial to work out that you need to prefix it
>>>> with "arm_pmuv3.", which documentation would improve.
> 
>>> It is fiddly, which is why the more I think about it the more I'd rather
>>> ditch the kernel cmdline entirely and leave it up to KVM. That's the
>>> most flexible approach. There isn't a good way to change the cmdline
>>> after boot. Trying to make it writeable via sysfs runs into the problem
>>> of when is it safe to apply the change.
> 
>>> I thought it was commonly understood module parameters need to be
>>> prefixed by the module name, but I can add better documentation to that
>>> effect.
> 
> 
> 
>> People just want it written out fully somewhere so they can copy paste
>> it. Kernel developers might be able to piece it together, but not
>> everyone will.
> 
> This is the KVM mailing list. Kernel developers are the primary
> audience, but I will make reasonable efforts to include others in the
> future.
> 

I'm more thinking of the users of this after it gets merged, rather than 
just for the review.

>>>> Testing the whole set I ran into a few issues:
> 
>>>> This warn is hit when there is some kind of interaction with 
>>>> sleeping. I
>>>> tried to bisect it but it only appears on the last commit when the
>>>> option to enable partitioning is added.
> 
>>>>     /*
>>>>      * ARM pmu always has to reprogram the period, so ignore
>>>>      * PERF_EF_RELOAD, see the comment below.
>>>>      */
>>>>     if (flags & PERF_EF_RELOAD)
>>>>         WARN_ON_ONCE(!(hwc->state & PERF_HES_UPTODATE));
> 
>>>> Steps to reproduce:
> 
>>>> Host (arm_pmuv3.reserved_host_counters=0):
>>>>    $ sudo perf stat -C 2 -e \
>>>>      'branches,branches,branches,branches,branches,branches'
>>>>    $ sudo taskset --cpu-list 2 ./lkvm run --kernel \
>>>>      /boot/vmlinux-7.1.0-rc7+ -m 1024 -c 1 --pmu
> 
>>>> Guest:
>>>>    $ sleep 1
> 
>>>>     WARNING: drivers/perf/arm_pmu.c:302 at 
>>>> cpu_pm_pmu_notify+0x278/0x2c0,
>>>> CPU#2: swapper/2/0
>>>>      Call trace:
>>>>     cpu_pm_pmu_notify+0x278/0x2c0 (P)
>>>>     notifier_call_chain+0x84/0x1d0
>>>>     raw_notifier_call_chain+0x24/0x38
>>>>     cpu_pm_exit+0x34/0x68
>>>>     acpi_processor_ffh_lpi_enter+0x40/0x78
>>>>     acpi_idle_lpi_enter+0x54/0x78
>>>>     cpuidle_enter_state+0xb4/0x248
>>>>     cpuidle_enter+0x44/0x68
>>>>     do_idle+0x21c/0x300
>>>>     cpu_startup_entry+0x40/0x50
>>>>     secondary_start_kernel+0x120/0x150
>>>>     __secondary_switched+0xc0/0xc8
> 
> 
>>> I'll attempt to reproduce that. I've never seen it myself but I've
>>> mainly been using QEMU for my testing.
> 
> 
>> The newest Arm FVP should have cpuidle enabled if you boot it with ACPI,
>> but I hit this on a Radxa Orion O6 board.
> 
> Noted. Thanks.
> 
> 
>>>> When running the guest on a single CPU I get different counts for the
>>>> same event for a single process, although this never happens on a host.
>>>> I think there might even be some Perf tests which expect them to be the
>>>> same, and this doesn't depend on whether any events are running on the
>>>> host or not. Not sure if you ran all the Perf selftests in a guest or
>>>> not?
> 
>>> I'll investigate but I'm not sure perf is intended to guarantee
>>> that. perf stat just runs the event counters but may not write or read
>>> them at exactly the same time.
> 
> 
>> Is that true? The perf core calls perf_pmu_disable() when a process is
>> scheduled out before reading the count of each event of that process in
>> an inner loop. The perf_pmu_disable() clears PMCR_EL0.E which freezes
>> all of the counters so they can be read out in a consistent state.
> 
>> It's important that they're all stopped at the same time because
>> counters might be used in metrics as ratios of each other. So I think
>> it's deliberately designed that way and appears to not be working in a
>> guest now.
> 
> By default I think perf assumes events can be measured independently, If
> you want to guarantee events are scheduled together to avoid measurement
> skew you need to make sure the events are grouped.
> 
> The common way to do that is with {} around the event list:
> 
> perf stat -e {branches,branches}
> 
> Please see if that resolves the issue.
> 

Groups only change how the events are scheduled, not how the driver 
starts or stops multiple events running on the same PMU (grouped or 
ungrouped). In my repro I had less events than counters in HW, so they 
will always be scheduled at the same time regardless of grouping.

I did notice something extra though, you have to first open some amount 
of counters, and then open more than that. Then the second time the ones 
with different counts will be however many were opened first time, as if 
some state has stuck.

For example if I open two counters then 6, the first two always have 
different counts the second time:

   $ perf stat -e branches,branches true

   Performance counter stats for 'true':

             106129      branches 

             106129      branches 



   $ perf stat -e 
'{branches,branches,branches,branches,branches,branches}' true

   Performance counter stats for 'true':

             117013      branches 

             117013      branches 

             110364      branches 

             110364      branches 

             110364      branches 

             110364      branches


After opening 6 again a third time they'll all have the same counts.

>>>> I'm not sure if the exception level filtering isn't working or there is
>>>> something wrong with freezing. Doesn't the host PMU driver need to
>>>> freeze with HPME? I see it's still doing it with PMCR_EL0.E which
>>>> freezes the guest's counters now doesn't it?
> 
>>> HPME only has any effect while HPMN is programmed to a value different
>>> than the number of counters on the system. That is only true in a guest
>>> context. As I understand it, that means HPME has no effect anywhere the
>>> host driver needs to freeze counters since that happens in host context.
> 
> 
>> Oh yeah that makes sense, I didn't think about that. I'm not sure if my
>> other idea about exception level filtering being responsible makes sense
>> either.
> 
> I'll check that too.
> 
>>> Maybe HPMN stays programmed during interrupt handling though. I'll
>>> confirm.
> 
> 
>>>> Host (arm_pmuv3.reserved_host_counters=0):
>>>>    $ sudo taskset --cpu-list 2 ./lkvm run --kernel \
>>>>      /boot/vmlinux-7.1.0-rc7+ -m 1024 -c 1 --pmu
> 
>>>> Guest:
>>>>    $ perf stat -e branches,branches true
> 
>>>>     Performance counter stats for 'true':
> 
>>>>               167963      branches
> 
>>>>               160925      branches
> 
> 
>>>>    $ perf stat -e branches,branches,branches,branches,branches true
> 
>>>>     Performance counter stats for 'true':
> 
>>>>               164425      branches
> 
>>>>               164425      branches
> 
>>>>               164425      branches
> 
>>>>               157743      branches
> 
>>>>               157743      branches
> 
> 
>>>> When running the guest on two CPUs I just get zeros. Do the kvm
>>>> selftests not catch this? Or is it something to do with my setup:
> 
>>> KVM selftests definitely don't catch it. I'll see if I can reproduce.
> 
>>> Since the problem happens with 2 CPUs I wonder if something is
>>> triggering the lazy context swap behavior so the counter values aren't
>>> being moved to the 2nd CPU correctly.
> 
> 
>> If that was the case I would have expected it to be intermittent, or you
>> would get a partial count if the second CPU started from 0, but not
>> zeros every where every time. Let me know if I can run any more tests.
> 
> I'll let you know if I think of something.
> 
>>>> Host (arm_pmuv3.reserved_host_counters=0):
>>>>    $ sudo taskset --cpu-list 2-3 ./lkvm run --kernel \
>>>>      /boot/vmlinux-7.1.0-rc7+ -m 1024 -c 1 --pmu
> 
>>>> Guest:
>>>>    $ perf stat -e branches,branches true
> 
>>>>    Performance counter stats for 'true':
> 
>>>>                    0      branches
> 
>>>>                    0      branches
> 
>>>> I also noticed I get the "squeezed" warning printed after launching the
>>>> guest but not using Perf. This comment implies that not using counters
>>>> makes it a nop:
> 
>>>>        /*
>>>>      * If we aren't guest-owned then we know the guest isn't using
>>>>      * the PMU anyway, so no need to bother with the swap.
>>>>      */
>>>>     if (vcpu->arch.pmu.access != VCPU_PMU_ACCESS_GUEST_OWNED)
>>>>         return;
> 
>>>> But maybe linux is touching them in a way that makes them guest owned,
>>>> even on probe? Or is the guest/host ownership tracking not working, I
>>>> didn't look too hard.
> 
>>> Maybe. I'll check. The guest is also running its own PMU driver that
>>> might trigger guest ownership on initialization since ownership is
>>> determined by which registers the guest touches.
> 
> 
>> It doesn't enable any counters though does it, even if it touches some
>> of the registers to probe? Should that result in squeezing out host
>> counters? Maybe it's more complicated to implement, but right now it
>> seems like there is some complexity without much benefit as 90% of hosts
>> are going to probe the counters just to see what's there but not use 
>> them.
> 
> As far as I'm aware the driver probe shouldn't shouldn't enable any
> counters or trigger squeezing. I'll narrow the conditions that trigger
> guest ownership.
> 
> My first suspect is the guest driver probe is triggering guest ownership
> by reading PMCR_EL0, which I agree should be changed to avoid that.

