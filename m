Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B133426EA3;
	Wed,  4 Feb 2026 15:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770218438; cv=none; b=lBdnpEXaOt/kHxsMTMDAHRPqzeQo+wKCByQVP4UaK6uYMYmF4ABJgCXJ7MMeUSxk/CsgfvhOAGc2ZhToTkEYDWHxbdFj0cnu7iBJicdkzBx41w81rDlw38rQXZ5sV9pQ4iwXmwPi161nVnHAgB2+N6i+OATtfxv32+b9ghWYH9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770218438; c=relaxed/simple;
	bh=++9lYWzTdMOjgGXRPi1wm/r2DF+ABICab3CW23ZaRaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nNk6u1XN+p4GvsGK9wHxDdd1YeTnoVPlsRMqtAkvzJ6yt5h5C9TkMHeb8lCKA0bQmRJ07w2eUChEKnJ9KYZuRImKKdiFYg8pydaUVcI/PGa1H872PXcJRBoPTOU2pXhQi186ih+deGxQVjDf46pv4n0jXrHvo79li5mG9QykAng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PUXGSiyX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PUXGSiyX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60A23C116C6;
	Wed,  4 Feb 2026 15:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770218438;
	bh=++9lYWzTdMOjgGXRPi1wm/r2DF+ABICab3CW23ZaRaU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PUXGSiyX0isPBVHbRTYr/12v4GH9HH7Cqyv3xq1MajCbb/ofN2RFqCHIBuRNEWCX/
	 iT16LebdEOcYe+hSyVuv8eK72lPrJUwDbs67AoDd0W76PoHBlX2SG984hhlW2DQuI2
	 uAKqeNoNPqX6Y0unJevlyywBezRmKTpg86qDIiwrdx4cBnUhgmA7GXLSN2zNt+6rl1
	 cx4bDYiaSWkxYhFBa41IRgWM1+CI070nuJcGadMIFwM7GQpmeWtydHTAyHzb7rGIKd
	 78oZJpEFUtTe84/lSoaoxrLDQroTqS+DwGKpuhMOa1hdWNJb72t4svbPoyIbeh/rBC
	 GsUj+a4Zh9nxA==
Date: Wed, 4 Feb 2026 08:20:34 -0700
From: Tycho Andersen <tycho@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Chun-Tse Shao <ctshao@google.com>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, Ravi Bangoria <ravi.bangoria@amd.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>
Subject: Re: [PATCH] perf: fix segfault in `lock contention -b`
Message-ID: <aYNjwvYkvk0Ul2Jl@tycho.pizza>
References: <20260109164417.396138-1-tycho@kernel.org>
 <aWGh_XNyt-hmSamy@google.com>
 <aWUeOQbFOZ2CVBG2@tycho.pizza>
 <aWa2vDy_0QGh_a20@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aWa2vDy_0QGh_a20@google.com>

On Tue, Jan 13, 2026 at 01:18:52PM -0800, Namhyung Kim wrote:
> On Mon, Jan 12, 2026 at 09:15:53AM -0700, Tycho Andersen wrote:
> > On Fri, Jan 09, 2026 at 04:49:01PM -0800, Namhyung Kim wrote:
> > > That said, can you add a NULL check in the init_numa_data() instead
> > > and see how far it can go?
> > 
> > Looks like not much further, it fails in lock_contention_bpf__load():
> > 
> > ./perf lock contention -b
> > libbpf: kernel BTF is missing at '/sys/kernel/btf/vmlinux', was CONFIG_DEBUG_INFO_BTF enabled?
> > libbpf: failed to find valid kernel BTF
> > libbpf: kernel BTF is missing at '/sys/kernel/btf/vmlinux', was CONFIG_DEBUG_INFO_BTF enabled?
> > libbpf: failed to find valid kernel BTF
> > libbpf: Error loading vmlinux BTF: -ESRCH
> > libbpf: failed to load BPF skeleton 'lock_contention_bpf': -ESRCH
> > Failed to load lock-contention BPF skeleton
> > lock contention BPF setup failed
> 
> Thanks for checking this.  I think it's ok to fail like this when BTF is
> not enabled.  Let me see if I can make some changes to run without it
> later.

Gentle ping, I was just reminded of this crash again this morning.

Tycho
