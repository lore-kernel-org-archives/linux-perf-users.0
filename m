Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81ED63ADBAD;
	Thu, 30 Jul 2026 18:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785437495; cv=none; b=OwucPF4MjLFIVYKZAl2PiEq+uVFtm58QqAmUha4Q03zmaWM/kLKC8OqPoekMbsYDlAWkpdKt8AXybUljsyhMC7baauhErjWmTu5erLg9IBQTsuiJ1Fu4AjFRovlfZFRDrSi+Ge6LrK3oRQJEjwStncXqchooGxpx8Cxa8ZnJWF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785437495; c=relaxed/simple;
	bh=28JGgY/XN4TEkGDOqjD4Mp2no9FPukMQ5Yl+k0HjhHI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C3NXxE3JyG4k4GfUOgK+mmxCRNyqI6zUHmhFyoDX41ReZlfEC3HKFvAcrPN+/FU8RbrzZNWeTmGBLDFE9Zro3pkUpRd86heeASlwde8UB/Dt2CWgLnDGQ4mU0NudsTmUmeGwNYaNt9tq9bbIHAsmDVC0yVaaJzlbsaNIFonciQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kQt8dpvG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kQt8dpvG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AC671F000E9;
	Thu, 30 Jul 2026 18:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785437491;
	bh=oFAp8XdSVJul7SU+BtQlBxtXLWL3iNzaxJra5JATbog=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=kQt8dpvG3F2xf1YVl4HMiKXSacgmmBUmPJzaLfrjTopQteByHFeaWc1ueuOay9K+O
	 3GafNXMc/PBzI/T2OGpLRZmzNcqFDpPk2n40HwpGmHQMWpfHUr+h6xIJIhdXdeGV+d
	 yZiVMBSVkUrKHIfDazM9EQwRBcdOlhFFd5+0pY8Ssb0kJSZPPvKzZiJYimeWNKVp+W
	 IaBcAZTYJp14/rGn12g9Y+KFqdHzFqni1xKClwu2432xVei17lxqH/En0KiJVCSjPw
	 94jccNDImM0VgFDsPl7PTEIW70jaDO0vKT7u73rB1uipfcN23RPzOFmsiHX95KkwoT
	 6qK9OA/bjm5mA==
Date: Thu, 30 Jul 2026 19:51:27 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org,
 linux-perf-users@vger.kernel.org, will@kernel.org, mark.rutland@arm.com,
 dave@stgolabs.net, sashiko-bot@kernel.org
Subject: Re: [PATCH v2 8/9] perf/cxl: Don't use pmu.dev in IRQ and hotplug
 callbacks after unregister
Message-ID: <20260730195127.208d939a@jic23-huawei>
In-Reply-To: <76fbd2ce-5d25-47a4-82d8-5577860a948c@arm.com>
References: <20260729145555.3919550-1-dave.jiang@intel.com>
	<20260729145555.3919550-9-dave.jiang@intel.com>
	<76fbd2ce-5d25-47a4-82d8-5577860a948c@arm.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 Jul 2026 12:38:28 +0100
Robin Murphy <robin.murphy@arm.com> wrote:

> On 29/07/2026 3:55 pm, Dave Jiang wrote:
> > On device removal the devm actions unwind LIFO, so cxl_pmu_perf_unregister()
> > runs first and perf_pmu_unregister() frees info->pmu.dev (device_del() +
> > put_device() -> kfree()). The overflow IRQ (freed last) and the CPU-hotplug
> > instance (removed next) are still live at that point, and both
> > cxl_pmu_irq() and cxl_pmu_offline_cpu() log via dev_dbg()/dev_err() on
> > info->pmu.dev, dereferencing freed memory. The shared IRQ can be entered
> > for a co-function on the same MSI vector, and a CPU can go offline in the
> > window before the hotplug instance is removed.
> > 
> > Log through info->pmu.parent instead, the cxl_pmu device passed to probe,
> > which is devm-managed and outlives every teardown action.
> > 
> > Fixes: 5d7107c72796 ("perf: CXL Performance Monitoring Unit driver")
> > Reported-by: sashiko-bot@kernel.org
> > Closes: https://sashiko.dev/#/patchset/20260715191454.459673-1-dave@stgolabs.net?part=1
> > Assisted-by: Claude:claude-opus-4-8
> > Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> > ---
> >   drivers/perf/cxl_pmu.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
> > index 2e817a52ff1e..f42238b2b6b0 100644
> > --- a/drivers/perf/cxl_pmu.c
> > +++ b/drivers/perf/cxl_pmu.c
> > @@ -803,7 +803,7 @@ static irqreturn_t cxl_pmu_irq(int irq, void *data)
> >   		struct perf_event *event = info->hw_events[i];
> >   
> >   		if (!event) {
> > -			dev_dbg(info->pmu.dev,
> > +			dev_dbg(info->pmu.parent,
> >   				"overflow but on non enabled counter %d\n", i);
> >   			continue;  
> 
> This seems dubious - we don't permit sharing the IRQ, and all events 
> must have been stopped and descheduled to allow the PMU to be removed in 
> the first place, so how would an overflow interrupt happen?

Hmm. Today the driver itself does permit sharing.  Which is awkward given
need for the interrupts not to get migrated to different CPUs which
I guess might happen if we get a race with driver bind and hotplug events.
I may well be missing other reasons sharing is bad, but that one seems
like enough to rule it out.

Perhaps the fix for now is remove the IRQF_SHARED flag.   Clear no one
was using the driver yet with real hardware given some of the fixes
in this series so we aren't going to regress anyone.

Hopefully no one actually thinks a device that puts PMUs on shared interrupts
is a good idea and no host running CXL runs out and has to force the PCIe
stuff to collapse them to a smaller set of vectors.

> 
> >   		}
> > @@ -966,7 +966,7 @@ static int cxl_pmu_offline_cpu(unsigned int cpu, struct hlist_node *node)
> >   	info->on_cpu = -1;
> >   	
target = cpumask_any_but(cpu_online_mask, cpu);
> >   	if (target >= nr_cpu_ids) {  
> 
> And this again is nonsense anyway - if the pointless dead code is 
> bothering people, just delete the whole check.
True enough.  I fear I gut and paste that from somewhere so might
be worth a more general scrub for other instances :(  

J
> 
> Thanks,
> Robin.
> 
> > -		dev_err(info->pmu.dev, "Unable to find a suitable CPU\n");
> > +		dev_err(info->pmu.parent, "Unable to find a suitable CPU\n");
> >   		return 0;
> >   	}
> >     
> 
> 

