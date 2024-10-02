Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1AC4621
	for <linux-perf-users@vger.kernel.org>; Wed,  2 Oct 2024 00:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727828757; cv=none; b=ibeBYwWxf8jZi1iFxEDehXjG2j6KlQwTs6xDvgpZ8sMMbQ9arxFPMD+OEN3leg6/8Foe3+1qF3H7WiJp840EG1MIL+YUPM1Iccblp6QT/0e8D+YvaPpfUAahpbDe65qcTRuTTDMrOrIaQFHyFmWahhLCyR+H8M01e5P2dv4vmfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727828757; c=relaxed/simple;
	bh=Mu6ajiKzlsNh/seb8tOPHrrUkbAGDEZobosSU5c9Wks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DSf2GAI0oFLXYUzFtsBhC+vGW8cGGNDgRc7zlcb8LAKZpy77YujWxTAOWhgj/TBp60CyUEey0n5wOeL2njoUYAmd7o9j1kQFWbKpvD2JdEDHEiE6qlC31YN46DwSUNM4vccl8D6HaS9lGDWkCX8PX5bBPdrYT8HhvHJg+PJU9PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BSyFU+mL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BSyFU+mL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 015E9C4CECD;
	Wed,  2 Oct 2024 00:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727828757;
	bh=Mu6ajiKzlsNh/seb8tOPHrrUkbAGDEZobosSU5c9Wks=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BSyFU+mL+F2Mdg3U0scslgOKaIEOb49mqHF5sZkwE5YjWdNcGxXPx6Bvxzs437q9J
	 HqhoDZXw/5ZAg1nUmdA5PifwwchHiG8+BmKsuY+viqmYkJd28cqbgEI74LIfV0+YjD
	 /ER9zZU+5QWiMP96FCvnBxGw2YqO0DgTBq+O/zIJKtHT6DL3KfvgNTo/d+f6D9J48D
	 3phxCSeim1UQjUfzKWJZ/WDgEgEVzFPpPOVZ3BJgZVFRC8byvfgL9kqS3NfhYPWz+W
	 z0hS1/iy5hxaL6vxiktfmXVdZnkJDXvZMryNpd7Nw+6amDOB3if52vvq4c0+/TYU4Q
	 Cv5L4T0wXfByw==
Date: Tue, 1 Oct 2024 17:25:55 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Veronika Molnarova <vmolnaro@redhat.com>
Cc: linux-perf-users@vger.kernel.org, acme@kernel.org, acme@redhat.com,
	kjain@linux.ibm.com, mpetlan@redhat.com, rstoyano@redhat.com,
	mark.rutland@arm.com, jolsa@kernel.org,
	alexander.shishkin@linux.intel.com, adrian.hunter@intel.com
Subject: Re: [PATCH v4] perf test stat_all_pmu.sh: Parse return value of perf
 stat
Message-ID: <ZvyTE4x9-BxCVx5J@google.com>
References: <20240814170146.20678-1-vmolnaro@redhat.com>
 <dd62147b-e9b5-4281-b547-fef46082e4f2@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dd62147b-e9b5-4281-b547-fef46082e4f2@redhat.com>

On Tue, Oct 01, 2024 at 10:35:33AM +0200, Veronika Molnarova wrote:
> 
> 
> On 8/14/24 19:01, vmolnaro@redhat.com wrote:
> > From: Veronika Molnarova <vmolnaro@redhat.com>
> > 
> > With the upstream MR !3916 of commit ad86d7ee43b22aa2 ('powerpc/hv-gpci:
> > Fix the H_GET_PERF_COUNTER_INFO hcall return value checks') the perf
> > stat for hv_gpci events without required permission set returns an
> > error value of -1 to differentiate the output from the unsupported
> > events. The stat_all_pmu test was designed in a way, that if any
> > command exits with a non-zero value the test exits with an error
> > value without any information provided due to the 'set -e' option.
> > 
> > The issue propagated upstream as the list of the files that affected perf
> > did not cover the changed files and was updated after the issue was
> > discovered. It was caught by CKI testing where it was triaged to stop
> > blocking further MRs, as most of the powerpc machines have some of
> > the hv_gpci events without the required permissions.
> > 
> > Remove the 'set -e' option from the test and rework the test case to log
> > the status of the event for better maintainability. Instead of exiting
> > immediately after 'perf stat' ends with a non-zero value, check the
> > return value and output of the 'perf stat' command with the appropriate action.
> > 
> > Link to the MR !3916 of commit ad86d7ee43b22aa2:
> > https://gitlab.com/redhat/centos-stream/src/kernel/centos-stream-9/-/merge_requests/3916
> > 
> > Cc: Adrian Hunter <adrian.hunter@intel.com>
> > Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> > Cc: Jiri Olsa <jolsa@kernel.org>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Michael Petlan <mpetlan@redhat.com>
> > Cc: Radostin Stoyanov <rstoyano@redhat.com>
> > Signed-off-by: Veronika Molnarova <vmolnaro@redhat.com>
> > ---
> > v2: Fix commit hash
> > v3: Add 'device busy' for parallel testing
> > v4: Change commit message
> 
> Is this version of the commit viable?

Sorry but we have a conflicting change in this area.  Can you please
rebase?

> > ---
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

I think you removed this part.  Please check.

Thanks,
Namhyung


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
> 
