Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF751DDC1;
	Wed,  4 Jun 2025 15:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749051155; cv=none; b=nEKTrhTA7NUYgn6B+txtKVCrbE8W+nhl6KOECTJV/rYl4sSbKNMPD6aPiYGNV+53gKU1ApoC9odf1BnKf379MV+R24iN1bxHtkQdu6JK+OC6LbMeL3vkS7Cia7eINgthL0QfjuIk/WqOTmq45rzgBDfXYPtxQcvazjdxKZaR3JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749051155; c=relaxed/simple;
	bh=Oxj0L0vMUeF1rATIob8FyEydepIqKducGZ1bw6oENWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u4pFkqYiNXbX5m/Sjpzd3k2T2O7Vhi8+GNbPD4grKpOi2x8tJPtrGSlaqSDMARNz+CdgLodupmAjCrDsLmPOAGwaJ9SvTlOH2X1LU/FCs4va33GXCrtli9RwfhAXzcMHw5hiutcot179Kk8wH/ylliRQnLJkmWVNXMyJ0W/0SG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=B6oP9n3H; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="B6oP9n3H"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=zSIx60s8W1RWmCAF04ar6XaDTCMxl8+rRsS7EF61guU=; b=B6oP9n3HnEWwmroXUatjSLp0PB
	NtpK3WbsPpN8PGKdq4svfO035Bd6PjgODgScaDHOjm5fCSfybX4KxecZlOhU5NB5Lzifu0guXSMQ8
	M+GjaTu2GusJh0wpNjx5civ2v535J9ZftwnpJa8/RbmiBq81Lx+ejCGF6kKjR50sZvmw0y5HC9V1Y
	rYksRqKo6BWLnF2VO7fKZXe937u3FN6t9MXvcf8/DqXS6xRJn6k1ZQz+ZRZGaVM7qoyK6lKbU7mVG
	lYfiEmEUWU8yHX+zaABzBqHAcXmAiDZvvLqmHkTW1b+dBS0P9bkL3EEoD2fcFjNrrUfhGEX2hssVb
	fwxGiKsA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uMq6G-00000003ED3-1d8p;
	Wed, 04 Jun 2025 15:32:20 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id BD968300787; Wed,  4 Jun 2025 17:32:19 +0200 (CEST)
Date: Wed, 4 Jun 2025 17:32:19 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Baisheng Gao <baisheng.gao@unisoc.com>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"reviewer:PERFORMANCE EVENTS SUBSYSTEM" <kan.liang@linux.intel.com>,
	"open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-perf-users@vger.kernel.org>,
	"open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-kernel@vger.kernel.org>,
	cixi.geng@linux.dev, hao_hao.wang@unisoc.com
Subject: Re: [PATCH] perf/core: Handling the race between exit_mmap and perf
 sample
Message-ID: <20250604153219.GJ39944@noisy.programming.kicks-ass.net>
References: <20250424025429.10942-1-baisheng.gao@unisoc.com>
 <aEBSt2LN7YhxYX7N@J2N7QTR9R3>
 <20250604142437.GM38114@noisy.programming.kicks-ass.net>
 <aEBeRfScZKD-7h5u@J2N7QTR9R3>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEBeRfScZKD-7h5u@J2N7QTR9R3>

On Wed, Jun 04, 2025 at 03:55:01PM +0100, Mark Rutland wrote:

> I think we might need something in the perf core for cpu-bound events, assuming
> those can also potentially make samples.
> 
> From a quick scan of perf_event_sample_format:
> 
> 	PERF_SAMPLE_IP			// safe
> 	PERF_SAMPLE_TID			// safe
> 	PERF_SAMPLE_TIME		// safe
> 	PERF_SAMPLE_ADDR		// ???

Safe, set by driver, or 0.

> 	PERF_SAMPLE_READ		// ???

This is basically read(2) on a fd, but in sample format. Only the count
values. This good.

> 	PERF_SAMPLE_CALLCHAIN		// may access mm

Right.

> 	PERF_SAMPLE_ID			// safe
> 	PERF_SAMPLE_CPU			// safe
> 	PERF_SAMPLE_PERIOD		// safe
> 	PERF_SAMPLE_STREAM_ID		// ???
safe

> 	PERF_SAMPLE_RAW			// ???
safe, this is random data returned by the driver

> 	PERF_SAMPLE_BRANCH_STACK	// safe
> 	PERF_SAMPLE_REGS_USER		// safe
> 	PERF_SAMPLE_STACK_USER		// may access mm
> 	PERF_SAMPLE_WEIGHT		// ???
> 	PERF_SAMPLE_DATA_SRC		// ???
Both should be safe, driver sets them.

> 	PERF_SAMPLE_IDENTIFIER		// safe
> 	PERF_SAMPLE_TRANSACTION		// ???
Safe, another random thing the driver can set. This was for
transactional memory stuff.

> 	PERF_SAMPLE_REGS_INTR		// safe
> 	PERF_SAMPLE_PHYS_ADDR		// safe; handles mm==NULL && addr < TASK_SIZE
> 	PERF_SAMPLE_AUX			// ???

Safe, should be driver, PT for Intel, or that CoreSight for ARM.

> 	PERF_SAMPLE_CGROUP		// safe
> 	PERF_SAMPLE_DATA_PAGE_SIZE	// partial; doesn't check addr < TASK_SIZE
> 	PERF_SAMPLE_CODE_PAGE_SIZE	// partial; doesn't check addr < TASK_SIZE

But does use init_mm when !mm, perf_get_page_size().

> 	PERF_SAMPLE_WEIGHT_STRUCT	// ???
Safe, driver bits again.

> 
> ... I think all the dodgy cases use mm somehow, so maybe the perf core
> should check for current->mm?

This then... I suppose.

---
diff --git a/kernel/events/core.c b/kernel/events/core.c
index f34c99f8ce8f..49944e4ec3e7 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7439,6 +7439,10 @@ perf_sample_ustack_size(u16 stack_size, u16 header_size,
 	if (!regs)
 		return 0;
 
+	/* No mm, no stack, no dump. */
+	if (!current->mm)
+		return 0;
+
 	/*
 	 * Check if we fit in with the requested stack size into the:
 	 * - TASK_SIZE
@@ -8153,6 +8157,9 @@ perf_callchain(struct perf_event *event, struct pt_regs *regs)
 	if (!kernel && !user)
 		return &__empty_callchain;
 
+	if (!current->mm)
+		user = false;
+
 	callchain = get_perf_callchain(regs, 0, kernel, user,
 				       max_stack, crosstask, true);
 	return callchain ?: &__empty_callchain;
