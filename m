Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850B33C199F
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Mar 2026 14:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773067414; cv=none; b=mbBKeq3rDQWq/zOu6ayRYOtoPBQGQFvbje8EaJnVSPCNOh0wOrPYmeM8C4ztpGTHXfAGRiWus+8GCLO2XWo+tCYVDHGJZxOXyZlu8AeEeS07TfE9B7asJ66U7vOfzvNVk2OTUF9qBCNunzBDfd6KLOJh5I6AL+rJHDexA/lcQDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773067414; c=relaxed/simple;
	bh=mguFycCClC7hIxduu/YAtXMSiWY4hv6TL5+n2Mt+bxk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=M65uRXZDgOud0Afd3MR1Y6DoZdHBB+vAbCaQyJ9PuftAnjGTm0egp9Rdxh3lzpl1L5qdL+dul67MzpqsP2mHBZ9DAUEcN5vHFQy5ZEe6N3GZ8C0wltOY5rRwAsONb6OkE7E0mSETQu5dK5HMkInIBvYExol751I70ZdXKSWbTH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CivCS4Dz; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=erPtHQ78; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CivCS4Dz";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="erPtHQ78"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773067409;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DaKhYXczwtijwhMhNK50Qi+Imd2B6nrC4erR8UlvNrQ=;
	b=CivCS4Dz9jJp2Yi78B7go+mtYkcc7Pzfqa6KCamzDSqerng/gqDVX2cf7w6h9bysIjErla
	cTKtgz4x1rYe44x5kLX6RrZ3HvnFDvKH9mbtQQMQd2LTJ86tuPvWfKGHcO5Cs/SsrxkwBf
	5371gxTBYq1c3y145sM6tmijO0Nta4Q=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-jqVOxN7pPwG-SG4F8IqCzw-1; Mon, 09 Mar 2026 10:43:28 -0400
X-MC-Unique: jqVOxN7pPwG-SG4F8IqCzw-1
X-Mimecast-MFC-AGG-ID: jqVOxN7pPwG-SG4F8IqCzw_1773067407
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-b96eed52862so112540666b.1
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Mar 2026 07:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773067407; x=1773672207; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DaKhYXczwtijwhMhNK50Qi+Imd2B6nrC4erR8UlvNrQ=;
        b=erPtHQ78lKGLDImHXgF+GM+YMGasz8jZ63fIHDD4R9cXupefmJZEwgIHLh01MESD26
         wWGF7pLZygZ2iWDO9bONlhpyxYMvb/jO72x2ai+r46sHh+t8KvnuOY7BIe6Y8ayEG9U1
         /fe/0LKvdOHDjN0kP41dnBgKrWulpzJ2+nW3pYBs26i9Vrzgf1yDhdivglWlcjqipk8k
         xzdO08LlxEfJ5l80zgQZke7dlP9ehwbf73uUtAn+jZ1SwcAHUBGYzzbUkQQEVY+bD6Gr
         f9EIjtS5AhAAVFdDz1LFU/T9MWQzqNq7Kxz0+xIt4u5HHBOutjg2UcFefhjgPh9d5B65
         4kXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773067407; x=1773672207;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DaKhYXczwtijwhMhNK50Qi+Imd2B6nrC4erR8UlvNrQ=;
        b=PrMuL3Z3fJUcyNIoz2muxVSdleKMg75FoQV8gqvx4YaOVbwkav18DD5IifFVYS8GOD
         eFIooK7M5YA/8odNCiU+3D/GZpo0eFz+m4Jyfj/NxtXHO4i7UNTN17SazGkVXbH+eUZg
         UVfNB0mWnFPAGyWvjkvYeDqfMZ1wt8RT1oxEr9bvsSk+k638uYkvCAIEKe2hgruE5Fg/
         MUzQicdMKT9fcboJOHpShY2PSm7YE//Kxe9agVNjUnxRvlrtPGaib60o6VrRanhk5Sqi
         d99vl/2tp/xOjBfKlpXvT9xF/R3FxE9dhX9OBBBucaaZVr61zJF9/8L8mIbb0k4Nt/5M
         9rbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFbwpK+zcwzw9UkDCvAbcDwVWkTxQyr3w0lF/V0CIGf1g+5iGtPw+iPl8QQXpMwRsTFA1v+xhSt6Z8LvyH8CMR@vger.kernel.org
X-Gm-Message-State: AOJu0YxyFOl5RxffoJa4SEwQXQWraN+eqRXpnWJRKA6Qq+NqQlihhMCm
	nsohRbh0h7tHFO6ZA2E9Uv2PicFjjrpwD1NXWYFN5z9PvfP222DRcsfrsFOiawqi7lOu+V1z82G
	IJMX3YOdcWjP2pvolZ65zqkKwwHIEiqB8hFm4Q8qqbylHGeddEkFjBygTx8ubsDA2E8vWzw==
X-Gm-Gg: ATEYQzyKWSC6JylLHpWVuhMk5vFKW960zLFgcvFntZmfwZ2M1opN6pLGdcrxqvDTCuK
	Ct9QG9+7515VvwpjolGBLB0cJ++1xnIu05Spq88DSHh80g0CPTsZp28H1p0pUdGCrW+tnTXtPuO
	XBEmkgJcoU875/VnYiPxMiQxnu9yYtY/DD6OCfEL6gANmywADDnz0xucUr366M09NeVpp3w5igT
	gdz0+WD0u7Cib//KxeRcPwptpmq+29dGRrbLYcPZroVKcZQ2P2HWgNdGfd3q7a24vSS2aWITcZ+
	DeOaDPV5rNWB9b8KRICS7XPksvB/A6oB/VUnpFEQYtTWTONGRi7K9Zt7HifWTjRj6Fb7mfC4dGN
	2DzfkwmuDDq7A38TKc8/Q8Wy4gRTnm7SmoJsIxHTqYNEkHI8k6lygnDhV
X-Received: by 2002:a17:907:7fa4:b0:b96:eb7e:bc3b with SMTP id a640c23a62f3a-b96eb7ec9a3mr256773666b.49.1773067406725;
        Mon, 09 Mar 2026 07:43:26 -0700 (PDT)
X-Received: by 2002:a17:907:7fa4:b0:b96:eb7e:bc3b with SMTP id a640c23a62f3a-b96eb7ec9a3mr256771866b.49.1773067406195;
        Mon, 09 Mar 2026 07:43:26 -0700 (PDT)
Received: from [192.168.0.135] (185-219-167-205-static.vivo.cz. [185.219.167.205])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b942f189de1sm382893266b.63.2026.03.09.07.43.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Mar 2026 07:43:25 -0700 (PDT)
Message-ID: <100385b1-afd0-4c17-831a-6cd45a02f6f3@redhat.com>
Date: Mon, 9 Mar 2026 15:43:23 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] powerpc, perf: Check that current->mm is alive before
 getting user callchain
From: Viktor Malik <vmalik@redhat.com>
To: Saket Kumar Bhaskar <skb99@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Joe Perches <joe@perches.com>, Paul Mackerras <paulus@ozlabs.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, atrajeev@linux.ibm.com,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
References: <20260227082502.1882395-1-vmalik@redhat.com>
 <aab3EW1LfDcjSzzy@linux.ibm.com>
 <80766050-c745-411b-8ee6-8141d2cfe4ff@redhat.com>
 <aa6pZaDySMl9JGKf@linux.ibm.com>
 <f40b2ccd-2d71-4089-bd28-3adbc70f0a1d@redhat.com>
Content-Language: en-US
In-Reply-To: <f40b2ccd-2d71-4089-bd28-3adbc70f0a1d@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/9/26 13:17, Viktor Malik wrote:
> On 3/9/26 12:05, Saket Kumar Bhaskar wrote:
>> On Thu, Mar 05, 2026 at 01:45:44PM +0100, Viktor Malik wrote:
>>> On 3/3/26 15:58, Saket Kumar Bhaskar wrote:
>>>> On Fri, Feb 27, 2026 at 09:25:02AM +0100, Viktor Malik wrote:
>>>>> It may happen that mm is already released, which leads to kernel panic.
>>>>> This adds the NULL check for current->mm, similarly to 20afc60f892d
>>>>> ("x86, perf: Check that current->mm is alive before getting user
>>>>> callchain").
>>>>>
>>>>> I was getting this panic when running a profiling BPF program
>>>>> (profile.py from bcc-tools):
>>>>>
>>>>>     [26215.051935] Kernel attempted to read user page (588) - exploit attempt? (uid: 0)
>>>>>     [26215.051950] BUG: Kernel NULL pointer dereference on read at 0x00000588
>>>>>     [26215.051952] Faulting instruction address: 0xc00000000020fac0
>>>>>     [26215.051957] Oops: Kernel access of bad area, sig: 11 [#1]
>>>>>     [...]
>>>>>     [26215.052049] Call Trace:
>>>>>     [26215.052050] [c000000061da6d30] [c00000000020fc10] perf_callchain_user_64+0x2d0/0x490 (unreliable)
>>>>>     [26215.052054] [c000000061da6dc0] [c00000000020f92c] perf_callchain_user+0x1c/0x30
>>>>>     [26215.052057] [c000000061da6de0] [c0000000005ab2a0] get_perf_callchain+0x100/0x360
>>>>>     [26215.052063] [c000000061da6e70] [c000000000573bc8] bpf_get_stackid+0x88/0xf0
>>>>>     [26215.052067] [c000000061da6ea0] [c008000000042258] bpf_prog_16d4ab9ab662f669_do_perf_event+0xf8/0x274
>>>>>     [...]
>>>>>
>>>>> Fixes: 20002ded4d93 ("perf_counter: powerpc: Add callchain support")
>>>>> Signed-off-by: Viktor Malik <vmalik@redhat.com>
>>>>> ---
>>>>>  arch/powerpc/perf/callchain_32.c | 3 +++
>>>>>  arch/powerpc/perf/callchain_64.c | 3 +++
>>>>>  2 files changed, 6 insertions(+)
>>>>>
>>>>> diff --git a/arch/powerpc/perf/callchain_32.c b/arch/powerpc/perf/callchain_32.c
>>>>> index ddcc2d8aa64a..b46e21679566 100644
>>>>> --- a/arch/powerpc/perf/callchain_32.c
>>>>> +++ b/arch/powerpc/perf/callchain_32.c
>>>>> @@ -144,6 +144,9 @@ void perf_callchain_user_32(struct perf_callchain_entry_ctx *entry,
>>>>>  	sp = regs->gpr[1];
>>>>>  	perf_callchain_store(entry, next_ip);
>>>>>  
>>>>> +	if (!current->mm)
>>>>> +		return;
>>>>> +
>>>>>  	while (entry->nr < entry->max_stack) {
>>>>>  		fp = (unsigned int __user *) (unsigned long) sp;
>>>>>  		if (invalid_user_sp(sp) || read_user_stack_32(fp, &next_sp))
>>>>> diff --git a/arch/powerpc/perf/callchain_64.c b/arch/powerpc/perf/callchain_64.c
>>>>> index 115d1c105e8a..eaaadd6fa81b 100644
>>>>> --- a/arch/powerpc/perf/callchain_64.c
>>>>> +++ b/arch/powerpc/perf/callchain_64.c
>>>>> @@ -79,6 +79,9 @@ void perf_callchain_user_64(struct perf_callchain_entry_ctx *entry,
>>>>>  	sp = regs->gpr[1];
>>>>>  	perf_callchain_store(entry, next_ip);
>>>>>  
>>>>> +	if (!current->mm)
>>>>> +		return;
>>>>> +
>>>>>  	while (entry->nr < entry->max_stack) {
>>>>>  		fp = (unsigned long __user *) sp;
>>>>>  		if (invalid_user_sp(sp) || read_user_stack_64(fp, &next_sp))
>>>>> -- 
>>>>> 2.53.0
>>>>>
>>>> Sorry, I missed adding cc list for the last conversation so adding this for reference:
>>>>
>>>>> Wouldn't be good if we check this in perf_callchain_user() as it will
>>>>> cover both cases.
>>>>
>>>> to which Viktor replied:
>>>> I considered it but in that case, we'd also miss the top-level stack
>>>> frame (the perf_callchain_store call above). Other arches include it so
>>>> I followed the behavior for powerpc.
>>>>
>>>> Viktor, agreed with your first point. I have another concern:
>>>>
>>>> I was hitting this issue with stacktrace_build_id_nmi in bpf and
>>>> applied this patch https://lore.kernel.org/bpf/20260126074331.815684-1-chen.dylane@linux.dev/T/#mf901967ebe77506f1bd6e3d876c2a85824d9519d
>>>>
>>>> Wondering if the above generic fix is working do we need to add this
>>>> check in powerpc specific code?
>>>
>>> I tried to apply that patch series but, unfortunately, keep getting the
>>> panic when running the BCC profile tool.
>>>
>>> Also, looking at the patch, it seems that it would only solve the issue
>>> when perf_callchain_user is called from a BPF context, however, I assume
>>> that it may be called from other contexts, too.
>>>
>>> Since perf_callchain_user_{32,64} are dereferencing current->mm while
>>> walking the stack, I think that an explicit protection against
>>> current->mm being NULL makes sense here, even in the presence of the
>>> above patch. Especially since other arches have it, too.
>>>
>>> Viktor
>>>
>> Ok that looks convincing then, another thing is that, how about moving perf_callchain_store
>> to perf_callchain_user and checking current->mm == NULL there for both perf_callchain_user_32/64.
>> next_ip, lr and sp can be passed to perf_callchain_user_32/64.
> 
> Yeah, that should be possible. I'll send v2.

v2 sent:

https://lore.kernel.org/linuxppc-dev/20260309144045.169427-1-vmalik@redhat.com/T/#u

Viktor

> 
> Viktor
> 
>>
>> Thanks,
>> Saket
>>
> 

