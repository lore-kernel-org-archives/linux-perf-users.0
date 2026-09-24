Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38213A5E88;
	Thu, 24 Sep 2026 05:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790227411; cv=none; b=mS8iSqP7js9Js+HUzZky4wv5/6L55TaSSiTXuqN0y7XiwG02nizXO4Se+/BMFiGX85tYd2T3cWzxrxPHsLBdTs06qMzIlzvzw2/W7fJXnWcIh5IBMJZTj4jjSHzJIEUFzw8rb1SQL3Oz1JyyopcmLzWftBdc8H2+qHypO7VMm5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790227411; c=relaxed/simple;
	bh=qWUi9QiTNiio3fpXFMjBWsz3Macp6r0q+NNeFlS2eVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f+AldS+J3fskQESX+IhaS3WJJfljv6caTuhsjXl1DMtn+EdgYwH/Z98SjRS1+YgCr5enLtWmarA50SqGBoPOjKA0mBst3E8F+0pXXMXCOgKjVN6ObAEJZy8LaMWFEJNAibYUf8Crewz0qin1oHAJlAxv2tAIDEwpWjfucdORQuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F8q+sYa1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F8q+sYa1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BE5E1F000FF;
	Thu, 24 Sep 2026 05:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790227409;
	bh=m2KsrtT4VFSuanRFo0eUCalCr/XNe9kNgFSsyPxSnMo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=F8q+sYa1/SU3746VQEFRXLc9SkV3tVCdAJ4bStN6tGBx9QqaXhaQArSddiDy8abFr
	 BMbFZ1UlvZ1SGbLd0FXxPIh+qyhSaX6x4FFGPT7ErsVLkc9UH0FAlq6DLbBmjJwRTq
	 xsSPJ9YtPPke6AxV5ZOl+RTnhBdQf/AFk6GJzuKIs/bdBReyw5ZNsaL5n2IhNHg+6e
	 7M72VSe9tY7rELvskPeSGOtuf6+s1rAP+hAIHDYXZLB2Z3IfPsI0QrxQxjrVUeQjny
	 RWBq5mH4sHhUhUBXGhtuZuxZP0pIMvjq2xBxc6ot0PX+6540JsqedPFsUJQ+aLRsnl
	 6QG7JeC0LBRHw==
Date: Wed, 23 Sep 2026 22:23:27 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	loongarch@lists.linux.dev, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf loongarch: Fix discarded const qualifier in
 _get_field()
Message-ID: <arSzzwtLnew2t7VY@z2>
References: <20260924021756.22433-1-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260924021756.22433-1-yangtiezhu@loongson.cn>

On Thu, Sep 24, 2026 at 10:17:56AM +0800, Tiezhu Yang wrote:
> When building perf on LoongArch, the following compilation errors occur:
> 
>   CC      arch/loongarch/util/header.o
> arch/loongarch/util/header.c: In function '_get_field':
> arch/loongarch/util/header.c:31:15: error: assignment discards 'const' qualifier from pointer target type [-Werror=discarded-qualifiers]
>    31 |         line2 = strrchr(line, ' ');
>       |               ^
> arch/loongarch/util/header.c:36:12: error: assignment discards 'const' qualifier from pointer target type [-Werror=discarded-qualifiers]
>    36 |         nl = strrchr(line, '\n');
>       |            ^
> cc1: all warnings being treated as errors
> 
> Declare 'line2' and 'nl' as const char * to ensure type safety. In modern
> glibc versions, strrchr() returns a 'const char *' if the input string is
> const.
> 
> This is similar to commit 7378b6656aa4 ("perf riscv: Fix discarded const
> qualifier in _get_field()").
> 
> Fixes: 492ac37fa38f ("perf kvm: Add kvm-stat for loongarch64")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> ---
>  tools/perf/arch/loongarch/util/header.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/arch/loongarch/util/header.c b/tools/perf/arch/loongarch/util/header.c
> index 0c6d823334a2..46f53a74f71e 100644
> --- a/tools/perf/arch/loongarch/util/header.c
> +++ b/tools/perf/arch/loongarch/util/header.c
> @@ -26,7 +26,7 @@
>  
>  static char *_get_field(const char *line)
>  {
> -	char *line2, *nl;
> +	const char *line2, *nl;
>  
>  	line2 = strrchr(line, ' ');
>  	if (!line2)
> -- 
> 2.42.0
> 
