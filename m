Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C71277013;
	Fri, 31 Oct 2025 19:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761937463; cv=none; b=h/9Mq1z63cJpCIpAIMeXtyPYzJfg9HLT2i7uwBiF1Hf0fCBpHmUFiQEqFvvvv1P3i9+G9AL8vFVAAMLrljDgUBiaaJiIDyu2+sM5iGgq+JUEIOZqSNxZ9yU2a9HfaQvXoDk+XeRObHSEX8RurTUUXAr19ARHccQdj3Bp80VgvFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761937463; c=relaxed/simple;
	bh=PlnlB9X5yrrRtzROnExh9iaTA/qyoJqUloV1Xf0DJwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B+DK24lJZXxKRD7zDgX1V7uIrrnw4sdXK1Bh5Drf3AzCiSkcqM6G9vGMDkZGV1dLgER5PLmw+h3oI7+02lsXsYikbjF/4bRmKtDvJ8z8wtCzI5x/P+cHZnUIxRBiMyeUoJU+vSqI9+hyATJbVvwONk9tKAK4KIKy8Fmg+s9jE18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MyldevX9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MyldevX9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DB35C4CEE7;
	Fri, 31 Oct 2025 19:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761937462;
	bh=PlnlB9X5yrrRtzROnExh9iaTA/qyoJqUloV1Xf0DJwI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MyldevX9SeVmg/F1LzF9YbzKjNRoxXF3EnqskiEyH5FqzWlD41AI+ShRLXxyVip6J
	 +r15bCvDNTH2V/IPRlI1RfAZoDwesmCJ2FwrnjLtIpAs9y6RLtGdkBvCKVvbxX/PZG
	 ALGcvW7rHTXdpin7lgbZD2DPwzj7i8b/Z1nOKdM1Shiuc0UQ/gePY1gJfzPHnDlCHs
	 kEWA4g9oj6At3ESYRbZiHNqWU+mijkWLPPMr+gD7dGkUB/FfqdTBrSfYEw6a3TaL1S
	 20v+8hU8xo81VLbQB/IRVWxkwfJSddCsVPVE6h4XDLf5jY0i7/bAyuc28arCe9aqB9
	 mdQWHN+lUBKmg==
Date: Fri, 31 Oct 2025 12:04:20 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: pgnmirror <vacacax16@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>, linux-perf-users@vger.kernel.org,
	zntsproj <vseokaktusah7@gmail.com>
Subject: Re: [PATCH v2] tools/perf/tests/make: use IS_64_BIT for generic lib
 dir
Message-ID: <aQUINHg0w8_BwtG4@google.com>
References: <20251031151114.5642-1-vacacax16@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251031151114.5642-1-vacacax16@gmail.com>

On Fri, Oct 31, 2025 at 06:11:14PM +0300, pgnmirror wrote:
> Use the IS_64_BIT flag to set the lib directory generically for all architectures.
> Previously, this logic was hardcoded for x86/x86_64 only.
> 
> Signed-off-by: zntsproj <vseokaktusah7@gmail.com>
> ---
>  tools/perf/tests/make | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/tests/make b/tools/perf/tests/make
> index b650ce886..64066e011 100644
> --- a/tools/perf/tests/make
> +++ b/tools/perf/tests/make
> @@ -53,9 +53,8 @@ endif
>  
>  include $(srctree)/tools/scripts/Makefile.arch
>  
> -# FIXME looks like x86 is the only arch running tests ;-)
> -# we need some IS_(32/64) flag to make this generic
> -ifeq ($(ARCH)$(IS_64_BIT), x861)
> +# use IS_64_BIT to select lib/lib64 generically for all architectures
> +ifeq ($(IS_64_BIT), 1)

IIRC last time we checked this, some arch/distro didn't have lib64
directory on 64-bit systems.  Are you sure if it'd work on them or do
you have any real problem with this?

Thanks,
Namhyung


>  lib = lib64
>  else
>  lib = lib
> -- 
> 2.51.2
> 
