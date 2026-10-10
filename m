Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7FE363C43;
	Sat, 10 Oct 2026 19:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791658906; cv=none; b=LdvPbqpo97byshWL47PNwVNr3GKsK2sTFidyqPi4N3PerKCyuljOEoyFQfRIUZ1xxZx7qTMuVJss8RdhyG9wCPuBXb1FKKN/I3s0PKNJC+V8i2DJH4iWA4NT2qhc40CXqqQ6gojxbGd/9sHefkecF28CPayzgFyRRhPLWX66urM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791658906; c=relaxed/simple;
	bh=25JVAP/UW2dJ5YAe9ajdXuBBXqQBC7/QAFQxhO4xl9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qcYOfBbKREvWGgsb9JSBm6mMySHC9CwMDDdtFprazVaivVH15pqRfDTrwSsDvHZKJlpabCKGv1VvepitYi1s/l4UO70gFnFg+qHX1+iDD+TwfmmkAdZ2wmXPVF+DklWgQwKkl6RwuammMF2XNofdylfMHPT3YqapfM4q3vDSoYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DnA9J6bY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DnA9J6bY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B5BC1F000FF;
	Sat, 10 Oct 2026 19:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791658905;
	bh=Itkos3/Vh5tyxsYrO8J7NNRS45742Z89YQlBQ2I7jYc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DnA9J6bYECmeoFzs+T3m4W4KFKAedulhdQnrUlnKhD1fWEEenzEKvyPh7CvdEdkIp
	 BWBcXi9mSpXwVHLgG9EFGrY5HldVLdKLq13r1IayJf5dupgzgf0caV891DiuZ8CTXL
	 B4P2AKhhah4Rer1jdVWjX/vd+U9NKyY5EiTVYZEZGx7UmaW40z1RoIl0WY0tn00BMu
	 S1hPi/GzUWw81vULavdlm8o+wOlqF0p7RspTr8uembBxYsDTsigan0mIA/YeO3mQv3
	 L3ULvUO8a7pekE/uWQDWxpgaQuoqH+BYtq1d12aQQ3hRcJxCihME4xKDIkgk+H9U9+
	 wWZywprTdNb1g==
Date: Sat, 10 Oct 2026 12:01:44 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 2/3] perf symbol: Add missing symsrc__destroy() for
 libbfd
Message-ID: <asqLmOna3bCigzTG@z2>
References: <20261010182439.9732-1-namhyung@kernel.org>
 <20261010182439.9732-2-namhyung@kernel.org>
 <sashiko-outbox-166826@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sashiko-outbox-166826@kernel.org>

On Sat, Oct 10, 2026 at 06:34:56PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] perf: double free and UAF in libbfd fallback logic
> --
> 
> commit 27e7b4b66a3038201c422641092c060f7b466328
> Author: Namhyung Kim <namhyung@kernel.org>
> 
> perf symbol: Add missing symsrc__destroy() for libbfd
> 
> This commit aims to prevent memory leaks and symbol overwrites by destroying
> any pending syms_ss when libbfd successfully loads symbols.
> 
> Closes: https://lore.kernel.org/r/sashiko-outbox-162540@kernel.org
> 
> > diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> > index 6e327eaec8c0e..5e63c3477570c 100644
> > --- a/tools/perf/util/symbol.c
> > +++ b/tools/perf/util/symbol.c
> > @@ -1925,6 +1925,10 @@ int dso__load(struct dso *dso, struct map *map)
> >  			nsinfo__mountns_enter(dso__nsinfo(dso), &nsc);
> >  
> >  		if (bfdrc > 0) {
> > +			if (syms_ss) {
> > +				symsrc__destroy(syms_ss);
> > +				syms_ss = NULL;
> > +			}
> 
> [Severity: High]
> Can this sequence lead to a use-after-free and double free later in the
> function?
> 
> If syms_ss and runtime_ss were both set to point to the same symsrc object
> in an earlier iteration of the candidate debug images loop, this block
> destroys the object and clears syms_ss, but leaves runtime_ss pointing to
> the now freed memory. The object also remains tracked in the ss_ array.
> 
> After the loop breaks, could the fallback logic in dso__load() resurrect the
> destroyed object:
> 
> 	if (runtime_ss && !syms_ss) {
> 		syms_ss = runtime_ss;
> 	}
> 
> This appears to lead to dso__load_sym() being called with the destroyed 
> syms_ss object, which would cause a use-after-free and overwrite the 
> successful ret = 1 result from BFD:
> 
> 	if (syms_ss)
> 		ret = dso__load_sym(dso, map, syms_ss, runtime_ss, kmod);
> 
> Finally, since the destroyed object was never removed from the ss_ array, 
> would the cleanup block at the end of the function trigger a double-free?
> 
> 	for (; ss_pos > 0; ss_pos--)
> 		symsrc__destroy(&ss_[ss_pos - 1]);

Right, I'll fix.

Thanks,
Namhyung

> 
> >  			ret = 1;
> >  			break;
> >  		}
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261010182439.9732-1-namhyung@kernel.org?part=2
