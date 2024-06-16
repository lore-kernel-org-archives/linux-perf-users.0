Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7A923DE
	for <linux-perf-users@vger.kernel.org>; Sun, 16 Jun 2024 03:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718510177; cv=none; b=MFMKMQBRQfL+0DUmYV6sO9jfYinKEcWCDscN+t3pOizoqfiLzVXI+vbeVafbpLUusGMS40VLCYeuKZTN6DUAs0xhNoKXt+PqstgjpHz8MyzWeqdZSENNJi+7Ygq/2s+QapCndNunlBaDXKS+MzqMVgTBz+Y3QeSEjC0xdek4OME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718510177; c=relaxed/simple;
	bh=qiRQdMrDaZnTKsyPqjkqTIwelaI2cKFQQ2ak3bzDeuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jqlvg2f/+F/d2GlGxmen49EFsOB1FhqnV3kYsKhBIWEd2P+bwiFWDb5gXFerGLg0+yenYxDuWjAMIedZEEijn+RoyxR1aDclGr5+aexyE1Iqfty7EIo3r/+Oq+KE8No0WjJbT/ShtUX32baT1zl7jVF1AvRkVUYmv5Ah/uwirv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qJJg0+TZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qJJg0+TZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BB06C2BBFC;
	Sun, 16 Jun 2024 03:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718510176;
	bh=qiRQdMrDaZnTKsyPqjkqTIwelaI2cKFQQ2ak3bzDeuE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qJJg0+TZ9Nlymq6zzY+R92tY0Bs/QE6rcQotZlDOloU6rwqwTFiB3ZQHfqpVWugNx
	 BgKn0g+NxUQaacSj5F7IQ/XeC7y3B01CCViT/enRUPfQQbUcGuYadSlOD/u06hChmI
	 bzTauY1BLMxv2aVkuXlJaqzQuR+37CV5cqUVn2O/P1Y+46QZtnukBiAkNrTw9kpSYK
	 AVRyDlz8FFy/D+q6bpQsI24r0sora/UYMVWh47jH0cDX+Z50a1ZQkGYJptCBSMwvB0
	 DWW+yqF5gOBw8CFEWje6jqFF76edsHWVJbd+kI7mG6G8FLCZRmC3WPlwITYaeFmn/e
	 kakBHJU4I0+hw==
Date: Sat, 15 Jun 2024 20:56:14 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Michael Petlan <mpetlan@redhat.com>
Cc: vmolnaro@redhat.com, linux-perf-users@vger.kernel.org, acme@kernel.org,
	acme@redhat.com
Subject: Re: [PATCH] perf test stat_bpf_counter.sh: Remove comparison of
 separate runs
Message-ID: <Zm5iXuQFE6TmztkC@google.com>
References: <20240604153111.105548-1-vmolnaro@redhat.com>
 <Zl-x8uob6NT3HlfT@google.com>
 <alpine.LRH.2.20.2406131407370.4040@Diego>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.20.2406131407370.4040@Diego>

Hello,

On Thu, Jun 13, 2024 at 04:20:58PM +0200, Michael Petlan wrote:
> On Tue, 4 Jun 2024, Namhyung Kim wrote:
> > On Tue, Jun 04, 2024 at 05:31:11PM +0200, vmolnaro@redhat.com wrote:
> > > From: Veronika Molnarova <vmolnaro@redhat.com>
> > > 
> > > The test has been failing for some time when two separate runs of
> > > perf benchmarks are recorded and the counts of the samples are compared,
> > > while once the recording was done with option --bpf-counters and once
> > > without it. It is expected that the count of the samples should within
> > > a certain range, firstly the difference should have been within 10%,
> > > which was then later raised to 20%. However, the test case keeps failing
> > > on certain architectures as recording the same benchmark can provide
> > > completely different counts samples based on the current load of the
> > > system.
> > > 
> > > Sampling two separate runs on intel-eaglestream-spr-13 of "perf stat
> > > --no-big-num -e cycles -- perf bench sched messaging -g 1 -l 100 -t":
> > > 
> > >  Performance counter stats for 'perf bench sched messaging -g 1 -l 100 -t':
> > > 
> > >          396782898      cycles
> > > 
> > >        0.010051983 seconds time elapsed
> > > 
> > >        0.008664000 seconds user
> > >        0.097058000 seconds sys
> > > 
> > >  Performance counter stats for 'perf bench sched messaging -g 1 -l 100 -t':
> > > 
> > >         1431133032      cycles
> > > 
> > >        0.021803714 seconds time elapsed
> > > 
> > >        0.023377000 seconds user
> > >        0.349918000 seconds sys
> > > 
> > > , which is ranging from 400mil to 1400mil samples.
> > > 
> > > From the testing point of view, it does not make sense to compare two
> > > separate runs against each other when the conditions may change
> > > significantly. Remove the comparison of two separate runs and check only
> > > whether the stating works as expected for the --bpf-counters option. Compare
> > > the samples count only when the samples are recorded simultaneously
> > > ensuring the same conditions.
> > 
> > Hmm.. but having a test which checks if the output is sane can be
> > useful.  If it's a problem of dynamic changes in cpu cycles, maybe
> > we can use 'instructions' event instead (probably with :u) to get
> > more stable values?
> 
> Hello.
> 
> As far as I understand it, nowadays, the test checks two things:
> 
>   test_bpf_counters()
>     record $workload twice (with and without --bpf-counters)
> 	check that there are numeric results
> 	compare the results
> 
>   test_bpf_modifier()
>     record $workload once with and without modifier (which should be what
> 	--bpf-counters switch does to the events, right?)
> 	check that there are numeric results
> 	compare the results
> 	
> The problem here is not only the "dynamic changes in cpu-cycles", it
> is rather in the testcase design itself. A testcase that compares two
> metrics should get rid of all possible variable effects that influence it.
> 
> The second function actually compares the values correctly, since they
> are measured against the same identical workload.
> 
> So, in my opinion, a better test design would be:
> 
>   (1) check that record without --bpf-counters works as a reference run

Do you mean by `perf stat record`?  Or saving the output of `perf stat`
in a text file?


>   (2) check that record with --bpf-counters works too
>       (if not, we may compare to (1) to find out if whole `record` is broken
> 	  or just the --bpf-counters option)

Ditto.


>   (3) possibly run `perf evlist` to check that --bpf-counters has added the
>       '/b' modifier

The `perf evlist` would work only for `perf stat record`.  Then I think
it's a completely new test case.


>   (4) check with versus without "b", such as current test_bpf_modifier()
>       function does
> 
> I like what Veronika suggests, it is basically the above, except of (3).
> 
> ...
> 
> In case we want preserve two separate runs in test_bpf_counters() _and_
> also check the numbers, then we should:
>   - use some more predictable workload:
>     - in an ideal case a statically linked simple binary
> 	- in less-than-ideal case `perf test -w something`
>   - use instructions instead of cycles
> However, I don't like that idea very much, because of the design principles
> mentioned above.

I understand it's not ideal.. maybe it's fine not to check the numbers
here because we do that in the test_bpf_modifier.  But it'd be nice to
have that.  Let's try with instructions event first, change it later if
it doesn't go well.

Thanks,
Namhyung

