Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54B71A01DB
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Aug 2024 15:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723562130; cv=none; b=aLrBYlutw2VrReegn9COLjhinsj1bvTeYEjMbTA2kfpK/TgVmV3iGJlTK5nHnltP/7EuYq9yge301rSbbbEvdxirx0uNqC8OjrsvT7bPeHmvCxyKGpTEjhAq5fmhMbt2xYk3DCWbNgeZA8bIoqmBIM1kTrKMKGKIJQ7HNn10Q04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723562130; c=relaxed/simple;
	bh=77+g095/DpouJPwuMC87rOvMp4/EIlWKTTAX+Xk9y1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LFB5xCZXrLLVPvAOEMDIcIiff2h+7QrSjWEmVwct4vYb30xndSnevKA3NotIzRY/x1kRIqsif/Z6dBPifJ9003qLObxVZA4lJcVv0yFTc8ZAKouRwKHe4ko0M27xYetOQoKdWYCT4hsWqLVvpbIixEl8bQXOlm9JSpndMcwu8Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q2ZMK8br; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q2ZMK8br"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A2A8C4AF09;
	Tue, 13 Aug 2024 15:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723562129;
	bh=77+g095/DpouJPwuMC87rOvMp4/EIlWKTTAX+Xk9y1o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q2ZMK8brfAnN8M2meFXQFdp5Z0AmjB1FFj+OaIYhPgNgr99TENRi9kAkVqOrDAigU
	 xCQKzYy5P1fnmIoHSWH4tSMzrMRgueg8a6Gi5a6/xPf30dFdpSRPVdAy3Ofyd2B1Ew
	 Xqt2ypRdijK5NNUFsemxYiDG98OZaZpcIbpTIOJpIirFfGKtIG1TvoNQv4/ZUzt0j5
	 JxpVj2aJZdsFdkTNi/VF+6Z662+/YORA6YrfaBCd9FZsd2zwhA4vy5K/WN0KWTprEs
	 ecPNsjtRRcOZA/zT2yaXzr/VjA68KBnN9vxcKlYxsrAN1cRuNjXpPKvvFrgCOkr1kG
	 EzWLJm+eiKnbA==
Date: Tue, 13 Aug 2024 12:15:25 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: kajoljain <kjain@linux.ibm.com>
Cc: vmolnaro@redhat.com, linux-perf-users@vger.kernel.org, acme@redhat.com,
	mpetlan@redhat.com, Ian Rogers <irogers@google.com>,
	Disha Goel <disgoel@linux.ibm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>
Subject: Re: [PATCH v2] perf test stat_all_pmu.sh: Parse return value of perf
 stat
Message-ID: <Zrt4jZckGWIFH8n3@x1>
References: <Zh6ZEGOfgcEfwha4@x1>
 <20240429110439.17362-1-vmolnaro@redhat.com>
 <ZjVIQa3JouJde7I1@x1>
 <ZroKjgWHYwPpvbau@x1>
 <e1435347-404e-4ff4-a4b1-c9338a60c8d3@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1435347-404e-4ff4-a4b1-c9338a60c8d3@linux.ibm.com>

On Tue, Aug 13, 2024 at 01:21:14PM +0530, kajoljain wrote:
> 
> 
> On 8/12/24 18:43, Arnaldo Carvalho de Melo wrote:
> > On Fri, May 03, 2024 at 05:25:37PM -0300, Arnaldo Carvalho de Melo wrote:
> >> On Mon, Apr 29, 2024 at 12:56:24PM +0200, vmolnaro@redhat.com wrote:
> >>> From: Veronika Molnarova <vmolnaro@redhat.com>
> >>>
> >>> With the upstream MR !3916 of commit ad86d7ee43b22aa2 ('powerpc/hv-gpci:
> >>> Fix the H_GET_PERF_COUNTER_INFO hcall return value checks') the perf
> >>> stat for hv_gpci events without required permission set returns an
> >>> error value of -1 to differentiate the output from the unsupported
> >>> events. The stat_all_pmu test was designed in a way, that if any
> >>> command exits with a non-zero value the test exits with an error
> >>> value without any information provided due to the 'set -e' option.
> >>
> >> Is this v2 or v3? Kajol, can I have your tested-by?
> > 
> > Oops, Kajol wasn't on the CC list, nor Ian, I'm adding them, maybe Kajol
> > can test it on those machines and Ian, who wrote the test can take a
> > look, also adding all the perf tools reviewers, as listed in
> > MAINTAINERS.
> > 
> > Thanks,
> > 
> > - Arnaldo
> >  
> Hi Veronika,
> I checked the patch, code wise patch looks fine to me. I also tested it
> on powerpc system.
> 
> Just have concern on your commit message, you added below text as part
> of your commit message:
> 
> It was caught by CKI testing where it was triaged to stop
> blocking further MRs, as most of the powerpc machines do not support
> some of the hv_gpci events.
> 
> The hv-gpci events are supported in pseries system.
> And for different power processors, we already have code to include only
> supported event as part of perf list.
> 
> If you are taking about parametrized events which are skipped in this
> testcase, its not that those parametrized events are not supported.
> Since testing proper values of the parameters is out of scope of this
> script we are skipping those events.
> 
> Can you remove that part from commit message? Rest looks fine to me.

Veronika, can you please address the reviewer's comment and send a v4
patch, collecting the tags he provided?

Thanks,

- Arnaldo
 
> Reviewed-by: Kajol Jain <kjain@linux.ibm.com>
> Tested-by: Kajol Jain <kjain@linux.ibm.com>
> 
> Thanks,
> Kajol Jain
> 
> >>> Running stat_all_pmu test on powerpc machine with unsupported hv_gpci
> >>> event causes failure after the MR as the zero return value was required.
> >>> The issue propagated upstream as the list of the files that affected perf
> >>> did not cover the changed files and was updated after the issue was
> >>> discovered. It was caught by CKI testing where it was triaged to stop
> >>> blocking further MRs, as most of the powerpc machines do not support
> >>> some of the hv_gpci events.
> >>>
> >>> Remove the 'set -e' option from the test and rework the test case to log
> >>> the status of the event for better maintainability. Instead of exiting
> >>> immediately after 'perf stat' ends with a non-zero value, check the
> >>> return value and output of the 'perf stat' command with the appropriate action.
> >>>
> >>> Link to the MR !3916 of commit ad86d7ee43b22aa2:
> >>> https://gitlab.com/redhat/centos-stream/src/kernel/centos-stream-9/-/merge_requests/3916
> >>>
> >>> Signed-off-by: Veronika Molnarova <vmolnaro@redhat.com>
> >>> ---
> >>> Fixed the issue with applying due to a fixed comment typo upstream and
> >>> added Ian's suggestion for the 'device busy' issue during parallel
> >>> testing.
> >>>
> >>>  tools/perf/tests/shell/stat_all_pmu.sh | 41 ++++++++++++++++++--------
> >>>  1 file changed, 29 insertions(+), 12 deletions(-)
> >>>
> >>> diff --git a/tools/perf/tests/shell/stat_all_pmu.sh b/tools/perf/tests/shell/stat_all_pmu.sh
> >>> index c77955419173..a75beddda4db 100755
> >>> --- a/tools/perf/tests/shell/stat_all_pmu.sh
> >>> +++ b/tools/perf/tests/shell/stat_all_pmu.sh
> >>> @@ -2,21 +2,38 @@
> >>>  # perf all PMU test
> >>>  # SPDX-License-Identifier: GPL-2.0
> >>>  
> >>> -set -e
> >>>  
> >>>  # Test all PMU events; however exclude parameterized ones (name contains '?')
> >>>  for p in $(perf list --raw-dump pmu | sed 's/[[:graph:]]\+?[[:graph:]]\+[[:space:]]//g'); do
> >>> -  echo "Testing $p"
> >>> -  result=$(perf stat -e "$p" true 2>&1)
> >>> -  if ! echo "$result" | grep -q "$p" && ! echo "$result" | grep -q "<not supported>" ; then
> >>> -    # We failed to see the event and it is supported. Possibly the workload was
> >>> -    # too small so retry with something longer.
> >>> -    result=$(perf stat -e "$p" perf bench internals synthesize 2>&1)
> >>> -    if ! echo "$result" | grep -q "$p" ; then
> >>> -      echo "Event '$p' not printed in:"
> >>> -      echo "$result"
> >>> -      exit 1
> >>> +  echo -n "Testing event '$p' -- "
> >>> +  stat_output=$(perf stat -e "$p" true 2>&1)
> >>> +  stat_result=$?
> >>> +  if echo "$stat_output" | grep -q "$p"; then
> >>> +    # return value 0 if counters get printed either if the event is supported or not
> >>> +    if [ $stat_result -eq 0 ] && ! echo "$stat_output" | grep -q "<not supported>"; then
> >>> +        echo "supported"
> >>> +    elif [ $stat_result -eq 0 ]; then
> >>> +        echo "not supported"
> >>> +    # return value 255 when the required permission for the event is not set
> >>> +    elif [ $stat_result -eq 255 ] && echo "$stat_output" | grep -q "No permission"; then
> >>> +        echo "no permission to enable"
> >>> +    # return value 255 in case of resource busy during parallel testing of events
> >>> +    elif [ $stat_result -eq 255 ] && echo "$stat_output" | grep -q "Device or resource busy"; then
> >>> +        echo "resource busy"
> >>> +    # return value 129 when trying to run 'perf stat' with a non-existent event
> >>> +    elif [ $stat_result -eq 129 ] && echo "$stat_output" | grep -q "Bad event name"; then
> >>> +        echo "Fail: Bad event name"
> >>> +        echo "$stat_output"
> >>> +        exit 1
> >>> +    else
> >>> +        echo "Fail: Unknown return value $stat_result"
> >>> +        echo "$stat_output"
> >>> +        exit 1
> >>>      fi
> >>> +  else
> >>> +      echo "Fail: Event '$p' not printed in:"
> >>> +      echo "$stat_output"
> >>> +      exit 1
> >>>    fi
> >>>  done
> >>>  
> >>> -- 
> >>> 2.43.0
> >>>
> > 
