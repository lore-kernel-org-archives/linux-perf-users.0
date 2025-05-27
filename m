Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C33F20C038
	for <linux-perf-users@vger.kernel.org>; Tue, 27 May 2025 20:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748379272; cv=none; b=ghiNU9hTKEvC0/1DZMEsoAIJe9LSnNmX/VaUYR+M1nyWPcGbq//+5pRBAUzRAUQopOkbAcLPNtSdeBJAyz3HXuikwUzvV5ybNJq5Uh5+0rIm71E07Q1DRU0t4nZ6kl6VUtJBN4Ab0sGY57JxKF7Q2hSx5XwVO2PuTqTZNEy/OhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748379272; c=relaxed/simple;
	bh=G2bOQ+/WCz0WzAESN4fFva64rvuKHL86G/4KuFHYgmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JXi+SgggdOSUOhVZ++A5JXMi178BNnIcP8fApTQI0rr7Wudbk6URp/g0VVbc6OJvdNTYuxLIb01AO+TpzGd8ABy20c0F/pR93sccCxi8F7j1fnlAhl5i9dJsCVvVpQr89/dmsLA1oVJwaqX+qLyc26ZY+be5J4MucX6kV5JNwXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NM5t3Hpw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NM5t3Hpw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64762C4CEE9;
	Tue, 27 May 2025 20:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748379272;
	bh=G2bOQ+/WCz0WzAESN4fFva64rvuKHL86G/4KuFHYgmE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NM5t3HpwpsrM8pbTinC55acmXH11b2d/DTDsGz8/6R4vIOsLyaPkE480likyRaL1q
	 kcVTD041FF9AIMa5s+L1kTN7XTd0Ws6VTnPBkKgzgJdvDYBB6dSc3H4pMe1oQLDluf
	 4Lqq1Q8v+66CPLTeCZB/LZek/48LBw8eluC/TotB2b+CI5Y8gagqtran4VXgpqOVkj
	 sfYpFcByRuW2cUgU9963tIjfh5fVA7p6cwM3AH29h6xPjcvF7UWHKhwdWesO79AzY/
	 SpTdqEr+kaHW2aMx2xe8WPfB/vLBGpFCDmTDUxCF6qp644ykKqpm0KPFM+BmeETC8w
	 oKWO7LCZkrn5w==
Date: Tue, 27 May 2025 17:54:28 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Yicong Yang <yangyicong@huawei.com>
Cc: yangyicong@hisilicon.com, namhyung@kernel.org, catalin.marinas@arm.com,
	will@kernel.org, peterz@infradead.org, mingo@redhat.com,
	mark.rutland@arm.com, jolsa@kernel.org, john.g.garry@oracle.com,
	james.clark@linaro.org, leo.yan@linux.dev, irogers@google.com,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, jonathan.cameron@huawei.com,
	hejunhao3@huawei.com, linuxarm@huawei.com, wangyushan12@huawei.com,
	caijingtao@huawei.com, xueshan2@huawei.com,
	prime.zeng@hisilicon.com, Joe Mario <jmario@redhat.com>
Subject: Re: [PATCH v2 0/3] Add support for SPE Data Source packet on
 HiSilicon HIP12
Message-ID: <aDYmhILZTC79Qp_t@x1>
References: <20250425033845.57671-1-yangyicong@huawei.com>
 <d06b1e86-b6b8-3909-65bb-45b7cd70d263@huawei.com>
 <aC3oFxuEbVEHd3Pb@x1>
 <f5afc098-def8-fa83-db9e-32837eadec0c@huawei.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5afc098-def8-fa83-db9e-32837eadec0c@huawei.com>

On Mon, May 26, 2025 at 07:06:37PM +0800, Yicong Yang wrote:
> Hi Arnaldo,
> 
> On 2025/5/21 22:49, Arnaldo Carvalho de Melo wrote:
> > On Wed, May 14, 2025 at 11:38:42AM +0800, Yicong Yang wrote:
> >> a gentle ping on this..
> > 
> > So this involves both kernel and tooling, as soon as someone merges the
> > kernel part, I can try and get to the user part,
> 
> is it still possible to catch up with this cycle? Kernel part has been picked up [1].
> 
> thanks.

I'm applying it now.

- Arnaldo
 
> [1] https://lore.kernel.org/linux-arm-kernel/174790933967.1291842.14160046478134585349.b4-ty@kernel.org/
> 
> > 
> > - Arnaldo
> >  
> >> Thanks.
> >>
> >> On 2025/4/25 11:38, Yicong Yang wrote:
> >>> From: Yicong Yang <yangyicong@hisilicon.com>
> >>>
> >>> Add support for Data Source packet on HIP12. Support counting L2 HITM for c2c
> >>> statistic since it was missing.
> >>>
> >>> Change since v2:
> >>> - split the kernel/userspace changes into different patch
> >>> - revise some mem_snoop decoding according to the discussion
> >>> - count missing L2 HITM for c2c statistic
> >>> Link: https://lore.kernel.org/linux-perf-users/20250408122809.37884-1-yangyicong@huawei.com/
> >>>
> >>> Yicong Yang (3):
> >>>   arm64: cputype: Add cputype definition for HIP12
> >>>   perf arm-spe: Add support for SPE Data Source packet on HiSilicon
> >>>     HIP12
> >>>   perf mem: Count L2 HITM for c2c statistic
> >>>
> >>>  arch/arm64/include/asm/cputype.h              |  2 +
> >>>  tools/arch/arm64/include/asm/cputype.h        |  2 +
> >>>  .../util/arm-spe-decoder/arm-spe-decoder.h    | 17 ++++
> >>>  tools/perf/util/arm-spe.c                     | 96 +++++++++++++++++++
> >>>  tools/perf/util/mem-events.c                  |  5 +-
> >>>  5 files changed, 121 insertions(+), 1 deletion(-)
> >>>
> > 
> > .
> > 
