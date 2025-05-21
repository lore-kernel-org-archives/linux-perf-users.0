Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285091D63DF
	for <linux-perf-users@vger.kernel.org>; Wed, 21 May 2025 14:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747839003; cv=none; b=SQ4UrHV4yvzkx8p8I6Te2dQ+1jjvb8Cti5wTARUQUfzCAcDpJHl1xSX1xRn4mKCa6u+k5CdMY8bL6id1M6WVjVmpoVkDvTWhOjcjp1nwslVEVfgjS+kRTsM0hegsldn1TtZuunKKRV64Kcmgr0DUci4K3X2Fbk5o9dyJUaS8N6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747839003; c=relaxed/simple;
	bh=kpejLVfuGzeC4eSxpnmOWcLTEEDUfc6nPoJRhXIElao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dDopFae+nHzv9K2WL9JDOx4haPoEkysiezzyzqoqH/SmKnoUnEd4Y84mTzjS9SBPCXhqVnXsWvgPWOSPT391uIqrTKxhacsrhKwD81FnpQV7rctXemkhet0AGv1cUmbc/cNY3LyMiQWIpTYfloYNcwMJrw3g9xSdrJlzf9PY8KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Idnbwoj9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Idnbwoj9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 262CAC4CEE4;
	Wed, 21 May 2025 14:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747839002;
	bh=kpejLVfuGzeC4eSxpnmOWcLTEEDUfc6nPoJRhXIElao=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Idnbwoj9CIZeH4b5+gII+STCrWkRoMVQ0V8lrtBBPsxqJgHbzfvGmJieF3lzVSC/5
	 cw4qNgg6Utg3C0wCOKRjs9M7ey/pCWT5Hlt3kZiagzzVe7Gx+NcL++QM7/xg7IWnWq
	 pW3ubvbPBOoldgF78fC4V/7U6GCs9GlzlraqBU+BP1gFn5+JEJlnGkb5FmTumYS2vX
	 MxEGQw0tUx+seDdl8N2FfLedOB2sABP1aAbzI62bPWUkvnjrRPN9nas3/JE/DEAtbl
	 Ngf3fxnwFxcDtatWVL4vpF6IKTdN+dY5ATPR1FeGX2vbPlvOGolv/4JjHEl/PHFpbe
	 LPKsyu2fGi3Kw==
Date: Wed, 21 May 2025 11:49:59 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Yicong Yang <yangyicong@huawei.com>
Cc: namhyung@kernel.org, catalin.marinas@arm.com, will@kernel.org,
	peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
	jolsa@kernel.org, john.g.garry@oracle.com, james.clark@linaro.org,
	leo.yan@linux.dev, irogers@google.com,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, yangyicong@hisilicon.com,
	jonathan.cameron@huawei.com, hejunhao3@huawei.com,
	linuxarm@huawei.com, wangyushan12@huawei.com, caijingtao@huawei.com,
	xueshan2@huawei.com, prime.zeng@hisilicon.com,
	Joe Mario <jmario@redhat.com>
Subject: Re: [PATCH v2 0/3] Add support for SPE Data Source packet on
 HiSilicon HIP12
Message-ID: <aC3oFxuEbVEHd3Pb@x1>
References: <20250425033845.57671-1-yangyicong@huawei.com>
 <d06b1e86-b6b8-3909-65bb-45b7cd70d263@huawei.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d06b1e86-b6b8-3909-65bb-45b7cd70d263@huawei.com>

On Wed, May 14, 2025 at 11:38:42AM +0800, Yicong Yang wrote:
> a gentle ping on this..

So this involves both kernel and tooling, as soon as someone merges the
kernel part, I can try and get to the user part,

- Arnaldo
 
> Thanks.
> 
> On 2025/4/25 11:38, Yicong Yang wrote:
> > From: Yicong Yang <yangyicong@hisilicon.com>
> > 
> > Add support for Data Source packet on HIP12. Support counting L2 HITM for c2c
> > statistic since it was missing.
> > 
> > Change since v2:
> > - split the kernel/userspace changes into different patch
> > - revise some mem_snoop decoding according to the discussion
> > - count missing L2 HITM for c2c statistic
> > Link: https://lore.kernel.org/linux-perf-users/20250408122809.37884-1-yangyicong@huawei.com/
> > 
> > Yicong Yang (3):
> >   arm64: cputype: Add cputype definition for HIP12
> >   perf arm-spe: Add support for SPE Data Source packet on HiSilicon
> >     HIP12
> >   perf mem: Count L2 HITM for c2c statistic
> > 
> >  arch/arm64/include/asm/cputype.h              |  2 +
> >  tools/arch/arm64/include/asm/cputype.h        |  2 +
> >  .../util/arm-spe-decoder/arm-spe-decoder.h    | 17 ++++
> >  tools/perf/util/arm-spe.c                     | 96 +++++++++++++++++++
> >  tools/perf/util/mem-events.c                  |  5 +-
> >  5 files changed, 121 insertions(+), 1 deletion(-)
> > 
