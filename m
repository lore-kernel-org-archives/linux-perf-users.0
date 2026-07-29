Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28830468C13;
	Wed, 29 Jul 2026 19:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785352491; cv=none; b=A+oH2QbVYkAoo7iGs9I47GrScI57nap2qU2fbINAq2SjpnDacPtHmjmbqZ3L3ZmJrf66nu4C3MBZjqXxj+fTEJ3ODBx0gcL9oCUPFkeQZlT0iSakkU8130qPOyzXUiz7orqvDMVh7O1NrVfu+6+DRdI0XfIo9SvUxFY8SHN+wDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785352491; c=relaxed/simple;
	bh=svLtFfcMj+MtL57Jiu0gFs0QFN6XZ+oKK2jpR8p2XhI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ERkENGUqXTRWjS3fpgAcQabOlfB5+Ea6uiTk4FHnvLiureFp72abqciMYgig76ZAzJVyicuzHudljNq/I3+mg2GkYrdTHSmV26025Ih3J2LdldSLGBdvfp3XUyDO63VocMdIYLORGg+71AhjZF6LNpytaMzNPL36epJEPx7zg4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R0cYBQmI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R0cYBQmI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 099421F000E9;
	Wed, 29 Jul 2026 19:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785352490;
	bh=24Z5iDsdAi+qQI0YVBFgmLu8L2SsrEqjiBGXreN8T7g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=R0cYBQmIXkhpSyjGVrL4PdRhKX6ltk9X4BGT5SZqhuhw397w9PeaN2Am6xNrKL47a
	 zGqksMcAEicwm4p1/4aGZ1tbCj+J04aAgKiVsJ48P9snwsU6RVcNdHJsmkSg5xR0R/
	 BtL2HiTqu10VI1/TbpbegpbPTe39UNEybVoxt5AjGe2kpVE8mWoeZbhrrsXpYQpspe
	 GqlF1HqpJXKiT0DtH/Rdb01vbvzwA+xTcojna45zSbGqsGA9a4+PmWUdHSg2+9yyFr
	 6mpyaF9HpIBYvUcNj0IY2ERQ4+oXtAC5nQYB1UBJRUJN1JyGZ9K1HKkjRGOSQJ30Wa
	 5g9l6veEBThkQ==
Date: Wed, 29 Jul 2026 20:14:46 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-perf-users@vger.kernel.org,
 will@kernel.org, mark.rutland@arm.com, dave@stgolabs.net,
 sashiko-bot@kernel.org, Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v2 9/9] perf/cxl: Avoid cpumask_of(-1) when no CPU is
 assigned
Message-ID: <20260729201446.62732044@jic23-huawei>
In-Reply-To: <20260729145555.3919550-10-dave.jiang@intel.com>
References: <20260729145555.3919550-1-dave.jiang@intel.com>
	<20260729145555.3919550-10-dave.jiang@intel.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 Jul 2026 07:55:55 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> cpumask_show() feeds info->on_cpu straight into cpumask_of() for the
> world-readable cpumask sysfs attribute. on_cpu is -1 before the first
> hotplug online callback and transiently in cxl_pmu_offline_cpu() before a
> new target is chosen. cpumask_of(-1) treats the CPU number as unsigned and
> does out-of-bounds pointer arithmetic in get_cpu_mask(), so a concurrent
> read of the attribute dereferences a wild pointer and can fault -- a local
> denial of service.
> 

I'm not keen on the solution here. 

The transient state is ugly anyway. We can just move setting it to -1 into
the dummy code that deals with that well known case of you have CPUs online
and code is still running.

The init case looks like a false positive to me.  But maybe I'm missing stuff.
The perf registration that surfaces the sysfs happens after hotplug handler is
added and I believe that synchronously runs it for CPUs that are already up.
Given we are running code (and CXL stuff isn't super early) something will
be up so it won't remain -1 by the time of use.

Can we just use the generic stuff?  Maybe need Robin's stuff to add init / exit
per driver calls. 
https://lore.kernel.org/linux-arm-kernel/cover.1784911757.git.robin.murphy@arm.com/

In general, I'd like Robin to take a quick look at the more generic perf
parts of this series given he has clearly been deep in this stuff a lot
more recently than me :)

Jonathan

> Read on_cpu once and emit an empty mask when it is negative.
> 
> Fixes: 5d7107c72796 ("perf: CXL Performance Monitoring Unit driver")
> Reported-by: sashiko-bot@kernel.org
> Closes: https://sashiko.dev/#/patchset/20260715191454.459673-1-dave@stgolabs.net?part=1
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/perf/cxl_pmu.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
> index f42238b2b6b0..6aad381c0376 100644
> --- a/drivers/perf/cxl_pmu.c
> +++ b/drivers/perf/cxl_pmu.c
> @@ -501,8 +501,17 @@ static ssize_t cpumask_show(struct device *dev, struct device_attribute *attr,
>  			    char *buf)
>  {
>  	struct cxl_pmu_info *info = dev_get_drvdata(dev);
> +	int cpu = READ_ONCE(info->on_cpu);
>  
> -	return cpumap_print_to_pagebuf(true, buf, cpumask_of(info->on_cpu));
> +	/*
> +	 * on_cpu is -1 before the first online callback and transiently during
> +	 * cxl_pmu_offline_cpu(). cpumask_of(-1) computes an out-of-bounds
> +	 * pointer, so report an empty mask instead.
> +	 */
> +	if (cpu < 0)
> +		return sysfs_emit(buf, "\n");
> +
> +	return cpumap_print_to_pagebuf(true, buf, cpumask_of(cpu));
>  }
>  static DEVICE_ATTR_RO(cpumask);
>  

