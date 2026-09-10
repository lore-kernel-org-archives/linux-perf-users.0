Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07AB04908C6;
	Thu, 10 Sep 2026 13:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789047872; cv=none; b=l6Y6W1tmCDwxjmNQ3hYDnYtrykg7HwEKKA66SQNItSsCiMcuTXJzQEBRd7nbx4M8A6RXf0bLwFwP+6rvImtd0m413mkX3eHOTDjw6VLqXRH2cj+3m7kGJUDgKYn/cEAk/YZcnb1s4CNT1l6EXg1k5q7E9kty3i8CIeeFSUVeu88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789047872; c=relaxed/simple;
	bh=bIwWQpXipxMRcB/emu/mOwdbnXa5cDOt6wRE5AAVHus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uC46ubsxQmEhtv4uZJy8de53b99DJ8s6kJYPibYXFSQWoUw4AaYcsD9CnNkOjIJlU84rOEec+pxDKCoLB9hwmtIE1oG30c3tOUTxJZYbj66MP6LO1ZmnODevccrB1GsQ4lEWkq/1AFsMVvKB9CslpVtlctXyePxpsEF2nojjQYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pTKyYAIL; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pTKyYAIL"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=/4FhJKwRP8Lp0XnQIktc6XdRlLkbVSD9nMojGx2nRBM=; b=pTKyYAILmItNlw2zv3d70F/veG
	xIP+H92VpIdWMNCE9YCrbyK8PnjObamv8JSknCp1wvNliJbb4WYgdOp6VQyazfb5eLzDMgyyPQ9XB
	55oYNUMK/xYR+W/zIh+5MCrlE/RqcBlrCZw6PQhRFwzYzQmKp1AmKVZ5Mq/BIdoxbZvNaUrDG3nQI
	ECXkhapct/FUdOF/b5j2Wd0qij0iYEwtv4et4pp9489Wl3kE/Ss7tRQ67sdrdDjAvUHCmhk8UiCPJ
	F6k4QU2oSiWNADpy+pQGY/IYT9OK9fW76f9WJYB1zQDYcWWQasCHYrDxoCBpKkv2wnUrDgL1lw/Ea
	nnzT8NOw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4f4j-00000000Xh8-28dz;
	Thu, 10 Sep 2026 13:44:25 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 13E63300400; Thu, 10 Sep 2026 15:44:25 +0200 (CEST)
Date: Thu, 10 Sep 2026 15:44:25 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Dapeng Mi <dapeng1.mi@intel.com>, Xudong Hao <xudong.hao@intel.com>
Subject: Re: [Patch v10 00/10] Perf tools: Support eGPRs/SSP/SIMD registers
 sampling
Message-ID: <20260910134425.GV776954@noisy.programming.kicks-ass.net>
References: <20260721072707.3787848-1-dapeng1.mi@linux.intel.com>
 <23909a5e-2600-4d52-a0e4-5260cbeadb1c@linux.intel.com>
 <aqKxtHweUZEdcI_H@x2>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aqKxtHweUZEdcI_H@x2>

On Thu, Sep 10, 2026 at 10:33:40AM -0300, Arnaldo Carvalho de Melo wrote:
> On Thu, Sep 10, 2026 at 10:59:51AM +0800, Mi, Dapeng wrote:
> > Peter queued the dependent perf patches into the tip perf/core tree.
>  
> > https://lore.kernel.org/all/20260824082731.1013973-1-dapeng1.mi@linux.intel.com/
>  
> > But since there are UAPI changes, these perf-tools patches would lead to
> > errors without the corresponding perf patches. 
>  
> > @Arnaldo, @Namhyung, @Ian how would we handle such kind of dependency
> > issues generally? Wait for the dependent perf patches merged into mainline
> > and then merge the perf-tools patches?
> 
> That would slow down development, if it made perf kernel upstream, even
> if not yet to Linus, we can update the header in perf-tools-next, the
> check_headers script will warn about it, but now it is not running by
> default so no distracting warning and if when we decide to run it we got
> advanced warning that it will take some time to sort out, i.e. when the
> perf kernel UAPI header hits upstream and perf-tools-next merges with
> it.
> 
> So send perf kernel patches to Peter and the tooling ones to me and
> Namhyung.
> 

Patches are in tip/perf/core.
