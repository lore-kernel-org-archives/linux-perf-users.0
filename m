Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF85419C56F;
	Tue,  1 Oct 2024 21:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727817555; cv=none; b=c1XcL0jTEMP/S0bcOmjzjSVo07U1TzvMJvnQzR3WNMpcBoApAWVYenYP2DpZ4yVGgWP23r4aScJ96K39kfP8ppOej+kFbRsGR16ZQbYtprfa617rkLi1gin438cqUvPDbXNsJNdjEOL3h+D5tN5Qpo/8n1yT5s2dl8ky9A6xKHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727817555; c=relaxed/simple;
	bh=244LgueFRtPdrYTYFFh1neNOJHKmMrFxLaO4qT37TdI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U4v8dkd5QkqW7lnLGWbGmavfdP4XyLkhtyHSn4tgMxVJBMVYtKpUcKGFQh2cbJRQC2ntVcE96EI5myyh8wu6sMURd977yfaA6gVJef+gjScbLQr8ET9HkIQ7l0jrtCPgY8Ir+sVYeXbulH7ne/lw4cjF7HXGxGY4MSczIVJAm5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VuFbAORd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VuFbAORd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBC2AC4CEC6;
	Tue,  1 Oct 2024 21:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727817555;
	bh=244LgueFRtPdrYTYFFh1neNOJHKmMrFxLaO4qT37TdI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VuFbAORdc5igqvJcV+l36uysAL/HAooTfAqXKCLQ7Ezo44aOp2sYKrY1MzcCa8eK9
	 Mc3b1o3VqCMWCKSmHaZqQUTHGzVOFN5be1fXFXzZJC0D7PgxUBda5jn7fKkPsibmf8
	 lOwW3NS/DHOuN02skoAv59Xayrbp6qn1/swV14MITq5REkSADBsP7+pM9XUGyCZ35j
	 uILqPTsuTspsxu2V3MK7hGPClF4ZbxiZqMVbaVuAnNdAYIExKJIAUmFqRXjMtIu9+B
	 +1WK9rnT7LwmUrU+y/buwX3G/d5VkkPRg75xyeAmek9Vf6OIV905oErk1JEYUc71OO
	 Db5VaH8tE5AXg==
Date: Tue, 1 Oct 2024 14:19:13 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Mark Rutland <mark.rutland@arm.com>,
	James Clark <james.clark@arm.com>, Kajol Jain <kjain@linux.ibm.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Atish Patra <atishp@atishpatra.org>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Mingwei Zhang <mizhang@google.com>
Subject: Re: [PATCHSET 0/8] perf tools: Do not set attr.exclude_guest by
 default (v4)
Message-ID: <ZvxnUfgEiHY-Zmr4@google.com>
References: <20241001002027.1272889-1-namhyung@kernel.org>
 <4ce19789-eea1-4e5e-9269-13bd78d846c2@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4ce19789-eea1-4e5e-9269-13bd78d846c2@linux.intel.com>

On Tue, Oct 01, 2024 at 01:46:36PM -0400, Liang, Kan wrote:
> 
> 
> On 2024-09-30 8:20 p.m., Namhyung Kim wrote:
> > Hello,
> > 
> > I found perf tools set exclude_guest bit inconsistently.  It used to
> > set the bit but now the default event for perf record doesn't.  So I'm
> > wondering why we want the bit in the first place.
> > 
> > Actually it's not good for PMUs don't support any exclusion like AMD
> > IBS because it disables new features after the exclude_guest due to
> > the missing feature detection logic.
> > 
> > v4 changes)
> > 
> >  * handle EOPNOTSUPP error in compatible way  (Kan)
> >  * drop --exclude-guest option in perf stat
> >  * not to separate exclude_hv fallback
> >  * rename to exclude_GH_default  (Kan)
> >  * drop the RFC from the subject
> > 
> > v3) https://lore.kernel.org/lkml/20240905202426.2690105-1-namhyung@kernel.org/
> > 
> >  * move exclude_guest fallback to the front
> >  * fix precise_max handling on AMD
> >  * simplify the default event for perf record
> > 
> > v2) https://lore.kernel.org/lkml/20240904064131.2377873-1-namhyung@kernel.org/
> > 
> >  * update the missing feature detection logic
> >  * separate exclude_hv fallback
> >  * add new fallback for exclude_guest
> > 
> > v1) https://lore.kernel.org/lkml/20240902014621.2002343-1-namhyung@kernel.org/
> > 
> > AFAIK it doesn't matter for the most cases but perf kvm.  If users
> > need to set the bit, they can still use :H modifier.  For vPMU pass-
> > through or Apple M1, it'd add the exclude_guest during the fallback
> > logic.
> > 
> > Also the kernel feature detection logic should be separated from the
> > exclude bit tests since it depends on the PMU implementation rather
> > than the core kernel features.  So I changed it to use a software
> > event for the detection and factor out some hw-specific checks.
> > 
> > The code is available at 'perf/exclude-v4' branch in
> > git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git
> > 
> > Thanks,
> > Namhyung
> > 
> > 
> > Namhyung Kim (8):
> >   perf tools: Add fallback for exclude_guest
> >   perf tools: Don't set attr.exclude_guest by default
> >   perf tools: Simplify evsel__add_modifier()
> >   perf tools: Do not set exclude_guest for precise_ip
> >   perf tools: Detect missing kernel features properly
> >   perf tools: Move x86__is_amd_cpu() to util/env.c
> >   perf tools: Check fallback error and order
> >   perf record: Just use "cycles:P" as the default event
> > 
> 
> The patch set looks good to me.
> 
> Acked-by: Kan Liang <kan.liang@linux.intel.com>

Thanks for your review!
Namhyung

