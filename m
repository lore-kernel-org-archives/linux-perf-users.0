Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B57A836DA03;
	Mon, 27 Jul 2026 11:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785151603; cv=none; b=hjt2O22UvKoqbCiva7brRV2EdEx9xJYzBd1JVkup88mHl1BHzDyOtJk3FwpiWu5/fcA59HSPKYmoEkt68Vw9PHOq3zO4PVFKI6HCI0tA9u0zqjJaXUDnnd6p6k6xS5t8SeGAlWcDEdmcOYuC8Yz2KyROAVX9gu7AJhT+15YF7PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785151603; c=relaxed/simple;
	bh=1kO15h5bXorZeEhEqIT2af5pMsnNRVI+OSavPTxuPv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VaOr5oVPU3udtRr+lMNe7GACKE5i+fCLekmdh5b+RZtw7jtoICmRM1Ay6JKd2nDIRcQA+RQKJ03osQwKOsL2/MQ/1OXjAhoif30YLnY0B4/JOmkHmsM4+00a5D/Q9NI4ePj9vpZHJWY2SweDLcbb8iC5ZIsWuLv8gkbt2Nb083M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p200300f6af4fc500ebaed89d31e83d28.dip0.t-ipconnect.de [IPv6:2003:f6:af4f:c500:ebae:d89d:31e8:3d28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 1F1972409BD;
	Mon, 27 Jul 2026 13:19:44 +0200 (CEST)
Date: Mon, 27 Jul 2026 13:19:42 +0200
From: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	peterz@infradead.org, mingo@redhat.com, acme@kernel.org, namhyung@kernel.org, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	irogers@google.com, adrian.hunter@intel.com, james.clark@linaro.org, x86@kernel.org, 
	dave.hansen@linux.intel.com, tglx@kernel.org, bp@alien8.de, hpa@zytor.com, 
	iommu@lists.linux.dev, suravee.suthikulpanit@amd.com, sandipan.das@amd.com
Subject: Re: [PATCH] x86/events/amd/iommu: Fix cpumask of IOMMU events
Message-ID: <amc-s_W_TjLYnbw0@8bytes.org>
References: <20260517114026.6817-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260517114026.6817-1-vasant.hegde@amd.com>

On Sun, May 17, 2026 at 11:40:26AM +0000, Vasant Hegde wrote:
> IOMMU performance counters are accessed via MMIO space. Currently IOMMU
> PMUs uses a single global cpumask (iommu_cpumask) shared across all AMD
> IOMMU PMU instances. This prevents collecting per-socket numbers
> (ex: perf stat --per-socket).
> 
> Fix this by adjusting cpumask based on IOMMUs NUMA node.
> 
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  arch/x86/events/amd/iommu.c | 29 +++++++++++++++++++++++------
>  drivers/iommu/amd/init.c    |  7 +++++++
>  include/linux/amd-iommu.h   |  1 +
>  3 files changed, 31 insertions(+), 6 deletions(-)

Acked-by: Joerg Roedel <joerg.roedel@amd.com>

