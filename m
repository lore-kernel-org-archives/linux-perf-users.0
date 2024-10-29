Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B2920110B;
	Tue, 29 Oct 2024 13:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730209772; cv=none; b=saG/ExIinBLWIe0alDoj6GnZqPXZhrhPJZ7irOUpa7kAQTTsnH6HvtxDDBK5iQtvczcVrX2h5XapAA1FpMC+PJGuhLyyf5CUbMzXP6ucIH2zQZ6VCDq2jzKPiId2A8WlXFJsaDtYrJYZwrmMPL1do5H//VqGPwa63RU2DJQNk4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730209772; c=relaxed/simple;
	bh=C/ScIlfAb593FeK9w8ZSP3kiikc6hHoA8f0RrZWiq2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D20k3tohfYoe9dhEC90PasorSC3W3YeVBvVdp3W2LPQPRz4PHFOwiyVmnE19m8vYwmAAuBxr2IcIt/P7fA0MpRpyGU9dp+KCAvePy0zwLbtDXTG1/0u4mk6xdtVBNsb7xV3UxUzNiWaMAMEQLmwkco8PfPBp3FahYvi5GivePnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lhBawctP; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lhBawctP"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=2So21KyGv/lGhqEP+pOczTZjGr3niJl2qAKbXe3sW10=; b=lhBawctPuBRihfvYcTJTAxAQBP
	QlAaIinlH4dap5F73nMnOds/W07vkC15/Z9GxhHBRElR4sOOkig6TZ2mf9iT2CpVFa1pVoZDFb7tZ
	Ujag/Kw/WBjK3bm09OjJHZdB558VoiYtLRcqOYkE3uNGoEf1VYEyoPE0WoYUcp6i92/8oVVm4H2VC
	ZKKamGxIxE8egjn+Qy9ZOj6AiCJMf+lcu9hBAfD/RnU6hX27/mdHp6EyBx2Uq+oAgpjBtk3XBl5qy
	+g2IK5PYdpnlKVoQHX3ru1Cwtf4ZkPRkUb0IO2ER+bolnUJzSOH3oU7kowrpTGTN2Jo27JNjD10qs
	yvBTOW8g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t5mb0-00000009uSM-2SON;
	Tue, 29 Oct 2024 13:49:18 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 4174F30073F; Tue, 29 Oct 2024 14:49:18 +0100 (CET)
Date: Tue, 29 Oct 2024 14:49:18 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	linux-kernel@vger.kernel.org, Indu Bhagat <indu.bhagat@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, Mark Brown <broonie@kernel.org>,
	linux-toolchains@vger.kernel.org, Jordan Rome <jordalgo@meta.com>,
	Sam James <sam@gentoo.org>, linux-trace-kernel@vger.kerne.org,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Jens Remus <jremus@linux.ibm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Florian Weimer <fweimer@redhat.com>,
	Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v3 11/19] unwind: Add deferred user space unwinding API
Message-ID: <20241029134918.GA14555@noisy.programming.kicks-ass.net>
References: <cover.1730150953.git.jpoimboe@kernel.org>
 <a94eb70a80c4a13dedb2655b7848304a992cb1b0.1730150953.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a94eb70a80c4a13dedb2655b7848304a992cb1b0.1730150953.git.jpoimboe@kernel.org>

On Mon, Oct 28, 2024 at 02:47:38PM -0700, Josh Poimboeuf wrote:

> +static void unwind_user_task_work(struct callback_head *head)
> +{
...
> +	guard(rwsem_read)(&callbacks_rwsem);
> +
> +	for_each_set_bit(i, &pending, UNWIND_MAX_CALLBACKS) {
> +		if (callbacks[i])
> +			callbacks[i]->func(&trace, cookie, privs[i]);
> +	}

I'm fairly sure people will come with pitchforks for that read-lock
there. They scale like shit on big systems. Please use SRCU or somesuch.

> +}
> +
> +int unwind_user_register(struct unwind_callback *callback, unwind_callback_t func)
> +{
> +	scoped_guard(rwsem_write, &callbacks_rwsem) {
> +		for (int i = 0; i < UNWIND_MAX_CALLBACKS; i++) {
> +			if (!callbacks[i]) {
> +				callback->func = func;
> +				callback->idx = i;
> +				callbacks[i] = callback;
> +				return 0;
> +			}
> +		}
> +	}
> +
> +	callback->func = NULL;
> +	callback->idx = -1;
> +	return -ENOSPC;
> +}
> +
> +int unwind_user_unregister(struct unwind_callback *callback)
> +{
> +	if (callback->idx < 0)
> +		return -EINVAL;
> +
> +	scoped_guard(rwsem_write, &callbacks_rwsem)
> +		callbacks[callback->idx] = NULL;
> +
> +	callback->func = NULL;
> +	callback->idx = -1;
> +
> +	return 0;
> +}


