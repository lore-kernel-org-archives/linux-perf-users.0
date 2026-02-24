Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E923F3803D1;
	Tue, 24 Feb 2026 12:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771936801; cv=none; b=pDAFC/mIFqJnbOyPt+2QJOxPdgmkj2d89/UkP/GNkrBRHNQ+DsbaV79V/JdhQYIJVwLJ8ylJx/yHWADVZPLKFMS4JqvOINzjS+s6dbcyVqfAA5dVkr9vb27bLYqjiBJvkHE63xNCbqXFNrDXKM8zZQwXk68YS+k9oVeIWW8Fekk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771936801; c=relaxed/simple;
	bh=Tc4yE1Igmo3JuyNBu6GkT6M4Zfl82jcWV3+0wgKor1g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f517vYPUaU9J1DyYsrbvPTPh9nVkTqulPwN4Gs3ZAOenAfpAjsv+maVfwQxTQjZBwtzRIddGw1Z4n6SyxcOfHwrMh7DmR0HmYXY4OMDPkG5zIEZi20QJe8v0l2P0DLFBT/REywaVi+HJJQLLQhSFRphiDsIXJiPgnD3U9bS1Brc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EC973339;
	Tue, 24 Feb 2026 04:39:52 -0800 (PST)
Received: from [10.163.172.181] (unknown [10.163.172.181])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AF7683F62B;
	Tue, 24 Feb 2026 04:39:53 -0800 (PST)
Message-ID: <99e06029-7738-4275-829d-6d96867785be@arm.com>
Date: Tue, 24 Feb 2026 18:09:50 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V1 04/16] perf/events: Replace READ_ONCE() with standard
 pgtable accessors
To: Peter Zijlstra <peterz@infradead.org>, Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Ryan Roberts <ryan.roberts@arm.com>,
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
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20260224104134.GW1395266@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 24/02/26 4:11 PM, Peter Zijlstra wrote:
> On Tue, Feb 24, 2026 at 10:08:21AM +0000, Mark Rutland wrote:
>> On Tue, Feb 24, 2026 at 10:41:41AM +0530, Anshuman Khandual wrote:
>>> Replace READ_ONCE() with standard page table accessors i.e pxdp_get() which
>>> anyways default into READ_ONCE() in cases where platform do not override.
>>
>> For each of the patches where you make this sort of change, please
>> explain in the commit message *why* it is necessary to do this.
>>
>> IIUC the entire point of this is that in subsequent patches, arm64 will
>> need to use something other than READ_ONCE() for all pXX levels in order
>> to support D128 translation tables.
>>
>> Spelling that out in the commit message makes it much easier for
>> reviewers to see what's going on, and to focus any discussion/questions,
>> e.g. *why* won't READ_ONCE() work?
> 
> That, and only being sent *one* patch, I have no clue what the rest of
> them are doing. Didn't even get 0/n.
> 
> I hate people sending me just one patch; just send the whole series
> already.

Sorry about that. I normally gather emails from all individual patches
in the series while creating the Cc list for the cover letter, so that
every one receives the entire series regardless of the subsystem.

But this was the only patch that did not belong either to mm or arm64.
Hence some how missed adding your email. I have already sent the entire
series to your inbox.
