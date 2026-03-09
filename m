Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD753A5E89
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Mar 2026 12:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773058680; cv=none; b=eGWygFXYELj9cG8sxOM6YLVaD9mjrwFTjoT3WEj7fd33SCTl/PMNX+d+5CYymGq8jt46QardFflyPkQlHVENhKzuqYyjmpl39qdVCx/mqpkxL/1FB8zKM54R7GAcsx+sdDjmyp0Fx/Xn5ntjSywkR5CilfiOcd0IXESiw+jd5I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773058680; c=relaxed/simple;
	bh=OozR2JHfgFlcf3yfRLJXVdOhqh9iyrFEXwOX6FN3Zks=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OOhDhEUtcRC8onpgVLwqPu4DE0TdAXOlBmByZ4ycS5mVhBqG3kS0d7yQqchGCEr+VURCGuevwR6FAr7XtphKwbLKhxVKka/sHHs8czGlNzm1xXGLKvnUE4pWKCP3zaR9RFypF/bN3r6KE+IWUlmM104xhJC2TqLF7tJthfFyo1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VF6bhIxH; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=OA+TOY7b; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VF6bhIxH";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="OA+TOY7b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773058677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HNyyMMOd63VribfqOYS2i0x1XZyTkPZ+RO24bylfwjk=;
	b=VF6bhIxHayyS+VGxGkmeDj1FDsKK1eqtLuGFs7IfaCzy7+3qnXBchY+vrcEUyvljnMYj8k
	hQ79X2q8nNzkR5i6Sy5ODR2gwYrwueyyrbnRa4NYrQXYvzrigqn/PH8tCEq/TxvZCF7WH5
	KudyotWwzPEgUhYLQiAx17MkwIgTcR4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-ofJLeTLSP5i_ItLHus3cgw-1; Mon, 09 Mar 2026 08:17:56 -0400
X-MC-Unique: ofJLeTLSP5i_ItLHus3cgw-1
X-Mimecast-MFC-AGG-ID: ofJLeTLSP5i_ItLHus3cgw_1773058675
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-439beddef55so6184000f8f.0
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Mar 2026 05:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773058675; x=1773663475; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HNyyMMOd63VribfqOYS2i0x1XZyTkPZ+RO24bylfwjk=;
        b=OA+TOY7bYnETjwsupMctjwmkaHn+KPkAUSkmGpG5vY9IN1beWH5PfP4sagaUe7xXcb
         NBPxaD5urH1T4y8nlxa9ZpLmFUjWxVtXQBsMC8qe2eYn2mXDW12cLSIqG1YJeUIbf53O
         NHCRzsqmonheoSBcHBQmTWe7BJQem6yVTTTxDtSZLPzHDbugxexst+IiDsuFsdTO8Hs7
         qZHcRCP30ymn1y/2Jdjo9lJO3g+GeWeXQ3xOnWC/kqKoRNRh4QfTs+vVU7ifkG8XCMJN
         A9CjJs6tspEOsT6ut/Az4DnCmFeCk3sjE9rzhDzeowJa5tT3PW3vWrAdXlBC02YrUzH1
         4sFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773058675; x=1773663475;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HNyyMMOd63VribfqOYS2i0x1XZyTkPZ+RO24bylfwjk=;
        b=GLH9w5NCNRQUIljWdPUgVYeZlpvOSZ2sAv8kV81QOgtR8OOQeK2Z1S/TvD9gkY/jV9
         o0SWzZKLx+BDmZMinNxcUkAzubUFdXBpJdyUVMzOZzdMBt/JdtP64h2RGqbIrMeNh20Z
         yRDO9k3fVhJ4Anc8Sa5Lmnv2Q/XBWijDM/6eOZWmzq7bcgRUDg+3rX8P+yuMKFRNsduQ
         Q5sGP2bKPDvaC3y+6Ii4Yliu6DPUNgD0b8nY2HykvNb18kJNHckILV+uLmVFmSsW4SJr
         mvko2Bjml47mrHfrFnNmvjbdzs0934kt/3tALkwEHpdusOIn2c7a+Yu2n7+GfGkrWuTK
         YRCA==
X-Forwarded-Encrypted: i=1; AJvYcCWXxa8lBZNb7oRm1CHBQXBVN2NCtkWOktTqwXKBh0rxHp5m0x0PfYeL1a+kS9b7K7Fns56zozy/UKhqGVbxBUEz@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+tpZ7gfprk/wXNDMjjTCuCBimSJAWzFxZu73nAtPipwFfollP
	INqQirUtOevOOl8GcCa7pO1GRHwm+xk8Uka58ZIBe5m9T49KGV0FaiwKRbGSbsI0fxu10OcNcIx
	96aMqyKvScsGkJl9WfSOTCONDTsUpMb6PE1Wq8isB6miLct1uiZyvRBJudzn8GY/+4V7FFyTcoe
	PaTbHS
X-Gm-Gg: ATEYQzxqYMabPX329S95/lNv4yTKeGXrUsLFuzpc6X7dj5y9dKop7mnYrypqP3uWIeO
	A59vNOoVfaa9UgXmKAgodPaq1NiQ6X25RPVlqqzZXQIufKIXydKQpULIAIHbYPgDIhDjcivsdCe
	JA+3wUK7lgJ3raqY8x9D7eWLVMvIQREng1T/CbOvQV5GbeU2qHmoAitEJ7rrR+yFCBTOy7Dip4N
	mD0ZgLaz7JblrLYkcCUPTcbyKU2yHxJjKmt2h3W6GACwAPBre2tggY5MeKATiWYWxNGUqzQYtxE
	A2J5W1xj41ahK12MrJF/4mXKLZO4dzEV0W11/UtCAoUzpqQs0S7ycTCj2VrmmQX67QcmUH7PBHl
	lRWTRVSLh1Gy4+i2ox6yvLXKvuhXQjMmc7RdOMoiLiNNxOs7yUmR6Rz4G
X-Received: by 2002:a05:6000:290c:b0:439:b3d2:376b with SMTP id ffacd0b85a97d-439da66207amr19413537f8f.14.1773058674900;
        Mon, 09 Mar 2026 05:17:54 -0700 (PDT)
X-Received: by 2002:a05:6000:290c:b0:439:b3d2:376b with SMTP id ffacd0b85a97d-439da66207amr19413477f8f.14.1773058674321;
        Mon, 09 Mar 2026 05:17:54 -0700 (PDT)
Received: from [192.168.0.135] (185-219-167-205-static.vivo.cz. [185.219.167.205])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dad8da01sm27690413f8f.1.2026.03.09.05.17.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Mar 2026 05:17:53 -0700 (PDT)
Message-ID: <f40b2ccd-2d71-4089-bd28-3adbc70f0a1d@redhat.com>
Date: Mon, 9 Mar 2026 13:17:52 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] powerpc, perf: Check that current->mm is alive before
 getting user callchain
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
From: Viktor Malik <vmalik@redhat.com>
Content-Language: en-US
In-Reply-To: <aa6pZaDySMl9JGKf@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/9/26 12:05, Saket Kumar Bhaskar wrote:
> On Thu, Mar 05, 2026 at 01:45:44PM +0100, Viktor Malik wrote:
>> On 3/3/26 15:58, Saket Kumar Bhaskar wrote:
>>> On Fri, Feb 27, 2026 at 09:25:02AM +0100, Viktor Malik wrote:
>>>> It may happen that mm is already released, which leads to kernel panic.
>>>> This adds the NULL check for current->mm, similarly to 20afc60f892d
>>>> ("x86, perf: Check that current->mm is alive before getting user
>>>> callchain").
>>>>
>>>> I was getting this panic when running a profiling BPF program
>>>> (profile.py from bcc-tools):
>>>>
>>>>     [26215.051935] Kernel attempted to read user page (588) - exploit attempt? (uid: 0)
>>>>     [26215.051950] BUG: Kernel NULL pointer dereference on read at 0x00000588
>>>>     [26215.051952] Faulting instruction address: 0xc00000000020fac0
>>>>     [26215.051957] Oops: Kernel access of bad area, sig: 11 [#1]
>>>>     [...]
>>>>     [26215.052049] Call Trace:
>>>>     [26215.052050] [c000000061da6d30] [c00000000020fc10] perf_callchain_user_64+0x2d0/0x490 (unreliable)
>>>>     [26215.052054] [c000000061da6dc0] [c00000000020f92c] perf_callchain_user+0x1c/0x30
>>>>     [26215.052057] [c000000061da6de0] [c0000000005ab2a0] get_perf_callchain+0x100/0x360
>>>>     [26215.052063] [c000000061da6e70] [c000000000573bc8] bpf_get_stackid+0x88/0xf0
>>>>     [26215.052067] [c000000061da6ea0] [c008000000042258] bpf_prog_16d4ab9ab662f669_do_perf_event+0xf8/0x274
>>>>     [...]
>>>>
>>>> Fixes: 20002ded4d93 ("perf_counter: powerpc: Add callchain support")
>>>> Signed-off-by: Viktor Malik <vmalik@redhat.com>
>>>> ---
>>>>  arch/powerpc/perf/callchain_32.c | 3 +++
>>>>  arch/powerpc/perf/callchain_64.c | 3 +++
>>>>  2 files changed, 6 insertions(+)
>>>>
>>>> diff --git a/arch/powerpc/perf/callchain_32.c b/arch/powerpc/perf/callchain_32.c
>>>> index ddcc2d8aa64a..b46e21679566 100644
>>>> --- a/arch/powerpc/perf/callchain_32.c
>>>> +++ b/arch/powerpc/perf/callchain_32.c
>>>> @@ -144,6 +144,9 @@ void perf_callchain_user_32(struct perf_callchain_entry_ctx *entry,
>>>>  	sp = regs->gpr[1];
>>>>  	perf_callchain_store(entry, next_ip);
>>>>  
>>>> +	if (!current->mm)
>>>> +		return;
>>>> +
>>>>  	while (entry->nr < entry->max_stack) {
>>>>  		fp = (unsigned int __user *) (unsigned long) sp;
>>>>  		if (invalid_user_sp(sp) || read_user_stack_32(fp, &next_sp))
>>>> diff --git a/arch/powerpc/perf/callchain_64.c b/arch/powerpc/perf/callchain_64.c
>>>> index 115d1c105e8a..eaaadd6fa81b 100644
>>>> --- a/arch/powerpc/perf/callchain_64.c
>>>> +++ b/arch/powerpc/perf/callchain_64.c
>>>> @@ -79,6 +79,9 @@ void perf_callchain_user_64(struct perf_callchain_entry_ctx *entry,
>>>>  	sp = regs->gpr[1];
>>>>  	perf_callchain_store(entry, next_ip);
>>>>  
>>>> +	if (!current->mm)
>>>> +		return;
>>>> +
>>>>  	while (entry->nr < entry->max_stack) {
>>>>  		fp = (unsigned long __user *) sp;
>>>>  		if (invalid_user_sp(sp) || read_user_stack_64(fp, &next_sp))
>>>> -- 
>>>> 2.53.0
>>>>
>>> Sorry, I missed adding cc list for the last conversation so adding this for reference:
>>>
>>>> Wouldn't be good if we check this in perf_callchain_user() as it will
>>>> cover both cases.
>>>
>>> to which Viktor replied:
>>> I considered it but in that case, we'd also miss the top-level stack
>>> frame (the perf_callchain_store call above). Other arches include it so
>>> I followed the behavior for powerpc.
>>>
>>> Viktor, agreed with your first point. I have another concern:
>>>
>>> I was hitting this issue with stacktrace_build_id_nmi in bpf and
>>> applied this patch https://lore.kernel.org/bpf/20260126074331.815684-1-chen.dylane@linux.dev/T/#mf901967ebe77506f1bd6e3d876c2a85824d9519d
>>>
>>> Wondering if the above generic fix is working do we need to add this
>>> check in powerpc specific code?
>>
>> I tried to apply that patch series but, unfortunately, keep getting the
>> panic when running the BCC profile tool.
>>
>> Also, looking at the patch, it seems that it would only solve the issue
>> when perf_callchain_user is called from a BPF context, however, I assume
>> that it may be called from other contexts, too.
>>
>> Since perf_callchain_user_{32,64} are dereferencing current->mm while
>> walking the stack, I think that an explicit protection against
>> current->mm being NULL makes sense here, even in the presence of the
>> above patch. Especially since other arches have it, too.
>>
>> Viktor
>>
> Ok that looks convincing then, another thing is that, how about moving perf_callchain_store
> to perf_callchain_user and checking current->mm == NULL there for both perf_callchain_user_32/64.
> next_ip, lr and sp can be passed to perf_callchain_user_32/64.

Yeah, that should be possible. I'll send v2.

Viktor

> 
> Thanks,
> Saket
> 

