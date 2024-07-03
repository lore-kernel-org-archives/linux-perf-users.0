Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980DA539A;
	Wed,  3 Jul 2024 14:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720018002; cv=none; b=os9pdybH4H3jMQ+DR+X+xC47Vm5Yy3QhWFLIfS2qockemsbEhS/EF2GmGOA1q4uorotfC0SWhhG+OY6alNuP4655KzwezzXUf+Z0EWD54A4NJfDlM5ynz+eCkmSqH4vz/vorIy0HGSBbC/TqCaQLPadf0bm2JHNl+IsE/A/Qeag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720018002; c=relaxed/simple;
	bh=hzswYPDUWMS3NpzqbKRM//ug/16cbXllB+Qg3+i6Vj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GJhBfyaqaTBrT5EppsKe7k9wh0xlEzRHw/eFyj1mj5RC1Txlah5zylWBKPdsVZ6Abhlgjinu+4n9fuUNct4Wh6wTMm+IFa6MLu7GD8vSlO/6GlZrelQwpr6Tuh2nQ6X6InV0aNGa2NFH5yy7s7NfVPCn2sTSmy2BpFzKtzxb/KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fjasle.eu; spf=pass smtp.mailfrom=fjasle.eu; dkim=pass (2048-bit key) header.d=fjasle.eu header.i=@fjasle.eu header.b=nusiYTwA; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fjasle.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fjasle.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fjasle.eu header.i=@fjasle.eu header.b="nusiYTwA"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fjasle.eu;
	s=ds202307; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Q18dbCBSWQqaohXSVfI09EdZ3Fg1nBCG+COXuuXseQc=; b=nusiYTwAyA0dKsGCLBeM7Kj0++
	MmwTSQTVFRvzQB8zZNvGWE4ZKoSu108Rkgp/M4Y2wdxnxCg1ae46AT3rcDjKHHjFdeek+tqI9zDQ6
	G/vXsPLcvbdVzukrWKglv2/zch7QxqO6RaHz5Z/wh+0skthzMJXIm47iNaNIsfY3pm1zyINQylJ0T
	gbnMFRAx0BNGun9K2iiGdVHZXTZ/P8vFOoe8U/a7mhIbSpTz3lBn+Uh98WzK0DQDqr1g43/vkqQxG
	o2cn+waocRX6JF3wW+qJxCXSjv1kbOKX6Ffeur/15ZYoIcmn8OnrVk5/LTm0vm2UGbgJlYzVQUd59
	Noc8mhnA==;
Received: from [61.8.139.249] (port=11010 helo=lindesnes.fjasle.eu)
	by smtp.domeneshop.no with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <nicolas@fjasle.eu>)
	id 1sP1FW-002Obv-GM;
	Wed, 03 Jul 2024 16:46:22 +0200
Date: Wed, 3 Jul 2024 16:46:08 +0200
From: Nicolas Schier <nicolas@fjasle.eu>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] perf install: Don't propagate subdir to Documentation
 submake
Message-ID: <20240703-affable-meticulous-dingo-0d845b@lindesnes>
References: <20240523-make-tools-perf-install-v1-1-3903499e637f@avm.de>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240523-make-tools-perf-install-v1-1-3903499e637f@avm.de>

On Thu, May 23, 2024 at 10:06:40AM +0200, Nicolas Schier wrote:
> Explicitly reset 'subdir' variable when descending to
> tools/perf/Documentation.  Similar to commit f89fb55714b62 ("perf build:
> Don't propagate subdir to submakes for install_headers", 2023-01-02),
> calling the 'tools/perf_install' target via top-levels Makefile results
> in repeated subdir components when attempting to call the perf
> documentation installation rules:
> 
>     $ make tools/perf_install NO_LIBTRACEEVENT=1 JOBS=1
>     [...]
>     /bin/sh: 1: cd: can't cd to /data/linux/kbuild/tools/perf/tools/perf/
>     ../../scripts/Makefile.include:17: *** output directory "/data/linux/kbuild/tools/perf/tools/perf/" does not exist.  Stop.
>     make[5]: *** [Makefile.perf:1096: try-install-man] Error 2
>     make[4]: *** [Makefile.perf:264: sub-make] Error 2
>     make[3]: *** [Makefile:113: install] Error 2
>     make[2]: *** [Makefile:131: perf_install] Error 2
> 
> Resetting 'subdir' fixes the call from top-level Makefile.
> 
> Reported-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Nicolas Schier <n.schier@avm.de>
> ---
>  tools/perf/Makefile.perf | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index 5c35c0d893069..ab15d199e3794 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -1093,7 +1093,7 @@ install-python_ext:
>  
>  # 'make install-doc' should call 'make -C Documentation install'
>  $(INSTALL_DOC_TARGETS):
> -	$(Q)$(MAKE) -C $(DOC_DIR) O=$(OUTPUT) $(@:-doc=) ASCIIDOC_EXTRA=$(ASCIIDOC_EXTRA)
> +	$(Q)$(MAKE) -C $(DOC_DIR) O=$(OUTPUT) $(@:-doc=) ASCIIDOC_EXTRA=$(ASCIIDOC_EXTRA) subdir=
>  
>  ### Cleaning rules
>  
> 
> ---
> base-commit: 29c73fc794c83505066ee6db893b2a83ac5fac63
> change-id: 20240523-make-tools-perf-install-71c3d1f11ffc
> 
> Best regards,
> -- 
> Nicolas Schier
> 

Ping.  Are there complaints, or chances that someone picks this up?

Kind regards,
Nicolas
