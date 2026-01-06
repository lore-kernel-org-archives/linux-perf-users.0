Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9CC0335557;
	Tue,  6 Jan 2026 11:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767697280; cv=none; b=LyvezR/ejpyURUcvK1RgfUSvh2MRkoR2S4QAgFo9Rj3IXNE2LTI/hRmDvcvS+ZIituTBzg+hs8twIX4y7gIQxYYtlCwCXD+IMlOpacbm+XubRNtEFd0/EITvbwH0mb97Qiep9RVAmBSTwZKB2D6YpTIFcVdWg4CVCCGnj/elLuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767697280; c=relaxed/simple;
	bh=ns7AV7KdtpZWpsiFswjsTDCpROD3BuxQ7Qc6+GFrSGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ee9VyjEfKCCfPzWKjJB6Vi/EwBWBtdkd5l0RDr+bo1JUf12LTjqH5PLtuld+6qf8ZfIMdrQnW0BDYlQArALerzt+RnNw7eZ2ppBHDSgjQ6tKsh2FETr2oposSKqS4iCuQ6LzZs8wAsDxC0ZOUPJJWiYN/k0r2smZS+7/k1t9qDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=r9a1jdYm; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="r9a1jdYm"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=fUMO7SOFqDjMmjplPe/dBxqKnTCEktvk7ucaUMOcMDk=; b=r9a1jdYmGzNV/LDTJYWHkLAuSe
	76mSHo17YC4xExOeMg7MVGPIQbXhnTOAGf+qgj+CMB+X+lg8+ZmDmCYZJTfa4H8+xN3cGA3ee2Emg
	sKe3k1XBoUgFxzUiHijKEUNCbMaxkawsgXM6tWzVOErN99u0qH662J1y0iPRp0xOYXOT32In132vE
	PrGf2AVAkLFuMX1xUSEHDw7TE8Z7oD8gqm/WGB683wYJJ5fR8vMetm7Unk0iH+sVnJiciIVvEHPhL
	BYHrI14pvAk15P0BaR5Qtc5CfY0BMbPl6zaHX1yi2e9WCWMDASdZB3csrei0IK7rMy/sz/sBq8fxy
	b5axszTA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vd4oG-0000000BgWd-1pnW;
	Tue, 06 Jan 2026 11:01:08 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 5DC0B30056B; Tue, 06 Jan 2026 12:01:07 +0100 (CET)
Date: Tue, 6 Jan 2026 12:01:07 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Zide Chen <zide.chen@intel.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Xudong Hao <xudong.hao@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>
Subject: Re: [PATCH V2 02/13] perf/x86/intel/uncore: Support per-platform
 discovery base devices
Message-ID: <20260106110107.GC2393663@noisy.programming.kicks-ass.net>
References: <20251231224233.113839-1-zide.chen@intel.com>
 <20251231224233.113839-3-zide.chen@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251231224233.113839-3-zide.chen@intel.com>

On Wed, Dec 31, 2025 at 02:42:19PM -0800, Zide Chen wrote:
> @@ -1897,6 +1899,17 @@ static const struct x86_cpu_id intel_uncore_match[] __initconst = {
>  };
>  MODULE_DEVICE_TABLE(x86cpu, intel_uncore_match);
>  
> +static bool ucore_use_discovery(struct uncore_plat_init *config)
> +{
> +	int i;
> +
> +	for (i = 0; i < UNCORE_DISCOVERY_DOMAINS; i++)
> +		if (config->domain[i].discovery_base)
> +			return true;
> +
> +	return false;
> +}
> +
>  static int __init intel_uncore_init(void)
>  {
>  	const struct x86_cpu_id *id;
> @@ -1911,15 +1924,14 @@ static int __init intel_uncore_init(void)
>  
>  	id = x86_match_cpu(intel_uncore_match);
>  	if (!id) {
> -		if (!uncore_no_discover && uncore_discovery(NULL))
> -			uncore_init = (struct uncore_plat_init *)&generic_uncore_init;
> -		else
> +		uncore_init = (struct uncore_plat_init *)&generic_uncore_init;
> +		if (uncore_no_discover || !uncore_discovery(uncore_init))
>  			return -ENODEV;
>  	} else {
>  		uncore_init = (struct uncore_plat_init *)id->driver_data;
> -		if (uncore_no_discover && uncore_init->use_discovery)
> +		if (uncore_no_discover && ucore_use_discovery(uncore_init))
>  			return -ENODEV;
> -		if (uncore_init->use_discovery &&
> +		if (ucore_use_discovery(uncore_init) &&
>  		    !uncore_discovery(uncore_init))
>  			return -ENODEV;
>  	}

I got triggered by that naming oddity, but then couldn't help but also
fix the lack of { } and then use for-scoped variables.

--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -1899,13 +1899,12 @@ static const struct x86_cpu_id intel_unc
 };
 MODULE_DEVICE_TABLE(x86cpu, intel_uncore_match);
 
-static bool ucore_use_discovery(struct uncore_plat_init *config)
+static bool uncore_use_discovery(struct uncore_plat_init *config)
 {
-	int i;
-
-	for (i = 0; i < UNCORE_DISCOVERY_DOMAINS; i++)
+	for (int i = 0; i < UNCORE_DISCOVERY_DOMAINS; i++) {
 		if (config->domain[i].discovery_base)
 			return true;
+	}
 
 	return false;
 }
@@ -1929,9 +1928,9 @@ static int __init intel_uncore_init(void
 			return -ENODEV;
 	} else {
 		uncore_init = (struct uncore_plat_init *)id->driver_data;
-		if (uncore_no_discover && ucore_use_discovery(uncore_init))
+		if (uncore_no_discover && uncore_use_discovery(uncore_init))
 			return -ENODEV;
-		if (ucore_use_discovery(uncore_init) &&
+		if (uncore_use_discovery(uncore_init) &&
 		    !uncore_discovery(uncore_init))
 			return -ENODEV;
 	}
