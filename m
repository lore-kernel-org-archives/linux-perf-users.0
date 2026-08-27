Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9746F489892;
	Thu, 27 Aug 2026 16:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787847390; cv=none; b=ZV6Zj5II+jPQPZqFd7TCl7jB29OCkHbL94smtpuwt1k6bQwSUM2LCopBzl8r03a6VmH/2INk49lz2Ko0x4YP3PraSH5geGLPvmLQIx87B+2oNGxaslYcZ8AERge+LYVlf0BiVkZpY0u1v8z+/DlxKn3e2ytQN2JR+PzECgf83r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787847390; c=relaxed/simple;
	bh=Po7B+ioTUC8/AQc54cprCiMxCkcn8AmZZRO/gw2sSvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pxjbp2tai9An7twPwMnp/s3jUhCSmameSSYmkmSRwtTYkHwop6B5/MgEumRhLRNX4ACBy0Afe67YliZ0kEDrfRP+nYWttVJxRJgWvOH1JrlE/dqBrmsrt++FJ5toOD7gqiOyyHnBsvabO63SzWLTlnrCQYxuyC+EEmFaaMu5X8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=RSz0WQUr; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="RSz0WQUr"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 71856165C;
	Thu, 27 Aug 2026 09:16:17 -0700 (PDT)
Received: from localhost (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D280E3F66F;
	Thu, 27 Aug 2026 09:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1787847381; bh=Po7B+ioTUC8/AQc54cprCiMxCkcn8AmZZRO/gw2sSvM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RSz0WQUrcKH2CxlPtJo/0Invj3NXrJJrlz9QcPIDv+6RcnX0U5tzKjzBArF49rlno
	 ZC1qb6WRgIWljwhSLGfZ994TWwRDd9m+hXYBJNYaO80EHzG1UIlDa5HovlCjXOIFWO
	 z0DFR7ViT+KHq3/JM/jWZBAY5XS2s33Kw41C7ET4=
Date: Thu, 27 Aug 2026 17:16:19 +0100
From: Leo Yan <leo.yan@arm.com>
To: James Clark <james.clark@linaro.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@arm.com>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Suyash Mahar <smahar@meta.com>, Amir Ayupov <aaupov@fb.com>,
	Leo Yan <leo.yan@linux.dev>, linux-arm-kernel@lists.infradead.org,
	coresight@lists.linaro.org, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 07/14] perf arm-spe: Use generic snapshot search
Message-ID: <20260827161619.GN8904@e132581.arm.com>
References: <20260821-james-cs-unformatted-per-thread-fix-v2-0-00c4fd0701b4@linaro.org>
 <20260821-james-cs-unformatted-per-thread-fix-v2-7-00c4fd0701b4@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260821-james-cs-unformatted-per-thread-fix-v2-7-00c4fd0701b4@linaro.org>

On Fri, Aug 21, 2026 at 10:49:05AM +0100, James Clark wrote:

[...]

> SPE also had a special fixup case for head pointers greater than the
> buffer length, which is not needed because the SPE driver always wraps
> them, and __auxtrace_mmap__read() handles that anyway. It also didn't
> have the special case for old > head for when the wrap heuristic fails
> but the pointers showed a wrap had happened.

Here mentioned the "special fixup case" is:

  if (head >= buffer_size)
      return true

If the hardware pointer is exactly the end of buffer, it is a strong
indication for wrapping. So it might be worth adding an explicit
"head == buffer_size" check in the common code.

That said, if always checking the final 512 bytes, this case is very
likely to be detected anyway, so I am not concerned about dropping the
check.

> The other feature lost is that this search only looked from head to the
> end of the buffer, rather than always at the last 512 bytes. This was
> flawed because once head is close to the end, it's likely it could
> contain zero padding from actual SPE data and a wrap would be missed.

> It's better to err on the side of caution and mark as a wrap, rather
> than trying to optimize by limiting the search from head onwards.

Wouldn't this be a trade-off between missing a wrap and reporting a
false positive wrap?

Ignoring head makes the search overlap valid trace data when head is
close to the end of the buffer but has not wrapped yet
(e.g. mm->len - head < 512). That data can then be mistaken as evidence
of a wrap.

For a false positive wrap, [head..mm->len] contains zero data. This
should be fine, as zero data are treated as PAD packets and discarded
during decoding.

I'd suggest adding this info into the commit log, in case later we need
to understand these weird cases. With that:

Reviewed-by: Leo Yan <leo.yan@arm.com>
