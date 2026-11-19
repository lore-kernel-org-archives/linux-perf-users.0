Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795090169;
	b=d8Nm85L+mHyeZAiQ5By9ac54VdyomwIpxl13SCW/jAwGv/fGfWyS4rNR3FOzqcV4pdlJ
	 D0DW1oDlDkhU7Tdec/QQ4JTrasV475UYFYuBrI5GlraLwQyASJceJzQJ6n++9iVbPdGlm
	 6KglFfJSsw9IIPCJNnyOwyEBcgq5wmn29SfUTOVYWXqZBEUT4Mt1/S0vX8rb8BXK68bBC
	 VhjpThJWlNTmKg1V/AJHqJdI5uPqafl+uupg6Woq9JaCronvdte3KjDhKiOwH9WPkytEb
	 K6dFNctNn8dZQi2fpU/yzxfMZaLwKQhH6MlhwhCdRfUhcZSudqe1SHTm7SGtSmaPUYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795090169;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=TUDOVlWmZnXMKNe+ZNA7KaG2nGMjD/Q1uW1+mIIZvBA=;
	b=Od4jj7PVQUDYUx2djGwJ3ZRN6Sn4EsUbEf6cO8CaDVOHO72SVtGHtV7dPD1r22d8LAs5
	 LtwllZaL9GiurfQo12c/IZwliaTkMF/WGvFwxO3R4tAzd2RF5nKAbU/9yLwlz57QNMwkB
	 8U+BtV3+F5G7oIARJ+JnpQVOCSp80esEsDX8KbMwxQRYz7NCim8lNIrdK7ml8KB9NpQjB
	 qAhNj4PqvWiyr+nCnC5Lnd1NYnnNDGgWiOFtzQgg2/NmJFBDCTqsXnzICWqjoPzG9MlHX
	 d4HoW7nIdu6l94tV6XxgoNtWDS85J7IPS0OWXBWotJkcP3c6kw3Fi+GDpZzhrRFpTww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=Vi3GD9OS;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b="hi/whsCn";
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A62606A32F;
	Thu, 19 Nov 2026 12:09:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9A62606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=Vi3GD9OS;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=hi/whsCn
Date: Thu, 19 Nov 2026 13:09:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1795090167;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TUDOVlWmZnXMKNe+ZNA7KaG2nGMjD/Q1uW1+mIIZvBA=;
	b=Vi3GD9OSwjdLZ9183q5e2EwjfgLd37sDsYqxn6W0UtatLC9jk41h/0NMMWCVUkkH87sL9L
	7hPJn4hv2VKnRgovp23MXA36UtzwNZH9Fz3D1LbLkDq5ShasLYIQZP6r8xOJCRp9X4GWra
	cVX36QP0nhfavIyINoSXOp0fufzhsKRtuCbtxd9Lm/LHd3wRnaG8RfBgd05PyjA91N4o9o
	2YYMp67YL5cigdA6yApJm1VexiQk2Ax4XXIVU292bvNkdSkWTXFqKv2kMvZWZWw8/vt38k
	cjEtlT4lGzFWQEG8yVoYVcykVtEJ0m4pC5aw+WoxJ0lNh10HerZzfYQYwyqbsg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1795090167;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TUDOVlWmZnXMKNe+ZNA7KaG2nGMjD/Q1uW1+mIIZvBA=;
	b=hi/whsCnOXK/awZNDHC8V6uE7sOVQpnBDrG/RYkZZo8/ZpvjqEYBmHCwGLeW2a62qCWu3R
	lcAHfibiJsphu8Dw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Tengda Wu <wutengda@huaweicloud.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/2] perf/core: Prevent duplicate sigtrap task work
 enqueue
Message-ID: <20261119120925.Ecvw25kh@linutronix.de>
References: <cover.1795053619.git.wutengda@huaweicloud.com>
 <45bd71c976aea1a0e8bf5762dd6b6552e6009439.1795053619.git.wutengda@huaweicloud.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <45bd71c976aea1a0e8bf5762dd6b6552e6009439.1795053619.git.wutengda@huaweicloud.com>

On 2026-11-19 09:51:00 [+0000], Tengda Wu wrote:
> The sigtrap handling in __perf_event_overflow() checks
> event->pending_work before calling task_work_add(), but only sets
> pending_work after the task work has been queued.
> 
> This leaves a window where an NMI can interrupt task_work_add()
> and re-enter __perf_event_overflow() for the same event. Since
> pending_work is still zero, the nested invocation can enqueue
> the same pending_task again.
> 
> The re-entrant call path looks like this:
> 
>   __perf_event_overflow()
>     task_work_add()
>       kasan_record_aux_stack()
>         <NMI>
>           __perf_event_overflow()
>             task_work_add()
> 
> The nested invocation may enqueue pending_task before the
> outer invocation does. When the outer invocation resumes, it
> inserts the same task work entry again, potentially creating
> a cycle in the task work list.
> 
> As a result, perf_pending_task() may be executed repeatedly,
> leading to unbalanced event reference counting.

The repeated task_work_add() will corrupt the list.

> Fix this by atomically claiming pending_work with
> cmpxchg_acquire() before calling task_work_add(). This ensures
> that only one invocation can enqueue the task work, even when
> another overflow occurs re-entrantly from an NMI.
> 
> If task_work_add() fails, clear the claim with
> smp_store_release() to allow a subsequent overflow to retry.

"to revert to previous state".

> In perf_pending_task(), defer clearing pending_work until
> after perf_sigtrap() has completed. Use smp_store_release()
> to ensure that a subsequent overflow cannot re-queue the task
> work before the previous invocation has finished handling it.
> 
> Also use smp_load_acquire() when checking pending_work in
> the exclude_kernel warning path to ensure the read is properly
> ordered.
> 
> Fixes: c5d93d23a260 ("perf: Enqueue SIGTRAP always via task_work.")
> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian
