Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DDE81DD877
	for <linux-perf-users@vger.kernel.org>; Fri, 23 Jan 2026 16:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769185795; cv=none; b=u4R3jyPmQZ3DkmspFuOxcZ+19YI7knrAEZjlCi0nvcpa6cpX8fJU7xyD6v/rTMVwEZ6TRYDDsBbFdlbeXM6NAMbu2FM9dpF6M0TF+dLonRFP17oHpUHfPXvXHPSAMgx7E+icplBAXuZn/O/B5sYgoC3LUVfmXeINZxfMaAc2G1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769185795; c=relaxed/simple;
	bh=bf+hVo1BUIrjFf4pFGzOm14CARV3+i628QdtJ3ev5G8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u0kKGrGO7QiHUscYtChh6dHbcFf1Tqsog1XsdWfhDxK40btdQKyibWIcTZskSJ9EFdw2sNB1PZgDAhGVy0S9F1gGGgCJiO8ERlsoJLw/8/P4F9gu3yiU3SFhlmsa1SriPT2zB2PlxoQrsYQzknh5dsMmri4O9uKv397LFPYERM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jdNkbKXH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jdNkbKXH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B443C4CEF1;
	Fri, 23 Jan 2026 16:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769185794;
	bh=bf+hVo1BUIrjFf4pFGzOm14CARV3+i628QdtJ3ev5G8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jdNkbKXHDdDYNcQGCEs3AojAb9D9u+vqmeJaa2YQUiclQv5HwjYJJSAQ20pijlQsq
	 RXp5jI25pPS7Eyx4sahLxwObnjVQnz25Lfqk5vKbeBKvO4kMpJPLKrg+NaJ35sceYU
	 sr6icnxccQnFIwN1PIsT3lXtKlW2l1bKcL+RHYSBSv8UCnuWFjp3bw0VswnqaLgpoS
	 /LfOyEvYnsM07w+ukCVietFtRv9bjJoPmp7MGcDVCVBgqWjzrBFMLB1UDUQ8/DGxi2
	 P0clqFgmXR3w9ALwt60Oektdn08Xn2dPvwa8jCJ4/KKD6ZfuZQ/U9WHc406i6++n5Y
	 7rI5fD2f+S0lA==
Date: Fri, 23 Jan 2026 13:29:51 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Michael Petlan <mpetlan@redhat.com>
Cc: Jakub Brnak <jbrnak@redhat.com>, acme@redhat.com,
	linux-perf-users@vger.kernel.org, namhyung@kernel.org,
	irogers@google.com
Subject: Re: [PATCH v5 0/7] Introduce structure for shell tests
Message-ID: <aXOh_4oN9P_Sxo8t@x1>
References: <20251125155648.197527-1-jbrnak@redhat.com>
 <a5f59c64-0da-6928-7a9-c5b6c2be8ef8@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5f59c64-0da-6928-7a9-c5b6c2be8ef8@redhat.com>

On Fri, Jan 23, 2026 at 03:26:54PM +0100, Michael Petlan wrote:
> Hello Ian and Namhyung,
> 
> kindly reminding this patchset. Could we get it merged soon please?
> Or is there still anything to address?
> 
> Thanks in advance!

Just test applied and it went cleanly, will try to review it after
lunch.

- Arnaldo
 
> Regards,
> Michael
> 
> On Tue, 25 Nov 2025, Jakub Brnak wrote:
> > Hi maintainers,
> > 
> > This revision of series of patches continues the effort of upstreaming a perftool-testsuite and 
> > incorporates the review feedback that was previously discussed.
> > A new patch (7/7) was added to fix the incorrect relative path for locating stderr-whitelist.txt 
> > in report tests.
> > 
> > Thanks,
> > Jakub
> > 
> > Link to v4: https://lore.kernel.org/linux-perf-users/20250930160923.13728-1-jbrnak@redhat.com/#t
> > 
> > Changes since v4:
> > Patch 1: applied review feedback, renamed shell_info -> shell_test_info, minor cleanups
> > Patch 2: renamed shell_info -> shell_test_info
> > Patch 4: renamed shell_info -> shell_test_info
> > Patch 7: added in v5, fix for relative path to 
> > stderr-whitelist.txt in report tests
> > 
> > Jakub Brnak (7):
> >   perf tests: Create a structure for shell tests
> >   perf test: Provide setup for the shell test suite
> >   perftool-testsuite: Add empty setup for base_probe
> >   perf test: Introduce storing logs for shell tests
> >   perf test: Format log directories for shell tests
> >   perf test: Remove perftool drivers
> >   perf test: Fix relative path for 'stderr-whitelist.txt'
> > 
> >  tools/perf/tests/builtin-test.c               | 129 +++++++-
> >  tools/perf/tests/shell/base_probe/setup.sh    |  13 +
> >  .../tests/shell/base_report/test_basic.sh     |   6 +-
> >  .../tests/shell/perftool-testsuite_probe.sh   |  24 --
> >  .../tests/shell/perftool-testsuite_report.sh  |  23 --
> >  tools/perf/tests/tests-scripts.c              | 288 +++++++++++++++---
> >  tools/perf/tests/tests-scripts.h              |  15 +
> >  tools/perf/tests/tests.h                      |   8 +-
> >  8 files changed, 398 insertions(+), 108 deletions(-)
> >  create mode 100755 tools/perf/tests/shell/base_probe/setup.sh
> >  delete mode 100755 tools/perf/tests/shell/perftool-testsuite_probe.sh
> >  delete mode 100755 tools/perf/tests/shell/perftool-testsuite_report.sh
> > 
> > -- 
> > 2.51.1
> > 
> > 
