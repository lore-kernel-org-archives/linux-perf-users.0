Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0242FD7D0
	for <linux-perf-users@vger.kernel.org>; Mon, 10 Nov 2025 09:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762767104; cv=none; b=mGylA/950Bmabi95jbVQuN1hgSELX3kJK40SzrB7vNXylLw9dRMHvf/I1tdz7qLoq9QIs/TYEHv2LOtxLWsF1OuCq3qg7FnILBhmmIimNCaCol8D+Bbh3IagLh71xZDkybBYcgaQxvv1QKhuC8xY+E5H54brrhxSg2D8dJtwq6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762767104; c=relaxed/simple;
	bh=R4sPwVWsKKDvww/k4FfA6t+mlOFcHNFmY2LFzg0LQDc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iRj/OPKuqx/Ydh9bMG+1YjHlSkhzpMsYHI6b2L5zft+sDSRHyPW/4tJb2er7NBnAmiBqjniont+ccZv4Tmz3l0rTeiCJXAFNB9A1sgzv8nmW5KWgD3r7eZd9obDRjkze7SNeHs3vbkHsPnwDM46JA68hvNPrYqGWYEEOuVlSYTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lNfSJ4A9; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lNfSJ4A9"
Message-ID: <9ebb8b72-4b73-4cf5-9054-9134daf16d0d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762767089;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gEqwTslyKAJyhJtEPTZjhrfmoW1bErkJB1EH4ikLcaw=;
	b=lNfSJ4A9dqlet90fBnyfeT7ds2I81ua7PKcHLGykZ2mzA5QFNyWCzXCzI7rfpLAqOmP4wC
	cXOBn4Pz+abAOeCOyi/NoxUmctIVe3Jd4EiyxwUCW7RKT9dMt2j72XdCXmWOVUazgxmj8p
	ewq0388oN+sENkpiIck08M25gClCpiY=
Date: Mon, 10 Nov 2025 17:31:19 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v5 1/3] perf: Refactor get_perf_callchain
To: bot+bpf-ci@kernel.org, peterz@infradead.org, mingo@redhat.com,
 acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, kan.liang@linux.intel.com
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@kernel.org, eddyz87@gmail.com,
 yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
References: <20251109163559.4102849-2-chen.dylane@linux.dev>
 <886b17f3dd9f9836dd87b9249a01e737088fe52174b8d513ad6350c6bb19ff87@mail.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Chen <chen.dylane@linux.dev>
In-Reply-To: <886b17f3dd9f9836dd87b9249a01e737088fe52174b8d513ad6350c6bb19ff87@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/11/10 00:58, bot+bpf-ci@kernel.org 写道:
>> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
>> index fd1d91017..edd3058e4 100644
>> --- a/include/linux/perf_event.h
>> +++ b/include/linux/perf_event.h
>> @@ -67,6 +67,7 @@ struct perf_callchain_entry_ctx {
>>   	u32				nr;
>>   	short				contexts;
>>   	bool				contexts_maxed;
>> +	bool				add_mark;
>>   };
> 
> [ ... ]
> 
>> diff --git a/kernel/events/callchain.c b/kernel/events/callchain.c
>> index 808c0d7a3..fb1f26be2 100644
>> --- a/kernel/events/callchain.c
>> +++ b/kernel/events/callchain.c
> 
> [ ... ]
> 
>> +void __get_perf_callchain_user(struct perf_callchain_entry_ctx *ctx, struct pt_regs *regs)
>> +{
>> +	int start_entry_idx;
>> +
>> +	if (!user_mode(regs)) {
>> +		if (current->flags & (PF_KTHREAD | PF_USER_WORKER))
>> +			return;
>> +		regs = task_pt_regs(current);
>> +	}
>> +
>> +	if (ctx->add_mark)
>> +		perf_callchain_store_context(ctx, PERF_CONTEXT_USER);
>> +
>> +	start_entry_idx = ctx->nr;
>                            ^^^^^^^^
>> +	perf_callchain_user(ctx, regs);
>> +	fixup_uretprobe_trampoline_entries(ctx->entry, start_entry_idx);
>> +}
> 
> Can this break uprobe trampoline fixups? The original code used
> entry->nr for start_entry_idx, but the refactored version uses ctx->nr.
> 
> These two counters track different things:
> - entry->nr counts ALL entries (incremented by both
>    perf_callchain_store_context() and perf_callchain_store())
> - ctx->nr only counts regular callchain entries (incremented only by
>    perf_callchain_store(), not by perf_callchain_store_context())
> 
> When add_mark is true, perf_callchain_store_context() increments
> entry->nr but not ctx->nr, causing them to become out of sync.
> 
> For example, if kernel callchain collection runs first with add_mark
> set:
> 
>    Initial: ctx->nr = entry->nr = 0
> 
>    In __get_perf_callchain_kernel():
>      perf_callchain_store_context() stores PERF_CONTEXT_KERNEL marker
>        -> entry->nr becomes 1, ctx->nr still 0
>      perf_callchain_kernel() stores N kernel frames
>        -> entry->nr becomes 1+N, ctx->nr becomes N
> 
>    In __get_perf_callchain_user():
>      perf_callchain_store_context() stores PERF_CONTEXT_USER marker
>        -> entry->nr becomes 2+N, ctx->nr still N
>      start_entry_idx = ctx->nr assigns N (should be 2+N)
>      fixup_uretprobe_trampoline_entries() scans from wrong index
> 
> This causes fixup_uretprobe_trampoline_entries() to scan kernel
> callchain entries instead of user callchain entries, missing the
> uretprobe trampolines that need to be fixed up.
> 
> Should this use ctx->entry->nr instead of ctx->nr?
> 

Use ctx->entry->nr looks better, will change it.
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/19211481431


-- 
Best Regards
Tao Chen
