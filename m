Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE498389DF3;
	Tue, 31 Mar 2026 20:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774990722; cv=none; b=sXscsW39Q5nBKrTVD0dD8MTX+pvNXjxQBI75gJLiph+d9NB6loI8cc/rNR5aLgRyZ21RaG8qIVAc59gR3mgVUGkiXslqa1Jya6NkRZiLNIVUz7gNNbvFO6vi4sJRQIjdXor9HVyFsQmvIV34+nlq4wn+cB7t117z3JZ4LbpB0gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774990722; c=relaxed/simple;
	bh=grPRCaitgBgkq7/YggVMK4Zcu9KTX9pDc8weDIulcIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qI1cccawYRgwPPo36xSKoybeOzlb8C8lHDju4BqocAyKb+VH8pQNMz7swTgBnW5VTuWyrj0NIz9NIz0bn1idBnu8czjG7ayor9MY4ajfM/jpDHY2u64z4rpNjZ6Opz4h9ww9uGRnuB8ayD4Nm4Fc0dVFG0qGsa/9x81D0Kv75qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JB8rtwiB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JB8rtwiB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EF17C19423;
	Tue, 31 Mar 2026 20:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774990722;
	bh=grPRCaitgBgkq7/YggVMK4Zcu9KTX9pDc8weDIulcIs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JB8rtwiB3voX7tjvL2mc8EbFTSvOcTG5hG7Ww/9NfQq9//5RvPx02zxzpTP39bcCg
	 Gni46kn/f0zfhO6mYIrGU94Fi3cJtvySmk2uWnX7hp5BCGKjdGCdX/6x1zxNSlLNIU
	 TVjFetYzkLYUkbp41bzZ85XyuO1dMuWeHIY2TACqKf4xcHVFUl9ByhZuDF7LuyZ2rh
	 CbGvLlqY18PWEQXJWX2uhFlJGV9r3TJ+5QpDYS2ZChRBYnvzNO8UQxVUVsrhMEkx6G
	 62qHdA1NYtZkSAnHq707yczZ7ZQZXcr8z5TXOCmdc7BpP5XiLEj57Uu9IVrYzLcik0
	 IgvqBG3CzhLCw==
Date: Tue, 31 Mar 2026 17:58:39 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: kernel test robot <lkp@intel.com>, oe-kbuild-all@lists.linux.dev,
	linux-perf-users@vger.kernel.org
Subject: Re: [perf-tools-next:tmp.perf-tools-next 9/10] grep:
 tools/include/uapi/linux/fadvise.h: No such file or directory
Message-ID: <acw1fz4IxmAK_p-M@x1>
References: <acu3Qeoy3pRcCrpl@rli9-mobl>
 <acwdajLKBcDiuk_I@x1>
 <acwtoHaXuv-MlgTz@google.com>
 <acwzGca2RX1dEILf@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acwzGca2RX1dEILf@x1>

On Tue, Mar 31, 2026 at 05:48:28PM -0300, Arnaldo Carvalho de Melo wrote:
> On Tue, Mar 31, 2026 at 01:25:04PM -0700, Namhyung Kim wrote:
> > Hi Arnaldo,
> > 
> > On Tue, Mar 31, 2026 at 04:15:54PM -0300, Arnaldo Carvalho de Melo wrote:
> > > On Tue, Mar 31, 2026 at 08:00:01PM +0800, kernel test robot wrote:
> > > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git tmp.perf-tools-next
> > > > head:   02288074fcf09dec98dcb3fefdada4ebb4a91d33
> > > > commit: 7eb9876f1d9fdb6f6a8ed5737452178ca2169205 [9/10] perf beauty: Move copy of fadvise.h from tools/include/ to tools/perf/trace/beauty/include/
> > > > config: arm64-allnoconfig-bpf (https://download.01.org/0day-ci/archive/20260331/202603311011.IoMYrQLJ-lkp@intel.com/config)
> > > > compiler: aarch64-linux-gnu-gcc (Debian 14.2.0-19) 14.2.0
> > > > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260331/202603311011.IoMYrQLJ-lkp@intel.com/reproduce)
> > > > 
> > > > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > > > the same patch/commit), kindly add following tags
> > > > | Reported-by: kernel test robot <lkp@intel.com>
> > > > | Closes: https://lore.kernel.org/r/202603311011.IoMYrQLJ-lkp@intel.com/
> > > 
> > > Since this hasn't touched a non-tmp branch, I'll not add it, i.e. its a
> > > v2.
> > > 
> > > Thanks anyway, I found and fixed the issue,
> > 
> > Do you want to add it to perf-tools or send v2?  I thought you wanted to
> > have it in perf-tools-next as you added "next" in the patch subject.
> 
> v2, yeah, for next.
> 
> Will send now, together with the other related patch, so that sashiko
> can test the series and not fail to test the the fadvise one, that
> depends on the first.

Got your point, it is in perf-tools-next/tmp.perf-tools-next already, so
you'll need to replace what is there with what I'll send as v2, since it
didn't hit perf-tools-next/perf-tools-next.

Ok, sending it now.

- Arnaldo
