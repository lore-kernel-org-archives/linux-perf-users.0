Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF3F8175F;
	Fri, 16 Aug 2024 17:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723829501; cv=none; b=Yy0GBGXLY2Knh+1hW8br9a5et1JEWRhdwAdZOwUMiDynBI2hUnN/BdDFwjazgs0TKIzAtLz313/ALuqCyg8lKmobCT7d45uQp7lkZc1Bo9AtVz1tgqaAql8PSQ5gNVxjmJ/v/ht36YTAAK2sMy2d72N2i1bwV9jlgX4FHqTAmvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723829501; c=relaxed/simple;
	bh=SfEzZM+SRzAxJmCjIXHzBLpMu427s1d9B2TcFaQN4Xw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rDbQ5A23A1JUtq52Djq8owIZ3ZGwyhw8O5TRdysADz83SraF3/qxsRGJBkBm73fYiOF2yFBTU1KEENnWdfhCKGrwH7hRGQUVf5tCrOWX7hpdCKRaGantDKvCJiCfcoraqL1iozChU0DRXpIP+/wqQGmCyinvfsHEmbZ6zZQJdKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oicthh54; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oicthh54"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBBA5C32782;
	Fri, 16 Aug 2024 17:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723829501;
	bh=SfEzZM+SRzAxJmCjIXHzBLpMu427s1d9B2TcFaQN4Xw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oicthh54Ypp+/yoT/90GPsdKpzzuw0OUcCQuLu6zNcMIxHShedsZQU/S7hdKTgSdN
	 n8UKDzhE9mlAY/DkUnIh5jLI7VNgG6HLrR+FujAvueJuMZ9wVAb8pXA8QRAizoYQ5o
	 rp03Hb3C6fh5zjBj+9oKztSychnAQtbEZ4qa1wVzqIGNiQF+mBpATdfklaNivF0z+r
	 u+vM3c2O0IJ5UIuU5ZmKWIvpxKh7HlLBeUkwjiPOcG4HyfIlQpCpB1i+ILxlud56Pp
	 jGu4bjrri6ruRwPIOLv2mWDu6opVzedxtDxRuYDX6ic6m4n87HQbihFYQLCRLJ8VXy
	 weZ783bkXq1yQ==
Date: Fri, 16 Aug 2024 10:31:39 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Xu Yang <xu.yang_2@nxp.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	imx@lists.linux.dev
Subject: Re: [PATCH] perf kvm: move HAVE_KVM_STAT_SUPPORT down
Message-ID: <Zr-M-9mJyJ9G51sA@google.com>
References: <20240809115335.540947-1-xu.yang_2@nxp.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240809115335.540947-1-xu.yang_2@nxp.com>

On Fri, Aug 09, 2024 at 07:53:35PM +0800, Xu Yang wrote:
> The 32-bit arm build system will complain:
> 
> tools/perf/util/python.c:75:28: error: field ‘sample’ has incomplete type
>    75 |         struct perf_sample sample;
> 
> However, arm64 build system doesn't complain this.
> 
> The root cause is arm64 define "HAVE_KVM_STAT_SUPPORT := 1" in
> tools/perf/arch/arm64/Makefile, but arm arch doesn't define this.
> This will lead to kvm-stat.h include other header files on arm64 build
> system, especially "sort.h" for util/python.c.

But it's not intuitive.  I think you can include "util/sample.h" in the
util/python.c.

Thanks,
Namhyung

> 
> This will try to move HAVE_KVM_STAT_SUPPORT down, so normal header files
> can be exported to source files on other arch too.
> 
> Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
> ---
>  tools/perf/util/kvm-stat.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/kvm-stat.h b/tools/perf/util/kvm-stat.h
> index 3e9ac754c3d1..92f1191cd462 100644
> --- a/tools/perf/util/kvm-stat.h
> +++ b/tools/perf/util/kvm-stat.h
> @@ -2,8 +2,6 @@
>  #ifndef __PERF_KVM_STAT_H
>  #define __PERF_KVM_STAT_H
>  
> -#ifdef HAVE_KVM_STAT_SUPPORT
> -
>  #include "tool.h"
>  #include "sort.h"
>  #include "stat.h"
> @@ -13,6 +11,8 @@
>  #include <stdlib.h>
>  #include <linux/zalloc.h>
>  
> +#ifdef HAVE_KVM_STAT_SUPPORT
> +
>  #define KVM_EVENT_NAME_LEN	40
>  
>  struct evsel;
> -- 
> 2.34.1
> 
