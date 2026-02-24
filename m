Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36D3127BF6C;
	Tue, 24 Feb 2026 12:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771937357; cv=none; b=C6Yd9o+iCRxfcXU+vAzdYiXMBMANKMrJ58CsK+aM+kSqykQzjJDGpzh+2NilLDkPJe5CWv9gaYSyfp+pLu5Ec/8IN7G947n62Tn+VpaQA6LCvJ/MtCWzgIcGGyUkeBvNC9ZAd1I8w7Mmi2z8Bh7paxyEo5USgRaLanCZwPPHW+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771937357; c=relaxed/simple;
	bh=BR5kdYudbTbkxritXneTaZ9oiN8qQ4GDm7RBwpcvgOk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=llAJJOsp9esEu+EO5prTSMEIfhaMEqYQX5bsA5mw6vZUjWv4i5AIVqaOlT7QTQkdMoEg4+wT2xHqY3zKFhTh93ueKDYveHDeEP7SwIajrwKgY9Kivr96vbliFQFBvlfBlyjcSKcwqSBCnrhXj4TzH9l5/19tDJagZyDBfBAEMMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 39386339;
	Tue, 24 Feb 2026 04:49:09 -0800 (PST)
Received: from [10.163.172.181] (unknown [10.163.172.181])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2C3EB3F62B;
	Tue, 24 Feb 2026 04:49:09 -0800 (PST)
Message-ID: <9ef5f8e4-0cc5-404e-8287-ce43fcf5c139@arm.com>
Date: Tue, 24 Feb 2026 18:19:06 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V1 04/16] perf/events: Replace READ_ONCE() with standard
 pgtable accessors
To: Ryan Roberts <ryan.roberts@arm.com>, Peter Zijlstra
 <peterz@infradead.org>, Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Linu Cherian <linu.cherian@arm.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, linux-perf-users@vger.kernel.org
References: <20260224051153.3150613-1-anshuman.khandual@arm.com>
 <20260224051153.3150613-5-anshuman.khandual@arm.com>
 <aZ14lUwuA86aiOH-@J2N7QTR9R3>
 <20260224104134.GW1395266@noisy.programming.kicks-ass.net>
 <6812706f-1ea3-416d-8ba1-da522238e040@arm.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <6812706f-1ea3-416d-8ba1-da522238e040@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 24/02/26 4:52 PM, Ryan Roberts wrote:
> On 24/02/2026 10:41, Peter Zijlstra wrote:
>> On Tue, Feb 24, 2026 at 10:08:21AM +0000, Mark Rutland wrote:
>>> On Tue, Feb 24, 2026 at 10:41:41AM +0530, Anshuman Khandual wrote:
>>>> Replace READ_ONCE() with standard page table accessors i.e pxdp_get() which
>>>> anyways default into READ_ONCE() in cases where platform do not override.
>>>
>>> For each of the patches where you make this sort of change, please
>>> explain in the commit message *why* it is necessary to do this.
>>>
>>> IIUC the entire point of this is that in subsequent patches, arm64 will
>>> need to use something other than READ_ONCE() for all pXX levels in order
>>> to support D128 translation tables.
>>>
>>> Spelling that out in the commit message makes it much easier for
>>> reviewers to see what's going on, and to focus any discussion/questions,
>>> e.g. *why* won't READ_ONCE() work?
>>
>> That, and only being sent *one* patch, I have no clue what the rest of
>> them are doing. Didn't even get 0/n.
>>
>> I hate people sending me just one patch; just send the whole series
>> already.
> 
> Perhaps Anshuman can forward you the rest of the series, but FWIW, the cover
> letter is here:
> https://lore.kernel.org/all/20260224051153.3150613-1-anshuman.khandual@arm.com/

I have already forwarded the entire series to Peter.

> 
> High level summary is that we are adding support for 128 bit page tables on
> arm64. Existing places that use READ_ONCE() to read PTEs now require 128-bit
> single copy atomicity guarrantees, which READ_ONCE() doesn't allow (on arm64 at
> least) - it fails to compile if used on anything over 64 bit.
> 
> load pair/store pair (ldp/stp) are only single copy atomic if FEAT_LSE128 is
> supported (which is required if FEAT_D128 - 128 bit pgtables - is suported).
> Currently 128 bit pgtables is a compile time decision so we could have chosen to
> extend READ_ONCE()/WRITE_ONCE() to allow 128 bit for this configuration. But
> it's a general purpose API and we were concerned that other users might
> eventually creep in that expect 128 and then fail to compile in the other configs.
> 
> But worse, we are considering eventually making D128 a boot time option, at
> which point we'd have to make READ_ONCE() always allow 128 bit at compile time
> but then it might silently tear at runtime.
> 
> So our preference is to standardize on these existing helpers, which we can
> override in arm64 to give the 128 bit SCA guarrantee when we need it.

That summarizes the intent for this change - will update the commit message
as required. Thanks Ryan for such a detailed explanation. 
