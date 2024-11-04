Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9166C1ABEBA;
	Mon,  4 Nov 2024 23:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730763281; cv=none; b=sXLZX/0FPl8O/YjElJiXz2JIe+SIium/TIzrp692EqWeDYgkaMJEMgAcNmgqPsPYYA65SDgTy+rqcTPc7o6dJGGh2rVYz3SFJ5pCGFPPXribnT5zzlSsbP5uI0oQfcboFHyfFoeDBZFXCwLyUM5Gj5VSycCETbn2eJw//YdVVKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730763281; c=relaxed/simple;
	bh=88TYumyhWbfjVMyfSLi2/8DI4JnQwU62uhhbbbI3EPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yj9tANpXxwYx0kslX3PhSF7smrVsE4agwDFo9q13yIgEK6PCG86KQtF0gA9i9OyCG/6EMSBr6M423cmhTAGJJ30+o1sS4O6d66rVm2/4XOGsvMqJd+tctCRzm+QiQ1opYxzElNKdXKjw3CPW3/46KAnF4oNu4EETEmdY04FpjkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bk2WE9bR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bk2WE9bR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5FDCC4CED1;
	Mon,  4 Nov 2024 23:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730763280;
	bh=88TYumyhWbfjVMyfSLi2/8DI4JnQwU62uhhbbbI3EPc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bk2WE9bRtabX0pG/dgRccsTHBgk3EKcHrehNbj5h74YnMHZlwsGo6fKaH2m0wXp3k
	 iE6KH+DZpT5uYmvB2VIz1m03obmFmHmkhfyYiwZ9rYD07lTh4eW+BFFwppXdOKnxLt
	 5AnTsWLqxlW1sjxaiQ8JU638m/VdU11GB5DrKh6pj3QWgeZrDKj7zTtosRmTxpy0Fy
	 RIIeVGYc3DP2GIRJ5xeOZKGa0f8VmGlLKgwWlLZIuOCYhlTNFUbX1WimsV/6oNZ/r+
	 MdytaQ1+UQix5E25D6/Hi6ryDchy3Fwhno1axOeFEVqRn2b4Iho2RoLkO1OSUKNbe4
	 uWTSuW+7cv2jw==
Date: Mon, 4 Nov 2024 15:34:38 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf test: Fix LBR test by adding indirect calls
Message-ID: <ZylaDu6NjJIq6rUf@google.com>
References: <20241103002414.2281869-1-namhyung@kernel.org>
 <CAP-5=fUg-DFKM4SQa7P2fWRd62y7kDiP+qP2kP-TiZMy2EX7mQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUg-DFKM4SQa7P2fWRd62y7kDiP+qP2kP-TiZMy2EX7mQ@mail.gmail.com>

On Sat, Nov 02, 2024 at 09:58:03PM -0700, Ian Rogers wrote:
> On Sat, Nov 2, 2024 at 5:24 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > I've noticed sometimes perf record LBR tests failed on indirect call
> > test because it has empty branch stacks more than expected.
> >
> > The test workload (thloop) spawns a thread and calls a loop function for
> > 1 second both from the main thread and the new thread.  However neither
> > of them has indirect calls in the body so it ended up with empty branch
> > stacks.
> >
> >   LBR any indirect call test
> >   [ perf record: Woken up 21 times to write data ]
> >   [ perf record: Captured and wrote 5.607 MB /tmp/__perf_test.perf.data.pujKd (7924 samples) ]
> >   LBR any indirect call test: 7924 samples
> >   LBR any indirect call test [Failed empty br stack ratio exceed 2%: 3%]
> >
> > Refactor the test workload to call the test_loop() both directly and
> > indirectly.  Now expectation of indirect call is 50% but let's add some
> > margin for startup and finish routines.
> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/tests/shell/record_lbr.sh | 2 +-
> >  tools/perf/tests/workloads/thloop.c  | 9 ++++++---
> >  2 files changed, 7 insertions(+), 4 deletions(-)
> >
> > diff --git a/tools/perf/tests/shell/record_lbr.sh b/tools/perf/tests/shell/record_lbr.sh
> > index 8d750ee631f877fd..7a23b2095be8acba 100755
> > --- a/tools/perf/tests/shell/record_lbr.sh
> > +++ b/tools/perf/tests/shell/record_lbr.sh
> > @@ -121,7 +121,7 @@ lbr_test "-j any_ret" "any ret" 2
> >  lbr_test "-j ind_call" "any indirect call" 2
> >  lbr_test "-j ind_jmp" "any indirect jump" 100
> >  lbr_test "-j call" "direct calls" 2
> > -lbr_test "-j ind_call,u" "any indirect user call" 100
> > +lbr_test "-j ind_call,u" "any indirect user call" 52
> >  lbr_test "-a -b" "system wide any branch" 2
> >  lbr_test "-a -j any_call" "system wide any call" 2
> >
> > diff --git a/tools/perf/tests/workloads/thloop.c b/tools/perf/tests/workloads/thloop.c
> > index 457b29f91c3ee277..fa5547939882cf6c 100644
> > --- a/tools/perf/tests/workloads/thloop.c
> > +++ b/tools/perf/tests/workloads/thloop.c
> > @@ -18,14 +18,16 @@ static void sighandler(int sig __maybe_unused)
> >
> >  noinline void test_loop(void)
> >  {
> > -       while (!done);
> > +       for (volatile int i = 0; i < 10000; i++)
> 
> I don't think the volatile here will stop a sufficiently eager
> optimizing compiler. I think it may need to be static as well.

Ok, probably we can disbale optimizations in this code like others
in the test workloads.

Thanks for your review!
Namhyung

