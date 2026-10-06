Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D2742CAF6
	for <linux-perf-users@vger.kernel.org>; Tue,  6 Oct 2026 13:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791292420; cv=none; b=BJgs9U2sNXXk+v9M8x98UfilxihotsSHqbGpTfX4jYiirkAI4WDM8TTnq72OIgp5HCJdLU8aWJLMTyWAqeSQeOQXsw7mrMPPF96GQE+hf9yr1df/y41rEFr0nWNqe37zNpLlhV27omfUPdLf591VPwVcyV2NwrEk44Y+ynKGp3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791292420; c=relaxed/simple;
	bh=lFO2ncSddcpojTzsCQnp4OEuNYflGaK4r/Q6mTwyAJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LK9Wo8skvFfnmQ5xApeE7BQ8ZjaG2FVyOD8+m9kCCnAeXV1KqwdKxTtEX4ZpV65Bds2z2GHLRDcYjAbIzrTtc1A/PnyGHx6sKQAyV+8kqIAwQu1SJSBY2Daj5jJpRsq+eUjnRWshTd5qDmFoOKX0yxHF7ePw50/YvTjkLIyc2e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N0fzFVRT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N0fzFVRT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48E131F000FF;
	Tue,  6 Oct 2026 13:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791292419;
	bh=Q67+RGDmNTFBXvF/YkPI0aDuiqbmnMROtxpPFvOhU68=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=N0fzFVRTLuykwduiyDLMtsm6xx3CwaM9M7DLZ9SmOISQgcpFqLjbNuEP9C9XwuFzj
	 KshJK+faGx/P0lWsVP1QrmyvHFoPc4sULs91TdI+vVdql3Qp9R+pGjYgLKJcMZrxck
	 XPJ+6Iewuy4QRLDV+TzLKZLiOfbuC73N7xOB6LUHTFuBgkZKqjwSv1kdNipxSr6toB
	 lG+roZctroipPlTfWp5pBxAf0pD1820t4Gdl1qyD5Qe71MfG6ZrBo7Id8947Ul6RVp
	 vUKfxoOMEAIen+z5zygpEPN2ir2ogLcreeAceb/5Ezputp67N8zWmMZPxqam3RZZBP
	 kXUDHe+sG8rVg==
Date: Tue, 6 Oct 2026 15:13:36 +0200
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Michael Petlan <mpetlan@redhat.com>, linux-perf-users@vger.kernel.org,
	irogers@google.com, acme@redhat.com
Subject: Re: [PATCH 0/2] perf test attr: Fix and re-enable the test
Message-ID: <asT0AIC8cAYy0AKD@x2>
References: <20260924223027.799654-1-mpetlan@redhat.com>
 <asQo_ZqrjOAoJ1ux@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <asQo_ZqrjOAoJ1ux@google.com>

On Mon, Oct 05, 2026 at 03:47:25PM -0700, Namhyung Kim wrote:
> On Fri, Sep 25, 2026 at 12:30:25AM +0200, Michael Petlan wrote:
> > I have noticed that a testcase formerly known as "Setup struct perf_event_attr",
> > later renamed to "Perf attribute expectations test" has been disabled by
> > accident during the move.

> > That also probably led to forgetting to update the struct size, which is now
> > fixed by the second patch.

> > Michael Petlan (2):
> >   perf test attr: Propagate the return value from the test to the
> >     wrapper
> >   perf test attr: Fix wrong size expectation for events
 
> The "Fixes" tag format is a bit different, but otherwise

I fixed the Fixes tags.
 
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks, applied both patches,

- Arnaldo
