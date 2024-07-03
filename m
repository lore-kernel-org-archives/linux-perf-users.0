Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0B22BB13;
	Wed,  3 Jul 2024 21:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720041792; cv=none; b=UWT4sVsXmjdkvtIbtkgW1UhaJdJUrIz/7q7PMYuOTw3ct2pbUX1CsX1YmOV40A7Bfg9oTPgccUOYOS0tehuXgf6/lsAyKT7g9cLyIaBqPX6DVSBkGJibzNu9ELtFByg/6csENg8HSw0+mo8ASA8foKFd0FqgvHUY8P+z1dHmbsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720041792; c=relaxed/simple;
	bh=2ieoZ2IlCs+IyedLZuRseH/oLdEXmhc7vi+zgmr5NVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jd6roVsLa47BwlV4SD+CwLEnbcP0t8ck+oJ6zY88XoDih4uet17VOC0T2ARki8w+3j2enuSvAqE/nZNJTZNZBkVvRizbj5u9G6Ffra2A4lgeXe1h2jkyWwEtJR0PrTAqCGzkGo6YOED1AsUQDAudKMuBPHNXWOivl4H2Zy0KNrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GGBKI8ib; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GGBKI8ib"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E08BC2BD10;
	Wed,  3 Jul 2024 21:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720041792;
	bh=2ieoZ2IlCs+IyedLZuRseH/oLdEXmhc7vi+zgmr5NVk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GGBKI8ib5cnvhX/bvlSxYcgnO+YYsZKX7N7OSjy1XJ3glGy+5UzyI6OxXYLr4WRdl
	 S+7L33X6rlYouoHHrV+AnR64KShEKFLh5ge6KdxUPxVDrLdineoj0NMzFCqZtW84xE
	 fXhfxBsoKRis985us7/H+lN3MQwDst17PTe6j0DyyPI+gRceicUNdmy+EWy8kBQVLk
	 MHsz07T4Vz4vUBQfNZObIN9FIMq94SAXGJQF9N52eEIPaKhU2NuNSp1n5KtKpK6j+9
	 T2HsmSjLi065UDWmiNiUywdaTNYVyzhZrqpIVx2MBUibQYF+Dgl32n2Yli9Aea1Him
	 S2HcnNGydyFGA==
Date: Wed, 3 Jul 2024 14:23:10 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 2/2] perf test: Display number of remaining tests
Message-ID: <ZoXBPrw0kOtgLu98@google.com>
References: <20240701044236.475098-1-irogers@google.com>
 <20240701044236.475098-3-irogers@google.com>
 <ZoTIDCXKZw0bnthC@google.com>
 <CAP-5=fUAeVL57Q14hL=girAeNev-xjgz0Wv5Vpc_OMwXoouoTQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUAeVL57Q14hL=girAeNev-xjgz0Wv5Vpc_OMwXoouoTQ@mail.gmail.com>

On Tue, Jul 02, 2024 at 09:30:44PM -0700, Ian Rogers wrote:
> On Tue, Jul 2, 2024 at 8:40 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Sun, Jun 30, 2024 at 09:42:36PM -0700, Ian Rogers wrote:
> > > Before polling or sleeping to wait for a test to complete, print out
> > > ": Running (<num> remaining)" where the number of remaining tests is
> > > determined by iterating over the remaining tests and seeing which
> > > return true for check_if_command_finished. After the delay, erase the
> > > line and either update it with the new number of remaining tests, or
> > > print the test's result. This allows a user to know a test is running
> > > and in parallel mode (default) how many of the tests are waiting to
> >
> > It's not default anymore. :)
> >
> >
> > > complete. If color mode is disabled then avoid displaying the
> > > "Running" message.
> > >
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > ---
> > >  tools/perf/tests/builtin-test.c | 77 ++++++++++++++++++++++-----------
> > >  tools/perf/util/color.h         |  1 +
> > >  2 files changed, 53 insertions(+), 25 deletions(-)
> > >
> > > diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
> > > index c3d84b67ca8e..23be9139f229 100644
> > > --- a/tools/perf/tests/builtin-test.c
> > > +++ b/tools/perf/tests/builtin-test.c
> > > @@ -241,7 +241,10 @@ static int run_test_child(struct child_process *process)
> > >       return -err;
> > >  }
> > >
> > > -static int print_test_result(struct test_suite *t, int i, int subtest, int result, int width)
> > > +#define TEST_RUNNING -3
> > > +
> > > +static int print_test_result(struct test_suite *t, int i, int subtest, int result, int width,
> > > +                          int remaining)
> > >  {
> > >       if (has_subtests(t)) {
> > >               int subw = width > 2 ? width - 2 : width;
> > > @@ -251,6 +254,9 @@ static int print_test_result(struct test_suite *t, int i, int subtest, int resul
> > >               pr_info("%3d: %-*s:", i + 1, width, test_description(t, subtest));
> > >
> > >       switch (result) {
> > > +     case TEST_RUNNING:
> > > +             color_fprintf(stderr, PERF_COLOR_YELLOW, " Running (%d remaining)\n", remaining);
> > > +             break;
> > >       case TEST_OK:
> > >               pr_info(" Ok\n");
> > >               break;
> > > @@ -272,13 +278,15 @@ static int print_test_result(struct test_suite *t, int i, int subtest, int resul
> > >       return 0;
> > >  }
> > >
> > > -static int finish_test(struct child_test *child_test, int width)
> > > +static int finish_test(struct child_test **child_tests, int running_test, int child_test_num,
> > > +                    int width)
> > >  {
> > > +     struct child_test *child_test = child_tests[running_test];
> > >       struct test_suite *t = child_test->test;
> > >       int i = child_test->test_num;
> > >       int subi = child_test->subtest;
> > >       int err = child_test->process.err;
> > > -     bool err_done = err <= 0;
> > > +     bool err_done = false;
> > >       struct strbuf err_output = STRBUF_INIT;
> > >       int ret;
> > >
> > > @@ -293,7 +301,7 @@ static int finish_test(struct child_test *child_test, int width)
> > >        * Busy loop reading from the child's stdout/stderr that are set to be
> > >        * non-blocking until EOF.
> > >        */
> > > -     if (!err_done)
> > > +     if (err > 0)
> > >               fcntl(err, F_SETFL, O_NONBLOCK);
> > >       if (verbose > 1) {
> > >               if (has_subtests(t))
> > > @@ -307,29 +315,48 @@ static int finish_test(struct child_test *child_test, int width)
> > >                         .events = POLLIN | POLLERR | POLLHUP | POLLNVAL,
> > >                       },
> > >               };
> > > -             char buf[512];
> > > -             ssize_t len;
> > > -
> > > -             /* Poll to avoid excessive spinning, timeout set for 100ms. */
> > > -             poll(pfds, ARRAY_SIZE(pfds), /*timeout=*/100);
> > > -             if (!err_done && pfds[0].revents) {
> > > -                     errno = 0;
> > > -                     len = read(err, buf, sizeof(buf) - 1);
> > > -
> > > -                     if (len <= 0) {
> > > -                             err_done = errno != EAGAIN;
> > > -                     } else {
> > > -                             buf[len] = '\0';
> > > -                             if (verbose > 1)
> > > -                                     fprintf(stdout, "%s", buf);
> > > -                             else
> > > +             if (perf_use_color_default) {
> > > +                     int tests_in_progress = running_test;
> > > +
> > > +                     for (int y = running_test; y < child_test_num; y++) {
> > > +                             if (check_if_command_finished(&child_tests[y]->process))
> > > +                                     tests_in_progress++;
> > > +                     }
> > > +                     print_test_result(t, i, subi, TEST_RUNNING, width,
> > > +                                       child_test_num - tests_in_progress);
> > > +             }
> > > +
> > > +             err_done = true;
> > > +             if (err <= 0) {
> > > +                     /* No child stderr to poll, sleep for 10ms for child to complete. */
> > > +                     usleep(10 * 1000);
> > > +             } else {
> > > +                     /* Poll to avoid excessive spinning, timeout set for 100ms. */
> > > +                     poll(pfds, ARRAY_SIZE(pfds), /*timeout=*/100);
> >
> > When I tested this patch, I saw it refreshes too often in parallel mode.
> > Maybe 100ms is too short?  I don't know if it's from usleep (10ms) or
> > here.
> 
> It's usually the poll and I suspect it is the test writing a lot of
> output. I agree it can look a little flickery but it is also
> responsive in terms of not waiting too long before moving to the next
> test. I think it is possible to improve on the code here, the main
> thing I was after was making the output writing self contained and not
> split between start test and finish test, as that won't work well in
> the parallel case.

Is it possible to skip the rewriting if nothing is changed?

Thanks,
Namhyung

