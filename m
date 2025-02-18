Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49DB713D51E;
	Tue, 18 Feb 2025 10:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739876322; cv=none; b=TmmeCTYNCGkUTAw6Pt0L9m4H8Dg9muIpjPmXofzNTQIXeV7ZBj1IaXp79P5OIZDhmEDwu1PlHlFvBYEElhXnFQYiZN1lqIXFsHZam1CjLr4+P23dVEhP+Dh4Wqcqn9fGJfBprcq7Tma1ukslIrPjUiBCOaPKrAqr3rsoVv36fAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739876322; c=relaxed/simple;
	bh=JrSYRQbRbJIRg2Bl8bm/Ov8CdgaQPul6Fqzh7AfEKfM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dqg2rhPG6nLZyWd0/hGT98rnRqcZ1Mi1/Lk9I7EZUGYLCjEqyn7O7Y4sHkII3YczoNzfSrHFa4GIb0d9BtB7EDwfg3DtFxmt0M73keOVFrC8JTgm4bMLVDSzwof89zDWcdz3Z8Bxm+JJ1WdAlQy/Cs8lYY+Fn9aQXgq+WudtIL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=xQY828Vy; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="xQY828Vy"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1739876315; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=pmDZr8RzS+flLxV3A4zL7q/WNhMN3Hm30taNoOceehA=;
	b=xQY828Vy2KA0XT7IRoMqtFkcZFpw0xeOtEqaV/lWlIznhV7MCUZpwHA8CNlIiynjXtr+fEXaWkoGxQ1qC0Vk5FJG0Rz2xhYzby6RXCpl93NTUrUN1QVahRPeD5qdDOuwfV66Zp14FctVBK+CkLQgLLN5uSCzjiXqd+Gcqy2CXbs=
Received: from U-V2QX163P-2032.local(mailfrom:fengwei_yin@linux.alibaba.com fp:SMTPD_---0WPlh.8b_1739876313 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 18 Feb 2025 18:58:34 +0800
Date: Tue, 18 Feb 2025 18:58:32 +0800
From: YinFengwei <fengwei_yin@linux.alibaba.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: will@kernel.org, mark.rutland@arm.com, 
	linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	jie.li.linux@linux.alibaba.com
Subject: Re: [PATCH] perf/arm-cmn: don't claim resource during ioremap() for
 CMN700 with ACPI
Message-ID: <hfip42i45jkumuvgdthxm2bk6qylqyqh6erzaq43yiqygvn6uu@dcui675lwtkm>
References: <20250218012111.30068-1-fengwei_yin@linux.alibaba.com_quarantine>
 <d5040b5c-564d-4abf-be22-d2aa1183b633@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5040b5c-564d-4abf-be22-d2aa1183b633@arm.com>

On Tue, Feb 18, 2025 at 10:31:42AM +0800, Robin Murphy wrote:
> On 2025-02-18 1:21 am, Yin Fengwei wrote:
> > Currently, arm-cmn PMU driver assumes ACPI claim resource
> > for CMN600 + ACPI. But with CMN700 + ACPI, the device probe
> > failed because of resource claim failes when ioremap() is
> > called:
> > [   10.837300] arm-cmn ARMHC700:00: error -EBUSY: can't request region for resource [mem 0x40000000-0x4fffffff]
> > [   10.847310] arm-cmn ARMHC700:00: probe with driver arm-cmn failed with error -16
> > [   10.854726] arm-cmn ARMHC700:02: error -EBUSY: can't request region for resource [mem 0x40040000000-0x4004fffffff]
> > [   10.865085] arm-cmn ARMHC700:02: probe with driver arm-cmn failed with error -16
> > 
> > Let CMN700 + ACPI do same as CMN600 + ACPI to allow CMN700
> > work in ACPI env.
> 
> No, the CMN-600 routine is a special case for CMN-600 having two nested
> memory resources of its own. CMN-700 and everything else only have one
> memory resource, so that is not appropriate. What else is claiming the
> region to cause a conflict?
Sorry. Forgot the link for the new proposed fix:
https://lore.kernel.org/all/Z7QYlUP6nfBNMXsv@U-V2QX163P-2032.local/

My understanding is that there are two problems here:
1. ACPI claim the memory range and that's why we see this -EBUSY error
   with correct code path for CMN700 + ACPI table.

2. It's not correct to apply CMN600 probe method to CMN700 because
   CMN600 has two nested memory resouces while CMN700 should only have
   one memory resource. And you don't want to introduce trick to handle
   incorect ACPI DSDT.

Regards
Yin, Fengwei

> 
> Thanks,
> Robin.
