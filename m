Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C306C3002C8;
	Wed, 12 Aug 2026 16:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786550663; cv=none; b=VCQrsud4q9VU5rDmzRjLs3DQpwtcQ1lhc3UZnn9AUdrnVwdg2CizM9hMOgR40Wwt04iXa7QGi+2oYLEW8FpsfQGCmzXJZ+vhco7BT3aZwBuunGn5CUoC1Via1cWHU7cuO1dHKrgZWGnhqgMPntQ57ocUOPA4CpikizL+y9TbD74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786550663; c=relaxed/simple;
	bh=eVRhJngr6bMz47JpFyBSv34ozlsoORzO98UTtyNcL60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q93KYBUKmZetKDn9lRTHLRDqKM6ARhpevDNF6KbMHZEtflkPowfA3dCBm9XSiyF9ezT5ubPFQLch1jSxLuembAb8ahMRDMWknpSb9qgKOytJZX7SYt2djmEkX15SduBKGjMvq3atQ3JGo61IEOROkn4hS38roH/jhbOpcW+z5l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XRAkMb1z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XRAkMb1z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E8D81F000E9;
	Wed, 12 Aug 2026 16:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786550662;
	bh=vJygTOdKukhuIJluqdbJ7WiouK0OKaet42x7L+IQKj0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XRAkMb1z0FwoU0GOlr0v1j1Qh82G3qkt9/i6Ka0KY5hWaHAlqCiQ7f7rgfeIXUWpT
	 WMOqPQm8VIJQKDWOkbEZJnS0oqwjGIt5qTcgDr2NDzvVTd8sx3ruOPUS2l7AoYtOuZ
	 U17s9gLEGECpmn6p6oaYgM4HVS7qtFqqEeBts5YO/HuXQLuFwZM0f/VNCG6KnuOuKx
	 el8J94c/i4TxfMjBKdGqWH/KcDhwrsL9qYsBVFZXSVorCrjVI4pO6p8T3HLMOeo0EH
	 gAfx+Q9dbIqa76L4taNjBKTQAkW98FiOluYBq85ua0j7ArA/cu1uay6fwIyID7OTzO
	 wvYX6CF/UMTpQ==
Date: Wed, 12 Aug 2026 13:04:18 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Amir Ayupov <aaupov@fb.com>, linux-perf-users@vger.kernel.org,
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	James Clark <james.clark@linaro.org>, Leo Yan <leo.yan@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	linux-doc@vger.kernel.org, Mike Leach <mike.leach@arm.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Swapnil Sapkal <swapnil.sapkal@amd.com>
Subject: Re: [PATCH 2/9] perf thread-stack: Report branch stack hw_idx as not
 available
Message-ID: <anyZgnHNV_P3fqbe@x1>
References: <20260803090640.2412336-1-aaupov@fb.com>
 <20260803090640.2412336-2-aaupov@fb.com>
 <544211a6-29c5-49ab-b9f9-543f199b9533@intel.com>
 <83378be0-1e89-4e31-94a4-ba083f0f7c8c@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83378be0-1e89-4e31-94a4-ba083f0f7c8c@intel.com>

On Wed, Aug 12, 2026 at 06:48:24PM +0300, Adrian Hunter wrote:
> On 11/08/2026 18:58, Adrian Hunter wrote:
> > On 03/08/2026 12:06, Amir Ayupov wrote:
> >> thread_stack__br_sample() and thread_stack__br_sample_late() fill a
> >> caller-supplied branch_stack that is typically allocated with zalloc(),
> >> leaving hw_idx as 0. Zero is a valid hardware index, so consumers that
> >> honour PERF_SAMPLE_BRANCH_HW_INDEX see a reconstructed branch stack
> >> claiming to start at LBR TOS entry 0.
> >>
> >> These branch stacks are reconstructed from instruction trace and have no
> >> hardware index at all. Set hw_idx to -1ULL, which is the established way
> >> to say "not available" and matches what intel-pt and cs-etm already put
> >> in the branch stacks they synthesise directly.
> >>
> >> Signed-off-by: Amir Ayupov <aaupov@fb.com>
> > 
> > Fixes tag?
> > 
> > Otherwise:
> > 
> > Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
> 
> On second thoughts, it seems that hw_idx is only used for stitching
> LBRs which is anyway disabled by default and only enabled by --stitch-lbr.
> 
> Setting -1ULL will prevent has_stitched_lbr() making a match, but we can
> rely on the user to decide that for themselves via --stitch-lbr.

This is one of those options that few people use as its so specialized,
do you think we could auto-enable it if we notice it is a good idea for
some specific machine and request from the user? I.e. user requests
callchains, unlimited or with a limit that is more than what we can do
without stitching: we auto stich?

- Arnaldo
 
> So, in fact, it doesn't look like this change should be needed?
> 
> > 
> >> ---
> >>  tools/perf/util/thread-stack.c | 2 ++
> >>  1 file changed, 2 insertions(+)
> >>
> >> diff --git a/tools/perf/util/thread-stack.c b/tools/perf/util/thread-stack.c
> >> index c5ce741b07446..1a3dffa83bde2 100644
> >> --- a/tools/perf/util/thread-stack.c
> >> +++ b/tools/perf/util/thread-stack.c
> >> @@ -624,6 +624,7 @@ void thread_stack__br_sample(struct thread *thread, int cpu,
> >>  	unsigned int nr;
> >>  
> >>  	dst->nr = 0;
> >> +	dst->hw_idx = -1ULL;
> >>  
> >>  	if (!ts)
> >>  		return;
> >> @@ -686,6 +687,7 @@ void thread_stack__br_sample_late(struct thread *thread, int cpu,
> >>  	bool start = false;
> >>  
> >>  	dst->nr = 0;
> >> +	dst->hw_idx = -1ULL;
> >>  
> >>  	if (!ts)
> >>  		return;
> > 
