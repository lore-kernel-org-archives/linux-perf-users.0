Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A222123A6
	for <linux-perf-users@vger.kernel.org>; Mon,  4 Nov 2024 19:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730749927; cv=none; b=KkbZpxbItzpFBqr25k/SBnPVJrlT25hWTokiigVD9TxhpXpJbcDa6q13VcL7WNb77fJXlVA0cTWR0jZjpPM/fMUByFJMzGdKTst2p2DVulaRfqN7Vpl/3JXA+u3mPrOzxErbRjbJoJX/VBaVueD/XhivBGGPUIRP7PNQCp7NWPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730749927; c=relaxed/simple;
	bh=daJVoLWMJgnDAQoF8idqLRpe4+dcNNTu2JiI5rzPbvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=THeTrVAy35wNgSVji5Dxke4TOhy4FY4pfyetQoVLeHwOiOLCCuF3vuEbrQy0OmEPCcson24zU5WmLCXmDu8iuGN5mfdONFkVmZqz18uh40FVjDajc/1dX30dXnV89yYsr8NptoLcL0EtAYHgUORf/FVynebsoAuv+DwGbrThRNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OxR8Bw7/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OxR8Bw7/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BC12C4CED0;
	Mon,  4 Nov 2024 19:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730749927;
	bh=daJVoLWMJgnDAQoF8idqLRpe4+dcNNTu2JiI5rzPbvY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OxR8Bw7/kBoB4J+I7s0+skhftbhMfE63iflbGPpD67mTPk2jVvZVTb8DiAepyKrE9
	 rh5LsSJO1Z/5qCxDLvBh7k/pETPZzsHLCCtOloMlIK4yIG/Fb0C0QuayHyZX/bKjRc
	 FMDrEn21/0pzhm5ZNQk48JXohSxN5pv2OnOaLIJlLZ48HFKCfM+fyksjkBUEp3AAc9
	 88iUNhLX+fWoHtzIN/7h3L+77EOgRjJiRfP2Z64eqxl+u3T17E4zNi2QBgkCQ1vHqa
	 ne9rn7tMNP161FeMoSmexeDUPnSqJjRmfyFrXITBC5K4aPCk74CF8+PCfai90yWYke
	 vsuwMrBwI6xYQ==
Date: Mon, 4 Nov 2024 11:52:05 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Michael Petlan <mpetlan@redhat.com>
Cc: linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
	Arnaldo de Melo <acme@redhat.com>, vmolnaro@redhat.com
Subject: Re: perf test fail :: "perf stat --bpf-counters --for-each-cgroup
 test"
Message-ID: <Zykl5Xk8u5nhe0Pm@google.com>
References: <alpine.LRH.2.20.2407191137440.11376@Diego>
 <CA+JHD90TkDVHPw4jqxMX2guqsg-8xrqD2iiEfZ_akixvVYZKZg@mail.gmail.com>
 <alpine.LRH.2.20.2407191303000.11376@Diego>
 <536d5b91-f9ed-99b3-6c17-3d93bf451ffd@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <536d5b91-f9ed-99b3-6c17-3d93bf451ffd@redhat.com>

Hello Michael,

On Fri, Nov 01, 2024 at 11:15:39AM +0100, Michael Petlan wrote:
> 
> On Fri, 19 Jul 2024, Michael Petlan wrote:
> > On Fri, 19 Jul 2024, Arnaldo Carvalho de Melo wrote:
> > > On Fri, Jul 19, 2024, 6:50 AM Michael Petlan <mpetlan@redhat.com> wrote:
> > >       Hello Namhyung,
> > > 
> > >       we were investigating some test failures of the testcase mentioned
> > >       in $subj. We have narrowed it down to:
> > > 
> > >           # perf stat -C 0,1 --for-each-cgroup system.slice,user.slice -e cycles -- taskset -c 1 perf test -w thloop
> > > 
> > >           Performance counter stats for 'CPU(s) 0,1':
> > >                <not counted>      cycles                           system.slice
> > >                3,020,401,084      cycles                           user.slice                       
> > > 
> > >                1.009787097 seconds time elapsed
> > > 
> > >       As seen, the system.slice is not counted properly in our case. It
> > >       happens even without bpf-counters being involved.
> > > 
> > >       There were rumours that it might be caused due to too small system
> > >       load, but it apparently happens even when the load was replaced by
> > >       "thloop" workload from perf-test's workload library. However, even
> > >       so, if the load was insufficient, we'd see a value – 0 instead of
> > >       "not counted". The "<not counted>" result is printed if the counter
> > >       wasn't properly enabled and running.
> > > 
> > >       Have you encountered this problem? What could cause it?
> > > 
> > > 
> > > What does running with -vvv says? Some inconclusive error coming from the kernel? 
> > 
> Hello!
> 
> We have been investigating this issue a bit more again and we have come
> to conclusion that everything is probably OK, except of the testcase
> which in short relies on the fact that taskset can force any system.slice
> workload to happen on a particular CPU, which in my opinion does not
> apply, being rather random and that's why the test sometimes fails.
> 
> To summarize the problem a bit:
> 
> 1) The $subj testcase sometimes fails.
> 
> 2) It consists of two parts, one performs counting system-wide and the
> second limits the counting to CPUs 0 and 1. The second one sometimes
> fails, while the first (systemwide) passes always.
> 
> 3) The reason why the test fails is because system.slice may get
> <not counted> result.
> 
> 4) There is another problem with this testcase on single-cpu boxes, since
> there is no "cpu 1", so we decided to try having "-C 0" and "taskset -c 0"
> on such boxes. The problems with getting "<not counted>" disappeared!
> 
> ---------------------------
> 
> So... The systemwide tracing test works:
> 
> # perf stat --for-each-cgroup system.slice,user.slice -e cycles -a -- sleep 3
>  Performance counter stats for 'system wide':
> 
>      8,884,593      cycles            system.slice
>      5,645,624      cycles            user.slice
> 
>    3.004137451 seconds time elapsed
> 
> When we pin the workload AND tracing to particular CPU, it might fail:
> 
> # perf stat -C 0 --for-each-cgroup system.slice,user.slice -e cycles -- taskset -c 0 true
> 
>  Performance counter stats for 'CPU(s) 0':
> 
>      <not counted>  cycles            system.slice
>      2,722,263      cycles            user.slice
> 
>    0.004184686 seconds time elapsed
> 
> Namhyung said that there might be not enough load, which finally appears
> to be the problem. But not in the manner that replacing `true` by something
> more "heavy" would help, but in the fact that system.slice didn't run on
> CPU 0 at all during the `perf stat` counting.
> 
> Taskset can pin the process to some CPU, but even without it (or when we
> pin it to CPU 3 for example), _some_ user.slice content is always run on
> cpu 0, so we get values.
> 
> However, there is no guarantee that system.slice will run there. We would
> probably need to load more the content that systemd decides to put under
> "system.slice" and hope that it will get a chance to run on CPU 0 or 1 or
> whatever we use in the testcase.
> 
> Of course, the more CPUs the machine has, the higher chance to get the
> <not counted> result for system.slice is. That's why -a works and also
> that's why it works on a single-CPU machine.
> 
> ............
> 
> Thus, I think that we should simply remove the taskset part of the testcase
> and leave only the systemwide part.
> 
> Thoughts?

Thanks for taking a look at this.  I admit that the CPU list can make
troubles.  We need a better cgroup testing infra.  Anyway let's get rid
of the problematic test for now.

Thanks,
Namhyung

