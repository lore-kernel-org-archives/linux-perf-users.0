Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794907752;
	b=jqkilJu51IQ+IyhH5ZmdIR1F7y5e7aO/5hrJ4xefzYKwpVFRtbe2iGkozd1tkNDiuvcL
	 DkhFYFAC0xDiMB3uO/2gjmXXPEhZACa8UohkeFHBkPUfU9EeLoes3SIIusX2vlsSQyaXR
	 PHtNYKQGcnmZ1e0KiFLkP7hLtRhVTTsgCDNDVGGDUr+7z3sv+9AwGIgxbh3+uJUCMkewK
	 amexntZdHxc2iPG5o9o7JQLE8oR7UbcNbHBUlhbXGDOwS6ic0WBdBFZf8PJf3nypfrLin
	 RyyFWwCvEmGSP0XPVNSCKPNvwFNybwZkiRIUWbPToQGSq5CsNhx5B2RXE9XM6zXvYmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794907752;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
	bh=dF5MViTg8YOEEudif96/pwRP0E0s9rCachj6JTmLUVQ=;
	b=3EV+I7ojmK6D0vn+5gObrcXtjlqlBioATAFDYURN9kc5YTfxrDFebrVMqOsgMRqdGxkg
	 QAo9pLe+p1wy29iqUmV2+Ybdgqs8T8H/h7hFQOpn+77MsDt+GMQg+DGjShnDFc0AnjPn6
	 p/5S342zbL38FOmRYBqpwOgCCAkO6XTBbE7JDLJXhEzOGLgy24YsEpHrtC2BxpZlvtPOV
	 wT8j962iU5koLJBdOifmmP8jDvrOktWhKTqJ+hMcdx6mOq3rZe7LOtVQL0pQXhGh/MWWj
	 qQ7bFpJf/9exPjrjtMvSDZIyEcD52dlwvQceftPRqttL1F5rtyiHToly0z4V7SpHQIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=msinmYKc;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE2A606A31C;
	Tue, 17 Nov 2026 09:29:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9AE2A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=msinmYKc
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9C4DE339;
	Tue, 17 Nov 2026 01:29:07 -0800 (PST)
Received: from localhost (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2934E3F673;
	Tue, 17 Nov 2026 01:29:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794907750; bh=kYJCY4Q16lrxSHjHkE75I7AzcqNZxfjGXDBq1dW4/kA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=msinmYKcP7h/+3CgM+h7kdrK5GrIERhYbL2MsSCCh1EfKnt2NPt+3ozymW9Fx2nYe
	 iv+ISEGOMpbrbvls5z4OD/fBZ9jT03+KQ7sDkm5g44QFKIvp3D85WWc0SnEgvw/yyd
	 2MoU69TEdUGgBjY+MbRsUB7Qo6QPuOg9X0UHLyXE=
Date: Tue, 17 Nov 2026 09:29:08 +0000
From: Leo Yan <leo.yan@arm.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>, Johan Hovold <johan@kernel.org>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>,
	Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Jeremy Linton <jeremy.linton@arm.com>,
	Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@arm.com>,
	James Clark <james.clark@linaro.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Al Grant <al.grant@arm.com>, "Johnny.Fan" <johnny.fan@cixtech.com>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	driver-core@lists.linux.dev, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/8] device property: Add firmware node IRQ affinity
 callbacks
Message-ID: <20261117092908.GU9176@e132581.arm.com>
References: <20261116-acpi_arm_pmu_registration_hmp-v1-0-0371d4eca626@arm.com>
 <20261116-acpi_arm_pmu_registration_hmp-v1-1-0371d4eca626@arm.com>
 <avwFYMdr7g4r6Z9y@ashevche-desk.local>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <avwFYMdr7g4r6Z9y@ashevche-desk.local>

On Tue, Nov 17, 2026 at 09:42:24AM +0200, Andy Shevchenko wrote:
> On Mon, Nov 16, 2026 at 06:21:28PM +0000, Leo Yan wrote:
> > Platform IRQ affinity lookup currently selects the OF or ACPI helper
> > directly. Add fwnode_irq_get_affinity() and an irq_get_affinity operation
> > implemented by both firmware types.
> > 
> > Use the new helper for platform devices, preserving the existing fallback
> > to cpu_possible_mask when affinity information is unavailable.
> 
> From this commit message it's unclear why we do that. Is it any helpful in the
> future? If yes, for what?

This refactoring lets platform devices backed by swnode provide IRQ
affinity through the common fwnode interface. Patch 02 provides swnode's
IRQ affinity callback.

I will reply your comments in patch 02 for why we need swnode to
store IRQ affinity.

> ...
> 
> > static const struct cpumask *get_irq_affinity(struct platform_device *dev,
> 
> >  {
> >  	const struct cpumask *mask = NULL;
> >  #ifndef CONFIG_SPARC
> 
> > -	struct fwnode_handle *fwnode = dev_fwnode(&dev->dev);
> > -
> 
> Might be unneeded churn — you can leave these two lines being untouched.
> 
> > -	if (is_of_node(fwnode))
> > -		mask = of_irq_get_affinity(to_of_node(fwnode), num);
> > -	else if (is_acpi_device_node(fwnode))
> > -		mask = acpi_irq_get_affinity(ACPI_HANDLE_FWNODE(fwnode), num);
> 
> > +	mask = fwnode_irq_get_affinity(dev_fwnode(&dev->dev), num);
> 
> 	mask = fwnode_irq_get_affinity(fwnode, num);
> 
> >  #endif
> 
> >  	return mask ?: cpu_possible_mask;
> 
> But I understand the point as we have only a single user left. So I am not
> objecting the proposed approach, just pointed out on an alternative.

I'll keep the local fwnode variable as you suggest.

> ...
> 
> > +++ b/include/linux/fwnode.h
> 
> >  struct fwnode_operations;
> >  struct device;
> > +struct cpumask;
> 
> Yes, it's a bit disordered, can you place the new one before the 'device'
> to follow alphabetical order?

Will do.

Thanks,
Leo
