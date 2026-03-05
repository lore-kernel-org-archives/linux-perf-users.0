Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F27336888
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Mar 2026 12:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772714751; cv=none; b=qit10xqPnyc+/P0qybzhxKTsFdUgvMgoBm/LkeHozKm9ePFhk3+ZqaIgWaZgHPAIWsh9UQ4j/IUiGTGC8OJf2ffpIRKEld46MemL9MwA+PKe/lUsWhRUJAsEyXb0vW5CDEFCsI/IkhIRO6ZODiUawa3I7ZwreDPLfr0dFFiEg1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772714751; c=relaxed/simple;
	bh=edIqlo7BDG6ryHe7lI82URkSb6Ls8kMYck1YU1J8E1g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aIpY+kpqANfgfktdbscg8SrP93DbdrGjcdWZfA3chJc+Pwi+krquy1pgzMlGJ7cNHiY9LhGswStjshFv7MTLkTtgJgV2TqzXdgx1OHrek3l14i2ffxa6ymNi3vdxha78SQQv5BrTiTuR7QCxZ4AZenibgIi5OB+1KAamWsdR9Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SOWBUKRc; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=qlpK8CE+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SOWBUKRc";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="qlpK8CE+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772714749;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8lkxI+3lOCvkC886PGfDKxPOQ08Kegpy+JUcXJYkgXA=;
	b=SOWBUKRce6kIWv1MyUgZleDb4nVRyNebl8d3hG5ea+s4k2w4j36aUaAgLYRQJgrFfFUf+4
	JFjeglKehjjD+8ZyOyqMZv3s/tEqsJ4Xs/y7PYgRXFytWXXJ0kZZdknK7BervQD/6k0Es0
	1qPbCHkl0dasRNoWyWITkzRohQUd6Nc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-99-B-Jb-C15M2CJ0X3dfAWJZA-1; Thu, 05 Mar 2026 07:45:48 -0500
X-MC-Unique: B-Jb-C15M2CJ0X3dfAWJZA-1
X-Mimecast-MFC-AGG-ID: B-Jb-C15M2CJ0X3dfAWJZA_1772714747
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-48379489438so78378185e9.2
        for <linux-perf-users@vger.kernel.org>; Thu, 05 Mar 2026 04:45:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772714747; x=1773319547; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8lkxI+3lOCvkC886PGfDKxPOQ08Kegpy+JUcXJYkgXA=;
        b=qlpK8CE+z6SiPusVJ42z3qIS5SRAuM5Wb8j/bU+mVXE+llq+wKv9b/ZFD4tNQxUCSR
         TotHwnHRW+UsY5K7yJplslDOQcDOhdBBSuA5g/Li9ify6I/QBrDQ3IzVFrVBoU/gf+zT
         lt6HJsmTUPnvz93r96lD2mTeG1IhLmpkMrnOlNcl0LtTSnjgJlNSp6+qjixHplc4JQ0z
         ZvIrRLrRmHZSuEOCivuegOqIApYUbLvvuJBdulY8qbj11J09gB3KV+zFuphHFXpcoIWl
         hYoWAOupr2TLt3QZpOq9ZI67nnJ8LM/bE31yuVa5ejTbexkPHNulWA6EmPwNG2yVI+xq
         Bwkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772714747; x=1773319547;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8lkxI+3lOCvkC886PGfDKxPOQ08Kegpy+JUcXJYkgXA=;
        b=c3qLpmbYJ26vA1ockL23ox0v5weYVV0uMYce9M4t7zrC3/1iVbSheNQH4FSf1KPbGN
         HzY3hG8EWHSFCj3TeD53T+q0A/ocnNnmP2uV32Tsbm27mgX5YZOK36zhecszt3uVxQol
         aiNbnFLQux2RU7LgM6IrQTuMdrYBsdRWwwSV0ZDiRuymLq0iw8W+t9lTcu79QwIBTXUN
         hGDfLFyfdeRZiCgdGWmTT0xsRDz0qPmLGKDiwflP4zjdTmedeB5Vy9wm/Qct7ur7Bm2s
         /2/8pZgcJCkQVvlYGzETTfpAGTGLp38K7WdWWIAdcKDiS8h3FIcmPxQFbP+LndYJxeod
         Xyjw==
X-Forwarded-Encrypted: i=1; AJvYcCWq18N7OiFf1BcLlR4D+bZjGYzCwPXTVkRHs+/MIeZPpFs7KE/c6yOmTaZKsEDkeSUZr3QNeWXTeOAi0otZcOK+@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5izb+FkE1i/rrX+mcTqTGqLnPQssOJQmzgOuWYTn0+Q8cZNgV
	ie7/Wtm6x7u435GpsuSyraeXuhdnWJf9soQLMfqLVKvlGfnTgi0wZNgjIQNfZthr2uh5/uYGNV3
	Zzr0ZL0v9XvW0IkwtbIx8gQSXhkWBXY+sAmK97+JYkHgp9GFrd3GXvIEudANekCTNwMj79g==
X-Gm-Gg: ATEYQzwYf1JxHbyQGyo1MemmOwRtPQBF2kPpuz7XClniMLdZ+ie6r0O3N5SKaXXpYhj
	uXhWgEBjpwaAte2MoliFqy+FqS+fTUlSZjUUxgA35zZqqp83fz8ijF+jVGMaViNINQkK608oYF+
	aTdIszPdzotxWymOZb9KRLZQKVwd3wuKAawhd61KwOr2oY/bM5HoJT7GIw/h6chOf+22zpbR6mW
	BUfFpgdJ4hEjW14nv4xZPfuLR1UHTWnW8rpuxar9IBRXA5yEn5CX5vEFkwkLyk8enUxAzpyLXm4
	M9dRYlyPE3wfxVhjDAdrQLWcm9Lgwim/Tj0J9BAyMWMdTo81Vy5aAWfo56AtjDwCtmcFLgTZ+TC
	nfEauQcW43j5Axtzyy0HkaMmnTel1oRmCWAWPFZZaO7AY59ZuE+Xjlm73
X-Received: by 2002:a05:600c:458d:b0:482:eec4:74c with SMTP id 5b1f17b1804b1-4851988a630mr86649845e9.22.1772714746636;
        Thu, 05 Mar 2026 04:45:46 -0800 (PST)
X-Received: by 2002:a05:600c:458d:b0:482:eec4:74c with SMTP id 5b1f17b1804b1-4851988a630mr86649485e9.22.1772714746130;
        Thu, 05 Mar 2026 04:45:46 -0800 (PST)
Received: from [192.168.0.135] (185-219-167-205-static.vivo.cz. [185.219.167.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851fb33815sm80533045e9.12.2026.03.05.04.45.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Mar 2026 04:45:45 -0800 (PST)
Message-ID: <80766050-c745-411b-8ee6-8141d2cfe4ff@redhat.com>
Date: Thu, 5 Mar 2026 13:45:44 +0100
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
From: Viktor Malik <vmalik@redhat.com>
Content-Language: en-US
In-Reply-To: <aab3EW1LfDcjSzzy@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/3/26 15:58, Saket Kumar Bhaskar wrote:
> On Fri, Feb 27, 2026 at 09:25:02AM +0100, Viktor Malik wrote:
>> It may happen that mm is already released, which leads to kernel panic.
>> This adds the NULL check for current->mm, similarly to 20afc60f892d
>> ("x86, perf: Check that current->mm is alive before getting user
>> callchain").
>>
>> I was getting this panic when running a profiling BPF program
>> (profile.py from bcc-tools):
>>
>>     [26215.051935] Kernel attempted to read user page (588) - exploit attempt? (uid: 0)
>>     [26215.051950] BUG: Kernel NULL pointer dereference on read at 0x00000588
>>     [26215.051952] Faulting instruction address: 0xc00000000020fac0
>>     [26215.051957] Oops: Kernel access of bad area, sig: 11 [#1]
>>     [...]
>>     [26215.052049] Call Trace:
>>     [26215.052050] [c000000061da6d30] [c00000000020fc10] perf_callchain_user_64+0x2d0/0x490 (unreliable)
>>     [26215.052054] [c000000061da6dc0] [c00000000020f92c] perf_callchain_user+0x1c/0x30
>>     [26215.052057] [c000000061da6de0] [c0000000005ab2a0] get_perf_callchain+0x100/0x360
>>     [26215.052063] [c000000061da6e70] [c000000000573bc8] bpf_get_stackid+0x88/0xf0
>>     [26215.052067] [c000000061da6ea0] [c008000000042258] bpf_prog_16d4ab9ab662f669_do_perf_event+0xf8/0x274
>>     [...]
>>
>> Fixes: 20002ded4d93 ("perf_counter: powerpc: Add callchain support")
>> Signed-off-by: Viktor Malik <vmalik@redhat.com>
>> ---
>>  arch/powerpc/perf/callchain_32.c | 3 +++
>>  arch/powerpc/perf/callchain_64.c | 3 +++
>>  2 files changed, 6 insertions(+)
>>
>> diff --git a/arch/powerpc/perf/callchain_32.c b/arch/powerpc/perf/callchain_32.c
>> index ddcc2d8aa64a..b46e21679566 100644
>> --- a/arch/powerpc/perf/callchain_32.c
>> +++ b/arch/powerpc/perf/callchain_32.c
>> @@ -144,6 +144,9 @@ void perf_callchain_user_32(struct perf_callchain_entry_ctx *entry,
>>  	sp = regs->gpr[1];
>>  	perf_callchain_store(entry, next_ip);
>>  
>> +	if (!current->mm)
>> +		return;
>> +
>>  	while (entry->nr < entry->max_stack) {
>>  		fp = (unsigned int __user *) (unsigned long) sp;
>>  		if (invalid_user_sp(sp) || read_user_stack_32(fp, &next_sp))
>> diff --git a/arch/powerpc/perf/callchain_64.c b/arch/powerpc/perf/callchain_64.c
>> index 115d1c105e8a..eaaadd6fa81b 100644
>> --- a/arch/powerpc/perf/callchain_64.c
>> +++ b/arch/powerpc/perf/callchain_64.c
>> @@ -79,6 +79,9 @@ void perf_callchain_user_64(struct perf_callchain_entry_ctx *entry,
>>  	sp = regs->gpr[1];
>>  	perf_callchain_store(entry, next_ip);
>>  
>> +	if (!current->mm)
>> +		return;
>> +
>>  	while (entry->nr < entry->max_stack) {
>>  		fp = (unsigned long __user *) sp;
>>  		if (invalid_user_sp(sp) || read_user_stack_64(fp, &next_sp))
>> -- 
>> 2.53.0
>>
> Sorry, I missed adding cc list for the last conversation so adding this for reference:
> 
>> Wouldn't be good if we check this in perf_callchain_user() as it will
>> cover both cases.
> 
> to which Viktor replied:
> I considered it but in that case, we'd also miss the top-level stack
> frame (the perf_callchain_store call above). Other arches include it so
> I followed the behavior for powerpc.
> 
> Viktor, agreed with your first point. I have another concern:
> 
> I was hitting this issue with stacktrace_build_id_nmi in bpf and
> applied this patch https://lore.kernel.org/bpf/20260126074331.815684-1-chen.dylane@linux.dev/T/#mf901967ebe77506f1bd6e3d876c2a85824d9519d
> 
> Wondering if the above generic fix is working do we need to add this
> check in powerpc specific code?

I tried to apply that patch series but, unfortunately, keep getting the
panic when running the BCC profile tool.

Also, looking at the patch, it seems that it would only solve the issue
when perf_callchain_user is called from a BPF context, however, I assume
that it may be called from other contexts, too.

Since perf_callchain_user_{32,64} are dereferencing current->mm while
walking the stack, I think that an explicit protection against
current->mm being NULL makes sense here, even in the presence of the
above patch. Especially since other arches have it, too.

Viktor

