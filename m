Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038BA188010
	for <linux-perf-users@vger.kernel.org>; Tue, 29 Oct 2024 12:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730206365; cv=none; b=WTZd1jvbwR8liCAHU/eoB0+COCtVG0M70n0rossRa5B4ysdHJY8RQR7MI2pYBscwKeIsI02GJMEgsfYKTnntb/ExvT8FBcV6y82+sDXPdmZqgXbDxLFqnoeUPMR/btTV96M2HXbepna6XTJDFw+8cvJCixQmKaoV4oEeOGYZCpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730206365; c=relaxed/simple;
	bh=AgS/64H0ikYBHZGxDnekV0MxouKseVkwrQmfNTHL1PQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CUHKz4ufypLqnAK8mHLs0TuY2T36WVMOnL/inzTF9nGkNDHBvgIu/lqBtmV9I9UsE3aVER0NYZ5SFqTqo5rZ5MxDXIHpTbYDorj+1Q0DkQMvJyyMZeSDCe9eKNEaCuzx1RnB1cP6LPIC/Eu0o4jwMTk0/iV3d62FU0E/mD1DDK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=IlLtdpM2; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IlLtdpM2"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=AiJMYaj+Oz6Trnr28FGPzdigBnQQLVU5+zJp2nxFeW4=; b=IlLtdpM29j1t/0GX86IkUs4K83
	2nZycEzcY4ADJ2QGtsPfiA4MkLiVBGUPvXWwn7wd0RTuKLeJ3KyuGosizC1XZmXkT7dFVok71cPLZ
	GbsO8HYPxiFVp0rDFGjN4T8tLzbJTCq70g82fJtFC02SPhYQXhQXJotK/pnmKbwv0TZMwSxpUANiY
	ETChGU9w6OqPM2I9/c3jcxXdStTiQpq0/9aw9RZWrGNcLuLiJSFq851l0Oe5Q+zz7vjC2DjUBhlig
	S00PNGgXlYzocM++gdDSR1mfqZQ4ftOcjxb8vPv9byjNNpDBcqpQNmuKFj5uuvZOaxvfmFBwXnbpS
	C6NqWPRQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t5li3-00000009hxI-2CvK;
	Tue, 29 Oct 2024 12:52:32 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 215FE30073F; Tue, 29 Oct 2024 13:52:31 +0100 (CET)
Date: Tue, 29 Oct 2024 13:52:31 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Gaosheng Cui <cuigaosheng1@huawei.com>
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, ravi.bangoria@amd.com,
	wangweiyang2@huawei.com, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH -next] perf: Fix possible null-ptr-deref in
 __perf_pmu_install_event()
Message-ID: <20241029125231.GU14555@noisy.programming.kicks-ass.net>
References: <20241029015347.476375-1-cuigaosheng1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241029015347.476375-1-cuigaosheng1@huawei.com>

On Tue, Oct 29, 2024 at 09:53:47AM +0800, Gaosheng Cui wrote:
> The function find_get_pmu_context() returns ERR_PTR(-ENOMEM) if kzalloc()
> fails. It is crucial to verify its return value before dereferencing
> it to avoid a potential nullptr dereference.
> 
> Fixes: bd2756811766 ("perf: Rewrite core context handling")
> Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
> ---
>  kernel/events/core.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index afada11ffb9f..4ff45e320314 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -13177,6 +13177,10 @@ static void __perf_pmu_install_event(struct pmu *pmu,
>  
>  	event->cpu = cpu;
>  	epc = find_get_pmu_context(pmu, ctx, event);
> +	if (IS_ERR(epc)) {
> +		put_ctx(ctx);
> +		return;
> +	}

Supposing this is true (hint, it isn't), then you've managed to
'fix' a NULL deref with silent buggy behaviour.

Is that an improvement?
