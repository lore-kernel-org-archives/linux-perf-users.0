Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78ABC3BB9E5;
	Wed,  8 Apr 2026 10:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775645937; cv=none; b=aaSimOBORG8LUwV3zsqsjvOVhmwe2+deXmDXvDWmwZDiSPaS29EuGUhmodgXVPeNmXAM8BqxgvZgG0PudvSKbHDKMCGuBHmVWNOsOlT+ARxz+zMAgaYgwxCERYHLsx8bMvFPvOe2VPVzT2mNxW4CuLELF9vnYhItl12QNE4dJHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775645937; c=relaxed/simple;
	bh=rvCB0mtFCTChcch/FM64LYIf0vr0IZ0WwJBCN05cnQg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bGK3zsglDxRo4s7lzcb7gqO2B0jBeUrGuINZtSrKa76IAW0Hm6vZVQvWK03UpjUrSkx3HzcPB2nPHW/9Zcb0SB9quvTaOUFcD8DJ5rGXlnqG+MTmUiendzmcvV+Rl3fWPZ3QqODLZtaPKbEtXHo5A50frWxc5/JUF/uamIdw0u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ZSPo+kwj; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ZSPo+kwj"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0A7303161;
	Wed,  8 Apr 2026 03:58:49 -0700 (PDT)
Received: from [10.163.180.198] (unknown [10.163.180.198])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F23E23F632;
	Wed,  8 Apr 2026 03:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1775645934; bh=rvCB0mtFCTChcch/FM64LYIf0vr0IZ0WwJBCN05cnQg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZSPo+kwjikI+iRW4adeq1Vx/UxwAGFrfNhig45c90krMMeJUQpomGNau9pTkioJg3
	 mzGBxrK+v+q1P5KG9fHhUFQbVCAaYZnRtbR6gS4JFEchs1JRDpB3ykj9MtEMsAjDi7
	 VnrqcD848OeDpenFRsURVEewmf1UU4/17K4SfAjM=
Message-ID: <bcf784d9-5350-4b43-a827-a1cead862cad@arm.com>
Date: Wed, 8 Apr 2026 16:28:48 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/events: Replace READ_ONCE() with standard pgtable
 accessors
To: Peter Zijlstra <peterz@infradead.org>,
 "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260227062744.2215491-1-anshuman.khandual@arm.com>
 <1267a6c0-f8e7-4708-96da-4d131b5c6069@arm.com>
 <c7688962-d10c-49e1-a434-ab7ae2c64cdb@kernel.org>
 <20260407071820.GA3738010@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20260407071820.GA3738010@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 07/04/26 12:48 PM, Peter Zijlstra wrote:
> On Tue, Apr 07, 2026 at 08:48:22AM +0200, David Hildenbrand (Arm) wrote:
>> On 4/7/26 05:28, Anshuman Khandual wrote:
>>>
>>>
>>> On 27/02/26 11:57 AM, Anshuman Khandual wrote:
>>>> Replace raw READ_ONCE() dereferences of pgtable entries with corresponding
>>>> standard page table accessors pxdp_get() in perf_get_pgtable_size(). These
>>>> accessors default to READ_ONCE() on platforms that don't override them. So
>>>> there is no functional change on such platforms.
>>>>
>>>> However arm64 platform is being extended to support 128 bit page tables via
>>>> a new architecture feature i.e FEAT_D128 in which case READ_ONCE() will not
>>>> provide required single copy atomic access for 128 bit page table entries.
>>>> Although pxdp_get() accessors can later be overridden on arm64 platform to
>>>> extend required single copy atomicity support on 128 bit entries.
>>>>
>>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>>> Cc: David Hildenbrand <david@kernel.org>
>>>> Cc: Peter Zijlstra <peterz@infradead.org>
>>>> Cc: Ingo Molnar <mingo@redhat.com>
>>>> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
>>>> Cc: Namhyung Kim <namhyung@kernel.org>
>>>> Cc: linux-perf-users@vger.kernel.org
>>>> Cc: linux-mm@kvack.org
>>>> Cc: linux-kernel@vger.kernel.org
>>>> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>>>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>>>> ---
>>>> This patch applies both on v7.0-rc1 and mm-unstable.
>>>>
>>>> Part of the D128 series but independent. Hence could be considered on its own.
>>>>
>>>> https://lore.kernel.org/all/20260224051153.3150613-5-anshuman.khandual@arm.com/
>>>>
>>>> Collected Peter's tag from an off list conversation.
>>>
>>> Gentle ping. 
>>>
>>> Still don't see this patch in latest next-20260406. Hence just
>>> wondering which tree and branch this patch is being picked up ?
>>
>> It's a trivial change and the last generic code change required for you
>> arm64 D128 change, right?
>>
>> I would assume this to go through the tip tree, but if Peter agrees we
>> could route this (mm) patch through the MM tree.
> 
> Right, I thought this was part of a larger series and figured it would
> ride along with whatever other patches.
> 
> If you still want me to pick this up, I can, just state clearly where
> this ought to go.

It would be great if you could pick this up. Thanks !

