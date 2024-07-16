Received: from bumble.birch.relay.mailchannels.net (bumble.birch.relay.mailchannels.net [23.83.209.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D884417F7
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Jul 2024 01:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.209.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721094722; cv=pass; b=mb+ukxEOP+8br4Dc3uwY1bDcZUrV150i6KN70NPiiUF0m1wYc3KzWlqr/sXOP0gbvArt+WIGUfoDiPZvvYiyYLFAQHxF8mlUtRkxVa/KiaerHWRTHrthP2YAfyt497gMbIzNaFDQ8FQuWQ7cvTQ4mRTguXgu7HZ6wWfjlF4g+/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721094722; c=relaxed/simple;
	bh=PeKiarT8eQc6rksVYELDY4cwNAKkH7slx1rYRZo2fQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qBNbGcmhHYJB0lA5GB6tDRWQd0UaTRHAmOdIeUUTvNkCPioPXd1ggMUpGw/78xnDSshRd+gu4jtN90w3wZanove82RL1TLjEeNDV9lLNwAOlNPtVtJ7TDBHMKcNvPBjRcEFY8KWUe+sBxq//jPxG1izg6QUrfUNK46nyYPjLdi0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=templeofstupid.com; spf=pass smtp.mailfrom=templeofstupid.com; dkim=pass (2048-bit key) header.d=templeofstupid.com header.i=@templeofstupid.com header.b=VK4yiC8J; arc=pass smtp.client-ip=23.83.209.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=templeofstupid.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=templeofstupid.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=templeofstupid.com header.i=@templeofstupid.com header.b="VK4yiC8J"
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 758C44C62B1
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Jul 2024 01:36:14 +0000 (UTC)
Received: from pdx1-sub0-mail-a289.dreamhost.com (unknown [127.0.0.6])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 1DD8E4C5EF6
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Jul 2024 01:36:14 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1721093774; a=rsa-sha256;
	cv=none;
	b=F5U8FdYQuqZi6GR2mkU7A8Icnal3xfFZ36hVXSiEX7TXxSXjyLigiM7jSuyISAdGFhhLES
	szDRVLDl4nD4ydqkkuefIKLzyTgW6VnSGKoqihz7pVqiHsd0aOQ1yjh6SOh6QFv8lPbnZT
	/r30WyjiawVZzWrnI/5I5TWS+weopJumjjWbFa21hi2Tk53Uw0QMKPK+DhritPypq4Bguz
	9E6waOKEKfBR+261cBUdd56mQeffXmHmmUGBbAN1ui2ao6DpORbe0FX9ywsyZBiCJSfVYI
	a/NX+K3mArvxdEaz9dGPgoRQgWd+0PFNBYHdKsSmiNCv8zcA+uSy+nowLEz30Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1721093774;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=/MwgD32GHUs1vzsv67n+6LWFnsTKem5E7XUoauy6A14=;
	b=7iDzISCFfkPjBZIhf07ycv4+41ZuXs/vg6Jyfr1OgTJiImU68CoxgD/XvWX4pmOLoa/RTR
	fvgI9l4LrhaFjsDD/wQ7EyESVKtuQtAxsksDKuIRpsMw+fHNW8i7pRkB1ZBgZTDoFA2zMR
	qhfgQco0oCNbzfPA2TM+xDi2Rulp04cOz+U5MKR0q8aL1biK7mjeycwAjtO962WfjJdwnX
	16m+E6jIa3tGKQsOuJKLQFZCJIegaVdCqLUMo6IrDMxfV/m26/XsnLaRgXrogWem5N94i1
	Ws7IJZteRc/ucZcRW/7O3wk4RoGrp+ycNkxA0QSxvF3g05UayEEWiw2n9QJZEA==
ARC-Authentication-Results: i=1;
	rspamd-5d9c874f6d-dlj4j;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=kjlx@templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MailChannels-Auth-Id: dreamhost
X-Tart-Drop: 31d937bf05cceef0_1721093774336_277989503
X-MC-Loop-Signature: 1721093774336:3583593711
X-MC-Ingress-Time: 1721093774335
Received: from pdx1-sub0-mail-a289.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.104.53.183 (trex/6.9.2);
	Tue, 16 Jul 2024 01:36:14 +0000
Received: from kmjvbox.templeofstupid.com (c-73-70-109-47.hsd1.ca.comcast.net [73.70.109.47])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kjlx@templeofstupid.com)
	by pdx1-sub0-mail-a289.dreamhost.com (Postfix) with ESMTPSA id 4WNM990wVxzpM
	for <linux-perf-users@vger.kernel.org>; Mon, 15 Jul 2024 18:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
	s=dreamhost; t=1721093773;
	bh=/MwgD32GHUs1vzsv67n+6LWFnsTKem5E7XUoauy6A14=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=VK4yiC8J0b6b3GKy+TkXdiog4U044nDbG6X3HJI+0l/5tXA/cdIZNprqboX31ofKV
	 bq+cbrtD7MYBc7A+LGMRdRbJ9wWipHH76Ny4TG/u7UyXYRdQgJ1CbazRh3nPJNllfM
	 sHqzBb3TXuX3CafgGce76c75Wh9a3B40vPedGE3jcbfff9gW2bckJujGwAhyBqlAFT
	 OLikKd344sD/KNFARe8plLKBwnyzkCC5QxX4GNI1jw3lfvlS39q1BjYlD5vScqQuWF
	 pAfOt3R8ajvKlH3a9t3cqlxyu3mor1jY5Cqbw4K6QewzdA5In3AB0Sqh3OsAOguqHO
	 q1WgV9HzMiCnQ==
Received: from johansen (uid 1000)
	(envelope-from kjlx@templeofstupid.com)
	id e002b
	by kmjvbox.templeofstupid.com (DragonFly Mail Agent v0.12);
	Mon, 15 Jul 2024 18:36:03 -0700
Date: Mon, 15 Jul 2024 18:36:03 -0700
From: Krister Johansen <kjlx@templeofstupid.com>
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf@vger.kernel.org, linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	Krister Johansen <kjlx@templeofstupid.com>, houtao1@huawei.com
Subject: Re: [PATCH bpf-next] perf/bpf: Use prog to emit ksymbol event for
 main program
Message-ID: <20240716013603.GA1890@templeofstupid.com>
References: <20240714065533.1112616-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240714065533.1112616-1-houtao@huaweicloud.com>

On Sun, Jul 14, 2024 at 02:55:33PM +0800, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> Since commit 0108a4e9f358 ("bpf: ensure main program has an extable"),
> prog->aux->func[0]->kallsyms is left as uninitialized. For bpf program
> with subprogs, the symbol for the main program is missed just as shown
> in the output of perf script below:
> 
>  ffffffff81284b69 qp_trie_lookup_elem+0xb9 ([kernel.kallsyms])
>  ffffffffc0011125 bpf_prog_a4a0eb0651e6af8b_lookup_qp_trie+0x5d (bpf...)
>  ffffffff8127bc2b bpf_for_each_array_elem+0x7b ([kernel.kallsyms])
>  ffffffffc00110a1 +0x25 ()
>  ffffffff8121a89a trace_call_bpf+0xca ([kernel.kallsyms])
> 
> Fix it by always using prog instead prog->aux->func[0] to emit ksymbol
> event for the main program. After the fix, the output of perf script
> will be correct:
> 
>  ffffffff81284b96 qp_trie_lookup_elem+0xe6 ([kernel.kallsyms])
>  ffffffffc001382d bpf_prog_a4a0eb0651e6af8b_lookup_qp_trie+0x5d (bpf...)
>  ffffffff8127bc2b bpf_for_each_array_elem+0x7b ([kernel.kallsyms])
>  ffffffffc0013779 bpf_prog_245c55ab25cfcf40_qp_trie_lookup+0x25 (bpf...)
>  ffffffff8121a89a trace_call_bpf+0xca ([kernel.kallsyms])
> 
> Fixes: 0108a4e9f358 ("bpf: ensure main program has an extable")
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---
> Hi,
> 
> ksymbol for bpf program had been broken twice, and I think it is better
> to add a bpf selftest for it, but I'm not so familiar with the
> perf_event_open(), for now I just post the fix patch and will post the
> selftest later.
> 
>  kernel/events/core.c | 28 +++++++++++++---------------
>  1 file changed, 13 insertions(+), 15 deletions(-)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index f0128c5ff278..e1b7d9e61fa0 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -9289,21 +9289,19 @@ static void perf_event_bpf_emit_ksymbols(struct bpf_prog *prog,
>  	bool unregister = type == PERF_BPF_EVENT_PROG_UNLOAD;
>  	int i;
>  
> -	if (prog->aux->func_cnt == 0) {
> -		perf_event_ksymbol(PERF_RECORD_KSYMBOL_TYPE_BPF,
> -				   (u64)(unsigned long)prog->bpf_func,
> -				   prog->jited_len, unregister,
> -				   prog->aux->ksym.name);
> -	} else {
> -		for (i = 0; i < prog->aux->func_cnt; i++) {
> -			struct bpf_prog *subprog = prog->aux->func[i];
> -
> -			perf_event_ksymbol(
> -				PERF_RECORD_KSYMBOL_TYPE_BPF,
> -				(u64)(unsigned long)subprog->bpf_func,
> -				subprog->jited_len, unregister,
> -				subprog->aux->ksym.name);
> -		}
> +	perf_event_ksymbol(PERF_RECORD_KSYMBOL_TYPE_BPF,
> +			   (u64)(unsigned long)prog->bpf_func,
> +			   prog->jited_len, unregister,
> +			   prog->aux->ksym.name);
> +
> +	for (i = 1; i < prog->aux->func_cnt; i++) {
> +		struct bpf_prog *subprog = prog->aux->func[i];
> +
> +		perf_event_ksymbol(
> +			PERF_RECORD_KSYMBOL_TYPE_BPF,
> +			(u64)(unsigned long)subprog->bpf_func,
> +			subprog->jited_len, unregister,
> +			subprog->aux->ksym.name);
>  	}
>  }

Thanks, this looks correct to me.  Sorry that I missed this earlier.

Reviewed-by: Krister Johansen <kjlx@templeofstupid.com>

-K
