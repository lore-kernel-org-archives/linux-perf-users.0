Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B9D3112B0
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Oct 2025 12:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760444052; cv=none; b=ErpBslVlUbrZNya65lp/+E+Cdq9ZZsCJupDHHE4txF8kJdYiSrFONIYoyWTExvj9dFKlL7iZYAiKZ+q5O/UewJFihhQ2fI3yL3COMktQfXR368foOschAi576wW7b//yx1u5+ZT/zspSNhLURS5J74p0LoMWm+nkLHIGNU5jU54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760444052; c=relaxed/simple;
	bh=fIBzMkg0VGF52LXe1aiatwyk4pMCOhu7mOP/HlvLhSQ=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LpuBnUW7p85G0J6Amjg7Yrt4nH7eu/mWp+jrX76IFBi0WBzyl77RWWyaaN2W01fraYcOwiydt8WL2/1nQdceE+erbrVIQagUdqD/XYijV9tRhmfVQUyJQ7qnbmJq8rd6Nfl97ukSAamqw269L4GbisGGN+TwTzIIaksjHA7JC3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fvG7eOAM; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fvG7eOAM"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b4736e043f9so828612166b.0
        for <linux-perf-users@vger.kernel.org>; Tue, 14 Oct 2025 05:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760444047; x=1761048847; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V4uv5mR3gumLLTp4rzrsge5eRolk8g3BgbWGMPSIr70=;
        b=fvG7eOAMSKj3VnEF6W9A6rI3EbIps9jpVGhIf5yvHF7LlcHmxe1scAATSS1JB3pNWT
         XGgcvCFKnYUlHCxUsAxSB43g9uzu8y3957zpKYYZhgvS5PipzRvZjl6DLVmi6N+5bM6a
         G9KJs3R24CDXOKkZyy7xkE8EglxXqZd8hdLYIEFQVaKz0R/yg61uYzVvHX90Y9Z0rHEz
         lDvgYraTbLwmm1ppLQWYtWSXfm0zhgShBanpRxwiIDkaK//Q1ytZcEIeF4TrYRBliVmz
         c3qNbvnAA3KmHZ3FNb6Zh1FYurn25PHQPRCc89mNo/lLBq4u54WbQlBvJyjtpkuzVtC3
         FgEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760444047; x=1761048847;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V4uv5mR3gumLLTp4rzrsge5eRolk8g3BgbWGMPSIr70=;
        b=KFlRN8WZWuvz5gn9ko6P07iXmN+O46jchpjnzuQjd8JPcM2lB4HKS9d4OVmRURCRPp
         N4ML1QLPD5db9X+h7CgIoZhtjTeGtOlNN63x1YAw0XUMa2khCwWpmIoK5YfTScmfq1jN
         Z3qzyRiljwcy38jv/i568IXKB+t/kTNsnY6wgllEZ2qbQ+LqYL/5yowUPLYY6CGO8aQU
         pAfUWXq9ACf5HyIdcK0DV+380P89hnRkOYdJihyKkvP1j5vrH3QFaXXDPz+QrbeVY9/9
         aOoU7EZexLxojerdliFBfYxmYJO1reEJfaLbjFURIb7y3pTbsgoZWqnKfWwioagj8cZp
         S34Q==
X-Forwarded-Encrypted: i=1; AJvYcCWshYPylx7DuN/Q97Pq++m3ORz0nx66VREGzWPmY0CrF9kf8y+18p/odDU/sl9DQt5tr0rK2q9drNsOOztQkSXI@vger.kernel.org
X-Gm-Message-State: AOJu0YwWFiwz29NGUxlk5OJvUdpZ9qF8iM4p53SvRB9i+21TFW8DYceb
	578F/WGlhowLvOZymjLWdjcdhvk4pJnE5VKEiD00Z0c4Bzc5MoZ+12ET
X-Gm-Gg: ASbGnctnqDzW53PRH0tBfw0qwNv6ACMjaZLjy+XOMaCUZv4eBgJY7vm4NTTlqv3FT4Q
	0JEFYx6WqLZSug1gFKSs54jtvr/5VoGdCOjFF4MIkqQxqOn/pb3avVoqh4NaQtRaKtgh3ZXB2gC
	MAMxTL2ILLCbxBgpuPiaHCNo5NdQbjAW+BlpgWuORvE85hlQVIHOYS2ddvohrlO5qCwCGgwXGOi
	cD4OKkxIzKMHPxysXHf0y2a1fWxWo2D3uB0y2XuXiuFtPAB0pMOYsS2Sf2/mRJTDiAUJRpbnDxv
	dN6Zr60L8kRsHlv6IGhO5bkz9LBdAaR7gyQXaS13a1xNorOXYwgpcbLHUnpGYEPAGtwtdv1rb0a
	F/mP7m3e9/aLIrdJ467Mz4FpPuA==
X-Google-Smtp-Source: AGHT+IHkRlcBwOY51BkfooCa8LhIq4rnJgTTrE+rrJI+8PsajKfIrEpNVRNGLaYNbHSpIVOY51g+2w==
X-Received: by 2002:a17:907:2d93:b0:afe:b92b:28e9 with SMTP id a640c23a62f3a-b50ac5d0859mr2537079066b.49.1760444046995;
        Tue, 14 Oct 2025 05:14:06 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::31e0])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d61cd9f5sm1130915166b.21.2025.10.14.05.14.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 05:14:06 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 14 Oct 2025 14:14:04 +0200
To: Tao Chen <chen.dylane@linux.dev>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, irogers@google.com,
	adrian.hunter@intel.com, kan.liang@linux.intel.com, song@kernel.org,
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	martin.lau@linux.dev, eddyz87@gmail.com, yonghong.song@linux.dev,
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
	haoluo@google.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [RFC PATCH bpf-next v2 2/2] bpf: Pass external callchain entry
 to get_perf_callchain
Message-ID: <aO4-jAA5RIUY2yxc@krava>
References: <20251014100128.2721104-1-chen.dylane@linux.dev>
 <20251014100128.2721104-3-chen.dylane@linux.dev>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014100128.2721104-3-chen.dylane@linux.dev>

On Tue, Oct 14, 2025 at 06:01:28PM +0800, Tao Chen wrote:
> As Alexei noted, get_perf_callchain() return values may be reused
> if a task is preempted after the BPF program enters migrate disable
> mode. Drawing on the per-cpu design of bpf_perf_callchain_entries,
> stack-allocated memory of bpf_perf_callchain_entry is used here.
> 
> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
> ---
>  kernel/bpf/stackmap.c | 19 +++++++++++--------
>  1 file changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> index 94e46b7f340..acd72c021c0 100644
> --- a/kernel/bpf/stackmap.c
> +++ b/kernel/bpf/stackmap.c
> @@ -31,6 +31,11 @@ struct bpf_stack_map {
>  	struct stack_map_bucket *buckets[] __counted_by(n_buckets);
>  };
>  
> +struct bpf_perf_callchain_entry {
> +	u64 nr;
> +	u64 ip[PERF_MAX_STACK_DEPTH];
> +};
> +
>  static inline bool stack_map_use_build_id(struct bpf_map *map)
>  {
>  	return (map->map_flags & BPF_F_STACK_BUILD_ID);
> @@ -305,6 +310,7 @@ BPF_CALL_3(bpf_get_stackid, struct pt_regs *, regs, struct bpf_map *, map,
>  	bool user = flags & BPF_F_USER_STACK;
>  	struct perf_callchain_entry *trace;
>  	bool kernel = !user;
> +	struct bpf_perf_callchain_entry entry = { 0 };

so IIUC having entries on stack we do not need to do preempt_disable
you had in the previous version, right?

I saw Andrii's justification to have this on the stack, I think it's
fine, but does it have to be initialized? it seems that only used
entries are copied to map

jirka

>  
>  	if (unlikely(flags & ~(BPF_F_SKIP_FIELD_MASK | BPF_F_USER_STACK |
>  			       BPF_F_FAST_STACK_CMP | BPF_F_REUSE_STACKID)))
> @@ -314,12 +320,8 @@ BPF_CALL_3(bpf_get_stackid, struct pt_regs *, regs, struct bpf_map *, map,
>  	if (max_depth > sysctl_perf_event_max_stack)
>  		max_depth = sysctl_perf_event_max_stack;
>  
> -	trace = get_perf_callchain(regs, NULL, kernel, user, max_depth,
> -				   false, false);
> -
> -	if (unlikely(!trace))
> -		/* couldn't fetch the stack trace */
> -		return -EFAULT;
> +	trace = get_perf_callchain(regs, (struct perf_callchain_entry *)&entry,
> +				   kernel, user, max_depth, false, false);
>  
>  	return __bpf_get_stackid(map, trace, flags);
>  }
> @@ -412,6 +414,7 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
>  	u32 skip = flags & BPF_F_SKIP_FIELD_MASK;
>  	bool user = flags & BPF_F_USER_STACK;
>  	struct perf_callchain_entry *trace;
> +	struct bpf_perf_callchain_entry entry = { 0 };
>  	bool kernel = !user;
>  	int err = -EINVAL;
>  	u64 *ips;
> @@ -451,8 +454,8 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
>  	else if (kernel && task)
>  		trace = get_callchain_entry_for_task(task, max_depth);
>  	else
> -		trace = get_perf_callchain(regs, NULL, kernel, user, max_depth,
> -					   crosstask, false);
> +		trace = get_perf_callchain(regs, (struct perf_callchain_entry *)&entry,
> +					   kernel, user, max_depth, crosstask, false);
>  
>  	if (unlikely(!trace) || trace->nr < skip) {
>  		if (may_fault)
> -- 
> 2.48.1
> 
