From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH perf/core  00/22] perf refcnt debugger API and fixes
Date: Wed, 9 Dec 2015 10:41:38 -0300
Message-ID: <20151209134138.GB15864@kernel.org>
References: <20151209021047.10245.8918.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:47181 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754345AbbLINlo (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 9 Dec 2015 08:41:44 -0500
Content-Disposition: inline
In-Reply-To: <20151209021047.10245.8918.stgit@localhost.localdomain>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, Adrian Hunter <adrian.hunter@intel.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@redhat.com>, Wang Nan <wangnan0@huawei.com>, Alexei Starovoitov <ast@plumgrid.com>

Em Wed, Dec 09, 2015 at 11:10:48AM +0900, Masami Hiramatsu escreveu:
> Hi Arnaldo,
> 
> Here is a series of patches for perf refcnt debugger and
> some fixes.
> 
> In this series I've replaced all atomic reference counters
> with the refcnt interface, including dso, map, map_groups,
> thread, cpu_map, comm_str, cgroup_sel, thread_map, and
> perf_mmap.
> 
>   refcnt debugger (or refcnt leak checker)
>   ===============
> 
> At first, note that this change doesn't affect any compiled
> code unless building with REFCNT_DEBUG=1 (see macros in
> refcnt.h). So, this feature is only enabled in the debug binary.
> But before releasing, we can ensure that all objects are safely
> reclaimed before exit in -rc phase.

That helps and is finding bugs and is really great stuff, thank you!

But I wonder if we couldn't get the same results on an unmodified binary
by using things like 'perf probe', the BPF code we're introducing, have
you thought about this possibility?

I.e. trying to use 'perf probe' to do this would help in using the same
technique in other code bases where we can't change the sources, etc.

For perf we could perhaps use a 'noinline' on the __get/__put
operations, so that we could have the right places to hook using
uprobes, other codebases would have to rely in the 'perf probe'
infrastructure that knows where inlines were expanded, etc.

Such a toold could work like:

   perf dbgrefcnt ~/bin/perf thread 

And it would look up thread__get and thread__put(), create an eBPF map
where to store the needed tracking data structures, and use the same
techniques you used, asking for backtraces using the perf
infrastructure, etc.

We would be using this opportunity to improve the 'perf probe' and the
eBPF infrastructures we're putting in place, and having something that
could be used in other codebases, not just perf.

Comments about other issues are below:
 
> To use the refcnt debugger, you just build a perf binary with
> REFCNT_DEBUG=1 as follows;
>   ----
>   # make REFCNT_DEBUG=1
>   ----
> And run the perf command. If the refcnt debugger finds leaks,
> it shows the summary of the bugs. Note that if the command does
> not use stdio, it doesn't show anything because refcnt debugger
> uses pr_debug. Please use --stdio option in such case.

It would be interesting to have this writing to a file instead, so that
we could use the same technique for the TUI and other UIs.
 
> E.g. with the first 13 patches, perf top shows that many objects
> are leaked.
>   ----
>   # ./perf top --stdio
>   q
>   exiting.
>   REFCNT: BUG: Unreclaimed objects found.
>   REFCNT: Total 3595 objects are not reclaimed.
>     "map" leaks 3334 objects
>     "dso" leaks 231 objects
>     "thread" leaks 9 objects
>     "comm_str" leaks 13 objects
>     "map_groups" leaks 8 objects
>      To see all backtraces, rerun with -v option
>   ----
> You can also dump all the backtrace data with -v option, but I
> don't recommend you to do it on your console, because it will
> be very very long (for example, above dumps 40MB text logs
> on your console).
> 
> Instead, you can use PERF_REFCNT_DEBUG_FILTER env. var. to focus
> on one object, and also use "2>" to redirect stderr output to file.
> E.g.
>   ----
>   # PERF_REFCNT_DEBUG_FILTER=map ./perf top --stdio -v 2> refcnt.log
>   q
>   exiting.
>   # less refcnt.log
>   mmap size 528384B
>   Looking at the vmlinux_path (8 entries long)
>   Using /lib/modules/4.3.0-rc2+/build/vmlinux for symbols
>   REFCNT: BUG: Unreclaimed objects found.
>   ==== [0] ====
>   Unreclaimed map@0x2157dc0
>   Refcount +1 => 1 at
>   ...
>     ./perf() [0x4226fd]
>   REFCNT: Total 3229 objects are not reclaimed.
>     "map" leaks 3229 objects
>   ----
> 
>   Bugfixes
>   ========
> 
> In this series I've also tried to fix some object leaks in perf top
> and perf stat.
> After applying this series, this reduced (not vanished) to 1/5.
>   ----
>   # ./perf top --stdio
>   q
>   exiting.
>   REFCNT: BUG: Unreclaimed objects found.
>   REFCNT: Total 866 objects are not reclaimed.
>     "dso" leaks 213 objects
>     "map" leaks 624 objects
>     "comm_str" leaks 12 objects
>     "thread" leaks 9 objects
>     "map_groups" leaks 8 objects
>      To see all backtraces, rerun with -v option
>   ----
> 
> Actually, I'm still not able to fix all of the bugs. It seems that
> hists has a bug that hists__delete_entries doesn't delete all the
> entries because some entries are on hists->entries but others on
> hists->entries_in. And I'm not so sure about hists.c.
> Arnaldo, would you have any idea for this bug?

I'll will audit the hists code, its all about collecting new entries
into an rbtree to then move the last batch for merging with the
previous, decayed ones while continuing to process a new batch in
another thread.
 
> 
>   General refcnt miscodings
>   =========================
> 
> BTW, while applying this change, I've found that there are refcnt
> coding mismatches in those code and most of the bugs come from those
> mismatches.
> 
> - The reference counter can be initialized by 0 or 1.
>  - If 0 is chosen, caller have to get it and free it if failed to
>    register appropriately.
>  - If 1 is chosen, caller doesn't need to get it, but when exits the
>    caller, it has to put it. (except for returning the object itself)
> - The application should choose either one as its policy, to avoid
>   confusion.
> 
> perf tools mixes it up (moreover, it initializes 2 in a case) and
> caller usually forgets to put it (it is not surprising, because too
> many "put" usually cause SEGV by accessing freed object.)

Well, we should fix the bugs and document why some initialization is
deemed better than a single initialization style.

For instance, if we know that we will keep multiple references straight
away, then we could init it with some value different that preferred,
that I aggee, is 1, i.e. the usual way for some constructor is:


struct foo *foo__new()
{
	struct foo *f = malloc(sizeof (*f));

	if (f) {
		atomic_set(&f->refcnt, 1);
	}

	return f;
}

void *foo__delete(struct foo *f)
{
	free(f);
}

void foo__put(struct foo *f)
{
	if (f && atomic_dec_and_test(f->refcnt))
		foo__delete(f);
}


Then, when using if, and before adding it to any other tree, list, i.e.
a container, we do:

	struct foo *f = foo__new();

	/*
	 * assume f was allocated and then the function allocating it
	 * failed, when it bails out it should just do:
 	 */
out_error:
	foo__put(f);

And that will make it hit zero, which will call foo__delete(), case
closed.
 
> As far as I can see, cgroup_sel, perf_mmap(this is initialized 0 or 2...),
> thread, and comm_str are initialized by 0. Others are initialized by 1.
> 
> So, I'd like to suggest that we choose one policy and cleanup the code.
> I recommend to use init by 1 policy, because anyway caller has to get

See above, if nothing else recommends using a different value, use 1.

> the refcnt. Suppose the below code;
> 
>    ----
> obj__new() {
> 	obj = zalloc(sizeof(*obj));
> 	refcnt__init(obj, refcnt, 0);
> 	return obj;
> }
> 
> caller() {
> 	obj = obj__new();
> 	if (parent__add_obj(parent, obj) != SUCCESS) {
> 		free(obj);
> 	}
> }
>    ----
> 
> At first glance, this looks good. However, if the parent__add_obj() once

The caller never should call free or the object destructor (i.e.
foo__delete() in my example above), it should _always_ just drop the
referece it has to the object, i.e. call foo__put()

> gets the obj(refcnt => 1) and fails to add it to parent list by some reason,
> it should put the obj(refcnt => 0). This means the obj is already freed at
> that point.
> 
> Then, caller() shouldn't free obj in error case? No, because parent__add_obj()
> can fail before getting the obj :(. Maybe we can handle it by checking return
> code, but it is ugly.
> 
> If we choose "init by 1", caller always has to put it before returning. But

Right, if you don't keep a pointer to the object that at a later point
you will call obj__put() on it, then you should do it straight away
after adding it to some list, tree, array, i.e. a container, and the
container adding operation should grab a refcount, that will be dropped
when the object is removed from that data structure.

> the coding rule becomes simpler.
>    ----
> caller() {
> 	obj = obj__new();
> 	if (parent__add_obj(parent, obj) != SUCCESS) {
> 		ret = errorcode;
> 	}
> 	obj__put(obj);
> 	return ret;
> }
>    ----
> 
> Thank you,
> 
> ---
> 
> Masami Hiramatsu (22):
>       [v2] perf refcnt: Introduce generic refcount APIs with debug feature
>       perf refcnt: Use a hash for refcnt_root
>       perf refcnt: Add refcnt debug filter
>       perf refcnt: refcnt shows summary per object
>       perf: make map to use refcnt
>       perf: Make dso to use refcnt for debug
>       perf: Make map_groups to use refcnt
>       perf: Make thread uses refcnt for debug
>       perf: Make cpu_map to use refcnt for debug
>       perf: Make comm_str to use refcnt for debug
>       perf: Make cgroup_sel to use refcnt for debug
>       perf: Make thread_map to use refcnt for debug
>       perf: Make perf_mmap to use refcnt for debug
>       perf: Fix dso__load_sym to put dso
>       perf: Fix map_groups__clone to put cloned map
>       perf: Fix __cmd_top and perf_session__process_events to put the idle thread
>       perf: Fix __machine__addnew_vdso to put dso after add to dsos
>       perf stat: Fix cmd_stat to release cpu_map
>       perf: fix hists_evsel to release hists
>       perf: Fix maps__fixup_overlappings to put used maps
>       perf: Fix machine.vmlinux_maps to make sure to clear the old one
>       perf: Fix write_numa_topology to put cpu_map instead of free
> 
> 
>  tools/perf/builtin-stat.c    |   11 ++
>  tools/perf/builtin-top.c     |    6 +
>  tools/perf/config/Makefile   |    5 +
>  tools/perf/util/Build        |    1 
>  tools/perf/util/cgroup.c     |   11 +-
>  tools/perf/util/comm.c       |    8 +
>  tools/perf/util/cpumap.c     |   33 +++---
>  tools/perf/util/dso.c        |    7 +
>  tools/perf/util/evlist.c     |    8 +
>  tools/perf/util/header.c     |    2 
>  tools/perf/util/hist.c       |   10 ++
>  tools/perf/util/machine.c    |    5 +
>  tools/perf/util/map.c        |   15 ++-
>  tools/perf/util/map.h        |    5 +
>  tools/perf/util/refcnt.c     |  229 ++++++++++++++++++++++++++++++++++++++++++
>  tools/perf/util/refcnt.h     |   70 +++++++++++++
>  tools/perf/util/session.c    |   10 ++
>  tools/perf/util/symbol-elf.c |    2 
>  tools/perf/util/thread.c     |    7 +
>  tools/perf/util/thread_map.c |   28 +++--
>  tools/perf/util/vdso.c       |    2 
>  21 files changed, 420 insertions(+), 55 deletions(-)
>  create mode 100644 tools/perf/util/refcnt.c
>  create mode 100644 tools/perf/util/refcnt.h
> 
> 
> -- 
> Masami HIRAMATSU
> Linux Technology Research Center, System Productivity Research Dept.
> Center for Technology Innovation - Systems Engineering 
> Hitachi, Ltd., Research & Development Group
> E-mail: masami.hiramatsu.pt@hitachi.com
