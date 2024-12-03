Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C811F8901
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Dec 2024 18:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733249409; cv=none; b=ST6tmn0ta7SbUIP4MCUJFgCiZK1rjnuC4G+RW+v/65nAfUFKot3/vnb0FdDq7zgqysNDACKEyfstaRxqhDqgOxBrkkTC6iQbDcpnm3U6KuWbvqb9X5I5ZYXwpUaBt8tv64LjiF40d8w15r1MZK0pKvBpqWpn1UdGtnWNLZzjRIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733249409; c=relaxed/simple;
	bh=nnDUCrPO8Iropz23V0QUybTcd+UW8xp5KCTHCW7bM34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kXf4UFqd7Akv14DhMURTiXzMPLezHERpkPsBI5kgXEkYq5yKQYV2i4hxy0x2Cm372ghuAaI31gRDMklRbsxKd6XXp/lkf7AcDBIb4gMrsxLXSNrrjoE/W5p8KO7yyEUhtfnsf9yF115/sQWXdzd8hulPIjMBwWPldbcyNbO2YAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CgNS8iv9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CgNS8iv9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D197EC4CECF;
	Tue,  3 Dec 2024 18:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733249409;
	bh=nnDUCrPO8Iropz23V0QUybTcd+UW8xp5KCTHCW7bM34=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CgNS8iv9VNj77hCYVjt+9Ua/I/7b3bYE6B+sA4dAZfi1P9+e28PbehGVEUIkiSd14
	 CGJ8E2SWqVIPH5w1oaBM0DRgyfWzhlCgXJf26z8mWPplpTSRx59Z/u1zeGu8LhUwKj
	 AN8T8+CR26lFOlvJl+ufhmbPUSP8UJ4tbMORdE5fvVeiYbkLYR5Jy2pHrVbD5pt9v/
	 OrDFTvrvgMFPhT5M67OgvLi75SM1/xjyjGcr2COO/eTYUPw/YHpD4Ei80wKdhak1wg
	 LKkmHxjTeQP/msl6YIfdAox1AP5MZJ4Rxm300gPEvokdGcv4IioFoWuFlKxvAHn19Y
	 5R3xEepQ2qt8w==
Date: Tue, 3 Dec 2024 10:10:07 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: James Clark <james.clark@linaro.org>
Cc: Thomas Richter <tmricht@linux.ibm.com>, Ian Rogers <irogers@google.com>,
	"linux-perf-use." <linux-perf-users@vger.kernel.org>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Leo Yan <leo.yan@arm.com>,
	Sumanth Korikkar <sumanthk@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>
Subject: Re: Perf test 7 fails on s390 since 6.12.0
Message-ID: <Z09Jf6n9gVxURbsf@google.com>
References: <12338ec9-51a0-44ef-b2e6-4a95d3bf0e4d@linux.ibm.com>
 <8d6d43d1-51be-4412-829a-ef5875321f5b@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8d6d43d1-51be-4412-829a-ef5875321f5b@linaro.org>

Hello,

On Tue, Dec 03, 2024 at 02:37:00PM +0000, James Clark wrote:
> 
> 
> On 02/12/2024 2:53 pm, Thomas Richter wrote:
> > I just downloaded the latest kernel tree 6.13.0rc1 and observed several
> > failures of the perf test suite.
> > 
> > This test case is the first one:
> > # ./perf test -F 7
> > Unrecognized literal '#system_tsc_freq'  7: Simple expression parser  : FAILED!
> > #
> 
> Hi Thomas,
> 
> Did you see this thread: https://lore.kernel.org/linux-perf-users/0F805B2F-35CC-4E0C-BD2F-84552C4C528E@linux.vnet.ibm.com/
> 
> Is that related to your issue? I looked but I couldn't find a V2 from
> Athira.

Oh, I missed this one.  I'll take a look again and let Athira proceed.

> 
> The same test was also mentioned on "[GIT PULL] perf-tools changes for
> v6.13", but I can't tell if it's the same type of failure or not.

I suspect it's the same issue.

Thanks,
Namhyung

