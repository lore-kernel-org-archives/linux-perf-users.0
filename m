Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8605E2DCF45;
	Thu, 26 Feb 2026 13:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772111170; cv=none; b=czx9fgot6MA5ik6sHca+4ajG/jMzXyHoQtDxz3aAogGRAwwxgOlmjbgEsBJfs+8WYYsAUtNTMMgS56Cay+puWmjjRh/Y8GtBrB6+I3e0mRoyO1fpyv0wPB0ONiI/hseKumMoXAWJzJtereKI33tNDRCxMopH6YtF6ykAzGuo7Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772111170; c=relaxed/simple;
	bh=bPTACQtnDVwrh2f/I9r1/a1evMID9Ba6Z3MzsWAbsGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z6gqzYgw0oFcE0FC3M+52mp2AEz2ViDHpEMt6fRcFG6xkGFRUkFCme7lIM1e5X4DQlqeHWKrIOtC9W/cz729MXtQEbNI+IuACHdpPtjjqwMuJJn+FH7t5BKtEPToJNEjy0ohkiy7atsYhO/TSNK/rljtIGw1xcRW1SgNYHY3ERI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SqKMagjJ; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SqKMagjJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=A0/HWocQb68nGZKmEchDPZq+TglTn2PnmfDGzpkJZ/k=; b=SqKMagjJlGvHEHSXQrkAFesNyN
	Gm3Ty9IPfGhtU1FftcdTUg3XUIzDEF23Xzl/J2FAPNJ9vSHtMlzZnfnUKkt/hxhbSNASGxCw99SC4
	n5SvSUeFiGNTfYry8KdWKXWR6fObEfsrbLTMY0WCvdk9X6mgd3oRXvWAhF8RTqpizkKYgLvpW6doF
	yVfCtf69FFwgD5V/gMSKHz7mD+jLI+KDG2N5gDJb+KCjnl7mUJd4pajOqTFoig9F8GqjMZ7kQLIez
	mTMO1yBy70/oaB2SFQ7ys46eQZjpu71hitdIYcNcw6vmOxSRUxc3q8q5oF9En2oNj9kAaN/AoL1vx
	mK9BedPg==;
Received: from 2001-1c00-8d85-5700-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:5700:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvb46-0000000Azg7-1YUn;
	Thu, 26 Feb 2026 13:06:02 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B347A300462; Thu, 26 Feb 2026 14:06:00 +0100 (CET)
Date: Thu, 26 Feb 2026 14:06:00 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: Michael Petlan <mpetlan@redhat.com>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	Sadasivan Shaiju <sadasivan.shaiju2@amd.com>, x86@kernel.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Manali Shukla <manali.shukla@amd.com>,
	Santosh Shukla <santosh.shukla@amd.com>,
	Ananth Narayan <ananth.narayan@amd.com>,
	Sandipan Das <sandipan.das@amd.com>
Subject: Re: [PATCH v2 1/5] perf/amd/ibs: Account interrupt for discarded
 samples
Message-ID: <20260226130600.GB606826@noisy.programming.kicks-ass.net>
References: <20260216042216.1440-1-ravi.bangoria@amd.com>
 <20260216042216.1440-2-ravi.bangoria@amd.com>
 <79e0c820-e934-47a1-abd-3612e82b310@redhat.com>
 <c9771902-39da-430f-ab2b-ba953d9ba79e@amd.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9771902-39da-430f-ab2b-ba953d9ba79e@amd.com>

On Tue, Feb 24, 2026 at 01:41:54PM +0530, Ravi Bangoria wrote:
> Hi Michael,
> 
> >> Add interrupt throttling accounting for below cases:
> >>
> >>   o IBS Op PMU: A software filter (in addition to the hardware filter)
> >>     drops samples whose load latency is below the user-specified
> >>     threshold.
> >>
> >>   o IBS Fetch PMU: Samples discarded due to the zero-RIP erratum (#1197).
> >>
> >> Although these samples are discarded, the NMI cost is still incurred, so
> >> they should be counted for interrupt throttling.
> >>
> > 
> > Maybe worth tagging
> > 
> > Fixes: 26db2e0c51fe83e1dd852c1321407835b481806e ("perf/x86/amd/ibs: Work around erratum #1197")
> > Fixes: d20610c19b4a22bc69085b7eb7a02741d51de30e ("perf/amd/ibs: Add support for OP Load Latency Filtering")
> 
> Yes, makes sense.
> 
> Ingo / Peter, Please let me know if you want me to respin.

I've added them. Thanks!
