Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B292175A86
	for <linux-perf-users@vger.kernel.org>; Wed,  3 Jun 2026 19:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780513699; cv=none; b=nVYBex6BRUgIXQyYlhn6ROD5Jv/k4AzdEWojm3NBV81nHu/PxaaNacA2PjxiM6IG9FxUJIDqoWAZrpLdN4hUO4mhN9Hvm1ADdDCqburqEXOqVZM/9rtPP1Cb92AOYPsggO38lb/MHLv/dLbwtbLfybFUdDUaUltcmvaIGI+5jnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780513699; c=relaxed/simple;
	bh=FzXukX66i17zXHLjXVBlFwVoRUKRVmDn8ad5e5Ymk0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gLCgpQBYpR8IvZrsTht52Z3/pCBNmWj4R/XUYj8F8vxBEEOveu12hJlZMnSnAw+Xbg0nOrr8976bkQ/OLglqKAGShPDi2b3cyEDcu2Dz8HvhlFRIU3fuqJjmuaW9KddpmMdHvsvsGP6gAaImwDn2GAQEupo4umzq81UjxRo+PzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PYKky46+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PYKky46+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC6ED1F00893;
	Wed,  3 Jun 2026 19:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780513698;
	bh=3CTIVlXCIO25P8d2Il+eXBfUp6qlmX+j/4XxLOBpL0g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PYKky46+/pUw7Wzaozgb0L+0wlZBKsZvUwkCD0ENdCGiApgDwac+896jMowS7GlTi
	 hrQnWN8yN0mi9NAIkTyqKXgLy5kzBfEwVpiIvw0zeVXU5SpPrhF+fsPiyMehgGskHX
	 XpOv45qNDo8Ez126am96xwP+eypZmgQPZFzKVGgy1GtWmyD30MOPTkvAl8p5OY1R3v
	 dEMJi/T2lcooucVV3LGV5BcBHjxn757HPFzxYXkPvsJeQwGZTx8rIx7g417MNPFdj6
	 zTl8u+gOLlo7vz8lCnH3Z948wLdRtsPdRMBuHJN9tbOtj293PKmlR7dHKaRO1M9yf+
	 7Pf8JmsVC/z2g==
Date: Wed, 3 Jun 2026 16:08:14 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: linux-perf-users <linux-perf-users@vger.kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Subject: Re: Musl and ERR_PTR review prompts
Message-ID: <aiB7ngwE_bNlbb4N@x1>
References: <CAP-5=fWRS46ripc2dMyZfYE_1m6wLnThaVAi3kT5aMFd1ARBiA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fWRS46ripc2dMyZfYE_1m6wLnThaVAi3kT5aMFd1ARBiA@mail.gmail.com>

On Wed, Jun 03, 2026 at 08:36:43AM -0700, Ian Rogers wrote:
> Hi,
> 
> Just wanted to give a heads up that I sent a PR to improve reviewing
> for these two issues with the Chris Mason prompts (which get
> incorporated into Sashiko):
> https://github.com/masoncl/review-prompts/pull/72
> 
> The ERR_PTR guidance follows receiving reviews from Sashiko that
> encouraged the use of ERR_PTR.

I provided an Acked-by there, thanks,

- Arnaldo
