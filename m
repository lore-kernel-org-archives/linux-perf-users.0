Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284E22F12CB;
	Wed,  7 Jan 2026 21:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767823053; cv=none; b=MHaplKpPJfQtGW/LVS9wwiMf4HR774WLP4F5cV41vmbG3wHswzIOqb4e6ytJ/OKiQhedd4vcbXYCoSrG5I9/uj7JgmLy7DbwpWwfFZR3QMaSKrNPWq97xoVLRiqozbruGT+p+tJ0/2vQ05d10snWB4FY13hsaMI1NnWx8rj//S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767823053; c=relaxed/simple;
	bh=DMHqqj1KA0UKWPMpyqAGo7GxPeavQmrDBNQuOKzRzyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gyI2E1/kkIUzCqvXcjjc/l2YJc30MareuxGC4cPKkBSGI02OQLGzKpOquuS4zklbJTBSYTEfEtGc25ZMoGEkMpNEPlC5DQLVuBm9y3Bq6600VIKCIVuh+v0gPFY/eC6XrUQ+YX0405GSSfbw5fUSJZ62zX+Y76cpGuAwDUJEA9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NSwd1fJx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NSwd1fJx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA4AEC4CEF1;
	Wed,  7 Jan 2026 21:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767823052;
	bh=DMHqqj1KA0UKWPMpyqAGo7GxPeavQmrDBNQuOKzRzyc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NSwd1fJxMHCtfmER/yTQlVdu91vkfgOhciYiN5sFTnojc61mR6mKtGpxrVrR6WUbT
	 8r5mjw5qvTVRLnxQ0pz+SXCrpmaXiewYwUCFXzh68mCh/RkN82gECJzpIi57pkA55t
	 pumo6j1VrI4t6yd3C103IaV/277rUaQzjq+iii17GwDzaPX92bTZgPAb1gy5Y3qMPF
	 7pWbhOYDigxKF1UDS2w6OxPrnEXNZqGl9KNnMr2Mc2qPiatE1W4HK6nJ1z+eEvGEvg
	 PvfsmW0udvQxsJSqyHYCvB76NRLBnPPhWlvSBrsBsja1N45cK1B/031ynPCZEsR3s1
	 W/5Tax56uXLtQ==
Date: Wed, 7 Jan 2026 21:57:24 +0000
From: Will Deacon <will@kernel.org>
To: Yunhui Cui <cuiyunhui@bytedance.com>
Cc: akpm@linux-foundation.org, alex@ghiti.fr, anup@brainfault.org,
	aou@eecs.berkeley.edu, atish.patra@linux.dev,
	catalin.marinas@arm.com, dianders@chromium.org,
	johannes@sipsolutions.net, lihuafei1@huawei.com,
	mark.rutland@arm.com, masahiroy@kernel.org, maz@kernel.org,
	mingo@kernel.org, nicolas.schier@linux.dev, palmer@dabbelt.com,
	paul.walmsley@sifive.com, suzuki.poulose@arm.com,
	thorsten.blum@linux.dev, wangjinchao600@gmail.com,
	yangyicong@hisilicon.com, zhanjie9@hisilicon.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v6 1/2] watchdog: move arm64 watchdog_hld into common code
Message-ID: <aV7WxLVlMzD910Dg@willie-the-truck>
References: <20251114033243.76509-1-cuiyunhui@bytedance.com>
 <20251114033243.76509-2-cuiyunhui@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251114033243.76509-2-cuiyunhui@bytedance.com>

On Fri, Nov 14, 2025 at 11:32:42AM +0800, Yunhui Cui wrote:
> Move the contents of arch/arm64/watchdog_hld.c to kernel/watchdog_perf.c
> to create a generic implementation that can be reused by other arch,
> such as RISC-V.
> 
> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> ---
>  arch/arm64/Kconfig               |  1 +
>  arch/arm64/kernel/Makefile       |  1 -
>  arch/arm64/kernel/watchdog_hld.c | 94 --------------------------------
>  drivers/perf/arm_pmu.c           | 10 +++-
>  include/linux/perf/arm_pmu.h     |  2 -
>  kernel/watchdog_perf.c           | 83 ++++++++++++++++++++++++++++
>  lib/Kconfig.debug                |  8 +++
>  7 files changed, 101 insertions(+), 98 deletions(-)
>  delete mode 100644 arch/arm64/kernel/watchdog_hld.c

Acked-by: Will Deacon <will@kernel.org>

Will
