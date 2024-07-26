Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E50B101C8;
	Fri, 26 Jul 2024 14:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722003315; cv=none; b=YpVNJ5ANmj+AbSj60Tc4ovsll4pCH50FeCa8I3SVrLjFenJICgP/LSGfexwqTSOSaMGZDYsW28J8SRrr73z0O1ZuR8RiGVikEYKtdwRzFmOrTHXV/4VgOfzX98y6URr95utwLv0cSToO5u6z2gY4zTyuDLtypdSMYxFHC/02Pc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722003315; c=relaxed/simple;
	bh=YK7f4GEURlSx9QESfNEkBzEeM632DMd4xHj2yB7qYWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lmv/lDzwqRsX2CzE0ui5YzsBxI96KnjtBL3589+vVbeM5pcY8tBl6KSNrjoWKOWz38zk/cmkkKHqepe3ZIkLGsntysQNNCgUe+GrsmlDNZENz4ramz0v1UQgqYKO4gP6hC2tGYO1tzqqLfns1xghXCcCaI6OGMIIS5RPK1bRWTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lZVc6PP8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lZVc6PP8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 092E2C32782;
	Fri, 26 Jul 2024 14:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722003314;
	bh=YK7f4GEURlSx9QESfNEkBzEeM632DMd4xHj2yB7qYWk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lZVc6PP8PXESpntnK32WfKX8jYAHbZgh+dO48T/xHUg+Uf7D9lVd7a+v/slw8n0hQ
	 Vu8R+TBXnF7rwaCI7NLqDspsG7NW5ssQ+oa/N6GuVub/rXDPGho8FJNw60jfuHiXM6
	 fu8c/lle9YXoPSh8sEb/TFFvSdX8Tu2KTtHolWYOXVleKi4tljFlBCzeUewstMua+C
	 WJmUnXy+l4PCMdJgsjltvnjqYWRb5oKNRq9tZbTsuYL1tN2FSmp1Inw2UdQw7h289+
	 /vR36NZVoSwFrrZhhvXEZLYnRPfSd9DvnAM69nWU03QeR0jvnBKsjEEhc6nAfqec5H
	 MDWjl10DspfRA==
Date: Fri, 26 Jul 2024 11:15:10 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Chen Ni <nichen@iscas.ac.cn>
Cc: peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf inject: Convert comma to semicolon
Message-ID: <ZqOvbtX2hehL3E3U@x1>
References: <20240716075347.969041-1-nichen@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240716075347.969041-1-nichen@iscas.ac.cn>

On Tue, Jul 16, 2024 at 03:53:47PM +0800, Chen Ni wrote:
> Replace a comma between expression statements by a semicolon.
> 
> Fixes: 97406a7e4fa6 ("perf inject: Add support for injecting guest sideband events")
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>

Thanks, applied to tmp.perf-tools-next, again removed the fixes.

- Arnaldo
> ---
>  tools/perf/builtin-inject.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
> index a212678d47be..7b4a5d56d279 100644
> --- a/tools/perf/builtin-inject.c
> +++ b/tools/perf/builtin-inject.c
> @@ -2069,7 +2069,7 @@ static int __cmd_inject(struct perf_inject *inject)
>  		 */
>  		inject->tool.finished_init	= host__finished_init;
>  		/* Obey finished round ordering */
> -		inject->tool.finished_round	= host__finished_round,
> +		inject->tool.finished_round	= host__finished_round;
>  		/* Keep track of which CPU a VCPU is runnng on */
>  		inject->tool.context_switch	= host__context_switch;
>  		/*
> -- 
> 2.25.1
