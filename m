Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2FE433F589
	for <linux-perf-users@vger.kernel.org>; Sat, 19 Sep 2026 22:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789857082; cv=none; b=guol8tOn4NfMG2PccgqMvQO/zcCM9nTx415s1sZeE7nm69vrXnvzbelJudOLw4poom/63p1CGYI93dW8FJsU3Blk/VRQEy4LOrceAwEGVmNYiZjjh94mcBWfqL8vbYNHFveEPHED61YGj5xrEC18L97D4gR79XU4OqbvA5XEWfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789857082; c=relaxed/simple;
	bh=RNTQSXqgO/M0bmZsDPfgXKTqs8IgKP//kfeiYthx5Uw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=c6n3bitRCr1Gtk2zXt0nLeprjpa4gnIfslUCftGnYau6tmIcA5mTabAKjcxNjO8KENslvtNGxTLlhc5Tqn6uIMS/yIJEOlJlWh1UrlIJ94KFndtKh36ElImm9c5nGVU+SpAfi6nLi0kAj7fy+BhQHrQaFj9HHSDhIGk+nSXtYt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W7WAv0k+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W7WAv0k+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 428691F000FF;
	Sat, 19 Sep 2026 22:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789857080;
	bh=p0U4sEF/WLUg7kkGSaLj9PCrTxuG62EDDKcF39dDNq4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=W7WAv0k+Cxnu9UQZhz7z7AzSJQ3RTTB12uO560kivXaUNOe2xcT615oUP/QhNEp2A
	 hI5HvzT/NzbK2KlUOTNUwUCpKU8ckFpDEgPiIWY/uIQv3xFlqxZX6Sq6a6s+P/YHKt
	 cjiqJk8IflebbzS2PzGJg85P8YkrCNI5jdegKrNKWg7CWDFnjEylfuFgMgYFSC0V6Y
	 oYG9CI6weg4w1OJ1xMEId73AyHr3NUCrybqLqgGaFfiQ9Xo8DnXreAVel2b4Gii7f4
	 xlLwJhOqOODOss6VGgalcsNEWTFWBiFWEZRSnLj8VLu0E/6EE4mnKYZvtNE4HEcK3Q
	 qieiiiGdsscxg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf/core: fix locked_vm leak on alias mmap() and
 cross-MM pinned_vm underflow
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hui Peng" <benquike@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260919221728.3707189-1-benquike@gmail.com>
References: <20260919221728.3707189-1-benquike@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 19 Sep 2026 22:31:19 +0000
Message-Id: <20260919223120.428691F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] perf: mmdrop() in RCU callback causes softirq context violation
--

commit f66e9c8b5f2a9c636e7dc5afd975c9e2ed17cf78
Author: Hui Peng <benquike@gmail.com>

perf/core: fix locked_vm leak on alias mmap() and cross-MM pinned_vm underf=
low

In perf_mmap(), mapping an output ring buffer onto an event via
PERF_EVENT_IOC_SET_OUTPUT / alias mmap() increments user->locked_vm and
mm->pinned_vm without recording the accounting MM on the ring_buffer or
releasing user_extra onperf_mmap_close(), causing a permanent locked_vm
leak and a cross-MM pinned_vm underflow when the mapping is closed in a
different process. Store the accounted mm_struct on struct perf_buffer
and unaccount against the original mm_struct on close.

> diff --git a/kernel/events/internal.h b/kernel/events/internal.h
> index c03c4f2eea571..f10eacd8b5903 100644
> --- a/kernel/events/internal.h
> +++ b/kernel/events/internal.h
[ ... ]
> @@ -67,6 +70,10 @@ static inline void rb_free_rcu(struct rcu_head *rcu_he=
ad)
>  	struct perf_buffer *rb;
> =20
>  	rb =3D container_of(rcu_head, struct perf_buffer, rcu_head);
> +	if (rb->aux_mmap_mm)
> +		mmdrop(rb->aux_mmap_mm);
> +	if (rb->mmap_mm)
> +		mmdrop(rb->mmap_mm);

[Severity: High]
Does this code call mmdrop() in an RCU callback, which executes in a softirq
context?

If this mmdrop() drops the final mm_count reference (for instance, if the
original process has already exited), it synchronously invokes __mmdrop().
__mmdrop() performs blocking teardown operations (such as pgd_free() and
percpu_counter_destroy()) which can sleep.

Sleeping in a softirq context is illegal and leads to a kernel BUG or panic.

This could happen if a process mmaps a perf event to create a ring buffer,
which uses mmgrab() to increment mm_count. If the process then exits, dropp=
ing
its own mm reference, and later the ring buffer is unmapped (e.g., by anoth=
er
process closing the alias), this triggers ring_buffer_put(), which schedules
rb_free_rcu() via call_rcu(). The RCU callback then drops the final referen=
ce
and triggers the bug.

Should this teardown be deferred to the workqueue (rb_free_work) which runs
in a process context, or perhaps use mmdrop_async() instead?

>  	free_uid(rb->mmap_user);
>  	rb_free(rb);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260919221728.3707=
189-1-benquike@gmail.com?part=3D1
