Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9F93ADBA2;
	Mon, 19 Oct 2026 12:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792412565; cv=none; b=I5WmX3FB1oB5CZ0+3LAhiA7aSYNM2DKaEPcqOr30ZIxdnJA5JvICrgv6S6ouc9+7nhl93NcJXwp86h95/u7fWn4KPaS/qH559UNCOTXYaAhPI+2Hxk+tpwmwSHRUGfm1w/Cnv/Wb+VlGBy5Wnakb1msLGvShNkrGKO3Vo3ivv8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792412565; c=relaxed/simple;
	bh=hRcaTeGza4tnHc/I82ceXfzAzaQzdhgFCOuEexA/vYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JtofkNcB290LdqOpT0f3/iHbwbrPiBs1H0oVgK5DRdlGJJVmELbI6aqjOjZ7+JqDK5O31y5c2I5Kh57czuUVVFVkIH/lJP7AXb4XJG0IyMWKT369hgY9hDB/7GvcLZ9GtLFAJYi1VXQ19DHOItRYEGYpRkBXOWLla63IjHqYixs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JVKpS0Fu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JVKpS0Fu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CF4D1F000C4;
	Mon, 19 Oct 2026 12:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792412563;
	bh=42BiGOguczNjCdD8znJYD+rJzBE/in1SlQJ/mDpJd0w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JVKpS0Fuhgjsx7EcPM4mspRCj+cJ13Vr9dyWYi5tZyRgYzdplloZM8dhJPojue0KU
	 gwIqHcEugpnRmbUd+Mk3h+lm1rd8zy0fXmp6IrcwxZ27roljErPraZxk3qIxuHCOVQ
	 qU9dwJmroV6k9ml+ouPWfS0i7KSPRtPZcYbl+zZRv+RYP1R2NE4kzKkUE6OUwm+2cg
	 y2mv0mpUeGiW8xLpsby4FSQhcOicsYUvbYfqD04Ol23Qd1cNg1SZfHlVTV4LthvjBo
	 Zc8ImrnIFb8D3HaBeeXIK51m6AYLCyoAVeVEB3E2kSsOxEqalcNooM9qo+lGo5WmnF
	 X+MyMawaAbgtg==
Date: Mon, 19 Oct 2026 09:22:40 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, 9erthalion6@gmail.com,
	adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org,
	leo.yan@arm.com, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, mingo@redhat.com,
	peterz@infradead.org
Subject: Re: [PATCH v4 0/3] perf test: Per-test timeouts, JUnit XML
 compliance, and snippet improvements
Message-ID: <atYLkAOAGkg1dyIX@x2>
References: <20260929025345.88829-1-irogers@google.com>
 <20261012234724.721224-1-irogers@google.com>
 <as_1Jr1h4qFF_2Jj@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <as_1Jr1h4qFF_2Jj@google.com>

On Wed, Oct 14, 2026 at 02:33:26PM -0700, Namhyung Kim wrote:
> On Mon, Oct 12, 2026 at 04:47:21PM -0700, Ian Rogers wrote:
> > Ian Rogers (3):
> >   perf test: Add per-test timeout support
> >   perf test: Improve JUnit XML schema compliance and completeness

Both are failing to apply to perf-tools-next, I'm pushing what I have
(with 3/3) to tmp.perf-tools-next now.

> >   perf test: Avoid stack trace noise in verbose=1 failure snippets

Applied.
 
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,

- Arnaldo
