Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794585644;
	b=Ffftpx4GrEJI5ThDXL6LMMTIX8LLEe+SRrcuw45wWUaFcxr4g2KlBFGUyErvLrC0Smby
	 gJSEXKUUKVhme9an7Zxd0aqPFTsR/3EV0vJwO0fGixzTuDKkEORPjdUVmsczOaAg9efgH
	 VNcm0AU65IPfQ1oyUwJfYYiaIpwOSanTYlaB8udqQd9Ys+h73ttg3EQayYWQJVc4rr6iN
	 2PJiMoiIMRN4YhZMSJUxYXxIgoXKSTsoaGJXg3uMnShsHnsyghqf+mQBXC192YJiXEWDq
	 8IgYJ/QvfwWDHQwlIE4e4vpGFgK+iTMxvUsAvqMstW25eWeoYcaLyCG0eFnpDspyYHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794585644;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=F5dahvAOImInV6SIjD8FOKW1Yr8AhR0mLeOjsT7+EeQ=;
	b=HiTisJrGc/Nvhc1/sflegxwDbjioXYKx0NL+cmxX5LkevUipEVzju/YfmUDqCDF3IZFz
	 Kqphf3MO1wgt95pRFSW5YdN8/eAtF7gsTOdiL3skJYJkiBCIzrMpaMEEXtmtcz5pL4+uY
	 30Ob6vRHWFMfkpIcp2D0ev9tJd7BWwafIJJLank0FqoKKtpeXrClh+lYVDCQpYjlS1R/6
	 YUcYN1ylI7hz6W4ybKt9vBg33OCF6m5Wz7xXutzSzIp3zIrmtrUK3UQL9lR6OTURl/rcp
	 KsstPIFU2tHtGwUKkzT5tVtTZ2giQGFitBPxv+RiZk9Lv9l48WdDofRZ2gxUGWqzIAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=aWBWdbQJ;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A65460A3824;
	Fri, 13 Nov 2026 16:00:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A65460A3824
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=aWBWdbQJ
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 660B0143D;
	Fri, 13 Nov 2026 08:00:40 -0800 (PST)
Received: from localhost (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 10DBB3F85F;
	Fri, 13 Nov 2026 08:00:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794585643; bh=F5dahvAOImInV6SIjD8FOKW1Yr8AhR0mLeOjsT7+EeQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aWBWdbQJBYg4MEtEMuhTMbj8Or0EiVBJ9zGCzjJSte9x+sC/BKA7tSzxX9aSPPoIQ
	 1vtTR23rbFSxPLB0Az3UZhQLt/KBmB+1yxCnVGLcKmsNuGB03sQ3qpBg30Rp5r5cmQ
	 GWhn/ELGpaZIsPZ4lSpFfWae24ZaNbmFELET0h2A=
Date: Fri, 13 Nov 2026 16:00:41 +0000
From: Leo Yan <leo.yan@arm.com>
To: "Johnny.Fan" <johnny.fan@cixtech.com>
Cc: will@kernel.org, mark.rutland@arm.com, suzuki.poulose@arm.com,
	jeremy.linton@arm.com, maz@kernel.org, mike.leach@arm.com,
	james.clark@linaro.org, alexander.shishkin@linux.intel.com,
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	cix-kernel-upstream@cixtech.com, jie.fu@cixtech.com,
	bob.zhang@cixtech.com, Fugang Duan <fugang.duan@cixtech.com>
Subject: Re: [PATCH v3 2/2] perf: arm_pmu_acpi: Support heterogeneous ACPI
 systems
Message-ID: <20261113160041.GS9176@e132581.arm.com>
References: <20261102084153.3975282-1-johnny.fan@cixtech.com>
 <20261102084153.3975282-3-johnny.fan@cixtech.com>
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
In-Reply-To: <20261102084153.3975282-3-johnny.fan@cixtech.com>

Hi Johnny,

On Mon, Nov 02, 2026 at 04:41:52PM +0800, Johnny.Fan wrote:

[...]

> Group the CPUs by (hetero id, interrupt) and register one platform
> device per group. A GSI may be shared between groups with
> non-overlapping CPU masks, so only unregister the GSI mapping once no
> successfully registered device uses it, as the mapping is not reference
> counted.

This is fine for me in general. For CPU grouping, we would prefter to
use MIDR rather than hetid, as events should be able to migrate between
CPUs with the same MIDR.

My concern is that we need particular change in SPE/TRBE drivers to
retrieve IRQ affinity based on this change. It is better to improve
fwnode layer to provide a general way for retrieve IRQ affinity. I did
a bit experiment with using swnode and seems it makes sense.

I would also consolidate CPU PMU device registration. That means we need
to extend the device registration to support SPI. We also need to update
PMU platform driver for ACPI device probe.

Based on above idea, I would fold your patch into my series (but I will
drop the first patch for changing TRBE/SPE drivers). I will keep you as
the author but please bear me a bit that I may refactor it to fit into
the extensions. Hope this is fine for you.

Thanks,
Leo
