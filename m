Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46699469D;
	Tue,  2 Sep 2025 07:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756797960; cv=none; b=VpXSWSdA/CP3r30knYGJHhK8dsv6mGzkyXVzJHDl7uxxR/0Q9rlkiPPt6GwEIwt+xeG6i44fMSKlCN3sjWMR85jI3axWpVfMmruE0syxzazCJOa6JCdIj5mZ5HHXhjuX29DIRoJjgpLSuDNgx9Dwi2cpejP0EyimXeXavw1MPDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756797960; c=relaxed/simple;
	bh=o6x3XwnesQDDmeLegEJ5eW1wXByzf9Oe3An9+C4zs+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qQyZjWWwFCj9Eyuetome7ZNvcGWCAFlTf5DD0wBRUFgJz5Vit5AFaPgiSEiMQwG6E/MV8kMoRhx/35qy3BStJtfh1RIj85NNa0X2l3plzyJ9OQIRlOkAJNSrOrp4DimJyCpQJg+VTFWgiQk7UWSfY1fEJufRJ/fMtFCBrrFnTpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=i1Owkx2r; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="i1Owkx2r"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=dz1ceWnZXo4B0qGAWeNu9tznsutRy2a+hLaPzKpp8aM=; b=i1Owkx2r4j8LbmnwbmF2kgzq7t
	Ph5caIj/3w+fYMruvADDrQknU6tRuI4jxCmJN3uaElyA5C+242Y2CvDbmj1AXxTMCMZ1l9HFUAa1/
	oyP3edANsa/rTGGVXtM4vYogzV2ad8qkCQqd7kGFtNsobbebRbPvCQevYIfoaga5eiWrkBBJZuBrK
	xNhEjZThZ9v4ATkWV/7vfAbZwddRGCxirZfjTZzRa5RfwuTo/L5FVva8FhfDyRW1DRO7RJcABmQJY
	rmYR0BMLHJ+3uuSPeA36QHp/5Mf8wiyZ1U9qZhKzQX4ISCNGfP9yqapU52fzxJPDSUWnbXSDnaDSc
	70P1BguA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utLOo-00000002S7u-3Vd2;
	Tue, 02 Sep 2025 07:25:51 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 45D7030039F; Tue, 02 Sep 2025 09:25:50 +0200 (CEST)
Date: Tue, 2 Sep 2025 09:25:50 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Xichao Zhao <zhao.xichao@vivo.com>
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf core: Replace offsetof() with struct_size()
Message-ID: <20250902072550.GJ3245006@noisy.programming.kicks-ass.net>
References: <20250902034349.601692-1-zhao.xichao@vivo.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902034349.601692-1-zhao.xichao@vivo.com>

On Tue, Sep 02, 2025 at 11:43:49AM +0800, Xichao Zhao wrote:
> When dealing with structures containing flexible arrays, struct_size()
> provides additional compile-time checks compared to offsetof(). This
> enhances code robustness and reduces the risk of potential errors.
> 
> Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
> ---
>  kernel/events/callchain.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/events/callchain.c b/kernel/events/callchain.c
> index 6c83ad674d01..0f88e44af664 100644
> --- a/kernel/events/callchain.c
> +++ b/kernel/events/callchain.c
> @@ -80,7 +80,7 @@ static int alloc_callchain_buffers(void)
>  	 * accessed from NMI. Use a temporary manual per cpu allocation
>  	 * until that gets sorted out.
>  	 */
> -	size = offsetof(struct callchain_cpus_entries, cpu_entries[nr_cpu_ids]);
> +	size = struct_size(entries, cpu_entries, nr_cpu_ids);

None of this code is needed anymore; that issue with NMI not being able
to access vmalloc memory should be long fixed.
