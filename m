Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 022B5C147;
	Tue,  4 Jun 2024 14:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717511685; cv=none; b=MQ56Qgo2AxNbBS5AZV2hx0RNY2XUtCX+JgVs2D4P8og0fvpjZG2vpmI9OirjKet7Ptv5KGKhRv0bNzunzIDv5ZhspVY+HtcztqiXFI5z0wPjHneort14FH+yv8nhXM8GGEinM681472Ucb4VSoY6RoWiih3zg60fylX4HlwoGps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717511685; c=relaxed/simple;
	bh=VnrLIrbhzUALzkQehAninJgeB7+/iCbWWjBnOYjHgZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kqd1CJqG/7qvi+qKMq++FP3Ka5QFYTjJEyxtX1fAbfabBO+nElkIjB2dqbMn1Qrma+EB/snovCiCC0mW2NYrb5ycMwFMAk1wfYQ/lHHLqKI+OaqGqdNmB+45O3TVQ42V1Z6+uaYfunRkokbbtKZiIuQq+jByn1VdhuXmiiiaVF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CDA6F1042;
	Tue,  4 Jun 2024 07:35:07 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AA0143F64C;
	Tue,  4 Jun 2024 07:34:41 -0700 (PDT)
Date: Tue, 4 Jun 2024 15:34:36 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Besar Wicaksono <bwicaksono@nvidia.com>, Will Deacon <will@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [RFC/PATCH 1/1] tools headers arm64: Sync arm64's cputype.h with
 the kernel sources
Message-ID: <Zl8l_NdVEmcrsuSx@J2N7QTR9R3>
References: <Zl4MYzhP0NB-Z1DW@x1>
 <Zl7aOk2h4_73JmUu@J2N7QTR9R3>
 <Zl8cYk0Tai2fs7aM@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zl8cYk0Tai2fs7aM@x1>

On Tue, Jun 04, 2024 at 10:53:38AM -0300, Arnaldo Carvalho de Melo wrote:
> On Tue, Jun 04, 2024 at 10:11:22AM +0100, Mark Rutland wrote:
> > On Mon, Jun 03, 2024 at 03:33:07PM -0300, Arnaldo Carvalho de Melo wrote:
> > > The changes in the above patch add MIDR_NEOVERSE_V[23] and
> > > MIDR_NEOVERSE_V1 is used in arm-spe.c, so probably we need to add those
> > > and perhaps MIDR_CORTEX_X4 to that array? Or maybe we need to leave this
> > > for later when this is all tested on those machines?
> > 
> > Hmm... looking at where that was added this is somewhat misnamed, this
> > is really saying that these cores use the same IMPLEMENTATION DEFINED
> > encoding of the source field. That's not really a property of Neoverse
> > specifically, and I'm not sure what Arm's policy is here going forwards.
> > 
> > We should probably rename that to something like
> > common_data_source_encoding, with a big comment about exactly what it
> > implies.
> > 
> > I would not touch this for now -- someone would have to go audit the
> 
> Ok, you mean not touch tools/perf/util/arm-spe.c, right, can I just go
> ahead and update the copy of that header so that we have a clean (of
> build warnings) build?

Yes: update the header, but leave arm-spe.c unchanged. Sorry for not
being clear!

It'd be nice if we could update the commit message to note that we're
deliberately leaving that as-is.

Either way:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.
