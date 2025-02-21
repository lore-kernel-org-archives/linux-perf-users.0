Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F0421127A
	for <linux-perf-users@vger.kernel.org>; Fri, 21 Feb 2025 14:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740149978; cv=none; b=p9vTQubpu0XHIaZaT3xNvFBrIBBoXV4tmOvUm0ezcUZ2C4nany5pHCLWpU+ci3lFMhidWKO+SSsXIi8UY+luOJxQfteaSwX2Ck863IL3b4dVX09tlZ2uWk3gVmM5FRIc7TaoBDjUpKzuzwXl3RxgCWG8Z3eJaMEB5kBpONyyMwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740149978; c=relaxed/simple;
	bh=IWx10U5hlcjCo42XavA4eCGfnUghawW2mQhwyhSsV2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a84hP7QydMYLI/a4AINoovoTK2MJ80ryy3GL5OIpSa/zcStLPRMGuWzBKVNtpsToAV/jeG2q7cmob+mgIBsuaKcHX13/FrdoMAf353FMsrr7tN8XgT5NrChpgU+0+pVQ36A49kxBbwCb0UOwOpO19CrWWWTc0OOj+FJfg+bzu48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bj3RL9Wi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bj3RL9Wi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE31EC4CED6;
	Fri, 21 Feb 2025 14:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740149978;
	bh=IWx10U5hlcjCo42XavA4eCGfnUghawW2mQhwyhSsV2k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bj3RL9WiYEBPhwaujePQ4YMK9cRD6pYz9hY9TBI3HT9EcFEyidOiaqszLtgza4PMy
	 BSvyAgli+AIxbGxSA663OZGlpNEevIIzK8+VPvVGsHvoSdW4imi6dC7RLZakUOaVU9
	 MSzqUCeoTNmy+NjFHI2vB/JeJfekFkAzOpO9Kgh5+n00BVF3iiz0KZne4Dt8JuMqLm
	 qgCkqxXp3hy1yqkyv6f7yuhc2q0gYU15iSBgf/Bi001Yf7QKbQHNFuVH2iV91jO32E
	 /Cj1ogyKPUoQT3yVeivayF/4poZrvD/BY9whameX2Z2kBVDNTuDww5237THPiPFueV
	 T8bHWa3C0GQhg==
Date: Fri, 21 Feb 2025 14:59:33 +0000
From: Will Deacon <will@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: linux-perf-users@vger.kernel.org, irogers@google.com, acme@kernel.org,
	namhyung@kernel.org, james.clark@linaro.org, mike.leach@linaro.org,
	leo.yan@linux.dev
Subject: Re: [PATCH] MAINTAINERS: Remove John Garry from arm64 perf tools
Message-ID: <20250221145932.GB20567@willie-the-truck>
References: <20250214114646.1444305-1-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214114646.1444305-1-john.g.garry@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Fri, Feb 14, 2025 at 11:46:46AM +0000, John Garry wrote:
> Unfortunately I don't have time to help review these days, but
> hopefully will have in future.
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 25c86f47353d..9e1e906014c7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18539,7 +18539,6 @@ F:	tools/lib/perf/
>  F:	tools/perf/
>  
>  PERFORMANCE EVENTS TOOLING ARM64
> -R:	John Garry <john.g.garry@oracle.com>
>  R:	Will Deacon <will@kernel.org>
>  R:	James Clark <james.clark@linaro.org>
>  R:	Mike Leach <mike.leach@linaro.org>

Thanks for the help John! You're always welcome back in the future if
you find the time again.

Acked-by: Will Deacon <will@kernel.org>

Will
