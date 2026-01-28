Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D061C337B8B;
	Wed, 28 Jan 2026 08:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769590329; cv=none; b=Vt5Xt1ufX4H1PNv87VuXndNy+nKQJ1xaO1od8T2mWkSex1C8wOsySZk3y6sgdC1B76MMs8nyzCOZnRJ3R9pIRrKE3zc8GW01P7CsxqiMo97zKA4kFhQFi9hdGuDgBSCqI1O6mV54wY40oLkIKzVjQx5VRvWtjUaDK+GJpuuQpis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769590329; c=relaxed/simple;
	bh=T4OXPR/bW/1RgGiENHQ9H5vsxpc9KYjqN4c26ZdymX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EuVtC7dRtGHsDycTnRqJZ+4R1MaLunK/3VjWUC3Dm+XwF0/T/o8MxJyqORfz98lGtUREMIjWztnQaWqaxe0kN4pd2PT1YRcgDWWAOgxGZ7lY3KlAkt4aKakmpNBDIxgzJDAepYxspccxbMJpwKGzlxie9kMUFqLksKafK8w8T6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=oDIbzeol; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oDIbzeol"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=fMn7DKyHncqMo+r0yd1dcVlP4ZvGiURXL0RdqOhIvbA=; b=oDIbzeolmR/xi7fTGeaZ/uzdpb
	gy6rBNr7VhtmIZy2qc7u0bnY0zah+3f8fZ2x0JJTk0Cc7q0K+TFmQcpvSnMCKHCsacR+HiY3rD/x9
	+KnyrD5XELvEef4odwrQLp5eIsFhfV2oVUh8XYZZNSWk3PqwSWRwisEU0f/J5FpfAvUK5LYq5y7QH
	+v7otcpJkJsTW+iQiH8dmENKG2rrqXgvOOCJwnkyPqeUAgLPqXtxhHPRxYhYPVbxDWFcbCWZ4nA+p
	i4rSR/pAI8ptz2FBgRCdy18NSQUOv4aN2BHiSimV8V3xlShOCs6YQyqsYw9z/S1lKx6N2nZdnnfTr
	DM16CzzQ==;
Received: from 2001-1c00-8d85-5700-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:5700:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vl1HM-00000008mKO-3QIn;
	Wed, 28 Jan 2026 08:52:01 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 5C5E5300708; Wed, 28 Jan 2026 09:52:00 +0100 (CET)
Date: Wed, 28 Jan 2026 09:52:00 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Qing Wang <wangqing7171@gmail.com>
Cc: syzbot+72a43cdb78469f7fbad1@syzkaller.appspotmail.com, acme@kernel.org,
	adrian.hunter@intel.com, alexander.shishkin@linux.intel.com,
	irogers@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, mark.rutland@arm.com,
	mingo@redhat.com, namhyung@kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [perf?] WARNING: suspicious RCU usage in
 get_callchain_entry
Message-ID: <20260128085200.GE3372621@noisy.programming.kicks-ass.net>
References: <000000000000fe324606174e1f9e@google.com>
 <20260128035508.1840613-1-wangqing7171@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260128035508.1840613-1-wangqing7171@gmail.com>

On Wed, Jan 28, 2026 at 11:55:08AM +0800, Qing Wang wrote:
> #syz test
> 
> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> index da3d328f5c15..f97d4aa9d038 100644
> --- a/kernel/bpf/stackmap.c
> +++ b/kernel/bpf/stackmap.c
> @@ -460,7 +460,7 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
>  
>  	max_depth = stack_map_calculate_max_depth(size, elem_size, flags);
>  
> -	if (may_fault)
> +	if (!trace_in)
>  		rcu_read_lock(); /* need RCU for perf's callchain below */
>  
>  	if (trace_in) {
> @@ -474,7 +474,7 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
>  	}
>  
>  	if (unlikely(!trace) || trace->nr < skip) {
> -		if (may_fault)
> +		if (!trace_in)
>  			rcu_read_unlock();
>  		goto err_fault;
>  	}
> @@ -494,7 +494,7 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
>  	}
>  
>  	/* trace/ips should not be dereferenced after this point */
> -	if (may_fault)
> +	if (!trace_in)
>  		rcu_read_unlock();
>  
>  	if (user_build_id)
> 

This is just papering over more bugs. There was a series out there
somewhere trying to fix up this code, let me see if I can find it in
this shitshow called an inbox :/
