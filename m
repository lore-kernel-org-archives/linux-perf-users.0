Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB021A7255;
	Thu, 19 Dec 2024 21:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734643068; cv=none; b=GZiywSzMvdJq7eEi25/zD2qVXg2nRsgsuc5Qq142OiQ522gsQJ8YjdwAZdX3E3/MhFtJ0rJFxjNmJR0b4bWj6j4XeKfYxoSJPSSd522vj5Pu9uZpmoaPGWp/KvzEE0GfWq55sNCXUkaNGgaOb13FRZy0T7QIbuhQBCNx8BoRWgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734643068; c=relaxed/simple;
	bh=Xguiim+qILjVCBoVe+8bY4ysCx9+X2qr0I572pnLh7c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HOAjecv+1BCimS2R56oFDMA7A+1qYzpvhcqNB9aH/hViEjtG/jG2cmFk0eh2cs0AXCDpeA2eLOY3qBPZQq5DtIgy39wRLXMYIpLyGwbbbyx2p9faWCndmsLBGeUcK2LS3K6ucpfzc5Iet/sEqmIgTjjCiSUozX2YmwELvsl/G7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fYVE9t/A; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fYVE9t/A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734643067; x=1766179067;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Xguiim+qILjVCBoVe+8bY4ysCx9+X2qr0I572pnLh7c=;
  b=fYVE9t/A2vJ9OhHgfpU74fyLCE3bJyFcz50ge3dDU2dpNS8XtTEuNqYO
   Eqyl2Fi0me3mTG2KIwNe3wygWyMTdjQsZzIRObz5iHpi6hkWPgUki1GYW
   2+QukbDNCgXHfeS57IgYOgOE6HCqHqJJ4weUmmSklzkYVRrJzJGyNEqD1
   KwpxfEAXeMPxQkvlnkS7SobGMjlmVqHBYWiQp3KT1HpDMafKJhbmu4JZA
   cuYlYeVk0nnY+ouE5bZYdUeMjWm2D4gYB8aM9EDIgFL5Fu2/o/lnPczgl
   BeeY3zjXgLLm4Ht0pbYCSfWP54x7M0XQh6uJBUgG3gze/hYgNpW3TMu86
   w==;
X-CSE-ConnectionGUID: Mt26tJGHQkec5ygUVrLHnQ==
X-CSE-MsgGUID: 20zOACnzRDyXyVNoOu1B0Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11291"; a="57652142"
X-IronPort-AV: E=Sophos;i="6.12,248,1728975600"; 
   d="scan'208";a="57652142"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2024 13:17:47 -0800
X-CSE-ConnectionGUID: RauDh5uKSuuwqQTb6+sHXQ==
X-CSE-MsgGUID: GgmwH8RYQ9KOiVL+mPM19A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,248,1728975600"; 
   d="scan'208";a="129141533"
Received: from bswapp-mobl.amr.corp.intel.com (HELO [10.124.12.64]) ([10.124.12.64])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2024 13:17:45 -0800
Message-ID: <65a04f0d-668b-47b6-a532-d1e11ef4835a@intel.com>
Date: Thu, 19 Dec 2024 13:17:44 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] perf: map pages in advance
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Matthew Wilcox <willy@infradead.org>, David Hildenbrand <david@redhat.com>,
 Yi Lai <yi1.lai@linux.intel.com>
References: <20241205082948.56212-1-lorenzo.stoakes@oracle.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <20241205082948.56212-1-lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/5/2024 12:29 AM, Lorenzo Stoakes wrote:
> We are adjusting struct page to make it smaller, removing unneeded fields
> which correctly belong to struct folio.
> 
> Two of those fields are page->index and page->mapping. Perf is currently
> making use of both of these. This is unnecessary. This patch eliminates
> this.
> 
> Perf establishes its own internally controlled memory-mapped pages using
> vm_ops hooks. The first page in the mapping is the read/write user control
> page, and the rest of the mapping consists of read-only pages.
> 
> The VMA is backed by kernel memory either from the buddy allocator or
> vmalloc depending on configuration. It is intended to be mapped read/write,
> but because it has a page_mkwrite() hook, vma_wants_writenotify() indicates
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
> maintaining the required R/W and R/O behaviour is a PFN map.
> 
> There should be no change to actual functionality as a result of this
> change.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

With this patch, it seems perf tool has some problems in capturing the
kernel data with Intel PT.

Running the following commands, the size of perf.data is very small, and
perf script can't find any valid records.

perf record -e intel_pt//u -- /bin/ls
perf script --insn-trace


