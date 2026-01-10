Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46F312B93;
	Sat, 10 Jan 2026 00:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768004808; cv=none; b=FYewfsVMOpkk+tYOeab5K77XFz4QHWHUunYy4JhGamF3mRsS05B0JKO5T6cGrsnzf9/v9ItUrsIqAKQ7IebMXaQUjou7hLujtQ6bpwhMsZGZZ6Lp4jLz8mzqWcZNCqIA/rH9gS88yWNChvtFVL57odazYNZfbhRbzaMN5UhEl0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768004808; c=relaxed/simple;
	bh=/sKiopJ2tfHiOMGT3D41kWUZpy9iLFf0tD5sLu9C5Ss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bpUQ5cbg29gHb7Lu5q1Fq7Fk8C3CAqt+0YNDOgAfqL1ChP8PRygtabqlcJ9SJVoOKvR3FyezpUAKc63IMUzz7WE2SY9btecY+l3KHAB+6IZV45CX1jnWBoEY3pOJAvwOhRqaM13FsQtX1kaGusG9tWfEkK+OA4GSLOMi/JEfw/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yl5V4fDS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yl5V4fDS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB838C4CEF1;
	Sat, 10 Jan 2026 00:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768004808;
	bh=/sKiopJ2tfHiOMGT3D41kWUZpy9iLFf0tD5sLu9C5Ss=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Yl5V4fDSB6q6Q0Lv8l4ZkDRRkMEdVpcExHGFiJloRtlynQYHBPy/jfgwUPnV9BgOq
	 fOIdciqyGfQDP+stVjN08O19J4yewE2FWLZrwYjo5v28VsGKBtO/iUUfuuZuaYG/H9
	 mCTL4/xQmTFyfIlp2Ea0tCOpNwPHCZ9opXTyu2+tuCQfsLzHgkv1YyZNTQ/Yg4n3bL
	 vt1CyAVF5dfQu6P9DGQrFQUOFF2RMbrUIWkhgjv2c5J1L9OFwIrZphUfuRm4OABLsJ
	 1fzFszzSEatj5qFF1Q69+xrWsB482DubnFJfRzLHvGK5eFcNyrA6UMBi0XishuWaHL
	 PqUF+E37KsTSA==
Date: Fri, 9 Jan 2026 16:26:46 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 3/4] perf test: Do not skip when some metrics tests
 succeeded
Message-ID: <aWGcxpQXZZH5znwq@google.com>
References: <20251219011820.2505506-1-namhyung@kernel.org>
 <20251219011820.2505506-3-namhyung@kernel.org>
 <CAP-5=fVDYu+GLspYQNEHk7_X8-FE-OaEF0OaG+vfWrrYH9ZcoQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVDYu+GLspYQNEHk7_X8-FE-OaEF0OaG+vfWrrYH9ZcoQ@mail.gmail.com>

Hi Ian,

On Fri, Jan 09, 2026 at 03:37:01PM -0800, Ian Rogers wrote:
> On Thu, Dec 18, 2025 at 5:18 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > I think the return value of SKIP (2) should be used when it skipped the
> > entire test suite rather than a few of them.  While the FAIL should be
> > reserved if any of test failed.
> 
> This doesn't make sense to me. The current behavior is to set err to 0
> (success):
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/tests/shell/stat_all_metrics.sh?h=perf-tools-next#n18
> If a failure condition occurs then err is set to 1 (fail)
> unconditionally as you can't be more failing than failing, like:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/tests/shell/stat_all_metrics.sh?h=perf-tools-next#n38
> If a skip condition is encountered then we set err to 2 (skip)
> conditional on the err state only being currently 0 (success) - ie
> don't turn a fail into a skip:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/tests/shell/stat_all_metrics.sh?h=perf-tools-next#n45
> 
> All metrics are always tested by test, so I'm not sure what "entire
> test suite" means. The test should report success if nothing skips or
> fails, skip if something skips and there are no failures, and
> otherwise failure.

We have different ideas for the return values. :)  I think it should
report SKIP if it cannot test anything, FAILURE if anything fails and
otherwise SUCCESS.

So the gray area is when some subtests succeed and some skip (and no
failures).  It'd be great if we can agree on one way or another.

> 
> I can see the test being simplified by having a failure flag and a
> skip flag, then determining the 0, 1 or 2 value from these two flags.
> It would be avoiding testing the err value when setting it to 2
> (skip), but the change here isn't doing that. The change introduces a
> new value of 3, which seems more complex, and the skip flag is set
> depending on the global err value rather than just being a sticky flag
> showing a metric failed.

3 is not supposed to return, but I think it'd be nice if we can do
without introducing it.

Thanks,
Namhyung

