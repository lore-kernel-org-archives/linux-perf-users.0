Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2592218A93F;
	Fri, 25 Oct 2024 10:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729850716; cv=none; b=eflID4UzrmyJFap/zI218pok7pzFMhE2lcgiGRLud/kmMNcTOo2Nn1m5T71QT5Z6DRACGEWR/XhZarceXgtn7vTf6nw1ak+MifSovUGyY9dYGAvyfyrcnI8isYlDs55h7sMUEACxKNfd9ZJH0WA9ZyqV2co+rrPv508OOAjuBxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729850716; c=relaxed/simple;
	bh=5Rmgse8OJ9Svz+cStz1SqIUagwANKfQx5Aew6921C2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DOflMscL00MC4JzW8FivfO4KDEg3I5ow65Slax+CvBtKS9cpMhAwDLvpAx3VXWXqXR/qGoOKVjLd3+6uJCiMVz3nIt4ZNPMLmVd0pbr4HKmcGtkS2/AdHU5SCPc6fmzyG/FkSE6SB16FVcGnkAW/r3irR88SHwYxttTyrRzIx+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=saWduF+r; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="saWduF+r"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=F5eurqf5UlrsNfBs8L/ryTJL5XF2hPl7LkVdrOAI/+U=; b=saWduF+rw4whm/ncm4eoOE7X36
	LwL51Pl25i1Af0VWtOFpsE+UqNFFysEUkFO0fyrA7L8iSBrZNsVlopBQir/a65KW/pOHW3Wr4vWHd
	43UIwjy7EvKtPfmSaSA7r2t29fc+qgutMCAHVKbzLfFMAkmfiYCarZuNlwpY71am4WC5LOx+1ypDf
	DSF2Mw+SUVjACQNeG4kora21fhn1A3CWsDaKuqMR61/BAV2VB/DTwfyNSkoNmuY13/rCn1f+S94lA
	uZKB9o8cWK4lFrtxRrQcx21YzSzLbMgx9VsPly+60eVmP+IMDobZhv5Cn/cB3Lbe/LomzRgggqTIT
	dU++cFuA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t4HBw-000000055hT-1wb0;
	Fri, 25 Oct 2024 10:05:13 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 7966430083E; Fri, 25 Oct 2024 12:05:12 +0200 (CEST)
Date: Fri, 25 Oct 2024 12:05:12 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [peterz-queue:perf/pmu-unregister] [perf] 24b8359383:
 WARNING:possible_circular_locking_dependency_detected
Message-ID: <20241025100512.GJ14555@noisy.programming.kicks-ass.net>
References: <202410251647.21bf487b-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202410251647.21bf487b-lkp@intel.com>

On Fri, Oct 25, 2024 at 04:37:22PM +0800, kernel test robot wrote:

> [   90.688729][  T589] WARNING: possible circular locking dependency detected
> [   90.689307][  T589] 6.12.0-rc2-00016-g24b8359383ae #1 Tainted: G                T
> [   90.689852][  T589] ------------------------------------------------------
> [   90.690348][  T589] trinity-c2/589 is trying to acquire lock:
> [ 90.690768][ T589] ee61f668 (&ctx->mutex){+.+.}-{3:3}, at: perf_event_ctx_lock_nested (kernel/events/core.c:1318) 
> [   90.691425][  T589]
> [   90.691425][  T589] but task is already holding lock:
> [ 90.691944][ T589] ed2041d4 (&mm->mmap_lock){++++}-{3:3}, at: vm_mmap_pgoff (arch/x86/include/asm/jump_label.h:41 include/linux/jump_label.h:207 include/linux/mmap_lock.h:35 include/linux/mmap_lock.h:123 mm/util.c:586) 
> [   90.692525][  T589]
> [   90.692525][  T589] which lock already depends on the new lock.
> [   90.692525][  T589]
> [   90.693271][  T589]
> [   90.693271][  T589] the existing dependency chain (in reverse order) is:
> [   90.693907][  T589]
> [   90.693907][  T589] -> #1 (&mm->mmap_lock){++++}-{3:3}:
> [   90.697787][  T589] -> #0 (&ctx->mutex){+.+.}-{3:3}:

> [   90.707850][  T589] 1 lock held by trinity-c2/589:
> [ 90.708198][ T589] #0: ed2041d4 (&mm->mmap_lock){++++}-{3:3}, at: vm_mmap_pgoff (arch/x86/include/asm/jump_label.h:41 include/linux/jump_label.h:207 include/linux/mmap_lock.h:35 include/linux/mmap_lock.h:123 mm/util.c:586) 
> [   90.708811][  T589]

Damn, I'm an idiot. But also, how did I not manage to trigger this
myself...

Oh well, something to do over the weekend I suppose :/
