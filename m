Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788F21F460B;
	Thu, 13 Mar 2025 20:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741897092; cv=none; b=fNJxoTSDJTL8loaP97AeZXZXXEOKxCxOcsTfxSg26/idsh/XBPrq0LqD9jnSgjVnGbmDvChUuky3aPP5YDRdg7b31qyEF0dbfCePZ4NBAC+H0RSEd3zZqcT+ciVg17GjNwYAzJ155oBCOA38Ga/nywwdi4fbJXNql8TQ73c8PDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741897092; c=relaxed/simple;
	bh=g21cefL7pF9/fFzm172iRJmsvYrNq/ZPoflq1jUWDzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P/6AlpyyA6H/Q54QPSE/XuXSY/b+aMuJ5rFZVjHCDPmMYUwymuUhmGNphMieuBhP3rKDjddGz5L7hMEDiaUerul6v0kOQCmarVkvV6EW2v62Cb46yUAm053f2HVuaay1dB3Byo1OwqYp2s7QvA41UzdcuRDIGGKuaGMdFvBiFzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n1F+Ngtj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n1F+Ngtj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D915C4CEDD;
	Thu, 13 Mar 2025 20:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741897090;
	bh=g21cefL7pF9/fFzm172iRJmsvYrNq/ZPoflq1jUWDzs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n1F+NgtjidcUGh6mBJaPQRzQlG+YD0beabaqodcoGRmJvLRQZ/zU/HJS+L1LybYK4
	 2IH0+MveoL1oeR0/7PWU80IUmCmQ0AW9AtW6CA7EPj2R+YJb/GJl5GUg1XSFqPoM1U
	 89zwRXtEpW87A0rVGx+n9Qgqn+ojPZ/vEsuVBOWX3+iDWTBZpkduV3yyStvtmdMvWz
	 SJOZ5Rdxv7ISU970sdbp2eZiL/H1TFqE2O65fPqXcoXzuG6LNTcoyISxoA+ybtAaCU
	 /3VM6m+/cVD24dpehxVzT7/TUvju//7T6tUcWxiqcXsauEsufVERZ/Hf9ZMZsu/yQD
	 YH3865qa5NWWw==
Date: Thu, 13 Mar 2025 13:18:08 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Leo Yan <leo.yan@arm.com>
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
Message-ID: <Z9M9gK4VS199CRKh@google.com>
References: <20250312055846.671522-1-irogers@google.com>
 <20250312105450.GN9682@e132581.arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250312105450.GN9682@e132581.arm.com>

Hello,

On Wed, Mar 12, 2025 at 10:54:50AM +0000, Leo Yan wrote:
> Hi Ian,
> 
> On Tue, Mar 11, 2025 at 10:58:46PM -0700, Ian Rogers wrote:
> > On continuous testing the perf script output can be empty, or nearly
> > empty, causing tr/grep to exit and due to "set -e" the test traps and
> > fails. Add some empty file handling that sets the test to skip and
> > make grep and other text rewriting failures non-fatal by adding
> > "|| true".
> > 
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/tests/shell/test_brstack.sh | 79 +++++++++++++++++++-------
> >  1 file changed, 59 insertions(+), 20 deletions(-)
> > 
> > diff --git a/tools/perf/tests/shell/test_brstack.sh b/tools/perf/tests/shell/test_brstack.sh
> > index e01df7581393..6f5ae227b3e8 100755
> > --- a/tools/perf/tests/shell/test_brstack.sh
> > +++ b/tools/perf/tests/shell/test_brstack.sh
> > @@ -1,4 +1,4 @@
> > -#!/bin/sh
> > +#!/bin/bash
> >  # Check branch stack sampling
> >  
> >  # SPDX-License-Identifier: GPL-2.0
> > @@ -17,35 +17,54 @@ fi
> >  
> >  skip_test_missing_symbol brstack_bench
> >  
> > +set -x
> > +err=0
> >  TMPDIR=$(mktemp -d /tmp/__perf_test.program.XXXXX)
> >  TESTPROG="perf test -w brstack"
> >  
> >  cleanup() {
> >  	rm -rf $TMPDIR
> > +	trap - EXIT TERM INT
> >  }
> >  
> > -trap cleanup EXIT TERM INT
> > +trap_cleanup() {
> > +	set +e
> > +	echo "Unexpected signal in ${FUNCNAME[1]}"
> > +	cleanup
> > +	exit 1
> > +}
> > +trap trap_cleanup EXIT TERM INT
> >  
> >  test_user_branches() {
> >  	echo "Testing user branch stack sampling"
> >  
> > -	perf record -o $TMPDIR/perf.data --branch-filter any,save_type,u -- ${TESTPROG} > /dev/null 2>&1
> > -	perf script -i $TMPDIR/perf.data --fields brstacksym | tr -s ' ' '\n' > $TMPDIR/perf.script
> > +	perf record -o "$TMPDIR/perf.data" --branch-filter any,save_type,u -- ${TESTPROG} > "$TMPDIR/record.txt" 2>&1
> > +	perf script -i "$TMPDIR/perf.data" --fields brstacksym > "$TMPDIR/perf.script"
> >  
> >  	# example of branch entries:
> >  	# 	brstack_foo+0x14/brstack_bar+0x40/P/-/-/0/CALL
> >  
> > -	set -x
> > -	grep -E -m1 "^brstack_bench\+[^ ]*/brstack_foo\+[^ ]*/IND_CALL/.*$"	$TMPDIR/perf.script
> > -	grep -E -m1 "^brstack_foo\+[^ ]*/brstack_bar\+[^ ]*/CALL/.*$"	$TMPDIR/perf.script
> > -	grep -E -m1 "^brstack_bench\+[^ ]*/brstack_foo\+[^ ]*/CALL/.*$"	$TMPDIR/perf.script
> > -	grep -E -m1 "^brstack_bench\+[^ ]*/brstack_bar\+[^ ]*/CALL/.*$"	$TMPDIR/perf.script
> > -	grep -E -m1 "^brstack_bar\+[^ ]*/brstack_foo\+[^ ]*/RET/.*$"		$TMPDIR/perf.script
> > -	grep -E -m1 "^brstack_foo\+[^ ]*/brstack_bench\+[^ ]*/RET/.*$"	$TMPDIR/perf.script
> > -	grep -E -m1 "^brstack_bench\+[^ ]*/brstack_bench\+[^ ]*/COND/.*$"	$TMPDIR/perf.script
> > -	grep -E -m1 "^brstack\+[^ ]*/brstack\+[^ ]*/UNCOND/.*$"		$TMPDIR/perf.script
> > -	set +x
> > -
> > +	expected=(
> > +		"^brstack_bench\+[^ ]*/brstack_foo\+[^ ]*/IND_CALL/.*$"
> > +		"^brstack_foo\+[^ ]*/brstack_bar\+[^ ]*/CALL/.*$"
> > +		"^brstack_bench\+[^ ]*/brstack_foo\+[^ ]*/CALL/.*$"
> > +		"^brstack_bench\+[^ ]*/brstack_bar\+[^ ]*/CALL/.*$"
> > +		"^brstack_bar\+[^ ]*/brstack_foo\+[^ ]*/RET/.*$"
> > +		"^brstack_foo\+[^ ]*/brstack_bench\+[^ ]*/RET/.*$"
> > +		"^brstack_bench\+[^ ]*/brstack_bench\+[^ ]*/COND/.*$"
> > +		"^brstack\+[^ ]*/brstack\+[^ ]*/UNCOND/.*$"
> > +	)
> > +	for x in "${expected[@]}"
> > +	do
> > +		if ! tr -s ' ' '\n' < "$TMPDIR/perf.script" | grep -E -m1 -q "$x"
> > +		then
> > +			echo "Branches missing $x"
> > +			if [ "x$err" == "x0" ]
> > +			then
> > +				err=2
> 
> Here it sets "err=2", as a result, if any grep command fails, the script
> exits while reporting to skip the test.  This seems incorrect to me.
> 
> My understanding is the regular expressions above are mandatory to be
> matched, otherwise, it must be something is wrong.  We should not skip
> the test in this case.
> 
> I can understand that 'perf record' cannot record all branch types, if
> this is the case, maybe we can improve the recording quality rather
> than reporting skip?  E.g.,
> 
>   cat <<EOF > "$TMPDIR/loop.sh"
>   for run in {1..5}; do perf test -w brstack; done
>   EOF
> 
>   perf record -o "$TMPDIR/perf.data" --branch-filter any,save_type,u
>     -- sh $TMPDIR/loop.sh
> 
> If we run the test for 5 times, should this can allow us to ensure the
> branch samples are recorded?

The brstack (and other workload programs) can take an argument to
control its duration.  For brstack, it's the number of loop iteration
and default is 999999.

Thanks,
Namhyung

