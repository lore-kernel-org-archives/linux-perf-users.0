Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EFEB19F101;
	Wed,  4 Jun 2025 09:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749028789; cv=none; b=lS+/6bcCoUBPmk621P3dgv6hOoxRI2cQSte0bC8oFau1Q8W1mv+rVahtPj/iWIGGnZMnPznmFnX8k3oPHrlIH4lW6u7Zu9Nrbl4WAfkaM2x/qIJQ0LRPQUXvtYb6GMgB/Jq9GX3E84/6F/XWTt6RsGHpmjKj2G8Z6sPpYsFxmLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749028789; c=relaxed/simple;
	bh=lxLNldesewtz8jaymqrDTOlOB3djGqwwU1UpzOKfUVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OQX2nDpLJUBNe+Xi7PC3L0mF1GFEB7CLZ7Q+SHP4dV7t1Ah/gP5lTVmipNrte4MI29Fy+2Wgu6fPWqcfLazRroQDe3OCiHOz56XMugVBQEB3RLj/RWnM9d+Kcxw4lZ9ZFuw2q4MBOa6vQC/vxsnRUw6rcP8QU+U+hPwnyHzzOb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bmoy5xXE; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bmoy5xXE"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=4qucXv8AaXrbxT1HvJ0ArOKNfkabQLNKPBxoV6EhBP8=; b=bmoy5xXET0BUvyFu7Mjf/i50KL
	tVm74cGRt4i5vASMRo/1LE9ipvRWnhM58QjCuaCKuZO6RFzCcBBKxj4BEuQ2QE09x9KHtjzwaJyZS
	qY8PILURnzscxyf33fV9l6cmhM/mjfzxZeNtJUa9/Vbg0mEvgormJpVbmXN7ac7cCzLAh7/Ctlolw
	7Hnj35mnF214h84iCe3PDPmUJR9WEprpoSnzrOvGrILDvPh452q6CUGj3n74CbYMMwBBZZXPUJ75n
	NCTrmgBwWCaYzQ2f9lYrs+zuk3Pdlqg53wT2imtDMOv2b9B2o22DbRWh7PgX+qtn7mJiBhAqF/i3P
	Z9BpeEGg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uMkHZ-00000002x3O-0JEH;
	Wed, 04 Jun 2025 09:19:37 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 6559A300787; Wed,  4 Jun 2025 11:19:36 +0200 (CEST)
Date: Wed, 4 Jun 2025 11:19:36 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Luo Gengkun <luogengkun@huaweicloud.com>
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, davidcc@google.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] perf/core: Fix nr_cgroups/cpuctx->cgrp is not
 updated correctly
Message-ID: <20250604091936.GG38114@noisy.programming.kicks-ass.net>
References: <20250604033924.3914647-1-luogengkun@huaweicloud.com>
 <20250604033924.3914647-2-luogengkun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250604033924.3914647-2-luogengkun@huaweicloud.com>

On Wed, Jun 04, 2025 at 03:39:23AM +0000, Luo Gengkun wrote:
> Since __perf_remove_from_context updates event->state before
> list_del_event, this prevents list_del_event from calling
> perf_cgroup_event_disable, resulting in will not update nr_cgroups and
> cpuctx->cgrp.
> 
> To fix this problem, move perf_cgroup_event_disable into
> __perf_remove_from_context as:
> 
> commit a3c3c66670ce ("perf/core: Fix child_total_time_enabled accounting bug at task exit")
> 
> did.
> 
> Fixes: a3c3c66670ce ("perf/core: Fix child_total_time_enabled accounting bug at task exit")
> Signed-off-by: Luo Gengkun <luogengkun@huaweicloud.com>

So I already have Yeoreum's patch for this:

  https://lkml.kernel.org/r/20250603144414.GC38114@noisy.programming.kicks-ass.net
