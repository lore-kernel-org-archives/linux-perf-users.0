Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8BD2459CC;
	Wed, 26 Feb 2025 09:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740563332; cv=none; b=ZMVWMYhxkMzgrqLE2H3yABLOUZrwM1XAWCfO7AcwLGcVjSr1hytPIYG91JriekQfTD0YvrADD4eyigK7ZUx8FY28jk8bvaZLJXcn1Jr2NX/E9Le496HJk5akfliRdD0u+Ychl0pMjEhL7cksc+DM1/yTd8w/5wG2FBTRe6ntCXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740563332; c=relaxed/simple;
	bh=QP93zTpIBj69URrJI/doxAsbsvpPaRP3UufccvOM9RI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N8YC/YuGxKnKClnV993ghAu5QfaM+9jmt7AOXBuu2iDY44uPKXc6e+syYLSy6b00iENFg28+Jgfw/YkC5YqH9zr2PlgwMGzED5wM47h/vyRelKNtjAQG2bqlw79XbS8jHx5PyAqVGIoFuV8MLJJMIIFJRFmjYNYmsQjZ8hS0yfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OAyxZ13v; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OAyxZ13v"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=871hFDdRTS+OmWOz6zBCg95pt62GNhL4S6ODQibnhm4=; b=OAyxZ13v6drg2o41uBYCpG7hpY
	YYwg7sFxGpGwOQLo/KE1Q0SNOr+2oXD103PoW7Z1HHVk+d5+BC3jxteMpEXlS/wzDMkE1m3+grPOS
	Ru8iG2HGLHa6XRSpxnIx5Pz6kOMJwdJyWkz7bOTEgnSgwp/V1lYewaz6bi1r6JX2e/TVtCuywrDxP
	xbsBMClWmez6YU2/rqC8izSbVTVygxW+aKGRi57QYct//tXbzL0o658FrQkvAuXvxZNvj9nYaGW5M
	pokONrO/k8BZbDDXakEQ9Bz2iB00aRUnG2Hh+8RLOQvEKFbWlLhew/4ggqJLkFo6i1wTGVUcU2J48
	CHjTNZJA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tnE1y-0000000Ep3b-2VNh;
	Wed, 26 Feb 2025 09:48:42 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 992A3300677; Wed, 26 Feb 2025 10:48:41 +0100 (CET)
Date: Wed, 26 Feb 2025 10:48:41 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, Dapeng Mi <dapeng1.mi@intel.com>
Subject: Re: [Patch v2 12/24] perf/x86/intel: Allocate arch-PEBS buffer and
 initialize PEBS_BASE MSR
Message-ID: <20250226094841.GT11590@noisy.programming.kicks-ass.net>
References: <20250218152818.158614-1-dapeng1.mi@linux.intel.com>
 <20250218152818.158614-13-dapeng1.mi@linux.intel.com>
 <20250225112543.GM11590@noisy.programming.kicks-ass.net>
 <000043b8-1284-46f3-b117-9ece905f218e@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000043b8-1284-46f3-b117-9ece905f218e@linux.intel.com>

On Wed, Feb 26, 2025 at 02:19:15PM +0800, Mi, Dapeng wrote:
> 
> On 2/25/2025 7:25 PM, Peter Zijlstra wrote:
> > On Tue, Feb 18, 2025 at 03:28:06PM +0000, Dapeng Mi wrote:
> >> Arch-PEBS introduces a new MSR IA32_PEBS_BASE to store the arch-PEBS
> >> buffer physical address. This patch allocates arch-PEBS buffer and then
> >> initialize IA32_PEBS_BASE MSR with the buffer physical address.
> > Just to clarify, parts with ARCH PEBS will not have BTS and thus not
> > have DS?
> 
> No, DS and BTS still exist along with arch-PEBS, only the legacy DS based
> PEBS is unavailable and replaced by arch-PEBS.

Joy. Is anybody still using BTS now that we have PT? I thought PT was
supposed to be the better BTS.
