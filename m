Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50EA29117F;
	Tue, 15 Apr 2025 13:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744722895; cv=none; b=ILb6ZQhVwK9TdamOgZdyJx1LRrinJMRn5ZkSHypAeGNzICpv4f3XnookRnG0tupajome/C3qOXod7VeZSRrVDkWkyyxvNWM93CepDNk/WlphWieqGr8U3wWfA2YnOXBosrkcMCgNUZDbJ5TFtKB6SNN2OjmADUiRVw/CzcbxSAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744722895; c=relaxed/simple;
	bh=EkXGyCOE3xPaZmPI/Zws1XQgorOCwXDnbNA4uFRzZdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pzAJ0ncY7aWl2qxnatafArt9VrTThNdjc7yigRvq7NYKwSQ9RaUbnCWXo//usSmVRKScMPaxcMp6gzxZxqcdakx/8t0S2DvtZ3Nd1pAV3jbCftxpObV03/IF81B6V+xff3hU3VElVNKtnJn/ckh27POG5E4nM8fLbK2fKpRLpXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NWR/sIhK; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NWR/sIhK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=lYmK/WS3ekIfja6Gz/BbjmC+YRaWmyyvrp83kJkGeFI=; b=NWR/sIhKT1gDu8aHjS48fF2aZt
	lw41iRUOiWacG726FRxRGbX78++vRtWrxR7cn3bQRhaSaWBWbw6nQZsqUZ36kCSK9l9cDKhO55mLF
	wCaVSco6UaQkCbRyEqHOAVqcM4F+R0iRX650jS5zeYJntrD2Z43NozMpB8qMOQk8rtSYavtdB5HS1
	tCOqhNcvQtUZ+ldIx1aXi2h9xtBvZs5grEgWKuUOKyxxV7obZbk8VJB6MRScETDaUgG/kzsbzEtK6
	SZPbRkeaymti+oenbNGNNoug6N2GJmN3pEOwbO2H5HZ7LLT2lX1xeXgTCQA3bp8JgPk0yvIXOw4/E
	GBcuAHjA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u4g7j-00000009tFM-1Yn2;
	Tue, 15 Apr 2025 13:14:47 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 7A4E630037D; Tue, 15 Apr 2025 15:14:46 +0200 (CEST)
Date: Tue, 15 Apr 2025 15:14:46 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: James Clark <james.clark@linaro.org>
Cc: Oliver Sang <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
	lkp@intel.com, linux-kernel@vger.kernel.org, x86@kernel.org,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	linux-perf-users@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>,
	Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [tip:perf/core] [perf] da916e96e2:
 BUG:KASAN:null-ptr-deref_in_put_event
Message-ID: <20250415131446.GN5600@noisy.programming.kicks-ass.net>
References: <202504131701.941039cd-lkp@intel.com>
 <20250414190138.GB13096@noisy.programming.kicks-ass.net>
 <Z/3krxHJLaWJTj4R@xsang-OptiPlex-9020>
 <5bc5f54b-ce6a-4834-86d4-5014d44c7217@linaro.org>
 <20250415100840.GM5600@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250415100840.GM5600@noisy.programming.kicks-ass.net>

On Tue, Apr 15, 2025 at 12:08:40PM +0200, Peter Zijlstra wrote:
> On Tue, Apr 15, 2025 at 10:14:05AM +0100, James Clark wrote:
> > On 15/04/2025 5:46 am, Oliver Sang wrote:
> 
> > > yes, below patch fixes the issues we observed for da916e96e2. thanks
> > > 
> > > Tested-by: kernel test robot <oliver.sang@intel.com>
> > > 
> > 
> > Also fixes the same issues we were seeing:
> > 
> > Tested-by: James Clark <james.clark@linaro.org>
> 
> Excellent, thank you both! Now I gotta go write me a Changelog :-)

Hmm, so while writing Changelog, I noticed something else was off. The
case where event->parent was set to EVENT_TOMBSTONE now didn't have a
put_event(parent) anymore. So that needs to be put back in as well.

Frederic, afaict this should still be okay, since if we're detached,
then nothing will try and access event->parent in the free path.

Also, nothing in perf_pending_task() will try and access either
event->parent or event->pmu.

---
Subject: perf: Fix event->parent life-time issue
From: Peter Zijlstra <peterz@infradead.org>
Date: Tue Apr 15 12:12:52 CEST 2025

Due to an oversight in merging da916e96e2de ("perf: Make
perf_pmu_unregister() useable") on top of 56799bc03565 ("perf: Fix
hang while freeing sigtrap event"), it is now possible to hit
put_event(EVENT_TOMBSTONE), which makes the computer sad.

This also means that for the event->parent == EVENT_TOMBSTONE, the
put_event() matching inherit_event() has gone missing.

Previously this was done in perf_event_release_kernel() after calling
perf_remove_from_context(), but with it delegated to put_event(), this
case is now entirely missed, leading to leaks.

Fixes: da916e96e2de ("perf: Make perf_pmu_unregister() useable")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/events/core.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2343,6 +2343,7 @@ static void perf_child_detach(struct per
 	 * not being a child event. See for example unaccount_event().
 	 */
 	event->parent = EVENT_TOMBSTONE;
+	put_event(parent_event);
 }
 
 static bool is_orphaned_event(struct perf_event *event)
@@ -5688,7 +5689,7 @@ static void put_event(struct perf_event
 	_free_event(event);
 
 	/* Matches the refcount bump in inherit_event() */
-	if (parent)
+	if (parent && parent != EVENT_TOMBSTONE)
 		put_event(parent);
 }
 
