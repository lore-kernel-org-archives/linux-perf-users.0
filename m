Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B4133E37A
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Jul 2026 05:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784784497; cv=none; b=u5TocJD9E8PiZW6Eg1Clmp/LWQNFIvw6wkeWTxU+2+JNRiHMKH0MdMD98jI4VnrY9oLjW1VBFMcLBNkeV1qHIEF98WyJbW4LckskK+VGU1665X9jSRUUQMgGFH26PsNLI+LXA2PHsWQMDiT5XXZPYqZ1B28LbCIo1BGG01ocFeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784784497; c=relaxed/simple;
	bh=YqvtLlIUGuRaIlR4KUCZGPgt+160EsVF2nG09/lqx1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nAEx85/XCFUqP7H9gZiffg3aekCxAYb6/2V9TgYlSKH2s+fxE+RA6kKNnHyKNYJlszIRtXEMcIO7uLsr/6quUwPTma2OKqbryfGabXuyaQQcVeGbL12pQiNsHwl4DjkbUQAn5TXdCozzMqYXPVCf4xalJkaGSkNLIqSXGCNDD3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nKuMdWf/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nKuMdWf/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBF881F000E9;
	Thu, 23 Jul 2026 05:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784784496;
	bh=AvXNFX9yPA+0meZGTZJEzoWaYZ2xcwRR6leDgty4BnY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nKuMdWf/3DsGy5VMceurlodb0rUxuRkJ3kFQCT+ZPDMNhnszDbPvjObD1yUv3wUoR
	 buLKsgI1aVHeptG9jZOq0ZtRSHlAS+Sy4iZpkDUTxb6Z04mqnONRg/qKYah9o9IJHT
	 HN1Zm1YprVqFm/5WjNKVDR0NfBwjsme6y4eCC9NfKNp3qhKgBXfRJahTRpN15kfLYs
	 B2USHZBK6CadAaHDeD+e4DMcKdLu29NumiJI9f7aH+lZbAWm5x6tjJCIDri8R08yJw
	 VmN6faJhJ1wEn6Zt1rsNGjnjp8bwKl1sgJ8NFE71vj7E6DIfgxHTvk+e7pjTwYrikm
	 qVVZ47GJgKh8Q==
Date: Wed, 22 Jul 2026 22:28:11 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Melo <arnaldo.melo@gmail.com>
Cc: Ian Rogers <irogers@google.com>,
	linux-perf-users <linux-perf-users@vger.kernel.org>
Subject: Re: Getting positive, and not just negative, Sashiko reviews
Message-ID: <amGmayOYWbL_Uhny@google.com>
References: <CAP-5=fVpPktV2Y8XYxOMpZuY1oYQMwxmwqtaphRG4i6qkSVZyw@mail.gmail.com>
 <E034E1D9-D2EA-428C-AD7C-A8F40B2E0E52@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <E034E1D9-D2EA-428C-AD7C-A8F40B2E0E52@gmail.com>

Hello,

On Wed, Jul 22, 2026 at 08:30:04PM -0300, Arnaldo Melo wrote:
> 
> 
> On July 22, 2026 7:19:33 PM GMT-03:00, Ian Rogers <irogers@google.com> wrote:
> >Hi,
> >
> >I wanted to give a heads up. I sent out a 1 line email policy change
> >for linux-perf-users to get positive Sashiko reviews, not just
> >negative ones:
> >https://github.com/sashiko-dev/sashiko/pull/363
> >Please comment/complain if this upsets you and I can abandon the PR.
> 
> And it's merged upstream already, let's see how it goes, I think it
> may be a good move. 
> 
> The maintainers summit list discussion (public) touches lots of
> aspects about Sashiko collaboration, we need to take its reviews with
> a grain of salt, but my experience so far is very positive, I've been
> using it locally for perf and pahole development, in a loop with
> Claude code, with very good results.

I'm also ok with getting positive reviews.

Thanks,
Namhyung

