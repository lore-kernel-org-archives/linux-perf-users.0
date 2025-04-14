Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25AE28BAB7;
	Mon, 14 Apr 2025 19:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744657429; cv=none; b=PGhZ2WbDxxnbESUZMnaX8pRbRd+WBRMmI/BNe9/UngkUHkWGes4Rlcqem0Avm2TUEjyvZKYHTL1RGDN/8CU4pyCVqOjXHP3Iw3AM6P+TzOPvtJHHLW1xVXz6yJk5YydDoZGWcbSubxEnZCbeCDvSDo4xbrqJYd5uZZtytrO77HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744657429; c=relaxed/simple;
	bh=Y/eydiMqkLYo6xxcAikKcaBMqiwERE9XwRwOYoJPhTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TcHXULzWq3FFzbnBJ5ST+DH5KEgZx1FL/vKYrlBY9hsBTjYezhXnVBaqtxxea+T4K6qybZ2xkvuQyQdtClPAUDIJiUntu48pMoH3lh9I10GZXVUUxUvtxwiSBlr2xFikKdfN9HH7G/EVR5JLb0rGlxf6d8fAVLKZNbyeyZUs1HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KMAGrRZi; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KMAGrRZi"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=CfQ/VDuRGvjV05uf8TH8cpoPsYAPWh3vrUlOAz73d0g=; b=KMAGrRZi9t0ZCWveqHabnHqE0j
	seBnnlErt+Wma68pLPL2ySPPcrgx5S5bhuzw8GYQ49tkD82tGyzoIkeU6Ma1U1zp/pq1hagfH1bla
	vS0+9sc361kxcb6j/4/abgCPV66hS411lSYC3o+KQVfVxeMvUHOm/DDkzzgL3venjQiZRhR9fgtTB
	qdfjD4isd2d2zLA3M5Z4jr1BxEnu2IZV3NhRJfhLy3A6GFxqC0W4058UJKHSfOXiYPKoU8+s5c6uj
	rWQO1o691ozw2zBQl3NOhUPgVpQHpCocqnv18+AmdCqrKmDuElI6fB6xGyK98yAYvu79F0bYQdKYX
	pDFB4ZbA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4P3t-0000000ExxR-0mj0;
	Mon, 14 Apr 2025 19:01:44 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id C412B3003AF; Mon, 14 Apr 2025 21:01:38 +0200 (CEST)
Date: Mon, 14 Apr 2025 21:01:38 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
	x86@kernel.org, Ravi Bangoria <ravi.bangoria@amd.com>,
	linux-perf-users@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>
Subject: Re: [tip:perf/core] [perf]  da916e96e2:
 BUG:KASAN:null-ptr-deref_in_put_event
Message-ID: <20250414190138.GB13096@noisy.programming.kicks-ass.net>
References: <202504131701.941039cd-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202504131701.941039cd-lkp@intel.com>

On Mon, Apr 14, 2025 at 09:59:25AM +0800, kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed "BUG:KASAN:null-ptr-deref_in_put_event" on:
> 
> commit: da916e96e2dedcb2d40de77a7def833d315b81a6 ("perf: Make perf_pmu_unregister() useable")
> https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git perf/core
> 
> [test failed on linux-next/master 29e7bf01ed8033c9a14ed0dc990dfe2736dbcd18]
> 
> in testcase: trinity
> version: trinity-x86_64-ba2360ed-1_20241228
> with following parameters:
> 
> 	runtime: 300s
> 	group: group-02
> 	nr_groups: 5
> 
> 
> 
> config: x86_64-randconfig-078-20250407
> compiler: clang-20
> test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> 
> (please refer to attached dmesg/kmsg for entire log/backtrace)
> 
> 
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202504131701.941039cd-lkp@intel.com
> 

Does this help?

---
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 2eb9cd5d86a1..528b679aaf7e 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5687,7 +5687,7 @@ static void put_event(struct perf_event *event)
 	_free_event(event);
 
 	/* Matches the refcount bump in inherit_event() */
-	if (parent)
+	if (parent && parent != EVENT_TOMBSTONE)
 		put_event(parent);
 }
 
