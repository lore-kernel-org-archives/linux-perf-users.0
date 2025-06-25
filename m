Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601853074AF;
	Wed, 25 Jun 2025 20:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750883230; cv=none; b=ePYcXlx1rXcIhub0F71/Oz1qz1BHm+7joXypTJ5yHPPqPoPLeYpoK29SFSFd8oxm9lwPOo96wDXvCrFCU+7hba5dZiiYHtgDfROyGwNsY5LJ1Jr2zUK7pt5vl/TPDVupXRHptvK2OddzynQ0EJqUyE/lT1Sv48X8fY2SI5FvJ1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750883230; c=relaxed/simple;
	bh=L0XFF8QZAQZVZrSioL4g5TSd6rdXj60OFcoDA1TNzh8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LlVcM8wStY5ahmLeWnyuX29QXOvGrTrZZDcA1tAA+BSrPWZlrZtRvtSFkConQ7A9TAEq6voMLu9CCeR+vDKkTvLtK7slQyPJsl7LEGvehS//aM+lobnXgfW+75mMIcMEXyQ9KRTcU8sz/2elApEW74AmimCdLmGjFnnJX+Myg0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jwcFXe10; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jwcFXe10"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 814FDC4CEEA;
	Wed, 25 Jun 2025 20:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750883229;
	bh=L0XFF8QZAQZVZrSioL4g5TSd6rdXj60OFcoDA1TNzh8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jwcFXe105wP5p4eVBZKF79v17eJnTR4gI1VzSSiZ8hStGNf05zjeDpIwHsmu+xyRa
	 ib69oWPex4p7KfrPaMgO7Vuz8cMeFJsQg3DLwK3p/PDFK9jnXpOp9NuMLOg/G1Bi9G
	 Jk+rvXAlw7mGZEtCl8qw8aZlcJPLgRPylxQ2hJXnga3w9p188EFwgwRScahcjwEkyM
	 FB2FpWkcVBNcfdO++NznKbcch4wS7aNzRNIi2J/ljgHsXbei8aNzdh6Lgcr7b0dkiN
	 DYgP6TYGsYRkN+NLulTLWl5t/yiysYT9m/phSc5rAnsSsZp9MdJQlN9uAqQjC09CsZ
	 cpWZJ++1XV51Q==
Date: Wed, 25 Jun 2025 13:26:34 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Liang Kan <kan.liang@linux.intel.com>,
	Yuzhuo Jing <yuzhuo@google.com>
Subject: Re: [PATCH v2 0/4] perf: Remove libcrypto dependency
Message-ID: <20250625202634.GE1703@sol>
References: <20250614044133.660848-1-ebiggers@kernel.org>
 <aFroVMHTBOB7wfjI@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aFroVMHTBOB7wfjI@google.com>

On Tue, Jun 24, 2025 at 11:03:00AM -0700, Namhyung Kim wrote:
> Hello,
> 
> On Fri, Jun 13, 2025 at 09:41:29PM -0700, Eric Biggers wrote:
> > This is a reworked version of
> > https://lore.kernel.org/all/20250521225307.743726-1-yuzhuo@google.com/.
> > I've changed it to add a new minimal SHA-1 implementation, instead of
> > trying to pull in the kernel's SHA-1 implementation which is not really
> > designed to be extracted into userspace programs.  I also added a test.
> > 
> > Eric Biggers (2):
> >   perf build: enable -fno-strict-aliasing
> >   perf util: add a basic SHA-1 implementation
> > 
> > Yuzhuo Jing (2):
> >   perf genelf: Remove libcrypto dependency and use built-in sha1()
> >   tools: Remove libcrypto dependency
> 
> Thanks for working on this.  But can you please rebase it on to the
> latest perf-tools-next tree/branch?  It doesn't apply cleanly.
> 
> Thanks,
> Namhyung
> 

Done: https://lore.kernel.org/all/20250625202311.23244-1-ebiggers@kernel.org/

- Eric
