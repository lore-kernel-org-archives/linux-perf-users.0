Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643B53590A9;
	Tue, 31 Mar 2026 20:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774988706; cv=none; b=DJaEdFxER77vKD9i/H6Tnwc29w5jDA1kDLNNrlKbMhe5FpEL4nM+idknlkEmBdO6+NmAuoboWIDGILMVmyskefkPC8hNGHUTeCJTH10UTD1UtQpJEEK24ZbxhF3LxedpIgdgyjRC78eKy0vb4lH1w4Ej5XvgDGe7PEFfKR8VP3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774988706; c=relaxed/simple;
	bh=fkkgeC51xOMSCc4A3Xa1C5hHY2so28uSaDVX0DI+2EY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UMRvgJ0JTGIXmsW6VxD5LcHdAnZTgqJ1EPs/IXiZc/IvmKrvQbcZcWB/TW69hu+AEBEGPgJ4zWTtQovF4mc9Y9xA9EURtiqus9Oz5g5AzbFJmsD5K5DI7h6iwOGeI/BureRifO3hfjsyOqSk9vix3GIlo3okMghjuhO3YLmerX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o5ytQ425; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o5ytQ425"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE746C19423;
	Tue, 31 Mar 2026 20:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774988706;
	bh=fkkgeC51xOMSCc4A3Xa1C5hHY2so28uSaDVX0DI+2EY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o5ytQ4255GtUjSj055tL00LV2xErRhEzpVJkNOtqZoRyWfLsiKE9P7Z0HgX8Lnamo
	 x9wwe5hSsIOdoddbVFzXmJxCfQFQteOk1thVAp38iKJcV8madAKUmXeua9D7VvJmCz
	 sKVXr4nr6R64HZ2SRax64Bpk7l+XMndkaQpQQu8Rb1nU4N3oD/5TpB4toRR/8FtNh9
	 Xte18rjaYn3vhtbwBPFEAUk2ctGXA/pS5AwRi9PeoS3mF34sKXxeQ0nvOLJcrg2xuU
	 DrJatDlN3EWRA3C0Me5Pu/t0aYckRdWDx3UB6tNhNyPL0yHe2os8G/5w+po+zM1I0j
	 ZwpTwLQvKtQmw==
Date: Tue, 31 Mar 2026 13:25:04 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: kernel test robot <lkp@intel.com>, oe-kbuild-all@lists.linux.dev,
	linux-perf-users@vger.kernel.org
Subject: Re: [perf-tools-next:tmp.perf-tools-next 9/10] grep:
 tools/include/uapi/linux/fadvise.h: No such file or directory
Message-ID: <acwtoHaXuv-MlgTz@google.com>
References: <acu3Qeoy3pRcCrpl@rli9-mobl>
 <acwdajLKBcDiuk_I@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <acwdajLKBcDiuk_I@x1>

Hi Arnaldo,

On Tue, Mar 31, 2026 at 04:15:54PM -0300, Arnaldo Carvalho de Melo wrote:
> On Tue, Mar 31, 2026 at 08:00:01PM +0800, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git tmp.perf-tools-next
> > head:   02288074fcf09dec98dcb3fefdada4ebb4a91d33
> > commit: 7eb9876f1d9fdb6f6a8ed5737452178ca2169205 [9/10] perf beauty: Move copy of fadvise.h from tools/include/ to tools/perf/trace/beauty/include/
> > config: arm64-allnoconfig-bpf (https://download.01.org/0day-ci/archive/20260331/202603311011.IoMYrQLJ-lkp@intel.com/config)
> > compiler: aarch64-linux-gnu-gcc (Debian 14.2.0-19) 14.2.0
> > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260331/202603311011.IoMYrQLJ-lkp@intel.com/reproduce)
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/r/202603311011.IoMYrQLJ-lkp@intel.com/
> 
> Since this hasn't touched a non-tmp branch, I'll not add it, i.e. its a
> v2.
> 
> Thanks anyway, I found and fixed the issue,

Do you want to add it to perf-tools or send v2?  I thought you wanted to
have it in perf-tools-next as you added "next" in the patch subject.

Thanks,
Namhyung

