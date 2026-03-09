Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FEC53A7846;
	Mon,  9 Mar 2026 12:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773057963; cv=none; b=pOGoJGHq+b+lA0/wKFsUcR70aIf3EGikaGV2gbbxhjPQUF6eiWNfPquqSsww7X8YTO6f+LtQLN2kcf4Hw2J9LenF+8dDRf0yQXLMKW278gQMKJtgfeFzoZNUev0rS9Uug15w0pYLb31H/VrJfXNB2AdF+kFYcpd4ozG7NawMdNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773057963; c=relaxed/simple;
	bh=cqUQxeHEp/W1gy99PSlgkFBnoZrTdCCwHCyfLGlE0Lk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iiUlsTXpls02bIuVvXrIbukEmrQgGoKZMFVX72l1NUbULPlIVqw7EVMT/6QT+Haq2FRLKY2qB6GkeAvblOT3FStZvcBHGrjivvhsf04TBgRaqe7pH/tfFNoskIQmhkUa3rZTQeaNQr4mKUIzrTO8Ga7ynhzGV8Ks1qezmw1RRLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=U6T0Wi64; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="U6T0Wi64"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=aLdpbLxT6Uvbo1W1qoqQkm5/cnz1QpUGqky0e5dS1TE=; b=U6T0Wi64La4GpCo3zoNOvuKREJ
	Djz7j8gW7vZrwUscZ06mwPSXU30v+IZGuPNsipaT/pp5FMeJkzPgNqLtbwiwOQSXVfCudHueiQ/GU
	DaXUx0eQQPTLYcBCxHhMdmhQLp8/IEN6bveGLCAPPrFBLNe8skcZttKqOJQi7+giRo3CUITviIXyC
	FVNr3XyEEboK/+Iq3aXuzrYdBTvWNUTXlsNHKjU1EvGIpJssyEtGnsOZiwGyaYINGEQrc6bwjqrQ1
	aK1pKAoY+kHcUwMXAQgrcAYfjxmv/BEaF02UCIfanhjL7NovR8WNytQ4mkliqubW3zx7t6TKZP8oN
	yMCjgxqg==;
Received: from 2001-1c00-8d85-5700-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:5700:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vzZMn-00000005UKA-0jlQ;
	Mon, 09 Mar 2026 12:05:45 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 83B34300FB6; Mon, 09 Mar 2026 13:05:43 +0100 (CET)
Date: Mon, 9 Mar 2026 13:05:43 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Oliver Rosenberg <olrose55@gmail.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf_events: fix array-index-out-of-bounds in x86_pmu_del
Message-ID: <20260309120543.GA606826@noisy.programming.kicks-ass.net>
References: <20260309014215.3871484-1-olrose55@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309014215.3871484-1-olrose55@gmail.com>

On Sun, Mar 08, 2026 at 06:41:30PM -0700, Oliver Rosenberg wrote:
> Vulnerability Description:
> There exists a KASAN:wild-memory-access and an array-index-out-of-bounds
> (-1 index) in x86_pmu_del(). When a cross-PMU event group is created
> where the group leader is a PMU type that does not have txn implemented
> then the cpuc->txn_flags for the siblings are not set because only the
> group leader's pmu->start_txn() is called and in the case of not being
> implemented it is set to perf_pmu_nop_txn(). The events are still attempted
> to be processed as a group, when one of the x86 PMUs errors out,
> cpuc->txn_flags is not set and event->hw.idx is not set. The x86_pmu_del()
> function expects event->hw.idx not to be set when events are batched and
> not yet enabled during a transaction so the function checks the
> cpuc->txn_flags to skip the array-index-out-of-bounds. However, when an
> event errors out and the group events are not enable here, cpuc->txn_flags
> is not set and event->hw.idx is -1 so we do not skip the uses of
> event->hw.idx which causes an array-index-out-of-bounds.

I can confirm your POC works, and that the above is somehow what
happens. But it is not what should be happening.

Specifically, by adding an x86 even to a 'software' event, the software
event should be moved to the x86 pmu_ctx (move_group case in
perf_event_open) and then group_event->pmu_ctx->pmu should end up being
the x86 pmu in group_sched_in().

Tracing shows the move_group path is indeed taken and pmu_ctx is
adjusted.

> POC Explanation:
> The POC first fills the CPUs PMU events with x86 raw PMU events (type 4) to
> set up the group scheduling to fail and trigger the bug, it then creates a
> cross-PMU group with BREAKPOINT (type 5) as the group leader and 2 x86 raw
> PMU siblings. The first sibling is added but batched and not enabled, the
> second sibling fails on add because we exceed the max number of PMU events
> for the cpu. This triggers the cleanup of the first sibling for which
> cpu->txn_flags is not set and event->hw.idx=-1 since sibling 1 was not
> enabled. This triggers the bug when event->hw.idx is used as an
> array-index-out-of-bounds in x86_pmu_del().

You're forgetting part of what the POC does:

      if (fork() == 0) _exit(0);
        wait(NULL);


Without that, it doesn't reproduce. Suggesting there's something wrong
with inherit.

And indeed, the below makes it go away.

Now, let me go audit the code to see if this same problem exists in more
shapes...

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 03ce1bc7ef2e..75cd651a7f55 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1655,6 +1655,8 @@ static void x86_pmu_del(struct perf_event *event, int flags)
 	if (cpuc->txn_flags & PERF_PMU_TXN_ADD)
 		goto do_del;
 
+	WARN_ON(event->hw.idx < 0);
+
 	__set_bit(event->hw.idx, cpuc->dirty);
 
 	/*
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 03ced7aad309..ab968203b735 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -14743,7 +14749,7 @@ inherit_event(struct perf_event *parent_event,
 	get_ctx(child_ctx);
 	child_event->ctx = child_ctx;
 
-	pmu_ctx = find_get_pmu_context(child_event->pmu, child_ctx, child_event);
+	pmu_ctx = find_get_pmu_context(parent_event->pmu_ctx->pmu, child_ctx, child_event);
 	if (IS_ERR(pmu_ctx)) {
 		free_event(child_event);
 		return ERR_CAST(pmu_ctx);
