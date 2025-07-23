Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E837F78F26;
	Wed, 23 Jul 2025 00:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753232189; cv=none; b=XHrvo5LEBRoesAit93a6FTyPK2u7tpSu8VbSqXplJ/wX2KXJrJeIXJNgriB3JYNpviRxaubQbFZgQ/3PfhRk9OydkaM/WTZoAt7CTY1n6IndFfdKl5b2bGAqrXhGGXSZhwUyO7RyaPeWrRcHy962OkXCS94dMReA+gIQsvL49Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753232189; c=relaxed/simple;
	bh=QJxg62QCgXV0R5bA6++p8g8B+F1pTaGEkT3/0NKUVfY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sf5APIvkkFmptontaJAfXUURt0NGZdhojSCiKKUz5Oia0p0GijbEj/2OAHtY06MYVCkvnVZKhaa0bS+MB8X7jlOfeG4IhpWWOw5IdcVu7l/i4dPlAAsvL1pToi2VspHX6I7aZIlPjVBrmHCGzAdlw2DgTz9E5MuiPUZJH0A1/bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=trNTavwP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="trNTavwP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1D7AC4CEEB;
	Wed, 23 Jul 2025 00:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753232188;
	bh=QJxg62QCgXV0R5bA6++p8g8B+F1pTaGEkT3/0NKUVfY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=trNTavwPngyVCZbYzvSByN9aytmcE69e/s8B10RXqWnL4+p/rkYUeND68f5JBiwIw
	 DgkDPurDFO8XpNjIkpCHLfYbBD/cMwW5zFA8IpcqsulhoT5clMAnojs6tFIkt5qGqY
	 poR2DOxCN0CZktzS14CiXQk1kLWgbwYmdIzXSmQRO9uAWQCHx9Ib65T7PzdUNLR8Ad
	 GUYeA2kWVJ7unkF1O8d/rzAP6ohrMGQYIFs2GWgDvF+9OTHV4UYPqzUKPPHNNoS4aP
	 QBc5xr/ysXxcxULoWewswYIYbURWx4Kr/QwtSzjNltzKParjYqQcEqEIgQWKw3RT1L
	 p1xHg1e62lalw==
Date: Tue, 22 Jul 2025 17:56:25 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Bhaskar Chowdhury <unixbhaskar@gmail.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, vmolnaro@redhat.com, mpetlan@redhat.com,
	atrajeev@linux.vnet.ibm.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools:perf:tests:shell:common This file was missing the
 shebang line, so added it
Message-ID: <aIAzOewUz_KtcccA@google.com>
References: <20250722223350.414-1-unixbhaskar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250722223350.414-1-unixbhaskar@gmail.com>

Hello,

On Wed, Jul 23, 2025 at 04:02:24AM +0530, Bhaskar Chowdhury wrote:
> This file was missing the shebang line, so added it.

I guess that's because it doesn't intend to be run standalone.  IOW it
should be included by other files which should have the shebang.

Thanks,
Namhyung

> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> ---
>  tools/perf/tests/shell/common/init.sh | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/perf/tests/shell/common/init.sh b/tools/perf/tests/shell/common/init.sh
> index 26c7525651e0..9e9d4247ada3 100644
> --- a/tools/perf/tests/shell/common/init.sh
> +++ b/tools/perf/tests/shell/common/init.sh
> @@ -1,3 +1,4 @@
> +#!/bin/sh
>  # SPDX-License-Identifier: GPL-2.0
>  #
>  #	init.sh
> --
> 2.49.1
> 
