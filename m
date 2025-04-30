Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D54C1EB5B;
	Wed, 30 Apr 2025 13:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746019878; cv=none; b=gR/9rhNAUAcYm33mdIevTc681yT6XxD0vE+dAsJ8YQuUxRoi3GJUBTFrZgvPk+VDhd5sCjxJfZ+2h7RTdI3eOVIjTpJ2w4/W4ewOpkLLOl7uMdqA/Y85ja+lTwezw5Hxh26rfzYGT921j/VDMdno3u7rXsLDbtOehgCPtDdSsQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746019878; c=relaxed/simple;
	bh=e7zLQ4MhNgacuvAx29eWeq+/mRcxeSiifnlvJMe2CRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SzSz04Pg98zEs4HvFqiMPdrwYbseatHSsElmC7VeYOskJ3FCGDi8Q6olv3Eh1mU1auXm/P9mYXBAo2ZgEulKBNjBJxSr9L48GCBrAbxk9ueglhwmRC6qZh3jgzC/iHgzBTeO2yVxr4C8iOMFwk8/juVmpbj+SEHKsffo3EGwst8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SEhjsrDy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SEhjsrDy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD0F9C4CEE9;
	Wed, 30 Apr 2025 13:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746019878;
	bh=e7zLQ4MhNgacuvAx29eWeq+/mRcxeSiifnlvJMe2CRU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SEhjsrDyZpeASA4t096xdul5jnZV4nx1dPUovPg2ESUQoX7HNDbu8YN93QNG83cAd
	 Q3Ui/2o0FNvdXbpPVndQM45878qS7zEFgW0/PYVwjNUYrvGzfqV4nHkUeLMSt/SAWF
	 czA25qwuAPbNgGdQgGEclRLFk4nxtMiFyaghuDdZbFJkxr2jW2vh/VjMK+3z0cIDFY
	 p15AeeWPxQBkeCPx/mHXWigv/yAZ1ygzbar+OWeAJFVF+UYrGB5lxrh2YGDMmuzbxt
	 XVy0HCKZN8NM+fScQ2Sc4gY/scM3uBhpk3pbry5OvuYGCWK70BDe1RiFwocpccQQdW
	 1FoMcyEnWRavw==
Date: Wed, 30 Apr 2025 10:31:15 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Joe Mario <jmario@redhat.com>,
	Stephane Eranian <eranian@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Santosh Shukla <santosh.shukla@amd.com>,
	Ananth Narayan <ananth.narayan@amd.com>,
	Sandipan Das <sandipan.das@amd.com>
Subject: Re: [PATCH v4 4/4] perf test amd ibs: Add sample period unit test
Message-ID: <aBImI03VHeJSGVfn@x1>
References: <20250429035938.1301-1-ravi.bangoria@amd.com>
 <20250429035938.1301-5-ravi.bangoria@amd.com>
 <aBE8raTOCVZLfw7J@x1>
 <aBF5UWrxvYgbnxde@x1>
 <aBF7ZarWJvzeDKqF@x1>
 <4bea7b8a-9ff5-4ae9-8154-57ec7377ee4e@amd.com>
 <aBIgVi90Zinz6Rl4@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBIgVi90Zinz6Rl4@x1>

On Wed, Apr 30, 2025 at 10:06:33AM -0300, Arnaldo Carvalho de Melo wrote:
> On Wed, Apr 30, 2025 at 02:32:12PM +0530, Ravi Bangoria wrote:
> > On 30-Apr-25 6:52 AM, Arnaldo Carvalho de Melo wrote:
> > > On Tue, Apr 29, 2025 at 10:13:53PM -0300, Arnaldo Carvalho de Melo wrote:
> > >> Adding the patch below cures it, still need to test on a Zen 5 system.
> 
> > >> These issues were just in the regression test.
>  
> > > BTW, all is at the tmp.perf-tools-next branch at:
>  
> > > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git
> 
> > I tested with few simple perf mem/c2c commands and it seems to be working
> > fine.
> 
> Thanks for checking!
> 

BTW:

root@number:/home/acme/git/linux# perf test -vvv ibs
 73: AMD IBS via core pmu:
--- start ---
test child forked, pid 10047
Using CPUID AuthenticAMD-26-44-0
type: 0x0, config: 0x0, fd: 3  -  Pass
type: 0x0, config: 0x1, fd: -1  -  Pass
type: 0x4, config: 0x76, fd: 3  -  Pass
type: 0x4, config: 0xc1, fd: 3  -  Pass
type: 0x4, config: 0x12, fd: -1  -  Pass
---- end(0) ----
 73: AMD IBS via core pmu                                            : Ok
root@number:/home/acme/git/linux#

- Arnaldo
