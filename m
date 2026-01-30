Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADB52D063E
	for <linux-perf-users@vger.kernel.org>; Fri, 30 Jan 2026 14:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769782501; cv=none; b=UC1dQWRQhLFFuZFuae0VQvSnXUcwIZkfp81vI4TVbGEr8u4tq0ULFk2N+pBw6zFzTz2niB6bNPlJX0kNSnXB0XXMhvtPO/2Jemn5tR8h0qICw1gK/DAqdsjjpFt7O1+tODhFiWFxlaYT9zNvUTu4QKChlz/NwPeJf84m11xzVX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769782501; c=relaxed/simple;
	bh=1wQZXnJ2Cdr/Pz7A1F1VgsqCX5pJ8RniXpMYExSjsjk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XQRmjiZnaXDhfCtXNtMjCG+zBPgKxTxrxCIvPHbRuJrLBEDBUsBcfLlAyvgWbq0L8Ky107SMeN+36NK29YIlGHZv/tNkCAVPpMJduq457kio99XU4bKy9Yg3RbA4iX3z3rNdJsbpREc1W1y/ulFhsFKbsbpkp+LMMgjQTLKV2Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=w6qEZ7yW; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="w6qEZ7yW"
Message-ID: <6e149b55-9700-411b-b330-00de0fb93378@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769782488;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WgjEYvTFriYrUDdQIwSAHaaPs9j5W76Yn2YZsjaQAbE=;
	b=w6qEZ7yWMER53O2BM36jYMKgpFau1vClH0a5fTYFYsc1YKfsGYvh29Wr5M54yY5/qoHypo
	AsMBceZAvoGZ8klFAJaxBRxp73mejPQw/xydg+GhlbHFfx/rBCymHZHFL8AIBbwsKyekG7
	cUBaKs8MVy5n7HI/Sv0eo16ByMhpsN0=
Date: Fri, 30 Jan 2026 22:14:35 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 1/2] bpf: Allow sleepable programs to use tail
 calls
To: Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Martin KaFai Lau <kafai@fb.com>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>
References: <20260130081208.1130204-1-jolsa@kernel.org>
 <20260130081208.1130204-2-jolsa@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <20260130081208.1130204-2-jolsa@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2026/1/30 16:12, Jiri Olsa wrote:
> Allowing sleepable programs to use tail calls.
> 
> Making sure we can't mix sleepable and non-sleepable bpf programs
> in tail call map (BPF_MAP_TYPE_PROG_ARRAY) and allowing it to be
> used in sleepable programs.
> 
> Sleepable programs can be preempted and sleep which might bring
> new source of race conditions, but both direct and indirect tail
> calls should not be affected.
> 
> Direct tail calls work by patching direct jump to callee into bpf
> caller program, so no problem there. We atomically switch from nop
> to jump instruction.
> 
> Indirect tail call reads the callee from the map and then jumps to
> it. The callee bpf program can't disappear (be released) from the
> caller, because it is executed under rcu lock (rcu_read_lock_trace).
> 
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  include/linux/bpf.h   | 1 +
>  kernel/bpf/core.c     | 4 +++-
>  kernel/bpf/verifier.c | 1 +
>  3 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 5524f9429e76..3b0ceb759075 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -287,6 +287,7 @@ struct bpf_map_owner {
>  	enum bpf_prog_type type;
>  	bool jited;
>  	bool xdp_has_frags;
> +	bool sleepable;
>  	u64 storage_cookie[MAX_BPF_CGROUP_STORAGE_TYPE];
>  	const struct btf_type *attach_func_proto;
>  	enum bpf_attach_type expected_attach_type;
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index e0b8a8a5aaa9..5ebece600aeb 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -2401,6 +2401,7 @@ static bool __bpf_prog_map_compatible(struct bpf_map *map,
>  		map->owner->type  = prog_type;
>  		map->owner->jited = fp->jited;
>  		map->owner->xdp_has_frags = aux->xdp_has_frags;
> +		map->owner->sleepable = fp->sleepable;
>  		map->owner->expected_attach_type = fp->expected_attach_type;
>  		map->owner->attach_func_proto = aux->attach_func_proto;
>  		for_each_cgroup_storage_type(i) {
> @@ -2412,7 +2413,8 @@ static bool __bpf_prog_map_compatible(struct bpf_map *map,
>  	} else {
>  		ret = map->owner->type  == prog_type &&
>  		      map->owner->jited == fp->jited &&
> -		      map->owner->xdp_has_frags == aux->xdp_has_frags;
> +		      map->owner->xdp_has_frags == aux->xdp_has_frags &&
> +		      map->owner->sleepable == fp->sleepable;
>  		if (ret &&
>  		    map->map_type == BPF_MAP_TYPE_PROG_ARRAY &&
>  		    map->owner->expected_attach_type != fp->expected_attach_type)
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index e7ff8394e0da..f185ebc6748d 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -21386,6 +21386,7 @@ static int check_map_prog_compatibility(struct bpf_verifier_env *env,
>  		case BPF_MAP_TYPE_STACK:
>  		case BPF_MAP_TYPE_ARENA:
>  		case BPF_MAP_TYPE_INSN_ARRAY:
> +		case BPF_MAP_TYPE_PROG_ARRAY:
>  			break;
>  		default:
>  			verbose(env,

This change also prevents a bad use case: a sleepable program FD could
be inserted into a prog_array map whose owner is a non-sleepable program.

Looking at __bpf_prog_map_compatible(), are there any other program
properties we should consider checking to ensure compatibility when
updating a prog_array map?

From the tail call compatibility point of view, the restriction on
mixing sleepable and non-sleepable programs looks correct to me.

Acked-by: Leon Hwang <leon.hwang@linux.dev>

