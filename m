Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A66275860;
	Tue, 19 Aug 2025 10:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755599206; cv=none; b=Tk/B4rs8jiv1IazhNpvo7sTbJ2tNyMGO1P5SXu3j6gJaNKJU47pcZe/9JUcWXatgm8xlD8bGzK58fj2IT8xu0stgGoVJ5jtiE0FT6ZSGPYTmd2IFb/34IR68TML2d9uo4DtgdtLBMe/aG9f/dRyPD1cza8I3+uWQyuOIhAGHNrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755599206; c=relaxed/simple;
	bh=7yoFpviv7y4iqdmS6H1TONkysfR98qLahaGcdvZS2eQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PuTZHyZxnhGO0Q6gQqJ+0DPeI/Naduaq33C31+TsX6yhzy6XCAa0LezeoMX7QxlX/1irZSXbAtovVCQyCypfHw4pFNkhoUf2FVx3RHYNbrnCNQx8poKiRGfbrqyWb3bZSfvq56pWkPkkAKkr/VpdxaYIJPmnFV5wei8zO7wECrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E64BD1BD0;
	Tue, 19 Aug 2025 03:26:35 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F1DB33F63F;
	Tue, 19 Aug 2025 03:26:34 -0700 (PDT)
Date: Tue, 19 Aug 2025 11:26:18 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Chengdong Li <chengdongli@optimatist.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	namhyung@kernel.org, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf/core: Improve arguments checking of inherited
 per-task counters when sampling.
Message-ID: <aKRRSsEJxb1LZDV1@J2N7QTR9R3>
References: <20250814110625.84622-1-chengdongli@optimatist.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814110625.84622-1-chengdongli@optimatist.com>

On Thu, Aug 14, 2025 at 07:06:25PM +0800, Chengdong Li wrote:
> It's not allowed to mmap() of inherited per-task counters with CPU ==
> -1, this would create a performance issue. But it is not friendly to
> developers as current implementation postponed the arguments checking to
> perf_mmap(), developer can get an -EINVAL from mmap() but without
> any previous error returned from perf_event_open().
> 
> This patch improves it by moving the arguments checking from perf_mmap()
> to perf_event_open().

Why is that an improvement?

IIUC before this patch, it would be possible to read() the event,
whereas now the event cannot be opened at all.

AFAICT this is removing functionality people could legitimately use, so
this doesn't seem like an improvement.

Mark.

> 
> Signed-off-by: Chengdong Li <chengdongli@optimatist.com>
> ---
>  kernel/events/core.c | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 8060c2857bb2..f102adb395ec 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -6941,14 +6941,6 @@ static int perf_mmap(struct file *file, struct vm_area_struct *vma)
>  	int ret, flags = 0;
>  	mapped_f mapped;
>  
> -	/*
> -	 * Don't allow mmap() of inherited per-task counters. This would
> -	 * create a performance issue due to all children writing to the
> -	 * same rb.
> -	 */
> -	if (event->cpu == -1 && event->attr.inherit)
> -		return -EINVAL;
> -
>  	if (!(vma->vm_flags & VM_SHARED))
>  		return -EINVAL;
>  
> @@ -13392,6 +13384,18 @@ SYSCALL_DEFINE5(perf_event_open,
>  			return -EACCES;
>  	}
>  
> +	/*
> +	 * Don't allow perf_event_open() of inherited per-task counters
> +	 * with cpu == 1 when sampling. Otherwise, this would create a
> +	 * performance issue due to all children writing to the same mmap()
> +	 * created ring buffer.
> +	 *
> +	 * We recommend to call perf_event_open() for all cpus when sampling on
> +	 * inherited per-task counters.
> +	 */
> +	if (attr.sample_freq && attr.inherit && cpu == -1)
> +		return -EINVAL;
> +
>  	if (attr.freq) {
>  		if (attr.sample_freq > sysctl_perf_event_sample_rate)
>  			return -EINVAL;
> -- 
> 2.43.0
> 
