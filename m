Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B2C189914;
	Fri, 25 Oct 2024 08:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729844427; cv=none; b=VlZ/G4sicsWVKgsmu24qP8FQ82OP4bZGQQkPOdxCYN7gh3K/sHgqjyfr5ZortJcb3xBLXrAUlELUyqyUGIpWOsb/dleQs/uSHYzGeYm7Jsl6nQjbWNvMHM0EfRn6CmLL3Hajt3rEXCp2rN+4efTX0itmNDYIQ5tg1gu6Uu4ywpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729844427; c=relaxed/simple;
	bh=IGnhVY9qWQQlfpRCk+kdklhvIcFoKmf03HVY3gYCAbg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZNY83BIgG2VtvJPH0k+UCuZyH2CWP/a/GpP2XpC8QtU/3MnGUo2dgnMDyttvGd1iAfxH9Htrn+kuxgMIwkH8FUzTV+YhTrDaOB69jNSJCPPwb3nJkbM1ao0dHyucbYGSvUqNC0Qu2n5/5XfuGyrymHZjesIeA6NZgPTtxsrsB6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=irUoVhg3; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="irUoVhg3"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=EdrzlG5lxzYsBwtXdHwYIAcoVtX295ayqSh/lYdVec0=; b=irUoVhg32hUHfrvRiFRjIldb7Z
	m+5BIoOTE0fm/Ybxny87+tDr3T57Gr1Fl2IPaDwPCQ5x2/h16LhCu6mBrnNimNPtPpAxqmZpLshcc
	vYEieCgGHG4nptx8A+9fLlFw4TH3bCIg5cGAHg3AiktMKNdbObNwn3Qd7MZ9bncT/FE1S5Q20Z5EX
	FkbOrfdwnIyNFppm+Iga9XW+3iggOnmGnCN865WOflZPpTL0/Wfsv/wvsEYLJX5prcsdISmH2dPHj
	aS1x5Dx9tqXxdVkLJOleffHceUgrPmqHDN68FVRef9GITm69UHAnxMe2aoEjdlIS/UpVFoa+orFAJ
	9htJROBw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t4FYQ-00000008rTV-1G0I;
	Fri, 25 Oct 2024 08:20:20 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 83F3630083E; Fri, 25 Oct 2024 10:20:17 +0200 (CEST)
Date: Fri, 25 Oct 2024 10:20:17 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [peterz-queue:perf/pmu-unregister] [perf] 4cbf3df69c:
 BUG:kernel_NULL_pointer_dereference,address
Message-ID: <20241025082017.GF14555@noisy.programming.kicks-ass.net>
References: <202410251048.2505fe51-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202410251048.2505fe51-lkp@intel.com>

On Fri, Oct 25, 2024 at 10:19:41AM +0800, kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed "BUG:kernel_NULL_pointer_dereference,address" on:
> 
> commit: 4cbf3df69c5697061018989b08423d4c04bbe101 ("perf: Make perf_pmu_unregister() useable")
> https://git.kernel.org/cgit/linux/kernel/git/peterz/queue.git perf/pmu-unregister
> 
> in testcase: trinity
> version: trinity-x86_64-ba2360ed-1_20240923
> with following parameters:
> 
> 	runtime: 600s
> 
> 
> 
> config: x86_64-kexec
> compiler: clang-18
> test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> 
> (please refer to attached dmesg/kmsg for entire log/backtrace)
> 
> 
> +-----------------------------------------------------------+------------+------------+
> |                                                           | d4187ab34e | 4cbf3df69c |
> +-----------------------------------------------------------+------------+------------+
> | BUG:kernel_NULL_pointer_dereference,address               | 0          | 15         |
> | Oops                                                      | 0          | 15         |
> | RIP:__free_event                                          | 0          | 15         |
> | Kernel_panic-not_syncing:Fatal_exception                  | 0          | 15         |
> +-----------------------------------------------------------+------------+------------+
> 
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202410251048.2505fe51-lkp@intel.com
> 
> 
> [   27.301103][ T3733] BUG: kernel NULL pointer dereference, address: 0000000000000008
> [   27.302392][ T3733] #PF: supervisor write access in kernel mode
> [   27.303317][ T3733] #PF: error_code(0x0002) - not-present page
> [   27.304207][ T3733] PGD 80000001bfbc3067 P4D 80000001bfbc3067 PUD 1ae899067 PMD 0
> [   27.305417][ T3733] Oops: Oops: 0002 [#1] PREEMPT SMP PTI
> [   27.306260][ T3733] CPU: 0 UID: 65534 PID: 3733 Comm: trinity-c0 Not tainted 6.12.0-rc2-00028-g4cbf3df69c56 #1
> [   27.307747][ T3733] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> [ 27.309232][ T3733] RIP: 0010:__free_event (include/linux/list.h:195 include/linux/list.h:218 include/linux/list.h:229 kernel/events/core.c:5395) 

> [ 27.334428][ T3733] ? __free_event (include/linux/list.h:195 include/linux/list.h:218 include/linux/list.h:229 kernel/events/core.c:5395) 
> [ 27.335253][ T3733] ? __free_event (include/linux/list.h:218 include/linux/list.h:229 kernel/events/core.c:5395) 
> [ 27.336027][ T3733] perf_event_alloc (kernel/events/core.c:12566) 
> [ 27.336836][ T3733] __se_sys_perf_event_open (kernel/events/core.c:12978) 
> [ 27.337703][ T3733] ? enqueue_hrtimer (kernel/time/hrtimer.c:1093) 
> [ 27.338512][ T3733] ? hrtimer_start_range_ns (kernel/time/hrtimer.c:1302) 
> [ 27.339427][ T3733] do_syscall_64 (arch/x86/entry/common.c:?) 
> [ 27.340215][ T3733] ? irqentry_exit_to_user_mode (arch/x86/include/asm/processor.h:701 arch/x86/include/asm/entry-common.h:100 include/linux/entry-common.h:364 kernel/entry/common.c:233) 

This might help... Let me fold that and push out an updated brranch.

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -12395,6 +12395,7 @@ perf_event_alloc(struct perf_event_attr
 	INIT_LIST_HEAD(&event->active_entry);
 	INIT_LIST_HEAD(&event->addr_filters.list);
 	INIT_HLIST_NODE(&event->hlist_entry);
+	INIT_LIST_HEAD(&event->pmu_list);
 
 
 	init_waitqueue_head(&event->waitq);
