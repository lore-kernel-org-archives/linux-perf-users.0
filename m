Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD42B1EEE6;
	Fri,  2 May 2025 16:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746203592; cv=none; b=k1qSjRGFLO/E994j067aTQzGOtXS0siK1ZBlQt71SDAlNwY+67GS98I0LVE45kGtp8/RCNPluCxvkEJEd8m+4LXGWZemWsvlEho4ef1gKTjqrutDQragyDhzItSK1/lSNVXL4oM/WC7aQ63l73kds8+cZ+XKyqx+19gyn0+wnfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746203592; c=relaxed/simple;
	bh=gGhrIz8xXo4FBtKTWnukSWjz2WxOsCyy6kCNnvJY+Hs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N4ewGe11c8YiChraAT8p2HccI7VRvVjZipXc5XtCRz/NUoOhlLA1/xcy/X5/VG0BJ4qO6FtT4vE8+TE7cTxEy/k8zQRS0VKsZT+lHDh5DGS1Y+FMk5diIgkMVo4/gvXb1ofytbZ6VgVcJXL9T+gR8jvsz6ts4UWiSrx42fw5jMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HAo+Oz9P; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HAo+Oz9P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE99BC4CEE4;
	Fri,  2 May 2025 16:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746203590;
	bh=gGhrIz8xXo4FBtKTWnukSWjz2WxOsCyy6kCNnvJY+Hs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HAo+Oz9Pq0jIsklcz19DgnsHi3Xz2doGqzmqbED0UXb3ZJFccvU1w3YiY3eesIXdl
	 SPikIGJckbVCRZhIT0LdaDgGbJC4h1ch7B3kPv+KPS3zXhamj07grm0mVAJTvb9sFT
	 VFjG0LtD/m+PIJ3nj83FoiU3bZHzqw9DHCycX2JrelZ99uVtT7ZUUSQhM123boZsLP
	 GYYacEOwVmHwCPwUc0pKzjh1RZJCFUTHQxu6/r5nkgHBi8LamfB+qADWsmyl+SH0cn
	 plCETHnmpGCVoCBmQN2/PGqmoQRmWAcCDpKVepn7HsnKrgLNjANwtRAehWTB7YgDMA
	 ep7Xju5+0kugw==
Date: Fri, 2 May 2025 13:33:07 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Joe Mario <jmario@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: DW_AT_comp_dir and O= usage not working with objdump -dS, perf
 probe, etc
Message-ID: <aBTzw5t5u9CLIqhI@x1>
References: <aBKziq9dr_EsWLuZ@x1>
 <8046e5bb-06d4-47dd-ad08-deef63a7e734@t-8ch.de>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8046e5bb-06d4-47dd-ad08-deef63a7e734@t-8ch.de>

On Thu, May 01, 2025 at 08:59:39AM +0200, Thomas Weiﬂschuh wrote:
> Hi Arnaldo,
> 
> On 2025-04-30 20:34:34-0300, Arnaldo Carvalho de Melo wrote:
> > 	I noticed recently while testing some other patches that
> > disassembling with objdump -dS didn't work when building the kernel with
> > O= as it sets it to the build dir, not to where the sources are, for
> > instance:
> 
> <snip>
> 
> > I haven't checked, ran out of time today, but I think this may be
> > involved:
> > 
> > commit 97282e6d380db8a07120fe1b794ac969ee4a3b5c
> > Author: Thomas Weiﬂschuh <linux@weissschuh.net>
> > Date:   Sat Mar 22 10:03:16 2025 +0100
> > 
> >     x86: drop unnecessary prefix map configuration
> 
> It should be caused by this one:
> 
> commit cacd22ce69585a91c386243cd662ada962431e63
> Author: Thomas Weiﬂschuh <linux@weissschuh.net>
> Date:   Sat Mar 15 14:20:14 2025 +0100
> 
>     kbuild: make all file references relative to source root
> 
> 
> There is already another report about objdump here:
> https://lore.kernel.org/lkml/aBEttQH4kimHFScx@intel.com/
> 
> Let's continue the discussion there.

Thanks, I'll follow that discussion then.

- Arnaldo
