Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6A0290DAC;
	Wed,  4 Jun 2025 13:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749045497; cv=none; b=GWXMjuBwcrXoU4gr/yCvNU9LwegO+zZ1uJovKX4w+mlKM3RmPYmMk+301bq3Hs5j/8V2q216/DqIx7/o1J0q6RoltwGfGb0zPixWth154oO3PQ2sbifngtvf4QvavxCyTT5YMRnVb7XAk3V+BVpH3JAASDVY3Vpj/DqZ5Kxjcq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749045497; c=relaxed/simple;
	bh=g2WNtm+gErCC9zaaOUPQLB+n6rSn4DJGYIEUDZ2bxLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kri3oUXZqQgAsrVpCC90keuBGY6wvuAAJMnYr4AGez/wshhSiEV6Xoj/80qN0CnaeEmPfZV71etPeNMscjUr1aZzrxfR19Mpt55+1jZxFS8Op3/qWl9nUC7lfFoiJfEpqUu+GTYWNxyKNI4uGqleF5E8porjr7M43OmXD5fF39s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=T7SXF2UB; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="T7SXF2UB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=MofrKRmOHg0W6dvhylNzDHTjMTJLFlneoIq4UXMJ4/s=; b=T7SXF2UBFHfGJ6v3nIdlJfpgtH
	lOyY6rEp7V5XRZk+LxmhCX4zfe6hTFaPZA6OZK9V5heaLcvxDnLkYiwLymVvuaaoEe8zza/fDry3T
	xJyUR9Qxa+V8EYVkU9QtK6H5TBq4nprrjM73SfGmEadMrcrRmyugYmxzttDKbkedOkguEvRJy3v4W
	kbg+1mT0nzTWEAgbyqjYO4Hokmp1Q1bnAsahXSHUzz3Et7EQe2GTuD6FPYgEP62lwHxqs2Sys20Wd
	bVFW7mwLbyb8cARRP65Yg8rAVLJ4ocvZrlGuv1s/OjTY+JWhB1uX7bdX2vZ0blNvfey5Do3U9oAnR
	yEHwDwfg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uMod0-00000000uDF-33ZC;
	Wed, 04 Jun 2025 13:58:02 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id E0625300787; Wed,  4 Jun 2025 15:58:01 +0200 (CEST)
Date: Wed, 4 Jun 2025 15:58:01 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Leo Yan <leo.yan@arm.com>
Cc: Yeoreum Yun <yeoreum.yun@arm.com>, mingo@redhat.com, mingo@kernel.org,
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, David Wang <00107082@163.com>
Subject: Re: [PATCH 1/1] perf/core: fix dangling cgroup pointer in cpuctx
Message-ID: <20250604135801.GK38114@noisy.programming.kicks-ass.net>
References: <20250602184049.4010919-1-yeoreum.yun@arm.com>
 <20250603140040.GB8020@e132581.arm.com>
 <20250603144414.GC38114@noisy.programming.kicks-ass.net>
 <20250604080339.GB35970@noisy.programming.kicks-ass.net>
 <20250604101821.GC8020@e132581.arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250604101821.GC8020@e132581.arm.com>

On Wed, Jun 04, 2025 at 11:18:21AM +0100, Leo Yan wrote:

> Totally agree. The comment would be very useful!

I have the below. Let me go read your email in more than 2 seconds to
see if I should amend things.

I'm not sure doing the INACTIVE->INACTIVE cycle in the ASCII art is
going to make it clearer, might leave that off. But yeah, possible.

---

Subject: perf: Add comment to enum perf_event_state
From: Peter Zijlstra <peterz@infradead.org>
Date: Wed Jun  4 10:21:38 CEST 2025

Better describe the event states.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/perf_event.h |   42 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 40 insertions(+), 2 deletions(-)

--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -635,8 +635,46 @@ struct perf_addr_filter_range {
 	unsigned long			size;
 };
 
-/**
- * enum perf_event_state - the states of an event:
+/*
+ * The normal states are:
+ *
+ *            ACTIVE    --.
+ *               ^        |
+ *               |        |
+ *       sched_{in,out}() |
+ *               |        |
+ *               v        |
+ *      ,---> INACTIVE  --+ <-.
+ *      |                 |   |
+ *      |                {dis,en}able()
+ *   sched_in()           |   |
+ *      |       OFF    <--' --+
+ *      |                     |
+ *      `--->  ERROR    ------'
+ *
+ * That is:
+ *
+ * sched_in:       INACTIVE          -> {ACTIVE,ERROR}
+ * sched_out:      ACTIVE            -> INACTIVE
+ * disable:        {ACTIVE,INACTIVE} -> OFF
+ * enable:         {OFF,ERROR}       -> INACTIVE
+ *
+ * Where {OFF,ERROR} are disabled states.
+ *
+ * Then we have the {EXIT,REVOKED,DEAD} states which are various shades of
+ * defunct events:
+ *
+ *  - EXIT means task that the even was assigned to died, but child events
+ *    still live, and further children can still be created. But the event
+ *    itself will never be active again. It can only transition to
+ *    {REVOKED,DEAD};
+ *
+ *  - REVOKED means the PMU the event was associated with is gone; all
+ *    functionality is stopped but the event is still alive. Can only
+ *    transition to DEAD;
+ *
+ *  - DEAD event really is DYING tearing down state and freeing bits.
+ *
  */
 enum perf_event_state {
 	PERF_EVENT_STATE_DEAD		= -5,
