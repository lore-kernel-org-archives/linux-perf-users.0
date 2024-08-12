Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF401D699
	for <linux-perf-users@vger.kernel.org>; Mon, 12 Aug 2024 13:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723468574; cv=none; b=o6pGEAsp2HfmhIPsox1v92rZUAeWLziSRHRA5Z/hFJe4g6TyLr1QizQehS8DCc49Q/NUq7A2SZgemC0ZCda/bWME40Om04O25r+6eKPc9HSGYTKV7J9GK17DELFCMtLeXEQozZdikjHS6VpW+gUdFjc45R9HA33H4T8wW5VLTf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723468574; c=relaxed/simple;
	bh=Z/I+QOGih+eV4/sd6bWAUGn8NXjVDF6h6Z/NrkOefMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fQEpQbfSiJ3LcrfR8Yj9IlyvdfjYjQGrxjXxf/3A5+Cp3Tx1UsVApF50EvIdvzrqTrYCWJo+6Ly7Gs8fTf3MdU1qDliX8RmHtAzfEguIttgKpSRlukaBVcUungEbbUAg0pN6idL1TcYsBVcqHhpegP92HzjK66JfBz6Xj7P/Zjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FlwPXuTF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FlwPXuTF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CC02C32782;
	Mon, 12 Aug 2024 13:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723468573;
	bh=Z/I+QOGih+eV4/sd6bWAUGn8NXjVDF6h6Z/NrkOefMo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FlwPXuTFX8dcz3Xsmy61EXpSz+AtSpcaGmgecfa5U2seU0lMKKNNI07RtmDhKhz0T
	 6vF97S4WvoCYofU7ckfUTsuCRVk1GfX7kyRd4CIkiW81shJlOn1d7oYjK0jDAW34bJ
	 +oj6jjaiP5wXx4iLaAhCpk20y3LNPjuq7+Z8HU8E0wQySwOuGOWuNinc2cZja4+9Xg
	 4I6i91BhVptPRR5rOuKKzVRyqpT4xaIt0lK4oFt18/HiUMpqJq3s6Q/DDv4EO2iL7h
	 udjOSz/kPwX4NTIDps7/jVtHAhcN2AWUf6hke5cb2ZdLfarDD240uausWSUAJGdmUt
	 5ZL7q2LqQOXLA==
Date: Mon, 12 Aug 2024 10:16:10 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Michael Petlan <mpetlan@redhat.com>
Cc: vmolnaro@redhat.com, linux-perf-users@vger.kernel.org, acme@redhat.com
Subject: Re: [PATCH v2] perf test record.sh: Raise limit of open file
 descriptors
Message-ID: <ZroLGg6W9DKsexpp@x1>
References: <ZiqoWj3f-P3ChlWa@x1>
 <20240429085721.10122-1-vmolnaro@redhat.com>
 <alpine.LRH.2.20.2405211127360.4040@Diego>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alpine.LRH.2.20.2405211127360.4040@Diego>

On Tue, May 21, 2024 at 11:27:56AM +0200, Michael Petlan wrote:
> On Mon, 29 Apr 2024, vmolnaro@redhat.com wrote:
> > From: Veronika Molnarova <vmolnaro@redhat.com>
> > 
> > Subtest for system-wide record with '--threads=cpu' option fails due
> > to a limit of open file descriptors on systems with 128 or more CPUs
> > as the default limit is set to 1024.
> > 
> > The number of open file descriptors should be slightly above
> > nmb_events*nmb_cpus + nmb_cpus(for perf.data.n) + 4*nmb_cpus(for pipes),
> > which equals 8*nmb_cpus. Therefore, temporarily raise the limit to
> > 16*nmb_cpus for the test.
> > 
> > Signed-off-by: Veronika Molnarova <vmolnaro@redhat.com>
> 
> Acked-by: Michael Petlan <mpetlan@redhat.com>

b4 got confused, I'll pick the rigth version manually...

⬢[acme@toolbox perf-tools-next]$ b4 am -ctsl --cc-trailers 20240429085721.10122-1-vmolnaro@redhat.com
Grabbing thread from lore.kernel.org/all/20240429085721.10122-1-vmolnaro@redhat.com/t.mbox.gz
Checking for newer revisions
Grabbing search results from lore.kernel.org
Analyzing 7 messages in the thread
WARNING: duplicate messages found at index 1
   Subject 1: perf test record.sh: Raise limit of open file descriptors
   Subject 2: perf test record.sh: Raise limit of open file descriptors
  2 is not a reply... assume additional patch
Looking for additional code-review trailers on lore.kernel.org
Will use the latest revision: v2
You can pick other revisions using the -vN flag
Checking attestation on all messages, may take a moment...
---
  ✓ [PATCH v2] perf test record.sh: Raise limit of open file descriptors
    + Link: https://lore.kernel.org/r/20240311081127.7652-1-vmolnaro@redhat.com (✓ DKIM/kernel.org)
    + Acked-by: Michael Petlan <mpetlan@redhat.com> (✓ DKIM/redhat.com)
    + Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
  ✓ [PATCH v2] perf test record.sh: Raise limit of open file descriptors
    + Acked-by: Michael Petlan <mpetlan@redhat.com> (✓ DKIM/redhat.com)
    + Link: https://lore.kernel.org/r/20240429085721.10122-1-vmolnaro@redhat.com
    + Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
  ---
  ✓ Signed: DKIM/redhat.com
---
Total patches: 2
---
 Link: https://lore.kernel.org/r/20240311081127.7652-1-vmolnaro@redhat.com
 Base: not specified
       git am ./v2_20240311_vmolnaro_perf_test_record_sh_raise_limit_of_open_file_descriptors.mbx
⬢[acme@toolbox perf-tools-next]$

> > ---
> > Reworked the patch as the testfile has already changed since the patch
> > was sent causing the applying to fail, now applying upstream without
> > problems.
> >  tools/perf/tests/shell/record.sh | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> > 
> > diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
> > index 3d1a7759a7b2..344c0e40ebe8 100755
> > --- a/tools/perf/tests/shell/record.sh
> > +++ b/tools/perf/tests/shell/record.sh
> > @@ -21,6 +21,15 @@ testprog="perf test -w thloop"
> >  cpu_pmu_dir="/sys/bus/event_source/devices/cpu*"
> >  br_cntr_file="/caps/branch_counter_nr"
> >  br_cntr_output="branch stack counters"
> > +default_fd_limit=$(ulimit -n)
> > +# With option --threads=cpu the number of open file descriptors should be
> > +# equal to sum of:    nmb_cpus * nmb_events (2+dummy),
> > +#                     nmb_threads for perf.data.n (equal to nmb_cpus) and
> > +#                     2*nmb_cpus of pipes = 4*nmb_cpus (each pipe has 2 ends)
> > +# All together it needs 8*nmb_cpus file descriptors plus some are also used
> > +# outside of testing, thus raising the limit to 16*nmb_cpus
> > +min_fd_limit=$(($(getconf _NPROCESSORS_ONLN) * 16))
> > +
> >  
> >  cleanup() {
> >    rm -rf "${perfdata}"
> > @@ -190,11 +199,19 @@ test_branch_counter() {
> >    echo "Basic branch counter test [Success]"
> >  }
> >  
> > +# raise the limit of file descriptors to minimum
> > +if [[ $default_fd_limit -lt $min_fd_limit ]]; then
> > +       ulimit -n $min_fd_limit
> > +fi
> > +
> >  test_per_thread
> >  test_register_capture
> >  test_system_wide
> >  test_workload
> >  test_branch_counter
> >  
> > +# restore the default value
> > +ulimit -n $default_fd_limit
> > +
> >  cleanup
> >  exit $err
> > -- 
> > 2.43.0
> > 
> > 
> 
