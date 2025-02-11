Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D6C1E22E6;
	Tue, 11 Feb 2025 17:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739296284; cv=none; b=F9ZvaZZFMvFLL8uCXh8br5jTP3Y79RsIs1HGe6QaVzDXHOH/UOdgIFjePmcBCCqDaaqaR7nOQS+/CoLEXPGkArkK3oUMXbQIjhsjoIyWBLV2GJFmVb6t3HLmPW+bsBPKZH1jdG1lsKrXBHbhgOS9k6/RkBm04RQfMum4Tuf97pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739296284; c=relaxed/simple;
	bh=pOmYe+CzKZBKLzOG405L6ieNnxry6wJDC3YnqgayBh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kc2v1csOZXsCLhQxgp0zPtSEer3IQE2gCpg0FOjth8dRMOeeZfjgKmfcrwajxNWG7FbQu9Bhbsll5F+niciy22HMbWAFGV7CCJGsbDBJAwbyN/PH0OgMocal0XKGDStfvbxh9u+pAsY1wFLPgnNaLJY5is4A8sUBNh6PsapiXAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YbFXRVog; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YbFXRVog"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69BA5C4CEDD;
	Tue, 11 Feb 2025 17:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739296283;
	bh=pOmYe+CzKZBKLzOG405L6ieNnxry6wJDC3YnqgayBh4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YbFXRVogRNaFHzI0n1livDh5s/I9s0iwrHPQvU0h9KJihLz/ZffZurV+E9rYOPy+H
	 MuBoDNNAvM91AgiLWFfVPMtl+Hi4802P9HQKwnlJiCHpZVnHqni7TUs6ROKD3Ss4ca
	 ijyxH4ngpKOT9+OPUyN+PK9WVuwlfYyOIE1bHcsUikg7ljI1HOUt4nYlmG+bimvxJn
	 Clj/oD/MvPqjt7UHxjwXrjsssqdpRer6+5UYLgyMyXO5LJCIvC5ShXTyupvmhbN5mk
	 IDIX+k+ltDUMXnBKa6f94V8XjzMfu0g4HZno1GFDOiPBwbwPd0aGwfnKSv5SuA69Z3
	 XkKOvKucyZzqQ==
Date: Tue, 11 Feb 2025 09:51:20 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>, Hao Ge <gehao@kylinos.cn>,
	James Clark <james.clark@linaro.org>,
	Howard Chu <howardchu95@gmail.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Levi Yun <yeoreum.yun@arm.com>, Xu Yang <xu.yang_2@nxp.com>,
	Tengda Wu <wutengda@huaweicloud.com>,
	Yang Jihong <yangjihong1@huawei.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 00/10] Move uid filtering to BPF filters
Message-ID: <Z6uOGNO6p7i9Fese@google.com>
References: <20250111190143.1029906-1-irogers@google.com>
 <Z6panMzNSm1op8Di@google.com>
 <CAP-5=fUY83gifsMZA0Q45kiQQbAKp2uJxkuwrwGtHK2hiUFRDA@mail.gmail.com>
 <Z6rAHhAIdlkAryGJ@google.com>
 <CAP-5=fXjmJ+Rr7ejL6fCMeu6PZSit7n84hQkjh=0jQhkr1on3Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXjmJ+Rr7ejL6fCMeu6PZSit7n84hQkjh=0jQhkr1on3Q@mail.gmail.com>

On Mon, Feb 10, 2025 at 08:40:01PM -0800, Ian Rogers wrote:
> On Mon, Feb 10, 2025 at 7:12 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Mon, Feb 10, 2025 at 02:06:18PM -0800, Ian Rogers wrote:
> > > On Mon, Feb 10, 2025 at 11:59 AM Namhyung Kim <namhyung@kernel.org> wrote:
> > > >
> > > > On Sat, Jan 11, 2025 at 11:01:33AM -0800, Ian Rogers wrote:
> > > > > Rather than scanning /proc and skipping PIDs based on their UIDs, use
> > > > > BPF filters for uid filtering. The /proc scanning in thread_map is
> > > > > racy as the PID may exit before the perf_event_open causing perf to
> > > > > abort. BPF UID filters are more robust as they avoid the race. Add a
> > > > > helper for commands that support UID filtering and wire up. Remove the
> > > > > non-BPF UID filtering support.
> > > >
> > > > Hmm.. then non-BPF build cannot use the UID filtering anymore, right?
> > > > Also non-root users will be limited unless it pinned the BPF program in
> > > > advance.
> > > >
> > > > I think you can keep the original behavior and convert to BPF only when
> > > > it's available.
> > >
> > > Using BPF when available would be limited progress. The issues I have
> > > with not removing the existing approach are:
> > >
> > > 1) It is broken
> > > Scanning /proc for pids and then doing perf_event_open means that any
> > > time a process exits the perf_event_open fails.
> > > Steps to reproduce:
> > > This bug reproduces easily but if your machine is lightly loaded in
> > > one terminal run `perf test`, in another terminal run `sudo perf top
> > > -u $(id -u)` the perf top command will exit with:
> > > ```
> > > Error:
> > > The sys_perf_event_open() syscall returned with 3 (No such process)
> > > for event (cycles:P).
> > > /bin/dmesg | grep -i perf may provide additional information.
> > > ```
> > >
> > > 2) It is a work in progress that isn't progressing. Scanning /proc
> > > will only tell you about started processes; it won't tell you about
> > > processes that start during the profiling run, whether it be perf top
> > > or perf record. Extra work would be necessary to make this most basic
> > > of use-cases work, perhaps you could use tracepoints to capture
> > > starting processes and then enable user profiling on those processes.
> > > It would be horribly complicated, suffer from delays between observing
> > > things happen and doing the perf_event_open, biases in the samples,
> > > etc. I don't expect anyone to do it, especially when BPF filtering
> > > already solves the problem better. There have been 13 years that
> > > someone could have fixed it.
> > >
> > > 3) it adds significant useless complexity to the code base. Having
> > > 'user' in the target makes it look like perf_event_open can work on a
> > > pid, system wide or user basis. The user basis doesn't exist so the
> > > majority of the code base is just ignoring it - search for users of
> > > uid_str on target. Those that do run into problems (1) and (2).
> > >
> > > 4) It is redundant and leads to confusion with BPF filtering. Having
> > > the BPF filter on evsels is non-zero cost in terms of the code base
> > > complexity, but it is something broadly useful. As user filtering has
> > > never worked (see above) it isn't broadly used but is adding
> > > complexity. If both approaches were wanted then it is unclear what the
> > > code should be doing, presumably the mish-mash of BPF filtering and
> > > /proc scanning that happens today and will be broken due to (1) and
> > > (2). Putting everything into the BPF filter makes sense as you can
> > > combine a BPF filter with an additional BPF filter on user.
> > >
> > > 5) It is untested and adding a test leads to an always broken test due
> > > to testing being an example of where things break, see point 1 and its
> > > example.
> > >
> > > 6) Nobody wants the non-BPF approach. As it was broken nobody used the
> > > previous feature, maintaining it for no users is overhead. Let me know
> > > if someone is using this option (I doubt it given points 1 and 2) and
> > > they wouldn't be better served by BPF. People building perf today have
> > > to explicitly opt-out of wanting BPF in their tooling. I posted this
> > > change a month ago and nobody has jumped up saying please don't remove
> > > the old approach.
> > >
> > > 7) The interaction with this feature and changes in behavior, say
> > > ignoring events that fail to open, is non-obvious and not testable as
> > > testing would be broken as the functionality itself is broken. Having
> > > the broken feature hanging around and being untestable means that we
> > > slow progress on new features, testing and other improvements.
> > >
> > > Yes, we could try to fix all of that but why? Nobody has cared or
> > > tried in 13 years and I would like the tech debt off our plate with a
> > > better approach in its place.
> >
> > Thanks for writing this up.  I agree BPF approach is better but it has
> > its own limitation - basically it requires root.  And I know a few of
> > people who don't use BPF. :)  And maybe we need to check if user passes
> > filters to the event already.
> 
> I thought you were working on making the BPF filters pin-able? So root
> could enable the filter but then users have access to it.

Right, 'perf record --setup-filter pin' would do the job.  But it has to
be run in advance.

> You have to be root to be looking at other users in any case.

That's true.  But at least you can profile your processes. :)

> 
> > Also, I admit that I don't know who actually uses this.  But I can say
> > sometimes people uses tools in a creative way.  Anyway, I can imagine
> > an use case that system is in a steady state and each user has dedicated
> > jobs.  Then scanning /proc would work well.
> 
> Another one for Google's tree then.

Any chance you update the patchset to retain the old behavior and use
BPF only if available?

Thanks,
Namhyung

