Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A47F3B1BC
	for <linux-perf-users@vger.kernel.org>; Wed,  5 Jun 2024 15:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717600474; cv=none; b=t5v4H0j8AgSk9LbIrbTWAHukAzCf72LrK/7yt+SBJcpVYgNOJznvrNZk7tIOQvQ4H6OJM27Hoa72PdT75lsLaQHQpvn50dMfqIg/RYcOgRrjD1GhkYJXun3JXY48NNhJJdEjMZ4VDo23vjf/imnouicU3JYpJEVhfiLpVmB8LXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717600474; c=relaxed/simple;
	bh=inTLBFPiF3QNUYyxrof1SkNpGIxKC3xsYyySQonxahI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LP/BEEIo57WDRjREjDUZnfbW40W2Qfn/VrnYvj7fP13u4aXtHjhBq7x8qFCCYxZJp8iVTWKeTgraGIqEf2OsNZy1yV315anD3XOH4ue+wn4ysVMf+sQfZ0VeQLiDNQeVys1IPyPG/SH+ipir0zHJrRSWqc6inR+pSujmxGGoocc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lsl2zrcW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lsl2zrcW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23A98C2BD11;
	Wed,  5 Jun 2024 15:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717600473;
	bh=inTLBFPiF3QNUYyxrof1SkNpGIxKC3xsYyySQonxahI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lsl2zrcWDGl78EMQOepgL8tTQHntDWP70ftaa2nvl4Xk/urLKWta0wC6I+AfrTAtf
	 pkI4w3kngcF1/B3aM4Khvjm94UIKnuNBqSLDubPWyCJzoiBHQdHajPdKesTG7fd1Rg
	 KwBg7pDDAAXKu2Xo4yiPS0vusod3uLSYaV8bg+aGDn1QTfWTOsEWKca1ZyhFcAEdT9
	 O1W7SPKKt6R0aelMrOZaNli+3OjXW2F0fV+hHhBd90jx2VuHnLp0cOu0Xf6sv8wpfM
	 BEkcYlKYN61KlLXlo4hzFuvFXwfcUl25KjWEadK0fn0PwV7yRZt3Z5eKnUrsNV+y7D
	 dTAI9rtr4pEtA==
Date: Wed, 5 Jun 2024 12:14:30 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Lucas Stach <l.stach@pengutronix.de>
Cc: linux-perf-users@vger.kernel.org, kernel@pengutronix.de,
	patchwork-lst@pengutronix.de
Subject: Re: [PATCH] perf script: netdev-times: add location parameter to
 consume_skb
Message-ID: <ZmCA1kzzqXSPzG4z@x1>
References: <20240605144442.1985270-1-l.stach@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240605144442.1985270-1-l.stach@pengutronix.de>

On Wed, Jun 05, 2024 at 04:44:42PM +0200, Lucas Stach wrote:
> dd1b527831a3 ("net: add location to trace_consume_skb()") added a new
> parameter to the consume_skb tracepoint. Adapt the script to match.

From what I could see from
tools/perf/util/scripting-engines/trace-event-python.c this will work
with older kernels where this tracepoint field isn't available, but
since I haven't actually tested this with an old kernel without it:

Acked-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Thanks,

- Arnaldo


> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> ---
>  tools/perf/scripts/python/netdev-times.py | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/scripts/python/netdev-times.py b/tools/perf/scripts/python/netdev-times.py
> index 00552eeb7178..30c4bccee5b2 100644
> --- a/tools/perf/scripts/python/netdev-times.py
> +++ b/tools/perf/scripts/python/netdev-times.py
> @@ -293,7 +293,8 @@ def skb__kfree_skb(name, context, cpu, sec, nsec, pid, comm, callchain,
>  			skbaddr, location, protocol, reason)
>  	all_event_list.append(event_info)
>  
> -def skb__consume_skb(name, context, cpu, sec, nsec, pid, comm, callchain, skbaddr):
> +def skb__consume_skb(name, context, cpu, sec, nsec, pid, comm, callchain,
> +			skbaddr, location):
>  	event_info = (name, context, cpu, nsecs(sec, nsec), pid, comm,
>  			skbaddr)
>  	all_event_list.append(event_info)
> -- 
> 2.45.1
> 
