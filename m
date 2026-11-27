Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795814058;
	b=vLzcVRwnAtPX5IEctbzK02GFc8XAK6y8yw2w16Z4Y18lkAUqIYa3++loj7O/AtsBLCrQ
	 UZpVSUGtEaOztxWVW0CRFRMgIfrWVJPAqp+u0a2aBFwdVHfxyrIix65u9ETL56wi4WliP
	 kKHTP/MphUq7PR/d3Mq2aSd+WYGbJ/kAUkygaf/6r4imEJ9t6uLKMVYyZLo4pz0LyVErT
	 BpDJBkrs15pLFveUIh7j64ZdjXPuM/hrODd/gX8yvfb9Olb0DUNx3CVDk9CGQfkBKb7eG
	 uYxf10+ldDFUNeOy8AGw9FO0Whn654df2L0j2CH8J8ga8ne6l/0kK1j1Sx6dA0sThtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795814058;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=fZMajTFIhsk6u/dtLRxzX7CEIFWa9wuGr8CAmQQaGNw=;
	b=uhtyTe1Wp5a6IUKu11iAIVOaRvBmOokmTylBS2kb1rNxXIZ8rIxCNkMqeHyoB/eKu/d3
	 OllHP9aBABxrnIDprf5hwoOdmw+KOju/h02wRZwJMOE+MP4DaKy2iSZ+ba6Bg6GNt/bpb
	 9jdeabLN22v9bNrmkaHwFio5gsPChJ8V17nKO/OloYeZOgXV+DxPuE2QZyUTv0q1+QD2j
	 b3QLkw/yeVxnkrCixtkDbmdDkW6P3FcYBfzx8kWcc1bUHk7MMYgEGC2J9TOZd7gFFzsph
	 3brkybHj7mGNF0h1Ti/FMpPKRLX62grazW8jv5KawRJldkwn8ePOmVL+QAWM7E22z8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=JBAGojIu;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 195DB606A31C;
	Fri, 27 Nov 2026 21:14:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 195DB606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=JBAGojIu
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EFFE01575;
	Fri, 27 Nov 2026 13:14:12 -0800 (PST)
Received: from localhost (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 69F803F632;
	Fri, 27 Nov 2026 13:14:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795814055; bh=BvU5Ac6daDVpu8nVwZeldQF9W8KjlMmjXd6m7m9X1Ao=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JBAGojIux5rPsLXNCqTettd2ISRAQC7rD3tYF0Dvejdu3fznJ9SKFdDgWsjgEOLm1
	 O/wxUNyTne+/0q80rgMwPXbgKa/1kjFG+wVKnranHikRG+FtpGO6alIKwyE7kURAM0
	 SlAg2ZzKd4H8tiPTpD3barAL+1wZ4hdwygFK80TQ=
Date: Fri, 27 Nov 2026 21:14:13 +0000
From: Leo Yan <leo.yan@arm.com>
To: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@arm.com>,
	James Clark <james.clark@linaro.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	coresight@lists.linaro.org
Subject: Re: [PATCH 1/2] perf: arm_spe: Order padding before publishing AUX
 head
Message-ID: <20261127211413.GH861809@e132581.arm.com>
References: <20261015-add_barriers_for_perf_aux_output_skip-v1-0-5847d0578859@arm.com>
 <20261015-add_barriers_for_perf_aux_output_skip-v1-1-5847d0578859@arm.com>
 <awnPG6QADpRAgEzx@willie-the-truck>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <awnPG6QADpRAgEzx@willie-the-truck>

On Fri, Nov 27, 2026 at 06:42:35PM +0000, Will Deacon wrote:

> > @@ -487,8 +487,11 @@ static void arm_spe_pmu_pad_buf(struct perf_output_handle *handle, int len)
> >  	u64 head = PERF_IDX2OFF(handle->head, buf);
> >  
> >  	memset(buf->base + head, ARM_SPE_BUF_PAD_BYTE, len);
> > -	if (!buf->snapshot)
> > +	if (!buf->snapshot) {
> > +		/* Order the padding stores before publishing the new aux_head. */
> > +		smp_wmb();
> >  		perf_aux_output_skip(handle, len);
> > +	}
> 
> This looks correct to me, but I wonder if it should be handled by
> perf_aux_output_skip() instead? arm_spe_pmu_pad_buf() is called from a
> bunch of places in the driver, including in conjunction with
> perf_aux_output_end(), which looks like it already has the necessary
> memory barrier. So doing it here seems weird inconsistent to me.

As I mentioned in the cover letter, the choice of barrier depends on the
CPU memory model and the trace hardware. Perf deliberately leaves that
choice to the AUX driver [1].

SPE driver implicitly relies on the dsb(nsh) in
arm_spe_pmu_disable_and_drain_local() to make trace writes visible
before calling perf_aux_output_end(). I kept the barrier in the driver
for perf_aux_output_skip() to follow the same convention.

Thanks,
Leo

[1] https://lore.kernel.org/all/YLUFMzxin1PpgIdZ@hirez.programming.kicks-ass.net/
