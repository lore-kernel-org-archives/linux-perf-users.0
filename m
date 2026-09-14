Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B249A409632;
	Mon, 14 Sep 2026 08:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789373628; cv=none; b=LRYGdwBZwRut8agemcx040kOlqtcZpIITpQha85iTyhwZyI1zIj6vnb2fql5/dqEqojODSJ1Rm6+O3UTVxGPqcsSpOm3/pPxUAUGQp7UfXN5LxrznpXDAJX4arA28ISuTAwai8ZqO/FKSzjfDxzbgw24EmCPGyaV2iyYnPUZTXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789373628; c=relaxed/simple;
	bh=IUx9npSbM6aOGbT981H4LjgrA0kKmEs/fDvfjpfynoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pTO9ADwfWBDcCLeQZa0kWcpfGAteLjIwIkvSGpVpCryTQJfbk0UHU4CToZ4G8mu/86BrWrpd3ytzRg0fls91jBUKE7XXLmqIseqNb1F67Q76LRtQXkgTOyPPRcy85zhohJqFH+0bd2E9rX0gUtR35l8O1fn4Fh+vnBAx+InUD0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Ie0F5Yrz; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Ie0F5Yrz"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 294771570;
	Mon, 14 Sep 2026 01:13:42 -0700 (PDT)
Received: from localhost (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 65B693F7B4;
	Mon, 14 Sep 2026 01:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789373625; bh=IUx9npSbM6aOGbT981H4LjgrA0kKmEs/fDvfjpfynoU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ie0F5Yrzn4+JUTJXdJ59qKHeSnntkVs/evhaYFzCMI5fXmKYH+ALw+LAaNOIZflIx
	 cchmn6Qw7oauzbwstdIZIrMFDU5g5YkP0LZS323YQUWkpNicFH6hRlQqRd42sDydXD
	 VqDiywdnOT+pXi0AJXMsRgbNU6Aemrf8+CG/mmpE=
Date: Mon, 14 Sep 2026 09:13:43 +0100
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: James Clark <james.clark@linaro.org>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@arm.com>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Suyash Mahar <smahar@meta.com>, Leo Yan <leo.yan@linux.dev>,
	linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH 00/14] perf cs-etm: Per-thread mode fixes and snapshot
 wrap support
Message-ID: <20260914081343.GF200420@e132581.arm.com>
References: <20260811-james-cs-unformatted-per-thread-fix-v1-0-90565318f5f8@linaro.org>
 <aqdL33fw9AoxTrPq@x2>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aqdL33fw9AoxTrPq@x2>

Hi Arnaldo,

On Sun, Sep 13, 2026 at 10:20:31PM -0300, Arnaldo Carvalho de Melo wrote:
> On Tue, Aug 11, 2026 at 04:30:03PM +0100, James Clark wrote:
> > Fix a few issues with per-thread mode:
> >   - With TRBE, thread migrations hit a queue without a decoder assert
> >   - On nVHE, everything looks like guest trace instead of host
> >   - Tracing multiple threads didn't really work
> 
> This series applies cleanly to perf-tools-next but has no Reviewed-by
> nor was processed by Sashiko.
> 
> Can somebody from the ARM camp take a look at it, please?

James has sent v2 [1] and I gave some words on it. Adrian also has one
comment for snapshot callbacks refactoring.

Sashiko also sent out review on the series.

Thanks,
Leo

[1] https://lore.kernel.org/linux-perf-users/20260821-james-cs-unformatted-per-thread-fix-v2-0-00c4fd0701b4@linaro.org/
