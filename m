Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4471AA1D5;
	Wed,  4 Jun 2025 16:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749052806; cv=none; b=dZLw48DJ5ObA5hV96bWFSsynPdtTKvBeMd/sDvAVRq4lXHBi4XSKI+bRWtZYMC9DX8JboMk7YhFA24IR7QEfOZW0pV2dLEUuLd6LNklYMGZMXJfVyHN6lje0IR2HcrMhmKKPaclshzGXAsOCsoIfAcwxiAzqEc3LKEh5iZJopKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749052806; c=relaxed/simple;
	bh=UzvBQLQCA432LkL2VATkkRNLH1FaLFVPSbFrU4w1PHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HPDF0oYx+5d4Vp7NFQDkT8oH1ZO9riCYWUa6Vm5PmegjeohzWpVrYbFb/HibiZzA0I0YZ71Hi4aYWB4JujckseS5b4iRSnyLO3SLt5uyvJIWwhyztLT3aHgum1VA3Zte97R/yhE0SqcyE/edqYCBYR2RTW90iq81rt8RRHPNLm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=aW1OegFc; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aW1OegFc"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=SWCQk9cOoPmhCdT7cITTNHLcak2SqK86sZK5++8eMD8=; b=aW1OegFcb6ZnekRMsNtjRq9hEd
	YOwjC8yuF6NhmFJfV9ZcSep5jL+C1NyXp5QRXuH7RSOqCXnaoRXMGeZPNzkJBZi9gv5a1MNDFZXUa
	25YyMV+IGwq72wr4CkFMUzJSXgh+ciwa4Y1j/XT/adYKnFmqrlHPU3MmjgIexiUEF9c63yx31mYxu
	fbF0C6OG0uSIKPzDk8V+JIx5cPEbd7P2ciab/tVESEQsSAiuCJjRntlJaO5TSzcjoTRGhR8mmVYhA
	+TSpd3ey+Rn2b8Gbm6MrdqYlLGV2kCt6PkAx+t/A/uJaSbXMchhzWuHz3PJlk9AnQjXKDo65W4JkQ
	cpJccaZQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uMqWs-00000000uix-0INF;
	Wed, 04 Jun 2025 15:59:51 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 21BAC300787; Wed,  4 Jun 2025 17:59:49 +0200 (CEST)
Date: Wed, 4 Jun 2025 17:59:49 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Leo Yan <leo.yan@arm.com>
Cc: Yeoreum Yun <yeoreum.yun@arm.com>, mingo@redhat.com, mingo@kernel.org,
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, David Wang <00107082@163.com>
Subject: Re: [PATCH 1/1] perf/core: fix dangling cgroup pointer in cpuctx
Message-ID: <20250604155949.GK39944@noisy.programming.kicks-ass.net>
References: <20250602184049.4010919-1-yeoreum.yun@arm.com>
 <20250603140040.GB8020@e132581.arm.com>
 <20250603144414.GC38114@noisy.programming.kicks-ass.net>
 <20250604080339.GB35970@noisy.programming.kicks-ass.net>
 <20250604101821.GC8020@e132581.arm.com>
 <20250604141640.GL38114@noisy.programming.kicks-ass.net>
 <20250604154639.GE8020@e132581.arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250604154639.GE8020@e132581.arm.com>

On Wed, Jun 04, 2025 at 04:46:39PM +0100, Leo Yan wrote:
> On Wed, Jun 04, 2025 at 04:16:40PM +0200, Peter Zijlstra wrote:
> 
> [...]
> 
> > It might be prudent to do something like so:
> 
> Thanks for the patch.
> 
> > +static void __event_disable(struct perf_event *event,
> > +			    struct perf_event_context *ctx,
> > +			    enum perf_event_state state)
> > +{
> > +	if (event == event->group_leader)
> > +		group_sched_out(event, ctx);
> 
> I am a bit struggle for this code line. It disables all events in a
> group, but only clear cgroup pointer for group leader but miss to clear
> for sibling events.
> 
> If the cgroup pointer is only used for group leader, maybe we only
> maintain (set and clear) the cgroup pointer for the leader?

Hmm, so yeah, that is weird indeed.

So perf_cgroup_event_enable() is called in list_add_event(), which is
perf_install_in_context() and that should be every single event.

So yeah, I'm thinking we're having more bugs here still :-(

