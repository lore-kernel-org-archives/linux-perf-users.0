Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C35002701AA
	for <linux-perf-users@vger.kernel.org>; Thu, 24 Apr 2025 12:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745498933; cv=none; b=j+i64JyoIH2FEAQabFBqx0nC1O5eJL5gmAVqEHC05K5RTRyPVTXImeSISYNjpYvroYSwu3+yhFOed4rnvpDpevg7dh6RUxNxIW1A9qwln9Ndg63vZUUypW/NzkUBIrdx+lMfT0tp204RNEky0d1gv1F6XA0Svrwevtk+1oCB0WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745498933; c=relaxed/simple;
	bh=jqFUABVQ7hPVUEcrKccPVtQEmdaEbdTh5Ikx1G1/Uzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W65kSECNTqfaohbXaGXvrDWXdbiTZFW1K/K8HZ34bJ44IVtmv1dRXswxoJA1bbWK8nphb/QHHSOL4Ryv/qc/x3Z9+7aSS2A0+x6Yv/GD/WxmL1UWXrrFirh/5YwgxQsVcB5rK6EQKeoNl4k5kaJWWM0pWr/gu5fN4DBuvRf1zO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 123541063;
	Thu, 24 Apr 2025 05:48:46 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AAD703F59E;
	Thu, 24 Apr 2025 05:48:50 -0700 (PDT)
Date: Thu, 24 Apr 2025 13:48:48 +0100
From: Leo Yan <leo.yan@arm.com>
To: Yicong Yang <yangyicong@huawei.com>
Cc: yangyicong@hisilicon.com, James Clark <james.clark@linaro.org>,
	jonathan.cameron@huawei.com, hejunhao3@huawei.com,
	linuxarm@huawei.com, wangyushan12@huawei.com, caijingtao@huawei.com,
	xueshan2@huawei.com, prime.zeng@hisilicon.com, acme@kernel.org,
	namhyung@kernel.org, catalin.marinas@arm.com, will@kernel.org,
	peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
	jolsa@kernel.org, john.g.garry@oracle.com, leo.yan@linux.dev,
	irogers@google.com, linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf arm-spe: Add support for SPE Data Source packet on
 HiSilicon HIP12
Message-ID: <20250424124848.GA551819@e132581.arm.com>
References: <20250408122809.37884-1-yangyicong@huawei.com>
 <89741897-6c8f-4b75-8ec3-675111ea60a1@linaro.org>
 <20250422102952.GD28953@e132581.arm.com>
 <ccb8ce65-8241-0670-25c8-f8245fbc5e22@huawei.com>
 <20250422132006.GG28953@e132581.arm.com>
 <0098923f-0982-8d08-3c4f-810170ca0b87@huawei.com>
 <2fa27176-f820-a03f-033e-7da811643cff@huawei.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2fa27176-f820-a03f-033e-7da811643cff@huawei.com>

Hi Yicong,

On Thu, Apr 24, 2025 at 07:57:39PM +0800, Yicong Yang wrote:

[...]

> >> If so, you might need to revise the cache levels for:
> >>
> >>   ARM_SPE_HISI_HIP_PEER_CPU
> >>   ARM_SPE_HISI_HIP_PEER_CPU_HITM
> >>
> >> IIUC, cluster CPUs share L3 cache, and every CPU in a cluster has
> >> L1/L2 cache, for PEER_CPU cases, the memory level should be L2.
> >>
> > 
> > confirmed with our hardware people, should be L2 for these two data sources.
> > I misunderstood here, thanks for pointing it out.
> 
> I recalled why the handling is like this. considering 2 threads have potential false
> sharing issues which are running on core0 thread0 and core 1 thread 0 in the same
> cluster, we'll have some ARM_SPE_HISI_HIP_PEER_CPU_HITM samples to indicate the
> cacheline contention. If the cache level is L2 then we cannot observe this by
> `perf c2c report -d tot`, since L2 is not counted for HITM.
> 
> does it make sense to have below change to account L2 hitm for lcl_hitm? just like
> we account L2 peer snoop for lcl_peer.

Yes.  The change below makes sense to me.

> diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
> index 884d9aebce91..a384a866a562 100644
> --- a/tools/perf/util/mem-events.c
> +++ b/tools/perf/util/mem-events.c
> @@ -680,7 +680,10 @@ do {                               \
>                         if (lvl & P(LVL, LFB)) stats->ld_fbhit++;
>                         if (lvl & P(LVL, L1 )) stats->ld_l1hit++;
>                         if (lvl & P(LVL, L2)) {
> -                               stats->ld_l2hit++;
> +                               if (snoop & P(SNOOP, HITM))
> +                                       HITM_INC(lcl_hitm);
> +                               else
> +                                       stats->ld_l2hit++;
> 
>                                 if (snoopx & P(SNOOPX, PEER))
>                                         PEER_INC(lcl_peer);
