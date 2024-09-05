Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361C114B06A;
	Thu,  5 Sep 2024 04:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725509432; cv=none; b=PXiMSUHARryXfjXzIJAqF1qzCigJxsaSTiAz0FzyAlT1bCSaMZtNDJ2YvwGdCPmvyg71oaf9GlVPTZ5l9myzzFam00eF9X68ggvMaG+JSA2g7PD2CRJGERwzAB6/uNRs9LBVBs2CAKoAaZU4Ma7wAErBNkQC0MhioSJMFbItBis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725509432; c=relaxed/simple;
	bh=XXVu+AngkuGuRQYTI2X/8gm5xCwXfgNeMNvAuSRoEEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cpvHma3vXEQB4PkQa4WU+tLLvGxhGxLswjB+rv5+WI8X9qUAjIAXlyfg/TRBTcYIxkABmqqzyXYFHG5ejals6hZo5y/HwtU1kokR6faKfZBMVBNxoojlkyDgaGf0Do05EgOKLPXtP9yuAHwvgkxGLTx+XU+WE3D0WDXNtc5zv1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GMpLgr5I; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GMpLgr5I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D3A5C4CEC4;
	Thu,  5 Sep 2024 04:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725509431;
	bh=XXVu+AngkuGuRQYTI2X/8gm5xCwXfgNeMNvAuSRoEEk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GMpLgr5Io7Xbi/uTe9FkmIJ9Riupje2j17+z/p9yxtU4pSuCOaVBUkkTMUbSo4OIM
	 lmJV1zub+Lrn5jsBRzHZa/pxMuIh9MfNYB/xZXZnCBLWCVevll6NHVfuz+scWsIQBt
	 BDeoNIuVLayEnvt1k6xpInuPRq2cqt8R1CFPoUx8e1R2L8nqFtNm+bjmZJhJ3eaexo
	 sbZeNOOMreg9z+X/PO3QK8V1okXZgLKaGkJuIyUpViuoKZVyY1jKdK7wwvK9c9l86m
	 FomjnwLxFJV7igGYlAHIe/PxZQct82FKrmpsizOCfXw8gGohLUFmkC0dzHuKF7lOn8
	 uIQk/T3cHUf+Q==
Date: Wed, 4 Sep 2024 21:10:30 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf namespaces: check newns before free
Message-ID: <ZtkvNsNvIDQkKTFt@google.com>
References: <20240903091208.7152-1-zhangjiao2@cmss.chinamobile.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240903091208.7152-1-zhangjiao2@cmss.chinamobile.com>

Hello,

On Tue, Sep 03, 2024 at 05:12:08PM +0800, zhangjiao2 wrote:
> From: zhang jiao <zhangjiao2@cmss.chinamobile.com>
> 
> Since newns can be NULL, check it before free
> 
> Signed-off-by: zhang jiao <zhangjiao2@cmss.chinamobile.com>
> ---
>  tools/perf/util/namespaces.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/namespaces.c b/tools/perf/util/namespaces.c
> index cb185c5659d6..49e20e0a567a 100644
> --- a/tools/perf/util/namespaces.c
> +++ b/tools/perf/util/namespaces.c
> @@ -135,7 +135,8 @@ int nsinfo__init(struct nsinfo *nsi)
>  			       &RC_CHK_ACCESS(nsi)->in_pidns, spath);
>  
>  out:
> -	free(newns);
> +	if (newns)
> +		free(newns);

It's ok to call free(NULL).

Thanks,
Namhyung


>  	return rv;
>  }
>  
> -- 
> 2.33.0
> 
> 
> 
