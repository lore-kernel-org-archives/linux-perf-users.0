Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CCD18B464;
	Thu, 16 Jan 2025 21:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737061809; cv=none; b=a+6dBwByygMqg9Hc4kuXlqporxJCIR5Gmh9u+jFKOTmTR7VaQlW8IZF9f302MSRQLdaIjAYLjC065lDaTIO4WOzxlt2hwFbmmWT8nAI0IvgbeAaOTI/lEWaOjGS35CSRfBc8P/ZfhcESmxys3C+UnEPzdJZsFlBYrLx/m2XjJtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737061809; c=relaxed/simple;
	bh=D+p+NDkdTslt+DLYVV6gJCfp3dQ0MkzGmUAE+CHuPr8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tAjVwFIaGYqv57tw0EK413TwA9fUa8VCvf4hSXukpPW5ER3mIWDH16D4/VvVUA78mlPsLsUWQ1qMP8PxUpX2kPqMm4i/OUl9beN2/4VTyaG3A8ZQiWn8GTu2CUNwsrwCA1uzsqnv9s3wq1o4u4W3gFUAbBn1DG9HXSBxTz6wqC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Oh7sqswV; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Oh7sqswV"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=7F31H0PLTiG6yU7uqIlnY+Bu4H2JbnoORsLt9Rl0MWw=; b=Oh7sqswVS9cCjNO0710AL6SRnw
	PubXbsbdoQ3fR9IBjnvSW2yxGR55yVc+5h3aKG7i0aux1pxYovdtoQesPpfFd8o6et4NfWg1Tq/6I
	kkJuACw1m0mPy1Jn9Nw1+mZJid5staeL6aXiab0OI8e+JMjiMTPRQryKBzwjyaBx7RjaN59Pd0j+u
	92erL7vTMwlFGuxUc0MOZd/yb/jOfSYYktLQjJRTFiez+QG2gvJ7iemMimz2r+fB3NNjoSzH4APG/
	OlZNBUavYwg9hpozum5zreR2QU8dOsUTD9+bm2QZ0Fpp+J26SpA3539yuRv7Q3sEUlr+PiDqN3gUk
	NYEef/XA==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tYX7o-00000002Yw1-1Ccx;
	Thu, 16 Jan 2025 21:10:00 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B550E300777; Thu, 16 Jan 2025 22:09:59 +0100 (CET)
Date: Thu, 16 Jan 2025 22:09:59 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: mingo@redhat.com, namhyung@kernel.org, acme@kernel.org,
	eranian@google.com, irogers@google.com, kan.liang@linux.intel.com,
	bp@alien8.de, x86@kernel.org, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, santosh.shukla@amd.com,
	ananth.narayan@amd.com, sandipan.das@amd.com
Subject: Re: [PATCH v4 5/9] perf/amd/ibs: Don't allow freq mode event
 creation through ->config interface
Message-ID: <20250116210959.GB7232@noisy.programming.kicks-ass.net>
References: <20250115054438.1021-1-ravi.bangoria@amd.com>
 <20250115054438.1021-6-ravi.bangoria@amd.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250115054438.1021-6-ravi.bangoria@amd.com>

On Wed, Jan 15, 2025 at 05:44:34AM +0000, Ravi Bangoria wrote:
> Most perf_event_attr->config bits directly maps to IBS_{FETCH|OP}_CTL
> MSR. Since the sample period is programmed in these control registers,
> IBS PMU driver allows opening an IBS event by setting sample period
> value directly in perf_event_attr->config instead of using explicit
> perf_event_attr->sample_period interface.
> 
> However, this logic is not applicable for freq mode events since the
> semantics of control register fields are applicable only to fixed
> sample period whereas the freq mode event adjusts sample period after
> each and every sample. Currently, IBS driver (unintentionally) allows
> creating freq mode event via ->config interface, which is semantically
> wrong as well as detrimental because it can be misused to bypass
> perf_event_max_sample_rate checks.
> 
> Don't allow freq mode event creation through perf_event_attr->config
> interface.

So this is the case where:

perf_event_attr = {
	.freq = 1.
	.sample_freq = 0,
}

Right, where we would then take the period from the .config fields?

So that seems sensible enough; but does this not break existing users?
Or are we lucky enough to not have any users of this borken behaviour,
unlike the earlier broken behaviour that we now have to live with?


> Acked-by: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
> ---
>  arch/x86/events/amd/ibs.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
> index d9c84f1d530f..3e7ca1e2f25e 100644
> --- a/arch/x86/events/amd/ibs.c
> +++ b/arch/x86/events/amd/ibs.c
> @@ -315,6 +315,9 @@ static int perf_ibs_init(struct perf_event *event)
>  	} else {
>  		u64 period = 0;
>  
> +		if (event->attr.freq)
> +			return -EINVAL;
> +
>  		if (perf_ibs == &perf_ibs_op) {
>  			period = (config & IBS_OP_MAX_CNT) << 4;
>  			if (ibs_caps & IBS_CAPS_OPCNTEXT)
> -- 
> 2.43.0
> 
