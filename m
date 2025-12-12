Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA1E311C05;
	Fri, 12 Dec 2025 10:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765536258; cv=none; b=UPbaYgcEI0Fi9Qi6RaO8AqHLJDJozOocpSzWWD3gjBVuQGvbPvb2uJRLYd02fiPLDQly5Zm8FGWXVkcijgoSM5daesmf03AMrbeiZi5wAoqIbSOTV/yZzWC6HZJrEq2Pp968GBnBcmE7YM4nz/jEZ/PWNaQAF43qycKUHPPvsw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765536258; c=relaxed/simple;
	bh=Pu2H/2Z/qRcAZPg193QleUYUAMYV6ExjTfqj2adCIcA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RS89Ht4ToOWHIvtTZDinflgWdg9NHdaHIgTxRVh3tR+e4Ew37i6nQLNSR/CAjEPEsfN4+KpxJ/KWC2uOzt5GKvwArmgANkYxeUA9UdEl3YAJIxHY5dR+sv7RG1rMyaI85yAUbxtahQMkGgGGrkZpsm18auqfiaEMoOPTW5fbV0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=EbodsRjT; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EbodsRjT"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=8EZawLBa4wOYs64AOS7wdIAgiN6v2diZMH8l27Q+dKU=; b=EbodsRjTHDlLRdmlK0P48Pyn+j
	PcC7o58KA4TxCdWAdUlwhjTmVvKiswTqaqcx7TB8FLphJ0HvHrxlS7DnYXXpPE/HGTf8fCCRti1ZJ
	WBrc+wTb7MFvT3ikjof+adOJmLm3LPg/QKtRmqBJtDrgaI0GBODajfXqKfC8+QpfKk0OJ0AnnuwR8
	YKG68kBkUfR9mIku9OWP4pmKvh7J1yaArXN/vTht/IbxlVkKpobSeof7+uc+wTd1JllgvvfTpB9jJ
	6JPcYQcCMv0Op+kokAVlptJJHQsT2G+MujVmpbiqQT/oVjWdAU83UlJOav6zbRaaIcf+PEeVtaPVh
	pMV3TRjQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vU0d3-0000000FZ0H-3yrr;
	Fri, 12 Dec 2025 10:44:06 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 8F78730057C; Fri, 12 Dec 2025 11:44:04 +0100 (CET)
Date: Fri, 12 Dec 2025 11:44:04 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: evan.li@linux.alibaba.com
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
	tglx@linutronix.de, bp@alien8.de, dave.hansen@linux.intel.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	kitta <kitta@linux.alibaba.com>
Subject: Re: [PATCH] perf/x86: Prevent NULL event deref in handle_pmi_common()
Message-ID: <20251212104404.GO3911114@noisy.programming.kicks-ass.net>
References: <20251212084943.2124787-1-evan.li@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251212084943.2124787-1-evan.li@linux.alibaba.com>

On Fri, Dec 12, 2025 at 04:49:43PM +0800, evan.li@linux.alibaba.com wrote:
> From: Evan Li <evan.li@linux.alibaba.com>
> 
> handle_pmi_common() may observe an active bit set in cpuc->active_mask
> while the corresponding cpuc->events[] entry has already been cleared,
> which leads to a NULL pointer dereference.
> 
> This can happen when interrupt throttling stops all events in a group
> while PEBS processing is still in progress. perf_event_overflow() can
> trigger perf_event_throttle_group(), which stops the group and clears
> the cpuc->events[] entry, but the active bit may still be set when
> handle_pmi_common() iterates over the events.
> 
> The following change:
> 
> 7e772a93 ("perf/x86: Fix NULL event access and potential PEBS record loss")
> 
> moved cpuc->events[] clearing from x86_pmu_stop() to x86_pmu_del() and
> relied on cpuc->active_mask/pebs_enabled checks. However,
> handle_pmi_common() can still encounter a NULL cpuc->events[] entry
> despite the active bit being set.

How? What is doing del() concurrently with the pmi?
