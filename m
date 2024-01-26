Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1DE7F
	for <linux-perf-users@vger.kernel.org>; Fri, 26 Jan 2024 14:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706279515; cv=none; b=iYu6XSEP+i8g1WGsyLpDW68ZMAyP0klrjXdp7xov2X2qwSrFS6VC2cxn7j0lpDx81U03zpmsDztJHEhNuCHt7XRVCfmQxmnlcvmelDFJlEhFsS+CsjgBu+0foNJki7VpqUXxf87IpKaBZz33+QndpvER+WvCLxetVa7bhTbTFew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706279515; c=relaxed/simple;
	bh=Bv9b124wHSpNpXlaGLCyx3qctCxibacEAoC5S9zfano=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gj7yJSAX6MqSErGEGjxRNDQ3wIZ9oRiGmhkzy87b8eQTRbM1zbpXP2wp7KJQ3hGNc7XYZ7+hY61XwZsXY2wPbZCMdCHBaOfEOg/se7E9X+h/0hBJctCKTmkt0KJpeJk6/3vLwfLa7GHNEErkFouK4Bcmg114wZcf8FYOtsZttbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hor1euo8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hor1euo8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8420AC433F1;
	Fri, 26 Jan 2024 14:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706279515;
	bh=Bv9b124wHSpNpXlaGLCyx3qctCxibacEAoC5S9zfano=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hor1euo81HOj5aEo+eezM0zzaDcO61hxH7uXVGLceZLQ6XHI0tOVO94qmgJK4VfAb
	 so8Afu2IKq7wnRvMcFq7dCrFcH7QCSXZwTyrjIu0WCJqUsIOUYVhwBlwNbHwhDPp9U
	 AAcShvBLls8YGGJw1noEINtx8h9f4RrcMy8SnshxJBt6NiwaxcycG5MYo44HNuxG3E
	 MofFbZW9DPzST4Bzihw3oUOUc5Ab2tqWA38DouUjJpYH8NnWHb0RRYS7aitF4NWFvr
	 ZWbuljMM/cV8p52xoVHL7wNDCGE9nzzGovSq3KcQZ6Qdy//XnciUz3ecSh+59oBn8s
	 2Y2POPizjC5vA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 28C63405B2; Fri, 26 Jan 2024 11:31:53 -0300 (-03)
Date: Fri, 26 Jan 2024 11:31:53 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Yanteng Si <siyanteng@loongson.cn>
Cc: peterz@infradead.org, mingo@redhat.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	mark.rutland@arm.com, namhyung@kernel.org, adrian.hunter@intel.com,
	linux-perf-users@vger.kernel.org,
	Sun Haiyong <sunhaiyong@loongson.cn>
Subject: Re: [PATCH v2] tools/perf: Fix malloc call for new -Walloc-size
Message-ID: <ZbPCWRpDg3ryDsH5@kernel.org>
References: <20231204082055.91877-1-siyanteng@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231204082055.91877-1-siyanteng@loongson.cn>
X-Url: http://acmel.wordpress.com

Em Mon, Dec 04, 2023 at 04:20:55PM +0800, Yanteng Si escreveu:
> From: Sun Haiyong <sunhaiyong@loongson.cn>
> 
> GCC 14 introduces a new -Walloc-size included in -Wextra which errors out
> like:
> ```
> builtin-top.c: In function ‘prompt_integer’:
> builtin-top.c:360:21: error: allocation of insufficient size ‘0’ for
> type ‘char’ with size ‘1’ [-Werror=alloc-size]
>   360 |         char *buf = malloc(0), *p;
>       |                     ^~~~~~
> 
> ```
> 
> So, just set it to NULL, silence this error.

Thanks, applied to perf-tools.

Changed the subject to:

  perf top: Remove needless malloc(0) call that triggers -Walloc-size

And the last line of the log to:

  Just set it to NULL, getline() will do the allocation.

- Arnaldo

 
> Signed-off-by: Sun Haiyong <sunhaiyong@loongson.cn>
> Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
> ---
> v2:
> 
> * Refer to Namhyung's comment and set it to NULL.
> 
>  tools/perf/builtin-top.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
> index ea8c7eca5eee..3960c4d15eff 100644
> --- a/tools/perf/builtin-top.c
> +++ b/tools/perf/builtin-top.c
> @@ -357,7 +357,7 @@ static void perf_top__print_sym_table(struct perf_top *top)
>  
>  static void prompt_integer(int *target, const char *msg)
>  {
> -	char *buf = malloc(0), *p;
> +	char *buf = NULL, *p;
>  	size_t dummy = 0;
>  	int tmp;
>  
> -- 
> 2.31.4
> 

-- 

- Arnaldo
