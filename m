Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80CC221DB7;
	Wed, 23 Jul 2025 19:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753297873; cv=none; b=cSA8hvsS7pbsuPsvp43noMK6wJDG7gfQiSAApze+Fj+WkON0M7x1vIBKdZxUUaD+wNveXi4WkOtZl1SbvMbNfJDjPDbt+E5AaGml5JHnNOnfR+6X7PfQ3o5wHMs70Am0HxM7ZllD+pyvirapGQK+xTwfa/N2W3LUbgSBMDmp1x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753297873; c=relaxed/simple;
	bh=V5byk39n1HmyWQGRKiSu3MxLT9DQq3UI17ZkhmMF038=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qQ9vfSPkDaUrF5jCAl2qXqoSdEfZ0qC4Xe8Irhk/AuJ+WvifDevoGfCHpT/0ItOsy92hMMTIqg6v5npT3CB+PxNw71/ai4QM//l/Xj+yo6gxD2oIyvUpP8ibO+oy0H5jETWnVyV2hwhR0AEbYnmlXspbRUtCIxlxpeMAbF2ToiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FIhj+X2f; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FIhj+X2f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94E80C4CEE7;
	Wed, 23 Jul 2025 19:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753297873;
	bh=V5byk39n1HmyWQGRKiSu3MxLT9DQq3UI17ZkhmMF038=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FIhj+X2fBYCZjgRYRC3FLPrs24n5uXGDHBZx5jMCxHxgO9Jpk7+8vTQ5sUlPF1Wmm
	 I9lqYoWVojbh06SY84pl3PwmSA1XUdvQ/fLT2xZJTvq9ulW7ogRD0TsDGX3+jJAUMl
	 YhgSXXXf9IkcgL8+kW7oo7DpqjwjsT8Qg5mHzF9gCkPfVaOIIcOK0HPmm5ar2PjUBQ
	 GIXst8ZazMfyIImICU3IcNdpqrQZzBToCJyqFksZhBoAm03Go4O7EaJfT/iheBoZRz
	 cdWOtNEL1KQAgbUtivsQErqPkks6VPPSNK/oVDZP8vZSVsZ/qcpPBlPB4iHiXBJ/CC
	 K57zpM4DiuvCA==
Date: Wed, 23 Jul 2025 16:11:10 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>, Xu Yang <xu.yang_2@nxp.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Collin Funk <collin.funk1@gmail.com>,
	Howard Chu <howardchu95@gmail.com>,
	Weilin Wang <weilin.wang@intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Gautam Menghani <gautam@linux.ibm.com>,
	Thomas Falcon <thomas.falcon@intel.com>,
	Chun-Tse Shao <ctshao@google.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v7 00/16] New perf ilist app
Message-ID: <aIEzzt1f3UWDCAIw@x1>
References: <20250714164405.111477-1-irogers@google.com>
 <CAP-5=fW=AG8ztbzS-KXpo9fH_Hp_fkZ3CVDuG9pN7P32Qm0oyg@mail.gmail.com>
 <aIEjMroa3bW-T7d-@google.com>
 <aIEzRNLTCTA5Gqhm@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aIEzRNLTCTA5Gqhm@x1>

On Wed, Jul 23, 2025 at 04:08:55PM -0300, Arnaldo Carvalho de Melo wrote:
> On Wed, Jul 23, 2025 at 11:00:18AM -0700, Namhyung Kim wrote:
> > > I think there is some follow up for "make install" for scripts like
> > > these, but I'm keen for the python API to move forward.
> >  
> > I'll review the series today so that we can get some part of it, at
> > least.  Basically I think we need a wrapper script like perf-ilist to
> > run this easily (maybe with documentation).
> 
> I just tried, with the series applied:
> 
> root@number:~# perf ilist
> perf: 'ilist' is not a perf-command. See 'perf --help'.
> 
> Did you mean this?
> 	list
> root@number:~#
> 
> Now trying to figure out why it is not running.

So it is not wired up like 'perf archive', trying it directly:

root@number:~# ~acme/git/perf-tools-next/tools/perf/python/ilist.py 
Traceback (most recent call last):
  File "/home/acme/git/perf-tools-next/tools/perf/python/ilist.py", line 11, in <module>
    from textual import on
ModuleNotFoundError: No module named 'textual'
root@number:~#

I thought there was some discussion about catching this exception and
providing guidance, lemme try...

- Arnaldo
