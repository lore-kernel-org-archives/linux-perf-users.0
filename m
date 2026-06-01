Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A9F3D7D8F;
	Mon,  1 Jun 2026 15:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780326542; cv=none; b=XU6avB0+hAfcPbyvX2dWaj3D47lag9Bq6NlenItrHrq6Q8xPE8nN6R8fSEgTFmm6aRbzJHxjxfMU2/2erXuv2fcjZo8gIbeh2orHyh1oBYlgcJeJXUy6jbLvxBzPWg1+8m4S/CM9Vj4A8p/pI6kH6WRS+jr/baJ0hJEOTYma290=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780326542; c=relaxed/simple;
	bh=JM9gqvy0Ins5kQUQqIjFm8mHunSgB8xApWpZ2BBheFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YwULAmiYsTEepWFilP+JSKZfHyjmTlPv7c8Q4AbSDsgmR9jnHndKjEsQ3jNVnJeM1LZWa19vJ8p+1IUpA8PbnKw7ASULy1Toe81eKw49hbgkOsn6u+7LrerV06Pkk0sHLB6OnbAX7lCcQv8wxdjwt4C6Gl9dREf2Ah+HnC82mDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gxlLFTJH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gxlLFTJH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 531FD1F00893;
	Mon,  1 Jun 2026 15:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780326541;
	bh=NCS5TripKyJvnwhntJ5SfguNzHIdaleCIVbTVkLmcPg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gxlLFTJHnxQAOITTp4L9AoVMaMINdEEof984rJgzpOC2OWTv3ktvPhqGP/ahqhrnT
	 b3GrMWvE8/YcMFifkVP9ES9GGot0+tc2HN9wfux4/EgNVzuvvMYrVGFCMr4oo3guXP
	 mUeMxE3iJPzItvx/49GNGMuWJkNZkgxDGy6l2oKrDgHSMNH3/CiRW7HupO00JTKsGh
	 OVOsetMaBi399g4N1ViMQrh8bSrmB5RnqyyyX3jTtX1rUm5lOmg24X3wHLMxd1HYWG
	 vmuHJDwfRtHKhx2RC32LlYFaQHwgHDsHC+xR6jxm1lpzBMbShmdsB3pKdfV8tkT4dp
	 EpFNENMEMRwrA==
Date: Mon, 1 Jun 2026 16:08:56 +0100
From: Will Deacon <will@kernel.org>
To: Saurav Sachidanand <sauravsc@amazon.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Besar Wicaksono <bwicaksono@nvidia.com>,
	Ilkka Koskinen <ilkka@os.amperecomputing.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	aghayev@amazon.com, juew@amazon.com
Subject: Re: [PATCH 2/3] perf/arm_cspmu: nvidia: handle empty resource list
 in PCIE-TGT init
Message-ID: <ah2giNU4ZYN45emt@willie-the-truck>
References: <20260511210905.91917-1-sauravsc@amazon.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511210905.91917-1-sauravsc@amazon.com>

On Mon, May 11, 2026 at 09:09:04PM +0000, Saurav Sachidanand wrote:
> When acpi_dev_get_memory_resources() returns success but the resource
> list is empty (rentry is NULL), addr_filter_reg remains NULL from
> devm_kzalloc. Since IS_ERR(NULL) is false, the function proceeds
> without error and later dereferences the NULL pointer in
> pcie_tgt_pmu_config_addr_filter().
> 
> Set addr_filter_reg to ERR_PTR(-ENODEV) when the resource list is
> empty so the existing IS_ERR check catches it.
> 
> Fixes: 3dd73022306b ("perf/arm_cspmu: nvidia: Add Tegra410 PCIE-TGT PMU")
> Signed-off-by: Saurav Sachidanand <sauravsc@amazon.com>
> ---
>  drivers/perf/arm_cspmu/nvidia_cspmu.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)

What happened to patch 1/3? I don't have it in my inbox and it seems to
be missing from the archive as well:

https://lore.kernel.org/all/20260511210905.91917-2-sauravsc@amazon.com/

Please can you post a v2, with all three patches and the R-b tags from
Besar?

Thanks,

Will
