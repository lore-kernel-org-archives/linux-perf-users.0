Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01463AB29C;
	Tue, 29 Sep 2026 20:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790714814; cv=none; b=ty6CqLvCnMdk5ADFkrwrlqoxh090ljqrJT/I9+GoK9qQQx/2KoKbNltskj6Bw1vARpQYoIySdU09FF2VqNp4xpN9mJR+mw3MZvH3p7BJCxuUrpgwVOvJYp2wNwIrcBhawUsTjpQWrFohG8us7qcd/ruCPxX0qqDPDHvEoIMviG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790714814; c=relaxed/simple;
	bh=xnygFywH/QOZB3pT/1UkCjV3wkkhOA+SqvAshJv6tOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BG8dyvVD3HBe5E3dfkEnlN1CtTfHydP+jblbWTKAZoHojtxtiRso/MG2j0d4D4Ap6lbmlhm1e/041ADUHqUCme4pQr1ZLG/VHh4OHTPUTGKyNgwvjSlKoSyqQM2PT9ivECaEH9QFmaIiaLpqUEX7JcIjm8Qx6TGopPxm+vh7KI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P8XUVq7M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P8XUVq7M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B3BB1F000FF;
	Tue, 29 Sep 2026 20:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790714813;
	bh=1LTQm+BvBZp70Ajv/YL+tdfhvFyd+S3ZGkwzHuOAboQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=P8XUVq7MHd+RuJrERTxQbCgkYjf9yQ9ABB7rAU/XjAoGj8QvaJzRF87MFP6+/JeLN
	 sdcyfUCfntd2pZl6/JdQB8icowAHHrijwx2JAiTkjzQmu65GFlgSuuxvX+xl4C4k8+
	 Im9ijQr6neAWA/vFsQ0IZeBJ0rtzUjxF06TNdQPjxE/JfkAdIlZHPDARXrurt1ET0r
	 erWT7pK8MLyRHgRBx2faTCI2yk75ZACpa+4+gmZFcWLNxfQpqoGOkfg2LQaU8tZVxh
	 rPsbBze+0a4Y0tvNQry3bsugLzz05/UvfojL36tSUJk0rVYSz1uyJQ4XgqiLi/DlCk
	 6A4Rab5lbubTA==
Date: Tue, 29 Sep 2026 22:46:49 +0200
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: haghdoost@uber.com, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>, Leo Yan <leo.yan@linux.dev>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf symbols: Don't let a module's last symbol overlap
 the next module
Message-ID: <arwjudbuTiDKo7w2@x2>
References: <20260928-haghdoost-perf-symbols-fixup-module-end-v1-1-0a70d1edd401@uber.com>
 <arv7nGmcDGjt7p7K@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arv7nGmcDGjt7p7K@google.com>

On Tue, Sep 29, 2026 at 10:55:40AM -0700, Namhyung Kim wrote:
> On Mon, Sep 28, 2026 at 04:32:27PM -0700, Alireza Haghdoost via B4 Relay wrote:
> > From: Alireza Haghdoost <haghdoost@uber.com>
> > 
> > symbols__fixup_end() extends a zero-size symbol that is the last one in
> > the kernel or in a module to the end of the next page. On x86 the next
> > module can start in that page, so the stretched symbol overlaps it, and
> > a lookup can return the wrong symbol. For example:
> > 
> >   ffffffffc0c4aa50 t dca_sysfs_exit    [dca]
> >   ffffffffc0c4b000 t __nft_trace_packet [nf_tables]
> >   ffffffffc0c4b0b0 t nft_do_chain      [nf_tables]
> > 
> > dca_sysfs_exit gets end 0xffffffffc0c4c000, and samples in nft_do_chain
> > are reported as dca_sysfs_exit.
> > 
> > This patch clamps the end to the next symbol's start. The ARM case this
> > code was added for, where the next module is far away, is unchanged.
> > 
> > Add a "Kallsyms symbol ends" test case to the Symbols suite that covers
> > the kernel/module boundary, adjacent modules and a distant module.
> > 
> > Fixes: 8799ebce84d6 ("perf symbol: Update symbols__fixup_end()")
> > Fixes: bacefe0c7b77 ("perf tools: Fixup module symbol end address properly")
> > Signed-off-by: Alireza Haghdoost <haghdoost@uber.com>
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks, applied to perf-tools-next, for v7.4.

- Arnaldo
