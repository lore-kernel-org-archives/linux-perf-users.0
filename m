Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FD513AD20
	for <linux-perf-users@vger.kernel.org>; Sat,  2 Nov 2024 06:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730528407; cv=none; b=pqxAi0/+kZN479IYHHmWgm7oQ4gb0sOprbLl0TXSlPr3aXGQeo8eEMjpCXLT99w5LrHHHhqnqIfc1Uq4qLRrF3ZJZMf8XB7Hi6F4nSSKIsNBZBB+2/NYNuUTiE6WSGNZJFR+nQkddkKasYg7fZ9WmGgIFHhNYRu8tZEiarPVUCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730528407; c=relaxed/simple;
	bh=deEe/lAX43e2fEpTkOcJE5EjSw6ZXOgPyHJpuzbibpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tirrOyS9SheRHwMK4H8boJnf07s+/zJ/3bJuq6aeSha9SbjFiVUOHtAe1l+e74Rzucb70ac3nc0m6ypBpvlYE+9uuMlZLUpgRCw0N6TsiZocXYSZkKzvCXHYzhYqIoZf/66zmYAFpZgQ8rYNQ2Dl8LjwCvhDjHSQ+DnjUXK7NEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qTepXhPO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qTepXhPO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 829B6C4CEC3;
	Sat,  2 Nov 2024 06:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730528406;
	bh=deEe/lAX43e2fEpTkOcJE5EjSw6ZXOgPyHJpuzbibpU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qTepXhPOmGvQTenBWqMe7uqPlKSPNFgLghX5BbwE0EiSIbs/nsHmUa13axaaqrenY
	 L0o48lHgfQgCO2LzGyJLDLhf989JSzz5f01p+YKys4J7suG0MNywav50y3pTxfG1CG
	 XE16IxmJ2DeTCyX/6dB+ewdvnyT4o8IkoaqwYEBVjDdi3YbAbjTQJNuQa2A9uHSpyG
	 t7WiDZWmnpt1dXFS49jMHY7yO1QyL4eR+Guh8RyZ2DMjRl9yIfrTfwCkE0onsl1JSj
	 XkklfZxsdFzQfsfuDPZ+F1kurJC4SE7VsuyKgEGz33eCWRdT+nOs9nok7balRElrIf
	 LgRe4WwOUvByQ==
Date: Fri, 1 Nov 2024 23:20:05 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Michael Petlan <mpetlan@redhat.com>
Cc: vmolnaro@redhat.com, linux-perf-users@vger.kernel.org,
	kan.liang@linux.intel.com, irogers@google.com, acme@redhat.com,
	ak@linux.intel.com, alexander.shishkin@linux.intel.com
Subject: Re: perf sched timehist --state vs perf script
Message-ID: <ZyXElQ8uW8W8AcQr@google.com>
References: <20241024163630.24882-1-vmolnaro@redhat.com>
 <ZyF_JDYF4wgEmbrW@google.com>
 <a8297e65-97fc-507c-1b73-7547374688c@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a8297e65-97fc-507c-1b73-7547374688c@redhat.com>

On Thu, Oct 31, 2024 at 12:32:31PM +0100, Michael Petlan wrote:
> On Tue, 29 Oct 2024, Namhyung Kim wrote:
> > On Thu, Oct 24, 2024 at 06:36:30PM +0200, vmolnaro@redhat.com wrote:
> > > From: Veronika Molnarova <vmolnaro@redhat.com>
> > > 
> > > Hello!
> > > 
> > > We encountered an issue with 'perf sched timehist --state' when
> > > we expected for a test case that the process of a workload would 
> > > eventually end in the dead state(marked by 'X') and be switched
> > > out. This can be seen also by using 'perf script':
> > > 
> > >     # perf sched record -a sleep 1
> > >     [ perf record: Woken up 1 times to write data ]
> > >     [ perf record: Captured and wrote 0.167 MB perf.data (166 samples) ]
> > >     # perf script | grep sleep
> > >            sleep  151541 [000] 193461.410617: sched:sched_stat_runtime: comm=sleep pid=151541 runtime=3132275 [ns]
> > >            sleep  151541 [000] 193461.410624:       sched:sched_switch: sleep:151541 [120] S ==> swapper/0:0 [120]
> > >          swapper       0 [000] 193462.410688:       sched:sched_waking: comm=sleep pid=151541 prio=120 target_cpu=000
> > >          swapper       0 [000] 193462.410698:       sched:sched_switch: swapper/0:0 [120] R ==> sleep:151541 [120]
> > >          :151541  151541 [000] 193462.411100: sched:sched_stat_runtime: comm=sleep pid=151541 runtime=407210 [ns]
> > >          :151541  151541 [000] 193462.411107:       sched:sched_switch: sleep:151541 [120] X ==> swapper/0:0 [120]
> > > 
> > > But for the 'perf sched timehist --state' the process is shown
> > > in the zombie state when it is being switched out:
> > > 
> > >     # perf sched timehist --state | grep 151541
> > >     Samples do not have callchains.
> > >       193461.410624 [0000]  sleep[151541]                       0.000      0.054      3.129      S 
> > >       193462.411107 [0000]  :151541[151541]                     0.000      0.000      0.408      Z 
> > > 
> > > Shouldn't both commands report the same result, or is there a reason
> > > why 'perf script' uses the dead state while 'perf sched' uses dead?
> 
> Hello! Thanks for reacting!
> > 
> > I remember there was a discussion related to this.
> > 
> > https://lore.kernel.org/all/20240122070859.1394479-2-zegao@tencent.com/
> > 
> > And it seems it's fixed both in perf and libtraceevent.  Maybe your
> > libtraceevent is somewhat outdated and doesn't have the update.
> >
> Yes! When we've updated libtraceevent to 1.8.3, both show Z now, which is
> probably correct.

Cool.

> 
> Then it comes into my mind whether shouldn't perf-sched and perf-script
> both take it from libtraceevent to unify the approaches, rather than
> perf-sched using its own implementation and perf-script taking it from
> libtraceevent... ?

Yeah, I think it's better to use libtraceevent for it.

> 
> > > It also seems that the 'perf sched' cannot read the name of the zombie
> > > process, but that can be a different issue.
> > 
> > Hmm.. right.  It should update thread->comm using the sched_switch event.
> 
> According to the tests, the name seems that it used to be translated correctly
> in past, so it'd be nice if it worked again, althoug it is pretty clear which
> process it was, according to the PID. Thus, the test can be adjusted to search
> for the combination "PID, status Z", instead of "command, status Z"... I.e. to
> accept the current situation...

Sounds good.  Please send the patch.

Thanks,
Namhyung

