Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A449352036;
	Thu, 13 Aug 2026 11:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786619157; cv=none; b=PRS16on0CohMDsjl2lrtya+uXa7LyX6+cSQq6+Gdw1/1nAKhp6LYm/Cw2y4OeJTE3pN7CULJ+GZavaAaBtWyVZ1POr+/xhBKi1+0rWU8oBlFOtEPuAW0pA/plRiStCeZnBe3UnvsGP+m39iW4F20EPOO6wI/qwSo9+WpvW27EIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786619157; c=relaxed/simple;
	bh=YUi3fAbuH6/KviIr4RDgWkEk5FfP4Wav3UaS8hB3BO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g5SFzOIC/WbqCwf595Lk8efAgTjfeoPiwg9kzPcdevnGmfwfAjjPeA+UmXWGSMZIsWa6HmbC+LQvp7vZXUm2jiNbJ1CdTZNVZ48QIZLDgFm2aKML0aMuPVMmJlMJLf89i2msAdoBdy/9GArDSMadUO1JvujRbrCIz2/ZUCCneYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CZEg8LJ5; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CZEg8LJ5"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=JVhJJ5Pl9spyG2sH/U/1uA1mmtKo0P87rYxPoiXDRvE=; b=CZEg8LJ5dGerroWMv6in3X5mHH
	RSKBp7fTMiuX4qJZ0a2AAgQMcS5oBT3TNCNyYpVC3ssQfSctRGkALHvkPUxSneEybBCdgi+jK/Nt4
	YYr/dZJJblsTeAyP8WnLmLp/U7UYvMKA0JHczZJapJHPGy3NsRRHZg4ECgJPd1tfsYSI+kFf9V7dH
	I1N7Tfxj6keMUqvkr1Rz6aV2C9iwjKUrI1C+8OdQ08YzwEVMMaM3WT6mLEuUdKUj6yhjzCUCHurxf
	LtU8iL5/cfODa7e+Rc76pMfGTT2igA4w4hi+ADS9QsW5lof0aL3cNMNML3p8KiQ2B4VgTfn3wDgI+
	9V9yLatw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuTFd-00000003U0l-27lj;
	Thu, 13 Aug 2026 11:05:33 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 446A4300CB5; Thu, 13 Aug 2026 13:05:22 +0200 (CEST)
Date: Thu, 13 Aug 2026 13:05:22 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Deepanshu Kartikey <kartikey406@gmail.com>
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, olsajiri@gmail.com, irogers@google.com,
	adrian.hunter@intel.com, james.clark@linaro.org, song@kernel.org,
	kpsingh@kernel.org, mattbobrowski@google.com, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
	memxor@gmail.com, martin.lau@linux.dev, yonghong.song@linux.dev,
	emil@etsalapatis.com, rostedt@goodmis.org, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	syzbot+651d2774bd1d8395595f@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] perf/bpf: Fix data races in BPF perf event handling
Message-ID: <20260813110522.GD1246887@noisy.programming.kicks-ass.net>
References: <20260813060528.365959-1-kartikey406@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260813060528.365959-1-kartikey406@gmail.com>

On Thu, Aug 13, 2026 at 11:35:28AM +0530, Deepanshu Kartikey wrote:
> Fix multiple data races involving event->prog field:
> 
> 1. __perf_event_overflow() reads event->prog twice without
>    synchronization creating a TOCTOU race. Fix by using READ_ONCE()
>    to capture prog into a local variable and pass it directly to
>    bpf_overflow_handler() to avoid a second read inside that function.

Well, first you have to show there is concurrency where this matters,
since I still don't believe in your next point.

Also, there's actually worse issues when you consider ->prog and
->bpf_cookie form a pair.

> 2. perf_event_set_bpf_handler() and perf_event_free_bpf_handler()
>    perform plain writes to event->prog without WRITE_ONCE(), failing
>    to pair with the READ_ONCE() in __perf_event_overflow(). Fix by
>    using WRITE_ONCE() in all write paths including
>    perf_event_detach_bpf_prog().

As I said yesterday, how can perf_event_detach_bpf_prog() run
concurrently with __perf_event_overflow()? Unless you answer that, this
patch ain't moving nowhere.

> 3. perf_event_alloc() reads parent_event->prog locklessly during
>    fork() which can race with a concurrent detach clearing and freeing
>    the prog, potentially causing a NULL pointer dereference or
>    use-after-free in bpf_prog_inc(). Fix by holding bpf_event_mutex
>    when inheriting the BPF program. Make bpf_event_mutex non-static
>    and declare it extern in perf_event.h so it is accessible from
>    kernel/events/core.c.

This seems like a separate issue and should thus be a separate patch.
