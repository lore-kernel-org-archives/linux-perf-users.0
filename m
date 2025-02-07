Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27121D90DB;
	Fri,  7 Feb 2025 03:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738900627; cv=none; b=ncDYBfIWxGo7F2D/5WPlU61JbZGI5XzA9IIAb0cEC+tfgxbTwLMmr7iRQ7wXsbwD3BcFEWy/L8TO4FYuajIu30vuapsJ8HcIafy8RuQfnzokNqRlUOiyYCQc9YMr4ioc2C/tXVZaNbJH/BOT22/RPONFodpoTon4sTxlUCnw+dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738900627; c=relaxed/simple;
	bh=NCkjgWm0IBctfXMDtWxGTmY1UTxXS+wCSGlCXvRBNHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HwWy3+r1M/MxLQIpOu9B9Io6TeisW8c0LaCvJblfqt4zP1X5tAEp3WLhZBQ7tzJyGghVrMTMwrdTTtxa3K5zDxtkaUONws8Dv/LNSQkru5lrMe0ahL/nKQfF/jRePpEP9rTIls3e3NtjjFg/QZnzxKrhbEqp+fMF7XTwismZ9y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ouFoUmLp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ouFoUmLp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8485BC4CED1;
	Fri,  7 Feb 2025 03:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738900627;
	bh=NCkjgWm0IBctfXMDtWxGTmY1UTxXS+wCSGlCXvRBNHw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ouFoUmLpbYsuL+rQdOo4X8/TnCZ1KQ+39cpiKlfjvEBXLtxOX9GimfB6bzTh/IFaN
	 1wEFY7BvZvHBy3yHmZ4AihcvebaI9/pi7ipJWlhiPcCQdOSskSAG7s3zRhbsPbwxVn
	 z+85Sw3PSAyW35tHtpW6Rs63GOU0nx1UGr2Uu5VXaM85WrVEqzMfiPLXqdpduvwrfq
	 EGkRunvq1F3VjbDFWoiFo6gdHFmr0Wtpk0bQjpi6IlfIzkxF3Y9J6SY9ybXxz+WQ/j
	 164Buhky2eIreCa3aYzAszFHAjcGLbLOEry+PR8jOblIiTfhmJrZt5AwJQQxc6EYTF
	 0a2GeTuS618mw==
Date: Thu, 6 Feb 2025 19:57:04 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Dmitry Vyukov <dvyukov@google.com>, Andi Kleen <ak@linux.intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH v5 0/8] perf report: Add latency and parallelism profiling
Message-ID: <Z6WEkAPxtpVmx8cO@google.com>
References: <cover.1738772628.git.dvyukov@google.com>
 <87ldujkjsi.fsf@linux.intel.com>
 <CACT4Y+aVWH6d7kuxzvcJSarXMQB-PPDTcE5OvN2tjkOLnzmMLg@mail.gmail.com>
 <CAP-5=fUxY1KYXN-HcJPd2D66j5cC6DFTGPzYFVvJKvBLqyz6-Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUxY1KYXN-HcJPd2D66j5cC6DFTGPzYFVvJKvBLqyz6-Q@mail.gmail.com>

On Thu, Feb 06, 2025 at 10:51:16AM -0800, Ian Rogers wrote:
> On Thu, Feb 6, 2025 at 10:41 AM Dmitry Vyukov <dvyukov@google.com> wrote:
> > On Thu, 6 Feb 2025 at 19:30, Andi Kleen <ak@linux.intel.com> wrote:
> [snip]
> > > We traditionally didn't do it, but in general test coverage
> > > of perf report is too low, so I would recommend to add some simple
> > > test case in the perf test scripts.
> >
> > What of this is testable within the current testing framework?
> > Also how do I run tests? I failed to figure it out.
> 
> Often just having a test that ensure a command doesn't segfault is
> progress :-) The shell tests Andi mentions are here:
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/tests/shell?h=perf-tools-next
> There's no explicit `perf report` test there but maybe the annotate,
> diff or record tests could give you some ideas.

Well, we have. :)

  $ ./perf test -vv report
  116: perftool-testsuite_report:
  --- start ---
  test child forked, pid 109653
  -- [ PASS ] -- perf_report :: setup :: prepare the perf.data file
  ## [ PASS ] ## perf_report :: setup SUMMARY
  -- [ SKIP ] -- perf_report :: test_basic :: help message :: testcase skipped
  -- [ PASS ] -- perf_report :: test_basic :: basic execution
  -- [ PASS ] -- perf_report :: test_basic :: number of samples
  -- [ PASS ] -- perf_report :: test_basic :: header
  -- [ PASS ] -- perf_report :: test_basic :: header timestamp
  -- [ PASS ] -- perf_report :: test_basic :: show CPU utilization
  -- [ PASS ] -- perf_report :: test_basic :: pid
  -- [ PASS ] -- perf_report :: test_basic :: non-existing symbol
  -- [ PASS ] -- perf_report :: test_basic :: symbol filter
  ## [ PASS ] ## perf_report :: test_basic SUMMARY
  ---- end(0) ----
  116: perftool-testsuite_report                                       : Ok

Thanks,
Namhyung

