Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795187010;
	b=vFwYlobBranvoZAWEj9t/kATwPDUuVO0dSM+HAoQIKCYs7/HiiDFmB3b5n4mIegfWgfn
	 /LW5UolzDw1oOWi2ybYGSKLCYXDgNDvm7loY36GkuGsgTcO9J1LT8BTmRGbCPbjlXr+uy
	 bguOns984OBt1FJDXsqBzxCTEJarB6NpXLsW+59Ev1z2f2nOpt7/7H/f4GvxuzwAu1uwm
	 cGomuwTzvWDWeEDf9rRQhOtVboWWFRlFF2D/5ZNw/qMjjKJyRcjUokgi4niybkkzZC6to
	 OtUn93geDYn63IC/TIFjoNOaTXLbQRNkHjeBJfP+KjM4oySWpEbE0eGPWFCsijXhgEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795187010;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=fvkyUjxL9ZoCNsldL2/7evVfO66l1h2mjXG4ejQxtI8=;
	b=UK0dSprv/qUCY5NyuZG3N2qqyiv/rWvLt8MwJDM7L03GDtwgVa50Isuj1QYZXTjbrboH
	 1wZWxh0uxEcnoT5mQgr6bdFdPg//qk9raVaZ3TC+dyCySUStatkblJAXLDv4uM1W8y07x
	 205dfyCzjOL3yJjKgkK9uuEhmPjisdY7lhtBoaC1EsLoI8bG6moHuxuIE1Lqngc8rPLuZ
	 spoSTMolUCzApAUpBqliydoYrVivm5vMtpb5pmvLbu4CGz4GtD4LG9ZyxLPU9sczaKyou
	 MQ5BdvumFsZ8ndk9VeRyn+WjIqOTXojICEbXlKUfPZ4wMJQo7c6xA2sTmzPSqo66Ggg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=kFjPXEtn;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBBD606A33B;
	Fri, 20 Nov 2026 15:03:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DDBBD606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=kFjPXEtn
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=fvkyUjxL9ZoCNsldL2/7evVfO66l1h2mjXG4ejQxtI8=; b=kFjPXEtnZGIo+ELMkIM96umTyQ
	AtWq/NBU5bdY2S1cjluBF8GEEThJZG0qXbe+0rTZ6ZcFmAKXQ/l7i0ajRxsxEO8ukpvINOIGsrg7l
	quWBEeIAaIG47ukuV3WGqFMWBTml4iudQWwab+JPrCEMc/GC/VS7cwkKGdcAaUIjwJhyzPy5uKfjk
	cf4RADxdnEM93KsBah86iIIjc66SGwPN3NyrUjjBFFaFddPIk/JpheE0dwGzG/kK09ItS8lmE9OjF
	p004VUBNaapZlsA7dhGfmZsNFnA6cBVWeXv+W5GK3TpW0vAxf1sfL2Vf04ByWe/Yd+AX5wMbsHsq8
	VVujwunA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUQ93-00000006X6N-3zaP;
	Fri, 20 Nov 2026 15:03:22 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id E5BA13008D6; Fri, 20 Nov 2026 16:03:20 +0100 (CET)
Date: Fri, 20 Nov 2026 16:03:20 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev, linux-perf-users@vger.kernel.org,
	loongarch@lists.linux.dev, Mark Rutland <mark.rutland@arm.com>,
	Ian Rogers <irogers@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Oleg Nesterov <oleg@redhat.com>, WANG Xuerui <kernel@xen0n.name>,
	Will Deacon <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>, Waiman Long <longman@redhat.com>,
	Clark Williams <clrkwllms@kernel.org>,
	"Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
	James Clark <james.clark@linaro.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Chris Zankel <chris@zankel.net>,
	Max Filippov <jcmvbkbc@gmail.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ada Couprie Diaz <ada.coupriediaz@arm.com>
Subject: Re: [PATCH v5] ARM, ARM64, LONGARCH, XTENSA: Delay HW BP
 notification to task_work()
Message-ID: <20261120150320.GQ2668804@noisy.programming.kicks-ass.net>
References: <20261120144553.TjgAd_G6@linutronix.de>
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
In-Reply-To: <20261120144553.TjgAd_G6@linutronix.de>

On Fri, Nov 20, 2026 at 03:45:53PM +0100, Sebastian Andrzej Siewior wrote:
> Waiman, Luis, Ada reported that HW breakpoints on ARM64 trigger
> "sleeping while atomic" warnings on PREEMPT_RT. The hardware event is
> delivered with disabled interrupts and perf intrastrucure expects
> disabled interrupts while the overflow callback is invoked.
> 
> The callback then sends a SIGTRAP signal for which it acquires
> sighand_struct::siglock, a spinlock_t which becomes a sleeping lock and
> must not be acquired in atomic context.
> 
> Delay the event callback until the return to userland.
> Add perf_hwbp_notify(), a generic perf callback which delayes the
> actual callback invocation to task_work_add() callback. This callback
> invokes the architecture defined callback perf_arch_hwbp_send_sig().
> This requires struct callback_head and the functions require
> ARCH_NEED_PERF_HW_NOTIFY to be defined.
> 
> This was reported against ARM64. ARM, LongARCH and Xtensa follow the
> same pattern are also converted. Xtensa is the only not supporting
> PREEMPT_RT but now we have all architectures using the same pattern.
> 
> Fixes: d8fccd9ca5f90 ("arm64: Allow to enable PREEMPT_RT.")
> Reported-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
> Reported-by: Waiman Long <longman@redhat.com>
> Closes: https://lore.kernel.org/all/aho0eqjMESuHxECr@redhat.com/
> Reviewed-by: Ada Couprie Diaz <ada.coupriediaz@arm.com>
> Tested-by: Ada Couprie Diaz <ada.coupriediaz@arm.com>
> Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---

Mark; you was going to stare at this :-)

I'm thinking the archs are doing it wrong and should be sending the
signal elsewhere.
