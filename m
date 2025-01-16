Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49E919F120;
	Thu, 16 Jan 2025 20:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737061033; cv=none; b=el35Saskk/RJ+1ubrFhGYcvL9ZR6WIdAPtVe2G42CsAvVG64R+ibX/ipuW0mE+aWr9DM0jC+A4UN8x3Ze0wM9cfKSBqJP+Ozm61zKx9HcQlePkRWjL52Z7fEAepUWALucO5vb98WuW9+TzdxnzwqG1GIxRiyMTYwVPPSjtUt9G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737061033; c=relaxed/simple;
	bh=fHnBVAEoNJ9UuFUas6V7DmBffcW95cWeUlngJsXmqXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k2uscessobsOdwkgKIO4OLgL7j8VPAwSnK0lvtFvBDY7ilqL1Uk9YUtt9bgVe04PHZ1+733EkztMfFmKymbx37UpKtXgMmQ4xXSdAccggJUKPhTbdT2yMQY+8l5sJQl2ZcPJf4SW0Mq7nXV5r9vfEbT2zGBRUlszAMxqNVN/k2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rzAZo3e0; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rzAZo3e0"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=4ntE78axkP7z3tohiHkhYGPX5EMj3/3mCjm72M3PNjg=; b=rzAZo3e0RCJvSb7puygbsXkb3e
	2eVETpC+1BaRkKrH6/CHVLZm2z4fsh+qcrSTwJK7tY0pxp0qRuOfpFwhTSPeKp3UrTP55KT+3fYZw
	oO8Svcn3zYYx3YMNFh07gleBFtsPEesiH3QEU1cAE+rO6EPEo5C/GuDpfP+123qVO8Tu1SybyI/N/
	LO/P1Hru4vH3Udfl7usDBbFChCE08eTEFYHZyD483VErGGiwaPuPu6iCxNjwAmaClygA0KSrKwvKD
	bWOF1C+LQAywJi1qYnoNxkPD4JT0kz5ZW5IcguQjoLh2y3UKa5WE6fJ0kg2MF2t3t/68aYtR9cwAr
	Y4JaiQTQ==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tYWvE-00000002P4J-1YzX;
	Thu, 16 Jan 2025 20:57:01 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id ECC90300777; Thu, 16 Jan 2025 21:56:59 +0100 (CET)
Date: Thu, 16 Jan 2025 21:56:59 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	ak@linux.intel.com, eranian@google.com, dapeng1.mi@linux.intel.com
Subject: Re: [PATCH V9 3/3] perf/x86/intel: Support PEBS counters snapshotting
Message-ID: <20250116205659.GA15641@noisy.programming.kicks-ass.net>
References: <20250115184318.2854459-1-kan.liang@linux.intel.com>
 <20250115184318.2854459-3-kan.liang@linux.intel.com>
 <20250116114751.GJ8362@noisy.programming.kicks-ass.net>
 <be90e73b-eedf-4ff0-a832-b579e003cac9@linux.intel.com>
 <20250116204225.GA7232@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250116204225.GA7232@noisy.programming.kicks-ass.net>

On Thu, Jan 16, 2025 at 09:42:25PM +0100, Peter Zijlstra wrote:
> On Thu, Jan 16, 2025 at 10:55:46AM -0500, Liang, Kan wrote:
> 
> > > Also, I think I found you another bug... Consider what happens to the
> > > counter value when we reschedule a HES_STOPPED counter, then we skip
> > > x86_pmu_start(RELOAD) on step2, which leave the counter value with
> > > 'random' crap from whatever was there last.
> > > 
> > > But meanwhile you do program PEBS to sample it. That will happily sample
> > > this garbage.
> > > 
> > > Hmm?
> > 
> > I'm not quite sure I understand the issue.
> > 
> > The HES_STOPPED counter should be a pre-existing counter. Just for some
> > reason, it's stopped, right? So perf doesn't need to re-configure the
> > PEBS__DATA_CFG, since the idx is not changed.
> 
> Suppose you have your group {A, B, C} and lets suppose A is the PEBS
> event, further suppose that B is also a sampling event. Lets say they
> get hardware counters 1,2 and 3 respectively.
> 
> Then lets say B gets throttled.
> 
> While it is throttled, we get a new event D scheduled, and D gets placed
> on counter 2 -- where B lives, which gets moved over to counter 4.
> 
> Then our loops will update and remove B from 2, but because
> throttled/HES_STOPPED it will not start it on counter 4.
> 
> Meanwhile, we do have the PEBS_DATA_CFG thing updated to sample counter
> 1,3 and 4.
> 
> PEBS assist happens, and samples the uninitialized counter 4.

Also, by skipping x86_pmu_start() we miss the assignment of
cpuc->events[] so PEBS buffer decode can't even find the dodgy event.

