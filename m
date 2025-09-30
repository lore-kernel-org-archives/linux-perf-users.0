Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6C1194A44;
	Tue, 30 Sep 2025 03:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759201936; cv=none; b=d3z5RHN3PSpZU185sf2pISXm+Ax5IyIIHmLr3Wb9dBe40SIIGn4IZNw/Or42Oz2CpANREbDUFY4Bor05wFe0xgHQJwM9JbKkNlxVuqc+2aUcu1ubEKk8CGJ7Z4kjuCSfT9pqidtrAWwVNI+lfG7Lp3HGZBTRf9gVhjuXzZ1tXdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759201936; c=relaxed/simple;
	bh=NGG9DeZK47EVyEsf6Apy1O10y8NknK2/yC/JKs3evuM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kIAQSBEevNoK4aGAzf/IFVSOXnYrGMU0njJUDdFm+8Jh+TV+Kf7peMaQz9GH9niS+9GllU8jmBpFOdKfzUYVxnR5fXLnqKJxpuHAU/AOPajITZEi9aVJvHjSbRX1yBUZEes8lqTQrT+XAtufT5OYIU2cuoboRrk3C+A+S0mxNk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N/w4ZiF5; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N/w4ZiF5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759201934; x=1790737934;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=NGG9DeZK47EVyEsf6Apy1O10y8NknK2/yC/JKs3evuM=;
  b=N/w4ZiF54Ta9OXhLxakdKskA1BFUQZl6f/gw9JPPekXrIFHzSeRx6IYn
   WtZduByRkTy/ojUoWIVNsbgIjhZcoPgyT+L2Zq1T8Le1Gd3OedF+eWDFd
   +se9LatChqgiNTDCQoPnTeFgQF/aI/I6pngP16FDUMfSdxw/zdBAy9U1b
   iB/OTTg/fRfr/dWbZV60oS8mRO1lgp+vw/osGgFumdUMMtjullnqibVGt
   MeC0qi6pXpaiuNP+LHv8+2/NI3Pdk7sbikivevx+msp7UvBg0ec+P76nP
   r9hOt3mGeHG5TX4NCV6flLl0EQ5Uz1Gj1CVQGy1cxTgTze4uScZRmUvFs
   Q==;
X-CSE-ConnectionGUID: 8wbyUrYmR6WPnjUvUnJn8Q==
X-CSE-MsgGUID: AkPbs2HTRUSDbPA9gXCunw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="65270236"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="65270236"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2025 20:12:13 -0700
X-CSE-ConnectionGUID: z1w8pF8rQY66BjOhXdgEuA==
X-CSE-MsgGUID: OJCA+ymBQmipRXP1dfzm3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,303,1751266800"; 
   d="scan'208";a="179169815"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.232.209]) ([10.124.232.209])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2025 20:12:09 -0700
Message-ID: <9413e707-35d2-4c9a-9058-d14112ebb2cc@linux.intel.com>
Date: Tue, 30 Sep 2025 11:12:07 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] perf: Reveal PMU type in fdinfo
To: Chun-Tse Shao <ctshao@google.com>, linux-kernel@vger.kernel.org
Cc: Ian Rogers <irogers@google.com>, peterz@infradead.org, mingo@redhat.com,
 acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 adrian.hunter@intel.com, kan.liang@linux.intel.com, james.clark@linaro.org,
 howardchu95@gmail.com, weilin.wang@intel.com,
 linux-perf-users@vger.kernel.org
References: <20250603181634.1362626-1-ctshao@google.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20250603181634.1362626-1-ctshao@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 6/4/2025 2:15 AM, Chun-Tse Shao wrote:
> It gives useful info on knowing which PMUs are reserved by this process.
> Also add config which would be useful.
> Testing cycles:
>
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
> Reviewed-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Chun-Tse Shao <ctshao@google.com>
> ---
> v4:
>   Removed the first patch in v3 since it is merged.
>   Retested to make sure the patch still work.
>
> v3: lore.kernel.org/20241106003007.2112584-2-ctshao@google.com
>
>  kernel/events/core.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 95e703891b24..bad563692d63 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -56,6 +56,7 @@
>  #include <linux/buildid.h>
>  #include <linux/task_work.h>
>  #include <linux/percpu-rwsem.h>
> +#include <linux/seq_file.h>
>
>  #include "internal.h"
>
> @@ -7077,6 +7078,14 @@ static int perf_fasync(int fd, struct file *filp, int on)
>  	return 0;
>  }
>
> +static void perf_show_fdinfo(struct seq_file *m, struct file *f)
> +{
> +	struct perf_event *event = f->private_data;
> +
> +	seq_printf(m, "perf_event_attr.type:\t%u\n", event->orig_type);
> +	seq_printf(m, "perf_event_attr.config:\t%llu\n", (unsigned long long)event->attr.config);

Could we print the config field with hexadecimal format? It makes the event
is more easily recognized. Thanks.


> +}
> +
>  static const struct file_operations perf_fops = {
>  	.release		= perf_release,
>  	.read			= perf_read,
> @@ -7085,6 +7094,7 @@ static const struct file_operations perf_fops = {
>  	.compat_ioctl		= perf_compat_ioctl,
>  	.mmap			= perf_mmap,
>  	.fasync			= perf_fasync,
> +	.show_fdinfo		= perf_show_fdinfo,
>  };
>
>  /*
> --
> 2.49.0.1204.g71687c7c1d-goog
>
>
