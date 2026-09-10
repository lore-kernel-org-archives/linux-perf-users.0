Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588CB49BD94;
	Thu, 10 Sep 2026 14:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789049496; cv=none; b=SkL0TA0QxNOvGE9JESrC11MX9BRWgYZVcet0tZd+Lx6+CyOnMBlqB7nlkf9ObmV71K0/IMcPYJjJdpItJ37pyNgeao3X1QxTzPQIUyn+tV4b720PLPdgqgebaWmXMTPNZD3EnRCfJIw8Aa2LHChLshiA9NEhLVQKU9s6N5b+1Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789049496; c=relaxed/simple;
	bh=pza0lwj7D5ILHNLy7YEft9MjoGZfks7A+UiNyDy2dsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sqwkbgCO2cOuLA9Su/2e9RMa93aGvmuTZloz0tyPhS7N7HFQzYdEWNofdgQf783J9Yp1dyT+sxHbVkhYdR7PD1MAgPZk+lwEkP9IkzftRdLFEBKSGiF3OvY2FUSOj+Ahj2IJvhMuYEVkzXDavWJW50Wjb0A0fdcvc3v+4S2gr1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TKAWgcLz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TKAWgcLz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 483EC1F00899;
	Thu, 10 Sep 2026 14:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789049494;
	bh=rA7E7NZP2sXxrr0D5UjXcj7MmWstnfRiy0q/ui2D+3c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TKAWgcLzqLUnaVCVNal95H8VEG7p56aRYVQjiYExlUXWYDROs2nsXXSPd9jj+9eci
	 i7R8SJK+iuVp9rpEigFgBWSh3V+ySLuWvLK/13OUpDrnPy+YoFA1oBvXe5RQ/0vkWt
	 E3IvFiqfE6FoYorrcctuQyha9uvaQ/1Nn5pM+0v50cdvTl24sP8L+yojY/18S5tmtw
	 7FEL/BU5teJnSCNUw3oD/KsfVmWDnegBnzBkqa5SD5pcgj0Zoi52kSOMkzHZ8m0CUT
	 jpH9qtjPBeVrD1EdeOR34D4d1Mv0J3i5QoWaybOtN/qXb3vdkUNA3iCGyfxEy33aHM
	 aqAbrAbFm9jlw==
Date: Thu, 10 Sep 2026 11:11:32 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: sashiko-reviews@lists.linux.dev, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v1 1/3] perf sched: Add missing perf_session__delete()
Message-ID: <aqK6lHUNwgZzn1Cn@x2>
References: <20260713204707.2181098-1-namhyung@kernel.org>
 <20260713204707.2181098-2-namhyung@kernel.org>
 <20260713205907.77D4F1F000E9@smtp.kernel.org>
 <alVt_4Oaj8SvqAlv@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alVt_4Oaj8SvqAlv@google.com>

On Mon, Jul 13, 2026 at 04:00:15PM -0700, Namhyung Kim wrote:
> On Mon, Jul 13, 2026 at 08:59:07PM +0000, sashiko-bot@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> > > +++ b/tools/perf/builtin-sched.c
> > > @@ -4027,6 +4027,7 @@ static int perf_sched__schedstat_record(struct perf_sched *sched,
> > >  	else
> > >  		fprintf(stderr, "[ perf sched stats: Failed !! ]\n");
> > >  
> > > +	perf_session__delete(session);
> > >  	evlist__put(evlist);
> > >  	close(fd);
> > 
> > [Severity: Medium]
> > Does adding perf_session__delete() result in closing the file descriptor twice?
> > 
> > Since perf_session__delete() internally closes the file descriptor associated
> > with the session data, the subsequent explicit close(fd) will attempt to
> > close it again. This could return EBADF or erroneously close an unrelated
> > file descriptor if another thread opens a file in the meantime.
> 
> Hmm.. looks right.  I think I can just remove the close().

Ok, waiting for v2 then.

- Arnaldo
