Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E53175BF;
	Sun, 26 Oct 2025 00:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761439347; cv=none; b=eGCM9KwyVDVD7m16NqwD9D5XvKN1RIfh24CXivD4Tc2Fwco6PH0whi/PbYyl4Rr4XghrWV97VZ6EDEK7PXBQLDn9c1YWvTee/JpdT42Gl22zwEssb/QMNb7OEhF1Mdu2XJk5t2DKBEcrBKRkkVq/cxLacazrAvnIWBlavwqAkF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761439347; c=relaxed/simple;
	bh=pI8nQIGsVPd1D7KHekikmhNkDN5KTMCySGjlVYaK6Hg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eDRIfbOz+sSCSMt9gM2pqbVrlFyNPrKMT+VeOiS5U47Io6vNUn4YjtIev1Lfg43Tsekeym/Jgp2AZeeAGa+9s9CpeqZH01FzMSAxFKG6tthZj/a5VobSCGJ/WXCwFWw85mNQwKurRweFc7cVuyECZng9QSg6dlff/bOSyj3dbeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YO996WoQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YO996WoQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1FB5C4CEF5;
	Sun, 26 Oct 2025 00:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761439346;
	bh=pI8nQIGsVPd1D7KHekikmhNkDN5KTMCySGjlVYaK6Hg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YO996WoQKCbQWRTa0u53f+TrlZuyh+Dei5RfNKerYC7pDL2DbP0oNtoE0aLfnVCMI
	 dASliJU0g78Ls1lGXoI98SGB0NFkgwKZ8j4TMmhoTa/Ps/RO8XEJH+h062NMlWZPsf
	 vfOmjrqh6RBJqrw/v4OIHE9fHUi80e5J5I1hocNIU+zeGYFPAmEEFxKS8oyq6QKIjn
	 53g3UVqyQ3QZnVbVq9OXEEoFUNHQvxy/TVzmirQ8ymqCQknnZuBA60DKY3+mD0zZm0
	 YSovOZVDj80vXblSfn2PHpfadVBAKEYYvlI11dtQheCAKIES+ks38UrU07Bfju5rFG
	 rl/O7eggYjlXg==
Date: Sat, 25 Oct 2025 17:42:24 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: "Chen, Zide" <zide.chen@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	thomas.falcon@intel.com, dapeng1.mi@linux.intel.com,
	xudong.hao@intel.com
Subject: Re: [PATCH] perf tools: Refactor precise_ip fallback logic
Message-ID: <aP1ucJiJYBavTHV7@google.com>
References: <20251022220802.1335131-1-zide.chen@intel.com>
 <aPrktlANBHFtV52B@google.com>
 <576a7d2b-0a82-4738-8b86-507e4d841524@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <576a7d2b-0a82-4738-8b86-507e4d841524@intel.com>

On Fri, Oct 24, 2025 at 11:03:17AM -0700, Chen, Zide wrote:
> 
> 
> On 10/23/2025 7:30 PM, Namhyung Kim wrote:
> > Hello,
> > 
> > On Wed, Oct 22, 2025 at 03:08:02PM -0700, Zide Chen wrote:
> >> Commit c33aea446bf555ab ("perf tools: Fix precise_ip fallback logic")
> >> unconditionally called the precise_ip fallback and moved it after the
> >> missing-feature checks so that it could handle EINVAL as well.
> >>
> >> However, this introduced an issue: after disabling missing features,
> >> the event could fail to open, which makes the subsequent precise_ip
> >> fallback useless since it will always fail.
> >>
> >> For example, run the following command on Intel SPR:
> >>
> >> $ perf record -e '{cpu/mem-loads-aux/S,cpu/mem-loads,ldlat=3/PS}' -- ls
> >>
> >> Opening the event "cpu/mem-loads,ldlat=3/PS" returns EINVAL when
> >> precise_ip == 3. It then sets attr.inherit = false, which triggers a
> > 
> > I'm curious about this part.  Why the kernel set 'inherit = false'?  IOW
> > how did the leader event (mem-loads-aux) succeed with inherit = true
> > then?
> 
> Initially, the inherit = true for both the group leader
> (cpu/mem-loads-aux/S) and the event in question (cpu/mem-loads,ldlat=3/PS).
> 
> When the second event fails with EINVAL, the current logic calls
> evsel__detect_missing_features() first. Since this is a PERF_SAMPLE_READ
> event, the inherit attribute falls back to false, according to the
> fallback order implemented in evsel__detect_missing_features().

Right, that means the kernel doesn't support PERF_SAMPLE_READ with
inherit = true.  How did the first event succeed to open then?

> 
> > 
> >> kernel check failure since it doesn't match the group leader's inherit
> >> attribute. As a result, it continues to fail even after precise_ip is
> >> reduced.
> >>
> >> By moving the precise_ip fallback earlier, this issue is resolved, as
> >> well as the kernel test robot report mentioned in commit
> >> c33aea446bf555ab.
> >>
> >> No negative side effects are expected, because the precise_ip level is
> >> restored by evsel__precise_ip_fallback() if the fallback does not help.
> > 
> > I'm not sure.. some events may need a different (i.e. lower) precise
> > level than the max.  I think checking the missing feature later will
> > use the max precise level always.
> 
> Yes, but seems the basic idea of the event open fallback logic is to
> check whether it's lucky enough to open the event by falling back one
> single attribute, not multiple attributes.
> 
> evsel__precise_ip_fallback() can restore the precise_ip level after a
> failed attempt, while evsel__detect_missing_features() cannot recover
> the event attributes from its failed try.

I think precise_ip_fallback() is just a trial and error for each possible
value.  While detect_missing_features() checks what the current kernel
supports.  Trying different precise_ip values with unsupported attributes
doesn't make sense.

Thanks,
Namhyung

> 
> Therefore, falling back precise_ip first maintains the intended
> “one-by-one” fallback logic. If it’s placed later, it may combine two
> fallbacks, which can cause failures like the example above.  Of course,
> in theory, there might be cases where an event can be opened if both
> precise_ip and another feature are relaxed together, but I haven’t
> exhaustively checked whether such cases actually exist.
> 
> > Thanks,
> > Namhyung
> > 
> >>
> >> This also aligns with commit 2b70702917337a8d ("perf tools: Remove
> >> evsel__handle_error_quirks()").
> >>
> >> Fixes: af954f76eea56453 ("perf tools: Check fallback error and order")
> >> Fixes: c33aea446bf555ab ("perf tools: Fix precise_ip fallback logic")
> >> Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> >> Signed-off-by: Zide Chen <zide.chen@intel.com>
> >> ---
> >>  tools/perf/util/evsel.c | 6 +++---
> >>  1 file changed, 3 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> >> index ca74514c8707..6ce32533a213 100644
> >> --- a/tools/perf/util/evsel.c
> >> +++ b/tools/perf/util/evsel.c
> >> @@ -2714,12 +2714,12 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
> >>  	if (err == -EMFILE && rlimit__increase_nofile(&set_rlimit))
> >>  		goto retry_open;
> >>  
> >> +	if (evsel__precise_ip_fallback(evsel))
> >> +		goto retry_open;
> >> +
> >>  	if (err == -EINVAL && evsel__detect_missing_features(evsel, cpu))
> >>  		goto fallback_missing_features;
> >>  
> >> -	if (evsel__precise_ip_fallback(evsel))
> >> -		goto retry_open;
> >> -
> >>  out_close:
> >>  	if (err)
> >>  		threads->err_thread = thread;
> >> -- 
> >> 2.51.0
> >>
> 
