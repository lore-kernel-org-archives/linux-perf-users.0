Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF3A315D53;
	Tue, 10 Mar 2026 15:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773155349; cv=none; b=c1fpy5K9nFfJwBT7eLo1diSDXQWSbAZinOHSgwq/6GKxHL1DlG0f4QGgectrp9Wzqgbzo9zBPig0T2a+puiQB13HQydHeL0lx757s+abgVkan7d9q99Tl8GnKgFZEbgboUnLArfO7KaRv2nxhf+P7zzGwNkN1EZ02pGUvETxfMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773155349; c=relaxed/simple;
	bh=xpu+/Y7IXw7kv7ph2+TBjL6fozsm071ZHQjOXtti3bI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kAEBPw9+svO4Ph4vV2bGR6vEnDOfaMFUmcxf459lj1VVXKOM5Dh1qaFGviuaLNlgj94IYRHLklos9HBD3jMmA60/mj2pSzxPWKUOkilr4hbkQYCl6jSiHwjzWcQksnUrInmgDScdKoCi0pR0zXk6ZTa5JjdaZ7PgUyQcs+q3GGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CJ8dZRa2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CJ8dZRa2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BB1BC19425;
	Tue, 10 Mar 2026 15:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773155349;
	bh=xpu+/Y7IXw7kv7ph2+TBjL6fozsm071ZHQjOXtti3bI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CJ8dZRa2bmw2imx3gmkSFTmWLwxOdWF4i5ig1jBvdk99p5qkpUONjydKwrqMFxTFZ
	 /ElXCdhdU+ogCBNLV+XvGe33ywtB/I2aijgdtuGMyS6JY55oWrkTgVxJctZ/w7N/MP
	 db6HoLQXB8jL932tL7IB3GDDNkDHDE9oJUxmXgD+dRG1XXq47oQcbUu8LQmZ03w2vR
	 hUypMpXeOO+g9RyyLi3qlT94O2aCyhMT9qXp9PuDMSEdhGZxrXIgozcv7Kw0P8dDfd
	 TiJsyjLwSS89MXRc5zxng81/xTIIXWSih5A4SPKvUgskNhAH5C9IMZoz2xetQAxPXF
	 /IpzryJLZbHaQ==
Date: Tue, 10 Mar 2026 12:09:05 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: pcc@google.com, namhyung@kernel.org, adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com, james.clark@linaro.org,
	jolsa@kernel.org, justinstitt@google.com,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	llvm@lists.linux.dev, mark.rutland@arm.com, mingo@redhat.com,
	morbo@google.com, nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com, peterz@infradead.org
Subject: Re: [PATCH v1] perf annotate loongarch: Fix off-by-one bug in
 outside check
Message-ID: <abA0Eb6vdh4pibpg@x1>
References: <20260304190613.2507582-1-pcc@google.com>
 <20260306185306.2017505-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260306185306.2017505-1-irogers@google.com>

On Fri, Mar 06, 2026 at 10:53:06AM -0800, Ian Rogers wrote:
> A copy-paste of an issue fixed by Peter Collingbourne in:
> https://lore.kernel.org/linux-perf-users/20260304190613.2507582-1-pcc@google.com/
> 
> Signed-off-by: Ian Rogers <irogers@google.com>

Thanks, applied to perf-tools, for v7.0.

- Arnaldo

> ---
>  tools/perf/util/annotate-arch/annotate-loongarch.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/annotate-arch/annotate-loongarch.c b/tools/perf/util/annotate-arch/annotate-loongarch.c
> index 3aeab453a059..950f34e59e5c 100644
> --- a/tools/perf/util/annotate-arch/annotate-loongarch.c
> +++ b/tools/perf/util/annotate-arch/annotate-loongarch.c
> @@ -93,7 +93,7 @@ static int loongarch_jump__parse(const struct arch *arch, struct ins_operands *o
>  	start = map__unmap_ip(map, sym->start);
>  	end = map__unmap_ip(map, sym->end);
>  
> -	ops->target.outside = target.addr < start || target.addr > end;
> +	ops->target.outside = target.addr < start || target.addr >= end;
>  
>  	if (maps__find_ams(thread__maps(ms->thread), &target) == 0 &&
>  	    map__rip_2objdump(target.ms.map, map__map_ip(target.ms.map, target.addr)) == ops->target.addr)
> -- 
> 2.53.0.473.g4a7958ca14-goog
