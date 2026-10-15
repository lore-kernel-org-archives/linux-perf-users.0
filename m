Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 335A352E042;
	Thu, 15 Oct 2026 14:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792073972; cv=none; b=SDxndLL3yzriFUH5OF47hVPXb2D0W0K3vOmB4Ej1WAg/feXC2oQauNM8F9juYYSw4KmqmQZU4r87lplkG2jIIuElLWsGj3rigr7IrOHFSY4UYpTJikYxx7GmuvsbdZFIgkIpbQ86t1gv6s2jYpmwhMEmjFP3xIZJ6qPn+m4Rxhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792073972; c=relaxed/simple;
	bh=toY2d+nKnmDfOpFRB7kB9FTOmrbPE2iy1wkw0IypruA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ogloy8ELoCI0edWtMJJvLmFirZ7BFaDWeTS3uEZKassyF2BE4eO6D4vvS4cZ4kiSksSZOLeZuJ1Hfb43ZjiR8p37EwI/xK9AKPA0IhyXzGjMkZBiEvDftuCiKJ0BZpc7P1vPhzRVYcJOQnoSnGmri7VMzAgwRFI5m4TBtLM1SG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Y3vi/qaG; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Y3vi/qaG"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ABE2F1477;
	Thu, 15 Oct 2026 07:19:25 -0700 (PDT)
Received: from localhost (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7C8BF3F871;
	Thu, 15 Oct 2026 07:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1792073968; bh=toY2d+nKnmDfOpFRB7kB9FTOmrbPE2iy1wkw0IypruA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y3vi/qaGwlAMS6V2VrtigNi/Q0VFTsR5SvFAE1qOc5LJDFUg0KwzQ5o4ZY7d7aoXX
	 c6oCRN7lw7xuowVJbfbIVt4snSN2EfAzZVhhsM1O1xgdggk2ZbjoUtMYtaebVcBZFd
	 PVaIFnaZCRoisRwYZpfOTVYNcRuljdGFUMaL+nB4=
Date: Thu, 15 Oct 2026 15:19:26 +0100
From: Leo Yan <leo.yan@arm.com>
To: Marc Zyngier <maz@kernel.org>
Cc: "Johnny.Fan" <johnny.fan@cixtech.com>, will@kernel.org,
	mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	james.clark@linaro.org, jeremy.linton@arm.com,
	cix-kernel-upstream@cixtech.com, bob.zhang@cixtech.com,
	jie.fu@cixtech.com, Fugang Duan <fugang.duan@cixtech.com>
Subject: Re: [PATCH] perf: arm_spe: Support heterogeneous ACPI systems
Message-ID: <20261015141926.GC26205@e132581.arm.com>
References: <20261015062908.3565761-1-johnny.fan@cixtech.com>
 <86mrsf1bnv.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86mrsf1bnv.wl-maz@kernel.org>

On Thu, Oct 15, 2026 at 11:49:24AM +0100, Marc Zyngier wrote:

[...]

> > The CPUs without SPE are trimmed from the PMU supported CPUs by
> > probing PMSVer on each CPU, both at probe time (for online CPUs) and
> > from the hotplug callback (for CPUs that were offline at probe), as
> > ACPI conveys no affinity information and the PPI otherwise defaults
> > to all possible CPUs.
> 
> This is a bit odd: at the beginning, you are stating that the SPE
> interrupt being 0 is an indication of SPE not being supported. Then
> you check for PMSVer for the same properly. This seems pretty wrong.
> 
> It should be possible to build the mask of SPE-enabled CPUs without
> IPI-ing the other CPUs, and only rely on the firmware table.

Agreed.

The SPE driver probes its capabilities on one CPU selected by
smp_call_function_any(), then performs local setup on every CPU in
supported_cpus. It therefore relies on that mask being accurate;
including a CPU without SPE could lead to accesses to unimplemented
SPE system registers.

> > @@ -97,6 +100,20 @@ arm_acpi_register_pmu_device(struct platform_device *pdev, u8 len,
> >  			return gsi ? -ENXIO : 0;
> >  
> >  		this_gsi = parse_gsi(gicc);
> > +
> > +		if (optional) {
> > +			if (!this_gsi)
> > +				continue;
> > +
> > +			if (gsi && gsi != this_gsi) {
> > +				pr_warn("ACPI: %s: CPU%d: inconsistent interrupt %u/%u\n",
> > +					pdev->name, cpu, gsi, this_gsi);
> > +				return -ENXIO;
> > +			}
> > +			gsi = this_gsi;
> > +			continue;
> > +		}
> > +
> 
> This "optional" parameter feels very wrong. We now have an
> infrastructure to get a set of affinities for an interrupt (see
> 5324fe21ba9b7 and following patches). What this needs is ACPI to be
> plumbed into this.
> 
> Unfortunately, ACPI is awkward and very badly abstracted in this area,
> but that doesn't mean we should make the driver code more bizarre.
> 
> Treating SPE and TRBE differently is just as odd, and there is no
> reason to do other than suiting your particular platform.

Yes, SPE and TRBE should be consistent.

There is also a grouping question for SPE and TRBE. If all participating
CPUs implement the feature, but have different capabilities, should ACPI
registration create separate platform devices for the compatible CPU
groups? DT can describe separate CPU subsets using PPI partitions [1].

Thanks,
Leo

[1] https://github.com/torvalds/linux/blob/0fcb05b72344f40806cbe810de8872f1698bf053/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml#L139
[2] https://git.trustedfirmware.org/plugins/gitiles/TF-A/trusted-firmware-a.git/+/refs/heads/master/fdts/tc-base.dtsi#328
