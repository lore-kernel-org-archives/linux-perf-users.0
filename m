Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90B90C433F5
	for <linux-perf-users@archiver.kernel.org>; Wed, 13 Oct 2021 17:30:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 723F46101D
	for <linux-perf-users@archiver.kernel.org>; Wed, 13 Oct 2021 17:30:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbhJMRca (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 13 Oct 2021 13:32:30 -0400
Received: from foss.arm.com ([217.140.110.172]:42892 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230301AbhJMRca (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 13 Oct 2021 13:32:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CE6B61063;
        Wed, 13 Oct 2021 10:30:26 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.73.189])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AC1243F694;
        Wed, 13 Oct 2021 10:30:22 -0700 (PDT)
Date:   Wed, 13 Oct 2021 18:30:19 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        honnappa.nagarahalli@arm.com, Zachary.Leaf@arm.com,
        Raphael Gault <raphael.gault@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        Vince Weaver <vincent.weaver@maine.edu>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v10 3/5] arm64: perf: Add userspace counter access
 disable switch
Message-ID: <20211013173019.GC5400@C02TD0UTHF1T.local>
References: <20210914204800.3945732-1-robh@kernel.org>
 <20210914204800.3945732-4-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210914204800.3945732-4-robh@kernel.org>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Sep 14, 2021 at 03:47:58PM -0500, Rob Herring wrote:
> Like x86, some users may want to disable userspace PMU counter
> altogether. Add a sysctl 'perf_user_access' file to control userspace
> counter access. The default is '0' which is disabled. Writing '1'
> enables access.
> 
> Note that x86 also supports writing '2' to globally enable user access.

For clarity it might be worth mentioning that on x86 this is controlled
by the PMU's `rdpmc` sysfs attribute, i.e.

  Note that x86 supports globally enabling user access by writing '2' to
  /sys/bus/event_source/devices/cpu/rdpmc

> As there's not existing userspace support to worry about, this shouldn't
> be necessary for Arm. It could be added later if the need arises.
> 
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: linux-perf-users@vger.kernel.org
> Acked-by: Will Deacon <will@kernel.org>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> v10:
>  - Add documentation
>  - Use a custom handler (needed on the next patch)
> v9:
>  - Use sysctl instead of sysfs attr
>  - Default to disabled
> v8:
>  - New patch
> ---
>  Documentation/admin-guide/sysctl/kernel.rst | 11 +++++++++
>  arch/arm64/kernel/perf_event.c              | 27 +++++++++++++++++++++
>  2 files changed, 38 insertions(+)
> 
> diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
> index 426162009ce9..346a0dba5703 100644
> --- a/Documentation/admin-guide/sysctl/kernel.rst
> +++ b/Documentation/admin-guide/sysctl/kernel.rst
> @@ -905,6 +905,17 @@ enabled, otherwise writing to this file will return ``-EBUSY``.
>  The default value is 8.
>  
>  
> +perf_user_access (arm64 only)
> +=================================
> +
> +Controls user space access for reading perf event counters. When set to 1,
> +user space can read performance monitor counter registers directly.
> +
> +The default value is 0 (access disabled).
> +
> +See Documentation/arm64/perf.rst for more information.

Looking at the existing perf sysctls:

# ls /proc/sys/kernel/perf*
/proc/sys/kernel/perf_cpu_time_max_percent
/proc/sys/kernel/perf_event_max_contexts_per_stack
/proc/sys/kernel/perf_event_max_sample_rate
/proc/sys/kernel/perf_event_max_stack
/proc/sys/kernel/perf_event_mlock_kb
/proc/sys/kernel/perf_event_paranoid

I see that other than `perf_cpu_time_max_percent`, we've used
`perf_event_` as the prefix, and I suspect we should do the same here,
but I guess it may not matter either way.

> +
> +
>  pid_max
>  =======
>  
> diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
> index b4044469527e..a8f8dd741aeb 100644
> --- a/arch/arm64/kernel/perf_event.c
> +++ b/arch/arm64/kernel/perf_event.c
> @@ -286,6 +286,8 @@ static const struct attribute_group armv8_pmuv3_events_attr_group = {
>  PMU_FORMAT_ATTR(event, "config:0-15");
>  PMU_FORMAT_ATTR(long, "config1:0");
>  
> +static int sysctl_perf_user_access __read_mostly;
> +
>  static inline bool armv8pmu_event_is_64bit(struct perf_event *event)
>  {
>  	return event->attr.config1 & 0x1;
> @@ -1104,6 +1106,29 @@ static int armv8pmu_probe_pmu(struct arm_pmu *cpu_pmu)
>  	return probe.present ? 0 : -ENODEV;
>  }
>  
> +int armv8pmu_proc_user_access_handler(struct ctl_table *table, int write,
> +                void *buffer, size_t *lenp, loff_t *ppos)
> +{
> +	int ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
> +	if (ret || !write || sysctl_perf_user_access)
> +		return ret;
> +
> +	return 0;
> +}

Maybe this is needed in the next patch, but the if statement is entirely
redundant on this patch and looks really odd.

Can we please either:

1) Use proc_dointvec_minmax() directly in this patch (which is what Will
Acked in v9) and add the wrapper in the next patch when we need it.

2) make this:

| int armv8pmu_proc_user_access_handler(struct ctl_table *table, int write,
|                 void *buffer, size_t *lenp, loff_t *ppos)
| {
| 	return proc_dointvec_minmax(table, write, buffer, lenp, ppos);
| }

... and flesh it out in the next patch.

With either of those two options (and regardless of whether the
attribute is renamed):

Reviewed-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.

> +
> +	return 0;
> +}
> +
> +static struct ctl_table armv8_pmu_sysctl_table[] = {
> +	{
> +		.procname       = "perf_user_access",
> +		.data		= &sysctl_perf_user_access,
> +		.maxlen		= sizeof(unsigned int),
> +		.mode           = 0644,
> +		.proc_handler	= armv8pmu_proc_user_access_handler,
> +		.extra1		= SYSCTL_ZERO,
> +		.extra2		= SYSCTL_ONE,
> +	},
> +	{ }
> +};
> +
>  static int armv8_pmu_init(struct arm_pmu *cpu_pmu, char *name,
>  			  int (*map_event)(struct perf_event *event),
>  			  const struct attribute_group *events,
> @@ -1136,6 +1161,8 @@ static int armv8_pmu_init(struct arm_pmu *cpu_pmu, char *name,
>  	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_CAPS] = caps ?
>  			caps : &armv8_pmuv3_caps_attr_group;
>  
> +	register_sysctl("kernel", armv8_pmu_sysctl_table);
> +
>  	return 0;
>  }
>  
> -- 
> 2.30.2
> 
