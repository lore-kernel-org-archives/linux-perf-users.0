Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D615E37E5F5;
	Sat, 10 Oct 2026 06:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791614910; cv=none; b=G8FSry6oZLWpFK3VaWapFWPHGR3U1pKemJyS0SqSBMf3IEjVIqq1Iq4VdzW4veg50oPcSthvPxE7dIVnQZ6ADNVvS82pDIv0++7kGTzzBKyAvMvr0UTLdMIHnEkB/ZZ+yJGBE8x3q/Mx0fqLNkqUAj0AcznSyGCn0KXh1MBH8/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791614910; c=relaxed/simple;
	bh=basHzKR+/RnPodebMmWqG+h/lGSwn8ytoY9AJr/s4UY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AWye6tMAUW10UcuAKX9H3rE7X9fIjCXGoNUxvyoW6f++u2xZg7oB0yShZE8GlUTcDAbnWa4MiR9YHTCUEDGQaa7SiBUEVmusbElbomS6YT4ts981NchDkYBRYb5XwgcKPHR0YOT3beCduaj+mfctMysy9Q7BSTtcWYisHYnGrBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LA3rhHmH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LA3rhHmH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D78E1F000FF;
	Sat, 10 Oct 2026 06:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791614909;
	bh=SUpvYjfMaJ0M6jrxLoqe10JiFY1JZNHO4uSBagTyRfc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LA3rhHmHigZQGYrlK2TzeVrQN70m5o+/Ec5f0kLftt7oYdxPpd/tgalG2RI76chMU
	 r7FCEAgzRI19rt9+TtWzLP8S0Bt47Z0/I+qSDgKXEQXf2kCvxVrvQSceEvuW/CHqW1
	 ovwmWtiDWcPguJ4JBReXrZQerfXi31wxygVsjnCkCfIqDriaI1gy30mpehoRmo7JGI
	 0o/VNPP3ZXM8MgENW79FhGemqy3E32/nFdoDS3+Wres0FQKZJ5fFCsYil/MnyYSigV
	 5VgLTcEYs/VR25C70hG8mbLACY3H8QOBRcQeRt/Si/KCM+mzJNzzWJbAeNOc2acfJ1
	 OshtePCrK616Q==
Date: Fri, 9 Oct 2026 23:48:28 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 10/10] perf test: Fix dso data tests
Message-ID: <asnfvJYJzV7DqNaL@z2>
References: <20261006234315.920817-1-namhyung@kernel.org>
 <20261006234315.920817-11-namhyung@kernel.org>
 <sashiko-outbox-162544@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <sashiko-outbox-162544@kernel.org>

On Tue, Oct 06, 2026 at 11:59:03PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Medium] perf test: NULL pointer dereference on dso__new() failure
> - [Medium] perf: NULL pointer dereference when dso__new() fails
> --
> 
> commit 2688b984099e76fca1d46c74193628a04bf63e97
> Author: Namhyung Kim <namhyung@kernel.org>
> 
> perf test: Fix dso data tests
> 
> This commit fixes the dso data tests by bypassing the ELF check for binary
> types so that read/write operations on the test file can proceed properly.
> 
> > diff --git a/tools/perf/tests/dso-data.c b/tools/perf/tests/dso-data.c
> > index 46bc3f5972600..5a027ffab541b 100644
> > --- a/tools/perf/tests/dso-data.c
> > +++ b/tools/perf/tests/dso-data.c
> > @@ -138,6 +138,9 @@ static int test__dso_data(struct test_suite *test __maybe_unused, int subtest __
> >  	dsos__init(&machine.dsos);
> >  
> >  	dso = dso__new(file);
> > +	/* override the binary type for dso data access */
> > +	dso__set_binary_type(dso, DSO_BINARY_TYPE__SYSTEM_PATH_DSO);
> > +	dso__set_bintype_searched(dso);
> 
> [Severity: Medium]
> Will this crash if dso__new() fails?
> 
> If memory allocation fails and dso__new() returns NULL, these newly added
> calls will unconditionally dereference the pointer, causing a segmentation
> fault instead of allowing dsos__add() to handle the NULL safely and fail
> the test gracefully.

Ok, will check the return value.

> 
> >  	TEST_ASSERT_VAL("Failed to add dso", !dsos__add(&machine.dsos, dso));
> >  	TEST_ASSERT_VAL("Failed to access to dso",
> >  			dso__data_fd(dso, &machine) >= 0);
> 
> [ ... ]
> 
> > @@ -225,6 +228,9 @@ static int dsos__create(int cnt, int size, struct dsos *dsos)
> >  
> >  		TEST_ASSERT_VAL("failed to get dso file", file);
> >  		dso = dso__new(file);
> > +		/* override the binary type for dso data access */
> > +		dso__set_binary_type(dso, DSO_BINARY_TYPE__SYSTEM_PATH_DSO);
> > +		dso__set_bintype_searched(dso);
> 
> [Severity: Medium]
> Similarly, does this bypass the subsequent NULL check for dso?
> 
> By unconditionally dereferencing dso, a failure from dso__new() will cause
> a crash before reaching the explicit TEST_ASSERT_VAL() check intended to safely
> handle this exact allocation failure.

Ditto.

Thanks,
Namhyung

