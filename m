Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94C33403F5;
	Sun, 23 Aug 2026 10:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787480583; cv=none; b=iLmctzpv6gDlE/5/S3q3ctGtIlUDTrf3qxdT0i1uWr2Nqu7WfBEZ8LNzsC0Y+hqdVcNCf51xmFJmPbJZlSROK/JG7zE4js0cw9qst3Axq4Va07Jwt86fDsvyjvXahb2FpLZhbr1krHjDqcuDQF/8IF5qrG/z+uBXZc4wi1KjGv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787480583; c=relaxed/simple;
	bh=/1KIzU7jetVq1r/Ds9/JWWR2uNA7gVahDmhqUTe4IvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dNhv91r9WHcvyQOeqjf/0H0z4eupwR0S7jCnRXXfxeH9MprOpxsvL6WxUA/Si0tIKCozlo3ydGD2FR9rBNhKgfKzjPLH89bnAcprwzHw2+iv45oUAUxW0UolGldUAOUFkU8OKOs+/saDZz19UgORV/2IbtjjhAQRB16Ry8YR+qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m9+8Dsyc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m9+8Dsyc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C70A11F000E9;
	Sun, 23 Aug 2026 10:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787480582;
	bh=0AHOK0p0yfFOUtXF2nsKFoOfuc46jMFgwsTtkiSNHWE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=m9+8Dsyczhpsa4kW0bgrsd+dZfwym00UyYaSUzpWzrIxN+ItbqQaTSdZ+MrBTCRtU
	 2Fhsx6oA91CZj0xRxbb80WtIZt59rRs2NXOKRsD7LFpRf51T9XCdNWyI7oPUnXVkeq
	 Ok4TbmQFQa//YMa09g9Rb/D1M3RZW84qxC9QKtSrWcMyD52Gy3rYWUlQwQsh5OxAG3
	 AaLonaPPSzMVZ1pHaXmsV6UcFwKiFBXrg3FixMwEpDrZeVTweshDbNyjDe5YxMuc39
	 rPKIyp0LcBPvhDprxuYn8XHFj+mTGfxLaDpcwzJRi0yx/n2LcbyIH8s8AzWxLxoGPs
	 CcUGnJN2hnbuA==
Date: Sun, 23 Aug 2026 12:22:57 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	linux-perf-users@vger.kernel.org,
	Sean Christopherson <seanjc@google.com>
Subject: Re: [GIT PULL] Performance events updates for v7.3
Message-ID: <aorKASsneqj-jpwC@gmail.com>
References: <aoLUyf6R-TBxOgjT@gmail.com>
 <CAHk-=whfHkbCuZ1bZp2+0-+6KjsQxmyJ79StB-a0rO+cZN+3oA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whfHkbCuZ1bZp2+0-+6KjsQxmyJ79StB-a0rO+cZN+3oA@mail.gmail.com>


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Mon, 17 Aug 2026 at 02:30, Ingo Molnar <mingo@kernel.org> wrote:
> >
> >  - Patch series to fix a category of bugs [..]
> ...
> >  - Series to fix various uncore [..]
>
> In today's small pet peeve, you seem to have caught the same pointless
> verbiage bug that I've been editing out of other peoples'
> explanations: I really don't think it adds any value to talk about how
> one issue was fixed by X patches, and another was fixed by a single
> patch.
>
> Just say "Fix a category of bugs ..." and "Fix various uncore ..". The
> important thing is what got fixed, not that it was a "Five-patch
> series fixing XYZ" like some people seem to think.
>
> No, this isn't a big deal. I edit other peoples messages a lot more.
> Some people seem to not understand imperative mood, and keep doing
> that "Series fixing XYZ" thing.
>
> The only reason I mention it is that I don't think I _used_ to do it
> for your messages.

Yeah, so this was indeed a recent change of mine, I got the brilliant
idea to improve the pull request verbiage from the somewhat ambiguous
and perhaps a bit dismissive 'various' wording of larger changes to the
'series' phrasing, which intended to give the (significantly) higher
underlying effort a bit more credit while keeping the description
more compressed (and I tried to only apply it where it was justified,
so a simple cleanup series does not necessarily earn the same weight),
but looks like it's a regression and annoyance, so I reverted the
brain patch ;-)

I'll simply bring back more verbose summaries in those cases, or
use the 'various' verbiage.

Thanks,

	Ingo
