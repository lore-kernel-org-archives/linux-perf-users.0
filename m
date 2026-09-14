Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE2A1F4176;
	Mon, 14 Sep 2026 22:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789424244; cv=none; b=VekdLlqcTeQFReUPhFHPgLNKgZJsCqEic5Kl3A1aKCNC0HOzCoG6DB8GIDhgBI530ZB6lyiYyvAq+rpvIOFo/49j4ERQ/DzgKeZ2wZwHLHkbZFvSrlwVKcoUuw/jNPYcUKX+aMWQLtDNP0lDfePtM4iJeuGrjPryQt8ONc4yZB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789424244; c=relaxed/simple;
	bh=VmmGQy/SFyLE1yqmNp+unucn6PSxM6ocSME+1Chp/bs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZL/tz6BsXzn39DaNyxbMj1oEkm1zlaMVvvx6+piFxITsLv63ZNt2HSW4nF0Eyzrnn0/rXdcp/zrXK/w27OIwfoN3yIwzqetjGDW01OAD2OaKUzqVqDl4MNHoVODNARcNbpX8sa8pVl5hSwZvWg3cODqWsSxj783D238TdSZBstw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ks1EWNsG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ks1EWNsG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8D981F000FF;
	Mon, 14 Sep 2026 22:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789424243;
	bh=xlmw5Sp1urhZVdxH5bFJ0qTtxuqcS5RQxs8x0o0CImI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ks1EWNsGCj/8znYwhtVNtNPK8vD5mn84FhSrLpn+4ltFOKwo/u99XA7d7qbCHv5F/
	 DuWP8oEKgEQiEIKLLCihsIO2s6BWTx+Uk3m8z/7v+8gHtOIOTWFIEBuZHL8jFLu2cO
	 zVBJYa2rzX5OnEGhJKthAbQgS0gpSn3Rjp576w5REs2FjberPnFfJkIfvBVYa9dxf/
	 E5AHClCpWIc1LYuZdu3weXiR/JUKffyznWDdkEBSCK3JGs1Uk5mmPb/00T5AMdpACW
	 +DyWoop+SRcSDiJ0cyswOEoutKHf/aYOV+DNCKJc+DDntoYOm8mC8Cecj1KYHqFj3R
	 Q4mzx2dRec0kA==
Date: Mon, 14 Sep 2026 19:17:20 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH 1/8] perf test: Skip data_type_profiling when the PMU
 cannot record memory events
Message-ID: <aqhycPougjUadYif@x2>
References: <20260913222821.3353-1-acme@kernel.org>
 <20260913222821.3353-2-acme@kernel.org>
 <aqdOXOH6KaBTT_b_@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aqdOXOH6KaBTT_b_@google.com>

On Sun, Sep 13, 2026 at 06:31:08PM -0700, Namhyung Kim wrote:
> On Sun, Sep 13, 2026 at 07:28:13PM -0300, Arnaldo Carvalho de Melo wrote:
> > From: Arnaldo Carvalho de Melo <acme@redhat.com>
> > 
> > The test records with 'perf mem record' in per-thread mode and its only
> > guard matches one specific message:
> > 
> >   perf mem record -o /dev/null -- true 2>&1 | \
> >         grep -q "failed: no PMU supports the memory events" && exit 2
> > 
> > A PMU that has memory events but refuses them per-thread falls through
> > it, and AMD IBS does:
> > 
> >   $ perf mem record -o /dev/null -- true
> >   Error:
> >   Failure to open event 'ibs_op/ldlat=0/u' on PMU 'ibs_op' which will be removed.
> >   Invalid event (ibs_op/ldlat=0/u) in per-thread mode, enable system wide with '-a'.
> >   Error:
> >   Failure to open any events for recording.
> 
> Maybe we need to add a fallback logic to add 'swfilt' term for ibs_op.

Patch 9 in the latest series uses it, take a look.

- Arnaldo
 
> > What follows is not a skip either.  The script runs under 'set -e', so
> > the bare 'perf mem record' in test_basic_annotate() aborts it through the
> > EXIT trap, which reports a signal that never happened and exits 1:
> > 
> >   Basic Rust perf annotate test
> >   Unexpected signal in test_basic_annotate
> > 
> > so 'perf test' turns "this PMU cannot record these events" into a test
> > failure:
> > 
> >   $ perf test "data type profiling"
> >    87: perf data type profiling tests             : FAILED!
> > 
> > Assisted-by: LLM
> > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>
> 
> Thanks,
> Namhyung
> 
> > ---
> >  tools/perf/tests/shell/data_type_profiling.sh | 46 +++++++++++++++----
> >  1 file changed, 36 insertions(+), 10 deletions(-)
> > 
> > diff --git a/tools/perf/tests/shell/data_type_profiling.sh b/tools/perf/tests/shell/data_type_profiling.sh
> > index eca694600a0478d2..a916c410274aa888 100755
> > --- a/tools/perf/tests/shell/data_type_profiling.sh
> > +++ b/tools/perf/tests/shell/data_type_profiling.sh
> > @@ -19,6 +19,15 @@ perfout=$(mktemp /tmp/__perf_test.perf.out.XXXXX)
> >  perf mem record -o /dev/null -- true  2>&1 | \
> >    		grep -q "failed: no PMU supports the memory events" && exit 2
> >  
> > +# Skip if per-thread mem record is not supported on this PMU (e.g. AMD IBS
> > +# needs system-wide '-a'): it is what the test records with below, and a
> > +# failing record must not be reported as a test failure.
> > +if ! perf mem record -o /dev/null -- true 2>/dev/null
> > +then
> > +  echo "Skip: cannot record memory events on this PMU"
> > +  exit 2
> > +fi
> > +
> >  cleanup() {
> >    rm -rf "${perfdata}" "${perfout}"
> >    rm -rf "${perfdata}".old
> > @@ -52,25 +61,42 @@ test_basic_annotate() {
> >      index=1 ;;
> >    esac
> >  
> > +  # Under 'set -e' a bare failing command aborts the script through the EXIT
> > +  # trap, so the commands that report a failure have to be the condition of
> > +  # an 'if' for that reporting to ever happen.
> >    if [ "x${mode}" == "xBasic" ]
> >    then
> > -    perf mem record -o "${perfdata}" ${testprogs[$index]} 2> /dev/null
> > +    if ! perf mem record -o "${perfdata}" ${testprogs[$index]} 2> /dev/null
> > +    then
> > +      echo "${mode} annotate [Failed: perf record]"
> > +      err=1
> > +      return
> > +    fi
> >    else
> > -    perf mem record -o - ${testprogs[$index]} 2> /dev/null > "${perfdata}"
> > -  fi
> > -  if [ "x$?" != "x0" ]
> > -  then
> > -    echo "${mode} annotate [Failed: perf record]"
> > -    err=1
> > -    return
> > +    if ! perf mem record -o - ${testprogs[$index]} 2> /dev/null > "${perfdata}"
> > +    then
> > +      echo "${mode} annotate [Failed: perf record]"
> > +      err=1
> > +      return
> > +    fi
> >    fi
> >  
> >    # Generate the annotated output file
> >    if [ "x${mode}" == "xBasic" ]
> >    then
> > -    perf annotate --code-with-type -i "${perfdata}" --stdio --percent-limit 1 2> /dev/null > "${perfout}"
> > +    if ! perf annotate --code-with-type -i "${perfdata}" --stdio --percent-limit 1 2> /dev/null > "${perfout}"
> > +    then
> > +      echo "${mode} annotate [Failed: perf annotate]"
> > +      err=1
> > +      return
> > +    fi
> >    else
> > -    perf annotate --code-with-type -i - --stdio 2> /dev/null --percent-limit 1 < "${perfdata}" > "${perfout}"
> > +    if ! perf annotate --code-with-type -i - --stdio 2> /dev/null --percent-limit 1 < "${perfdata}" > "${perfout}"
> > +    then
> > +      echo "${mode} annotate [Failed: perf annotate]"
> > +      err=1
> > +      return
> > +    fi
> >    fi
> >  
> >    # check if it has the target data type
> > -- 
> > 2.55.0
> > 
