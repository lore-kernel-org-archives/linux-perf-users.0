Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C600F17BCA;
	Fri, 30 Jan 2026 10:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769768588; cv=none; b=D5PSmYpJxuta7UmpD6YyIznoRhMd/xCXy/Vy8nGT1HIoMPHjxrTb/opkxeybkhnVstflgax0rlFEmqjtiOrB0FNhKDj4luojP9spcIoYN+A7UjUPO19KNujYBumLtQkAxxByuZcq+0Ht1Y7UxaqewDPmeq4HTDbmnNXxkHvCp4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769768588; c=relaxed/simple;
	bh=qMBOafVGCTH88IYyfHxlvW2KTuXT3aCn+vgg6N7/myA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fbFc+QFaHJ383pmFwvtrL/s+DzdbBEBGrmi6vq/H4CTtxO0C/3Ng4sPuteqQdh8gBGk/Fj3d7YKP7wwPU2Yr4Zjz1p5DzfqKaE1caZjpo/KgvRIlbZHb0arWYE5o5wG1SLexrTJTOwrmu6dGWTCzIQ/nP9yEKzsRhkPtNHmHDlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HOYTzIPB; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HOYTzIPB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=BVh+chDyG+s+tV3ClqBUlFmOiGpBgy6M929kQydFBkM=; b=HOYTzIPBzwiMyej170IjZbTqF8
	me4s6iWqZclaDh17c2TWDFXjgcON1PwUztlg2t9fYX9/rK/rz0n07oNETA9Dxo4Kz4ry/Qnh2jdZj
	DosoDy+SQIFDVUHsAq41+SJdagiPFFHo/ccd2FS8HftmZCJ7d0RHq0uqnzx5pXUyGgVo6r/Jihh0P
	fiqvi4xvSRCS4aRG7istDMJiXee6DxY/wXVna3aPmhfCc2lwvzysNVtYVy9GHMwqR7UdEWiPEPSWB
	yOBA8B/eSNWN81ALeyfqYnQHeODe16vRGuZIDT4UVmf4JtFyJD53n4nCaIfLhNmXAiSuYj51mxLYy
	fd/PSWCg==;
Received: from 2001-1c00-8d85-5700-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:5700:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vlleX-0000000BcRJ-1FXV;
	Fri, 30 Jan 2026 10:23:01 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 2C26930331F; Fri, 30 Jan 2026 11:23:00 +0100 (CET)
Date: Fri, 30 Jan 2026 11:23:00 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Henry Zhang <henryzhangjcle@gmail.com>
Cc: mingo@redhat.com, acme@kernel.org, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
	Henry Zhang <zeri@umich.edu>,
	syzbot+2a077cb788749964cf68@syzkaller.appspotmail.com,
	andrii@kernel.org
Subject: Re: [PATCH] perf: Fix data race in perf_event_set_bpf_handler()
Message-ID: <20260130102300.GA171111@noisy.programming.kicks-ass.net>
References: <20260127023618.1469937-1-zeri@umich.edu>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260127023618.1469937-1-zeri@umich.edu>

On Mon, Jan 26, 2026 at 09:36:18PM -0500, Henry Zhang wrote:
> KCSAN reported a data race where perf_event_set_bpf_handler() writes
> event->prog while __perf_event_overflow() reads it concurrently from
> interrupt context:
> 
> BUG: KCSAN: data-race in __perf_event_overflow / __perf_event_set_bpf_prog
> 
> write to 0xffff88811b219168 of 8 bytes by task 13065 on cpu 0:
>  perf_event_set_bpf_handler kernel/events/core.c:10352 [inline]
>  __perf_event_set_bpf_prog+0x418/0x470 kernel/events/core.c:11303
> ...
> 
> read to 0xffff88811b219168 of 8 bytes by interrupt on cpu 1:
>  __perf_event_overflow+0x252/0x920 kernel/events/core.c:10410
> ...
> 
> Annotate event->prog access with WRITE_ONCE/READ_ONCE.
> 
> Reported-by: syzbot+2a077cb788749964cf68@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=2a077cb788749964cf68
> Signed-off-by: Henry Zhang <zeri@umich.edu>
> ---
>  kernel/events/core.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index a0fa488bce84..1f3ed9e87507 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -10349,7 +10349,7 @@ static inline int perf_event_set_bpf_handler(struct perf_event *event,
>  		return -EPROTO;
>  	}
>  
> -	event->prog = prog;
> +	WRITE_ONCE(event->prog, prog);
>  	event->bpf_cookie = bpf_cookie;

What about that cookie thing? The consumer seems to be a bpf function
(bpf_get_attach_cookie_pe) which can equally run concurrently, no?

Also, there seems to be a coherency issue here, if prog runs, it expects
cookie to be present and all that.

Would that not suggest something like:

	WRITE_ONCE(event->bpf_cookie, bpf_cookie);
	smp_store_release(&event->prog, prog);

>  	return 0;
>  }
> @@ -10407,7 +10407,9 @@ static int __perf_event_overflow(struct perf_event *event,
>  	if (event->attr.aux_pause)
>  		perf_event_aux_pause(event->aux_event, true);
>  
> -	if (event->prog && event->prog->type == BPF_PROG_TYPE_PERF_EVENT &&
> +	struct bpf_prog *prog = READ_ONCE(event->prog);

smp_load_acquire(&event->prog);

> +
> +	if (prog && prog->type == BPF_PROG_TYPE_PERF_EVENT &&
>  	    !bpf_overflow_handler(event, data, regs))
>  		goto out;
>  

Hmm?
