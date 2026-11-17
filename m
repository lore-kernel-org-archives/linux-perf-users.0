Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794901841;
	b=2I9GUeT4HhPIKQQKxHRhSZ+pu6meDmB0xe2HyFcZyLTOBC6PIvNbaAiXWDi1iT/VgD6K
	 TPvR6wpt4g/kbmimnp44zs+cgEtfKOj0C2mfJbp4ftMeXnGYgo9QUfTDHdoPCbqCc9uJo
	 KCim/u8C0lxI9uTyWsqDBX5zu4kVXTm1ueZzKf/NjYMj0qXdMQ7Q7JIrbqLgFl+LV+vmQ
	 7Icy4iWxrHnKWAnwH9ELPHax24Yz3Rxg5wlYiODJlrbMf1wV/rANCzPLwWNlsqmWYbTvD
	 t9IP0KWzeWm+/K8E06SU+5mLYSyR6+3BzCgC+kG7Wjqiekr/yN3LrP3ytkmh3QJtjrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794901841;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=8vgPP6Tx8J3tAl7vzRS2f9bzf7D4zQHjlRLap4jWt7g=;
	b=jadh8d2PezUH9dGPgCTKmXjxGBodsDbjYorWoVo1apf/O09dXIh/SFlcwRcCudCP4M8V
	 Mhe7MWGoa9PRWc1AKtJ4Jk3RpZOlEoYuf20rX39hfNPAuA7IS33R6IC7LUQNG9lAYWwwc
	 MpsI7+lxyP7GGTiQ1k1GOjtueNuIOAcOYsvCOD/Zg7p2ewHfK+Bh1MhoCUjulmgR2arLS
	 8QpKTUKjK+fXG5PO7tqm1FOa0wRGr/jDCenmW3X1TtyZxdO3IsdxHrKJTGYBFVHbLLCCN
	 T1U74NrS0xHnoAwCrNg1T0TZdcpqfogIezdRkMriXghTTtnPa+AQajjHRWcy9IUMk8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UycOj9WC;
	arc=none smtp.remote-ip=192.198.163.9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4AB8606A31C;
	Tue, 17 Nov 2026 07:50:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D4AB8606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UycOj9WC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794901837; x=1826437837;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7tsumGXRfcakGcSfEArUg8RNIoKnnuupodfU8GGdp+M=;
  b=UycOj9WCE4X2k7ZMrO4LTK0CtdxMyXT0yzmLPVfci8HsJpj0Rs10ML1/
   NzlrCfRk+HBBIPU+NAQwCHZFdOexGOvJB9IGGJ7wMY9Z8EI4sfk93Qh2I
   5BrkRksOQa1OYeaNJKYo3QIRLlUrA3dLB0Stomie6N/uSQKd1eD8r4MTb
   2FZTwFeFXEUFH6m+vLWMtlxO0GGyvbuqvDo9Dd8g+MMr2zYBsdX/fP8bM
   UxtnxOYimdljjosfLxmGhogGcEuPBDlM6Yf4vwln0p+33nT/wzlCxF0nO
   TQ4XU2JCMwJTkNv0lSPMky/oTmXjstCh7bOSUuSPPkQ2MXnu+iNigd5hz
   w==;
X-CSE-ConnectionGUID: WfNyz3uES8ytWCSe0scSGg==
X-CSE-MsgGUID: sq1I0iY2RcyFhe6R8SFj6A==
X-IronPort-AV: E=McAfee;i="6800,10657,11968"; a="3542643"
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="3542643"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 23:50:35 -0800
X-CSE-ConnectionGUID: SPVU5nc+QZS67WCpD35Wow==
X-CSE-MsgGUID: Jd/piBRPQmaHbo+f4M+jFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="9774997"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.254])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 23:50:27 -0800
Date: Tue, 17 Nov 2026 09:50:25 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Leo Yan <leo.yan@arm.com>
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
Message-ID: <avwHQXJxOir8XXxX@ashevche-desk.local>
References: <20261116-acpi_arm_pmu_registration_hmp-v1-0-0371d4eca626@arm.com>
 <20261116-acpi_arm_pmu_registration_hmp-v1-2-0371d4eca626@arm.com>
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
In-Reply-To: <20261116-acpi_arm_pmu_registration_hmp-v1-2-0371d4eca626@arm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Nov 16, 2026 at 06:21:29PM +0000, Leo Yan wrote:
> Devices created from firmware tables may need CPU affinity information
> without a corresponding firmware node. Allow software nodes to supply
> this information through the common firmware node IRQ affinity API.
> 
> Add software_node_add_irq_affinity() to copy a CPU mask for an IRQ index,
> and implement the software node irq_get_affinity callback. Keep each mask
> until the node is released and reject replacement so borrowed masks remain
> valid for the node's lifetime.


This is definitely not a place where to put that. Are you stating that any
software node might find the IRQ affinity information useful? I don't think
so. With that in mind this approach looks like a layering violation.

...

And overall, the domain specific (IRQ, DMA, et cetera) topics feels a bit
misplaced when one can find that in the generic properties. We also have
that PHY thingy, which is complete alien to word 'generic'.

-- 
With Best Regards,
Andy Shevchenko


