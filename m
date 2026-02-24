Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5475B376471;
	Tue, 24 Feb 2026 12:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771937596; cv=none; b=uUWOtQllExgpN0tI0JmltiDGn8pq7QVhSMnghbNKUh/HonL/2d2k6I3FMyCtjkyc4wWMP1veUjR8imlIlGT2P1ypXf1ae0nggahOPVULB3bfeY2lFkfGMYKYnMfqkQxaGvDFG3/9yZWY/SHDEOLgRTf59r2UDL/A8NKB9VXCu8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771937596; c=relaxed/simple;
	bh=iQHVQNUQB50AzZBE2LCvgrKsoBoVJCGFVBqTvImcwoY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KrBinzZ4Innca5kSuszROio+fIU1R73rBGVZhCFMaJeAnEw/jlNr6drzfy3HYxNpg3TFkgpiOkcEdxwSdQrycZ82mofegU5ZIoGfPvKVMIiUWW/IAJS9qCFfrzJgAwZ5+zKHhiRlfdOqy3HXbgEaly3x1GrMy5rMixzJDKE1wrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 79B39339;
	Tue, 24 Feb 2026 04:53:08 -0800 (PST)
Received: from [10.163.172.181] (unknown [10.163.172.181])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5C37F3F62B;
	Tue, 24 Feb 2026 04:53:09 -0800 (PST)
Message-ID: <c3b996e5-1c2f-4dea-b25b-31d24bc9620f@arm.com>
Date: Tue, 24 Feb 2026 18:23:06 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V1 04/16] perf/events: Replace READ_ONCE() with standard
 pgtable accessors
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Ryan Roberts <ryan.roberts@arm.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Linu Cherian <linu.cherian@arm.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, linux-perf-users@vger.kernel.org
References: <20260224051153.3150613-1-anshuman.khandual@arm.com>
 <20260224051153.3150613-5-anshuman.khandual@arm.com>
 <aZ14lUwuA86aiOH-@J2N7QTR9R3>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <aZ14lUwuA86aiOH-@J2N7QTR9R3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/02/26 3:38 PM, Mark Rutland wrote:
> On Tue, Feb 24, 2026 at 10:41:41AM +0530, Anshuman Khandual wrote:
>> Replace READ_ONCE() with standard page table accessors i.e pxdp_get() which
>> anyways default into READ_ONCE() in cases where platform do not override.
> 
> For each of the patches where you make this sort of change, please
> explain in the commit message *why* it is necessary to do this.

Sure will explain the intent better for these patches.

> > IIUC the entire point of this is that in subsequent patches, arm64 will
> need to use something other than READ_ONCE() for all pXX levels in order
> to support D128 translation tables.

Right.

> 
> Spelling that out in the commit message makes it much easier for
> reviewers to see what's going on, and to focus any discussion/questions,
> e.g. *why* won't READ_ONCE() work?

Got it.

> 
> Mark.
> 
>>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
>> Cc: Namhyung Kim <namhyung@kernel.org>
>> Cc: linux-perf-users@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>>  kernel/events/core.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>> index ac70d68217b6..4ee151cd2c6d 100644
>> --- a/kernel/events/core.c
>> +++ b/kernel/events/core.c
>> @@ -8422,7 +8422,7 @@ static u64 perf_get_pgtable_size(struct mm_struct *mm, unsigned long addr)
>>  	pte_t *ptep, pte;
>>  
>>  	pgdp = pgd_offset(mm, addr);
>> -	pgd = READ_ONCE(*pgdp);
>> +	pgd = pgdp_get(pgdp);
>>  	if (pgd_none(pgd))
>>  		return 0;
>>  
>> @@ -8430,7 +8430,7 @@ static u64 perf_get_pgtable_size(struct mm_struct *mm, unsigned long addr)
>>  		return pgd_leaf_size(pgd);
>>  
>>  	p4dp = p4d_offset_lockless(pgdp, pgd, addr);
>> -	p4d = READ_ONCE(*p4dp);
>> +	p4d = p4dp_get(p4dp);
>>  	if (!p4d_present(p4d))
>>  		return 0;
>>  
>> @@ -8438,7 +8438,7 @@ static u64 perf_get_pgtable_size(struct mm_struct *mm, unsigned long addr)
>>  		return p4d_leaf_size(p4d);
>>  
>>  	pudp = pud_offset_lockless(p4dp, p4d, addr);
>> -	pud = READ_ONCE(*pudp);
>> +	pud = pudp_get(pudp);
>>  	if (!pud_present(pud))
>>  		return 0;
>>  
>> -- 
>> 2.43.0
>>

