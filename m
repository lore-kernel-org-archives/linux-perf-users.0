Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F05151355F
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 15:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789572454; cv=none; b=eF1nCttZEQHxln2FNwK+UBp0dyinClGyJH8CHMqIz2tykqlrNqmAhDbb85gxqdjguRvN+zWj7uYdB5wjU9uPuQOQNmfz2GDT7v/qf9jCWfcilYNTaD+yps64BYwlVEi+O/DP77f5O+u1Dw2awFc6dqCFoqkXMG/xiD6orW0m4lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789572454; c=relaxed/simple;
	bh=/8VW9Dvo83Z09jxBj+TCP4E44skMYFi0oXPi1csETxg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BX/M3ZPhgghXvBMRnxXpuI8aoKWj/+6B1XewaIhd/O4Hc1Wqm6jT2mQVaXGCzZ/uRE6yS+xWs+J2Wo44XhUFE/POQzQO2Jksj+FARuvSfBtHqLgqOKykuANkZYCttgMkEHchE6VURGAy3Ti9jCBM9GKIbKPSdiXAx8f9lIzABDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=fHVRJNkU; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="fHVRJNkU"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D3335176A;
	Wed, 16 Sep 2026 08:27:24 -0700 (PDT)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9531F3F86F;
	Wed, 16 Sep 2026 08:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789572448; bh=/8VW9Dvo83Z09jxBj+TCP4E44skMYFi0oXPi1csETxg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fHVRJNkUub0vnRQHEeeucLmufQDlnCzbbvwgUI6h2FazgMh/QXc40U/xAGdmOy6X4
	 A4JemSKBr9Zez8hCtP8GaEenU6az1OKPCAwAM7DWrMYbWaioxLmByccOQ6fVD40mwG
	 0VhWBm1lb6s/F5eDR2GFZnd38q34ntUbhYHUNpvo=
Message-ID: <aaafc5a8-e64a-4091-b615-257e48c34781@arm.com>
Date: Wed, 16 Sep 2026 16:27:20 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] perf/arm-cmn: Fix multi-filter encoding
To: Leo Yan <leo.yan@arm.com>
Cc: will@kernel.org, mark.rutland@arm.com, ilkka@os.amperecomputing.com,
 linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <ec590cd4cc61b54d6ad3b306b69777ad7729c9d6.1789475062.git.robin.murphy@arm.com>
 <20260916093146.GG200420@e132581.arm.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260916093146.GG200420@e132581.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16/09/2026 10:31 am, Leo Yan wrote:
> On Tue, Sep 15, 2026 at 01:24:22PM +0100, Robin Murphy wrote:
>> The current special-case for EVICT_STATE_SEL filtering effectively
>> assigns the "filter" and "filter2" controls in the opposite order from
>> how the CMN S3 r2 TRM states "Filtering is programmed in pmu_hbt_lbt_sel
>> and pmu_evict_state_sel". On reflection, not only does this seem
>> unnecessarily non-obvious to users, but it's also likely to be a problem
>> for scaling to a full multi-filter abstraction in future. There is a
>> logical order to filters based on their bitfield positions in the
>> pmu_event_sel register, which the TRM descriptions allude to, and the
>> cmn_filter_select enum already (almost) follows, so let's fix the UABI
>> to follow suit while it's still unreleased.
>>
>> Fixes: 09178f536bb9 ("perf/arm-cmn: Plumb in new filter types")
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> 
> It's hard to say how useful my review is, but I went through the patch
> and also asked AI to explain the rationale. It makes sense to me:
> 
> Reviewed-by: Leo Yan <leo.yan@arm.com>
> 
> Seems we could implement a generic way to navigate filters based on
> the hardware bitfield ordering, e.g. filter_next(sel) and
> filter_prev(sel). This can be deferred until we have more combined
> filters.

Yup, that's the direction this was always heading - in the (near-ish) 
future we definitely are going to have to support different events 
having overlapping combinations of multiple filters, and even more cases 
of one event having different filters per CMN model. Thus one option I 
realised I'd like to keep open, in case arrays get too clunky, is to 
encode cmn_filter_select values in a bitmap, wherein a mapping of bits 
to CMN_EVENT_FILTER*() fields could always be implied based on this 
consistent ordering.

Thanks,
Robin.
