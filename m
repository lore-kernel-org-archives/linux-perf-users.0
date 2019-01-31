From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: System crash with perf_fuzzer (kernel: 5.0.0-rc3)
Date: Thu, 31 Jan 2019 09:27:11 +0100
Message-ID: <20190131082711.GC24233@krava>
References: <7c7ec3d9-9af6-8a1d-515d-64dcf8e89b78@linux.ibm.com>
 <20190130183648.GA24233@krava>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190130183648.GA24233@krava>
Sender: linux-kernel-owner@vger.kernel.org
To: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>, Andi Kleen <ak@linux.intel.com>, eranian@google.com, vincent.weaver@maine.edu, "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
List-Id: linux-perf-users.vger.kernel.org

On Wed, Jan 30, 2019 at 07:36:48PM +0100, Jiri Olsa wrote:

SNIP

> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 280a72b3a553..22ec63a0782e 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -4969,6 +4969,26 @@ static void __perf_event_period(struct perf_event *event,
>  	}
>  }
>  
> +static int check_period(struct perf_event *event, u64 value)
> +{
> +	u64 sample_period_attr = event->attr.sample_period;
> +	u64 sample_period_hw   = event->hw.sample_period;
> +	int ret;
> +
> +	if (event->attr.freq) {
> +		event->attr.sample_freq = value;
> +	} else {
> +		event->attr.sample_period = value;
> +		event->hw.sample_period = value;
> +	}

hm, I think we need to check the period without changing the event,
because we don't disable pmu, so it might get picked up by bts code

will check

jirka

> +
> +	ret = event->pmu->check_period(event);
> +
> +	event->attr.sample_period = sample_period_attr;
> +	event->hw.sample_period   = sample_period_hw;
> +	return ret;
> +}
> +
>  static int perf_event_period(struct perf_event *event, u64 __user *arg)
>  {
>  	u64 value;
> @@ -4985,6 +5005,9 @@ static int perf_event_period(struct perf_event *event, u64 __user *arg)
>  	if (event->attr.freq && value > sysctl_perf_event_sample_rate)
>  		return -EINVAL;
>  
> +	if (check_period(event, value))
> +		return -EINVAL;
> +
>  	event_function_call(event, __perf_event_period, &value);
>  
>  	return 0;
> @@ -9601,6 +9624,11 @@ static int perf_pmu_nop_int(struct pmu *pmu)
>  	return 0;
>  }
>  
> +static int perf_event_nop_int(struct perf_event *event)
> +{
> +	return 0;
> +}
> +
>  static DEFINE_PER_CPU(unsigned int, nop_txn_flags);
>  
>  static void perf_pmu_start_txn(struct pmu *pmu, unsigned int flags)
> @@ -9901,6 +9929,9 @@ int perf_pmu_register(struct pmu *pmu, const char *name, int type)
>  		pmu->pmu_disable = perf_pmu_nop_void;
>  	}
>  
> +	if (!pmu->check_period)
> +		pmu->check_period = perf_event_nop_int;
> +
>  	if (!pmu->event_idx)
>  		pmu->event_idx = perf_event_idx_default;
>  
> -- 
> 2.17.2
> 
