Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776A015AE8
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Oct 2023 08:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eXCgRIQM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3F891BD2
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Oct 2023 01:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697705022;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sNhtEDb46cdwd0UeanpUYMMLzJiY9Fo2EaQX8hX2fF8=;
	b=eXCgRIQM2G2hipbr4IOvdBJfWprzG7LsVLNYK4RTcoYHxPcKQ6GAV0gFIWJYgRKCcNcSnz
	ZT2hjSS0Jy1EBRuUuUhKjw4n9b6WnphPLDuQEI/0wXWcrM1cBYKVmm2jRhn7Ed7I7KJlvS
	bQLbU+3gfh7+V2pvTEjERlZ386LFJx8=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-SRYxxkX_PUSLD3YhvSFNpQ-1; Thu, 19 Oct 2023 04:43:40 -0400
X-MC-Unique: SRYxxkX_PUSLD3YhvSFNpQ-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-63d0c38e986so85104466d6.1
        for <linux-perf-users@vger.kernel.org>; Thu, 19 Oct 2023 01:43:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697705020; x=1698309820;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sNhtEDb46cdwd0UeanpUYMMLzJiY9Fo2EaQX8hX2fF8=;
        b=ox3XDOM/HMraDPTaW1tLoISQHkWUjAd3KiUnznEQF6NMDZ2C7YCgmsO10pAXs2FLrd
         KVz3VQvKjN4Th9UwFYAUFVx6L27HF3SwlTzT51mDKZ20S7LUwl7jjl0b5l2RiOvDi+Jh
         aqyE4OoMj3j4HNLC8TswDM4fz7qCgEQb8DFCAhAHNkv8ZphDuMd2HfIdIRYnS0gJ5oym
         bvCVp9/YIedoHpwaCkHwc014Y0EOpb2jExIo6vF5iPEUKnzPOMnWypajsXlyopMNOOLJ
         fhRMUoN5EtjQ0FWW3EOyq7Mqaf/PhhxGKbGoyoTALoOede1Q4qtLGSzeRKMDqL4hEgyH
         C8Sg==
X-Gm-Message-State: AOJu0YwTroboWMvdNq0bdr6tp1ZDqEcbWulW8QxhKcEzx6eNfyJrbcLx
	MsvWZejPlVEJ9b3qbeBSCCkHHQkUAf3pmHgSQlYLn4H/dOWu1FRgq4dWqnDmyvqgLnRZ23tlnJj
	NxspjVuM5g/JRgJ+vqG0I+7FJ5pqSOg==
X-Received: by 2002:ad4:5fcd:0:b0:66c:ffe1:e244 with SMTP id jq13-20020ad45fcd000000b0066cffe1e244mr2186139qvb.62.1697705020215;
        Thu, 19 Oct 2023 01:43:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IETbfgv/8+88fGni1xgnaMxsBgnNEdj2B+ZY0ZeQEa62JYNYio5HxIOk7eFGTP20cQ6OiiUgQ==
X-Received: by 2002:ad4:5fcd:0:b0:66c:ffe1:e244 with SMTP id jq13-20020ad45fcd000000b0066cffe1e244mr2186118qvb.62.1697705019902;
        Thu, 19 Oct 2023 01:43:39 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id t6-20020a056214118600b0066d11c1f578sm625981qvv.97.2023.10.19.01.43.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Oct 2023 01:43:39 -0700 (PDT)
Message-ID: <48d09c9f-78d9-e5eb-d85a-e75a6df81396@redhat.com>
Date: Thu, 19 Oct 2023 10:43:34 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 4/5] tools headers arm64: Update sysreg.h with kernel
 sources
Content-Language: en-US
To: Oliver Upton <oliver.upton@linux.dev>
Cc: Mark Brown <broonie@kernel.org>, kvm@vger.kernel.org,
 kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-perf-users@vger.kernel.org, Jing Zhang <jingzhangos@google.com>,
 Zenghui Yu <yuzenghui@huawei.com>, Suzuki K Poulose
 <suzuki.poulose@arm.com>, James Morse <james.morse@arm.com>,
 Marc Zyngier <maz@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Adrian Hunter <adrian.hunter@intel.com>, Ian Rogers <irogers@google.com>,
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>
References: <20231011195740.3349631-1-oliver.upton@linux.dev>
 <20231011195740.3349631-5-oliver.upton@linux.dev>
 <73b94274-4561-1edd-6b1e-8c6245133af2@redhat.com>
 <3c5332b0-9035-4cb8-96ce-7a9b8d513c3a@sirena.org.uk>
 <8baca35a-9154-97e6-d682-032fc69d2da6@redhat.com>
 <ZTBzAR1KsWuurob7@linux.dev>
From: Eric Auger <eauger@redhat.com>
In-Reply-To: <ZTBzAR1KsWuurob7@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Oliver,

On 10/19/23 02:06, Oliver Upton wrote:
> Hi Eric,
> 
> Thanks for reviewing the series.
> 
> On Wed, Oct 18, 2023 at 03:06:12PM +0200, Eric Auger wrote:
>> Hi Mark, Oliver,
>>
>> On 10/18/23 14:16, Mark Brown wrote:
>>> On Wed, Oct 18, 2023 at 01:57:31PM +0200, Eric Auger wrote:
>>>> On 10/11/23 21:57, Oliver Upton wrote:
>>>
>>>>>  #define set_pstate_pan(x)		asm volatile(SET_PSTATE_PAN(x))
>>>>>  #define set_pstate_uao(x)		asm volatile(SET_PSTATE_UAO(x))
>>>>>  #define set_pstate_ssbs(x)		asm volatile(SET_PSTATE_SSBS(x))
>>>>> +#define set_pstate_dit(x)		asm volatile(SET_PSTATE_DIT(x))
>>>
>>>> could you comment on the *DIT* addictions, what is it for?
>>>
>>> DIT is data independent timing, this tells the processor to ensure that
>>> instructions take a constant time regardless of the data they are
>>> handling.
>>
>>>
>>> Note that this file is just a copy of arch/arm64/include/asm/gpr-num.h,
>>> the main purpose here is to sync with the original.
>>
>> Ah thanks. that's helpful for me to understand where this gpr-num.h
>> comes from. This could be documented in the commit msg though.
>>
>> Something like:
>>
>> adding tools/arch/arm64/include/asm/gpr-num.h matching linux
>> arch/arm64/include/asm/gpr-num.h
>>
>> and syncing tools/arch/arm64/include/asm/sysreg.h with the fellow header
>> in the linux tree.
> 
> Yeah, I could've spelled it out a bit more. I already cracked this off
> of an even larger patch from before I picked up the series because the
> diff was massive.
> 
>> tbh I did not initially understand that all this diffstat was aimed to
>> match the linux arch/arm64/include/asm/sysreg.h. Now diffing both I have
>> some diffs. Doesn't it need a refresh?
> 
> I'm worried it is a fool's errand at this point to keep the two in sync,
> as I'm sure there will be more in -rc1. The tools copy of sysreg.h isn't
> a verbatim copy either, there are some deliberate deletions in there as
> well.
> 
> I've taken this as is, we can always come back and update the headers
> afterwards if we find a need for it

OK np. I did not notice you picked the series up and I jumped in too
late. Anyway that was worthwhile for my education ;-)

Eric
> 

