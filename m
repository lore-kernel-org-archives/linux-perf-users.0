Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6236D19992C;
	Tue, 31 Mar 2026 20:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774990108; cv=none; b=YjedXYqQKWMCqAl9A2Ds5DJfsGSK5AAXVdSMnA31vdA2xBr8XSERNITJmsnBNJoJfsFTxBvch0ibujf2gIWMXqKE6u/0HvUEqG9X5jOPjYwEcbX5eC4Ms6boGobsWfnbHD/WDWpP8id/pDFXXRSO52q4GwK2Kmti6HH4+FEx9U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774990108; c=relaxed/simple;
	bh=DzOT0G7/MKHglYIwpFoEP33RIaxJ4wIR4fkrBtVqoQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KqHpGOcZ4cv+1iseY4qN/1gHY11GzDfv8tOQt0dFDqDs4L16EKB4FtQTnioOJW3w/6RNz97rU8k39oz02XyHGM2YDPHBFhmNu9WeLf88qCMTpjDQdW+IfX7Sc6li385hw0UpqihoNYHD9NkJM+lwR3hS+ZKvMCZSjfHeIsKgdaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qcjavCa1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qcjavCa1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE631C19423;
	Tue, 31 Mar 2026 20:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774990108;
	bh=DzOT0G7/MKHglYIwpFoEP33RIaxJ4wIR4fkrBtVqoQY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qcjavCa199p3BQ4F23P2aObns22+kGJpZIHM7E5c5Li2gpidoaz3ERR76NZFWMJ9F
	 D3Bhld4T+tCO8CD6QWkuJb30ZEmpVCgW6CalqdowRCdFYIoanH0A/glCRr96WsKBia
	 Z5x7jA+Oh/RXOR9Utmoiigb9VjTZkLGA3t10V4bwdKoGrJ90NRFdFETMwgfyrzc0rA
	 CCzrHfx9BW+dow49RQxewqeldjeiqJlk0T32qHgCnNmlHj+otEDGr6uAAhd22MwH8m
	 oOQ1U1bNdZDjBluX7TyYxpXjdb6i4CqHuNu45XmG+89Z9Yz7kOeGH2OH1InbCZDAdW
	 w/teCIPcS6tAw==
Date: Tue, 31 Mar 2026 17:48:25 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: kernel test robot <lkp@intel.com>, oe-kbuild-all@lists.linux.dev,
	linux-perf-users@vger.kernel.org
Subject: Re: [perf-tools-next:tmp.perf-tools-next 9/10] grep:
 tools/include/uapi/linux/fadvise.h: No such file or directory
Message-ID: <acwzGca2RX1dEILf@x1>
References: <acu3Qeoy3pRcCrpl@rli9-mobl>
 <acwdajLKBcDiuk_I@x1>
 <acwtoHaXuv-MlgTz@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acwtoHaXuv-MlgTz@google.com>

On Tue, Mar 31, 2026 at 01:25:04PM -0700, Namhyung Kim wrote:
> Hi Arnaldo,
> 
> On Tue, Mar 31, 2026 at 04:15:54PM -0300, Arnaldo Carvalho de Melo wrote:
> > On Tue, Mar 31, 2026 at 08:00:01PM +0800, kernel test robot wrote:
> > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git tmp.perf-tools-next
> > > head:   02288074fcf09dec98dcb3fefdada4ebb4a91d33
> > > commit: 7eb9876f1d9fdb6f6a8ed5737452178ca2169205 [9/10] perf beauty: Move copy of fadvise.h from tools/include/ to tools/perf/trace/beauty/include/
> > > config: arm64-allnoconfig-bpf (https://download.01.org/0day-ci/archive/20260331/202603311011.IoMYrQLJ-lkp@intel.com/config)
> > > compiler: aarch64-linux-gnu-gcc (Debian 14.2.0-19) 14.2.0
> > > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260331/202603311011.IoMYrQLJ-lkp@intel.com/reproduce)
> > > 
> > > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > > the same patch/commit), kindly add following tags
> > > | Reported-by: kernel test robot <lkp@intel.com>
> > > | Closes: https://lore.kernel.org/r/202603311011.IoMYrQLJ-lkp@intel.com/
> > 
> > Since this hasn't touched a non-tmp branch, I'll not add it, i.e. its a
> > v2.
> > 
> > Thanks anyway, I found and fixed the issue,
> 
> Do you want to add it to perf-tools or send v2?  I thought you wanted to
> have it in perf-tools-next as you added "next" in the patch subject.

v2, yeah, for next.

Will send now, together with the other related patch, so that sashiko
can test the series and not fail to test the the fadvise one, that
depends on the first.

- Arnaldo
