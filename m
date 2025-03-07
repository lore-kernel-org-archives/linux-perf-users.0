Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF79321C180;
	Fri,  7 Mar 2025 18:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741370532; cv=none; b=H5HxfYZBHRJ00ifhVh6iWml3F46M2Z8oQ4bcTVAFROF2KdVIrlmgNR76udqUyisex2q1u5Xh1KoTFQtvO039ifN+EnX5KUW59QFxBRbgPhw7suGG6il656gW3i2PNCMCRTK3Ab3dgFUhmnIY3bQa3Dnvgt9ZwDvdsv5kwFoK0E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741370532; c=relaxed/simple;
	bh=ONMHaw54/99GCB2TTuQ/7MZvX+0TYWQYXH37lMm+rfM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ike0zSBLpjE/gqi1pDsaoZYXJRD20Fsz01dLMV06T0NHwWEPjfORGz7qtjuKD/LYM2kkOTGDs1nSYyJYDRQX8FVNTos44jug7Xsg9y3HsT1SieUD+29IuXOmhLJMrWOYH1KKt5iDYhtIUGAy8GNPbdkH/vATEFfFdllQY0I0xbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gF6Qannv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gF6Qannv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED0A4C4CED1;
	Fri,  7 Mar 2025 18:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741370531;
	bh=ONMHaw54/99GCB2TTuQ/7MZvX+0TYWQYXH37lMm+rfM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gF6Qannvn5Qb8FcLUHOEJI2syFuFiyF1laXvq+SpDsojgfKRsCSTjgKv9Kk32PzCz
	 OrlKJWaEs561K3k7RavDlYrI4IGxw60K4lDAtwNCBqe8QGrKOIJakksBNQAVVX+9UY
	 fE2WiA6EDagnhPg0zrszO2WbPSVGrkgXH+aPJNcyxE0pAUpN+Xam7YNQiPyGWUVx6A
	 H8PMDpJzlNmoTwY+uD01B/Jd6GIlF+1cFA8uhDQaJ9PNzO3uHYSQYNz1qKp3wXIwGs
	 oW+ocCVytjM3392MOP+IO3qxCXGUDs6EPvgit3RCIur3x8LVgLX+u40r3HlIGx7PA8
	 M6irJBzHQYkCw==
Date: Fri, 7 Mar 2025 10:02:09 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: James Clark <james.clark@linaro.org>
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v1] perf tests: Fix data symbol test with LTO builds
Message-ID: <Z8s0oQw3dxC11Ea2@google.com>
References: <20250226230109.314580-1-irogers@google.com>
 <CAP-5=fUN7=cQ9X10tH1qpmzpJoSoqHH5CV5MVwhqXkQ8vkbwoA@mail.gmail.com>
 <ac1350fd-ef8d-485c-ab70-b38a3ffe9b87@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ac1350fd-ef8d-485c-ab70-b38a3ffe9b87@linaro.org>

Hello,

On Thu, Feb 27, 2025 at 10:35:30AM +0000, James Clark wrote:
> 
> 
> On 27/02/2025 5:42 am, Ian Rogers wrote:
> > On Wed, Feb 26, 2025 at 3:01 PM Ian Rogers <irogers@google.com> wrote:
> > > 
> > > With LTO builds, although regular builds could also see this as
> > > all the code is in one file, the datasym workload can realize the
> > > buf1.reserved data is never accessed. The compiler moves the
> > > variable to bss and only keeps the data1 and data2 parts as
> > > separate variables. This causes the symbol check to fail in the
> > > test. Make the variable volatile to disable the more aggressive
> > > optimization. Rename the variable to make which buf1 in perf is
> > > being referred to.
> > > 
> > > Before:
> > > ```
> > > $ perf test -vv "data symbol"
> > > 126: Test data symbol:
> > > --- start ---
> > > test child forked, pid 299808
> > > perf does not have symbol 'buf1'
> > > perf is missing symbols - skipping test
> > > ---- end(-2) ----
> > > 126: Test data symbol                                                : Skip
> > > $ nm perf|grep buf1
> > > 0000000000a5fa40 b buf1.0
> > > 0000000000a5fa48 b buf1.1
> > > ```
> > > 
> > > After:
> > > ```
> > > $ nm perf|grep buf1
> > > 0000000000a53a00 d buf1
> > > $ perf test -vv "data symbol"126: Test data symbol:
> > > --- start ---
> > > test child forked, pid 302166
> > >   a53a00-a53a39 l buf1
> > > perf does have symbol 'buf1'
> > > Recording workload...
> > > Waiting for "perf record has started" message
> > > OK
> > > Cleaning up files...
> > > ---- end(0) ----
> > > 126: Test data symbol                                                : Ok
> > > ```
> > > 
> > > Fixes: 3dfc01fe9d12 ("perf test: Add 'datasym' test workload")
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> > 
> > Ah, I see we're trying to force -O0 and -fno-inline in the Makefile
> > (git.kernel.org is giving 403s):
> > https://github.com/torvalds/linux/blob/master/tools/perf/tests/workloads/Build#L11
> > Which LTO later undoes. I'm not seeing LTO breakages for brstack.c and
> > the shell test "Check branch stack sampling". I think LTO is able to
> > optimize this case as it is a variable/struct being optimized, so the
> > "-O0" and "-fno-inline" mustn't be being made to apply. Not a wholly
> > satisfactory reason to add the volatile, but I'm short on
> > alternatives.
> > 
> > Thanks,
> > Ian
> > 
> > 
> > 
> 
> Adding -fno-lto to that file works for me (llvm-15):
> 
>   CFLAGS_datasym.o          = -fno-lto -g -O0 -fno-inline ...
> 
> In fact it looks like we should add this to everywhere we're already doing
> -g and -O0. If lto is just another form of optimisation it should be
> disabled as well.
 
Make sense.  But it turned out that disabling LTO caused some subtle
troubles in my work environment unfortunately. :(

Adding 'volatile' seems to be a simple and reasonable alternative and
I agree with the renaming.

Thanks,
Namhyung

