Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7BA32E692;
	Mon,  4 May 2026 23:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777937586; cv=none; b=Ae0UUs4UCI8+lPO3JwzAUpV0OwdOBNy8/oXqDRVuhPzDMIOx0KrjxyuF5uA6zTdt4QzQFE2oNMvH3+DM9XqtAgMSAH31ZTz2qWR2ioJQvUBdrOZgRH4hxOTEkLDvE/h8Orm6U3sTjYjwOjwLspYe8ULMSG59Hc+6EiISGnTq4Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777937586; c=relaxed/simple;
	bh=KCkSlqtQNt18IZ7ftjUPM4U59XnSHVaN4tdkq754WMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XSn51s/0CjKduaBlsVLDmaaXF5/xF8BgpGg2mD+XCW/i/JIrETANgk0S7V1XdSWRqU/ZYreEh5+TQbO9TP7SDd5Dpmvx6B2gl/H+BzYPeeh7sUo3nxyeD14auleZbj2Z8usDaPVlBIUXyvC8FRdyBvH4cn59oCm/Q/RX+JAe0vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mI7xm/RW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mI7xm/RW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E302C2BCB8;
	Mon,  4 May 2026 23:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777937586;
	bh=KCkSlqtQNt18IZ7ftjUPM4U59XnSHVaN4tdkq754WMk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mI7xm/RWW4G1e901lyciKSKaVRZpAORPqkolu84skjf793pI8DDEh1Hs0PxS2bZPz
	 fraHnSoPAUEmsCgCY/VfOOA640/EfM2PUwKXTtaDIwtjweBicUh58MJv0JYSCQp2YL
	 E+Nh/q868kWifpPUsM9cctTTUF3gWVXE7cvVEed09lvwhFSSR86XxZIfOfmauAAgT7
	 jxQF1u2HxEfcJvwYzHFA0xdlf4ioGwZiPwc/d9RgriAMjq/GO6hcc7cy0n5vfzV2GB
	 dSXCNr4xvGVJYleAEnt8P1jfBY5pGkbcP+L3tp+8Lc+FT4MyuPFDcsmar2LUPNxs6X
	 zpIb47HhjsQMQ==
Date: Mon, 4 May 2026 16:33:02 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: sashiko@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 3/3] perf build: Remove NO_GTK2 build test
Message-ID: <afksrvsISrVFqD_p@google.com>
References: <20260504062758.92001-3-namhyung@kernel.org>
 <20260504064800.8E66FC2BCB8@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260504064800.8E66FC2BCB8@smtp.kernel.org>

On Mon, May 04, 2026 at 06:47:59AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The commit removes the `NO_GTK2` test cases but fails to add `make_with_gtk2` to the `run` list, leaving the opt-in GTK2 build entirely untested.
> --
> 
> commit a080179ce5f6a893edba859d130afb3b6367e133
> Author: Namhyung Kim <namhyung@kernel.org>
> 
> perf build: Remove NO_GTK2 build test
> 
> This commit removes the obsolete NO_GTK2 build targets since GTK2 support
> was previously made opt-in. It updates the build-test configuration by
> removing make_no_gtk2, make_no_ui, and updating make_minimal.
> 
> > diff --git a/tools/perf/tests/make b/tools/perf/tests/make
> > index 6587dc326d1b..dbd7c86a2dcc 100644
> > --- a/tools/perf/tests/make
> > +++ b/tools/perf/tests/make
> [ ... ]
> > @@ -153,8 +151,6 @@ run += make_libperl
> >  run += make_no_libpython
> >  run += make_no_scripts
> >  run += make_no_slang
> > -run += make_no_gtk2
> > -run += make_no_ui
> >  run += make_no_demangle
> >  run += make_no_libelf
> >  run += make_no_libdw
> 
> Does this leave the GTK2 build entirely untested?
> 
> The commit message states "we need to pass GTK2=1 to enable it. Let's
> update the build-test configuration for that."
> 
> However, after removing these targets, there doesn't appear to be a
> corresponding addition to the run list (such as run += make_with_gtk2)
> to actually test the opt-in GTK2 build path.

This is handled separately in tools/perf/Makefile.

Thanks,
Namhyung

