Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0801D63F0;
	Thu, 23 Apr 2026 01:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776906721; cv=none; b=rtRBXXDW26N0e1TmrwXUE5tpeHA/WTZzdraeaei+KIxjqnPIx60RyBKiLwAuX5qjitp8iuP8Sjw/440KIwwCKIPyW/hMQfs/KEW6CzSiK87CETusqPSPIowYzi/Sf+xo6In/3dkL2/l4Z+zl1i8ZbZ0eg3nLfgWHfI3Muunc+Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776906721; c=relaxed/simple;
	bh=S7lOtiK0ny4Q7zCLC45kW8aw23HtqZxs1qHhF0KBIJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bwsq+klCARpVcTD+9U2doZZm+D2k4OmtJOJtGEMiMU47tEhtLh6TeRihgHRVMoQbWaso8qzlNc1vLSh3TLPjKLNxoflc+czqvIKzwU7QFPP0Dqbj/45dQlTSIGOGyQeeShEvtTopw1aG3vX/omqCwaaTXE1Q05aZvztlFyIOiag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T0z6z9lF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T0z6z9lF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21205C19425;
	Thu, 23 Apr 2026 01:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776906721;
	bh=S7lOtiK0ny4Q7zCLC45kW8aw23HtqZxs1qHhF0KBIJ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T0z6z9lFxtdV+V69oNN3V3Wb8Tf2WQ2vY7z17mnxmQhIwVxK0DoSGvOEiXohWhrp/
	 rwHdpuTlSlnQmGY5ahuNYtZS6C9f/pkLpqDfsrm3txShr5khAcOVX75jQq2me7yzso
	 ibr59Pf+AeLGEgINWw+cOPlufD/Wwnhn9CQHfauknB2MAdACJl1ImXLh0pCDJJcRX3
	 MYFMj3Pf32s2hTKBSvAVUkl7lo2uB3ORuruUL5hgvArFpUesd72psIZjKszrH/yY+5
	 vd6xbe1NC6hWXRQ+PMZj4OtILye7q3H21KbYDewad7bLLmM/hPb8bf6vfZAUq2k9a6
	 TQ7M2B5k0+14Q==
Date: Wed, 22 Apr 2026 18:11:59 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Suchit Karunakaran <suchitkarunakaran@gmail.com>
Cc: sashiko@lists.linux.dev, bpf@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf/lock: enable end-timestamp accounting for cgroup
 aggregation
Message-ID: <aelx3_VdT_PfsNjd@google.com>
References: <20260420184656.331306-1-suchitkarunakaran@gmail.com>
 <20260421004512.CDE13C19425@smtp.kernel.org>
 <CAO9wTFiFRSRjMRSAA+vV-AF1rJQGdoCK_p6TXvQ+V1ToaqMs0w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAO9wTFiFRSRjMRSAA+vV-AF1rJQGdoCK_p6TXvQ+V1ToaqMs0w@mail.gmail.com>

On Tue, Apr 21, 2026 at 01:59:00PM +0530, Suchit Karunakaran wrote:
> On Tue, 21 Apr 2026 at 06:15, <sashiko-bot@kernel.org> wrote:
> >
> > Sashiko AI review found 2 potential issue(s):
> > - [High] Incomplete spinlock and rwlock contentions are silently dropped for LOCK_AGGR_CGROUP because account_end_timestamp() skips the per-CPU tstamp map.
> > - [Medium] Inconsistent cgroup attribution between complete and incomplete lock contentions when a task migrates cgroups.
> > --
> >
> > commit 7ba25dc647534f97eb1ae9f34c6c8d38e7fef074
> > Author: Suchit Karunakaran <suchitkarunakaran@gmail.com>
> >
> > perf/lock: enable end-timestamp accounting for cgroup aggregation
> >
> > This commit adds a cgroup_id field to struct tstamp_data to properly account
> > for incomplete lock contention events when aggregating by cgroup. It records
> > the cgroup ID at contention_begin and uses it to build the aggregation key
> > in userspace.
> >
> > > diff --git a/tools/perf/util/bpf_lock_contention.c b/tools/perf/util/bpf_lock_contention.c
> > > index cbd7435579fea..1a5bd2ff8ee4c 100644
> > > --- a/tools/perf/util/bpf_lock_contention.c
> > > +++ b/tools/perf/util/bpf_lock_contention.c
> > > @@ -463,8 +463,8 @@ static void update_lock_stat(int map_fd, int pid, u64 end_ts,
> > >               stat_key.lock_addr_or_cgroup = ts_data->lock;
> > >               break;
> > >       case LOCK_AGGR_CGROUP:
> > > -             /* TODO */
> > > -             return;
> > > +             stat_key.lock_addr_or_cgroup = ts_data->cgroup_id;
> > > +             break;
> >
> > Does this fully enable end-timestamp accounting for cgroup aggregation
> > on per-CPU locks like spinlocks and rwlocks?
> >
> > Looking at account_end_timestamp() in tools/perf/util/bpf_lock_contention.c,
> > there is an early return that skips the per-CPU tstamp map:
> >
> > static void account_end_timestamp(struct lock_contention *con)
> > {
> >         ...
> >         /* Now it'll check per-cpu tstamp map which doesn't have TID. */
> >         if (aggr_mode == LOCK_AGGR_TASK || aggr_mode == LOCK_AGGR_CGROUP)
> >                 return;
> >
> >         total_cpus = cpu__max_cpu().cpu;
> >         ts_fd = bpf_map__fd(skel->maps.tstamp_cpu);
> >         ...
> > }
> >
> > Since account_end_timestamp() skips iterating over skel->maps.tstamp_cpu
> > when aggr_mode is LOCK_AGGR_CGROUP, are all incomplete contentions for
> > spinlocks and rwlocks still silently dropped?
> >
> 
> As per my understanding the tstamp_cpu map stores per-cpu entries
> without a TID, so there is no current task context available to derive
> a cgroup ID. Unlike the per-task tstamp map where cgroup_id is
> captured at contention_begin time, per-cpu entries represent
> spinlock/rwlock contentions that are inherently CPU-bound and not
> attributed to a single task at contention_end time either. The
> original LOCK_AGGR_TASK mode has the same early return for the same
> reason, cgroup attribution without a task context is not meaningful.
> This patch addresses only the per-task straggler case.

Right, it'll miss spinlocks and rwlocks but I think it's ok.

> 
> > [ ... ]
> >
> > > diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/perf/util/bpf_skel/lock_contention.bpf.c
> > > index 96e7d853b9edf..d0e2cad02fa36 100644
> > > --- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
> > > +++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
> > > @@ -536,6 +536,8 @@ int contention_begin(u64 *ctx)
> > >       pelem->timestamp = bpf_ktime_get_ns();
> > >       pelem->lock = (__u64)ctx[0];
> > >       pelem->flags = (__u32)ctx[1];
> > > +     if (aggr_mode == LOCK_AGGR_CGROUP)
> > > +             pelem->cgroup_id = get_current_cgroup_id();
> >
> > If a task migrates to a different cgroup while blocked on a lock, could this
> > lead to inconsistent attribution between complete and incomplete contentions?
> >
> > The cgroup ID is statically recorded here at contention_begin() and used by
> > userspace for incomplete events.
> >
> > However, contention_end() continues to dynamically resolve the cgroup ID:
> >
> > SEC("tp_btf/contention_end")
> > int contention_end(u64 *ctx)
> > {
> >         ...
> >         case LOCK_AGGR_CGROUP:
> >                 key.lock_addr_or_cgroup = get_current_cgroup_id();
> >                 break;
> >         ...
> > }
> >
> > Would it be more consistent for contention_end() to also use the statically
> > recorded pelem->cgroup_id, ensuring that both completed and incomplete events
> > attribute the contention time to the exact same cgroup?
> >
> 
> I think the fix should go in the opposite direction. Instead of
> calling get_current_cgroup_id() at contention_end, I think we should
> be using pelem->cgroup_id. Semantically, the cost of lock contention
> is incurred by the task that had to wait for the lock. So it makes
> more sense to attribute that cost based on the cgroup at the time the
> wait started (contention_begin), rather than whatever happens to be
> current at the end.
> I’m not entirely certain about this, so I’d really appreciate any
> input from maintainers and reviewers on whether this attribution makes
> sense.

Agreed, as I replied earlier we should use pelem->cgroup_id.

The tstamp_data is saved per-thread so it doesn't matter which thread is
calling this.  I think the concern is when - IIRC I put it at _end()
because it may reduce the overhead when we have some filters.

But it seems it's already after checking the filters.  Then it should be
ok to do in _begin().  Maybe it's a better choice doing it in _begin()
since the thread is about to go to wait for the lock and doing nothing
critical.  While at the _end(), it'll start the critical section soon.

Thanks,
Namhyung

