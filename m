Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD1322FDFD;
	Thu, 16 Jan 2025 20:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737060163; cv=none; b=QOhVa5l7PJDtAnXGMFCiMtNv+44t3LjuvZUtjIGU1LNmihGb6zeHkIEZv0gOUYHI0Wd82jpKBs0fYWHeFWKEKJPJBw/rYXiZFn/PqW0sfutoNpvpwQX1PNW4sL+GkYa/MxnrwE8D3E4dpqg+fxHNLJkJRd1c2SrXQWgdMCDKVfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737060163; c=relaxed/simple;
	bh=cFdnOVHtsYGxkzO7J0/gnu/RgaxjiCyaCiPYS5XRyfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FJfCGCtAD2q+V36a92yeBwoGJFj56qyskayLAphwxtekl7BqmLQCbxkj3dPKIClopRooFycCMdXIH/J+1xO2lwGzjUn88lxfnQYruswVcK0iaM6htTRoPRg6+5sp1v01I8YLe5NVIddppA0JFh/tFmacLDLRO1ShRcfiuzaMIzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QJJPoQDQ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QJJPoQDQ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=6sms89aH1QB0lnq/awT+T3lnSDz3KSGljHm/qNlTrdQ=; b=QJJPoQDQ2t2GrUG4nMTDBP17PR
	hRyprPq/GDCXws5c5QGWRSgDfjWRmoSfHGajlzHMdGS7gXhRvGajfV/tkDCzwN3mScgm4KM+WsaAV
	U2dmO6D3VwI13i/dKvhS9/P9W+ApJBolDPHaXD73RNwMaFbJb4aeBwfEISumZrgFhWhX8ozl+ug6S
	R+e7zLXHijomBOK9GtgQhBb2AVhbS3rqryLkH6qBGALxt8t4KOLeFh9qago4BpWh3AeCRqttICz/V
	RFx6EAKtTeOtGypuTmGBtuABqU/ihdcgDrvcR8uTSeLYotY4k/eLAzEWovGYofCk18ssECbJXTq55
	NbMk7+XA==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tYWh8-00000002DRr-37gT;
	Thu, 16 Jan 2025 20:42:26 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id AA186300777; Thu, 16 Jan 2025 21:42:25 +0100 (CET)
Date: Thu, 16 Jan 2025 21:42:25 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	ak@linux.intel.com, eranian@google.com, dapeng1.mi@linux.intel.com
Subject: Re: [PATCH V9 3/3] perf/x86/intel: Support PEBS counters snapshotting
Message-ID: <20250116204225.GA7232@noisy.programming.kicks-ass.net>
References: <20250115184318.2854459-1-kan.liang@linux.intel.com>
 <20250115184318.2854459-3-kan.liang@linux.intel.com>
 <20250116114751.GJ8362@noisy.programming.kicks-ass.net>
 <be90e73b-eedf-4ff0-a832-b579e003cac9@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be90e73b-eedf-4ff0-a832-b579e003cac9@linux.intel.com>

On Thu, Jan 16, 2025 at 10:55:46AM -0500, Liang, Kan wrote:

> > Also, I think I found you another bug... Consider what happens to the
> > counter value when we reschedule a HES_STOPPED counter, then we skip
> > x86_pmu_start(RELOAD) on step2, which leave the counter value with
> > 'random' crap from whatever was there last.
> > 
> > But meanwhile you do program PEBS to sample it. That will happily sample
> > this garbage.
> > 
> > Hmm?
> 
> I'm not quite sure I understand the issue.
> 
> The HES_STOPPED counter should be a pre-existing counter. Just for some
> reason, it's stopped, right? So perf doesn't need to re-configure the
> PEBS__DATA_CFG, since the idx is not changed.

Suppose you have your group {A, B, C} and lets suppose A is the PEBS
event, further suppose that B is also a sampling event. Lets say they
get hardware counters 1,2 and 3 respectively.

Then lets say B gets throttled.

While it is throttled, we get a new event D scheduled, and D gets placed
on counter 2 -- where B lives, which gets moved over to counter 4.

Then our loops will update and remove B from 2, but because
throttled/HES_STOPPED it will not start it on counter 4.

Meanwhile, we do have the PEBS_DATA_CFG thing updated to sample counter
1,3 and 4.

PEBS assist happens, and samples the uninitialized counter 4.

We unthrottle B and program counter 4.
