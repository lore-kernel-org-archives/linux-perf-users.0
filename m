Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6C34A11;
	Tue,  4 Jun 2024 18:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717527348; cv=none; b=u31QdzL/3QNKJozImDRFk2WcOh7m4tJMd60YBYju2ZfyqGjFfAcD2OYZgTHEmMQi219A0GUnVFjUmFlWf1Lqecgr02Dv9I+KaCDg+LyCbnZv9GB8tAO+5ugDfXwXKJQNCcfUCrPaXcFYqF/TxqR4j++0NCt4nWMGu0Mw0nGAvLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717527348; c=relaxed/simple;
	bh=7etwAX1Sx0wpy2e1bNCcH1sY9OglvVJt3stPajkuwpA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CgQl7PMCNGd/ZxMpZBrk7O3pTkS0t3JVQQvE8cBpmb47zBtXQ/V2XBmdaP54EsFUCKYFDAiH0D5ShvhPgq2EP022n+erm+PxYqWxBKe2RdAZmW3uPLmk8i50F0F77lsxi1o6Oy5YYFmYwXuKYPYxj9bx/ztweFlZG85QldwsFNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qFAJnMeM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qFAJnMeM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D435C32782;
	Tue,  4 Jun 2024 18:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717527348;
	bh=7etwAX1Sx0wpy2e1bNCcH1sY9OglvVJt3stPajkuwpA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qFAJnMeMP7CD/A5g4VYceuMtehivxk4C8kzqXJQRm7peV+daD2hqzhd2Fpge74Nun
	 JQaA+VoIes12daVZaRLXEI5rG4ypAnA4bxuQK/CB5FSuckTEWyQ2M42YzMDf0oLK1E
	 iRb7ec6bqAoE9Cnvb0ncgEt2zdqpdYcFbl6V+2AbAdermBmy32e1mK1gd8od6+k12M
	 dUAiBfuF0N2hUSvYThBIEj5bB3KPI+RgUj+nAEqLmzoPiVGgOwfM05C9f6XiIJnriD
	 W3Bq9XZfFR1XF3W3h7z8MirvchWchBRxZ8/3SSLiRIWAUoyiJ0/z7dJY3NgzsZx3b/
	 NGD3Rz3mUOdFw==
Date: Tue, 4 Jun 2024 15:55:43 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Besar Wicaksono <bwicaksono@nvidia.com>, Will Deacon <will@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [RFC/PATCH 1/1] tools headers arm64: Sync arm64's cputype.h with
 the kernel sources
Message-ID: <Zl9jL1wCn3A5s8m3@x1>
References: <Zl4MYzhP0NB-Z1DW@x1>
 <Zl7aOk2h4_73JmUu@J2N7QTR9R3>
 <Zl8cYk0Tai2fs7aM@x1>
 <Zl8l_NdVEmcrsuSx@J2N7QTR9R3>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zl8l_NdVEmcrsuSx@J2N7QTR9R3>

On Tue, Jun 04, 2024 at 03:34:36PM +0100, Mark Rutland wrote:
> On Tue, Jun 04, 2024 at 10:53:38AM -0300, Arnaldo Carvalho de Melo wrote:
> > On Tue, Jun 04, 2024 at 10:11:22AM +0100, Mark Rutland wrote:
> > > On Mon, Jun 03, 2024 at 03:33:07PM -0300, Arnaldo Carvalho de Melo wrote:
> > > > The changes in the above patch add MIDR_NEOVERSE_V[23] and
> > > > MIDR_NEOVERSE_V1 is used in arm-spe.c, so probably we need to add those
> > > > and perhaps MIDR_CORTEX_X4 to that array? Or maybe we need to leave this
> > > > for later when this is all tested on those machines?
> > > 
> > > Hmm... looking at where that was added this is somewhat misnamed, this
> > > is really saying that these cores use the same IMPLEMENTATION DEFINED
> > > encoding of the source field. That's not really a property of Neoverse
> > > specifically, and I'm not sure what Arm's policy is here going forwards.
> > > 
> > > We should probably rename that to something like
> > > common_data_source_encoding, with a big comment about exactly what it
> > > implies.
> > > 
> > > I would not touch this for now -- someone would have to go audit the
> > 
> > Ok, you mean not touch tools/perf/util/arm-spe.c, right, can I just go
> > ahead and update the copy of that header so that we have a clean (of
> > build warnings) build?
> 
> Yes: update the header, but leave arm-spe.c unchanged. Sorry for not
> being clear!

np
 
> It'd be nice if we could update the commit message to note that we're
> deliberately leaving that as-is.

There is a link tag to this thread and I'll update the message removing
my questions and adding your recommendation.

> Either way:
> 
> Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks!

- Arnaldo
