Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795175768;
	b=GIkWUd9Ieo3eLbfDU7GAatnrlMVMFrhuaE6OAPNrQ8jTt7Yh5IGetZ4h69Vz95jFf96y
	 M6Vn1ok1/N1O2hI4+tiC8lPmTCYou26bA71pFvKIVry7e4dJBREPvsYVMxKIo+JR2OCQB
	 10hxz+9A9g1CD58uRxKihRpa+peBqPWbIKKe4zVMQCw3Hz/WkSHgQnYtG6YjpavX4OmU6
	 q6EChpu3RXwkSfQhuz8JSgfUv1m/mfIcRYv6zst5KBex47EB2wH9eFp8b1CKRFqRDrb2s
	 wsWRIH/31R7j1UAhF3nK06ZqSom41A62Nb+TrtIO314Mx46P1d6OyDb+jpCKLaNm3Yg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795175768;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=PXRVRPdOar/2qEkh1nAT5/sKJn9vJaTashrDQ/K8vps=;
	b=zkeSd/JFf+GhVNXkk7b7kIWMAsNoaZmOIDEIjB1HZjdV0dLaC18VbqwERiIKoAhdtcfs
	 AIsoESh0SQa/9O5gmBygwOnW2juMHWIFhZISoPior3Q5xpy4nSDEdqGwq4xP2cLVXrd0M
	 +SZiIEobzMe3XELx55vxXom4WHSbu2Y8iSlCCJIJuUvLu3D6L/pRYVlAbxeunFVFHUSlD
	 guF0HJpu2RmULjqFKmVyGAMQY2KNW8DlRZTnQ2EkbGDrzelKiFJJ/lbtr6Ui02UZFA39h
	 o2GqhnsR5TXc8GR0SxF0tJiN5V7VDewXVYvatSHD9rIpC13B8kEEk87FwTaCHgOmOIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=N1S78QAL;
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C36606A326
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2026 11:56:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7C36606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=N1S78QAL
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=PXRVRPdOar/2qEkh1nAT5/sKJn9vJaTashrDQ/K8vps=; b=N1S78QAL05nIyTn4M2vL8YOoy5
	c00+DFAh8DyIM4ZCDlcaVytoaDD7uNAyu9KkGlCZ4IW21cbefgjf7/71P4kZWoYP950Deu5x8I5Ii
	XcWBW4y/sHyCeLnFQuooQYXnfePTt5EzZ95mVGJghzLl0Hwm9xi9//KVTArWgUV8nwvd7VXRp6Ojs
	KTi7koTRPcLX5WoXU099QY7ulILm5rOQTcFl4fnczz6f6GevQKnxT09Eyou467P6gdb1LXRxKNwre
	y9tIRwH622YZgTN+PNGjtO0Sj9k4Ity18MH/1NFzTM7qjxE9BliXo7EQ4JS20F0Sy/jjZsi+P4wge
	OLFQgalA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUNDn-00000000jRi-27Pp;
	Fri, 20 Nov 2026 11:56:04 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 085AD301185; Fri, 20 Nov 2026 12:56:02 +0100 (CET)
Date: Fri, 20 Nov 2026 12:56:01 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Dominik Maier <dmnk@google.com>
Cc: Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Marco Elver <elver@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Rogers <irogers@google.com>, linux-perf-users@vger.kernel.org,
	dmnk+artist@google.com
Subject: Re: [PATCH] perf/hw_breakpoint: fix ctx->mutex vs perf_event_mutex
 inversion on attr modify
Message-ID: <20261120115601.GQ2668564@noisy.programming.kicks-ass.net>
References: <20261119192228.2661266-1-dmnk@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261119192228.2661266-1-dmnk@google.com>

On Thu, Nov 19, 2026 at 08:22:28PM +0100, Dominik Maier wrote:
> The perf events lock hierarchy documented in kernel/events/core.c orders
> task_struct::perf_event_mutex outside perf_event_context::mutex, which
> perf_event_open() and prctl(PR_TASK_PERF_EVENTS_ENABLE) follow.
> 
> However, perf_ioctl(PERF_EVENT_IOC_MODIFY_ATTRIBUTES) acquires
> ctx->mutex first via perf_event_ctx_lock() and then calls
> perf_event_modify_attr() -> modify_user_hw_breakpoint_check() ->
> modify_bp_slot() -> bp_constraints_lock(), which locks
> bp->hw.target->perf_event_mutex when bp_type changes.

  perf_ioctl()
    perf_event_ctx_lock()                     // perf_event_context::mutex
    _perf_ioctl()
      MODIFY_ATTR:
        perf_event_modify_attr()
          mutex_lock(event->child_mutex)      // perf_event::child_mutex
          perf_event_modify_breakpoint()
            modify_user_hw_breakpoint_check()
              if (bp->attr.bp_type != attr->bp_type)
                modify_bp_slot()
                  bp_constraints_lock()       // task_struct::perf_event_mutex

> If one thread in a
> process calls prctl(PR_TASK_PERF_EVENTS_ENABLE) while another calls
> ioctl(PERF_EVENT_IOC_MODIFY_ATTRIBUTES) with an alternating bp_type on a
> self-targeted breakpoint, the two threads deadlock against each other in
> TASK_UNINTERRUPTIBLE state.
> 
> Decouple bp_constraints_lock() from task_struct::perf_event_mutex by
> using a small static array of dedicated mutexes indexed by
> hash_ptr(tsk, BP_TASK_MUTEX_BITS). At most one bp_task_mutexes[] entry
> is ever held at a time, and ordering becomes strictly
> perf_event_mutex -> ctx->mutex -> bp_task_mutexes[] -> bp_cpuinfo_sem
> without extending task_struct.

How long until someone reports this as a scalability problem.. :/

> Fixes: 0912037fec11 ("perf/hw_breakpoint: Reduce contention with large number of tasks")
> Fixes: 32ff77e8cc9e ("perf/core: Implement fast breakpoint modification via _IOC_MODIFY_ATTRIBUTES")

I'm not sure about this second commit; that does introduce the
MODIFY_ATTR stuff, but things weren't broken back then.

If you really want a second commit, then 82aad7ff7ac2 seems like a fine
enough candidate, since I annotated that warning away without noticing
the inversion through modify_bp_slot().

The reason modify_bp_slot() exists is for switching between data and
code breakpoints; which I recon isn't something we can take away either.

Bah.
