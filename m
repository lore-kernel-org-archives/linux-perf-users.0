Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F6A339B4A;
	Thu, 18 Dec 2025 10:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766052685; cv=none; b=rpCo4VdWHEZpIE8D6qGYhJGObjuxTtNlz4w0wRuhL7KI4+gjLXhD6hQAybVUzRsbQ3msZC9VPfOE0w7inhTB7MIqqcpxfrYjurFiuBxwCZk4EwL5fw/8wR712Xh3CGLXhbUsX7wkSHlQmxhyKGqW4mfjPp8Pb4qrSSVsKli9yxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766052685; c=relaxed/simple;
	bh=7W87Swz9dRe0Iq5pPGhXSuna7hL0enbwtfT0Gipre9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k8nrkmrQchbPMQgWwgo7JZyglQT5hjopxd15Gi2zs6pBIBItFQX70ZzMOkPLHooltJGLFY4gixaglRvUvIam+56xkBX6DOuu0MS0nqhTuvSGr0J4JgYMajM3hacdj6fK+BS9RfeWd99lqJhijiTkQHdB4IVi9LFSj94BeRsh+is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bqitxy5c; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bqitxy5c"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=dqvJMpbSP56x20xgbSdWtNU06xvRlh7WU/pHezWhPIQ=; b=bqitxy5cTxm56QNLvj20SiZqJc
	mTTvj4nwoU55SgQGLffJN74/lyN+WOOD2PnQgr/7Hs7J7Bg8V6uEzMrl+6N/UtmWAqiRsx+m264PJ
	pKMfoZnvzDCKUFJE4Ci2yjpLOym0HSj9A8KF/ZU9ZlZpY/4C7pnRLNh8YGOz/oYAdEWFuvHfokcOC
	rAQLHwITwq/MJbIqrhee4F1poZxHcPCQew024g4Z+IuMV8yRoJC7havmVM6kJaFczNy7sG9lRTdNE
	xLFcQJdxeyYg4YGpXCV+rqH1+pfD+HUxHzSCTIus33rTgA0Fm6OLiIK1Bv/FfTBT5JC4y8H00bToG
	9NWSdezA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vWA76-00000008WUp-0KRa;
	Thu, 18 Dec 2025 09:16:00 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 5A88E30056B; Thu, 18 Dec 2025 11:11:13 +0100 (CET)
Date: Thu, 18 Dec 2025 11:11:13 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
	linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf/x86/uncore: clean up const mismatch
Message-ID: <20251218101113.GM3707891@noisy.programming.kicks-ass.net>
References: <2025121741-headstand-stratus-f5eb@gregkh>
 <20251218085551.GK3707891@noisy.programming.kicks-ass.net>
 <2025121819-snowdrift-thievish-4108@gregkh>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025121819-snowdrift-thievish-4108@gregkh>

On Thu, Dec 18, 2025 at 10:59:25AM +0100, Greg Kroah-Hartman wrote:
> On Thu, Dec 18, 2025 at 09:55:51AM +0100, Peter Zijlstra wrote:
> > On Wed, Dec 17, 2025 at 01:42:41PM +0100, Greg Kroah-Hartman wrote:
> > > In some cmp functions, a const pointer is cast out to a non-const
> > > pointer by using container_of() which is not correct.  Fix this up by
> > > properly marking the pointers as const, which preserves the correct
> > > type of the pointer passed into the functions.
> > 
> > How did you find this? My builds do not complain and all that.
> 
> I have a local change that turns container_of() into container_of_const():
> 	https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git/commit/?h=container_of_const_mess&id=ea8cab3db2b5a56c5ef63d0e32accce58eb9bb2c
> that I'm using to sweep the tree and fix up all of the places we have
> gotten this wrong.  And wow, have we gotten it wrong in so many
> places...
> 
> It's a slow grind, I'll get there eventually and then will merge a patch
> that forces container_of() to catch this type of thing so it will not
> come back in the future.  Maybe a year or so, no real rush :)

OK, meanwhile I'll see this patch is merged :-)
