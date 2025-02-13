Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E792205E06;
	Thu, 13 Feb 2025 05:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739424570; cv=none; b=f3paZus30HSejtWZAyiDLia82PURuQadu+D5Sv6xzBXONWJusVOSLvq9X99xHJDtXSyqMAJiwewLKqS7eyGGOVCLrYkjJi9qvxbxNOTAbZz+w9VBkaGyBqnY9RNgGestjir2mrPodvH2l0lyDskZW4C1jw0+kclO8AGQOXe+MoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739424570; c=relaxed/simple;
	bh=6ZxGRcclQsqfn7duofDY2aCW0LoKtmUEeo5XxD9IVvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rH5rAhYNEmvyq/qLZoeps6dPr1hq8xBIEbafDw9i+sMi++FizG/Wp/cRMynANsdmJe7d9fvU9REf8tJfQB1CS3gtpoSuUZpArdbPKFwHmPOEZvpSdeI9tMqJX/cXc6IwA1U/UQdBHWZs0OWDEqRN8mOP19HtwYOQoTuoR9KsOcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QSCEvkQe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QSCEvkQe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74A69C4CED1;
	Thu, 13 Feb 2025 05:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739424570;
	bh=6ZxGRcclQsqfn7duofDY2aCW0LoKtmUEeo5XxD9IVvc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QSCEvkQee5ozQMWVA0R04SgUm1lMDxhcMUTK8bNKo/Vllur8im/S1mxvlr9sXixdT
	 y40U9/1+nyJUF6sWgFSgvPWQCxQpEo1Nre2Nf6PLwoykl7U8WO1oHPS0s746gy1Wye
	 6nqX5rqrlEr52mqQI46vNHJLTqlZPixMJQKpAoEIvcwRcaOABqw0Bk5jY11nyoR5Os
	 mvW6WsEPQXJp4vp5jH4RyfeiiynZ1HfT6TtKfZIY7zAGU2FOljab0oMYc6Hf/Rebsg
	 5jm7Wj9mnKbnmrqv1sjoUd9s57IddFvjpdQo5uFoXELjus8hzpkvNUmLAljURBOU/+
	 CxzUnkGjsiemw==
Date: Wed, 12 Feb 2025 21:29:28 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Leo Yan <leo.yan@arm.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Graham Woodward <graham.woodward@arm.com>
Subject: Re: [PATCH v1 00/11] perf script: Refactor branch flags for Arm SPE
Message-ID: <Z62DOPuDJ-PrcHQw@google.com>
References: <20250205121555.180606-1-leo.yan@arm.com>
 <CAP-5=fUH6X2F5S5eH+iU+-hT0vNvMKPTqbGt=E9W06sG=MzxEg@mail.gmail.com>
 <20250212085439.GA235556@e132581.arm.com>
 <CAP-5=fX6veqJYbTRfOiOqtpg8Dq+m3nZJRd4zEBCZeNiwB5Xpw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fX6veqJYbTRfOiOqtpg8Dq+m3nZJRd4zEBCZeNiwB5Xpw@mail.gmail.com>

On Wed, Feb 12, 2025 at 08:14:48AM -0800, Ian Rogers wrote:
> On Wed, Feb 12, 2025 at 12:54 AM Leo Yan <leo.yan@arm.com> wrote:
> >
> > Hi Ian,
> >
> > On Tue, Feb 11, 2025 at 02:34:46PM -0800, Ian Rogers wrote:
> > > On Wed, Feb 5, 2025 at 4:16 AM Leo Yan <leo.yan@arm.com> wrote:
> > > >
> > > > This patch series refactors branch flags for support Arm SPE.  The patch
> > > > set is divided into two parts, the first part is for refactoring common
> > > > code and the second part is for enabling Arm SPE.
> >
> > [...]
> > >
> > > Reviewed-by: Ian Rogers <irogers@google.com>
> > >
> > > Built and tested (on x86). A little strange patch 5 adds a new bit not
> > > at the end, but "Sample parsing" test wasn't broken so looks like it
> > > is good. I was surprised the use of value in the union:
> > > ```
> > > struct branch_flags {
> > > union {
> > > u64 value;
> > > struct {
> > > u64 mispred:1;
> > > u64 predicted:1;
> > > ...
> > > ```
> > > didn't get broken. Perhaps there's an opportunity for additional tests.

Probably because it just checks the value as a whole u64, not each
bitfield.  But it seems to test if the value of the input sample data
and synthesized-and-parsed output sample data is same.  So it may not be
important what value it has.

Anyway it'd be nice if any ARM folks can review this series.

Thanks,
Namhyung

