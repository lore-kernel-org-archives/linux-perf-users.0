Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A98396D0C;
	Wed, 25 Mar 2026 15:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774451863; cv=none; b=qyFxfiI08K48PWAjkZosUuxN9h5URNjiB8y500x0MMDRPlS+0qN1OovBjVWqNVodwKv+dxmIr01aUe5jIdzI/fcK0gHRL/Txw6mLULjssacPim5tBy2Yq2HYPObI3FU/bGHSY4J2z/jZ0TrYTWGw9AgzRuNh/GKPGUp4QFYzanc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774451863; c=relaxed/simple;
	bh=hr4kLX1j1kqNlY7VsuT6cR38Vv3QHFKgwHkc57vWsc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MVAJ8OcJfKy2bktnU8p38fo7EUNHs7WGN9fmq7S5FrnWrY1KELNXHcEf91DjNk837n2xFtdcf9eTUaY5FJixUdWyuvttLYYs3pflajJMY7S5oPbqUpnY+nhgkUiJCwB8sFnr6KcDXhAsbT7fDyiueczxxiJE7y8g9c4ias0IxaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TY79w6WW; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TY79w6WW"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=4CPvloTjZ8EuJsTU4Thia0HQYGNABRMvje1Lu1b/rrQ=; b=TY79w6WWAU6S4a2rcGmHAAzSkS
	kRp27Zt7vLwB7xWxCWCl7UUf7MDtG9n8P304PLPcVRQYExA4vi+oc7G8RWgD1qyWszCKpZKiNIrm9
	/DS8MMo5Ib4PxxZ7o96CSETdnkV6XEODQ4U2qCaHhWW8LUefvFF2T1Id0tf5FqA4YJRPRDn5chDhB
	eXJI5tJGTpZeDspbSL8H19JIu1KX0p5HfhXNdRntbHBPucgaKC/rMXiLz57cLwz/bNXYy3WK79+JB
	ixp8Vc5i2QQfR4MPefhLcjrn7OZs4VMPwkKd7tRCAJDJfz16hQShc8Eq0EBZmvMxll9GCAVMom18l
	P/oci9mA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w5PzD-00000006SXp-3UTC;
	Wed, 25 Mar 2026 15:17:35 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 594B1300312; Wed, 25 Mar 2026 16:17:35 +0100 (CET)
Date: Wed, 25 Mar 2026 16:17:35 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: yuhaocheng035@gmail.com
Cc: irogers@google.com, wangqing7171@gmail.com, acme@kernel.org,
	adrian.hunter@intel.com, alexander.shishkin@linux.intel.com,
	james.clark@linaro.org, jolsa@kernel.org,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	mark.rutland@arm.com, mingo@redhat.com, namhyung@kernel.org,
	syzbot+196a82fd904572696b3c@syzkaller.appspotmail.com
Subject: Re: [PATCH v3] perf/core: Fix refcount bug and potential UAF in
 perf_mmap
Message-ID: <20260325151735.GI3738010@noisy.programming.kicks-ass.net>
References: <CAAoXzSrdEjHtLYqHJDT8bm_gDAY=C1VdeU=0NbjJ0hhpOo5V9w@mail.gmail.com>
 <20260325102053.1401-1-yuhaocheng035@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325102053.1401-1-yuhaocheng035@gmail.com>


Argh,. why is this hidden in this old thread :/

On Wed, Mar 25, 2026 at 06:20:53PM +0800, yuhaocheng035@gmail.com wrote:

> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 2c35acc2722b..a3228c587de1 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -6730,9 +6730,10 @@ static void perf_pmu_output_stop(struct perf_event *event);
>   * the buffer here, where we still have a VM context. This means we need
>   * to detach all events redirecting to us.
>   */
> -static void perf_mmap_close(struct vm_area_struct *vma)
> +static void __perf_mmap_close(struct vm_area_struct *vma, struct perf_event *event,
> +			      bool holds_event_mmap_lock)
>  {
> -	struct perf_event *event = vma->vm_file->private_data;
> +	struct perf_event *iter_event;
>  	mapped_f unmapped = get_mapped(event, event_unmapped);
>  	struct perf_buffer *rb = ring_buffer_get(event);
>  	struct user_struct *mmap_user = rb->mmap_user;
> @@ -6772,11 +6773,14 @@ static void perf_mmap_close(struct vm_area_struct *vma)
>  	if (refcount_dec_and_test(&rb->mmap_count))
>  		detach_rest = true;
>  
> -	if (!refcount_dec_and_mutex_lock(&event->mmap_count, &event->mmap_mutex))
> +	if ((!holds_event_mmap_lock &&
> +	     !refcount_dec_and_mutex_lock(&event->mmap_count, &event->mmap_mutex)) ||
> +	    (holds_event_mmap_lock && !refcount_dec_and_test(&event->mmap_count)))
>  		goto out_put;

*groan*, this is horrible.

Let me have a poke to see if there isn't a saner variant around.
