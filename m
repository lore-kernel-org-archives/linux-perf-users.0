Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04AD1FBEBC;
	Tue,  7 Apr 2026 06:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775544507; cv=none; b=ACWsc/HGfC5phIOFYnXRBYTf9Uh49kDUgbeE2OiVXw0fihZO9M/vYdrx5VXOD70bcaArvbav2n6GeUhEQ/EsXswVZ3MML1/sJ15vQX5EB0WEpEO6nl+jZam24MmiSTEDmorr3kX9FTXDATD1wa7LK/cUQdW/oPQp6o1fEDRLh68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775544507; c=relaxed/simple;
	bh=Ea/dgNWMCtrFcxVc9JR8+cREFl164xqobHdGsxImfvg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CUYJLYE0chho1KgCw2I/wwXrjotAS/yz1nfeOikHFQmXs1Ncj7SR7B6n8ArFHjHnOiBbS1kuJbOX5M9SWost4JS6QDq2KAbiqgvLsDYj/I2rdEFgsE8bGMoGxH5efoe7Ki9p1Eq2lWXOiwwG2DXr2BAa3bRFefU/De4hordLEAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OwWWkCfm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OwWWkCfm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D9A1C116C6;
	Tue,  7 Apr 2026 06:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775544506;
	bh=Ea/dgNWMCtrFcxVc9JR8+cREFl164xqobHdGsxImfvg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OwWWkCfmwSJazt6Bl6SPLtj1PCppUfp38Lf0p9XHHEmjjh+JRHXNZTlPpsgc5ZrT6
	 HF+hnGowGlh0El7GD1dmDRBlKTxRvoTUeWng9Rq3yL8XQuBOeoIU6iWV+mwHe1Vc1G
	 s6bsMuyDSlGRZgPHPI8oVfsOJm9b60+dLlml5UJlLxfA8cZkXEpj//0bws9rzxFROB
	 Q+kXxxzJWzLIrR9OWXap6yZEKiQqz5V05GJ6xUCl9Ew6kfI3c3h/A/tTZgC6DIxOEk
	 HYaMxGcUDSJXHfSqy7m/5WebBws7TkYXq5NePlRWkGnxGMSTQGUOFGMm3/nR7mJ8ar
	 ROnSXMmw13vqA==
Message-ID: <c7688962-d10c-49e1-a434-ab7ae2c64cdb@kernel.org>
Date: Tue, 7 Apr 2026 08:48:22 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/events: Replace READ_ONCE() with standard pgtable
 accessors
To: Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260227062744.2215491-1-anshuman.khandual@arm.com>
 <1267a6c0-f8e7-4708-96da-4d131b5c6069@arm.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <1267a6c0-f8e7-4708-96da-4d131b5c6069@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/7/26 05:28, Anshuman Khandual wrote:
> 
> 
> On 27/02/26 11:57 AM, Anshuman Khandual wrote:
>> Replace raw READ_ONCE() dereferences of pgtable entries with corresponding
>> standard page table accessors pxdp_get() in perf_get_pgtable_size(). These
>> accessors default to READ_ONCE() on platforms that don't override them. So
>> there is no functional change on such platforms.
>>
>> However arm64 platform is being extended to support 128 bit page tables via
>> a new architecture feature i.e FEAT_D128 in which case READ_ONCE() will not
>> provide required single copy atomic access for 128 bit page table entries.
>> Although pxdp_get() accessors can later be overridden on arm64 platform to
>> extend required single copy atomicity support on 128 bit entries.
>>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: David Hildenbrand <david@kernel.org>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
>> Cc: Namhyung Kim <namhyung@kernel.org>
>> Cc: linux-perf-users@vger.kernel.org
>> Cc: linux-mm@kvack.org
>> Cc: linux-kernel@vger.kernel.org
>> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>> This patch applies both on v7.0-rc1 and mm-unstable.
>>
>> Part of the D128 series but independent. Hence could be considered on its own.
>>
>> https://lore.kernel.org/all/20260224051153.3150613-5-anshuman.khandual@arm.com/
>>
>> Collected Peter's tag from an off list conversation.
> 
> Gentle ping. 
> 
> Still don't see this patch in latest next-20260406. Hence just
> wondering which tree and branch this patch is being picked up ?

It's a trivial change and the last generic code change required for you
arm64 D128 change, right?

I would assume this to go through the tip tree, but if Peter agrees we
could route this (mm) patch through the MM tree.

-- 
Cheers,

David
