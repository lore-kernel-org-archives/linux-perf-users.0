Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F89B53815;
	Mon, 20 May 2024 13:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716213032; cv=none; b=cJJyGUtlp/UWwdNdvZnkqXo3zpfYpmVXmL02MEjEt30u6Quq0w1fpBch647DZM2Rw2Jyisrtdtmruohvvw0ncxhwB+Opv2HTLZ03Yws72Sgc5+kZq1vHX5m+ojEaIsCPLaU81D1HBRkNopp5iPaR2Q2OW4UDHjmJZbV3akS/PgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716213032; c=relaxed/simple;
	bh=Lx0tA9PUl4u6rsl64pdQUuI6eKpXJDiV5Zbxo3wsfbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fKw2rrFBpaqE5YeaBy6zJbjQuYR1JwhC1MNlgzbIothxTCxqIoA195vPHRgm2c8yGGMKwLt1PO/URyFp7SPqcylBBo0a3lLqJ2CA+wJJc85rlaHwno7kKhjHT3jerWyloZ6WJdm22h7HThZaL2J0HkqQj0rEtPiUdlXGg57dScs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=GnN9zUkx; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="GnN9zUkx"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=C+780rlDaKNA/H8vHY/36D+6Z05m+PymlHPYx7PH0iw=; b=GnN9zUkxwPFpBVPs
	6dZgf3nZdak+FspBPIv1ffgPd8Y7OFaS+TRTvA90+n9Xt3CndHWOmd7+hlEa5Gw/O/6IZ81KN58uf
	JMvtMD7xRS1W8fQjnqH9M8KzBeCpEYNwjCHnHL+BQr9kHfPnYw3P7RWWU2JJSCfIfT3NcGRY20hEU
	Xp5fTVTVboXIX9qOVIv4X8q8AN4DzeyOC2ZWoNNHSYQaQVdQfVEyjTmlgYZ3kySNBP+/pvnZw9jlu
	V+dtVc9SPPgi5iVzDq+vNIyzryhUCnoiwkLLyY+uAslEjwTDcWWaRlVTQAZCnIoS+Ui3dSYIXY03c
	okr4MoBImIKALYSnIw==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1s93P6-001gmf-1X;
	Mon, 20 May 2024 13:50:16 +0000
Date: Mon, 20 May 2024 13:50:16 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
	irogers@google.com, adrian.hunter@intel.com
Cc: linux-perf-users@vger.kernel.org, x86@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf/x86/cstate: Remove unused struct 'perf_cstate_msr'
Message-ID: <ZktVGHl5PVd2hAqF@gallifrey>
References: <20240506004009.770451-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20240506004009.770451-1-linux@treblig.org>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 13:49:15 up 12 days,  1:03,  1 user,  load average: 0.04, 0.01, 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* linux@treblig.org (linux@treblig.org) wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> This looks like it's unused since
> Commit 8f2a28c5859b ("perf/x86/cstate: Use new probe function")
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Ping

> ---
>  arch/x86/events/intel/cstate.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/arch/x86/events/intel/cstate.c b/arch/x86/events/intel/cstate.c
> index 326c8cd5aa2d2..dcf3f152a2a64 100644
> --- a/arch/x86/events/intel/cstate.c
> +++ b/arch/x86/events/intel/cstate.c
> @@ -143,12 +143,6 @@ struct cstate_model {
>  #define SLM_PKG_C6_USE_C7_MSR	(1UL << 0)
>  #define KNL_CORE_C6_MSR		(1UL << 1)
>  
> -struct perf_cstate_msr {
> -	u64	msr;
> -	struct	perf_pmu_events_attr *attr;
> -};
> -
> -
>  /* cstate_core PMU */
>  static struct pmu cstate_core_pmu;
>  static bool has_cstate_core;
> -- 
> 2.45.0
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
