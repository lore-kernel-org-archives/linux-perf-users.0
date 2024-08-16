Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA0F1C3F34;
	Fri, 16 Aug 2024 14:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723819960; cv=none; b=Qs6EkGY0qo4rztoOZhEkNz8h7HiNjxlgI5YBua8eCyE9IJhc78bhYbreKGVqzN58lznFyfyb5yaOBVehZzd6sVc36O6aJnr3PQPCfER2njvX7h2PgWKT4SI6sqJfWl54C+QoRH5MB1AV+9GLbcgo+rXxqNdPKs48sfCkLvBz/Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723819960; c=relaxed/simple;
	bh=hP8++yNDxO743LCH8RbB2nxX3Bl26tRT1UVb8dqFOv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cJDQQnpYJ1m2viYs4E3t8NMPasd7sYhRE2nYy7xp7uJf2c7PsJaHuDglkCaf7gvFeUuv9IeDieSavAhEoqElHXtxooAjsRePQo+8ASO7PrTYIA484wDXjflkhoDCyco7JZeS0OhuwtD31W66JQLn6nDWfaO9J+oosfhfZCjqsdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dYVZ4xXL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dYVZ4xXL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90C6DC32782;
	Fri, 16 Aug 2024 14:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723819960;
	bh=hP8++yNDxO743LCH8RbB2nxX3Bl26tRT1UVb8dqFOv8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dYVZ4xXLEbj7MYWGheqrDy5vQDWDFQNo8mfWf6zVJX/HX4EKYsL78uoluVVWQB9dE
	 JWrxzTwkYkGHy2WOWBT4jJcyiCw0R92+4g+BED59lNc/y/T9+slTwhTGmS48/umT4z
	 VU9L9pOT9AL1ArQzeE0DGL0Me9L7H0ndQxvgpX6DkW4VQZjCoY7rDY5tSIQsS7Dkss
	 XfcODkDqoyygRdjxxK8kkrkQ2GHBKqMmKIpWAWcAbBiHK/B2mAW8CMVJ0k6+TV/lpa
	 0JyxKMwUtQFKufR1UOKsLN9DmVlQhu7hS9ZOZYG4/kNPYGMf8/WmOKfWNe+cintH1C
	 9Mt7QPWqZkGBg==
Date: Fri, 16 Aug 2024 11:52:36 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>, Alexei Starovoitov <ast@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Howard Chu <howardchu95@gmail.com>, adrian.hunter@intel.com,
	jolsa@kernel.org, kan.liang@linux.intel.com, namhyung@kernel.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/10] perf trace: Fix perf trace -p <PID>
Message-ID: <Zr9ntEtIvseYwG90@x1>
References: <20240815013626.935097-1-howardchu95@gmail.com>
 <20240815013626.935097-2-howardchu95@gmail.com>
 <CAP-5=fXCt4axmdjqDZXZzjW-gZK_KZ8R--OTR-M1sZYxZ94k5A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXCt4axmdjqDZXZzjW-gZK_KZ8R--OTR-M1sZYxZ94k5A@mail.gmail.com>

On Thu, Aug 15, 2024 at 11:28:17AM -0700, Ian Rogers wrote:
> On Wed, Aug 14, 2024 at 6:36 PM Howard Chu <howardchu95@gmail.com> wrote:
> >
> > perf trace -p <PID> work on a syscall that is unaugmented, but doesn't
> > work on a syscall that's augmented (when it calls perf_event_output() in
> > BPF).
> >
> > Let's take open() as an example. open() is augmented in perf trace.
> >
> > Before:
> > ```
> > perf $ perf trace -e open -p 3792392
> >          ? (         ):  ... [continued]: open())                                             = -1 ENOENT (No such file or directory)
> >          ? (         ):  ... [continued]: open())                                             = -1 ENOENT (No such file or directory)
> > ```
> >
> > We can see there's no output.
> >
> > After:
> > ```
> > perf $ perf trace -e open -p 3792392
> >      0.000 ( 0.123 ms): a.out/3792392 open(filename: "DINGZHEN", flags: WRONLY)                             = -1 ENOENT (No such file or directory)
> >   1000.398 ( 0.116 ms): a.out/3792392 open(filename: "DINGZHEN", flags: WRONLY)                             = -1 ENOENT (No such file or directory)
> > ```
> >
> > Reason:
> >
> > bpf_perf_event_output() will fail when you specify a pid in perf trace (EOPNOTSUPP).

Trying to figure out why it returns EOPNOTSUPP:

static __always_inline u64
__bpf_perf_event_output(struct pt_regs *regs, struct bpf_map *map,
                        u64 flags, struct perf_sample_data *sd)
{
        struct bpf_array *array = container_of(map, struct bpf_array, map);
        unsigned int cpu = smp_processor_id();
        u64 index = flags & BPF_F_INDEX_MASK;
        struct bpf_event_entry *ee;
        struct perf_event *event; 

        if (index == BPF_F_CURRENT_CPU)
                index = cpu;
        if (unlikely(index >= array->map.max_entries))
                return -E2BIG;

        ee = READ_ONCE(array->ptrs[index]);
<SNIP>
        if (unlikely(event->oncpu != cpu))
                return -EOPNOTSUPP;

        return perf_event_output(event, sd, regs);
}

⬢[acme@toolbox perf-tools-next]$ git grep -- '->oncpu'
arch/x86/kvm/vmx/pmu_intel.c:    *   cpu pinned event reclaims LBR, the event->oncpu will be set to -1;
kernel/events/core.c:   event->oncpu = -1;
kernel/events/core.c:   WRITE_ONCE(event->oncpu, smp_processor_id());
kernel/events/core.c:    * ->oncpu if it sees ACTIVE.
kernel/events/core.c:           event->oncpu = -1;
kernel/events/core.c:   if (READ_ONCE(event->oncpu) != smp_processor_id())
kernel/events/core.c:            * inactive here (event->oncpu==-1), there's nothing more to do;
kernel/events/core.c:           ret = cpu_function_call(READ_ONCE(event->oncpu),
kernel/events/core.c:   event_oncpu = __perf_event_read_cpu(event, event->oncpu);
kernel/events/core.c:            * Orders the ->state and ->oncpu loads such that if we see
kernel/events/core.c:            * ACTIVE we must also see the right ->oncpu.
kernel/events/core.c:           event_cpu = READ_ONCE(event->oncpu);
kernel/events/core.c:   int cpu = READ_ONCE(event->oncpu);
kernel/events/core.c:   if (WARN_ON_ONCE(READ_ONCE(sampler->oncpu) != smp_processor_id()))
kernel/events/core.c:                   cpu = READ_ONCE(iter->oncpu);
kernel/events/core.c:   event->oncpu            = -1;
kernel/trace/bpf_trace.c:       if (unlikely(event->oncpu != cpu))
⬢[acme@toolbox perf-tools-next]$

This looks like a bug, no? It seems what this patch is doing is papering
onver that bug :-\

Alexei, Peter?

That part in the cset introducing bpf_perf_output_event() says:

"User space needs to perf_event_open() it (either for one or all cpus)"

-1 should mean all cpus, right, or is bpf_perf_event_output() only
supported if we do as Howard did in this patch?

---
commit a43eec304259a6c637f4014a6d4767159b6a3aa3
Author: Alexei Starovoitov <ast@kernel.org>
Date:   Tue Oct 20 20:02:34 2015 -0700

    bpf: introduce bpf_perf_event_output() helper
    
    This helper is used to send raw data from eBPF program into
    special PERF_TYPE_SOFTWARE/PERF_COUNT_SW_BPF_OUTPUT perf_event.
    User space needs to perf_event_open() it (either for one or all cpus) and
    store FD into perf_event_array (similar to bpf_perf_event_read() helper)
    before eBPF program can send data into it.
---

We're missing something, can you help?

- Arnaldo

> > When using perf trace -p 114, before perf_event_open(), we'll have PID
> > = 114, and CPU = -1.
> >
> > This is bad for bpf-output event, because the ring buffer won't accept
> > output from BPF's perf_event_output(), making it fail. I'm still trying
> > to find out why.
> >
> > If we open bpf-output for every cpu, instead of setting it to -1, like
> > this:
> > PID = <PID>, CPU = 0
> > PID = <PID>, CPU = 1
> > PID = <PID>, CPU = 2
> > PID = <PID>, CPU = 3
> > ...
> >
> > Everything works.
> >
> > You can test it with this script:
> > ```
> >  #include <unistd.h>
> >  #include <sys/syscall.h>
> >
> > int main()
> > {
> >         int i1 = 1, i2 = 2, i3 = 3, i4 = 4;
> >         char s1[] = "DINGZHEN", s2[] = "XUEBAO";
> >
> >         while (1) {
> >                 syscall(SYS_open, s1, i1, i2);
> >                 sleep(1);
> >         }
> >
> >         return 0;
> > }
> > ```
> >
> > save, compile
> > ```
> > gcc open.c
> > ```
> >
> > perf trace
> > ```
> > perf trace -e open <path-to-the-executable>
> > ```
> >
> > Signed-off-by: Howard Chu <howardchu95@gmail.com>
> > ---
> >  tools/perf/util/evlist.c | 14 +++++++++++++-
> >  tools/perf/util/evlist.h |  1 +
> >  2 files changed, 14 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> > index c0379fa1ccfe..f14b7e6ff1dc 100644
> > --- a/tools/perf/util/evlist.c
> > +++ b/tools/perf/util/evlist.c
> > @@ -1067,7 +1067,7 @@ int evlist__create_maps(struct evlist *evlist, struct target *target)
> >         if (!threads)
> >                 return -1;
> >
> > -       if (target__uses_dummy_map(target))
> > +       if (target__uses_dummy_map(target) && !evlist__has_bpf_output(evlist))
> 
> I'm wondering if there should be a comment above this, something like:
> 
> Do we need the "any"/-1 CPU value or do we need to open an event on
> all target CPUs (the default NULL implies all online CPUs). The dummy
> map indicates that we need sideband perf record events in order to
> symbolize samples. The mmap-ed ring buffers need CPUs. Similarly BPF
> output events need ring buffers.
> 
> I'm not 100% on the ring buffer perf_event_open restrictions, and the
> man page doesn't cover it, my knowledge is implied from failures and
> seeing what the tool does.
> 
> Thanks,
> Ian
> 
> 
> >                 cpus = perf_cpu_map__new_any_cpu();
> >         else
> >                 cpus = perf_cpu_map__new(target->cpu_list);
> > @@ -2627,3 +2627,15 @@ void evlist__uniquify_name(struct evlist *evlist)
> >                 }
> >         }
> >  }
> > +
> > +bool evlist__has_bpf_output(struct evlist *evlist)
> > +{
> > +       struct evsel *evsel;
> > +
> > +       evlist__for_each_entry(evlist, evsel) {
> > +               if (evsel__is_bpf_output(evsel))
> > +                       return true;
> > +       }
> > +
> > +       return false;
> > +}
> > diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
> > index b46f1a320783..bcc1c6984bb5 100644
> > --- a/tools/perf/util/evlist.h
> > +++ b/tools/perf/util/evlist.h
> > @@ -447,5 +447,6 @@ int evlist__scnprintf_evsels(struct evlist *evlist, size_t size, char *bf);
> >  void evlist__check_mem_load_aux(struct evlist *evlist);
> >  void evlist__warn_user_requested_cpus(struct evlist *evlist, const char *cpu_list);
> >  void evlist__uniquify_name(struct evlist *evlist);
> > +bool evlist__has_bpf_output(struct evlist *evlist);
> >
> >  #endif /* __PERF_EVLIST_H */
> > --
> > 2.45.2
> >
