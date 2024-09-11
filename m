Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5910E157480;
	Wed, 11 Sep 2024 09:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726047943; cv=none; b=EZi1uRSoXMzxxy8HvMwYKJGxB3w34SlTWNjwyIdjlxKN3Usd1S9zm0Qp4xQMw67ijYDVwOZN/20DRaEpnmC06Y8hdyedZyCPSLsvznOH5jEyqHNim96G/2lg9x1hEM+RSCWdaS5yWwPVa0hj8zEqHPTZgyYzg/1BbcYaqjrXy58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726047943; c=relaxed/simple;
	bh=M9xzdKCV528AWjyhxcpr9fldRzcHF3Zr3CcpVRKx+yw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a6eqDJKntfAWt/x6cryYQgEPYfEnb63X65QuUGhqBr04e+BDNpe+jVUAxkUksR+XSvSLxuptxguMpc2KcK8r/ZFm65JdHZropw2+c4agrcL6eZpaCEiMhbnhgHxj8RNlNqDHHpi5Dnwq+kUPjCRlbOGIpYHbUd0Asm8HvylQJD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Zq/iawNy; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Zq/iawNy"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=IA1WLHJ84fTYPUbImP/w8EfdJseyVFaHxMOtPtkiN0k=; b=Zq/iawNyJsiXYutpv6il/K1pgs
	KYbYJz8RdrllwHMPBicQPdp14mXv3TA4D0z8u0pRzpoQTXzUrY5TAMkJiOJD9mJNAcXf9lgZ+rkqJ
	BcL1t1CLbEpeDIxF5tWnR3USOlwwMCbfH9IAQFNtu/pB9UH4ayiTVUElLqm2h+HeHNoyDUz9/Lxs3
	0R++3DYeLHbDij8KscM0iq+uNy9FjyatNxSDiWJBiCuXfsUhiYS8Kj10lYjV1z7qoNBLNxT6RDkOA
	VfvOrwDNuk1BqsYH7Yd5XRFKy8nBM3SCR8BM9pcejKUDEvxgbWig1G5xWu+No3a6ktnWiHVbWk9MD
	9BiAEEIg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1soJur-000000009IO-0JQf;
	Wed, 11 Sep 2024 09:45:37 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 82FC0300642; Wed, 11 Sep 2024 11:45:36 +0200 (CEST)
Date: Wed, 11 Sep 2024 11:45:36 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: kernel test robot <oliver.sang@intel.com>
Cc: Kan Liang <kan.liang@linux.intel.com>, oe-lkp@lists.linux.dev,
	lkp@intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [peterz-queue:perf/core] [perf/x86/rapl]  90942140bb:
 UBSAN:array-index-out-of-bounds_in_arch/x86/events/rapl.c
Message-ID: <20240911094536.GP4723@noisy.programming.kicks-ass.net>
References: <202409111521.c7c6d56f-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202409111521.c7c6d56f-lkp@intel.com>

On Wed, Sep 11, 2024 at 04:32:13PM +0800, kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed "UBSAN:array-index-out-of-bounds_in_arch/x86/events/rapl.c" on:
> 
> commit: 90942140bb6cc7e9a41d5927c7617ee522896f7a ("perf/x86/rapl: Move the pmu allocation out of CPU hotplug")
> https://git.kernel.org/cgit/linux/kernel/git/peterz/queue.git perf/core
> 
> in testcase: boot
> 
> compiler: clang-18
> test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> 
> (please refer to attached dmesg/kmsg for entire log/backtrace)
> 
> 
> +-----------------------------------------------------------+------------+------------+
> |                                                           | c206df6d69 | 90942140bb |
> +-----------------------------------------------------------+------------+------------+
> | UBSAN:array-index-out-of-bounds_in_arch/x86/events/rapl.c | 0          | 12         |
> +-----------------------------------------------------------+------------+------------+
> 
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202409111521.c7c6d56f-lkp@intel.com
> 
> 
> [   22.115286][    T1] ------------[ cut here ]------------
> [   22.115957][    T1] UBSAN: array-index-out-of-bounds in arch/x86/events/rapl.c:685:3

That is:

		rapl_pmus->pmus[topology_logical_die_id(cpu)] = pmu;

Which is scaled like:

	int nr_rapl_pmu = topology_max_packages() * topology_max_dies_per_package();

And that isn't new in that patch, just moved around.

Kan, as it happens these two patches got zapped by Ingo because they
conflict with that rapl patch from perf/urgent and he merged perf/urgent
into perf/core.

I was going to rebase these two patches on top, but given the above, can
you have a look instead?

