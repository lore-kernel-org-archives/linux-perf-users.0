Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6B303BB12C;
	Thu,  8 Oct 2026 10:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791456216; cv=none; b=bq0QsBMe7wLCFt3WPwUYXzqMAM9UwFA3WsWTuYTjE2NhUINywwpvaBhfqaNkMTQ01eRvpZ+i0ns4MTaXshShrx7xYqiLt/24w/kDlUN29Cr8rbnOsgONcJ6xDIPAgL4Q/Lsej3o82h3AIunaYMj8e0obkNcHS/2ZSxNEKiko4qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791456216; c=relaxed/simple;
	bh=T1jAqfIwowtrRpbeSKznwNXaX6VAkYHfAylhGBiLNqM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lOC11cvxLLnYOfvqBN2MdyARzwSNzA+gsb3esc+QrUxp9EsMGmDis0NaASbvlhuFZGZSgNuIyNgscsy507NOjvvm0fq4fbEhSHsaek3UBNMQQu2xcnY6To3Z/itIq/TAMH2yVx+KObfRF5ikFUytm/MLWHMZ8X30N9Qmd4yqkW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=c6lbfw7B; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="c6lbfw7B"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D2BD31477;
	Thu,  8 Oct 2026 03:43:30 -0700 (PDT)
Received: from [10.164.19.54] (unknown [10.164.19.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F18733F763;
	Thu,  8 Oct 2026 03:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1791456214; bh=T1jAqfIwowtrRpbeSKznwNXaX6VAkYHfAylhGBiLNqM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=c6lbfw7BRGiHAsotaazKMSDqa7nfF1pbMeub5xVs9+6i/0D/qjKph1DkIM3I85eFx
	 8iiGTsONeKOr8+3zBI66ryFcEAtnfUI+6MVDuvEsOuutmWyXcAaVtR3szW5dlkMD2r
	 P9o31AX7oelqTLFdse90tnM69G7GIhzbwwwh7Jz8=
Message-ID: <7c35e399-bc64-43c3-9588-672200758ea5@arm.com>
Date: Thu, 8 Oct 2026 16:13:27 +0530
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
 James Clark <james.clark@linaro.org>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Mark Rutland <mark.rutland@arm.com>, Tamas Petz <tamas.petz@arm.com>,
 Tamas Zsoldos <tamas.zsoldos@arm.com>,
 Michiel van Tol <michiel.vantol@arm.com>,
 David Hildenbrand <david@kernel.org>, Yabin Cui <yabinc@google.com>,
 coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <20260810-perf_aux_trace_large_granule-v1-0-03306c9339e3@arm.com>
 <20260810-perf_aux_trace_large_granule-v1-2-03306c9339e3@arm.com>
 <annp-BdTviQoH6vy@willie-the-truck> <20260810174159.GC15499@e132581.arm.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20260810174159.GC15499@e132581.arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/08/26 11:11 pm, Leo Yan wrote:
> On Mon, Aug 10, 2026 at 04:10:48PM +0100, Will Deacon wrote:
>> On Mon, Aug 10, 2026 at 03:44:42PM +0100, Leo Yan wrote:
>>> Commit 18049c8cff9c ("perf/aux: Allocate non-contiguous AUX pages by
>>> default") made the AUX allocator use order-0 pages by default unless a
>>> PMU explicitly asks for contiguous allocations.
>>
>> But that commit specifically calls out SPE as benefitting from
>> non-contiguous pages:
>>
>>   "For instance, ARM SPE and TRBE operate with virtual pages, and
>>    Coresight ETR allocates a separate buffer. For these PMUs,
>>    allocating contiguous AUX pages unnecessarily exacerbates memory
>>    fragmentation. This fragmentation can prevent their use on
>>    long-running devices."
>>
>> so why doesn't passing PERF_PMU_CAP_AUX_PREFER_LARGE reintroduce the
>> problems that 18049c8cff9c was trying to solve?
> 
> The question is how "allocating contiguous AUX pages unnecessarily
> exacerbates memory fragmentation." The relevant information I could find
> is [1]:
> 
>  "On Android, we collect ETM data periodically on internal user devices
>   for AutoFDO optimization (for both userspace libraries and the
>   kernel). Allocating a large chunk of contiguous AUX pages (4M for each
>   CPU) periodically is almost unbearable. The kernel may need to kill
>   many processes to fulfill the request. It affects user experience even
>   after using PMU."
> 
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

I don't have the full context here (can look in detail later) so drive-by comment:

In general, doing large order allocations should *reduce* fragmentation. If you allocate
16 order-0 pages as opposed to an order-4 compound page, you may end up spreading your
allocations across different blocks, thus preventing them from merging later.

A recent example can be found in vmalloc [1].

[1] https://lore.kernel.org/all/aPjrRkjiIt6HmXmT@casper.infradead.org/


> 
> [1] https://lore.kernel.org/lkml/CALJ9ZPNLgEBxOmDim-vztUknEETwdL-Z2gJ8K9s44TiPgKZgHg@mail.gmail.com/

