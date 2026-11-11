Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794388202;
	b=vyVJMLw9zLWBxPXQrmnBgkVlGUFApVX2g2KG9Fk4CBDBT/1GzFL0QI3HuEm06acJIOv9
	 qmlrvxEQ5IRzZX+t+tbnU5KnoT24/Fm1cY46ShTQ+zKKIossJhmVSqg4OFnKuhNZFCucg
	 RWGKXrdyS85g9OjYnZlUCRYe4wk3q5h6o1I0NFhJsWJr2AUvdVmvnSUv5XMQB7h1MXXAE
	 sKwfllH/INgrIGjo83XCIyCJIMcjVVrEtkfe3v7PuKv/uGZ2ZxBi2wqCzimtK44EmUDI1
	 wCCb4FakN8nWmhOSYkRodUKRIRd6rqcqxCJupmhTMeMumgUXeNNiTMyaN5tnWc0gzdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794388202;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=t+vKK3K8G/SPqdLLDE+tBceKxRVp95UdVCgcrDLkoto=;
	b=Q8IEL+4Zhjx3d7sfdYoHK1m4t9VVzBTEToq91sScOIlYZaGTpTipcmbccr/5lfJP9WnD
	 cHSVNKKzhVC0hzvjSOGv2N2B9hrvYjgv++j6C0jRyNDEztmjbH7HwEOrXjQzFbXhFA8iS
	 oSPa54lJVtWgb+IrEx84jiCjV/L/3acY9lHlGP9N23HuFgN7G5/GfxRcK7uaPn28FOCbo
	 D/rNLhK7RaXV8I1qSTJKEUAuzl3Ct2zC4iLyGXrNDLSCaDX3bEW3MoMV574mo/jerYOzy
	 t7+wf6pdxLiG6OZvA5+wuHm9fvHqSngcyw4YNujE/8++0jwfA37MzMihFeQD873feYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=YFCa6EzB;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8B4606A321;
	Wed, 11 Nov 2026 09:10:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1C8B4606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=YFCa6EzB
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=t+vKK3K8G/SPqdLLDE+tBceKxRVp95UdVCgcrDLkoto=; b=YFCa6EzBrVC/en7V2mI8fs9Dx7
	0YPbhN3gAEkJ3+UXWiE6IDI17eyJYW5eBh5TKyEAG2spovF/8QIeGxD+jachH/d59+PWHcryjW9mV
	tTYNXrggbvfiwJDX5NRyei2dB+VpQOGKAV90Aj8tOia3xykzwbIkuia3KwAfuXRWwWEFbNIb17lmO
	98xJv7nenB68tad867vy7+T/74ubVacDUz3g+XDTzMlrRymrtLuVDZqK9qsMLiFp6o22AaAXBwZ2f
	B5GY4hSsvPhbxa9bksT+3fJdAK4ImbnPeIaRLMt00bslWJYLzjyPIJS0xl5hP1S4iknK4xerbNPQj
	ErBk/zcg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xR4L6-00000008Avs-0ihc;
	Wed, 11 Nov 2026 09:09:56 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B5EF930025D; Wed, 11 Nov 2026 10:09:55 +0100 (CET)
Date: Wed, 11 Nov 2026 10:09:55 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2] uprobes: Use flexible array for xol_area bitmap
Message-ID: <20261111090955.GV2668804@noisy.programming.kicks-ass.net>
References: <20261111022605.66010-1-rosenp@gmail.com>
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
In-Reply-To: <20261111022605.66010-1-rosenp@gmail.com>

On Tue, Nov 10, 2026 at 06:26:05PM -0800, Rosen Penev wrote:
> The XOL slot bitmap has the same lifetime as struct xol_area, but it
> is currently allocated separately.  That adds another allocation
> failure path and a matching cleanup branch without buying any extra
> flexibility.
> 
> Store the bitmap as a flexible array member and allocate it together
> with the xol_area using kzalloc_flex().  The bitmap remains
> zero-initialized, while the allocation and error handling become
> simpler.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  v2: add Acked-by. remove Assisted-by
>  kernel/events/uprobes.c | 14 +++-----------
>  1 file changed, 3 insertions(+), 11 deletions(-)
> 
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index 853fc952331c..876c3cfe8031 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -108,7 +108,6 @@ static LIST_HEAD(delayed_uprobe_list);
>   */
>  struct xol_area {
>  	wait_queue_head_t		wq;		/* if all slots are busy */
> -	unsigned long			*bitmap;	/* 0 = free slot */
>  
>  	struct page			*page;
>  	/*
> @@ -117,6 +116,7 @@ struct xol_area {
>  	 * the vma go away, and we must handle that reasonably gracefully.
>  	 */
>  	unsigned long			vaddr;		/* Page(s) of instruction slots */
> +	unsigned long			bitmap[];	/* 0 = free slot */
>  };
>  
>  static void uprobe_warn(struct task_struct *t, const char *msg)
> @@ -1760,18 +1760,13 @@ static struct xol_area *__create_xol_area(unsigned long vaddr)
>  	struct xol_area *area;
>  	void *insns;
>  
> -	area = kzalloc_obj(*area);
> +	area = kzalloc_flex(*area, bitmap, BITS_TO_LONGS(UINSNS_PER_PAGE));

I am confused; this is a compile time constant. Why are we using flex
arrays?
