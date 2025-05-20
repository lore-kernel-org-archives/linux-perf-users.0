Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B617E1C3C08;
	Tue, 20 May 2025 01:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747705967; cv=none; b=TPT3Lsmj/KTgQR6J+VXp+tMJRluI7nELb/x3HqWdUoJuVEW0ZHXpSZqubzzDeQDoOMFHlQ4YffAWTMGSjBcupsrU0iPJpHwAt2ugquC8mlN1cONO0puvS9i1Rc3HJeX8F7MjE9oAgrWaiOaUSVGQ5qhAkSYIdhx5EqBFBhUJ0kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747705967; c=relaxed/simple;
	bh=7rvK125QqYiLA2+g2nikKbIyGirADh4k9rK/bWO22cE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gSozyk1O+pP2Q4nc1DXcb8dZlgGigH0JcCNPmYXQoxOri1+dSyj1Xm+OawtchLs//hVpCf53ke3Iwim3oLF4M865JvoyKWjjTGalDAY59Q0E+Srq8xMwrfEn9WOiEg7GvWRzNv0v14gukeWz2Owr0gIO0Kd4huQYmSD+3xQJnhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bv9AbFqC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bv9AbFqC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9EC9C4CEE4;
	Tue, 20 May 2025 01:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747705967;
	bh=7rvK125QqYiLA2+g2nikKbIyGirADh4k9rK/bWO22cE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bv9AbFqCAYrqZGnfJyB4wz4YJOkvLpvHhamcSDmUlg33+Vrt235+fJtwn3DmvFCQS
	 B50zaIYaRyG6K8JSZCQNuuTsxX3AdnevEtuZCoLLA8CFgEulW4aZVFWeBkW4BqzpRG
	 ObJXuDPBaD47Rhf+vrJ+dzhQmLL4dQlSjchVnfYJV4Aounr1ZLao2rwNDBQ8zlsBVB
	 SVgsd7QgVUYfv9cFoZxltnwZ+wpS3l5mrYvfkxOKZfKwnRVDmIKSfuFq6DDBxAn7UG
	 q5h/EJ6LJi433s9Li8l7tspTTJmY84SKM4c8bh0h05/r3Ltb0f6ScigFwikciNWTOk
	 oG4NqTc9tOSoA==
Date: Mon, 19 May 2025 18:52:45 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Leo Yan <leo.yan@arm.com>, Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf tests switch-tracking: Fix timestamp comparison
Message-ID: <aCvgbd5dZrF0YJg7@google.com>
References: <20250331172759.115604-1-leo.yan@arm.com>
 <CAP-5=fVsgahBhOEOac52PmL0V+n1jqAxzf7n9PVWgWsxq9TvgQ@mail.gmail.com>
 <20250401091422.GA115840@e132581.arm.com>
 <CAP-5=fUGLy9xGmMO+6PXvfviB4U8Q8O7H3iTSSqEf72vin8gDA@mail.gmail.com>
 <20250402090516.GG115840@e132581.arm.com>
 <20250516153158.GH412060@e132581.arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250516153158.GH412060@e132581.arm.com>

Hi Leo,

On Fri, May 16, 2025 at 04:31:58PM +0100, Leo Yan wrote:
> Hi Ian, Namhyung,
> 
> [ - Mailing list ]
> 
> On Wed, Apr 02, 2025 at 10:05:16AM +0100, Leo Yan wrote:
> > On Tue, Apr 01, 2025 at 12:54:12PM -0700, Ian Rogers wrote:
> > > On Tue, Apr 1, 2025 at 2:14 AM Leo Yan <leo.yan@arm.com> wrote:
> > > >
> > > > On Mon, Mar 31, 2025 at 01:18:31PM -0700, Ian Rogers wrote:
> > > >
> > > > [...]
> > > >
> > > > > I'm reminded of a Java check I wrote for this:
> > > >
> > > > Nice short article.
> > > >
> > > > > In clang -Wshorten-64-to-32 looks to cover this. I'll see if we can
> > > > > clean those warnings up a bit.
> > > >
> > > > I checked a bit and seems GCC has no this flag, but it makes sense for
> > > > me to enable the flag for Clang.
> > > >
> > > > > Reviewed-by: Ian Rogers <irogers@google.com>
> > > >
> > > > Thanks a lot, Ian.
> > > 
> > > I made a small variation to the change in:
> > > https://lore.kernel.org/lkml/20250401182347.3422199-10-irogers@google.com/
> > > to avoid a subtract and just directly compare the values.
> 
> Do you mind to pick up my this patch? :) Our internal CI reports the
> test case 109_Track_with_sched_switch failure daily, I am just wandering
> if we could apply the fix quickly.

Arnaldo is taking care of patches for v6.15.

Arnaldo, can you please take this?

Thanks,
Namhyung

> 
> Ian is working on a patch series for resolving the Clang warning which
> also includes a fix [1], if Ian could extract the fix for the compar()
> function in switch-tracking.c, this either would be fine for me.
> 
> Thanks a lot for your helping!
> 
> Leo
> 
> [1] https://lore.kernel.org/linux-perf-users/20250401182347.3422199-10-irogers@google.com/
