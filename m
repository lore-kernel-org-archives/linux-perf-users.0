Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794279050;
	b=nG/jNYypGvDaO4HellLUaeyMcHblAn8CaekJ68QYEyiZgra/K6odxGK/Jq8tbSc6bXze
	 HGOkQl75j/wNJv/6TCIaf4rYK1Mfq18FTVHnFGu2BDJuz4tqnpMo+JxVKjeK1sOjQWzGS
	 vI5bLAlFUm555D8Y9dBGktarEiPmlX1D2KTxxTKN9gqJ4JgwJvcCNctvjcUV15WcLpJp8
	 p7mH5ysxOVFrgdi3eHeA2uLMZOMeZpDUavFUHtpAdVfg8GvCQIQdRIwXMkbnLlZxw1MY1
	 fJPo5oU87Mw42N1w2Q9dbO8cn/b8GOM/Y9fEOLkyWge6V//pBUOeZAp69S1vvbVPrWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794279050;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=V4BuPZ7NW9TLL+8xfWGzyH2DKRK7c1rfjhgBtZNneX8=;
	b=XjS3vm6S2/nWhlREfiqwIs0k9GXBmx5mQkZT/ReWe2TEsrUb0clsVfC2AXO1iDhkdalO
	 sWMi/VDjOl1tZp8Ye84LqFAxHOHyJx+HPsZDdSm0Ls2l3wPv+ISdhhLYgs0uVHyVSNwpE
	 0CNnswV8/H1+Cp7H8hFs/PBl8e8mY5a3sY66d7ilDQKsaXQpgA54zo2VA5HweXJ8XEiNI
	 T79R8mwQU3oE+88yy9XZjkmQzoyfdQguINNL+2XKNnmjbOoP58EpeSOn71ef92uY0/aZK
	 KFg7srHVmuQ3x7CwR5CIAWRv6VAQO7D+DUrufeOBvOhSKDXmhncG+AR55iFOYI3B/Xw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k0BFBl8z;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C38F606A325;
	Tue, 10 Nov 2026 02:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k0BFBl8z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07BA71F008A2;
	Tue, 10 Nov 2026 02:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794279050;
	bh=V4BuPZ7NW9TLL+8xfWGzyH2DKRK7c1rfjhgBtZNneX8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=k0BFBl8zcd33ECWC2HjtKmbdUmGlo7G4Bqu9sRRwvbtFUAIUioMoO4JXLdDT0xjZp
	 RowSKL9DP6ksG991qVHD0bXCFj9UwIDE2rj03MvWA8S+Km4v3wZw6yNnTnode5ZoeG
	 f/nkY+f+gWu4nosoqsMqLgsVslyVqXkFwBezraEJBcghUYkxYq75iWrwAzGm6h3HjH
	 cQOObLLm9ZsLccfHSH+gPebfexjGrVbelz4Eb9Et+FMRhp0/8mByyfHdLlkf5JXTK7
	 BHdIvTj5cm9SvOLBGLxqoYyVHIYZkigGoR+wnF9GMiWoEULHyuMsCKXhWWR8iL+yUz
	 X78/Z/CQix8mw==
Date: Mon, 9 Nov 2026 18:50:48 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: James Clark <james.clark@linaro.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Jakub Brnak <jbrnak@redhat.com>, Leo Yan <leo.yan@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH v3 3/4] perf test probe_vfs_getname: Fix missing
 debuginfo detection
Message-ID: <avKGiPiE4Ag3PS33@z2>
References: <20261109-james-perf-test-fixes-v3-0-e8d0a65e618a@linaro.org>
 <20261109-james-perf-test-fixes-v3-3-e8d0a65e618a@linaro.org>
 <ecd60873-644e-4b8b-a786-ec84276a99c4@linaro.org>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ecd60873-644e-4b8b-a786-ec84276a99c4@linaro.org>

On Mon, Nov 09, 2026 at 12:11:09PM +0000, James Clark wrote:
> 
> 
> On 09/11/2026 10:17, James Clark wrote:
> > skip_if_no_debuginfo() looks for the errors that 'perf probe' prints when
> > there is no debuginfo in the output of add_probe_vfs_getname(). But since
> > commit 92b664dcefab ("perf test probe_vfs_getname: Skip if no suitable
> > line detected"), add_probe_vfs_getname() returns early without adding a
> > probe if 'perf probe -L' doesn't find the line, which is also what
> > happens when there is no debuginfo. The error from 'perf probe -L' is
> > discarded, so the debuginfo errors are never found.
> > 
> > This causes the debuginfo dependent subtests of the
> > "perftool-testsuite_probe" test to fail instead of being skipped on
> > kernels without debuginfo, because test_adding_kernel.sh calls
> > skip_if_no_debuginfo() unconditionally. The other users only call it
> > when add_probe_vfs_getname() returns 1, so they aren't affected.
> > 
> > Fix it by doing a dry run of a probe that needs debuginfo instead. This
> > works without libdw too, where 'perf probe -L' isn't available, and also
> > avoids adding a real probe just to check for debuginfo. This fixes the
> > "perftool-testsuite_probe" test:
> > 
> >    $ sudo perf test -vvv "perftool-testsuite_probe"
> >    ...
> >    -- [ FAIL ] -- perf_probe :: test_adding_kernel :: listing added probe :: perf probe -l (output regexp parsing)
> >    ...
> >    -- [ FAIL ] -- perf_probe :: test_adding_kernel :: wildcard adding support (command exitcode + output regexp parsing)
> >    ...
> >    -- [ FAIL ] -- perf_probe :: test_adding_kernel :: non-existing variable (output regexp parsing)
> >    ...
> >    ## [ FAIL ] ## perf_probe :: test_adding_kernel SUMMARY :: 3 failures found
> >    ...
> >    189: perftool-testsuite_probe : FAILED!
> > 
> > Fixes: 92b664dcefab ("perf test probe_vfs_getname: Skip if no suitable line detected")
> > Signed-off-by: James Clark <james.clark@linaro.org>
> > ---
> >   tools/perf/tests/shell/lib/probe_vfs_getname.sh | 6 +++++-
> >   1 file changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/perf/tests/shell/lib/probe_vfs_getname.sh b/tools/perf/tests/shell/lib/probe_vfs_getname.sh
> > index 57a59ae7d4ae..98cfb02cf7c6 100644
> > --- a/tools/perf/tests/shell/lib/probe_vfs_getname.sh
> > +++ b/tools/perf/tests/shell/lib/probe_vfs_getname.sh
> > @@ -64,7 +64,11 @@ add_probe_vfs_getname() {
> >   }
> >   skip_if_no_debuginfo() {
> > -	add_probe_vfs_getname -v 2>&1 | grep -E -q "^(Failed to find the path for the kernel|Debuginfo-analysis is not supported)|(file has no debug information)" && return 2
> > +	# Dry run a probe that needs debuginfo.
> > +	perf probe -n -v 'getname_flags $params' 2>&1 | grep -q \
> > +		-e "^Failed to find the path for the kernel" \
> > +		-e "^Debuginfo-analysis is not supported" \
> > +		-e "file has no debug information" && return 2
> >   	return 1
> >   }
> > 
> 
> Hi Namhyung,
> 
> This patch causes a shellcheck issue with certain versions. Not sure if you
> applied it already, but I'll send another version anyway:
> 
>   In tests/shell/./lib/probe_vfs_getname.sh line 30:
> add_probe_vfs_getname() {
> ^-- SC2120 (warning): add_probe_vfs_getname references arguments, but none
> are ever passed.

No worries, I'll pick v4.

Thanks,
Namhyung

