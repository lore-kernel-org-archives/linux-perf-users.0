Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A8128150F
	for <linux-perf-users@vger.kernel.org>; Sat, 15 Aug 2026 13:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786799225; cv=none; b=PLnm4FF4t8pDNEBBJJlKbLYLWucrToCveoO9tqR9XElD1noHmkJiIHiFpia8ukWWmu635Z1B7sUg6pNgq9d5gTZNhWi7w58dPVAjtApsOWahaEa/LJSfbbfo8fVVUSr4KGijoreRqwLR/JXRBcSTC7VRRiy0t6JHw4zDrzPopLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786799225; c=relaxed/simple;
	bh=GSch8juP5e4LArReeeyVhaNfw3KQo3wjbP+UHRep3ic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sjC+UAjssnckaFtUSYkraldK6hp8rX68aPDA+dBBH9Wr0gJBbz2d18TlrpsfBq90CbQ6HnQpl9ugxjr6FuLnPRVMCHN2jMCSsLYXAd0fxiNZiEnADqGseKJNYUQvwiOrxm422TExIniohsK7eps407ZF/9B4bYyU2ENCohldwPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ldTfBf2H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ldTfBf2H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E1281F000E9;
	Sat, 15 Aug 2026 13:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786799217;
	bh=zo039R+BXbMpPTTeWrfY2cZis3zctBWfW3buv4PURhY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ldTfBf2HoQolQUnsZoN+RPAgGSF0iRD6I8DTZRX7Q1cq/zBUlbUjuCDkRFqGnDE0+
	 LgIdKEC3QMCnvx2ChpYy4Bdv5jJEvKWwuVXVT0CRwq1toNyTMhVa/q2GUn+DxlnCK6
	 Ev1xzqoJsxfNG0mFi+P9obDPO2NTM/P0nDW7QIguucOVSADJIIF33HzjZUr/cTJNi3
	 IGe0qDbtq0cUHj/DEvjqG1ywvN0+nUWvzQB6ZAXunVx28xo9HwMQsHwe/NAVwbrkEd
	 21KrHpdwTiYkkMsg60bezanvulQniX0HYv5h6JLDxKGWLobtOiAlrAZvbBW9DNM3Ei
	 Mgdn99nfhPVYg==
Date: Sat, 15 Aug 2026 22:06:54 +0900
From: Namhyung Kim <namhyung@kernel.org>
To: Andi Kleen <ak@linux.intel.com>
Cc: acme@kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 3/4] perf tools: Add support for displaying weights in
 annotate
Message-ID: <aoBkboxcdvAEBAHx@google.com>
References: <20260813211109.240689-1-ak@linux.intel.com>
 <20260813211109.240689-4-ak@linux.intel.com>
 <an6zgXlyzPZ_2pI-@google.com>
 <an8p-1D0jNgE8P4T@tassilo>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <an8p-1D0jNgE8P4T@tassilo>

On Fri, Aug 14, 2026 at 07:45:15AM -0700, Andi Kleen wrote:
> On Fri, Aug 14, 2026 at 03:19:45PM +0900, Namhyung Kim wrote:
> > >  	 * symbol and are missed.
> > > @@ -719,6 +720,8 @@ int cmd_annotate(int argc, const char **argv)
> > >  	OPT_BOOLEAN(0, "tui", &annotate.use_tui, "Use the TUI interface"),
> > >  #endif
> > >  	OPT_BOOLEAN(0, "stdio", &annotate.use_stdio, "Use the stdio interface"),
> > > +	OPT_BOOLEAN(0, "no-weights", &symbol_conf.hide_weight,
> > > +		    "Hide weight columns in annotation"),
> > 
> > Can it be just "weights"?  Then we would get --no-weights for free. :)
> > Of course, the help message needs to say differently.
> 
> Sure I can rename it.
> 
> BTW this was the v2 with the broken white space hunks, please ignore or look at v3.

Ok, will do.

Thanks,
Namhyung

