Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF89846F
	for <linux-perf-users@vger.kernel.org>; Mon,  6 Oct 2025 20:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759781867; cv=none; b=hlT91j6Ppp0pBocJZxA1C2SZXPVAVcCaVzaGzyQlszbffCah2qEkfnLFeFxXXG+Jak5752cmdC0NPMeA73PL4lfyW8ov+pX09bhh7Do4JfcVOUmGIDPJ/EW3ez+RatPwiIMCsZE8bJMQqALtf+LMvJCyaIhKtpcgGiO+wDQxPe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759781867; c=relaxed/simple;
	bh=Kgz1As6lGKibGrUEZkNzxRecNvrhot7vv44aboVMfFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TK0xC+2LvS/C/EZDWXjKebHYLjGw9DCNr/IxR2jt/io4z60HWz4W7QkZ9v0mautcevKJ3qNnyNQo4HbhYfFEh77BvYb2/XrmptmUWfrWocJ2btWwjP/hQny5PeDlVbScHb766iggU+51lsJRcjcpOIrbRWK9FpWFC9fhrLOUxhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pvbzQpcc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pvbzQpcc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9BA4C4CEF7;
	Mon,  6 Oct 2025 20:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759781867;
	bh=Kgz1As6lGKibGrUEZkNzxRecNvrhot7vv44aboVMfFE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pvbzQpcc0TB+C+5JPF2dQ9ynzphDdziHGFVLo5lH2RzTqTJIdGvVkRFcNBRRzhrPn
	 sIpidZfrDXr2YLgXtOZJg2f/W1P8v/xh/5nNhy1UxGjDelZVgtwlV8DVeRyXg5CLZZ
	 M9Cjsiw0Nifmi4pZoZDvP/NAtqf+Pi1bRdnnOiSbCtbNPL3vwBWlzhevArj7MvSGCk
	 Hf9i2O9HGbcR7/6Hv1BrK8qSxx8kfVlbdc6UhMd8GDaPXFVzuzLQ45o7Uwl31ojfoz
	 qiQV45TGCZwrNcHLJ3ttnN1/zbXOTtXScgFwnRJJelWNPDSBFIgSd5xqMPwf4hu/+a
	 lMoU847L2pF2A==
Date: Mon, 6 Oct 2025 17:17:44 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Vincent Minet <v.minet@criteo.com>
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf tools: Fix arm64 libjvmti build by generating
 unistd_64.h
Message-ID: <aOQj6AiUd6NaZK-_@x1>
References: <20250922053702.2688374-1-v.minet@criteo.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250922053702.2688374-1-v.minet@criteo.com>

On Mon, Sep 22, 2025 at 07:37:02AM +0200, Vincent Minet wrote:
> Since commit 22f72088ffe6 ("tools headers: Update the syscall table with
> the kernel sources") the arm64 syscall header is generated at build
> time. Later, commit bfb713ea53c7 ("perf tools: Fix arm64 build by
> generating unistd_64.h") added a dependency to libperf to guarantee that
> this header was created before building libperf or perf itself.
> 
> However, libjvmti also requires this header but does not depend on
> libperf, leading to build failures such as:
> 
>   In file included from /usr/include/sys/syscall.h:24,
>                    from /usr/include/syscall.h:1,
>                    from jvmti/jvmti_agent.c:36:
>   tools/arch/arm64/include/uapi/asm/unistd.h:2:10: fatal error: asm/unistd_64.h: No such file or directory
>       2 | #include <asm/unistd_64.h>
> 
> Fix this by ensuring that libperf is built before libjvmti, so that
> unistd_64.h is always available.
> 
> Fixes: 22f72088ffe6 ("tools headers: Update the syscall table with the kernel sources")


Thanks, applied to perf-tools-next,

- Arnaldo

> ---
>  tools/perf/Makefile.perf | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index e2150acc2c13..f561025d4085 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -941,7 +941,7 @@ $(OUTPUT)dlfilters/%.so: $(OUTPUT)dlfilters/%.o
>  ifndef NO_JVMTI
>  LIBJVMTI_IN := $(OUTPUT)jvmti/jvmti-in.o
>  
> -$(LIBJVMTI_IN): FORCE
> +$(LIBJVMTI_IN): prepare FORCE
>  	$(Q)$(MAKE) -f $(srctree)/tools/build/Makefile.build dir=jvmti obj=jvmti
>  
>  $(OUTPUT)$(LIBJVMTI): $(LIBJVMTI_IN)
> -- 
> 2.51.0
> 
