Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE00EC5
	for <linux-perf-users@vger.kernel.org>; Sat,  1 Mar 2025 05:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740806473; cv=none; b=jWwy2esstd6nwu3mznXtJX367ekMeG3hhcxicQ/Bl1HAm6nr4ZrUXEVNSxwz5wcoi876RozffDFl9SUh1aJVsES3PiX+dOxECjO9dn39Z3k8pRHmDtKtRj8u1FGk/2zJdsRKW2kcTLbWooAzNzk0dgF0MV2t622jjTg7n/9no48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740806473; c=relaxed/simple;
	bh=DHTX0bfvUqsDcD8AtfDgVMzBVJDRma3f5b4ZKB2BCto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c1p0cW74QiKGMtxCekua97lARefn8l2VePZ3rXhZ/t7HnXrpFqiIx5oFj676R6xpiZ0SXA5ynVZxT+BvhjmPJBFEND/I48ZbM5XChaFchKPbPffE4TKCx3t2WzNLua+rT11viPLNy7IQlD91C7czRgt6MPjl0ghc5lcUQypZFSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fRQzY8f/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fRQzY8f/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAE38C4CEE5;
	Sat,  1 Mar 2025 05:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740806472;
	bh=DHTX0bfvUqsDcD8AtfDgVMzBVJDRma3f5b4ZKB2BCto=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fRQzY8f/iTwtrRw/Lvv0Cz0FtE4dz+WGtMQC5zrXaF2tyZO6K63LTCjOXX1slg6yM
	 3DpKoFOlB7Xt8i5JB8mQKh4Q0t0upq/U4sXGZyJJosqBmsu7j/+FCLgIn+4L8C1FXa
	 D1fY/M+tEm/Wx5CZRwwOt1GKvdSsauMuk6gG7vq6/W/64emvMfFqzCi+oMSZfoDqKR
	 GPbRC0b5pci9wfS5Vno1LkjJyPI5txES8v/FIWDwRi7UE2AdYWIeOcGktrXj5wxpiC
	 C75RbhgWIQD1f8kqaKy2N0QDa9iG/tzLu3oeDsKCgAWP7nLyHrDFQN7hXnx///pzyA
	 2jP3kJA2f50cw==
Date: Sat, 1 Mar 2025 05:21:08 +0000
From: Will Deacon <will@kernel.org>
To: Yuanjun Gong <ruc_gongyuanjun@163.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/1] drivers/perf: Add check to ida_alloc()
Message-ID: <20250301052107.GA27474@willie-the-truck>
References: <20250228031712.3743224-1-ruc_gongyuanjun@163.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228031712.3743224-1-ruc_gongyuanjun@163.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Fri, Feb 28, 2025 at 11:17:12AM +0800, Yuanjun Gong wrote:
> Check the return value of ida_alloc in case it fails.
> 
> Signed-off-by: Yuanjun Gong <ruc_gongyuanjun@163.com>
> ---
>  drivers/perf/fsl_imx9_ddr_perf.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/perf/fsl_imx9_ddr_perf.c b/drivers/perf/fsl_imx9_ddr_perf.c
> index 843f163e6c33..143103331edc 100644
> --- a/drivers/perf/fsl_imx9_ddr_perf.c
> +++ b/drivers/perf/fsl_imx9_ddr_perf.c
> @@ -790,6 +790,11 @@ static int ddr_perf_probe(struct platform_device *pdev)
>  	platform_set_drvdata(pdev, pmu);
>  
>  	pmu->id = ida_alloc(&ddr_ida, GFP_KERNEL);
> +	if (!pmu->id) {
> +		ret = -ENOMEM;
> +		goto ida_alloc_err;
> +	}

If ida_alloc() fails, it returns an error code, not 0.

What prompted you to write this patch?

Will
