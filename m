Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9313FCB3D;
	Fri, 18 Sep 2026 09:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789725064; cv=none; b=MyQS7GIzVAqaYg1sgJ/yRnrY3Tf4on60qSfnwZcIw9zfDLAewvFG0YoqKGZqrTUY+RsV7ELEkEUJb+hZhNWqc3Y2bev7b9Zw8q36SQHL1dBGITuQt8TpKS0dzM3rfbfpRBThUg3Y1p9hW1r8hHMz2FXTTEgl42LtIuxhAYgug7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789725064; c=relaxed/simple;
	bh=ByCzBbmwZf/rDEK2PLyjRpdxLQzY2WfI/6eu3xdTqV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FLNNN4e2x8SiSn7K++fX+/XV4KW7zP9DqQprOifCgZIbCAWFrqhzthZ2hnx54/foBwUqv0GnlpHLyIchmGSgZBJ9GSE0vQdpejQVcrmH0Zv8VaoLy4SXYEKRr/2BCnr2cG2Nh5tmkZMwBR2bJrF+Tz+IrQm7EQW+L07c3RyKc7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KZ7gd8Y8; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KZ7gd8Y8"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=noG7Xbw5qA6orJrsGAhv7ONYyvYhvezfCJLf3CU5i3g=; b=KZ7gd8Y88UOKHJhZOQ+EKpwhRJ
	5qjc3vHidmfMQPObUKgqlTHKLEu81C4KJfG//Q4KEo1RHLBWvrb7zdnrnSqiVgiDY6dj1/zkFuSZ2
	j+9QrpUw9a6VulXa++fkPhj1epOG+UEaNSG4e4QJTGBfzrvI6F/bj2qFBdilEBBmQtdQhZI2s631o
	fXOFIb81BPcDgBeAPtvtiAE0YgnuzYqmSbeiW84gymnPM0dPfRcC7lm03EUVCK5+pzvkMFD/GaaW4
	pLWuI0K1iCnsUVq4J4QsIk/NzpneAYXyIDXjN+q3lvxxtgJFzaibVoveEWB1s4nO+41abBJANbrBn
	UaWBnfgA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7VF4-0000000GkvP-0L5O;
	Fri, 18 Sep 2026 09:50:50 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 42EED300328; Fri, 18 Sep 2026 11:50:49 +0200 (CEST)
Date: Fri, 18 Sep 2026 11:50:49 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Luo Gengkun <luogengkun2@huawei.com>
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	james.clark@linaro.org, elver@google.com, dvyukov@google.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf/core: Fix race between perf_event_exit_task and
 perf_pending_task
Message-ID: <20260918095049.GL1837346@noisy.programming.kicks-ass.net>
References: <20260416033443.1492483-1-luogengkun2@huawei.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260416033443.1492483-1-luogengkun2@huawei.com>

On Thu, Apr 16, 2026 at 03:34:43AM +0000, Luo Gengkun wrote:
> A race condition exists between perf_event_exit_task() and perf_pending_task().
> 
> During begin_new_exec(), perf_event_exit_task() may be called, and the
> PF_EXITING flag is not set on task. so perf_sigtrap() continues to execute
> and triggers WARN_ON_ONCE(event->ctx->task != current).
> 
> To fix this problem, also check if the event->ctx->task is TASK_TOMBSTONE.
> 
> Fixes: 97ba62b27867 ("perf: Add support for SIGTRAP on perf events")
> Signed-off-by: Luo Gengkun <luogengkun2@huawei.com>
> ---
>  kernel/events/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 1f5699b339ec..3422900263fa 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -7543,7 +7543,7 @@ static void perf_sigtrap(struct perf_event *event)
>  	 * Both perf_pending_task() and perf_pending_irq() can race with the
>  	 * task exiting.
>  	 */
> -	if (current->flags & PF_EXITING)
> +	if (current->flags & PF_EXITING || event->ctx->task == TASK_TOMBSTONE)
>  		return;

Since do_exit() also calls perf_event_exit_task() (albeit a little later
than exit_signals()), and task_can_queue_signal() will return false when
PF_EXITING, and we ignore the return value of
send_sig_perf()/send_sig_info(). I don't think we need to check both.

That is, I think:

	if (event->ctx->task == TASK_TOMBSTONE)

is sufficient. Also, the comment needs updating.
