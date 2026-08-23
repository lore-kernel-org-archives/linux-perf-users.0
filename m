Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC287E792;
	Sun, 23 Aug 2026 12:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787486533; cv=none; b=PGrNS/yX8XNQeP/VHRFFWR0RpUlb6KfcYAyuxAVkUYc14AJUkBd8duZj5zJMpU035MljjGMrXsBIy11C6TPMk2Z8GdkItkt6tqkeOAK2gpTqTUO4hu5gTSsTjeQQAqVO83JAtP0oscNpNs8vg6rX8Q/rhGXv+gSl9QGYqhpG4yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787486533; c=relaxed/simple;
	bh=KXJKRSN8H2KSpoXjmOcnvK69wdqanVpAPLytJEdjiNc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=X5YCNyCJ7UBnl4W7e4iHLdobfVIFcWOcUlgTcgtBd4P1gFbkacLlofO5JYe5/h19l/3rP8V7mSDn7Ne4moJe5YS6zLOqun7TYg3/5I7PUfuqIUaCDNfTfoRueNayZOC4rlzpQfqra5ynad3Z3H9xqNA/AL4m1OcaqvcDs2qifQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NvJGRoA3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NvJGRoA3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E1E01F000E9;
	Sun, 23 Aug 2026 12:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787486531;
	bh=3oleSwVg3wXsaPeC1qU2M3/we6hwie5BXE6Evl0nixY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=NvJGRoA3rOrFSZKAU6MD7Qmk+jy2d37T2WCtu88e1y/9P+IRcXIt0HCG1yc0ntRUf
	 qms6CXL48UncOW+u1MpHcLBWW4w76DZMZMsc8dBPgMFWC7JNdhSchJC7Yc1zVPZHID
	 Moyh2/82ZPpAzqGVSUkcpsh5/bAYXYg2X6EZhAgMM4f7/BlFWHKH1ydFd401VZ8AOe
	 yp8/1TEJiAEYF38FEeB9AeJX0yuBPH9W8z6ucUXpBOnT+63A81dDjNSD4PC1Y8pZXy
	 hgWNQofjX0TE2+AO3vnw6bD93nLJ4RQsTIFVqQyE+tKpCGPEUnt6m+vHSxXw6GhdTZ
	 0h317UMm2qR2A==
Date: Sun, 23 Aug 2026 21:02:08 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: sashiko-bot@kernel.org, "Keke Ming" <ming.jvle@gmail.com>,
 linux-perf-users@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] uprobes: Free utask on dup_return_instance() failure
Message-Id: <20260823210208.25e21677ac0c691037d7ef24@kernel.org>
In-Reply-To: <20260822060014.AD2681F000E9@smtp.kernel.org>
References: <20260822054620.452262-1-ming.jvle@gmail.com>
	<20260822060014.AD2681F000E9@smtp.kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sat, 22 Aug 2026 06:00:14 +0000
sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [Critical] Double free of `extra_consumers` during `fork()` due to missing pointer nullification in `dup_return_instance()` / `ri_pool_push()`.
> --
> 
> --- Patch [1]: [PATCH] uprobes: Free utask on dup_return_instance() failure ---
> commit 52bd4caeb5b9686b25fe707609034e9397c6100a
> Author: Keke Ming <ming.jvle@gmail.com>
> 
> uprobes: Free utask on dup_return_instance() failure
> 
> dup_utask() installs the new uprobe_task in t->utask before copying
> return_instances. If dup_return_instance() fails, the partially copied
> utask is left attached to the child task. This patch frees the partially
> copied utask before returning -ENOMEM.
> 
> > diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> > index 7709ea8824778..7547929ab294d 100644
> > --- a/kernel/events/uprobes.c
> > +++ b/kernel/events/uprobes.c
> > @@ -2140,8 +2140,10 @@ static int dup_utask(struct task_struct *t, struct uprobe_task *o_utask)
> >  	p = &n_utask->return_instances;
> >  	for (o = o_utask->return_instances; o; o = o->next) {
> >  		n = dup_return_instance(o);
> > -		if (!n)
> > +		if (!n) {
> > +			uprobe_free_utask(t);
> 
> [Severity: Critical]
> This is a pre-existing issue, but can dup_return_instance() leave a dangling
> pointer that results in a double free of extra_consumers when
> uprobe_free_utask() is called here?

Hmm, this seems another bug here.

> 
> If a multi-consumer uretprobe is hit, extra_consumers is allocated. When this
> returns, it is pushed to the reuse pool:
> 
> kernel/events/uprobes.c:ri_pool_push() {
>     ri->cons_cnt = 0;
>     ri->next = utask->ri_pool;
>     utask->ri_pool = ri;
> }
> 
> This resets cons_cnt to 0 but retains the extra_consumers heap pointer.
> 
> If the thread then hits a single-consumer uretprobe, alloc_return_instance()
> reuses the pooled object. push_consumer() increments cons_cnt to 1 and uses
> the inline consumer, leaving the old extra_consumers pointer untouched.
> 
> When the task calls fork(), dup_return_instance() does a shallow copy:
> 
> kernel/events/uprobes.c:dup_return_instance() {
>     ri = kmemdup(old, sizeof(*ri), GFP_KERNEL);
>     if (!ri)
>         return NULL;
> 
>     if (unlikely(old->cons_cnt > 1)) {
>         ri->extra_consumers = kmemdup(old->extra_consumers, ...
>     ...
> }
> 
> Since old->cons_cnt == 1, it skips deep-copying or clearing extra_consumers.
> Both the parent and child tasks now share the exact same heap pointer. 

Hmm, so either clearing extra_consumers when returning ri to the pool
(with releasing extra_consumers) or clearing new ri->extra_consumers when
dup_return_instance(), will fix this.

Thanks,

> 
> When the tasks exit, or if dup_return_instance() fails and triggers the new
> cleanup path in this patch, ri_free() will execute kfree(ri->extra_consumers)
> in both contexts, freeing the same memory twice.
> 
> >  			return -ENOMEM;
> > +		}
> >  
> >  		/* if uprobe is non-NULL, we'll have an extra refcount for uprobe */
> >  		uprobe = hprobe_expire(&o->hprobe, true);
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260822054620.452262-1-ming.jvle@gmail.com?part=1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
