Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D14C4683
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Jun 2025 20:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749240437; cv=none; b=LjyxOTejwOp/oDnb9GGSB3tdKw/zqsiR5GhwVO//294RJWbLQBaDMrmfHkoE6hFXDVu6mJrk3M+chJ7Spoz4mLHZEytxZx/pigyUphxRM9PgAet0npdvHzHSXgDdoETvjytY5agb4eV3sg7UVCERKTxXzPV+TXAmB36IU9RvSzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749240437; c=relaxed/simple;
	bh=DPhk/usmgDzQp5BjqCyCDbs8x8mHXHde2y28VZELGVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UvS9oNFlJsb+0nhDpWnTFJJ0DwKDdW59XVkos9OHxcubGUf0b+J5kh4RXKtzES19UusE471nDQybwnCZDrv01eBXL0HXoHRuly3vOlqKnnUauR8ZVwnlx6TSdZfUCGnBYq07pADRlpL0DLD9QhueTjaMLKd82pYm16u/XZpzzI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ko5FV5tW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ko5FV5tW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76E50C4CEEB;
	Fri,  6 Jun 2025 20:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749240435;
	bh=DPhk/usmgDzQp5BjqCyCDbs8x8mHXHde2y28VZELGVU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ko5FV5tW8luy0sdrIGhXPtLj8nkvs86/NU/BvrCa4Ye2EzEleYH2KeHnzBLGtT+IC
	 qHTXaA90NftIczSzF5RjbWTekEVwpIxphL2Nn8pyzkYiISuIwwqdTG/tVIjAnbPzHu
	 aL5WLlLlOmumj3/DP9ea409NkXqx6CWUjiMdyPStjPywIYxYTan28Nl0Z+aGqv9Tm+
	 I2WlhheEQpPEAnHjUCOXbIn48FksasfviGAyRT853CnlPxCiXxIbKWDXY42xVBFQ5N
	 WKlL8DN7fopBNs/x3HelxZvun4WOdNuTR4uW8me/H87Tbb77Ibq1y47zFijW5ZRt9q
	 FF6D81L0jqhcQ==
Date: Fri, 6 Jun 2025 17:07:13 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Michel Lind <michel@michel-slm.name>
Cc: linux-perf-users@vger.kernel.org, James Clark <james.clark@linaro.org>
Subject: Re: perf-tools v6.15 tarball not uploaded?
Message-ID: <aENKcVeLE2Hg3b-2@x1>
References: <c5ac84be0a119d3dd432edf36196d07ad562b34c.camel@michel-slm.name>
 <aEHylyR4hGaqZ6C8@x1>
 <a4ac0d06699b0d69262953ce49c740d66590e05b.camel@michel-slm.name>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4ac0d06699b0d69262953ce49c740d66590e05b.camel@michel-slm.name>

On Fri, Jun 06, 2025 at 02:59:27PM -0500, Michel Lind wrote:
> On Thu, 2025-06-05 at 16:40 -0300, Arnaldo Carvalho de Melo wrote:
> > On Thu, Jun 05, 2025 at 11:24:50AM -0500, Michel Lind wrote:
> > > Hi Arnaldo,
> > > 
> > > I noticed the kernel.org mirrors don't have perf tarballs newer
> > > than
> > > 6.14.0 -
> > > https://mirrors.edge.kernel.org/pub/linux/kernel/tools/perf/
> > > 
> > > Will they be uploaded soon? Presumably I can just generate the
> > > tarball
> > > myself for now from the Git tag.
> > 
> > Its there now:
> > 
> > https://www.kernel.org/pub/linux/kernel/tools/perf/v6.15.0/perf-6.15.0.tar.xz
> > 
> Thanks! This works great on x86_64, on arm64 it's failing because some
> files that are needed to generate unistd_64.h per James' commits
> starting Apr 29 are not there.

Humm, the tests are made on x86_64, i.e. the tarball ones that use the
MANIFEST file to create the tarball and then test it...

Lemme try on my rpi5, and I think I hit it before but forget about
following up on it :-(
 
> (I tried copying the files that show up in the error log, but
> eventually hit a wall - for the Hyperscale build I'm going to get
> around it for now by just generating the file on CentOS Stream 9 and
> Stream 10 VMs, but I'll try soldiering on a bit to get this fixed
> properly next week)
 
> These are the files I had to add so far for those curious
 
> # needed to build uapi-asm-generic on arm64, see
> tools/lib/perf/Makefile
> Source1:       
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/plain/scripts/Makefile.asm-headers?h=v%{tag_version}#/Makefile.asm-headers
> Source2:       
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/plain/scripts/Kbuild.include?h=v%{tag_version}#/Kbuild.include
> Source3:       
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/plain/include/uapi/asm-generic/Kbuild?h=v%{tag_version}#/uapi-asm-generic-Kbuild
> 
> ...
> 
> %ifarch aarch64
> cp -p %{SOURCE1} scripts/
> cp -p %{SOURCE2} scripts/
> mkdir -p include/uapi/asm-generic/
> cp -p %{SOURCE3} include/uapi/asm-generic/Kbuild
> %endif
> 
> Best regards,
> 
> -- 
>  _o) Michel Lind
> _( ) identities:
> https://keyoxide.org/5dce2e7e9c3b1cffd335c1d78b229d2f7ccc04f2
>      README:     https://fedoraproject.org/wiki/User:Salimma#README


