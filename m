Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F90517C7C4;
	Mon, 12 Aug 2024 13:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723468896; cv=none; b=PaSwSo9yf16XX2BcVhFVPCvU2IhtpmflgdmyyQihxSZZnqU36Moo2bd9KuHySUw4GSad6BHAs4puxApXJCMf8l2u6Omto4SfPXpoO8UMfOgfSB70zG1Yh+evUkiv+Uc9ioXRjxvhNE9t4XBWLHKhs/IMP8IC9nX6ICkK4ldTaLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723468896; c=relaxed/simple;
	bh=YXdQQVRX9iCPihChy5jHJsCCXjCOLQlReWghD978IR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zlo9qlH+snub04D52zpaGvYt4QwMo930aCnr0S0yCeQHBsH6QjKIlGo/PyT+AfkLxQphOZ7kGrWUCAswyFlLdIBzFj52OTdYhiqAdG8htKXgc7OsKncXOGoMaM9Z+eSVTKS7bZPzn4Ozz35dUO7FMM5V0JLO6Dlz+gJ8q0KbAfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EPpmrtk2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EPpmrtk2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 828F5C4AF15;
	Mon, 12 Aug 2024 13:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723468896;
	bh=YXdQQVRX9iCPihChy5jHJsCCXjCOLQlReWghD978IR0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EPpmrtk2aBn0Iu4dRbjrWUUVo9RyLAGJ4l9IIe1KBQfcWmcj3Q3HhbHv1LJhjrjTh
	 1iEiekO9ilUAze8On+j2i/UIvR4qbw1OkaA8GjBHuyMEBF44DfxEueryYDZdXx66nz
	 +NvT+OPFS57f9G7aqPij4CVumoTZ2dGiuk7B3fd+IisbgzOsmfTWF813U+t7m3pAoa
	 zh/+tEA1fAiI9bqz+dwY0XffnvLbJlax9VZDU+n26MkCtsiAl/nI/BqpiAn1+bZXUu
	 GLjz7VqMTGMmEi4XS7Jmw7XXFIB9lWu6mWRm9T1zLu2HArg9rJxy7VZ/rzzjqbF1Ot
	 ER3xyWz6lnPMg==
Date: Mon, 12 Aug 2024 10:21:32 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: vmolnaro@redhat.com
Cc: Michael Petlan <mpetlan@redhat.com>, linux-perf-users@vger.kernel.org,
	acme@redhat.com, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Veronika Molnarova <vmolnaro@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] perf test record.sh: Raise limit of open file
 descriptors
Message-ID: <ZroMXJoNXCsh2ghd@x1>
References: <ZiqoWj3f-P3ChlWa@x1>
 <20240429085721.10122-1-vmolnaro@redhat.com>
 <alpine.LRH.2.20.2405211127360.4040@Diego>
 <ZroLGg6W9DKsexpp@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZroLGg6W9DKsexpp@x1>

On Mon, Aug 12, 2024 at 10:16:10AM -0300, Arnaldo Carvalho de Melo wrote:
> On Tue, May 21, 2024 at 11:27:56AM +0200, Michael Petlan wrote:
> > On Mon, 29 Apr 2024, vmolnaro@redhat.com wrote:
> > > From: Veronika Molnarova <vmolnaro@redhat.com>
> > > 
> > > Subtest for system-wide record with '--threads=cpu' option fails due
> > > to a limit of open file descriptors on systems with 128 or more CPUs
> > > as the default limit is set to 1024.
> > > 
> > > The number of open file descriptors should be slightly above
> > > nmb_events*nmb_cpus + nmb_cpus(for perf.data.n) + 4*nmb_cpus(for pipes),
> > > which equals 8*nmb_cpus. Therefore, temporarily raise the limit to
> > > 16*nmb_cpus for the test.
> > > 
> > > Signed-off-by: Veronika Molnarova <vmolnaro@redhat.com>
> > 
> > Acked-by: Michael Petlan <mpetlan@redhat.com>
> 
> b4 got confused, I'll pick the rigth version manually...

And you forgot to add the perf tools reviewers, as listed in
MAINTAINERS, you can get the list of people who should be on the Cc
using:

⬢[acme@toolbox perf-tools-next]$ scripts/get_maintainer.pl tools/perf/tests/shell/record.sh
Peter Zijlstra <peterz@infradead.org> (supporter:PERFORMANCE EVENTS SUBSYSTEM)
Ingo Molnar <mingo@redhat.com> (supporter:PERFORMANCE EVENTS SUBSYSTEM)
Arnaldo Carvalho de Melo <acme@kernel.org> (supporter:PERFORMANCE EVENTS SUBSYSTEM,commit_signer:3/4=75%)
Namhyung Kim <namhyung@kernel.org> (supporter:PERFORMANCE EVENTS SUBSYSTEM,commit_signer:1/4=25%)
Mark Rutland <mark.rutland@arm.com> (reviewer:PERFORMANCE EVENTS SUBSYSTEM)
Alexander Shishkin <alexander.shishkin@linux.intel.com> (reviewer:PERFORMANCE EVENTS SUBSYSTEM)
Jiri Olsa <jolsa@kernel.org> (reviewer:PERFORMANCE EVENTS SUBSYSTEM)
Ian Rogers <irogers@google.com> (reviewer:PERFORMANCE EVENTS SUBSYSTEM)
Adrian Hunter <adrian.hunter@intel.com> (reviewer:PERFORMANCE EVENTS SUBSYSTEM,commit_signer:1/4=25%,authored:1/4=25%,added_lines:7/55=13%,removed_lines:1/1=100%)
"Liang, Kan" <kan.liang@linux.intel.com> (reviewer:PERFORMANCE EVENTS SUBSYSTEM,commit_signer:1/4=25%,authored:1/4=25%,added_lines:30/55=55%)
Athira Rajeev <atrajeev@linux.vnet.ibm.com> (commit_signer:1/4=25%,authored:1/4=25%)
Veronika Molnarova <vmolnaro@redhat.com> (authored:1/4=25%,added_lines:17/55=31%)
linux-perf-users@vger.kernel.org (open list:PERFORMANCE EVENTS SUBSYSTEM)
linux-kernel@vger.kernel.org (open list:PERFORMANCE EVENTS SUBSYSTEM)
⬢[acme@toolbox perf-tools-next]$


 
> ⬢[acme@toolbox perf-tools-next]$ b4 am -ctsl --cc-trailers 20240429085721.10122-1-vmolnaro@redhat.com
> Grabbing thread from lore.kernel.org/all/20240429085721.10122-1-vmolnaro@redhat.com/t.mbox.gz
> Checking for newer revisions
> Grabbing search results from lore.kernel.org
> Analyzing 7 messages in the thread
> WARNING: duplicate messages found at index 1
>    Subject 1: perf test record.sh: Raise limit of open file descriptors
>    Subject 2: perf test record.sh: Raise limit of open file descriptors
>   2 is not a reply... assume additional patch
> Looking for additional code-review trailers on lore.kernel.org
> Will use the latest revision: v2
> You can pick other revisions using the -vN flag
> Checking attestation on all messages, may take a moment...
> ---
>   ✓ [PATCH v2] perf test record.sh: Raise limit of open file descriptors
>     + Link: https://lore.kernel.org/r/20240311081127.7652-1-vmolnaro@redhat.com (✓ DKIM/kernel.org)
>     + Acked-by: Michael Petlan <mpetlan@redhat.com> (✓ DKIM/redhat.com)
>     + Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
>   ✓ [PATCH v2] perf test record.sh: Raise limit of open file descriptors
>     + Acked-by: Michael Petlan <mpetlan@redhat.com> (✓ DKIM/redhat.com)
>     + Link: https://lore.kernel.org/r/20240429085721.10122-1-vmolnaro@redhat.com
>     + Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
>   ---
>   ✓ Signed: DKIM/redhat.com
> ---
> Total patches: 2
> ---
>  Link: https://lore.kernel.org/r/20240311081127.7652-1-vmolnaro@redhat.com
>  Base: not specified
>        git am ./v2_20240311_vmolnaro_perf_test_record_sh_raise_limit_of_open_file_descriptors.mbx
> ⬢[acme@toolbox perf-tools-next]$
> 
> > > ---
> > > Reworked the patch as the testfile has already changed since the patch
> > > was sent causing the applying to fail, now applying upstream without
> > > problems.
> > >  tools/perf/tests/shell/record.sh | 17 +++++++++++++++++
> > >  1 file changed, 17 insertions(+)
> > > 
> > > diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
> > > index 3d1a7759a7b2..344c0e40ebe8 100755
> > > --- a/tools/perf/tests/shell/record.sh
> > > +++ b/tools/perf/tests/shell/record.sh
> > > @@ -21,6 +21,15 @@ testprog="perf test -w thloop"
> > >  cpu_pmu_dir="/sys/bus/event_source/devices/cpu*"
> > >  br_cntr_file="/caps/branch_counter_nr"
> > >  br_cntr_output="branch stack counters"
> > > +default_fd_limit=$(ulimit -n)
> > > +# With option --threads=cpu the number of open file descriptors should be
> > > +# equal to sum of:    nmb_cpus * nmb_events (2+dummy),
> > > +#                     nmb_threads for perf.data.n (equal to nmb_cpus) and
> > > +#                     2*nmb_cpus of pipes = 4*nmb_cpus (each pipe has 2 ends)
> > > +# All together it needs 8*nmb_cpus file descriptors plus some are also used
> > > +# outside of testing, thus raising the limit to 16*nmb_cpus
> > > +min_fd_limit=$(($(getconf _NPROCESSORS_ONLN) * 16))
> > > +
> > >  
> > >  cleanup() {
> > >    rm -rf "${perfdata}"
> > > @@ -190,11 +199,19 @@ test_branch_counter() {
> > >    echo "Basic branch counter test [Success]"
> > >  }
> > >  
> > > +# raise the limit of file descriptors to minimum
> > > +if [[ $default_fd_limit -lt $min_fd_limit ]]; then
> > > +       ulimit -n $min_fd_limit
> > > +fi
> > > +
> > >  test_per_thread
> > >  test_register_capture
> > >  test_system_wide
> > >  test_workload
> > >  test_branch_counter
> > >  
> > > +# restore the default value
> > > +ulimit -n $default_fd_limit
> > > +
> > >  cleanup
> > >  exit $err
> > > -- 
> > > 2.43.0
> > > 
> > > 
> > 
