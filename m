Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3355232B9AC;
	Tue, 10 Mar 2026 15:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773155268; cv=none; b=ONVa05H7+Q41naFqM6EFONVnGRhSnZhlz8SAuO/CYkbKH6Kkr04+WGacoNKzenFugtlr678iGGAd3/KhOm6W3b7wBC5gG8OLwhBraAzp0hv0K/1xvHfghy6qb1NegBNmvhDcvsNs/tKk6piG0DP+EHfVOwezLHEiNvu0Jb+RQuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773155268; c=relaxed/simple;
	bh=1JjbbpVAuDTFJr9BiTjIUOKyxdt9pu9MrW0LTOaSxpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EeI5iHA4McR/49su9IhvLXgmaapiXHNs+ZO1OHjBnDX/tZfberzfWSUx6L7QZWcfHI8j5Kye7TQ4+/kPK+hSWdB+a8rKLfhwYSqhdujM0/ywKS032U55a6vkisyPuGpQFxWo932Gon6QBXXQzN2LSQ5csJnoMssH3JD4hiCV5R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CRqJblz5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CRqJblz5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4832DC2BCF5;
	Tue, 10 Mar 2026 15:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773155267;
	bh=1JjbbpVAuDTFJr9BiTjIUOKyxdt9pu9MrW0LTOaSxpI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CRqJblz5VHdSHFerr3HqI7/vzGhbxeSGX6fivsvmQCLytOn/xpAa+Yg8rqzvADRB6
	 SFphmwAK8gcuOnKzbcsKB9NvGb6dkRCxCzlDTvO1APIRI8RtyJD863Amn8p982fs9d
	 +G4Xhm7u7eMZzi67Q/W2cD0bVp2NwtdFiU1ynwL8JVOba8RiU6M0Hm98k2O4lHyZLp
	 FqkcxK1U9nV89Qo7QHKjPlRdeSE5r0t4oI9qIo30TT9bDBZIzAAvel3XLJ8GwYZqsO
	 IDqM5Wwcn6Qa0FZAiOLinECs4Kl/du7HsiLhw2FwJj/BUfF5mK/r3I5/y8c3mpSQe+
	 hBDsqkO1iHnrQ==
Date: Tue, 10 Mar 2026 12:07:44 -0300
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
Message-ID: <abAzwFW5iZk4XWH7@x1>
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

Thanks, applied to perf-tools, for v7.0.

- Arnaldo
 
> Signed-off-by: Ian Rogers <irogers@google.com>
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
