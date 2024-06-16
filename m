Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C54946F
	for <linux-perf-users@vger.kernel.org>; Sun, 16 Jun 2024 03:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718509235; cv=none; b=iEs+i50Ixd2eMknzu/2VT6RXM/Wgmrm3bRm9cE6gQ0ephfU59/ZM1DVe9YPH8ee97Dwp2/30Vc4wJjh0GFY0MiUyEbd4Udrn00G0Pemlhpk5HgXY7NuyG2yscFaAD7HVMUtIHrnO6vcGRNekPbKlTCH2DBf4NCJuwB4ObxaFiJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718509235; c=relaxed/simple;
	bh=W/8+qxL9c+ZKuUzm1/w4fdRg0jsp4nJ/sFa1lAs9PZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ApgdhtrBsSrSyxBkLpC6E8wYI56TLjHIm4cdQ4HwQwgiEXqVblGsD5VkCFe4+7yoOFuoz6wfmln/6DBZGq3OcoWexVN5fCkuGPdDWgVgEuaVmrp9BfDRyR+5vdotfgwYui+qHSTTncfHwEYiJgz6erVxvOSdkxF2g5nilDX3kAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q3KVnqgP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q3KVnqgP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81AEDC2BBFC;
	Sun, 16 Jun 2024 03:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718509234;
	bh=W/8+qxL9c+ZKuUzm1/w4fdRg0jsp4nJ/sFa1lAs9PZQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q3KVnqgPWY7FQRgVmIZaGwO5/JNq6xQaid5QxA9s77PBuqDN8Yzhep8b16QHnULu0
	 algLSplMHFslnGq9F76ofyRMvKN/vxYRJEJ81JGKsS56CAIG5PW77WeriuqMexNb23
	 QsSENHK2BzOKDkGHLfd7l1v3OzMqrKQuNhII+qLAGfHWLNhApLhhJEkNC0TDBWYDBs
	 IZPFdAtH/rF+cMHDUw3Myc+ws4lxr9QkQ4pYDVtCQB79z6YbpzhVc+dttL1I9tVVgo
	 y/ffCiQCvgB3lF5t6OEzZdkaW+JwSt9sxYT14iWx+WrRwVqp01aWbkGR5aGr0Bi5iG
	 yS5AHo7z/aofQ==
Date: Sat, 15 Jun 2024 20:40:32 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: James Clark <james.clark@arm.com>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	Leo Yan <leo.yan@arm.com>
Subject: Re: Perf Wiki Appears Broken
Message-ID: <Zm5esBevamPzcrl_@google.com>
References: <87365604-bfa5-4153-b41a-84bf87fb4cfd@arm.com>
 <a68343ee-b450-4ae1-a5dc-da6e1c865dcb@arm.com>
 <Zmrtr5Mw_V8a01pD@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zmrtr5Mw_V8a01pD@x1>

On Thu, Jun 13, 2024 at 10:01:35AM -0300, Arnaldo Carvalho de Melo wrote:
> On Thu, Jun 13, 2024 at 01:55:08PM +0100, James Clark wrote:
> > On 10/06/2024 10:19, James Clark wrote:
> > > Hi Arnaldo,
> > > 
> > > I'm not sure if you're still the admin of the Perf wiki, but I'm getting
> > > a login error:
> > > 
> > >  Wiki uses cookies to log in users. You have cookies disabled. Please
> > >  enable them and try again.
> > > 
> > > From a quick Google I think this might be a disk space or configuration
> > > issue.
> > > 
> > > I was planning to add a dockerfile for cross compiling an Arm Perf on
> > > x86. I suppose we can also discuss here if anyone thinks that's useful
> > > or the right place for it.
> > > 
> > > Thanks
> > > James
> > > 
> > 
> > I'm able to log in now. If you poked it, thanks!
> 
> Great! Probably was something transient and the admins fixed it.
> 
> I tried poking a friend that was the admin in the past but he told me he
> wasn't doing it anymore.

I'm still having a problem with login. :(

Thanks,
Namhyung

