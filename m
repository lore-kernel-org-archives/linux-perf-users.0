Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A15B14BFA2
	for <linux-perf-users@vger.kernel.org>; Tue, 22 Apr 2025 13:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745328014; cv=none; b=BozLEtH2eWr8SiQLl2xZo/C1zjzReY1RefTF9DDCtnrt9YZ3lrP2JV/uHiacS+SDBHLPUgKUhpnpgEK219bxZ90IpTdK5KFDTI3/yFtZu63DZvr9guhWIZa2sMzKou9oF5knNEfCItH7sKkRd/64VjgE49+yPNKwWTmy2dZ9Wl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745328014; c=relaxed/simple;
	bh=e8D4eoYG3WKHvVo37wV4+d2yhkxaQ/Lxcf2b2F1PKPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pZOq200wdT7agFCos+FtKAivh3Zbjfjwaxw93HHzd2661b956Nrjq9QPcRhnhAU3DBLswbpPXNmZXjiLjN+SlDa4rDB2l2bcfqTErO3ZoDLPlIUoMkbIRXhOxTBprwOVCjiW+J5brNfusNMR3mQHM6ulpuiwIqoSdwdFcWRDFmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2BDC1152B;
	Tue, 22 Apr 2025 06:20:07 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0D4733F5A1;
	Tue, 22 Apr 2025 06:20:11 -0700 (PDT)
Date: Tue, 22 Apr 2025 14:20:06 +0100
From: Leo Yan <leo.yan@arm.com>
To: Yicong Yang <yangyicong@huawei.com>
Cc: James Clark <james.clark@linaro.org>, yangyicong@hisilicon.com,
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
Message-ID: <20250422132006.GG28953@e132581.arm.com>
References: <20250408122809.37884-1-yangyicong@huawei.com>
 <89741897-6c8f-4b75-8ec3-675111ea60a1@linaro.org>
 <20250422102952.GD28953@e132581.arm.com>
 <ccb8ce65-8241-0670-25c8-f8245fbc5e22@huawei.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ccb8ce65-8241-0670-25c8-f8245fbc5e22@huawei.com>

On Tue, Apr 22, 2025 at 08:31:43PM +0800, Yicong Yang wrote:

[...]

> >>> +	case ARM_SPE_HISI_HIP_PEER_CLUSTER:
> >>> +		data_src->mem_lvl = PERF_MEM_LVL_REM_CCE1 | PERF_MEM_LVL_HIT;
> >>> +		data_src->mem_lvl_num = PERF_MEM_LVLNUM_L3;
> > 
> > Seems to me, a CPU has L3 cache, would the cluster has a higher level's
> > cache?
> 
> In my case, the cluster CPUs share the L3 cache and there's several clusters.
> L3's the highest level cache in the system.

If so, you might need to revise the cache levels for:

  ARM_SPE_HISI_HIP_PEER_CPU
  ARM_SPE_HISI_HIP_PEER_CPU_HITM

IIUC, cluster CPUs share L3 cache, and every CPU in a cluster has
L1/L2 cache, for PEER_CPU cases, the memory level should be L2.

[...]

> >>> +	case ARM_SPE_HISI_HIP_REMOTE_SOCKET:
> >>> +		data_src->mem_lvl = PERF_MEM_LVL_REM_CCE2;
> >>> +		data_src->mem_lvl_num = PERF_MEM_LVLNUM_ANY_CACHE;
> >>> +		data_src->mem_remote = PERF_MEM_REMOTE_REMOTE;
> >>> +		data_src->mem_snoopx = PERF_MEM_SNOOPX_PEER;
> >>
> >> Hi Yicong,
> >>
> >> Is the mem_snoop setting missing from this one?
> > 
> > The field 'mem_snoopx' is an extension to the field 'mem_snoop'.
> > 
> > If the field 'mem_snoopx' is set, it is no need to set 'mem_snoop'.
> > 
> 
> they should not be mutal exclusive. mem_snoopx provides the information where
> the cacheline comes from while mem_snoop provides the status of the cacheline.
> if hardware supports we can gather both information from the data source, like
> above for ARM_SPE_HISI_HIP_PEER_CLUSTER_HITM.

My understanding is the PERF_MEM_SNOOPX_PEER flag was extended for
support Arm SPE.  Other snoop flags were original from x86 arch.

I agreed that in some cases above, both the flags PERF_MEM_SNOOPX_PEER
and PERF_MEM_SNOOP_HITM can be set together, you can parse cache sharing
with different --display options:

  perf c2c report --display tot    => based on HITM flags
  perf c2c report --display peer   => based on SNOOPX_PEER flag

> for other cases if there's mem_snoopx information I think mem_snoop can be dropped,
> this won't make differeces. Checked c2c_decode_stats(), only PERF_MEM_SNOOP_HIT and
> PERF_MEM_SNOOP_HITM is useful when summarizing c2c statistics.

It is about how to present accurate results.

E.g., for REMOTE_SOCKET type, it is hard to say the data from remote
DRAM or any level's cache.  Since more hardware details are absent, this
is why I suggested not to set 'mem_snoop' for REMOTE_SOCKET.

Thanks,
Leo
