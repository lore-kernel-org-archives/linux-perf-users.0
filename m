Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED42314B82;
	Mon,  3 Nov 2025 16:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762187427; cv=none; b=kHopIuHkts8ArNew0GiateTF5Fs0rWcYxNwPW0TvSeRuQNzsjpvvFC6IksPOAghR2OPmN3xTpFZmy/nqxbKa7bT3kEihlBmCZ8Z/jP2S7KKdERCfOGTmP3/W+ooJjl4/xMK8n8g3fcEBh3G+czzH92JN6LHIP48qRnEYg/0+9LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762187427; c=relaxed/simple;
	bh=ZlEa6KKYS6CrKLsUDmwCF6rE0IcLkPcrxlwCy35odTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V2he+BW+pG4DKBGhC4GSngEDml4rdmjgdPr/w7dWo8rjbR3h7DfIe9Acl30orcJdGtoB5Ao10tBPYSBCKme0RABnLZlBdpVA7LxGYhvs6/i7Myhu3HwA26uPKpnBRvygjoCa9olafy73wsEMZyZWWNZKXVLIUky7/o2fuLjJpYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dgq7SrnY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dgq7SrnY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D724C4CEE7;
	Mon,  3 Nov 2025 16:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762187427;
	bh=ZlEa6KKYS6CrKLsUDmwCF6rE0IcLkPcrxlwCy35odTk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dgq7SrnYAPaCRmxBod/0PTmhgTXeyw3kutIRSbQbW1GPwW3MpxjYB+MgEEx8Hlyo7
	 ia4gUfPppCzBsDkE/1i/3zteDwjspCxSQN9PgFtIq7/3cfEwKNnbLISNFlFmos8kvY
	 roWZgwNcn43FZPJz9dQ9Z3mFE62Tp2ySv8+lIq4RP0fdBvwHsg5YuPDr1F+G9l0/In
	 QU/7dgWotX71fhXO0Z+ztwKUwCQOiPSO+Bp/jEe06wScGWvKQk1Av2zz57bWedIrX/
	 CNQMTt6/kfdgheuunWXjkOG/o6gBHU7ukQNck5KPbdzOHSSwMm505A9CKQS/8yksR7
	 TCBlPXtnVs44w==
Date: Mon, 3 Nov 2025 13:30:22 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Leo Yan <leo.yan@arm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-perf-users@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: Re: [PATCH 1/1] MAINTAINERS: Add James Clark as a perf tools reviewer
Message-ID: <aQjYniEKS0ZtYDEB@x1>
References: <aQjCEfiFLJwApdlj@x1>
 <20251103151912.GW281971@e132581.arm.com>
 <CAP-5=fWcjoz_iNyMM6xSqkyDzmOmar-zaejSOn1L6Dta061kEQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWcjoz_iNyMM6xSqkyDzmOmar-zaejSOn1L6Dta061kEQ@mail.gmail.com>

On Mon, Nov 03, 2025 at 08:15:45AM -0800, Ian Rogers wrote:
> On Mon, Nov 3, 2025 at 7:19 AM Leo Yan <leo.yan@arm.com> wrote:
> > On Mon, Nov 03, 2025 at 11:54:09AM -0300, Arnaldo Carvalho de Melo wrote:
> > > Just FYI, I'm carrying this on the perf tools tree.

> > > James Clark has been actively reviewing patches and contributing
> > > to perf tools. Reflect this by adding him as a reviewer in the
> > > MAINTAINERS file.

> > > Reviewed-by: James Clark <james.clark@linaro.org>
> > > Acked-by: Ingo Molnar <mingo@kernel.org>
> > > Acked-by: Namhyung Kim <namhyung@kernel.org>
> > > Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> > Well deserved, James. Congrats!
 
> Great, we need more code reviews!
 
> Acked-by: Ian Rogers <irogers@google.com>

Thanks, added to the cset.

- Arnaldo
