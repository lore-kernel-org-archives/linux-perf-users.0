Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A383E27FB30;
	Thu,  4 Sep 2025 06:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756968439; cv=none; b=nzBaqvQHvqbzHOzRwez7RS+DbMeBYIbVUCEFZOAY/0y3wlWOS99Q692SVyQPspI/hd/BQCEI1x6N7k4IMG7K0iXIp14C5q5SBfXS89C8TiQkr/FevIOD04VGJqjaF78yPswFpx6U35E6E0r/9MKpz88uHFNkIklKkmvHUabp+uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756968439; c=relaxed/simple;
	bh=V+KbhRiHSS3Yw9mT+RFbahEQhxzLIfxKllFZYhhIOX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oY9JSxAEwC2BroE5CzrfbGVmg3vbLtgKF9qzlHd/IOg4GGTJCUhjTfyAIGJgpLy30L1eNMq6GLozqKvDZd7K836pAj7TzKUZCW2ZCtmXN+3KiDlSifsqBPglDt7lkW0+0z014LllYy7BoNC3QEZ9bvCsUKqfEshvBUxVqd7Bo9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WzA82SHo; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WzA82SHo"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=efyhR8wHhw8uesblYSnLgPQBPUNCW7rCVpcxJ83V5M0=; b=WzA82SHoMRi9yVKB7fE7LAuc1c
	jsspskezLL1ajqArYYKzI6cX4WAwNcIkBBMtuGNUrV7io6kKfesya8FJMYYysXDzhT5ImjOLY6LFV
	248MTKZQHUNmlfu2GDFS/rdAZg0ZwzLMpkBnhkCCu548qhVx0yqSkFrCciRhTe05ZA4D36cQAIgAF
	uSGincVkuMSsYe6AEzciEecgQynn8iCwaWTJrIk4o8qLMnj04bDec49lcxdEb4sUGgOY8xHaRUya2
	SrO/LvCDU13jdZ3xoZf3iSRb8Uw1HdzRWYccGJKRwrny/suwG+mF2+B1WfIwU77Mz+0C+q3L0/MR+
	dw+7hO0w==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uu3kK-00000004IX4-0HP9;
	Thu, 04 Sep 2025 06:47:00 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 91B3F3002BF; Thu, 04 Sep 2025 08:46:59 +0200 (CEST)
Date: Thu, 4 Sep 2025 08:46:59 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Jinchao Wang <wangjinchao600@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	"Naveen N . Rao" <naveen@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, linux-perf-users@vger.kernel.org,
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 07/18] mm/ksw: add atomic watch on/off operations
Message-ID: <20250904064659.GV4067720@noisy.programming.kicks-ass.net>
References: <20250904002126.1514566-1-wangjinchao600@gmail.com>
 <20250904002126.1514566-8-wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250904002126.1514566-8-wangjinchao600@gmail.com>

On Thu, Sep 04, 2025 at 08:21:04AM +0800, Jinchao Wang wrote:

> +static DEFINE_PER_CPU(call_single_data_t,
> +		      watch_csd) = CSD_INIT(ksw_watch_on_local_cpu,
> +					    &watch_info);
> +

> +int ksw_watch_on(u64 watch_addr, u64 watch_len)
> +{
> +	unsigned long flags;
> +	int cpu;
> +
> +	if (!watch_addr) {
> +		pr_err("KSW: watch with invalid address\n");
> +		return -EINVAL;
> +	}
> +
> +	spin_lock_irqsave(&watch_lock, flags);
> +
> +	/*
> +	 * check if already watched
> +	 */
> +	if (watch_info.addr != 0 && // not uninit
> +	    watch_info.addr != (unsigned long)&watch_holder && // installed
> +	    watch_addr != (unsigned long)&watch_holder) { //not restore
> +		spin_unlock_irqrestore(&watch_lock, flags);
> +		return -EBUSY;
> +	}
> +
> +	watch_info.addr = watch_addr;
> +	watch_info.len = watch_len;
> +
> +	spin_unlock_irqrestore(&watch_lock, flags);
> +
> +	if (watch_addr == (unsigned long)&watch_holder)
> +		pr_debug("KSW: watch off starting\n");
> +	else
> +		pr_debug("KSW: watch on starting\n");
> +
> +	for_each_online_cpu(cpu) {
> +		if (cpu == raw_smp_processor_id()) {
> +			ksw_watch_on_local_cpu(&watch_info);
> +		} else {
> +			call_single_data_t *csd = &per_cpu(watch_csd, cpu);
> +
> +			smp_call_function_single_async(cpu, csd);
> +		}
> +	}
> +
> +	return 0;
> +}

What do you think happens when two ksw_watch_on() instances run
concurrently?

What happens if a CPU comes online/offline concurrently with
ksw_watch_on()?
