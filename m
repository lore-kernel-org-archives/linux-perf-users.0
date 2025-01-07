Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037EF1D8DFE;
	Tue,  7 Jan 2025 19:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736279066; cv=none; b=d7lbwechEwiz3UHB+rVhmoe089+QK+1qLPi8aWSeeL3ZYhwl/6TNgaOnyERVWomAEw2/SGjWCfmIeAe0SigPLV6tmyaNWLBAf7qBZOLW+OWDBv1IigX9Kc34i3/SekF8nmRFSkSA9nFkLJLf8JKiOLmbAaE4xwM2+KQfoKY0VaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736279066; c=relaxed/simple;
	bh=FC4SK16Q19vz3bnz+UUIAK5kWpm1TNbbzykxVH49iE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X/X6Xg8usSpU9nmR5F7HPqmfy/cetYK48AueYhgeveM02wJ6hDWxg8JfZ1v3NKKlqqEq5UBUnb/BUXiVplvXuWe2cXvq/9Cvx55Bl270fqCEbGAwQTJniLp6dCvPbvbLcXFi4vvJvc3GtGQlXjj7mrY62ljxMqU06T2pDhrpabI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ANGC5WVx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ANGC5WVx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3210CC4CED6;
	Tue,  7 Jan 2025 19:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736279065;
	bh=FC4SK16Q19vz3bnz+UUIAK5kWpm1TNbbzykxVH49iE0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ANGC5WVxL+w/9YsYimTpDfpUl5jYJknva8BrTis9h1cukRlGEChaXmqNGQ2iKkj9j
	 hSHKauVp+E0A4OKPSYpAqpOxgyK6eeIXbLpErzngTsNNzXgplQal/TlD8BtDDt4EdM
	 xWrLbya0FgopgdJL2gH3vb4zimEg+AqIyZPR8B6unM5e5iX9IEwknb8qLZyZMYiO2o
	 RT6cuBnEizzDyLmCIpL74zEE2EE7/1zhu7uJDVI5z43YPZt5ekURrqjB9/KDvUX7yO
	 b4x30j9J9GzGLTALZikpuwqzjSwP8rN1I4yHs+AuRhW1q12ITgK/A3UMBPoNQ+lJ1O
	 nlWJDwZ9IslUg==
Date: Tue, 7 Jan 2025 16:44:22 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>,
	Chun-Tse Shao <ctshao@google.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>, Ze Gao <zegao2021@gmail.com>,
	Weilin Wang <weilin.wang@intel.com>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v3 2/3] perf: Reveal PMU type in fdinfo
Message-ID: <Z32EFouwz3IHw8h0@x1>
References: <20241106003007.2112584-1-ctshao@google.com>
 <20241106003007.2112584-2-ctshao@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241106003007.2112584-2-ctshao@google.com>

On Wed, Nov 06, 2024 at 12:30:06AM +0000, Chun-Tse Shao wrote:
> It gives useful info on knowing which PMUs are reserved by this process.
> Also add config which would be useful.
> Testing cycles:

I applied the first patch in the series, that already helps, Peter, what
about this one for the kernel?

- Arnaldo
 
>   $ ./perf stat -e cycles &
>   $ cat /proc/`pidof perf`/fdinfo/3
>   pos:    0
>   flags:  02000002
>   mnt_id: 16
>   ino:    3081
>   perf_event_attr.type:   0
>   perf_event_attr.config: 0
> 
> Testing L1-dcache-load-misses:
> 
>   $ ./perf stat -e L1-dcache-load-misses &
>   $ cat /proc/`pidof perf`/fdinfo/3
>   pos:    0
>   flags:  02000002
>   mnt_id: 16
>   ino:    1072
>   perf_event_attr.type:   3
>   perf_event_attr.config: 65536
> 
> Signed-off-by: Chun-Tse Shao <ctshao@google.com>
> Change-Id: Ibea5618aaf00bae6f48a9b2a6e7798ab2b7f23ce
> ---
>  kernel/events/core.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index cdd09769e6c56..398cac8b208b9 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -55,6 +55,7 @@
>  #include <linux/pgtable.h>
>  #include <linux/buildid.h>
>  #include <linux/task_work.h>
> +#include <linux/seq_file.h>
>  
>  #include "internal.h"
>  
> @@ -6820,6 +6821,14 @@ static int perf_fasync(int fd, struct file *filp, int on)
>  	return 0;
>  }
>  
> +static void perf_show_fdinfo(struct seq_file *m, struct file *f)
> +{
> +	struct perf_event *event = f->private_data;
> +
> +	seq_printf(m, "perf_event_attr.type:\t%u\n", event->orig_type);
> +	seq_printf(m, "perf_event_attr.config:\t%llu\n", (unsigned long long)event->attr.config);
> +}
> +
>  static const struct file_operations perf_fops = {
>  	.release		= perf_release,
>  	.read			= perf_read,
> @@ -6828,6 +6837,7 @@ static const struct file_operations perf_fops = {
>  	.compat_ioctl		= perf_compat_ioctl,
>  	.mmap			= perf_mmap,
>  	.fasync			= perf_fasync,
> +	.show_fdinfo		= perf_show_fdinfo,
>  };
>  
>  /*
> -- 
> 2.47.0.199.ga7371fff76-goog
