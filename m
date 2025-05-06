Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3844113D531;
	Tue,  6 May 2025 06:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746513821; cv=none; b=HrIeCIhKXdYuJod5iHEcBsVjGQo9nz28fB5+CKuB6EsogpPrpw3wrSLApikFvRcJBhUD60mNgHq0EQlwlC4bRITsE/IhcdCPTu6/QbDTOzkmqdGNBmns8r4c5dYTyyVULwaJqxVIbP0vSHx1iGm/ubQknfo//piGo1XQDjoEjYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746513821; c=relaxed/simple;
	bh=61Vh5j7Cwed8wSGqkp/MdlV5dfIKU1kb/wM7E5fojPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jWV4q+zq6APp35hJ1JnhMO1GV9r7InkDHnO0N/QBJkQcsaYQQilPmpcl78CLQrXfS0iY6iVWLYYcAl62r+ltUQ0Rml9vFipU3t7/D2JmIwrsCavQZTLgx1WwoDegtpVv6cKNFVNE8i3cX+P7BllahRi6SAx3Nk+ZBZsYAd9kd64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rjKO80ru; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rjKO80ru"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F722C4CEE4;
	Tue,  6 May 2025 06:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746513820;
	bh=61Vh5j7Cwed8wSGqkp/MdlV5dfIKU1kb/wM7E5fojPw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rjKO80ruPVWgqOJpWGUdIIBG3XSqj2LMFgO7OX/4vKyRKeRbTGhk6/2ULD4OYR58n
	 WA7EYcRnZLuHIoVrpzGyb3xE7ZF22bKzGO3XIIeqz3kJFoToVLg1mfxEmnR5WVziUn
	 fsBYbrh1F6Po4AyIGJoyV5fmeIdkEbILwifoRP9o+R05Pwh41ush/70tWbr0N5w6nF
	 DKejnn/rRQ4p4AAOmugATyNSSCLdosg60sH/wG71lNQbU4FPamrAs9bjg20zifW9Ni
	 PDPlbWDqkU+eEizXHGSZxg+y1fZqZwBfLP3JLixEYSU3rtZ6pfCWhity3LQkFoD/Tw
	 fIMswYdLD2I6g==
Date: Mon, 5 May 2025 23:43:38 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Subject: Re: [RFC/PATCH] perf report: Support latency profiling in
 system-wide mode
Message-ID: <aBmvmmRKpeVd6aT3@google.com>
References: <20250503003620.45072-1-namhyung@kernel.org>
 <CACT4Y+Yr7vffLYG+YmyB=9Vn_oxdQqR_6U4d-_WeQoOtPXZ6iw@mail.gmail.com>
 <aBmei7cMf-MzzX5W@google.com>
 <CACT4Y+ameQFd3n=u+bjd+vKR6svShp3NNQzjsUo_UUBCZPzrBw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACT4Y+ameQFd3n=u+bjd+vKR6svShp3NNQzjsUo_UUBCZPzrBw@mail.gmail.com>

On Tue, May 06, 2025 at 07:55:25AM +0200, Dmitry Vyukov wrote:
> On Tue, 6 May 2025 at 07:30, Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > Hello,
> >
> > On Mon, May 05, 2025 at 10:08:17AM +0200, Dmitry Vyukov wrote:
> > > On Sat, 3 May 2025 at 02:36, Namhyung Kim <namhyung@kernel.org> wrote:
> > > >
> > > > When it profile a target process (and its children), it's
> > > > straight-forward to track parallelism using sched-switch info.  The
> > > > parallelism is kept in machine-level in this case.
> > > >
> > > > But when it profile multiple processes like in the system-wide mode,
> > > > it might not be clear how to apply the (machine-level) parallelism to
> > > > different tasks.  That's why it disabled the latency profiling for
> > > > system-wide mode.
> > > >
> > > > But it should be able to track parallelism in each process and it'd
> > > > useful to profile latency issues in multi-threaded programs.  So this
> > > > patch tries to enable it.
> > > >
> > > > However using sched-switch info can be a problem since it may emit a lot
> > > > more data and more chances for losing data when perf cannot keep up with
> > > > it.
> > > >
> > > > Instead, it can maintain the current process for each CPU when it sees
> > > > samples.
> > >
> > > Interesting.
> > >
> > > Few questions:
> > > 1. Do we always see a CPU sample when a CPU becomes idle? Otherwise we
> > > will think that the last thread runs on that CPU for arbitrary long,
> > > when it's actually not.
> >
> > No, it's not guaranteed to have a sample for idle tasks.  So right, it
> > can mis-calculate the parallelism for the last task.  If we can emit
> > sched-switches only when it goes to the idle task, it'd be accurate.
> 
> Then I think the profile can be significantly off if the system wasn't
> ~100% loaded, right?

Yep, it can be.

> 
> > > 2. If yes, can we also lose that "terminating" even when a CPU becomes
> > > idle? If yes, then it looks equivalent to missing a context switch
> > > event.
> >
> > I'm not sure what you are asking.  When it lose some records because the
> > buffer is full, it'll see the task of the last sample on each CPU.
> > Maybe we want to reset the current task after PERF_RECORD_LOST.
> 
> This probably does not matter much if the answer to question 1 is No.
> 
> But what I was is the following:
> 
> let's say we have samples:
> Sample 1 for Pid 42 on Cpu 10
> Sample 2 for idle task on Cpu 10
> ... no samples for some time on Cpu 10 ...
> 
> When we process sample 2, we decrement the counter for running tasks
> for Pid 42, right.
> Now if sample 2 is lost, then we don't do decrement and the accounting
> becomes off.
> In a sense this is equivalent to the problem of losing context switch event.

Right.  But I think it's hard to be correct once it loses something.

> 
> 
> > > 3. Does this mode kick in even for non system-wide profiles (collected
> > > w/o context switch events)? If yes, do we properly understand when a
> > > thread stops running for such profiles? How do we do that? There won't
> > > be samples for idle/other tasks.
> >
> > For non system-wide profiles, the problem is that it cannot know when
> > the current task is scheduled out so that it can decrease the count of
> > parallelism.  So this approach cannot work and sched-switch info is
> > required.
> 
> Where does the patch check that this mode is used only for system-wide profiles?
> Is it that PERF_SAMPLE_CPU present only for system-wide profiles?

Basically yes, but you can use --sample-cpu to add it.

In util/evsel.c::evsel__config():

	if (target__has_cpu(&opts->target) || opts->sample_cpu)
		evsel__set_sample_bit(evsel, CPU);

Thanks,
Namhyung

