Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62192847C;
	Mon,  1 Jul 2024 10:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719831175; cv=none; b=p7dcv5tP51zvJIMW+XlW5jIcGWmUTmVX02RfFewNvgGkdCYG5sCgLWCXY/agTepznv6wE5+VUJ2Rryf/kNI/232mss7XPewTy6/edrVqtNTkCc+itgzEUgoeRzbNs84YjrvpSPD7B5vEilfGmYeLVG3edzJ4q4Qiqo95qGtRgis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719831175; c=relaxed/simple;
	bh=8CLjqINZQd/1Hp4qCrkty2RpztoR4SUii75i1yU3dJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kb0obQJyJ+sDBEQ2eRQ3ywzN6hXPcp4SIVT4MoUlIcIwaURkHbyncJFHAZB2HfAw+ZOHZtx8SypoZNcD8OXzVbTOZDtXionUfzar/Q5OVEfMGr/wj4HZXlNxYF3zZa+OA9ogwHPTr7UOnaC5tfBlbelrhS7D9N1seVQkW5X5Amg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mTQ2GJgI; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mTQ2GJgI"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=MvPshWRAfPtdmhlevsYohTsNBpOkRW+6bZvfZyuBOrc=; b=mTQ2GJgIWfRuKGK1whjOlNnzYO
	NXh2ObV585lcUEcP5KxzoghbGjLLGt3XtG7oXvXFWcYn13FZNAh0X7+RVuYlNVV42zZ4VhjOCrguA
	p5DGX1Az2rS9TwMt2BUjsQqT8kYOyQC5SGKaa0y06MD4/9HgkdYdTjJd67CG4baMdW9waNorFtAxS
	5r+ZKZAxHVSPycpQclK+THJFjhqX4ySnhpv1VZVW8vivOZMQTnAEjv+TTEeA9qF4zOGMTd+XB111P
	rYtIVlWwziCEIPIr0qgulOzmNvMUdBmVFFUK/HVEHFRrGroLbuFmg6HlxhD6aTo3j4ItH+1nzldyL
	nj8+Ic6g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOEeF-00000009dkx-1j8m;
	Mon, 01 Jul 2024 10:52:40 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 0A07C300694; Mon,  1 Jul 2024 12:52:39 +0200 (CEST)
Date: Mon, 1 Jul 2024 12:52:38 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Hendrik Brueckner <brueckner@linux.ibm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@arm.com>, coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	Yicong Yang <yangyicong@hisilicon.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Will Deacon <will@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>, Andi Kleen <ak@linux.intel.com>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH V8 01/12] perf/core: Add aux_pause, aux_resume,
 aux_start_paused
Message-ID: <20240701105238.GC20127@noisy.programming.kicks-ass.net>
References: <20240628065111.59718-1-adrian.hunter@intel.com>
 <20240628065111.59718-2-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240628065111.59718-2-adrian.hunter@intel.com>

On Fri, Jun 28, 2024 at 09:51:00AM +0300, Adrian Hunter wrote:

> +	union {
> +		__u32	aux_action;
> +		struct {
> +			__u32	aux_start_paused :  1, /* start AUX area tracing paused */
> +				aux_pause        :  1, /* on overflow, pause AUX area tracing */
> +				aux_resume       :  1, /* on overflow, resume AUX area tracing */
> +				__reserved_3     : 29;
> +		};
> +	};

> @@ -12860,7 +12930,7 @@ perf_event_create_kernel_counter(struct perf_event_attr *attr, int cpu,
>  	 * Grouping is not supported for kernel events, neither is 'AUX',
>  	 * make sure the caller's intentions are adjusted.
>  	 */
> -	if (attr->aux_output)
> +	if (attr->aux_output || attr->aux_action)
>  		return ERR_PTR(-EINVAL);
>  

AFAICT this is the only usage of aux_action. But in a few patches time
you'll introduce a helper along the lines of has_aux_action() that tests
all the individual bits.

Combined with perf_copy_attr() ensuring __reserved_3 is actually 0, I'm
thinking that should all be enough to render this aux_action field
surplus to requirement, and we can simplify all this somewhat, no?
