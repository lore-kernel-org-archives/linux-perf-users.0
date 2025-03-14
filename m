Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C78A1DE3AD;
	Fri, 14 Mar 2025 09:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741943608; cv=none; b=LXyt32AlUrzRoTon0T92zD1IrCUkaIw02zodJEvM/NzwDeZY8+1nowseCUALbM2gaC1JwrWvV17FWlT3H9bCrdTZmFIKekt7Jw/J+AhsC3IG7+EpSLj8geComssD27lO+nXwWquWb+dr3q143HbIWjU76IibpC2jPlh27mbLfhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741943608; c=relaxed/simple;
	bh=WLlJgksv67r1gjn1fyE/ylFD8IWYUjpqVtcR1DHY0rs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OXPYgES+Ege0Cn4zjV4xM9bB+Fdn2/UvhziSOwSAOauOyw/dJViEIjcpU3PdxVJIcgd3XgcfRUJ5Nd0yBT9rjDK7P0Z5xt8jhlLdimqDaQc37wuWzo9rzauBuALoTV6AVCM49EUXw15h6mQ2vIiKBKwM6GH2BNQQNVrmiIlj4mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 682471424;
	Fri, 14 Mar 2025 02:13:29 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ECF303F673;
	Fri, 14 Mar 2025 02:13:18 -0700 (PDT)
Date: Fri, 14 Mar 2025 09:13:14 +0000
From: Leo Yan <leo.yan@arm.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	German Gomez <german.gomez@arm.com>
Subject: Re: [PATCH v1] perf tests: Harden branch stack sampling test
Message-ID: <20250314091314.GV9682@e132581.arm.com>
References: <20250312055846.671522-1-irogers@google.com>
 <20250312105450.GN9682@e132581.arm.com>
 <Z9M9gK4VS199CRKh@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9M9gK4VS199CRKh@google.com>

Hi Namhyung,

On Thu, Mar 13, 2025 at 01:18:08PM -0700, Namhyung Kim wrote:

[...]

> > >  test_user_branches() {
> > >  	echo "Testing user branch stack sampling"
> > >  
> > > -	perf record -o $TMPDIR/perf.data --branch-filter any,save_type,u -- ${TESTPROG} > /dev/null 2>&1
> > > -	perf script -i $TMPDIR/perf.data --fields brstacksym | tr -s ' ' '\n' > $TMPDIR/perf.script
> > > +	perf record -o "$TMPDIR/perf.data" --branch-filter any,save_type,u -- ${TESTPROG} > "$TMPDIR/record.txt" 2>&1
> > > +	perf script -i "$TMPDIR/perf.data" --fields brstacksym > "$TMPDIR/perf.script"
> > >  
> > >  	# example of branch entries:
> > >  	# 	brstack_foo+0x14/brstack_bar+0x40/P/-/-/0/CALL
> > >  
> > > -	set -x
> > > -	grep -E -m1 "^brstack_bench\+[^ ]*/brstack_foo\+[^ ]*/IND_CALL/.*$"	$TMPDIR/perf.script
> > > -	grep -E -m1 "^brstack_foo\+[^ ]*/brstack_bar\+[^ ]*/CALL/.*$"	$TMPDIR/perf.script
> > > -	grep -E -m1 "^brstack_bench\+[^ ]*/brstack_foo\+[^ ]*/CALL/.*$"	$TMPDIR/perf.script
> > > -	grep -E -m1 "^brstack_bench\+[^ ]*/brstack_bar\+[^ ]*/CALL/.*$"	$TMPDIR/perf.script
> > > -	grep -E -m1 "^brstack_bar\+[^ ]*/brstack_foo\+[^ ]*/RET/.*$"		$TMPDIR/perf.script
> > > -	grep -E -m1 "^brstack_foo\+[^ ]*/brstack_bench\+[^ ]*/RET/.*$"	$TMPDIR/perf.script
> > > -	grep -E -m1 "^brstack_bench\+[^ ]*/brstack_bench\+[^ ]*/COND/.*$"	$TMPDIR/perf.script
> > > -	grep -E -m1 "^brstack\+[^ ]*/brstack\+[^ ]*/UNCOND/.*$"		$TMPDIR/perf.script
> > > -	set +x
> > > -
> > > +	expected=(
> > > +		"^brstack_bench\+[^ ]*/brstack_foo\+[^ ]*/IND_CALL/.*$"
> > > +		"^brstack_foo\+[^ ]*/brstack_bar\+[^ ]*/CALL/.*$"
> > > +		"^brstack_bench\+[^ ]*/brstack_foo\+[^ ]*/CALL/.*$"
> > > +		"^brstack_bench\+[^ ]*/brstack_bar\+[^ ]*/CALL/.*$"
> > > +		"^brstack_bar\+[^ ]*/brstack_foo\+[^ ]*/RET/.*$"
> > > +		"^brstack_foo\+[^ ]*/brstack_bench\+[^ ]*/RET/.*$"
> > > +		"^brstack_bench\+[^ ]*/brstack_bench\+[^ ]*/COND/.*$"
> > > +		"^brstack\+[^ ]*/brstack\+[^ ]*/UNCOND/.*$"
> > > +	)
> > > +	for x in "${expected[@]}"
> > > +	do
> > > +		if ! tr -s ' ' '\n' < "$TMPDIR/perf.script" | grep -E -m1 -q "$x"
> > > +		then
> > > +			echo "Branches missing $x"
> > > +			if [ "x$err" == "x0" ]
> > > +			then
> > > +				err=2
> > 
> > Here it sets "err=2", as a result, if any grep command fails, the script
> > exits while reporting to skip the test.  This seems incorrect to me.
> > 
> > My understanding is the regular expressions above are mandatory to be
> > matched, otherwise, it must be something is wrong.  We should not skip
> > the test in this case.
> > 
> > I can understand that 'perf record' cannot record all branch types, if
> > this is the case, maybe we can improve the recording quality rather
> > than reporting skip?  E.g.,
> > 
> >   cat <<EOF > "$TMPDIR/loop.sh"
> >   for run in {1..5}; do perf test -w brstack; done
> >   EOF
> > 
> >   perf record -o "$TMPDIR/perf.data" --branch-filter any,save_type,u
> >     -- sh $TMPDIR/loop.sh
> > 
> > If we run the test for 5 times, should this can allow us to ensure the
> > branch samples are recorded?
> 
> The brstack (and other workload programs) can take an argument to
> control its duration.  For brstack, it's the number of loop iteration
> and default is 999999.

Sorry I did not dig into the brstack workload program.

If the workload has run for a large number of loops, the question is:
why isn't the test capturing the expected branch stacks?

Thanks,
Leo
