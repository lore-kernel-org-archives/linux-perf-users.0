Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81093224FA;
	Wed, 30 Apr 2025 23:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746056390; cv=none; b=czVqSbXrVj8i1EKVIjQ4LZXzylDbaiVH5HOxLpnsIczulhTWsLz/ayTZN6F71KBCp/t7ycyIxUpoYACeg3WWVVmkQMWnCvHB29bSYcbfFEhQSuznI0w60TUnfpkcTSULXMWiQipL29fs6njQeQ6ArsAgv0Sr6n6mYeFfuJ3tmYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746056390; c=relaxed/simple;
	bh=q0/1FCqesPJ0uv8M8Mu9vFgEJRoRAee9ysk85//yWiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Woz6e59ITCNUkLAZEYj4CAlsskcHnqjU83UDVAAxGlzu8ys8yHgK5Z2cAmn2dzRD+wGI3b7MUHXyY6c0LqqjHRb8FTcZVoKYcXLM2dVKGY3m/BGXYYTuCPom7e9HpevBEpg5HeDrdLxC4TSL9qGBlv3VxNVOWJBW8nuTtuhC/x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jZoWLz8L; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jZoWLz8L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96692C4CEE9;
	Wed, 30 Apr 2025 23:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746056390;
	bh=q0/1FCqesPJ0uv8M8Mu9vFgEJRoRAee9ysk85//yWiE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jZoWLz8LrFd1jOhL+1AaM7UTAzy1f9wIi9x7SfcAU+ZuMPT7nMur55BHf2mh5N6fV
	 +38CM69pZPeGZWBiH4uJqPcIeNiLhqz/E5bzpGik5WCMXlEqh+U7cmMSadBTQP5Dx5
	 tuKMLATcTefvwgx8zO7vpX6CI//W142y/f4koP5CmhMDpcSkn768QOE9fvImcoq3hh
	 j3IrJcW+Ji83QzhPDO5nQvZ4Med1ZpnqA0IhW+nxHz2K3prB2t1oeo3e/L4R0++GsA
	 4FNsQ0T+vr9czxEvRC90a6bq9wudG3rnigYt7XqfH6kOmG+hmYf+ZJBv8zT9WHONA0
	 Nw6Zddiwt0cLw==
Date: Wed, 30 Apr 2025 20:39:47 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Joe Mario <jmario@redhat.com>,
	Stephane Eranian <eranian@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"Shukla, Santosh" <santosh.shukla@amd.com>,
	Ananth Narayan <ananth.narayan@amd.com>,
	Sandipan Das <sandipan.das@amd.com>
Subject: Re: [PATCH v4 4/4] perf test amd ibs: Add sample period unit test
Message-ID: <aBK0wz2QENx9qQEz@x1>
References: <20250429035938.1301-1-ravi.bangoria@amd.com>
 <20250429035938.1301-5-ravi.bangoria@amd.com>
 <aBE8raTOCVZLfw7J@x1>
 <aBF5UWrxvYgbnxde@x1>
 <aBF7ZarWJvzeDKqF@x1>
 <4bea7b8a-9ff5-4ae9-8154-57ec7377ee4e@amd.com>
 <aBIgVi90Zinz6Rl4@x1>
 <aBImI03VHeJSGVfn@x1>
 <09f5d37b-0ef8-4cc5-bf60-172c448ff9c7@amd.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09f5d37b-0ef8-4cc5-bf60-172c448ff9c7@amd.com>

On Wed, Apr 30, 2025 at 09:37:22PM +0530, Ravi Bangoria wrote:
> Hi Arnaldo,
> 
> > root@number:/home/acme/git/linux# perf test -vvv ibs
> >  73: AMD IBS via core pmu:
> > --- start ---
> > test child forked, pid 10047
> > Using CPUID AuthenticAMD-26-44-0
> > type: 0x0, config: 0x0, fd: 3  -  Pass
> > type: 0x0, config: 0x1, fd: -1  -  Pass
> > type: 0x4, config: 0x76, fd: 3  -  Pass
> > type: 0x4, config: 0xc1, fd: 3  -  Pass
> > type: 0x4, config: 0x12, fd: -1  -  Pass
> > ---- end(0) ----
> >  73: AMD IBS via core pmu                                            : Ok
> > root@number:/home/acme/git/linux#
> 
> It picks up both the IBS tests for me. (Is that what you mean?)
> 
>   $ sudo ./perf test ibs
>    73: AMD IBS via core pmu                                            : Ok
>   112: AMD IBS sample period                                           : Ok
> 
>   $ ./perf --version
>   perf version 6.15.rc2.g35db59fa8ea2

Are there two? I probably tested it with just the first patch on your
series applied, lemme see...

The second takes quite a while to finish :)

root@number:/# perf test ibs
 73: AMD IBS via core pmu                                            : Ok
112: AMD IBS sample period                                           : Ok
root@number:/#


root@number:/# perf stat --null perf test 73
 73: AMD IBS via core pmu                                            : Ok

 Performance counter stats for 'perf test 73':

       0.018951061 seconds time elapsed

       0.004640000 seconds user
       0.005627000 seconds sys


root@number:/# perf stat --null perf test 112
112: AMD IBS sample period                                           : Ok

 Performance counter stats for 'perf test 112':

      17.888279280 seconds time elapsed

       1.539229000 seconds user
      16.325610000 seconds sys


root@number:/#

But yeah, both are passing on this 9950x3d.

- Arnaldo
