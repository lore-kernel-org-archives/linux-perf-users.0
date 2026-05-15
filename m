Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4390A346AD3;
	Fri, 15 May 2026 11:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778844621; cv=none; b=BGXFNDLB7l6Wfs02pQmm6YatA+bbjT19KF2ZOgmN6paN7DZsJyjWtoLWFReLFnvvg+Rx2IVI772ixSu6C1Pj7SFynN5HPLMU03Rh9fXc8jZX/rHgqt9/ERF+Vu4Vw6dgdQJxEis85yiVJI81cSZvbhXEQMZ8piVW55rHa/EsRC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778844621; c=relaxed/simple;
	bh=V/RVbsqg5o1Dn2bCT7hAGylh0+eGzei6D+mOtw65sfY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sm92NeugNp/S0tutGg8j+iszWbiYgAo4WS/Xe38Il9AAsYwkt24FqajAp0uFGmUJxU+5ekfC6/riTmnN31X6i2GW0JjHp0eLAqWjRXd18ttfrMuhHEOcMLZ2lVq8+7m8txfWpQ0v2mWXqVH4TbdRlfu/uiVtsV7Usb2hRS4K4PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ITJ3iTrY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ITJ3iTrY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 701BDC2BCB0;
	Fri, 15 May 2026 11:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778844620;
	bh=V/RVbsqg5o1Dn2bCT7hAGylh0+eGzei6D+mOtw65sfY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ITJ3iTrYKbbpYLl3hrZUo9oU+d33eUfR4OhITaVwkH7astQsCmP11R76mtbDHm8rq
	 3OAndfjFaffte+QC7ilGLCXS91AF4BtggGpoWhf2sqawdZipALxah3jcR9rP6prIiz
	 1sgtmMUuoXNv1cCCKOyCgzVvFrRHzEzy2fEft90LbdZEDx/h+fK4FxVNTHDAKgvQ5P
	 0UX91QKg9Q3WZCowtV3QwGaEi28rd332V5F3K79qg8uXj1WBcC1uCwyKY8Vl6k5bub
	 NFIvyqYVF4EV29K7U4OvWeKqzX/WGknmPtduWHRvieqZDTVpO9qoVIkImLv5oqUbtz
	 V3d+GFGPQ9Zig==
Date: Fri, 15 May 2026 08:30:18 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	linux-kernel@vger.kernel.org, mmayer@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	"open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-perf-users@vger.kernel.org>
Subject: Re: [PATCH] perf trace beauty fcntl: Fix build with older kernel
 headers
Message-ID: <agcDysX6_-FunmuX@x1>
References: <20260513192347.4007895-1-florian.fainelli@broadcom.com>
 <CAP-5=fXfD5bkhoufpa3aYU5mO4YiJ3agjG+vyB6KUU=o4vGADw@mail.gmail.com>
 <f06b4732-33f4-4457-9e6b-58ede7590122@broadcom.com>
 <CAP-5=fXfwAXo1_FyS=ZZgtBaP0o5QNxz=1x9EFz+m+4gU8tnZQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXfwAXo1_FyS=ZZgtBaP0o5QNxz=1x9EFz+m+4gU8tnZQ@mail.gmail.com>

On Wed, May 13, 2026 at 04:13:58PM -0700, Ian Rogers wrote:
> On Wed, May 13, 2026 at 2:56 PM Florian Fainelli <florian.fainelli@broadcom.com> wrote:

> > On 5/13/26 13:58, Ian Rogers wrote:
> > > On Wed, May 13, 2026 at 12:23 PM Florian Fainelli <florian.fainelli@broadcom.com> wrote:
> > >> Toolchains with older kernel headers that do not include upstream commit
> > >> c75b1d9421f80f4143e389d2d50ddfc8a28c8c35 ("fs: add fcntl() interface for
> > >> setting/getting write life time hints") will now fail to build perf due
> > >> to missing definitions for
> > >> F_GET_RW_HINT/F_SET_RW_HINT/F_GET_FILE_RW_HINT/F_SET_FILE_RW_HINT.

> > >> Provide a fallback definition for these when they are not already
> > >> defined.

> > > This seems fine but the commit you mention was added to Linux 4.13. Is
> > > there a reason you've run into this problem? The oldest active LTS
> > > kernel is 4.19.

> > The toolchain I am using is still on kernel headers 4.9.x, I am
> > cognizant this is a very old set of kernel headers, this is specific and
> > unique to building for MIPS, our ARM/ARM64 targets are using more modern
> > components.

> Sgtm. I have some libunwind clean up for MIPS that I'll add you to, in
> case it is of interest since I can't test it myself :-)
 
> For this patch:
> Reviewed-by: Ian Rogers <irogers@google.com>

Thanks, applied to perf-tools-next, for v7.2.

- ARnaldo
