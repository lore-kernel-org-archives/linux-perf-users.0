Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D818F4E2;
	Thu,  5 Dec 2024 02:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733365051; cv=none; b=TB7dMnXW6nykhsl9NHlXUg8eB8hBlaebFzjOlX6giqVv8SNZrav6/QlS6OxKSrLrJjx2t5K63gDkBvvIpek+CagoX4eKIETwlB/eTafa7RR6ziZZ4WDEuEFwHql9dgv7dNopCeIcoxbGTcS+9UP1EOU733Isz6rGr75yYIj0OE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733365051; c=relaxed/simple;
	bh=Y1sJJLmEmkNjvVUyOmSvBDRUkbsmGO+F6NgDqW4V+u4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sTeUALxZxvq9zlvPz0tFcCAde5OExTZpYzS6knRl4BGufarQTbjiEdLLPIbFiXauDL0uH4hhFdGIsnl33TURDPdegrUSoDaVM80M6SjZopB9NefrCdKN0CDdURk9RNFj3x7PE6D7VQ+aQTJG1sEgRAW5b+kc+jPRHqNDGSkwMKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DJIsSnKT; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DJIsSnKT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733365050; x=1764901050;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Y1sJJLmEmkNjvVUyOmSvBDRUkbsmGO+F6NgDqW4V+u4=;
  b=DJIsSnKTSyplEi7tpSphxi0w4wAiM3x0NsLRC8D3sVTMc/a5xdbCgKaI
   8EfluC9Xzku4YKgoNrLXw7U63riqdoLulYVpaWaca3KY963xFik1KE4pL
   wX1SoUPddsMer0/801OzfnoEX37hnFLby0nEbYAOnQopniNVyagblxlxF
   azIiiiwEJ/oJDttn3fG8HDhFX9/EWojkQrI8hpuSmyR4GTPscYErQF8qW
   Yu/NQs55SAG6J+YFhld5l5YrRycE0wmkoZUUOUBDbiJy3Dl8fqNVXZ1pT
   a5Cj/hEhPui2k4EZgfoRcf5XM1l+gRNuAkJ+h4U0sy3CYtYNtjtp9YwBK
   A==;
X-CSE-ConnectionGUID: qU943IpPQcW0LJCNfEPGFA==
X-CSE-MsgGUID: xa9Ot15rT7asTDfOOyef6w==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="33905289"
X-IronPort-AV: E=Sophos;i="6.12,209,1728975600"; 
   d="scan'208";a="33905289"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2024 18:17:28 -0800
X-CSE-ConnectionGUID: vsgJLFLmRJ6d/I3PErLUTg==
X-CSE-MsgGUID: Aiujf5ReR56FHE/0RRf6Aw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,209,1728975600"; 
   d="scan'208";a="98022540"
Received: from ly-workstation.sh.intel.com (HELO ly-workstation) ([10.239.161.23])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2024 18:17:24 -0800
Date: Thu, 5 Dec 2024 10:16:51 +0800
From: "Lai, Yi" <yi1.lai@linux.intel.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Matthew Wilcox <willy@infradead.org>,
	David Hildenbrand <david@redhat.com>, yi1.lai@intel.com
Subject: Re: [PATCH v2] perf: map pages in advance
Message-ID: <Z1ENEwafY7g/rzeo@ly-workstation>
References: <20241129153134.82755-1-lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241129153134.82755-1-lorenzo.stoakes@oracle.com>

On Fri, Nov 29, 2024 at 03:31:34PM +0000, Lorenzo Stoakes wrote:
> We are current refactoring struct page to make it smaller, removing
> unneeded fields that correctly belong to struct folio.
> 
> Two of those fields are page->index and page->mapping. Perf is currently
> making use of both of these, so this patch removes this usage as it turns
> out it is unnecessary.
> 
> Perf establishes its own internally controlled memory-mapped pages using
> vm_ops hooks. The first page in the mapping is the read/write user control
> page, and the rest of the mapping consists of read-only pages.
> 
> The VMA is backed by kernel memory either from the buddy allocator or
> vmalloc depending on configuration. It is intended to be mapped read/write,
> but because it has a page_mkwrite() hook, vma_wants_writenotify() indicaets
> that it should be mapped read-only.
> 
> When a write fault occurs, the provided page_mkwrite() hook,
> perf_mmap_fault() (doing double duty handing faults as well) uses the
> vmf->pgoff field to determine if this is the first page, allowing for the
> desired read/write first page, read-only rest mapping.
> 
> For this to work the implementation has to carefully work around faulting
> logic. When a page is write-faulted, the fault() hook is called first, then
> its page_mkwrite() hook is called (to allow for dirty tracking in file
> systems).
> 
> On fault we set the folio's mapping in perf_mmap_fault(), this is because
> when do_page_mkwrite() is subsequently invoked, it treats a missing mapping
> as an indicator that the fault should be retried.
> 
> We also set the folio's index so, given the folio is being treated as faux
> user memory, it correctly references its offset within the VMA.
> 
> This explains why the mapping and index fields are used - but it's not
> necessary.
> 
> We preallocate pages when perf_mmap() is called for the first time via
> rb_alloc(), and further allocate auxiliary pages via rb_aux_alloc() as
> needed if the mapping requires it.
> 
> This allocation is done in the f_ops->mmap() hook provided in perf_mmap(),
> and so we can instead simply map all the memory right away here - there's
> no point in handling (read) page faults when we don't demand page nor need
> to be notified about them (perf does not).
> 
> This patch therefore changes this logic to map everything when the mmap()
> hook is called, establishing a PFN map. It implements vm_ops->pfn_mkwrite()
> to provide the required read/write vs. read-only behaviour, which does not
> require the previously implemented workarounds.
> 
> While it is not ideal to use a VM_PFNMAP here, doing anything else will
> result in the page_mkwrite() hook need to be provided, which requires the
> same page->mapping hack this patch seeks to undo.
> 
> It will also result in the pages being treated as folios and placed on the
> rmap, which really does not make sense for these mappings.
> 
> Semantically it makes sense to establish this as some kind of special
> mapping, as the pages are managed by perf and are not strictly user pages,
> but currently the only means by which we can do so functionally while
> maintaining the required R/W and R/O bheaviour is a PFN map.
> 
> There should be no change to actual functionality as a result of this
> change.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
> v2:
> * nommu fixup.
> * Add comment explaining why we are using a VM_PFNMAP as suggested by
>   David H.
> 
> v1:
> https://lore.kernel.org/all/20241128113714.492474-1-lorenzo.stoakes@oracle.com/
> 
>  kernel/events/core.c        | 116 ++++++++++++++++++++++++------------
>  kernel/events/ring_buffer.c |  19 +-----
>  2 files changed, 80 insertions(+), 55 deletions(-)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 5d4a54f50826..1bb5999d9d81 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -6284,41 +6284,6 @@ void perf_event_update_userpage(struct perf_event *event)
>  }
>  EXPORT_SYMBOL_GPL(perf_event_update_userpage);
> 
> -static vm_fault_t perf_mmap_fault(struct vm_fault *vmf)
> -{
> -	struct perf_event *event = vmf->vma->vm_file->private_data;
> -	struct perf_buffer *rb;
> -	vm_fault_t ret = VM_FAULT_SIGBUS;
> -
> -	if (vmf->flags & FAULT_FLAG_MKWRITE) {
> -		if (vmf->pgoff == 0)
> -			ret = 0;
> -		return ret;
> -	}
> -
> -	rcu_read_lock();
> -	rb = rcu_dereference(event->rb);
> -	if (!rb)
> -		goto unlock;
> -
> -	if (vmf->pgoff && (vmf->flags & FAULT_FLAG_WRITE))
> -		goto unlock;
> -
> -	vmf->page = perf_mmap_to_page(rb, vmf->pgoff);
> -	if (!vmf->page)
> -		goto unlock;
> -
> -	get_page(vmf->page);
> -	vmf->page->mapping = vmf->vma->vm_file->f_mapping;
> -	vmf->page->index   = vmf->pgoff;
> -
> -	ret = 0;
> -unlock:
> -	rcu_read_unlock();
> -
> -	return ret;
> -}
> -
>  static void ring_buffer_attach(struct perf_event *event,
>  			       struct perf_buffer *rb)
>  {
> @@ -6558,13 +6523,87 @@ static void perf_mmap_close(struct vm_area_struct *vma)
>  	ring_buffer_put(rb); /* could be last */
>  }
> 
> +static vm_fault_t perf_mmap_pfn_mkwrite(struct vm_fault *vmf)
> +{
> +	/* The first page is the user control page, others are read-only. */
> +	return vmf->pgoff == 0 ? 0 : VM_FAULT_SIGBUS;
> +}
> +
>  static const struct vm_operations_struct perf_mmap_vmops = {
>  	.open		= perf_mmap_open,
>  	.close		= perf_mmap_close, /* non mergeable */
> -	.fault		= perf_mmap_fault,
> -	.page_mkwrite	= perf_mmap_fault,
> +	.pfn_mkwrite	= perf_mmap_pfn_mkwrite,
>  };
> 
> +static int map_range(struct perf_buffer *rb, struct vm_area_struct *vma)
> +{
> +	unsigned long nr_pages = vma_pages(vma);
> +	int err = 0;
> +	unsigned long pgoff;
> +
> +	/*
> +	 * We map this as a VM_PFNMAP VMA.
> +	 *
> +	 * This is not ideal as this is designed broadly for mappings of PFNs
> +	 * referencing memory-mapped I/O ranges or non-system RAM i.e. for which
> +	 * !pfn_valid(pfn).
> +	 *
> +	 * We are mapping kernel-allocated memory (memory we manage ourselves)
> +	 * which would more ideally be mapped using vm_insert_page() or a
> +	 * similar mechanism, that is as a VM_MIXEDMAP mapping.
> +	 *
> +	 * However this won't work here, because:
> +	 *
> +	 * 1. It uses vma->vm_page_prot, but this field has not been completely
> +	 *    setup at the point of the f_op->mmp() hook, so we are unable to
> +	 *    indicate that this should be mapped CoW in order that the
> +	 *    mkwrite() hook can be invoked to make the first page R/W and the
> +	 *    rest R/O as desired.
> +	 *
> +	 * 2. Anything other than a VM_PFNMAP of valid PFNs will result in
> +	 *    vm_normal_page() returning a struct page * pointer, which means
> +	 *    vm_ops->page_mkwrite() will be invoked rather than
> +	 *    vm_ops->pfn_mkwrite(), and this means we have to set page->mapping
> +	 *    to work around retry logic in the fault handler, however this
> +	 *    field is no longer allowed to be used within struct page.
> +	 *
> +	 * 3. Having a struct page * made available in the fault logic also
> +	 *    means that the page gets put on the rmap and becomes
> +	 *    inappropriately accessible and subject to map and ref counting.
> +	 *
> +	 * Ideally we would have a mechanism that could explicitly express our
> +	 * desires, but this is not currently the case, so we instead use
> +	 * VM_PFNMAP.
> +	 *
> +	 * We manage the lifetime of these mappings with internal refcounts (see
> +	 * perf_mmap_open() and perf_mmap_close()) so we ensure the lifetime of
> +	 * this mapping is maintained correctly.
> +	 */
> +	for (pgoff = 0; pgoff < nr_pages; pgoff++) {
> +		unsigned long va = vma->vm_start + PAGE_SIZE * pgoff;
> +		struct page *page = perf_mmap_to_page(rb, pgoff);
> +
> +		if (page == NULL) {
> +			err = -EINVAL;
> +			break;
> +		}
> +
> +		/* Map readonly, perf_mmap_pfn_mkwrite() called on write fault. */
> +		err = remap_pfn_range(vma, va, page_to_pfn(page), PAGE_SIZE,
> +				      vm_get_page_prot(vma->vm_flags & ~VM_SHARED));
> +		if (err)
> +			break;
> +	}
> +
> +#ifdef CONFIG_MMU
> +	/* Clear any partial mappings on error. */
> +	if (err)
> +		zap_page_range_single(vma, vma->vm_start, nr_pages * PAGE_SIZE, NULL);
> +#endif
> +
> +	return err;
> +}
> +
>  static int perf_mmap(struct file *file, struct vm_area_struct *vma)
>  {
>  	struct perf_event *event = file->private_data;
> @@ -6783,6 +6822,9 @@ static int perf_mmap(struct file *file, struct vm_area_struct *vma)
>  	vm_flags_set(vma, VM_DONTCOPY | VM_DONTEXPAND | VM_DONTDUMP);
>  	vma->vm_ops = &perf_mmap_vmops;
> 
> +	if (!ret)
> +		ret = map_range(rb, vma);
> +
>  	if (event->pmu->event_mapped)
>  		event->pmu->event_mapped(event, vma->vm_mm);
> 
> diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
> index 4f46f688d0d4..180509132d4b 100644
> --- a/kernel/events/ring_buffer.c
> +++ b/kernel/events/ring_buffer.c
> @@ -643,7 +643,6 @@ static void rb_free_aux_page(struct perf_buffer *rb, int idx)
>  	struct page *page = virt_to_page(rb->aux_pages[idx]);
> 
>  	ClearPagePrivate(page);
> -	page->mapping = NULL;
>  	__free_page(page);
>  }
> 
> @@ -819,7 +818,6 @@ static void perf_mmap_free_page(void *addr)
>  {
>  	struct page *page = virt_to_page(addr);
> 
> -	page->mapping = NULL;
>  	__free_page(page);
>  }
> 
> @@ -890,28 +888,13 @@ __perf_mmap_to_page(struct perf_buffer *rb, unsigned long pgoff)
>  	return vmalloc_to_page((void *)rb->user_page + pgoff * PAGE_SIZE);
>  }
> 
> -static void perf_mmap_unmark_page(void *addr)
> -{
> -	struct page *page = vmalloc_to_page(addr);
> -
> -	page->mapping = NULL;
> -}
> -
>  static void rb_free_work(struct work_struct *work)
>  {
>  	struct perf_buffer *rb;
> -	void *base;
> -	int i, nr;
> 
>  	rb = container_of(work, struct perf_buffer, work);
> -	nr = data_page_nr(rb);
> -
> -	base = rb->user_page;
> -	/* The '<=' counts in the user page. */
> -	for (i = 0; i <= nr; i++)
> -		perf_mmap_unmark_page(base + (i * PAGE_SIZE));
> 
> -	vfree(base);
> +	vfree(rb->user_page);
>  	kfree(rb);
>  }
> 
> --
> 2.47.1

Hi Lorenzo Stoakes,

Greetings!

I used Syzkaller and found that there is general protection fault in perf_mmap_to_page in linux-next next-20241203.

After bisection and the first bad commit is:
"
eca51ce01d49 perf: Map pages in advance
"

All detailed into can be found at:
https://github.com/laifryiee/syzkaller_logs/tree/main/241204_084442_perf_mmap_to_page
Syzkaller repro code:
https://github.com/laifryiee/syzkaller_logs/tree/main/241204_084442_perf_mmap_to_page/repro.c
Syzkaller repro syscall steps:
https://github.com/laifryiee/syzkaller_logs/tree/main/241204_084442_perf_mmap_to_page/repro.prog
Syzkaller report:
https://github.com/laifryiee/syzkaller_logs/tree/main/241204_084442_perf_mmap_to_page/repro.report
Kconfig(make olddefconfig):
https://github.com/laifryiee/syzkaller_logs/tree/main/241204_084442_perf_mmap_to_page/kconfig_origin
Bisect info:
https://github.com/laifryiee/syzkaller_logs/tree/main/241204_084442_perf_mmap_to_page/bisect_info.log
bzImage:
https://github.com/laifryiee/syzkaller_logs/raw/refs/heads/main/241204_084442_perf_mmap_to_page/bzImage_c245a7a79602ccbee780c004c1e4abcda66aec32
Issue dmesg:
https://github.com/laifryiee/syzkaller_logs/blob/main/241204_084442_perf_mmap_to_page/c245a7a79602ccbee780c004c1e4abcda66aec32_dmesg.log

"
[   22.133358] KASAN: null-ptr-deref in range [0x0000000000000178-0x000000000000017f]
[   22.133907] CPU: 0 UID: 0 PID: 727 Comm: repro Not tainted 6.13.0-rc1-next-20241203-c245a7a79602 #1
[   22.134557] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
[   22.135371] RIP: 0010:perf_mmap_to_page+0x39/0x500
[   22.135763] Code: 41 56 41 55 41 54 49 89 f4 53 48 89 fb e8 3f 5f c2 ff 48 8d bb 78 01 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <0f> b6 04 02 84 c0 74 08 3c 03 0f 8e e9 03 00 00 4c 63 ab 78 01 00
[   22.137075] RSP: 0018:ffff888020f0f798 EFLAGS: 00010202
[   22.137465] RAX: dffffc0000000000 RBX: 0000000000000000 RCX: dffffc0000000000
[   22.137980] RDX: 000000000000002f RSI: ffffffff81a5ccf1 RDI: 0000000000000178
[   22.138495] RBP: ffff888020f0f7c0 R08: 0000000000000001 R09: ffffed10025fbdb0
[   22.139012] R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000000000
[   22.139530] R13: 0000000000000000 R14: 0000000020002000 R15: ffff888011cce3c0
[   22.140047] FS:  00007f7f57f30600(0000) GS:ffff88806c400000(0000) knlGS:0000000000000000
[   22.140630] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   22.141052] CR2: 00000000200000c0 CR3: 0000000014e10004 CR4: 0000000000770ef0
[   22.141570] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   22.142088] DR3: 0000000000000000 DR6: 00000000ffff07f0 DR7: 0000000000000400
[   22.142606] PKRU: 55555554
[   22.142815] Call Trace:
[   22.143005]  <TASK>
[   22.143173]  ? show_regs+0x6d/0x80
[   22.143455]  ? die_addr+0x45/0xb0
[   22.143720]  ? exc_general_protection+0x1ae/0x340
[   22.144102]  ? asm_exc_general_protection+0x2b/0x30
[   22.144486]  ? perf_mmap_to_page+0x21/0x500
[   22.144810]  ? perf_mmap_to_page+0x39/0x500
[   22.145130]  ? perf_mmap_to_page+0x21/0x500
[   22.145448]  perf_mmap+0xbd9/0x1ce0
[   22.145729]  __mmap_region+0x10e7/0x25a0
[   22.146038]  ? __pfx___mmap_region+0x10/0x10
[   22.146376]  ? mark_lock.part.0+0xf3/0x17b0
[   22.146712]  ? __pfx_mark_lock.part.0+0x10/0x10
[   22.147071]  ? __kasan_check_read+0x15/0x20
[   22.147403]  ? mark_lock.part.0+0xf3/0x17b0
[   22.147744]  ? __sanitizer_cov_trace_const_cmp1+0x1e/0x30
[   22.148162]  ? trace_cap_capable+0x78/0x1e0
[   22.148500]  ? cap_capable+0xa4/0x250
[   22.148792]  mmap_region+0x248/0x2f0
[   22.149086]  do_mmap+0xb29/0x12a0
[   22.149355]  ? __pfx_do_mmap+0x10/0x10
[   22.149651]  ? __pfx_down_write_killable+0x10/0x10
[   22.150027]  ? __this_cpu_preempt_check+0x21/0x30
[   22.150393]  vm_mmap_pgoff+0x235/0x3e0
[   22.150699]  ? __pfx_vm_mmap_pgoff+0x10/0x10
[   22.151037]  ? __fget_files+0x1fb/0x3a0
[   22.151352]  ksys_mmap_pgoff+0x3dc/0x520
[   22.151664]  __x64_sys_mmap+0x139/0x1d0
[   22.151975]  x64_sys_call+0x2001/0x2140
[   22.152283]  do_syscall_64+0x6d/0x140
[   22.152572]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   22.152960] RIP: 0033:0x7f7f57c3ee5d
[   22.153251] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 93 af 1b 00 f7 d8 64 89 01 48
[   22.154593] RSP: 002b:00007ffd805489f8 EFLAGS: 00000212 ORIG_RAX: 0000000000000009
[   22.155156] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f7f57c3ee5d
[   22.155683] RDX: 0000000000000000 RSI: 0000000000001000 RDI: 0000000020002000
[   22.156210] RBP: 00007ffd80548a20 R08: 0000000000000003 R09: 0000000000000000
[   22.156739] R10: 0000000000006053 R11: 0000000000000212 R12: 00007ffd80548b38
[   22.157263] R13: 0000000000401126 R14: 0000000000403e08 R15: 00007f7f57f77000
[   22.157799]  </TASK>
[   22.157975] Modules linked in:
[   22.158322] ---[ end trace 0000000000000000 ]---
[   22.158694] RIP: 0010:perf_mmap_to_page+0x39/0x500
[   22.159061] Code: 41 56 41 55 41 54 49 89 f4 53 48 89 fb e8 3f 5f c2 ff 48 8d bb 78 01 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <0f> b6 04 02 84 c0 74 08 3c 03 0f 8e e9 03 00 00 4c 63 ab 78 01 00
[   22.160388] RSP: 0018:ffff888020f0f798 EFLAGS: 00010202
[   22.160782] RAX: dffffc0000000000 RBX: 0000000000000000 RCX: dffffc0000000000
[   22.161304] RDX: 000000000000002f RSI: ffffffff81a5ccf1 RDI: 0000000000000178
[   22.161824] RBP: ffff888020f0f7c0 R08: 0000000000000001 R09: ffffed10025fbdb0
[   22.162344] R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000000000
[   22.162877] R13: 0000000000000000 R14: 0000000020002000 R15: ffff888011cce3c0
[   22.163403] FS:  00007f7f57f30600(0000) GS:ffff88806c400000(0000) knlGS:0000000000000000
[   22.163988] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   22.164417] CR2: 00000000200000c0 CR3: 0000000014e10004 CR4: 0000000000770ef0
[   22.165409] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   22.165956] DR3: 0000000000000000 DR6: 00000000ffff07f0 DR7: 0000000000000400
[   22.166918] PKRU: 55555554
"

I hope you find it useful.

Regards,
Yi Lai

---

If you don't need the following environment to reproduce the problem or if you
already have one reproduced environment, please ignore the following information.

How to reproduce:
git clone https://gitlab.com/xupengfe/repro_vm_env.git
cd repro_vm_env
tar -xvf repro_vm_env.tar.gz
cd repro_vm_env; ./start3.sh  // it needs qemu-system-x86_64 and I used v7.1.0
  // start3.sh will load bzImage_2241ab53cbb5cdb08a6b2d4688feb13971058f65 v6.2-rc5 kernel
  // You could change the bzImage_xxx as you want
  // Maybe you need to remove line "-drive if=pflash,format=raw,readonly=on,file=./OVMF_CODE.fd \" for different qemu version
You could use below command to log in, there is no password for root.
ssh -p 10023 root@localhost

After login vm(virtual machine) successfully, you could transfer reproduced
binary to the vm by below way, and reproduce the problem in vm:
gcc -pthread -o repro repro.c
scp -P 10023 repro root@localhost:/root/

Get the bzImage for target kernel:
Please use target kconfig and copy it to kernel_src/.config
make olddefconfig
make -jx bzImage           //x should equal or less than cpu num your pc has

Fill the bzImage file into above start3.sh to load the target kernel in vm.


Tips:
If you already have qemu-system-x86_64, please ignore below info.
If you want to install qemu v7.1.0 version:
git clone https://github.com/qemu/qemu.git
cd qemu
git checkout -f v7.1.0
mkdir build
cd build
yum install -y ninja-build.x86_64
yum -y install libslirp-devel.x86_64
../configure --target-list=x86_64-softmmu --enable-kvm --enable-vnc --enable-gtk --enable-sdl --enable-usb-redir --enable-slirp
make
make install

