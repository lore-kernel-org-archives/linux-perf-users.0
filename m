Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D3C31064E;
	Fri,  7 Nov 2025 08:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762504234; cv=none; b=sZFcG2DD/wLiDRes+g3rTgKnB8PFSbJEFRrsLnSEKupDQOW8y1Rf1L2S2wIABMIXl79jaYql+MY+RaWBDSbLC0HSeBJS4MAYqGbmjGgx5h57YTbZbujHa4dws0OjJY0R+plLVMhxlVhRm3OoH5Sxfl/1nLQ4LkuzXYW7R/D612I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762504234; c=relaxed/simple;
	bh=/GDJ7o76Y5uJc2qW1MGc7RcJT8vazPW4ZWKo0tuhWZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AahNVavsQTkBxagk4YOHjNP71SfRxOICX38tLaUJ50GOCLksn6rgl93KCe7nocuLn9HKji7Y1xVnfMkcaW3HygWQAEPahxAKO1BvPyXKXIl9BxBTPJE0LpjHPxfU2FTIJ78FsNCvjr/d8rFqbjh9Vr6gLhGUDrfN6HWZOcV5Yws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CX2yZ5Ev; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CX2yZ5Ev"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=QtuHvIiLnEpCIAltXZ3QPNFM+VVLhdWSvHUbj92zxRA=; b=CX2yZ5EvC9D4kgUXVekaUskEiC
	jnVnZC+f3bWQsdQ6Dt2NeAJl9fw6QvvH1BEXkhI4cLErRJOoOxw1oVMdD1kgsM87aK8AIK67vFf5c
	yLgN26ZHtAF0Pz6PYYKSqPx2XA0osl5nLuoWoY6Eo9ioQuRku7QHqWogojquRn2dcR0yx74Fdhd6c
	TbUvaUE0wkiO1xYD4ewldbkfp0oYQHquS4MKf3GhT+1O2lXWltjcPcC0GShIStChdFKDLoMGaHFl8
	CKZyVldkZCcnBlhRK3rBtdEWJBRmM7vb4n/LhV58bEJYRY7BgyLGjopUl7aaVW/ruKv7ulXqbkptf
	dSFIueug==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vHGyE-00000005ylg-3fwE;
	Fri, 07 Nov 2025 07:34:25 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 038143001D4; Fri, 07 Nov 2025 09:28:46 +0100 (CET)
Date: Fri, 7 Nov 2025 09:28:45 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, Dapeng Mi <dapeng1.mi@intel.com>,
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Xudong Hao <xudong.hao@intel.com>
Subject: Re: [Patch v9 10/12] perf/x86/intel: Update dyn_constranit base on
 PEBS event precise level
Message-ID: <20251107082845.GB1508773@noisy.programming.kicks-ass.net>
References: <20251029102136.61364-1-dapeng1.mi@linux.intel.com>
 <20251029102136.61364-11-dapeng1.mi@linux.intel.com>
 <20251106145217.GA4067720@noisy.programming.kicks-ass.net>
 <09210c12-cc61-4af5-bd13-830fd9650f9b@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09210c12-cc61-4af5-bd13-830fd9650f9b@linux.intel.com>

On Fri, Nov 07, 2025 at 02:11:09PM +0800, Mi, Dapeng wrote:
> 
> On 11/6/2025 10:52 PM, Peter Zijlstra wrote:
> > On Wed, Oct 29, 2025 at 06:21:34PM +0800, Dapeng Mi wrote:
> >> arch-PEBS provides CPUIDs to enumerate which counters support PEBS
> >> sampling and precise distribution PEBS sampling. Thus PEBS constraints
> >> should be dynamically configured base on these counter and precise
> >> distribution bitmap instead of defining them statically.
> >>
> >> Update event dyn_constraint base on PEBS event precise level.
> > What happened to this:
> >
> >   https://lore.kernel.org/all/e0b25b3e-aec0-4c43-9ab2-907186b56c71@linux.intel.com/
> 
> About the issue, Kan ever posted a patch to mitigate the risk, but it seems
> the patch is not merged yet.
> 
> https://lore.kernel.org/all/20250512175542.2000708-1-kan.liang@linux.intel.com/
> 

Clearly it became a victim of some scatter brained maintainer or
something.

Let me stick that near this set and go read the last few patches.
