Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AEB9389DEA;
	Tue,  7 Apr 2026 06:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775544828; cv=none; b=Le2QUi84P9W4F13mTbYmCP+9sy9cSDMOQ5+Y4KUc7+LrPEEktuFtqXmnayoBIVtJoFffdyjRiygatr10/I1SBM3EYykAA44TfghauUl4tz/cFajCiP8NPmQGbAt2DQPsF47KdqgvNlm4qIDZTDrjeexyP4ixakpmLaKD0qLg6yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775544828; c=relaxed/simple;
	bh=xmJOywtnqtcjtDrOIaLg4cNmmd9eqq3pTFEdQ1HGsDk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rir+LCj3eAv9TyrY1hE5bWJtVJE04bpUZwtuZPjJ9Fl7H+K3gyRRp5df7OmLKOG6wbYD3KC1l2pXAhtazeNGM1NzXELeaQIiY+lTW0ta29DmdeAuRVSZ6qDDj9B8/VgLuVsGhs06t48ZdacQCgRJQY9nKj1sDrfNgCoUY/YtVYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=gq19ZaG6; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="gq19ZaG6"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6B3F716F2;
	Mon,  6 Apr 2026 23:53:39 -0700 (PDT)
Received: from [10.164.18.83] (unknown [10.164.18.83])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A6EB73F641;
	Mon,  6 Apr 2026 23:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1775544825; bh=xmJOywtnqtcjtDrOIaLg4cNmmd9eqq3pTFEdQ1HGsDk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gq19ZaG6H/Z6QLLA361dNnxs7Rcoy1FFoxh2es/ZkM34A3iiH7Q0NWkQ9Xjf85a/V
	 Cw84yhYE9dms8niScH613/FI3ApHX6Wc/QmkYVNEjsQk3N+7VxRQ/QXYkr1v8tdtC2
	 iPBeGS35uCwhoz4oVnSyTerqZzVYnRL5bM3gmw1g=
Message-ID: <f5c9bd04-115b-4f34-bfd2-0bac756f84cb@arm.com>
Date: Tue, 7 Apr 2026 12:23:39 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/events: Replace READ_ONCE() with standard pgtable
 accessors
To: "David Hildenbrand (Arm)" <david@kernel.org>, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260227062744.2215491-1-anshuman.khandual@arm.com>
 <1267a6c0-f8e7-4708-96da-4d131b5c6069@arm.com>
 <c7688962-d10c-49e1-a434-ab7ae2c64cdb@kernel.org>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <c7688962-d10c-49e1-a434-ab7ae2c64cdb@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07/04/26 12:18 PM, David Hildenbrand (Arm) wrote:
> On 4/7/26 05:28, Anshuman Khandual wrote:
>>
>>
>> On 27/02/26 11:57 AM, Anshuman Khandual wrote:
>>> Replace raw READ_ONCE() dereferences of pgtable entries with corresponding
>>> standard page table accessors pxdp_get() in perf_get_pgtable_size(). These
>>> accessors default to READ_ONCE() on platforms that don't override them. So
>>> there is no functional change on such platforms.
>>>
>>> However arm64 platform is being extended to support 128 bit page tables via
>>> a new architecture feature i.e FEAT_D128 in which case READ_ONCE() will not
>>> provide required single copy atomic access for 128 bit page table entries.
>>> Although pxdp_get() accessors can later be overridden on arm64 platform to
>>> extend required single copy atomicity support on 128 bit entries.
>>>
>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>> Cc: David Hildenbrand <david@kernel.org>
>>> Cc: Peter Zijlstra <peterz@infradead.org>
>>> Cc: Ingo Molnar <mingo@redhat.com>
>>> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
>>> Cc: Namhyung Kim <namhyung@kernel.org>
>>> Cc: linux-perf-users@vger.kernel.org
>>> Cc: linux-mm@kvack.org
>>> Cc: linux-kernel@vger.kernel.org
>>> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>>> ---
>>> This patch applies both on v7.0-rc1 and mm-unstable.
>>>
>>> Part of the D128 series but independent. Hence could be considered on its own.
>>>
>>> https://lore.kernel.org/all/20260224051153.3150613-5-anshuman.khandual@arm.com/
>>>
>>> Collected Peter's tag from an off list conversation.
>>
>> Gentle ping. 
>>
>> Still don't see this patch in latest next-20260406. Hence just
>> wondering which tree and branch this patch is being picked up ?
> 
> It's a trivial change and the last generic code change required for you
> arm64 D128 change, right?

Right.

> 
> I would assume this to go through the tip tree, but if Peter agrees we
> could route this (mm) patch through the MM tree.
> 

Sure

