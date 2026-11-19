Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795107247;
	b=pMu6Q/H+ldxD8S+sRq1SZII0EC6Gh1R0jHJL2WRAS+BZr3C58fxYKPv6uSzecm+nYHVw
	 OjQNBzWfswn1heWl7M3M+znFhZnjohs22dsNzwtzEYC6WPotGl1fZtc//ecXUNdj6Yu4Y
	 TEQHNblTfhlF32KXp1/hxw9enPnNrBPO4szaQL6KZNEg7U7KAl/p8EjYaS0oGGKiC41vm
	 QB+w+yxrSLTBQjU7z6C8o9kODnHX0MEF1cC07b7HgBwWArLrBbqm1hAuMT/4HhB3O3gxe
	 ORtFVMA9Cyb5IL7fn72pmVOG32FjaJAQ5gsA4ACBwQDCrITpU3K0OWXyEhMt9e5Ac1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795107247;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=FpRAw10TJh8yb7R34VwZYYTrEJ2MgNuHTOaOU0kAmbg=;
	b=A87CmkBW2fVSqpWraEl7LzWsErxpKLKyZAruy0kl+NOjrXYZJS12x+WiPXR5nwRbhbm4
	 CQZCxn4/UT7RadJKRhYY/kRlTel42ZnEfysm4i5dIjrPpSVtHMUX+v5YX9vvbYuBATfPb
	 iqbOsZ8jPrEyJjNE8zwlyyCUteAv4hytruVe761THNQeDWzizMhk7jQQ/1+cwP5wU5ZlJ
	 zZfIAzSyQ4jjYMA+dxjIJLuY+FIb9KFa2wVk9tmz6Tdu/IJJzaFB6VboVNhqAA+vLbgsD
	 gUuHsrHF/dr1x/rD+s/OACMGvkkxXIpFGp9COQCke9nE04IorXtoDjMOR8jadhR5dxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=UdcRID8K;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C057606A338;
	Thu, 19 Nov 2026 16:54:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C057606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=UdcRID8K
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A8A901575;
	Thu, 19 Nov 2026 08:54:03 -0800 (PST)
Received: from localhost (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 360A43F673;
	Thu, 19 Nov 2026 08:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795107246; bh=UH4KDSFam0LfRKFnI3gJVWSsyCyljyOGfCQ7wrragEk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UdcRID8Kz4lZK/h1ThJUkIPZuCu8llRVTIWUol7CEgsEAJDWIJ0dMrQdRTWZMoOz2
	 XP992aMvTFRo5UvN7IMTff5COtXdHBV8kWVELcF8QaQZkmk72M2pRJtv6Ua4OgHRjd
	 /qd3KyGzwJg18bFRXM4FHYSooM96/pJ6aeSI40CE=
Date: Thu, 19 Nov 2026 16:54:04 +0000
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
Subject: Re: [PATCH 2/8] device property: Add software-node IRQ affinity masks
Message-ID: <20261119165404.GA9176@e132581.arm.com>
References: <20261116-acpi_arm_pmu_registration_hmp-v1-0-0371d4eca626@arm.com>
 <20261116-acpi_arm_pmu_registration_hmp-v1-2-0371d4eca626@arm.com>
 <avwHQXJxOir8XXxX@ashevche-desk.local>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <avwHQXJxOir8XXxX@ashevche-desk.local>

On Tue, Nov 17, 2026 at 09:50:25AM +0200, Andy Shevchenko wrote:
> On Mon, Nov 16, 2026 at 06:21:29PM +0000, Leo Yan wrote:
> > Devices created from firmware tables may need CPU affinity information
> > without a corresponding firmware node. Allow software nodes to supply
> > this information through the common firmware node IRQ affinity API.
> > 
> > Add software_node_add_irq_affinity() to copy a CPU mask for an IRQ index,
> > and implement the software node irq_get_affinity callback. Keep each mask
> > until the node is released and reject replacement so borrowed masks remain
> > valid for the node's lifetime.
> 
> 
> This is definitely not a place where to put that. Are you stating that any
> software node might find the IRQ affinity information useful? I don't think
> so. With that in mind this approach looks like a layering violation.

My intent is to expose optional affinity information through the
common platform_get_irq_affinity() interface.

As an alternative, could we represent the masks in an "irq-affinity"
property, with one CPU mask per IRQ index? The swnode .irq_get_affinity
callback would read it, using the existing property storage.

Would interpreting this property in swnode still be a layering
violation? See the sample code below.

---8<---

+static const struct cpumask *
+software_node_irq_get_affinity(const struct fwnode_handle *fwnode,
+			       unsigned int index)
+{
+	const struct property_entry *prop;
+	const void *masks;
+	size_t size = cpumask_size();
+
+	prop = property_entry_get(to_swnode(fwnode)->node->properties, "irq-affinity");
+	if (!prop || index >= prop->length / size)
+		return NULL;
+
+	masks = property_get_pointer(prop);
+	return masks ? masks + index * size : NULL;
+}
+
 static const struct fwnode_operations software_node_ops = {
 	.get = software_node_get,
 	.put = software_node_put,
@@ -774,6 +796,7 @@ static const struct fwnode_operations software_node_ops = {
 	.graph_get_port_parent = software_node_graph_get_port_parent,
 	.graph_parse_endpoint = software_node_graph_parse_endpoint,
 	.add_links = software_node_add_links,
+	.irq_get_affinity = software_node_irq_get_affinity,
 };

> ...
> 
> And overall, the domain specific (IRQ, DMA, et cetera) topics feels a bit
> misplaced when one can find that in the generic properties. We also have
> that PHY thingy, which is complete alien to word 'generic'.

Since software nodes have no standard property specification of their
own, would this be an appropriate way to define "irq-affinity" as a
generic swnode property?

Thanks for the review!

Leo
