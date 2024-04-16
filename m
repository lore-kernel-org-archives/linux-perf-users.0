Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E86A125B2
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Apr 2024 15:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713281300; cv=none; b=IgKdcSVhQ5isZZIyLDoSHzXar0seEYLI0ovYQe/y1iN5E4cgFRue891mEHMtxTiC9XG77eenGNikehVHGWGB+jonUBbMfSn5VVVEJGVix7PcHq31u5V5hyLBmKnnbm5MY43aRjO1zgf++iD53j2yEFvMuap3iVBOdRUAgPyYhgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713281300; c=relaxed/simple;
	bh=1Bk8hOwC03U9C95tHj5FhASGzNlCzzjgtHhHXtF9yYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pvixPwN+x/4yLNFKSHYqxyIMFWNofojoFjdR4PbQcTP08QKZZF04rmkfJF73tAfdte0nIDBrEmfWiy6+dA/HIh8scxCa/wVh6hxpnoqricOJF2Ds99dCMRYu21qrsYi/hcJN/Uxo3PhYfHyHEw7KeJLfmS4IFWG8zIqoZWng9UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DcJJNs6V; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DcJJNs6V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 436C0C113CE;
	Tue, 16 Apr 2024 15:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713281299;
	bh=1Bk8hOwC03U9C95tHj5FhASGzNlCzzjgtHhHXtF9yYc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DcJJNs6VlQehgmOkcTnTPLu3kfnft85nOb7aGsLLqYAGX51KfNd4K/bgJ+JOZg3sC
	 bBvNBcDXeu3OJXwhMbotrBbkMeNSh04BpsC2A6eQq6vuvuvEK4oi/iTI6ZFY2JxDKj
	 9SMe6DZKvb9cBsA2uqTHtQxY7CoyMi8ML9zOTNIW3iJtFnB6WzZDWv6PlXNb7ayIPz
	 g9jAhs/+uY9vzChhmgAwKEifNKcEr3FMV9QgtgnzhWMf5shulW2RVCmaIG6y6DVImf
	 yvMjdmJsO0b+q5iVIMLhnGp6S1ZC9PziS8C6JzPMuR6ycmx3eIO3BPmulwPLimPNMR
	 wC7VDvK7uqoHw==
Date: Tue, 16 Apr 2024 12:28:16 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Veronika Molnarova <vmolnaro@redhat.com>
Cc: Ian Rogers <irogers@google.com>, linux-perf-users@vger.kernel.org,
	Michael Petlan <mpetlan@redhat.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Kajol Jain <kjain@linux.ibm.com>
Subject: Re: [PATCH] perf test stat_all_pmu.sh: Parse return value of perf
 stat
Message-ID: <Zh6ZEGOfgcEfwha4@x1>
References: <20240409130240.13973-1-vmolnaro@redhat.com>
 <CAP-5=fVzs9832tK9nrxL++DZXwNV0eLmMwtd4ZNqkp4b512UHQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVzs9832tK9nrxL++DZXwNV0eLmMwtd4ZNqkp4b512UHQ@mail.gmail.com>

On Tue, Apr 16, 2024 at 08:03:41AM -0700, Ian Rogers wrote:
> On Tue, Apr 9, 2024 at 6:03 AM <vmolnaro@redhat.com> wrote:
> >
> > From: Veronika Molnarova <vmolnaro@redhat.com>
> >
> > With the MR a381bd3615de6 ('powerpc/hv-gpci: Fix the
> > H_GET_PERF_COUNTER_INFO hcall return value checks') the perf stat for
> > hv_gpci events without required permission set returns an error value
> > of -1 to differentiate the output from the unsupported events. The
> > stat_all_pmu test, however, exits immediately if any command exits with
> > a non-zero value due to 'set -e' option.
> >
> > Remove the 'set -e' option from the test and rework the test case to log
> > the status of the event for better maintainability. Instead of exiting
> > immediately after 'perf stat' ends with a non-zero value, check the
> > return value and output of the 'perf stat' command with appriopriate action.
> 
> nit: s/appriopriate/appropriate/
> 
> There was a similar issue with metric groups that should be on its way
> to landing:
> https://lore.kernel.org/lkml/20240403164818.3431325-1-irogers@google.com/

Cool, looks similar indeed, Veronika, can you consider reviewing Ian's
patch and providing a Reviewed-by: for it?

And also please check Ian's suggestions for your patch, below:
 
> > ---
> >  tools/perf/tests/shell/stat_all_pmu.sh | 36 ++++++++++++++++++--------
> >  1 file changed, 25 insertions(+), 11 deletions(-)
> >
> > diff --git a/tools/perf/tests/shell/stat_all_pmu.sh b/tools/perf/tests/shell/stat_all_pmu.sh
> > index c77955419173..d9f0d2100baa 100755
> > --- a/tools/perf/tests/shell/stat_all_pmu.sh
> > +++ b/tools/perf/tests/shell/stat_all_pmu.sh
> > @@ -2,21 +2,35 @@
> >  # perf all PMU test
> >  # SPDX-License-Identifier: GPL-2.0
> >
> > -set -e
> >
> >  # Test all PMU events; however exclude parametrized ones (name contains '?')
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
> > +    # return value 0 if counters gets printed either if the event is supported or not
> > +    if [ $stat_result -eq 0 ] && ! echo "$stat_output" | grep -q "<not supported>"; then
> > +        echo "supported"
> > +    elif [ $stat_result -eq 0 ]; then
> > +        echo "not supported"
> > +    # return value 255 when the required pemission for the event is not set
> 
> nit: s/pemission/permission/
> 
> > +    elif [ $stat_result -eq 255 ] && echo "$stat_output" | grep -q "No permission"; then
> > +        echo "no permission to enable"
> > +    # return value 129 when trying to run 'perf stat' with a non-existent event
> > +    elif [ $stat_result -eq 129 ] && echo "$stat_output" | grep -q "Bad event name"; then
> > +        echo "Fail: Bad event name"
> > +        echo "$stat_output"
> > +        exit 1
> 
> Something we've been seeing with parallel testing is getting busy
> PMUs. The error looks like:
> ```
> $ sudo bash -c "perf stat -e intel_bts// -a sleep 1; echo $?" & sudo
> bash -c "perf stat -e intel_bts// -a sleep 1; echo $?"
> [2] 953102
> Error:
> The sys_perf_event_open() syscall returned with 16 (Device or resource
> busy) for event (intel_bts//).
> /bin/dmesg | grep -i perf may provide additional information.
> 
> 255
> 
> Performance counter stats for 'system wide':
> 
>     <not counted>      intel_bts//
>                         (0.00%)
> 
>       1.002334792 seconds time elapsed
> 
> 0
> [2]+  Done                    sudo bash -c "perf stat -e intel_bts//
> -a sleep 1; echo $?"
> ```
> 
> To avoid failing for this we probably need something like:
> ```
>    elif [ $stat_result -eq 255 ] && echo "$stat_output" | grep -q
> "Device or resource busy"; then
>        echo "device busy"
> ```
> It'd be great if you could add this.
> 
> Thanks,
> Ian
> 
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
> >
