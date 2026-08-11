Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDFB418340
	for <linux-perf-users@vger.kernel.org>; Tue, 11 Aug 2026 09:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786438969; cv=none; b=pAx24sdFElP2Vxbxm6gvmZReHGfn21le/Gbch7J8EIh4qxs8mmYjJnCfjr25EkzQgQe+z+JGsKEkaf6Q5NFterG7NzOr+5S9l4IHPtmsYegmQtaMgI2SkDL74dC0eBEV3doPmExTt+oFm5Dt1QwQ2FA/h1/XUwj06LLKwYAy/IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786438969; c=relaxed/simple;
	bh=UNdShtdhmtajLCAjGkTFht9aSZ4+5TfV85KWo3ksl+Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FMH/tpO8Q4+AaUKX6K2enCsC0fULGoZcRYM/RJUwkkHqGaTZHmO/A9XLz/mfX5R0HXsSQoZkglDGo1aPqQR2lmIYzv0J3MYiRkLQtg2AqshvJX/zIChQ4DP1otxFXiKmneEjPHyIRsv9TQxmLzEoP6amfcrmQPbsR0E/u5+hFsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zmMDs8p1; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zmMDs8p1"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-47de008b020so432262f8f.1
        for <linux-perf-users@vger.kernel.org>; Tue, 11 Aug 2026 02:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1786438966; x=1787043766; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oJ88OLZKf9QMZYTUIDUM+DdXOTb/AyphVnNJxcq65aI=;
        b=zmMDs8p1h97Dkny2bIuQp1WJ+p5UwnVpcQ5Ne4Vn2F+m1l0rlqydxW3q0Rzb30eHso
         g94Cwe/By4wlnMQ1HaUMAB95yFPRIGYx9vGsADAUwAbScYJos7d5GjY/5ntEuZ0DKBZK
         ixVjtvhE6rd/aQV20LpmWymrdUsOZyQRRwH5d6QIVloS7ELmi4925+tSHsiYb+SYX4cH
         XnAdccX6FJMPRH35K4JB7etmsQ9NYehFnHueVVqcSh7BDiFsnfzJU/ozFBT5XvI8g/EU
         AKcb8hxoNwbX3uhh3RdNb8ccxkD8dbGjjh9jvEveCCR+TWh6nYxbCRXkfvMCIBe6uu0y
         z2FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786438966; x=1787043766;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oJ88OLZKf9QMZYTUIDUM+DdXOTb/AyphVnNJxcq65aI=;
        b=sUn6q/zf3zvpYwZp92FxA5vz6RrX8sLWv3gk2IPI8IiALjSp9J8etZSceERndp9cCQ
         Tf0mhnfP92W1Mr7uCjz0vHM7KyotCqc0e8ABRPx3ZD0Ve+6SiPYsXTvDl5WTxa6SuEM6
         zhKxkpQcya3FE+ak3xJhh1gHqfpuh7eFurtIM4c4f5LHI8atrhZBaELrt9Gl5DljjTX8
         NEU+ScNtWU3N0nyAI3dqICtjI/1IOmccjUOviVdO7cuploVRrW/EMJWEwruVZSPvsGbX
         eS8MPMMG9A3lIfEU9cxJI3t3zjSiPcJzdI7u5j3Ux3t2PgsvuWdDhEjqKGRUFf+VvwQ4
         hM5w==
X-Forwarded-Encrypted: i=1; AHgh+RqWIkpIB7aGWc5OYxQ9WTkZtBhlYC7+2V/TO5Yy65M7B76Q609Q+7mm/xiRT6lTAcC9Qhjy3DRKb8p8xbFne0Iw@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1hxcnBT7Ppk2twwEB6aBuyscz6jS/i/BVfbdAaiyqpepp3Ujo
	Vzs8LTI8yivplf8dWgx49LPOuE3Iy+ZiQ4KL5GLWYDtHGUBcYWKVqQg/Jo4nBeekmU4=
X-Gm-Gg: AR+sD11hvotSEyjqyewBmi+OzhUFYhTFy7xUjr16yaWIoO1UsXLccxf3mzR/9PUpifO
	vMRO09yf7Ml71uxBNIaTKG4dJC6uBVeiTk/ZV8D6FSycTVCewnAbtuxVxVfSEfc1XNAIi0fHeP2
	u00pYXTMlSfKzM94oPxH6RWr6KOYNXe+NqFNeVHyofaDXoZWeGP339jqnDRYqDj8Ls0KsqYVFC9
	lcAQXIKZ+4dPaA/0b/Qzz1lJZH1WTuDs8Qp8dHi6PYvvAZUxceG8kPPt6JErGaiiykckLdruozc
	Zhb3vzPatAOD+IxWod2m+B9ihjP9NkED9NAgXlQvbuyYbwEBnFG6+CEavrTpqSBZ0tpgwFXxNJO
	oOlQUm/eMgoKu080vVPgX82YVZpMoJXWyK/ybA38BPfBRkGZKgJ1GOqAfj389PPcZtJgWVMjutT
	j6z7XtsZ4duMTsbcDJh7cLjS6jocRmQL+xvh9R5zE+T3ES/ZUCSCCc48C0IpNfDD7tvrM=
X-Received: by 2002:a05:6000:46ce:b0:474:bbbb:bf17 with SMTP id ffacd0b85a97d-4814b54d77bmr1881469f8f.0.1786438965631;
        Tue, 11 Aug 2026 02:02:45 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4814a709624sm3106323f8f.22.2026.08.11.02.02.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2026 02:02:45 -0700 (PDT)
Message-ID: <8c8f6c2a-8fc2-4181-87fa-e64101dfce6f@linaro.org>
Date: Tue, 11 Aug 2026 10:02:44 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] perf: arm_spe: Prefer large AUX mappings
To: Leo Yan <leo.yan@arm.com>, Will Deacon <will@kernel.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
 Peter Zijlstra <peterz@infradead.org>, Mike Leach <mike.leach@arm.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Mark Rutland <mark.rutland@arm.com>, Tamas Petz <tamas.petz@arm.com>,
 Tamas Zsoldos <tamas.zsoldos@arm.com>,
 Michiel van Tol <michiel.vantol@arm.com>, Dev Jain <dev.jain@arm.com>,
 David Hildenbrand <david@kernel.org>, Yabin Cui <yabinc@google.com>,
 coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <20260810-perf_aux_trace_large_granule-v1-0-03306c9339e3@arm.com>
 <20260810-perf_aux_trace_large_granule-v1-2-03306c9339e3@arm.com>
 <annp-BdTviQoH6vy@willie-the-truck> <20260810174159.GC15499@e132581.arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260810174159.GC15499@e132581.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/08/2026 18:41, Leo Yan wrote:
> On Mon, Aug 10, 2026 at 04:10:48PM +0100, Will Deacon wrote:
>> On Mon, Aug 10, 2026 at 03:44:42PM +0100, Leo Yan wrote:
>>> Commit 18049c8cff9c ("perf/aux: Allocate non-contiguous AUX pages by
>>> default") made the AUX allocator use order-0 pages by default unless a
>>> PMU explicitly asks for contiguous allocations.
>>
>> But that commit specifically calls out SPE as benefitting from
>> non-contiguous pages:
>>
>>    "For instance, ARM SPE and TRBE operate with virtual pages, and
>>     Coresight ETR allocates a separate buffer. For these PMUs,
>>     allocating contiguous AUX pages unnecessarily exacerbates memory
>>     fragmentation. This fragmentation can prevent their use on
>>     long-running devices."
>>
>> so why doesn't passing PERF_PMU_CAP_AUX_PREFER_LARGE reintroduce the
>> problems that 18049c8cff9c was trying to solve?
> 
> The question is how "allocating contiguous AUX pages unnecessarily
> exacerbates memory fragmentation." The relevant information I could find
> is [1]:
> 
>   "On Android, we collect ETM data periodically on internal user devices
>    for AutoFDO optimization (for both userspace libraries and the
>    kernel). Allocating a large chunk of contiguous AUX pages (4M for each
>    CPU) periodically is almost unbearable. The kernel may need to kill
>    many processes to fulfill the request. It affects user experience even
>    after using PMU."
> 

This sounds like it could be an attribute to perf_event_open. We can do 
PREFER_LARGE by default for performance and fewer discontinuities, but 
on Android or small systems users can enable an option to revert back to 
single pages.

Or can this bit be determined at allocation time: "The kernel may need 
to kill many processes to fulfill the request"? If this memory pressure 
exists on allocation then do it one way, if not do it the other way.

> We might have missed chance to clarify how the fragmentation issue
> occurs in the first place. Let's say, a phone with 8 CPUs, allocating
> 4MB per CPU requires 32MB in total, which is a relatively small
> portion of 4GiB or 8GiB of RAM commonly found in phones. Moreover, once
> contiguous pages are freed, the buddy allocator can coalesce them
> again into buddy list. It is not obvious to me that PREFER_LARGE
> directly causes fragmentation.
> 
> One case where AUX allocation could exacerbate fragmentation is when the
> system is already fragmented. If a high-order allocation fails and the
> allocator falls back to smaller-order blocks, those allocations may
> consume free blocks scattered across different buddy regions and make
> subsequent high-order allocations more difficult.
> 
> If this is the main concern, I'd suggest using a smaller AUX buffer
> (e.g. 1MB or even 512KB) for TRBE/SPE to reduce memory pressure.
> Snapshot mode '-S' could also be considered, as it allows the buffer to
> be allocated once and reused for subsequent recordings by signals.
> 
> OTOH, using only order-0 pages can significantly increase TTW overhead
> on the trace path and lead to overflows, we observe this causes huge
> trace discontinuity. In the end, we need to trace-off the fragmentation
> concern against the trace discontinuity.
> 
> Thanks,
> Leo
> 
> [1] https://lore.kernel.org/lkml/CALJ9ZPNLgEBxOmDim-vztUknEETwdL-Z2gJ8K9s44TiPgKZgHg@mail.gmail.com/

