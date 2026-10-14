Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA0A3F926D;
	Wed, 14 Oct 2026 10:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791972006; cv=none; b=BdncuY5ZvGiYLeVYh1sHeHH2Y61MLBTbK/VwouKpcTay1r30NbAoRToGYV8xBZEVvz89Ifyns+/VlMW2zadngva2xn2k+Eiz66oFv3umDWmd2HJ5pUEDa+Y2BG8tzsGbmVcSldfxoFGdTLMCW0bEwxse0CpB1yk5I6M0BISdOqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791972006; c=relaxed/simple;
	bh=wJnCGFbIVeEexOeKLX8x3+qa/sOfdB11JY4f3DJDgFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YpjA9kcgLA+pKTn6ib/R11V2N7h+mAiZ5I2v5L/QCRxWFF/oUU/1mM/BCH9h9PGAucgGMVPHA5oWXglp3/wm5WMtIir+ex726v0ItDPHmUNzBkgLzwvhjcdAP5Txqz07UUpA9jSdrJQb2d1fPGXxFOW7SZ5MGn3b4aI+iAO2Gys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=c6LJsDnq; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="c6LJsDnq"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=6DjRcb5XHkDsYkqUF5LN5ytYR+eEnhS9lPG5XrhT6Cs=; b=c6LJsDnqONpcCQgrKq0s06JoyJ
	eQQTHYv7wDhun6gGBSTQ8Rg4O5zd/DUBv/QPjPS8cMKffzy1yfIhcaHJRZuvZqqu437HsUj0+llTa
	evpUefflu10zigNikGmhxtAOzTNLPaE0yXoqAW4+odHGxn/DNLuz9CLfVVQGJZuHoe+Jdksw0OsmD
	gDPGCxli306AfeHYjZtd0cXKTM1lsiK6xVk6jj9/08j9t+EFYpcRYQp0mnr/lF3bBsKHpeuFyfFcB
	GSw/f103WiZ7DrQL6QEgwq9C4xuLvAp/W0HGGEsDK67aoRp/nZVwc991cQlBsoOHXsACtabQG/OLy
	bXjvOGCw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xGvm7-0000000GboX-1DQe;
	Wed, 14 Oct 2026 09:59:55 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id D5B9230063F; Wed, 14 Oct 2026 11:59:50 +0200 (CEST)
Date: Wed, 14 Oct 2026 11:59:50 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Ian Rogers <irogers@google.com>
Cc: Bart Van Assche <bvanassche@acm.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Marco Elver <elver@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Lorenzo Stoakes <ljs@kernel.org>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v1 01/10] compiler-context-analysis: Avoid unused
 parameter warning in _context_unsafe_alias()
Message-ID: <20261014095950.GB4121339@noisy.programming.kicks-ass.net>
References: <20261013182458.1234616-1-irogers@google.com>
 <20261013182458.1234616-2-irogers@google.com>
 <871bf440-5b43-4d63-83f8-15ba96719fa6@acm.org>
 <fb2f83ea-cbe4-40a2-bbb3-bf2884ad8e05@acm.org>
 <CAP-5=fW0eOoWmN7kRUhCOVKvYsGs1fvqC746_HVa41MzjcOs-Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fW0eOoWmN7kRUhCOVKvYsGs1fvqC746_HVa41MzjcOs-Q@mail.gmail.com>

On Tue, Oct 13, 2026 at 03:59:44PM -0700, Ian Rogers wrote:
> On Tue, Oct 13, 2026 at 3:47 PM Bart Van Assche <bvanassche@acm.org> wrote:
> >
> > On 10/13/26 12:44 PM, Bart Van Assche wrote:
> > > On 10/13/26 11:24 AM, Ian Rogers wrote:
> > >> Assisted-by: Antigravity:gemini-3.1-pro
> > >
> > > I think this should be changed into Gemini 3.1 Pro. I don't think that
> > > the "Antigravity" part should occur in the Assisted-by tag.
> >
> > Has this feedback been noticed?
> 
> It was noticed but it was clearly wrong. The assisted-by line was
> expected to be AGENT_NAME:MODEL_VERSION but in:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/Documentation/process/coding-assistants.rst?id=816d9992d9ed434ec52cfbd63080d518e535a41b
> it is now requested to just put LLM. I can update this in v3.

The tag is going away.
 
