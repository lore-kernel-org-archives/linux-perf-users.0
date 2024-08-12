Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB0C1547D6
	for <linux-perf-users@vger.kernel.org>; Mon, 12 Aug 2024 13:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723468435; cv=none; b=PKMBUgMCuMc9Rv9bjTRCOn2wDAmChsNDTM+LhVpOyfmP7jDoqHhX84mGOy2jhbD8udqKDOTsRuYi1JfqzORiuKX6/ktAJ3IVBGPN10EXapGRu+/jObcUpn1GaBL1fNy33WinyqDg4X1N13kocYXS7HdIq20EvWYQ3LgQrfPwoOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723468435; c=relaxed/simple;
	bh=C22V6pX1/BVB5U7Q1Fp54WFm9WJ3vzbytwmcZgLHAt4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nABjZz6gZSazZTxkfvmsXDVfIanBp2aHhqhx5GEfRGIf/T3X1tL8sURALAnhJvjc+MeX5mwfZTOVVPdt8RY/c75DPigQK9VEpvz/PP8R3ioZEFDh+kZI/qta+fu4PMaHD5v++2T8TvRYks9abc5LU/dMba1JFF9aTZHnwvecDD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ir+j3lAp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ir+j3lAp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DE8EC32782;
	Mon, 12 Aug 2024 13:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723468434;
	bh=C22V6pX1/BVB5U7Q1Fp54WFm9WJ3vzbytwmcZgLHAt4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ir+j3lApUsXEg35KFmOqWpqO6nV00rnn4Pxyop2AzX/RfGrOA5xNoLkqtQgcd9W+A
	 4UyPA0075pdAXeQPO0Xpddd8IMMQyj7Rm85/PRfJPOVjFQDT0x6OQdNEUo7yc2fsf+
	 BlyWb5JJZIdDos21XYzWHTPDGepqyicXs2G1RGij2OAwjcvhpcBxLYr5wJFNmHgQvE
	 +2EhvN2rJHvWGT3NHhhX/AQx5yPWQ/rmA//SV/qEl1lpd5vgtTVhjoVVCMJi0fB4vW
	 IQ5JIPWHJIpMLXMqvDWxF7AwtforItOT6CmWVxFFeQfdqDAsStbZ2MF+ydORxVXqo7
	 fELao9kUhKjkQ==
Date: Mon, 12 Aug 2024 10:13:50 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: vmolnaro@redhat.com
Cc: linux-perf-users@vger.kernel.org, acme@redhat.com, mpetlan@redhat.com,
	Ian Rogers <irogers@google.com>, Kajol Jain <kjain@linux.ibm.com>,
	Disha Goel <disgoel@linux.ibm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>
Subject: Re: [PATCH v2] perf test stat_all_pmu.sh: Parse return value of perf
 stat
Message-ID: <ZroKjgWHYwPpvbau@x1>
References: <Zh6ZEGOfgcEfwha4@x1>
 <20240429110439.17362-1-vmolnaro@redhat.com>
 <ZjVIQa3JouJde7I1@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjVIQa3JouJde7I1@x1>

On Fri, May 03, 2024 at 05:25:37PM -0300, Arnaldo Carvalho de Melo wrote:
> On Mon, Apr 29, 2024 at 12:56:24PM +0200, vmolnaro@redhat.com wrote:
> > From: Veronika Molnarova <vmolnaro@redhat.com>
> > 
> > With the upstream MR !3916 of commit ad86d7ee43b22aa2 ('powerpc/hv-gpci:
> > Fix the H_GET_PERF_COUNTER_INFO hcall return value checks') the perf
> > stat for hv_gpci events without required permission set returns an
> > error value of -1 to differentiate the output from the unsupported
> > events. The stat_all_pmu test was designed in a way, that if any
> > command exits with a non-zero value the test exits with an error
> > value without any information provided due to the 'set -e' option.
> 
> Is this v2 or v3? Kajol, can I have your tested-by?

Oops, Kajol wasn't on the CC list, nor Ian, I'm adding them, maybe Kajol
can test it on those machines and Ian, who wrote the test can take a
look, also adding all the perf tools reviewers, as listed in
MAINTAINERS.

Thanks,

- Arnaldo
 
> > Running stat_all_pmu test on powerpc machine with unsupported hv_gpci
> > event causes failure after the MR as the zero return value was required.
> > The issue propagated upstream as the list of the files that affected perf
> > did not cover the changed files and was updated after the issue was
> > discovered. It was caught by CKI testing where it was triaged to stop
> > blocking further MRs, as most of the powerpc machines do not support
> > some of the hv_gpci events.
> > 
> > Remove the 'set -e' option from the test and rework the test case to log
> > the status of the event for better maintainability. Instead of exiting
> > immediately after 'perf stat' ends with a non-zero value, check the
> > return value and output of the 'perf stat' command with the appropriate action.
> > 
> > Link to the MR !3916 of commit ad86d7ee43b22aa2:
> > https://gitlab.com/redhat/centos-stream/src/kernel/centos-stream-9/-/merge_requests/3916
> > 
> > Signed-off-by: Veronika Molnarova <vmolnaro@redhat.com>
> > ---
> > Fixed the issue with applying due to a fixed comment typo upstream and
> > added Ian's suggestion for the 'device busy' issue during parallel
> > testing.
> > 
> >  tools/perf/tests/shell/stat_all_pmu.sh | 41 ++++++++++++++++++--------
> >  1 file changed, 29 insertions(+), 12 deletions(-)
> > 
> > diff --git a/tools/perf/tests/shell/stat_all_pmu.sh b/tools/perf/tests/shell/stat_all_pmu.sh
> > index c77955419173..a75beddda4db 100755
> > --- a/tools/perf/tests/shell/stat_all_pmu.sh
> > +++ b/tools/perf/tests/shell/stat_all_pmu.sh
> > @@ -2,21 +2,38 @@
> >  # perf all PMU test
> >  # SPDX-License-Identifier: GPL-2.0
> >  
> > -set -e
> >  
> >  # Test all PMU events; however exclude parameterized ones (name contains '?')
> >  for p in $(perf list --raw-dump pmu | sed 's/[[:graph:]]\+?[[:graph:]]\+[[:space:]]//g'); do
> > -  echo "Testing $p"
> > -  result=$(perf stat -e "$p" true 2>&1)
> > -  if ! echo "$result" | grep -q "$p" && ! echo "$result" | grep -q "<not supported>" ; then
> > -    # We failed to see the event and it is supported. Possibly the workload was
> > -    # too small so retry with something longer.
> > -    result=$(perf stat -e "$p" perf bench internals synthesize 2>&1)
> > -    if ! echo "$result" | grep -q "$p" ; then
> > -      echo "Event '$p' not printed in:"
> > -      echo "$result"
> > -      exit 1
> > +  echo -n "Testing event '$p' -- "
> > +  stat_output=$(perf stat -e "$p" true 2>&1)
> > +  stat_result=$?
> > +  if echo "$stat_output" | grep -q "$p"; then
> > +    # return value 0 if counters get printed either if the event is supported or not
> > +    if [ $stat_result -eq 0 ] && ! echo "$stat_output" | grep -q "<not supported>"; then
> > +        echo "supported"
> > +    elif [ $stat_result -eq 0 ]; then
> > +        echo "not supported"
> > +    # return value 255 when the required permission for the event is not set
> > +    elif [ $stat_result -eq 255 ] && echo "$stat_output" | grep -q "No permission"; then
> > +        echo "no permission to enable"
> > +    # return value 255 in case of resource busy during parallel testing of events
> > +    elif [ $stat_result -eq 255 ] && echo "$stat_output" | grep -q "Device or resource busy"; then
> > +        echo "resource busy"
> > +    # return value 129 when trying to run 'perf stat' with a non-existent event
> > +    elif [ $stat_result -eq 129 ] && echo "$stat_output" | grep -q "Bad event name"; then
> > +        echo "Fail: Bad event name"
> > +        echo "$stat_output"
> > +        exit 1
> > +    else
> > +        echo "Fail: Unknown return value $stat_result"
> > +        echo "$stat_output"
> > +        exit 1
> >      fi
> > +  else
> > +      echo "Fail: Event '$p' not printed in:"
> > +      echo "$stat_output"
> > +      exit 1
> >    fi
> >  done
> >  
> > -- 
> > 2.43.0
> > 
