Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794998648;
	b=MK2ss30hkzgUrp9pK1vpgR/cAUhh70s+ROBJVfTHhHfHHG3K+mUGLS+BwsmdWp9fc2De
	 zvcdDQdiYl5VeNql5K1ZJIwJJvAt1ksH+cu4iQN7lOhoo6lnFQbhfsCq5nmD1/jrRwjCT
	 sLWSAmEX23GHcNiAS+0OyOh3o7poYuXrH8HSBTIu1ghorlEk0/a1wyKsHYRtfcITepEN3
	 tnJNogw3hs9aLLX4BJYi6m54G6yz0kTTywO4pRjM+6QTbfWK9wBAbPa6cFbwveqc2lj3i
	 UiJYmsYZB83opmsquKskpz4I+k/QWbG53qb/ZMbCibfbC4tzLbveWinGomD7/DzDH+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794998648;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=N4S0kgZ/NMm9yfsBMXr5qvuT3q1E7nw/7lKsTCmiCBk=;
	b=cMAUJ+6b7ipvoa2DjR84bSAJ2ue9WM3kYfGetOdtbMYReBhMU4UnUqL8Q7F2+BiyQndb
	 1hlMkgMx/xwtlkRywytcpbhWV8Ns8E+/U3Q3Nz2uRyAr+XvtUznrbeHGJ5D0hp/pFICjK
	 Fkt71teyCYmTNRyj20QnMb7JK5VfHqp1DRm0lTWLQVTFbou/7ct2OF6cmD+jQepdMk/b5
	 rszrQf43+fVj0OnptgV/L82QG4JuF2OB1x8WE1nSZAc7tz64dQWR1vAn/c9i783eVoMKb
	 eH9Mgz4SienT3a4DNfwr1ftxsIBJ+y3OoMT6XVj0dWyvcmMO/tuowGUtLBfkgrQKVMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=JRBaxCpY;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48322606A325;
	Wed, 18 Nov 2026 10:44:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48322606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=JRBaxCpY
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=N4S0kgZ/NMm9yfsBMXr5qvuT3q1E7nw/7lKsTCmiCBk=; b=JRBaxCpYJ96qIq0CElGGRimB4X
	JUtorWIygmcywk0ejcDfiOTEqYbG4ftpFkvnhWkBc0ouBNBr+1e3i9z9q9mhR9u5G2dsYbzmtn9DF
	+/ZwK8vHiL87VprUZ2UaTUgPF/dSkAGgDlVlJCRI7AfxIZhoHAscvaUSKShiufX6tVdYM5MasjjIY
	xgoFhfqZHmgbH5pkaNq1srRFTk3cMa+oSNvPtJAvRAln5PlNzX68L+aBaUAQKF1rJ8l8VS8MfE56P
	soHs82/14YoQneXCaS1+ZwC10yg1M5TiJTtSx/2JB164e2zx+D+QlACC35191tc1zO/8TvY6sxtb5
	OOORY5Wg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTd8s-0000000COQD-2lAC;
	Wed, 18 Nov 2026 10:43:57 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id CF54F3004C9; Wed, 18 Nov 2026 11:43:53 +0100 (CET)
Date: Wed, 18 Nov 2026 11:43:53 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Daniel Wade <danjwade95@gmail.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Kyle Zeng <kylebot@openai.com>,
	Aditya Chillara <aditya.chillara@oss.qualcomm.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf: Reject group leaders detached by CPU hot-unplug
Message-ID: <20261118104353.GN1813469@noisy.programming.kicks-ass.net>
References: <20261116081248.21059-1-danjwade95@gmail.com>
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
In-Reply-To: <20261116081248.21059-1-danjwade95@gmail.com>

On Mon, Nov 16, 2026 at 06:42:48PM +1030, Daniel Wade wrote:
> When a CPU goes offline, __perf_event_exit_context() removes every event
> of that CPU's context with DETACH_GROUP. That clears PERF_ATTACH_GROUP and
> PERF_ATTACH_CONTEXT and leaves the event in PERF_EVENT_STATE_OFF, or in
> ERROR, while the file descriptor stays open and event->ctx keeps pointing
> at the per-CPU context; nothing re-attaches it when the CPU comes back.
> Commit fa091f46c383 ("perf: Reject exited events as group leaders")
> fixed the same defect for remove-on-exec, by rejecting a leader in a
> state <= PERF_EVENT_STATE_EXIT. OFF and ERROR are both above EXIT, so
> once the CPU is online again a leader detached by hot-unplug is still
> accepted and perf_group_attach() links the new event to it.
> 
> perf_group_detach() returns early when PERF_ATTACH_GROUP is already
> clear, which is right for the double detach it was written for, where no
> group is left to break up. With a sibling added after the hot-unplug
> detach it skips a sibling_list which is no longer empty: the leader is
> freed with that sibling still on it and still pointing at it through
> ->group_leader. Closing the sibling, or a group read or ioctl on it, then
> uses the freed event.
> 
> Commit 42c5ca1f0a28 ("perf/core: Fix group leader use-after-free after
> sibling detach") fixed the mirror image, a sibling detached by hot-unplug
> and the leader closed afterwards. It promotes the sibling from the paths
> below that early return, so a leader detached first and given a sibling
> afterwards still reaches the same free.

Nice

>  kernel/events/core.c |   12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index f5f2261f1fe..21c529cd7d1 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -14274,6 +14274,18 @@ SYSCALL_DEFINE5(perf_event_open,
>  			goto err_locked;
>  		}
>  
> +		/*
> +		 * Likewise against CPU hot-unplug, which detaches the events
> +		 * of a CPU context and breaks up its groups without putting
> +		 * them in a terminal state. perf_group_detach() does nothing
> +		 * for a leader that is already detached, so a sibling added
> +		 * to one would stay linked to it after the leader is freed.
> +		 */
> +		if (!(group_leader->attach_state & PERF_ATTACH_CONTEXT)) {
> +			err = -ENODEV;
> +			goto err_locked;
> +		}
> +
>  		/*
>  		 * Only a group leader can be exclusive or pinned
>  		 */

It occurs to me that changeing __perf_event_exit_contxt() to use
DETACH_EXIT | DETACH_GROUP, will also fix things, right?

In that case the STATE_EXIT check from fa091f46c383 will catch it.

Doing this makes the various cases (task-exit, CPU-offline) behave
similarly.

Does that work for you?

