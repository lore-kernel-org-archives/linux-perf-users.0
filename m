Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5281F171
	for <linux-perf-users@vger.kernel.org>; Fri,  7 Jun 2024 18:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717785496; cv=none; b=Q/HOjXEsMkZyuYfphi9Edl6cx639gyP1KzxCgHkyn062plJW42l0i+4Vv7uFIsUnWIQ37SBcr0StA0Q5zapcCbJdL32mwoZUYWdsqhlDRYMwxh8G11/EYW3YynX446UxyfEHqNfapGDnOGjZiXE6yzycsW5y/TSbgk/7Z9QifPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717785496; c=relaxed/simple;
	bh=5C+ad96IepJW4nHeY1YbCJI7jGi6VMi7S6v95ZEt5qI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MFAjjD+OWesg6J6OUeZ4mE/Vt/BxALpvDvYgl3garGz+Kqdh9DJQfsHZd+djxsAVGZFKloNm0Vs/XuSyIJm4FY/UANJ5RH/epOlj1amlN2BjO9kLmPQw8Vy/DYiChuVDH4rSmg0AQWpJe3YQ8oh801OCRW0ukbgdm9jBZ7RhZ0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MnYta17B; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MnYta17B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89384C2BBFC;
	Fri,  7 Jun 2024 18:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717785495;
	bh=5C+ad96IepJW4nHeY1YbCJI7jGi6VMi7S6v95ZEt5qI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MnYta17B8zSd8ynS1WuxrqnkNznxWxkaYjiy+n0mwIVbNZ06LMcKQVaioJ9LzUrNv
	 gECoMS4h5T51CiZFsIBr9No0M+d8XrnNzbvZwj3p+45ypiwTxqcc359ktdLQB4bhXy
	 f+lqlLO23TGykrv435aIbW+UZw1cL26yQY8P1+FeAM9Xv4SPPtyhIzaN9aA4CAtdev
	 If+rVt1PYmHjE5X7LavP32o3MUUUYmeBksJ0QQxibYjubVr68ABwQMk9JJSHv1SzpZ
	 VL0+iF4MH0oSxOD9s/jhkBe3ty2mwfQF53Cmaq+jp47+YsgHvXSdA8SIVCfjpvaB+7
	 qBfSzjM7MzRrQ==
Date: Fri, 7 Jun 2024 11:38:14 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Veronika Molnarova <vmolnaro@redhat.com>
Cc: linux-perf-users@vger.kernel.org, acme@kernel.org, acme@redhat.com,
	mpetlan@redhat.com
Subject: Re: [PATCH] perf test stat_bpf_counter.sh: Remove comparison of
 separate runs
Message-ID: <ZmNTllfoRvauEaK5@google.com>
References: <20240604153111.105548-1-vmolnaro@redhat.com>
 <Zl-x8uob6NT3HlfT@google.com>
 <6a33f2f6-fd69-4e90-8cd5-a73d393c20a1@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6a33f2f6-fd69-4e90-8cd5-a73d393c20a1@redhat.com>

On Thu, Jun 06, 2024 at 03:09:43PM +0200, Veronika Molnarova wrote:
> 
> 
> On 6/5/24 02:31, Namhyung Kim wrote:
> > On Tue, Jun 04, 2024 at 05:31:11PM +0200, vmolnaro@redhat.com wrote:
> >> From: Veronika Molnarova <vmolnaro@redhat.com>
> >>
> >> The test has been failing for some time when two separate runs of
> >> perf benchmarks are recorded and the counts of the samples are compared,
> >> while once the recording was done with option --bpf-counters and once
> >> without it. It is expected that the count of the samples should within
> >> a certain range, firstly the difference should have been within 10%,
> >> which was then later raised to 20%. However, the test case keeps failing
> >> on certain architectures as recording the same benchmark can provide
> >> completely different counts samples based on the current load of the
> >> system.
> >>
> >> Sampling two separate runs on intel-eaglestream-spr-13 of "perf stat
> >> --no-big-num -e cycles -- perf bench sched messaging -g 1 -l 100 -t":
> >>
> >>  Performance counter stats for 'perf bench sched messaging -g 1 -l 100 -t':
> >>
> >>          396782898      cycles
> >>
> >>        0.010051983 seconds time elapsed
> >>
> >>        0.008664000 seconds user
> >>        0.097058000 seconds sys
> >>
> >>  Performance counter stats for 'perf bench sched messaging -g 1 -l 100 -t':
> >>
> >>         1431133032      cycles
> >>
> >>        0.021803714 seconds time elapsed
> >>
> >>        0.023377000 seconds user
> >>        0.349918000 seconds sys
> >>
> >> , which is ranging from 400mil to 1400mil samples.
> >>
> >> From the testing point of view, it does not make sense to compare two
> >> separate runs against each other when the conditions may change
> >> significantly. Remove the comparison of two separate runs and check only
> >> whether the stating works as expected for the --bpf-counters option. Compare
> >> the samples count only when the samples are recorded simultaneously
> >> ensuring the same conditions.
> > 
> > Hmm.. but having a test which checks if the output is sane can be
> > useful.  If it's a problem of dynamic changes in cpu cycles, maybe
> > we can use 'instructions' event instead (probably with :u) to get
> > more stable values?
> > 
> > Thanks,
> > Namhyung
> > 
> 
> Well but isn't it better to check the sanity of the output if the counters are recorded
> for a load with the same conditions as has been added in patch d9bd1d4
> "perf test bpf-counters: Add test for BPF event modifier" utilizing the event modifiers: 
> perf stat --no-big-num -e cycles/name=base_cycles/,cycles/name=bpf_cycles/b -- $workload?
> Comparing two separate runs is more based on the stability of the workload than the
> bpf-counters option, which then causes the issue of defining the threshold of what values
> are still within the sane range.

Right, it'd be better if we can run once and the compare the counters.
But I don't think if --bpf-counters works only for a specific event.

> 
> But you are right that another possible fix for this issue is to change the workload or the
> event to get some more stable values, which could be comparable.

Yep, let's try with 'instructions:u'.

Thanks,
Namhyung
