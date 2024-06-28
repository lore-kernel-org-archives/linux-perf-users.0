Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171F9FC0E;
	Fri, 28 Jun 2024 19:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719603024; cv=none; b=qs/OhD7S2ZWDGwfkACeBDHOilqmNKLlstvZ9U243YXrESEDQ01Dh0nmD960TkMszmCb9zeT0S6BPiMkLvnHf1fODOX2jzJ0S5IRLHsSXocdgSo+gI48ekDpl39jlKwb8wV7SqUhbikNHfqYVHVVPLttBoxxLP66yMDMDNN7CPN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719603024; c=relaxed/simple;
	bh=ye6Xuii5TXxpYf0CfrgPnALJ0r4UWESs4M4nurh1zfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dfkE2ANFbSBqv9zBQOw2CSuhy4ohkxiWLMEFYnfvrB9U9ysMfTdyULbexgj3d5ZPswsJJVT/VHzmQus2rLt3LWDJewIZusFPpn9qaPVzvaPPysz/7bK7YgodymVBg/sZzh+3iCJluW1VJojTqS14h62oxzpyWDfAPyiu2A795Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jnJn2U9V; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jnJn2U9V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24724C116B1;
	Fri, 28 Jun 2024 19:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719603023;
	bh=ye6Xuii5TXxpYf0CfrgPnALJ0r4UWESs4M4nurh1zfg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jnJn2U9V3pDIUpRXYaeIfLw1l6cV3DfVRKA/3+Jdf37cZ87Nde7z7zzhHz4as9er+
	 sLdqQqjQQWGd8XreetEX3Of3AOEy+16BL5FQ02VYNZBiB8dArs3U//NRLikBH0dNob
	 pQ+uT8TsOve5+Unv6/9Alb0op2B2x2AaFW2KlzL+4Kf+IrKrGT3RkkiRAi1Q8pe/q1
	 PBCvqCbcLFPAvGnIQXj9lG3IV4HKM+wA8IYDFgzC2auQTO5neRAzaOmrJLg9L1Nl7w
	 1ZOTggS7ptyJOV46/D35n11s1nUpiRiMqJviV61K0p1tIJOtSzdvrv5jZBea7VVplz
	 GTIb74DjEUydg==
Date: Fri, 28 Jun 2024 16:30:20 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: namhyung@kernel.org, Yang Li <yang.lee@linux.alibaba.com>
Cc: peterz@infradead.org, mingo@redhat.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next] perf: pmus: Remove unneeded semicolon
Message-ID: <Zn8PTKYPAehGaZ2D@x1>
References: <20240628053049.44521-1-yang.lee@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240628053049.44521-1-yang.lee@linux.alibaba.com>

On Fri, Jun 28, 2024 at 01:30:49PM +0800, Yang Li wrote:
> ./tools/perf/util/pmu.c:1776:49-50: Unneeded semicolon

Reviewed-by: Arnaldo Carvalho de Melo <acme@redhat.com>

- Arnaldo
 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=9443
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  tools/perf/util/pmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index c94a91645b21..884eb23445e4 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -1773,7 +1773,7 @@ size_t perf_pmu__num_events(struct perf_pmu *pmu)
>  	size_t nr;
>  
>  	pmu_aliases_parse(pmu);
> -	nr = pmu->sysfs_aliases + pmu->sys_json_aliases;;
> +	nr = pmu->sysfs_aliases + pmu->sys_json_aliases;
>  
>  	if (pmu->cpu_aliases_added)
>  		 nr += pmu->cpu_json_aliases;
> -- 
> 2.20.1.7.g153144c
> 
