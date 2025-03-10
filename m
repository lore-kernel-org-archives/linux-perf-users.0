Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8BA227E9F;
	Mon, 10 Mar 2025 12:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741610930; cv=none; b=i8VbviLFGU/nzdHvmwY+VQoit9+o6IuvMquZ7ZwXgvs2Mn/xqiMoKTBUjJlmpGh8DdrPmOWAVOf52CYAveTFBpEXDq/uPCE6X9usX9BJ1nMwKUTf4fo483ng2Abv1XP0BzpVwpyUeWLsVLfWwIFL9ZUTXwRP3oeKNg2tGTqRgaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741610930; c=relaxed/simple;
	bh=Ruo9ud0HtzeGKf+fHj+F1i6t6C4nyt+byb1qSbd1ZR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kSKk0d8MiScdiDtXXiBy5H7zcHOWcEkhOqtujFfgvKlcld6J0770DEVkTToPsl8EZv2wyBaxbAHQY9fMbv+Y0Jdhz8W6fo4DZwsCczYy7ZjVRThsSbgCGZVdXfJ3iwfgswAWh2JMk9pqheohavqh3h5IXqDZnYe1cwQEwzAjZZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nWasINNf; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nWasINNf"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=c9xkd6KV/yatAwNNckPZRDG5c5f7LM7Kmzqj5CpIduI=; b=nWasINNfzooGM/hrmXrNrPZF6C
	OYAs9EBgKsE253ifuOMhGE2KdBzGLKQi4s8YPzW7TcYndXMonGHvONZ8/01T8QUPkmnSfMefsqEMy
	EM44TQ4pFOxyMp/JuQi6sAnbu+fpUD0XuxaLXSmTukzVMbyRlH8TTUwzVNxFBRQQnl+IXJBGo5JeN
	q8waFEtmQ8tdSO4N9wcSrgPPitM2bGIwyL6dGhVMFwZIs2jfDwlaWTkfO3uOloWXC+rn7SEN7JuD2
	mAjsRyd+gssxXhmCT4qWfFNEcsmZYQmLYKEOeTMeQE1wAO+ZbOoL0ysPAaKCzNjb4ds1sMpYfr+Mk
	vLgmGhkQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1trcXh-00000004eMw-0KMx;
	Mon, 10 Mar 2025 12:48:05 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 898B1300599; Mon, 10 Mar 2025 13:47:35 +0100 (CET)
Date: Mon, 10 Mar 2025 13:47:35 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: mark.barnett@arm.com
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
	irogers@google.com, ben.gainey@arm.com, deepak.surti@arm.com,
	ak@linux.intel.com, will@kernel.org, james.clark@arm.com,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, adrian.hunter@intel.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 3/5] perf: Allow adding fixed random jitter to the
 alternate sampling period
Message-ID: <20250310124735.GR5880@noisy.programming.kicks-ass.net>
References: <20250307202247.648633-1-mark.barnett@arm.com>
 <20250307202247.648633-4-mark.barnett@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250307202247.648633-4-mark.barnett@arm.com>

On Fri, Mar 07, 2025 at 08:22:45PM +0000, mark.barnett@arm.com wrote:
> @@ -9922,7 +9923,10 @@ static int __perf_event_overflow(struct perf_event *event,
>  	if (event->attr.alt_sample_period) {
>  		bool using_alt = hwc->using_alt_sample_period;
>  		u64 sample_period = (using_alt ? event->attr.sample_period
> -					       : event->attr.alt_sample_period);
> +					       : event->attr.alt_sample_period)
> +				  + (event->attr.jitter_alt_period
> +					? get_random_u32_below(2 << event->attr.jitter_alt_period)
> +					: 0);

So, ... this here is NMI context, right? Have you looked at the guts of
get_random_u32_below() ?

I would strongly suggest you go do so.

>  
>  		hwc->sample_period = sample_period;
>  		hwc->using_alt_sample_period = !using_alt;
