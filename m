Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6422E27FB3A;
	Thu,  4 Sep 2025 06:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756968317; cv=none; b=jpJ6EKZ+Y3xJN9Rhc8NryxZ/StOvU0ORrASxX7TjX5NaU/K4ThmRO0y+bxq0lXtr5GwceXw6eHKkOHgJxD2EpwVcw2yO5haLR5oEyRCnBmns+he+ku93AfgfCQMEhdusCXTqJO1eRnvaGtyUY9H2w3KSj5bm6MxrY6ije3v1mGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756968317; c=relaxed/simple;
	bh=y6AssyltUEJd/EJo8LBycypmE5jb0bS6gHIzXyIwEOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oyx33gjAvAQ7s5OCKCOeyOxxdynAIvJLKY7b4Ya7wUfbN4XSXlPApAijq+MPLLjpqUofEjyGx8Z35cO2/N3xz0qY7hC9E4Q7SHHZCUFo+LZtWMBTfatJridceRcAi7B6hNPA8NvLk+7HjmWClMXjHqaHfG+iVH/TSqpGZ/k6sJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LV+1vr5T; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LV+1vr5T"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=gZmrHXi/l2Bu3uwxMTV4r6fmpaXludQwzjRHMWeCses=; b=LV+1vr5TnEbOLwYDucpF+T7OIM
	LWIWn5X6Bnn9lXD+SOBNZPAjiFQE9u79hY8ceIoaYVBB+rG4wxes3Rm2SIO/T9SMXtDz1WDDJMAgR
	sEqyVAiZ8dOIT3rwh/d00dqxQja9pydA/vSzSy2tGohH0cMhzwqcl2EOSnawGlVX5x1IoMtLugTxx
	knHvZleoFEyGIIr00wSpr62kKCud3XmrUPYtIXF21hHRhmNQqk8Cn3ZbMtE3wh9dH+km5SACk+lgx
	OZSQvvdwMxJdlJ327jl9dk44f6BgII0+XrrASFOQRMxTzEYlx2jX3U6L47hw44gV4EoJHUl0mah0s
	hU3DEftg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uu3iD-00000004IW4-1Zu6;
	Thu, 04 Sep 2025 06:44:50 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 78BB03002BF; Thu, 04 Sep 2025 08:44:48 +0200 (CEST)
Date: Thu, 4 Sep 2025 08:44:48 +0200
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
Subject: Re: [PATCH v2 06/18] perf/hw_breakpoint: add arch-independent
 hw_breakpoint_modify_local()
Message-ID: <20250904064448.GU4067720@noisy.programming.kicks-ass.net>
References: <20250904002126.1514566-1-wangjinchao600@gmail.com>
 <20250904002126.1514566-7-wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250904002126.1514566-7-wangjinchao600@gmail.com>

On Thu, Sep 04, 2025 at 08:21:03AM +0800, Jinchao Wang wrote:
> Introduce hw_breakpoint_modify_local() as a generic helper to modify an
> existing hardware breakpoint. The function invokes
> hw_breakpoint_arch_parse() and delegates the reinstall step to the
> architecture via arch_reinstall_hw_breakpoint().
> 
> A weak default implementation of arch_reinstall_hw_breakpoint() is
> provided, returning -EOPNOTSUPP on architectures without support.
> 
> This makes the interface arch-independent while allowing x86 (and others)
> to provide their own implementation.
> 
> Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
> ---
>  include/linux/hw_breakpoint.h |  1 +
>  kernel/events/hw_breakpoint.c | 18 ++++++++++++++++++
>  2 files changed, 19 insertions(+)
> 
> diff --git a/include/linux/hw_breakpoint.h b/include/linux/hw_breakpoint.h
> index db199d653dd1..9453b5bdb443 100644
> --- a/include/linux/hw_breakpoint.h
> +++ b/include/linux/hw_breakpoint.h
> @@ -67,6 +67,7 @@ extern int
>  modify_user_hw_breakpoint_check(struct perf_event *bp, struct perf_event_attr *attr,
>  				bool check);
>  
> +int hw_breakpoint_modify_local(struct perf_event *bp, struct perf_event_attr *attr);
>  /*
>   * Kernel breakpoints are not associated with any particular thread.
>   */
> diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
> index 8ec2cb688903..ff428739f71e 100644
> --- a/kernel/events/hw_breakpoint.c
> +++ b/kernel/events/hw_breakpoint.c
> @@ -983,6 +983,24 @@ static void hw_breakpoint_del(struct perf_event *bp, int flags)
>  	arch_uninstall_hw_breakpoint(bp);
>  }
>  
> +int hw_breakpoint_modify_local(struct perf_event *bp, struct perf_event_attr *attr)
> +{
> +	int err;
> +
> +	err = hw_breakpoint_arch_parse(bp, attr, counter_arch_bp(bp));
> +	if (err)
> +		return err;
> +
> +	return arch_reinstall_hw_breakpoint(bp);
> +}
> +EXPORT_SYMBOL(hw_breakpoint_modify_local);
> +
> +/* weak fallback for arches without support */
> +__weak int arch_reinstall_hw_breakpoint(struct perf_event *bp)
> +{
> +	return -EOPNOTSUPP;
> +}

Again, so much fail :/

So we have:

{register,modify,unregister}_user_hw_breakpoint()

and

{register,unregister}_wide_hw_breakpoint()

And you choose to extend this latter with hw_breakpoint_modify_local()
instead of sticking with the naming scheme and say adding:

modify_wide_hw_breakpoint_local().

Also, again, that EXPORT is a fail, these other interfaces are all
EXPORT_SYMBOL_GPL().

Also note that modify_user_hw_breakpoint() doesn't seem to need new arch
hooks. Yet you fail to explain why you think you do.
