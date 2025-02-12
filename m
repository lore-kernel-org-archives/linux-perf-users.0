Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930F678F5D;
	Wed, 12 Feb 2025 01:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739325083; cv=none; b=DpbO3VvsCe55p9LO2ZUDrwgw19BDtbgSw3MH+A58CHQoj16OnhumFxG4k3qY/2oama88g4BONHksHadPx/vtoQbeoGouMZQ1DJvN9M6yjq++CMMdaOj2GmOAmZO/B9Qbi1RtiOkjifsOJpY+M0CsIsqrp5dcEkQZfNTZf/8lYZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739325083; c=relaxed/simple;
	bh=GhTU/A3t4aRQSNSXfTGplWZFHI0A5ro2NMW9IN42y0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AYMCSrA2rKGrLE0PUHm5L6L9hslBO82G12fTkPZs5143AlzX3Ts4f1KTidZwCtH3x2TA6f5IcHXg194A8kvoYscpP4y7zPCBMVfFpwC/MOAcODheqbxlNqWZUXMSBwlUy1qBtsek9PHm+92bBhC7JfVOQyBueYuHycKO1pYoI8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CoyxaFos; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CoyxaFos"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AE54C4CEDD;
	Wed, 12 Feb 2025 01:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739325083;
	bh=GhTU/A3t4aRQSNSXfTGplWZFHI0A5ro2NMW9IN42y0c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CoyxaFos3LI6Lvcyb/axYkL2dorYw+fJniBQ3NoEAwq2nflkU3zFoA3QamQ32FujB
	 8VaHEWAC1VLQ/QnjqGVlXtfQAk3jsk/uraK3wrW6Ydvx1VSnfEqbdFuJ0D1VfN99Dl
	 vKLlXehCUdluwa1TxNSHAap1g5wKvZyHwQMyxtN7Cyrj8c+/65IbSElKAK+BTKlfy6
	 eYYwU9Q01fYIS2C0OQFALjEtYTVdpqklRG9stEEpKdQBb2+tHmzKGsJdWfFtWpDE3G
	 hj/hkCLE27YOjyALxmJYdvCWaTi0UT44xriAJm8LayotnEjPXX2reKhKtKaXj5XWd3
	 D1aFzEU9x3Spw==
Date: Tue, 11 Feb 2025 17:51:20 -0800
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
Message-ID: <Z6v-mPJq6m61pFA4@google.com>
References: <20250111190143.1029906-1-irogers@google.com>
 <Z6panMzNSm1op8Di@google.com>
 <CAP-5=fUY83gifsMZA0Q45kiQQbAKp2uJxkuwrwGtHK2hiUFRDA@mail.gmail.com>
 <Z6rAHhAIdlkAryGJ@google.com>
 <CAP-5=fXjmJ+Rr7ejL6fCMeu6PZSit7n84hQkjh=0jQhkr1on3Q@mail.gmail.com>
 <Z6uOGNO6p7i9Fese@google.com>
 <CAP-5=fVxFe4nMS_dHmO=6-ddA40XbVdvouPLuOxj5cenjUr8ng@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVxFe4nMS_dHmO=6-ddA40XbVdvouPLuOxj5cenjUr8ng@mail.gmail.com>

On Tue, Feb 11, 2025 at 10:06:34AM -0800, Ian Rogers wrote:
> On Tue, Feb 11, 2025 at 9:51 AM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Mon, Feb 10, 2025 at 08:40:01PM -0800, Ian Rogers wrote:
> > > On Mon, Feb 10, 2025 at 7:12 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > > >
> > > > On Mon, Feb 10, 2025 at 02:06:18PM -0800, Ian Rogers wrote:
> > > > > On Mon, Feb 10, 2025 at 11:59 AM Namhyung Kim <namhyung@kernel.org> wrote:
> > > > > >
> > > > > > On Sat, Jan 11, 2025 at 11:01:33AM -0800, Ian Rogers wrote:
> > > > > > > Rather than scanning /proc and skipping PIDs based on their UIDs, use
> > > > > > > BPF filters for uid filtering. The /proc scanning in thread_map is
> > > > > > > racy as the PID may exit before the perf_event_open causing perf to
> > > > > > > abort. BPF UID filters are more robust as they avoid the race. Add a
> > > > > > > helper for commands that support UID filtering and wire up. Remove the
> > > > > > > non-BPF UID filtering support.
> > > > > >
> > > > > > Hmm.. then non-BPF build cannot use the UID filtering anymore, right?
> > > > > > Also non-root users will be limited unless it pinned the BPF program in
> > > > > > advance.
> > > > > >
> > > > > > I think you can keep the original behavior and convert to BPF only when
> > > > > > it's available.
> > > > >
> > > > > Using BPF when available would be limited progress. The issues I have
> > > > > with not removing the existing approach are:
> > > > >
> > > > > 1) It is broken
> > > > > Scanning /proc for pids and then doing perf_event_open means that any
> > > > > time a process exits the perf_event_open fails.
> > > > > Steps to reproduce:
> > > > > This bug reproduces easily but if your machine is lightly loaded in
> > > > > one terminal run `perf test`, in another terminal run `sudo perf top
> > > > > -u $(id -u)` the perf top command will exit with:
> > > > > ```
> > > > > Error:
> > > > > The sys_perf_event_open() syscall returned with 3 (No such process)
> > > > > for event (cycles:P).
> > > > > /bin/dmesg | grep -i perf may provide additional information.
> > > > > ```
> > > > >
> > > > > 2) It is a work in progress that isn't progressing. Scanning /proc
> > > > > will only tell you about started processes; it won't tell you about
> > > > > processes that start during the profiling run, whether it be perf top
> > > > > or perf record. Extra work would be necessary to make this most basic
> > > > > of use-cases work, perhaps you could use tracepoints to capture
> > > > > starting processes and then enable user profiling on those processes.
> > > > > It would be horribly complicated, suffer from delays between observing
> > > > > things happen and doing the perf_event_open, biases in the samples,
> > > > > etc. I don't expect anyone to do it, especially when BPF filtering
> > > > > already solves the problem better. There have been 13 years that
> > > > > someone could have fixed it.
> > > > >
> > > > > 3) it adds significant useless complexity to the code base. Having
> > > > > 'user' in the target makes it look like perf_event_open can work on a
> > > > > pid, system wide or user basis. The user basis doesn't exist so the
> > > > > majority of the code base is just ignoring it - search for users of
> > > > > uid_str on target. Those that do run into problems (1) and (2).
> > > > >
> > > > > 4) It is redundant and leads to confusion with BPF filtering. Having
> > > > > the BPF filter on evsels is non-zero cost in terms of the code base
> > > > > complexity, but it is something broadly useful. As user filtering has
> > > > > never worked (see above) it isn't broadly used but is adding
> > > > > complexity. If both approaches were wanted then it is unclear what the
> > > > > code should be doing, presumably the mish-mash of BPF filtering and
> > > > > /proc scanning that happens today and will be broken due to (1) and
> > > > > (2). Putting everything into the BPF filter makes sense as you can
> > > > > combine a BPF filter with an additional BPF filter on user.
> > > > >
> > > > > 5) It is untested and adding a test leads to an always broken test due
> > > > > to testing being an example of where things break, see point 1 and its
> > > > > example.
> > > > >
> > > > > 6) Nobody wants the non-BPF approach. As it was broken nobody used the
> > > > > previous feature, maintaining it for no users is overhead. Let me know
> > > > > if someone is using this option (I doubt it given points 1 and 2) and
> > > > > they wouldn't be better served by BPF. People building perf today have
> > > > > to explicitly opt-out of wanting BPF in their tooling. I posted this
> > > > > change a month ago and nobody has jumped up saying please don't remove
> > > > > the old approach.
> > > > >
> > > > > 7) The interaction with this feature and changes in behavior, say
> > > > > ignoring events that fail to open, is non-obvious and not testable as
> > > > > testing would be broken as the functionality itself is broken. Having
> > > > > the broken feature hanging around and being untestable means that we
> > > > > slow progress on new features, testing and other improvements.
> > > > >
> > > > > Yes, we could try to fix all of that but why? Nobody has cared or
> > > > > tried in 13 years and I would like the tech debt off our plate with a
> > > > > better approach in its place.
> > > >
> > > > Thanks for writing this up.  I agree BPF approach is better but it has
> > > > its own limitation - basically it requires root.  And I know a few of
> > > > people who don't use BPF. :)  And maybe we need to check if user passes
> > > > filters to the event already.
> > >
> > > I thought you were working on making the BPF filters pin-able? So root
> > > could enable the filter but then users have access to it.
> >
> > Right, 'perf record --setup-filter pin' would do the job.  But it has to
> > be run in advance.
> >
> > > You have to be root to be looking at other users in any case.
> >
> > That's true.  But at least you can profile your processes. :)
> >
> > >
> > > > Also, I admit that I don't know who actually uses this.  But I can say
> > > > sometimes people uses tools in a creative way.  Anyway, I can imagine
> > > > an use case that system is in a steady state and each user has dedicated
> > > > jobs.  Then scanning /proc would work well.
> > >
> > > Another one for Google's tree then.
> >
> > Any chance you update the patchset to retain the old behavior and use
> > BPF only if available?
> 
> The point of the series is:
> 1) get rid of unnecessary notions of target, the uid_str, it is extra
> complexity and doesn't make sense;
> 2) switch the two users of if to BPF.
> You are focussing on the thing that isn't the main point of the series.

But you removed non-BPF and non-root (w/o pinning BPF) use cases.

Thanks,
Namhyung

