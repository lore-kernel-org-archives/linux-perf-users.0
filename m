Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E50A38B7BF;
	Thu,  5 Feb 2026 11:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770289739; cv=none; b=SFRXOvQTiYH/GdXZ+uGYprl99LkG1o1yasRNAlmyhB3FI2uUMhZFJYvZ0Gc8yHvQudot6itEEUnAmUMLwsExpfnxgUI1OeHgsi1ahjbhQceWsN9lwoWDOJq+ljBMi6DWhaR8GzguE5ctkIaC5kJ62p6VKrK9/wsDFBnjuz4F86Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770289739; c=relaxed/simple;
	bh=Myea7TMkDqstWqZ8pJSz0WjhguqT5YrzvqPmMfua8z0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dbNQKUtgPPKwV4Z4F/AErLNKhU4iqAV6iSYTbWMmKlJ2yJJ6gw1ZsuWa7sqrPTuDzBBWEuAAp6VKsbt+YfTbNmucMzr/L8nrwHTcLYwQq9IqOrm3HprL38PFXJ37niL8/tK2axWVPFspaTtg/L0kwCaF4GT9A1NK2jZZctdHwMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=T+eFlh6q; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="T+eFlh6q"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=yDvA9T23LYSeDi7y5D8VQduz9DwHCy3IuYoV1yNUzBU=; b=T+eFlh6q3/dpfe/N+lfZi+sTOZ
	I6I7M/Dn6VXw0c69ZEHQVCTzvBiuzEkT15JonstrT9Wq08xhacPvXs0Gyr754aWpAvQjCuznNCCoP
	o65acdYQ1eqsST4kE11675yS6FjHP8FZDpP0NnaGyVZkzZ5TSX5tpfiFwRetijJDXaEg6SmYCbxBf
	j1zORmjxLEI53eUOBoeAdAqeFXMf2Cb9J30zmwbZefeBhYuellcMoFPmkeG6+UTggWbTIZVnkKE5r
	SNr+1AJRjXOzJN8uTKav7l01G26VYR3HSLZBRrHQWyu+VQ73ATgc1WkiazRKsW9si1CsCbNzHoOJ0
	yoqvzUcA==;
Received: from 2001-1c00-8d85-5700-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:5700:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnxEG-000000020qK-22kw;
	Thu, 05 Feb 2026 11:08:56 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 9CC74300FB6; Thu, 05 Feb 2026 12:08:55 +0100 (CET)
Date: Thu, 5 Feb 2026 12:08:55 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Zw Tang <shicenci@gmail.com>
Cc: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	mingo@redhat.com, boqun.feng@gmail.com,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	namhyung@kernel.org, will@kernel.org, juri.lelli@redhat.com
Subject: Re: [BUG] PREEMPT_RT: sleeping function called from invalid context
 in perf_event_wakeup()
Message-ID: <20260205110855.GJ232055@noisy.programming.kicks-ass.net>
References: <CAPHJ_VK1t=pRw9zct9CNRET1=uH-efB9grAJ-kGJEN=PDk7z0w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPHJ_VK1t=pRw9zct9CNRET1=uH-efB9grAJ-kGJEN=PDk7z0w@mail.gmail.com>

On Thu, Feb 05, 2026 at 06:42:05PM +0800, Zw Tang wrote:
> Hi,
> 
> I am reporting a PREEMPT_RT “sleeping function called from invalid
> context” bug triggered by a syzkaller reproducer on Linux 6.19.0-rc7.
> 
> The kernel reports:
> 
> BUG: sleeping function called from invalid context at
> kernel/locking/spinlock_rt.c:48
> in_atomic(): 1, irqs_disabled(): 1, preempt_count: 4
> 
> The splat points to perf’s wakeup path taking an RT spinlock while
> running in an atomic/IRQs-disabled context:
> 
> merge_sched_in()
> -> perf_event_wakeup()
> -> __wake_up_common_lock()
> -> rt_spin_lock()
> -> __might_resched() (complains about sleeping in invalid context)
> 
> This suggests a locking semantic mismatch on PREEMPT_RT:
> perf_event_wakeup() (via __wake_up_common_lock()) ends up taking a
> lock that maps to rt_spin_lock(), which may sleep on RT kernels, but
> the current context is explicitly atomic with IRQs disabled.

Fixes: f4b07fd62d4d ("perf/core: Use POLLHUP for pinned events in error")

diff --git a/kernel/events/core.c b/kernel/events/core.c
index dad0d3d2e85f..216cf6ae1c7d 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -4017,7 +4017,8 @@ static int merge_sched_in(struct perf_event *event, void *data)
 			if (*perf_event_fasync(event))
 				event->pending_kill = POLL_ERR;
 
-			perf_event_wakeup(event);
+			event->pending_wakeup = 1;
+			irq_work_queue(&event->pending_irq);
 		} else {
 			struct perf_cpu_pmu_context *cpc = this_cpc(event->pmu_ctx->pmu);
