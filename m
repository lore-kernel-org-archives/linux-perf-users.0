Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892603B9DA2;
	Wed, 10 Jun 2026 09:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781083001; cv=none; b=DGwjGBQS8g1G5Bpun/YTiyoLN/fs5em4ZeQ+00DafSO3RzOf1UosHCen36agrb4ZYornAm4UJtg6l3Z683cpnGZkTGWc4cle5TrTiHlOVRUIXQbSHUe/5l2yF2qxL0GYI5vMIsV6ahbAYEUJD9S9EzI5PZ9FqK/+V8709Yz84s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781083001; c=relaxed/simple;
	bh=Iqd+FHt3OnSyhhHHrXBvKyTX0bhXQbVp2+XZhWhkOGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=scWlejy+KIC6PzmqdoQppVh8aquRdBfsAtlDe4WNj5xU4TuIf9R4gb4VZAcoMHqvVGIB4trO0JanKKIRhd/Az4ar2xvBj67wzKaaIEKR01hkosYpLI4A0eM5AX+MEZrjYOFZhlqxnqPxhj9u5SBHvHZ2xuCGVbbWmC0HC86k3O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TE85sVFS; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TE85sVFS"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=RPbL7A8Y8Gy2DROXzJRDiI5faWiT2rvTWFT7dIV5gIU=; b=TE85sVFSRy9wl97soMJQTJ59mD
	zfugM30aSPc3qG7VT4KzRZjswfZAQQoDioVSTt6uM5fo1OIDhH8iGTsD48R5An0w4QYXlf6tQ9Jli
	1lJP/6zemwkf6eYKymTos53HQVwQaqXG5DnM3f/bmBy4W4NclJuZqlzBKYJrKjyYC+YY26xcIZq7H
	NzFFLrx+S8t9FmE5EC4CiRnGQOA0tLp0msTzuj7CIpEewTPNtfRbVzOsDcZUo1STbszW+31cIgeux
	AdtvkxJqhNxhX26j0i7H04Iaz6yDz4YuPT0evTxGwzaWL5haWMIm4xKJnbDJ4DQ7LuwmtoU3lyTEG
	UFlRoObw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wXF2x-00000003fvw-2CHP;
	Wed, 10 Jun 2026 09:16:30 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id D29E030036F; Wed, 10 Jun 2026 11:16:25 +0200 (CEST)
Date: Wed, 10 Jun 2026 11:16:25 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Dapeng Mi <dapeng1.mi@linux.intel.com>
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
	Xudong Hao <xudong.hao@intel.com>,
	Mark Rutland <mark.rutland@arm.com>
Subject: Re: [Patch v2 8/9] perf/core: Fix kernel register info leak via
 hardware skid
Message-ID: <20260610091625.GE48970@noisy.programming.kicks-ass.net>
References: <20260609050222.2458129-1-dapeng1.mi@linux.intel.com>
 <20260609050222.2458129-9-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260609050222.2458129-9-dapeng1.mi@linux.intel.com>

On Tue, Jun 09, 2026 at 01:02:21PM +0800, Dapeng Mi wrote:
> An unprivileged hardware perf event using exclude_kernel=1 can leak kernel
> register data to user space via PERF_SAMPLE_REGS_INTR or PERF_SAMPLE_IP.
> Due to hardware skid, a PMI may trigger after the CPU has already entered
> kernel space (Ring 0), bypassing the perf_allow_kernel() privilege
> barrier.
> 
> This security vulnerability is severely exacerbated by upcoming support
> for SIMD register sampling via XSAVES, which could expose sensitive kernel
> FPU states (such as active cryptographic keys).
> 
> Fix this by ensuring that sampled register data is dropped if the event's
> exclude_kernel attribute is set but the PMI catches the CPU in kernel mode.

There is history here, see for example:

  https://lore.kernel.org/r/CAP045Ap8cMx6mzSgcQ3n3bnh_8GJuCp7_KZe_5ZTCR_K6cPTLw@mail.gmail.com

So your earlier patches also sanitize the branch stack, but not in
generic code.

PHYS_ADDR already requires privileges
ADDR comes from PEBS on Intel, and IBS on AMD (iirc) and should be
reliable.

So yeah, I suppose IP and REGS_INTR are the big ones.
