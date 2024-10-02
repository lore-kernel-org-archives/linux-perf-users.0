Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74937621
	for <linux-perf-users@vger.kernel.org>; Wed,  2 Oct 2024 00:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727828347; cv=none; b=tDcqy8TXGKqn2+76fd+ZAkALOAf0J8WICqJiEcs9au+iAZGuz1v9MH3ZdLpJoZMLkvJyh7RQ9+WyMg1v81jvEQq/zqT3Hy2RHQmAka27BeqCrjbsRE47NWHqmPeLq3HjGF1BZnwZJKmU8kv7LHJ2OgyYOP4YejkghQVC4FhcKds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727828347; c=relaxed/simple;
	bh=xL+ES1Jvc+LFZo5iGPYzJJ2BWXmPRjUNRFD/q1/R0ss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cRbyMS9dZQFWQ2HHAz9+UQwP3X/APIkwK8GkcSRtHu+04KwAgaIOT8YJXsxHvnIaXCFsxKaP6XsLhAan/qUlxudOE/1ZsiCIlHsAfsKjHZvfE7UreIGfY4WYKW9edA8y+MUNbkS4jgOXGoTOfFylqJH4Q3nGuAyvfP43nIytJpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ml3M+bqM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ml3M+bqM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76AB4C4CEC6;
	Wed,  2 Oct 2024 00:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727828346;
	bh=xL+ES1Jvc+LFZo5iGPYzJJ2BWXmPRjUNRFD/q1/R0ss=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ml3M+bqM0DgQ+mIgcHjesy2n6wGE8aa3uFlyhhoSpwEYWlY27637wIPSCy37BQ8gR
	 KhmGbiM+n2+eF3FCYwm12kpEsoMH3TGBrgd3ovSYMriFdh5qZrzA/7BgO2T8ZIeeNa
	 1oo81qeewY5NWrTlR8PehWFfadbllhL2BymMXG7z8AEKxKRZh2NYKcQhSgBo7KFtkS
	 APLtLQBece+0XD3h+dvc0oj5BFznvbMu2GtoNbmfVus2pGd2pHeNIF1rCYodfdCI63
	 ecvWIJoDfdSZDoESqNRB5OOkOZdoTMIdv59FUVvnF0Yi1a1QZWemZ3BSr8mKZFIMKx
	 fYE9PzvPLAi3g==
Date: Tue, 1 Oct 2024 17:19:05 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Veronika Molnarova <vmolnaro@redhat.com>
Cc: linux-perf-users@vger.kernel.org, acme@kernel.org, acme@redhat.com,
	mpetlan@redhat.com, rstoyano@redhat.com, mark.rutland@arm.com,
	kan.liang@linux.intel.com, jolsa@kernel.org, irogers@google.com,
	alexander.shishkin@linux.intel.com, adrian.hunter@intel.com
Subject: Re: [PATCH] perf test: Restore sample rate for perf_event_attr
Message-ID: <ZvyRefEz4lj4evm5@google.com>
References: <20240828134655.29267-1-vmolnaro@redhat.com>
 <8664c3ee-01ff-4c96-bce7-54b22dc1a5e0@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8664c3ee-01ff-4c96-bce7-54b22dc1a5e0@redhat.com>

Hello,

On Tue, Oct 01, 2024 at 10:31:38AM +0200, Veronika Molnarova wrote:
> Ping
> 
> On 8/28/24 15:46, vmolnaro@redhat.com wrote:
> > From: Veronika Molnarova <vmolnaro@redhat.com>
> > 
> > Test "Setup struct perf_event_attr" consists of multiple test cases that
> > can affect the max sample rate value for perf events. Some test cases
> > check this value as it should not be lowered under the set minimum for
> > the given test. Currently, it is possible for the test cases to affect
> > each other as the previous tests can lower the sample rate, leading to
> > a possible failure of some of the future test cases as the value is not
> > restored at any point.
> > 
> >  10: Setup struct perf_event_attr:
> > --- start ---
> > test child forked, pid 104220
> > Using CPUID 0x00000000413fd0c1
> > running './tests/attr/test-record-C0'
> > Current sample rate: 10000
> > running './tests/attr/test-record-basic'
> > Current sample rate: 900
> > running './tests/attr/test-record-branch-any'
> > Current sample rate: 600
> > running './tests/attr/test-record-dummy-C0'
> > Current sample rate: 600
> > expected sample_period=4000, got 600
> > FAILED './tests/attr/test-record-dummy-C0' - match failure

Please indent the shell output or source code by at least 2 spaces so
that git can distinguish it from other messages.  Typical problems are
having '#' at the beginning of a line.

In this case, '---' in the test output makes it think the rest is a
comment and ignored the messages.

Can you please resend with the change?

Thanks,
Namhyung

> > 
> > Restore the max sample rate value for perf events to a reasonable value
> > before each test case if its value was lowered too much to ensure the
> > same conditions for each test case.
> > 
> >  10: Setup struct perf_event_attr:
> > --- start ---
> > test child forked, pid 107222
> > Using CPUID 0x00000000413fd0c1
> > running './tests/attr/test-record-C0'
> > Current sample rate: 10000
> > running './tests/attr/test-record-basic'
> > Current sample rate: 800
> > running './tests/attr/test-record-branch-any'
> > Current sample rate: 700
> > unsupp  './tests/attr/test-record-branch-any'
> > running './tests/attr/test-record-branch-filter-any'
> > Current sample rate: 10000
> > running './tests/attr/test-record-count'
> > Current sample rate: 10000
> > running './tests/attr/test-record-data'
> > Current sample rate: 600
> > running './tests/attr/test-record-dummy-C0'
> > Current sample rate: 800
> > running './tests/attr/test-record-freq'
> > Current sample rate: 10000
> > ...
> > 
> > Cc: Adrian Hunter <adrian.hunter@intel.com>
> > Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> > Cc: Ian Rogers <irogers@google.com>
> > Cc: Jiri Olsa <jolsa@kernel.org>
> > Cc: Kan Liang <kan.liang@linux.intel.com>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Michael Petlan <mpetlan@redhat.com>
> > Cc: Radostin Stoyanov <rstoyano@redhat.com>
> > Signed-off-by: Veronika Molnarova <vmolnaro@redhat.com>
> > ---
> >  tools/perf/tests/attr.py | 18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> > 
> > diff --git a/tools/perf/tests/attr.py b/tools/perf/tests/attr.py
> > index e890c261ad26..3db9a7d78715 100644
> > --- a/tools/perf/tests/attr.py
> > +++ b/tools/perf/tests/attr.py
> > @@ -246,6 +246,23 @@ class Test(object):
> >                  return False
> >          return True
> >  
> > +    def restore_sample_rate(self, value=10000):
> > +        try:
> > +            # Check value of sample_rate
> > +            with open("/proc/sys/kernel/perf_event_max_sample_rate", "r") as fIn:
> > +                curr_value = fIn.readline()
> > +            # If too low restore to reasonable value
> > +            if not curr_value or int(curr_value) < int(value):
> > +                with open("/proc/sys/kernel/perf_event_max_sample_rate", "w") as fOut:
> > +                    fOut.write(str(value))
> > +
> > +        except IOError as e:
> > +            log.warning("couldn't restore sample_rate value: I/O error %s" % e)
> > +        except ValueError as e:
> > +            log.warning("couldn't restore sample_rate value: Value error %s" % e)
> > +        except TypeError as e:
> > +            log.warning("couldn't restore sample_rate value: Type error %s" % e)
> > +
> >      def load_events(self, path, events):
> >          parser_event = configparser.ConfigParser()
> >          parser_event.read(path)
> > @@ -283,6 +300,7 @@ class Test(object):
> >          if self.skip_test_kernel_until():
> >              raise Notest(self, "new kernel skip")
> >  
> > +        self.restore_sample_rate()
> >          cmd = "PERF_TEST_ATTR=%s %s %s -o %s/perf.data %s" % (tempdir,
> >                self.perf, self.command, tempdir, self.args)
> >          ret = os.WEXITSTATUS(os.system(cmd))
> 
