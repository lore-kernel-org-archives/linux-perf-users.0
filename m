Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB841A83F9;
	Mon, 19 May 2025 18:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747679342; cv=none; b=JHywRWkPMn6/Gx3Ms1c0ZGVdyezGVhTg7TwT2LDnFEakUK17bzrHZI2pSu1nXXBmxyWL2zL1mdpsDwh8DN8wlmivuHQamBAlQZjpnNY4437s2jDw/GhOZmh6cLrohKnpZDGb7BPrSWaO8MaAkX3N/hzJiJvHHSeNXrKcAZphM60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747679342; c=relaxed/simple;
	bh=G8Gkl9lnzHDZwnlb37+AG+qtzTbZ34508kakmBdG10I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=afozza/59R0qxsk5EGxGCPbSKZ3eviXUmZWXNrSui9V3ORqaBOJ056XgFLEO73HScVtNFDMtTnGOIToihWx55TulrRrzo4vv6ZjlG49Xdv9VDuRxRF4GNHak3YtFB51TFTJikXNmJH6mWgMSc3EL3hJDnH5kB2oP2wvqWu9HhW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BAYO5AR8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BAYO5AR8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12E35C4CEE4;
	Mon, 19 May 2025 18:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747679342;
	bh=G8Gkl9lnzHDZwnlb37+AG+qtzTbZ34508kakmBdG10I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BAYO5AR8cUFaZbDmJiCLuRL55GNYvrWCo3e803T+m3fbVbClsgzEzlDtsF+f64yPm
	 mna8L2ZtTCBIEU7otOmLEwWSldWFOOudHYzXj87D3j8LktiZRtDv450ATd5nV9MmP7
	 OZ3GI1VKf+LiFU/6YSydcc85wHBr3frMzlJBe/tbUTRu33vrbORpD52GV6cVJK/sgP
	 wcb7KY/nvtOxzF/Bgr04F95rq5b1U1rl/iXRUYDILK665vKYtyzJesy9sWGQEgm+9h
	 5OKmaXMuj+tOvkShFFryO0BeuC63gEqa6eWXdtJNkwEYPll6+XJkgVISSftJ+e8JKf
	 yr2W85cBTm06A==
Date: Mon, 19 May 2025 15:28:58 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ravi Bangoria <ravi.bangoria@amd.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
Subject: Re: IBS perf test failures on 9950x3d
Message-ID: <aCt4akGLsuuC4aLP@x1>
References: <aCfuGXUnNIbnYo_r@x1>
 <33e86415-c90d-420a-b7a8-6a360769aea4@amd.com>
 <aColYM3RqE4T5t5c@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aColYM3RqE4T5t5c@google.com>

On Sun, May 18, 2025 at 11:22:24AM -0700, Namhyung Kim wrote:
> On Sat, May 17, 2025 at 05:33:19PM +0530, Ravi Bangoria wrote:
> > Hi Arnaldo,

> > > If it needs a specific kernel, then the test needs to cope with that,
> > > etc.

> > 1) Bunch of IBS kernel fixes went in recently (v6.15-rc1):

> >    https://lore.kernel.org/r/20250115054438.1021-1-ravi.bangoria@amd.com

> >    Since you are running on 6.14.5-300.fc42.x86_64, the failures are
> >    genuine and indicating that kernel should be fixed.

Telling that to the user and possibly skipping the test if viable using
uname to get the version and if less than v6.15-rc1 print "Skip (needs
v6.15-rc1 or newer)" may be an option.

Then if the bug somehow reappears, people running 'perf test' will flag
it.

> >    I'm wondering how would the test cope with the buggy kernel. Or
> >    probably 'perf test' a wrong place to put such selftests?
 
> Maybe... some kernel internal changes can be tested in the selftest.
 
> And 'perf test' should work with any kernel versions.  Is the test
> checking any invalid configs?  Probably then it should move to the
> selftest so that it can be tied to the fixed kernels and 'perf test'
> should only use valid configs.

Right, but then there are cases where something changed and then
'perf test' should adapt to accept new behaviour while keeping what made
sense for older kernels.

The fix Leo sent recently is one such case.

https://lore.kernel.org/all/20250519082755.1669187-1-leo.yan@arm.com/T/#u

And I think having it in 'perf test' as well may make the feature to be
tested more widely, both by those who run selftests as well as by people
trying just 'perf test'.

- Arnaldo
