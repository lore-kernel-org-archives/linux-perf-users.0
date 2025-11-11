Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC1F261B8A;
	Tue, 11 Nov 2025 13:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762867829; cv=none; b=iy0bB7cAA94vDWW8nedu+7V4IKXx7fx1tTT7qFU6ZkjcuV88V7sWgmY42Wgh+D6MPcv8+AyLHGxtSVrSy2WxiupIeIM0Ku7q7Wc9xdL3sq+ebtz/yiqgRdXq7x8FaokD78zn/UFWZMsGvYZFONgL+CXffeKLTmine9ntWj/L/zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762867829; c=relaxed/simple;
	bh=bF2Itc4QySqrWk46WOXPnAM1dW3/5wrclk+0WNC3B/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ew3N3htnvTIbOrrN0YHougIhDNdxFvw2qqeWxOCj/RQE4dCq62QHjbG9TgFsiG5QTJ3gVfuYF0SZauWpAkzqFrGXpzsyfWJJ7QdTLVieJ0zpx29i4HslhuoiVehfiNrkw21m3Yluu5ro5jfXlUAWXF7JfV80oG96y76Uq0ECmaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bMT6vELf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+/6v5WvR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bMT6vELf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+/6v5WvR"
Date: Tue, 11 Nov 2025 14:30:23 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762867825;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dicw9R/FuDXh/9SkmjZZ3oQxoKblN46We9FAQNIidZk=;
	b=bMT6vELfr/Pb8aQ0ZUdGxWNQl+1SYlFrEKkfbpGS7JKqPxCfyA6Q9hk1Ig+uXYn+sDiX9F
	sInG5bhYXIygf/pJUSJN5iz45JZfbJGywVqDaT92HiCJ6G2vkP6TD7UweRmTVFUDR+Wadf
	y8YmfoLS//M+oB7vbbmvIDKteY/XnJwv2EdUIPvaXQ+AaSvft8ARDSUWb9DKBSWsnI3SVT
	nvXMJ4aG20ir7A5COQrnurbdsAiahPq7E7zxvj20OJSYXCVBwgyzOcKi5S7AvTzvegBLm4
	xHUok+XKmvGVI+chgAqvxW1xl5ROkIDdbixBIbzcNIroAUbjnT/yoQF4KV3q/w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762867825;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dicw9R/FuDXh/9SkmjZZ3oQxoKblN46We9FAQNIidZk=;
	b=+/6v5WvR6R/gnZ7adCL6VahikeRbs0DOD5KjSNS9UiwXRajwedqQW7c/ie10gzPmqOfqic
	v268xtOZ41Rg0VDA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Liangyan <liangyan.peng@bytedance.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com, james.clark@linaro.org,
	zengxianjun@bytedance.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] perf/core: Fix pending work re-queued in
 __perf_event_overflow
Message-ID: <20251111133023.YqDNgQak@linutronix.de>
References: <20251109103253.57081-1-liangyan.peng@bytedance.com>
 <20251109164122.80138-1-liangyan.peng@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20251109164122.80138-1-liangyan.peng@bytedance.com>

On 2025-11-10 00:41:22 [+0800], Liangyan wrote:
> We got warning below during perf test.
=E2=80=A6
>=20
> A race condition occurs between task context and IRQ context when
> handling sigtrap tracepoint event overflows:
>=20
> 1. In task context, an event is overflowed and its pending work is
>    queued to task->task_works
> 2. Before pending_work is set, the same event overflows in IRQ context
> 3. Both contexts queue the same perf pending work to task->task_works
>=20
> This double queuing causes:
> - task_work_run() enters infinite loop calling perf_pending_task()
> - Potential warnings and use-after-free when event is freed in
> perf_pending_task()
>=20
> Fix the race by disabling interrupts during queuing of perf pending work.

Makes sense. Lets it does not overflow in NMI, too.
Either way I suggest to trim the commit message and remove the
backtrace as it probably does not add any value.

Sebastian
