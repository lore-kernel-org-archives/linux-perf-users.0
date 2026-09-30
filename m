Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFDAC359A99;
	Wed, 30 Sep 2026 13:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790775387; cv=none; b=mgY2/erO9+M1e+B7CdIO3FQASwEW3DWPXTl9SGK4baGFYzsXI1aExXqP9LpZeRhJpFYndImAzzYmUkGxJbhuyt9U7ffyXOKcR8V2H3HL6vjVoam4ZXhOlTTqnWASqpz05kOFBewGoX2aEPTLM+J5MsbGAOpgcL5ij2IR3JWPtFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790775387; c=relaxed/simple;
	bh=MWCvg4sjK/uErDxiJSNTuEfe/fE6ubDEaPpL4yLsOJU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gN6lNVxBmlj+S87rF8LG+W4aINGotnTasxohfajw2ztq6/G4oc4Ep6q0oX08Jx9dleQNsmOvaQqCNEr2jun80MdK9LB7pdSIsBTCkOhtcYm6TEkZxD+r/5IieGd5Ql5x2WKfKKklrMESaH1fdDSIwzh+QXkcLXTvulzdKtF2ibQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=DWAFlDVz; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="DWAFlDVz"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 78BF1497;
	Wed, 30 Sep 2026 06:36:12 -0700 (PDT)
Received: from [10.57.85.29] (unknown [10.57.85.29])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C98E03F86F;
	Wed, 30 Sep 2026 06:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790775375; bh=MWCvg4sjK/uErDxiJSNTuEfe/fE6ubDEaPpL4yLsOJU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DWAFlDVzKXIRcL9optFIbIIh9On6QwWlHn3t84awWXg+fiddvTAT19gXAPZkFhTZ/
	 G+sFhjcmcySLQfhWIa7n2J032I4Cvi3G+qVeRbWTEqRAFmwsa1/HkWnVxu/BWoDSwt
	 ts25+5YXwzXpQL8kvczPNYSr+bWaaEkvGMWBwIMU=
Message-ID: <b782f893-e3ab-40f7-a7c5-ce19660be2c1@arm.com>
Date: Wed, 30 Sep 2026 14:36:06 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/arm-cmn: Allow userspace to select the PMU's CPU
To: Haris Okanovic <harisokn@amazon.com>, mark.rutland@arm.com,
 will@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260929223244.2411400-1-harisokn@amazon.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260929223244.2411400-1-harisokn@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-09-29 11:32 pm, Haris Okanovic wrote:
> arm_cmn_probe() picks the CPU that owns the PMU with
> 
> 	cmn->cpu = cpumask_local_spread(0, dev_to_node(cmn->dev));
> 
> and arm_cmn_event_init() then binds every event to it unconditionally.
> That choice is only revisited by the CPU hotplug callbacks, so in
> practice the PMU stays on the first CPU local to the interconnect's NUMA
> node, which is usually CPU 0.
> 
> All of the PMU's recurring work therefore lands on one CPU. This is
> problematic on systems which reserve particular CPUs for latency
> sensitive work or confine background activity to a chosen set of
> housekeeping CPUs.
> 
> There is no way to set it explicitly. perf_event_open() and 'perf stat
> -C' have no effect because arm_cmn_event_init() overwrites event->cpu;
> /proc/irq/*/smp_affinity is refused for the DTC interrupts, which are
> requested with IRQF_NOBALANCING because their affinity has to follow the
> owning CPU.

All system PMU drivers have the same concern in this regard - why should 
arm-cmn be special?

> Make the existing 'cpumask' attribute writable. It already reports the
> CPU which owns the PMU; writing a CPU number now migrates the PMU there
> via the existing arm_cmn_migrate(), which moves the perf contexts and
> the DTC interrupt affinity together. Since the PMU has a single owning
> CPU, anything other than one CPU number is rejected.
> 
> The attribute expresses a preference rather than a guarantee. The
> hotplug callbacks may still move the PMU, for example when the chosen
> CPU is offlined.
> 
> Signed-off-by: Haris Okanovic <harisokn@amazon.com>
> ---
> I made the existing 'cpumask' attribute writable rather than
> adding a new one. Every other implementation of that file is read-only,
> so I am happy to switch to a separate attribute if you would prefer to
> keep 'cpumask' uniformly read-only across PMUs.
> 
> Tested on two platforms with CONFIG_PROVE_LOCKING=y:
> 
>    AWS m9g.metal-48xl CMN S3,  one mesh,   192 CPUs
>    AWS m8g.metal-48xl CMN-700, two meshes, 192 CPUs
> 
>    - Multiplexing occurs on the configured CPU.
>    - Offlining the owning CPU migrates the PMU and updates the attribute.
>    - Writes racing CPU offline/online produced no lockdep reports.

Lockdep isn't going to do much anyway, since the whole point is that 
perf mostly depends on CPU affinity and IRQ masking for mutual exclusion 
and serialisation, rather than explicit locking. What prevents 
perf_event_open racing against this update such that the new event->cpu 
still ends up with the old value, and thus will no longer be correctly 
synchronised against other scheduling calls/overflow interrupts/etc.?

Now yes, I think technically that race might already exist in a tiny 
window due to the order of hotplug callbacks (yet another reason why I'd 
like to clean up hotplug handling...), but at worst it's still 
relatively benign if the old CPU is actually going offline, since it 
will very soon reach a state where that misconfigured new event just 
won't work - since trying to schedule or read it depends on 
cross-calling a CPU that's now gone - but at least it's then not capable 
of corrupting _other_ events.

Thanks,
Robin.

> ---
>   Documentation/admin-guide/perf/arm-cmn.rst | 18 ++++++++++
>   drivers/perf/arm-cmn.c                     | 40 +++++++++++++++++++++-
>   2 files changed, 57 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/perf/arm-cmn.rst b/Documentation/admin-guide/perf/arm-cmn.rst
> index 796e25b7027b2..bf75b686cef76 100644
> --- a/Documentation/admin-guide/perf/arm-cmn.rst
> +++ b/Documentation/admin-guide/perf/arm-cmn.rst
> @@ -44,6 +44,24 @@ given type. To target a specific node, "bynodeid" must be set to 1 and
>   "nodeid" to the appropriate value derived from the CMN configuration
>   (as defined in the "Node ID Mapping" section of the TRM).
>   
> +CPU affinity
> +------------
> +
> +The driver also provides a "cpumask" sysfs attribute, which contains a
> +single CPU ID, of the processor which will be used to handle all the CMN
> +PMU events.
> +
> +The attribute is writable, and accepts a single CPU ID to move the PMU
> +to that processor, for instance to keep counter reads, interrupt handling
> +and event rotation away from CPUs reserved for latency sensitive work::
> +
> +  $# echo 5 > /sys/bus/event_source/devices/arm_cmn_0/cpumask
> +
> +This expresses a preference rather than a guarantee. In case of the
> +chosen processor being offlined, or a processor local to the
> +interconnect's NUMA node coming online while the chosen one is not, the
> +events and interrupts are migrated and the attribute is updated.
> +
>   Watchpoints
>   -----------
>   
> diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
> index 5378fba916cf5..4f82d667d8828 100644
> --- a/drivers/perf/arm-cmn.c
> +++ b/drivers/perf/arm-cmn.c
> @@ -5,6 +5,7 @@
>   #include <linux/acpi.h>
>   #include <linux/bitfield.h>
>   #include <linux/bitops.h>
> +#include <linux/cpu.h>
>   #include <linux/debugfs.h>
>   #include <linux/interrupt.h>
>   #include <linux/io.h>
> @@ -12,6 +13,7 @@
>   #include <linux/kernel.h>
>   #include <linux/list.h>
>   #include <linux/module.h>
> +#include <linux/mutex.h>
>   #include <linux/of.h>
>   #include <linux/perf_event.h>
>   #include <linux/platform_device.h>
> @@ -404,6 +406,8 @@ struct arm_cmn_nodeid {
>   	u8 dev;
>   };
>   
> +static void arm_cmn_migrate(struct arm_cmn *cmn, unsigned int cpu);
> +
>   static int arm_cmn_xyidbits(const struct arm_cmn *cmn)
>   {
>   	return fls((cmn->mesh_x - 1) | (cmn->mesh_y - 1));
> @@ -1519,8 +1523,42 @@ static ssize_t arm_cmn_cpumask_show(struct device *dev,
>   	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(cpumask_of(cmn->cpu)));
>   }
>   
> +static ssize_t arm_cmn_cpumask_store(struct device *dev,
> +				     struct device_attribute *attr,
> +				     const char *buf, size_t count)
> +{
> +	static DEFINE_MUTEX(cpumask_mutex);
> +
> +	struct arm_cmn *cmn = to_cmn(dev_get_drvdata(dev));
> +	unsigned int cpu;
> +	int err;
> +
> +	err = kstrtouint(buf, 0, &cpu);
> +	if (err)
> +		return err;
> +
> +	if (cpu >= nr_cpu_ids)
> +		return -EINVAL;
> +
> +	/* Serialises multiple writers against each other */
> +	mutex_lock(&cpumask_mutex);
> +	/* Blocks hotplug during write */
> +	cpus_read_lock();
> +
> +	if (!cpu_online(cpu))
> +		err = -EINVAL;
> +	else if (cpu != cmn->cpu)
> +		arm_cmn_migrate(cmn, cpu);
> +
> +	cpus_read_unlock();
> +	mutex_unlock(&cpumask_mutex);
> +
> +	return err ?: count;
> +}
> +
>   static struct device_attribute arm_cmn_cpumask_attr =
> -		__ATTR(cpumask, 0444, arm_cmn_cpumask_show, NULL);
> +		__ATTR(cpumask, 0644, arm_cmn_cpumask_show,
> +		       arm_cmn_cpumask_store);
>   
>   static ssize_t arm_cmn_identifier_show(struct device *dev,
>   				       struct device_attribute *attr, char *buf)

