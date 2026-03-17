Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C39379981
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Mar 2026 20:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773778751; cv=none; b=AALefOQ1hwFYT5b7N/eJwtzE3sLTNlsw3321yfNT1o6GzkdkEZf/jpE8uu2CUAIINPRqsWCR4GeFhmr+5JRA0//PDPi0aQmy/dgKR6TdG8qfwrSWzN67Kb8BlhibKcPyXKHLH7BvtIYxvs4K542zyZf97w+kOLn4a2ft+aS0tOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773778751; c=relaxed/simple;
	bh=IcCzzhSiFJWfxIIu3uIDgttkdd22Fqg5y8MnHCrLfl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qpnt2koaiLVjLe+gh9ukGQPlqG2N4HZpngSYKxNqLe0NNwMc3JfHY54NxqRUO47bngUnIV3nCBv2NNmr90J5jEzf0MWTMViRiVBR2PkmdFXhl+lBZ/zKbmV/yRmrsZzG0SplSIwK6ZPQCVcdf0FbKL/qwhbnc54o3cl9HW4VIck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WFiYej5G; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WFiYej5G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62713C2BCAF;
	Tue, 17 Mar 2026 20:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773778750;
	bh=IcCzzhSiFJWfxIIu3uIDgttkdd22Fqg5y8MnHCrLfl0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WFiYej5G1xb3fUPIM0YEQ9DsvR0rhf7SFKjJMu/dZ/9Ru4eTtjLx6PGjyOHsFUYZR
	 fJglqQDNS4IGVHXekEsHny6Kn89s+HWXP2am+ya21QY10m2IxkOs2flv8mv6PqElMZ
	 ELuIcadEk898KpBbxiNJpwMNwTzOpOb1dc+5jXaURDu2NgqWQXsqMV+TZ/rjyWO+Fu
	 dJDgE/u7CSjJah0bQBQArX+YyIokjKxsaHt5Opxa+OXFKXF5+G4HQcSmV2qkFGpdnw
	 nSgjsRTn5qnJr47zvYe6y4K1ls1cqvlykwT/PxksVhzcRo7SAM4BRhaUbfUWXQVM2m
	 J4VnyYEndscLA==
Date: Tue, 17 Mar 2026 17:19:07 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Melo <arnaldo.melo@gmail.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	"linux-perf-use." <linux-perf-users@vger.kernel.org>,
	Jan Polensky <japo@linux.ibm.com>
Subject: Re: perf stat issue with 7.0.0rc3
Message-ID: <abm3O7rGktEcUdz0@x1>
References: <66d0366b-8690-4bde-aba4-1d51f278dfa1@linux.ibm.com>
 <abQq79_ajs8zFeEI@x1>
 <CAP-5=fWG0Q-xNGn_-_KGCopaNsWG5rUN3pYNLEh3K7+xE0OwVQ@mail.gmail.com>
 <D40D4E89-3F4E-482C-9EB8-DCFAC70095AB@gmail.com>
 <CAP-5=fVxRd_byM2zZ_hLoZ36vPsN02nE4FozUuuwojXcJ3eODg@mail.gmail.com>
 <957241A0-E5C8-417C-98B7-B6E1EAFE19B1@gmail.com>
 <CAP-5=fWBDMMPv_CSE4Yv5VC_+MhXF2ddjrePeR=EajyBfQjS2g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fWBDMMPv_CSE4Yv5VC_+MhXF2ddjrePeR=EajyBfQjS2g@mail.gmail.com>

On Fri, Mar 13, 2026 at 11:27:30AM -0700, Ian Rogers wrote:
> > >No worries, presumably if I'd been monitoring:
> > >https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git/log/?h=tmp.perf-tools
> > >I'd have seen it was missing. Perhaps you can give a heads up to check
> > >for missing patches when assembling the PRs. I rarely look at
> > >perf-tools.git as perf-tools-next.git is where all the action is :-)
> > >Actually, I vibe coded a script that may work to automate this:
> > >```

> > Well, if those patches are ok for perf-tools, i.e. are fixes for
> > bugs introduced in the current merge window or urgent fixes for
> > longstanding bugs, they shouldn't be in perf-tools-next, they should
> > be in perf-tools to be merger in the current merge window.

> > Coordination in triaging via an Acked-by/Reviewed-by pointing out
> > it's something for the current merge window, something I do, is what
> > we should strive to do.

> > When I notice something that's needed for the current window that's
> > been processed by Namhyung for perf-tools-next, I merge it as well
> > (as will be in this case and maybe in the others that you pointed
> > out, thanks, I'll check each one).

> > No problem with that, better be in both branches than to get missed
> > :-)
 
> Thanks! In the patches tagged as "fixes," I think these 2 also need picking up:
 
> commit aa6a6a2d16c1e2e27e986936369959d70316199f ("perf parse-events:
> Fix big-endian 'overwrite' by writing") to fix s390.
> commit 06ec44c2aa2ef15fd56f9808b6cf7495e1fbd8ec ("perf kvm stat: Fix
> relative paths for including headers") for non-x86 builds.

Picked the two above in addition to the original one that Leo pointed
out to me at the start of this thread,

Thanks,

- Arnaldo
 
> The other patches are test fixes or address malloc failures that
> shouldn't really happen, so they are not a priority.
