Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7BB3074AC;
	Wed, 25 Jun 2025 17:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750873003; cv=none; b=RNTPeXekkfd+NPCvBdVZMJJldKTnB+kQMGRKvKrdH80EzmfDD9jZrFCHnAZ8eI41bVfDeuuLtRa3Lg4WKAsHkdfMTWXY+4LWKW4xsmjIqDyqjJpBzNBA9uuWF3p3WymEDmtAUp1SmCPnU9dlP945OSHOVxsHfoHE/mPoEykln8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750873003; c=relaxed/simple;
	bh=gKQBdwJfQOB2p6uspPogmrdt5HwcLRxI66qJ/qBEOe4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aPRJUFpBOf1DdixQAeUEA0gSWYHZGMr8bQfJSQLRvYGnbQa8kEXSjyFh20p4EWtmvtVTx/CLMddCb1OP98qt6lpxBuAlWPsKxKEpLXRLWQP1gqnu9g8qIAueAtusDyyWVREMDHI6bOUsrCMDO8CnS0Dxi5ZOk9/zNSzlGd5OI04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AuRqKfOJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AuRqKfOJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D204C4CEF1;
	Wed, 25 Jun 2025 17:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750873001;
	bh=gKQBdwJfQOB2p6uspPogmrdt5HwcLRxI66qJ/qBEOe4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AuRqKfOJJaH50ehgc/l//svX8sTekT1bzr88nifM3ga5e8IPMu+JVw7u0sqXF5Gqm
	 lh0my4AebDei+oEIVrOPRmPD/NuADfZqTm470g25GpxNCH/vg5SrSSqPY4GL2Tdtsk
	 KhpPchd5jFUkce8UqJ5x8qAi4zF7cyZBu8CIFBb28LRVehf7/ApJep0UgQ1vbH3jQ0
	 Pkm7qmno6UFj+HxxUeslXd5FECGrsANSsSAYCJwYx+IVF5wH7oD4edKUZLdeBZ/rz0
	 ech7lPSx2lhmf6xnq5zEW/nBs/SCobF6ovcGQlRUuJT+qLcgulLfnKYmjyT8PUiQRP
	 4+rrK3W3KjF+g==
Date: Wed, 25 Jun 2025 10:36:38 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
	lkp@intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [linux-next:master] [perf target] 5ddf4c3a17:
 perf-sanity-tests.perf_record_tests.fail
Message-ID: <aFwzpkvXcJiFFmHX@google.com>
References: <202506251422.589f230a-lkp@intel.com>
 <CAP-5=fU6hxJp7NhnQ4zDv6xdSfue9xyRhznp62=OxKLjok8UAA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fU6hxJp7NhnQ4zDv6xdSfue9xyRhznp62=OxKLjok8UAA@mail.gmail.com>

Hello,

On Wed, Jun 25, 2025 at 07:59:16AM -0700, Ian Rogers wrote:
> On Wed, Jun 25, 2025 at 12:10 AM kernel test robot
> <oliver.sang@intel.com> wrote:
> >
> >
> >
> > Hello,
> >
> > kernel test robot noticed "perf-sanity-tests.perf_record_tests.fail" on:
> >
> > commit: 5ddf4c3a17dc499fcbaf35692bc894340062dee8 ("perf target: Separate parse_uid into its own function")
> > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> >
> > [test failed on linux-next/master f817b6dd2b62d921a6cdc0a3ac599cd1851f343c]
> >
> > in testcase: perf-sanity-tests
> > version:
> > with following parameters:
> >
> >         perf_compiler: clang
> >         group: group-02
> >
> >
> > config: x86_64-rhel-9.4-bpf
> > compiler: gcc-12
> > test machine: 8 threads 1 sockets Intel(R) Core(TM) i7-7700 CPU @ 3.60GHz (Kaby Lake) with 32G memory
> >
> > (please refer to attached dmesg/kmsg for entire log/backtrace)
> >
> >
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <oliver.sang@intel.com>
> > | Closes: https://lore.kernel.org/oe-lkp/202506251422.589f230a-lkp@intel.com
> >
> >
> > 2025-06-22 14:23:54 sudo /usr/src/linux-perf-x86_64-rhel-9.4-bpf-5ddf4c3a17dc499fcbaf35692bc894340062dee8/tools/perf/perf test 126 -v
> > 126: perf record tests                                               : Running (1 active)
> > --- start ---
> > test child forked, pid 8698
> >  13bca6c-13bcaa5 g test_loop
> > perf does have symbol 'test_loop'
> > Basic --per-thread mode test
> > Per-thread record [Skipped event not supported]
> > Register capture test
> > Register capture test [Failed missing output]
> 
> Register capturing is different functionality to UID filtering.

Right.

> 
> > Basic --system-wide mode test
> > System-wide record [Skipped not supported]
> > Basic target workload test
> > Workload record [Failed record]
> 
> Something seems off, possibly something to do with permissions here.

Yeah, not sure what happended here.

> 
> > Branch counter test
> > branch counter feature not supported on all core PMUs (/sys/bus/event_source/devices/cpu) [Skipped]
> > Cgroup sampling test
> > Cgroup sampling [Skipped not supported]
> > Basic leader sampling test
> > Leader sampling [Failed record]
> 
> And here.
> 
> I suspect this was a test machine issue although later patches do add
> UID filtering tests to this test. I don't see anything actionable
> here.

I agree that none of these failures related to UID filtering.
But it seems leader sampling test is using 'cycles' events without
checking its availability.  So it'll fail on VMs that don't expose HW
PMUs.

Thanks,
Namhyung

> 
> > Topdown leader sampling test
> > Topdown leader sampling [Skipped event parsing failed]
> > precise_max attribute test
> > precise_max attribute [Skipped no cycles:P event]
> > precise_max attribute [Skipped no instructions:P event]
> > precise_max attribute [Skipped no hardware events]
> > ---- end(-1) ----
> > 126: perf record tests                                               : FAILED!
> >
> >
> > The kernel config and materials to reproduce are available at:
> > https://download.01.org/0day-ci/archive/20250625/202506251422.589f230a-lkp@intel.com
> >
> >
> >
> > --
> > 0-DAY CI Kernel Test Service
> > https://github.com/intel/lkp-tests/wiki
> >
