Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8836B1B982E;
	Tue, 18 Feb 2025 20:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739911018; cv=none; b=Wf4lscZWmzSTLHJr/g5fiUFiwYhI9YkzJZkMlLkKVQo6FEztANajhpeysqaHVdZ8zgoTTrANEy79W5N6jcmNY3pmlmN+hoem/TUA1fcNjQ1MD9J9KbwM+A4mfoKSJPKeb/Zk8hmgLsEzp7jStxDmPIU81e8Ip4M8f4G7JKAgIwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739911018; c=relaxed/simple;
	bh=+vOB4pI0liP3PpCo4sp/ZxKCZ/vkXcjKDnT8iKYlg5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d+ZIeVAJCB2QTaZlOpSmklsN4PZz3Wp33zjaJ1C+AjvSopr6mqUdMmUgIjfkDWP2MyjDxfvfyr5K3s1cDX0dn2UFHoBvCOO/bYRmr1XkUK1xe9UdrwxAQagfkWo7sSttVadqiVq7XQgWT2DvdmUPOosW8nPyOWbschkJ5SM5jig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fvxKnveF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fvxKnveF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60C2DC4CEE2;
	Tue, 18 Feb 2025 20:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739911015;
	bh=+vOB4pI0liP3PpCo4sp/ZxKCZ/vkXcjKDnT8iKYlg5Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fvxKnveFvcp4mUQsNLFuXYPZ3oFsOceim8Y6cMSKjedbxDOFJ66+mhGdinBh+uKYg
	 7ya4qehxvsTA7iy9UcuYrkYFpcIOqmEV3gUIXxw5O9KdNsZlvwZOHFFCH/OVtRWc5n
	 2ig56Ne45jpyol8AJBBJvnm0DCvtZ7EqHYwqm/Doe0aI4h1t9lb6XFvIWf7NTqJqHc
	 FxK9v3Yis5tqbRLRdYDpIYy9yAK2gACpG4IzIWWUpbG8hneez9bpquRVZrTNfTgRKd
	 zucUWryel9CaJekuEeGJ8BWRyyTB8Qap+xNOyx6YYy6NH7o5LIOosD/1TaxdqlHpFY
	 2wWE0Wpnmm9wg==
Date: Tue, 18 Feb 2025 21:36:52 +0100
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH] perf report: Add 'tgid' sort key
Message-ID: <Z7TvZGjVix2asYWI@x1>
References: <20250206000137.2026034-1-namhyung@kernel.org>
 <Z60NFEAf2C8cL8Xh@x1>
 <Z60Ndm8VVI4Ao31U@x1>
 <CAP-5=fXw09MM5XyozJMM3FjMANJei1aNVmBghSEQFiCKAtJmXw@mail.gmail.com>
 <CAP-5=fUqcykMdApHVweETg9bp2EVPJhJOj_PR8cByOOA6OyQGw@mail.gmail.com>
 <Z6_CL0RpUUvw0lR7@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z6_CL0RpUUvw0lR7@x1>

On Fri, Feb 14, 2025 at 11:22:39PM +0100, Arnaldo Carvalho de Melo wrote:
> On Wed, Feb 12, 2025 at 02:10:42PM -0800, Ian Rogers wrote:
> > On Wed, Feb 12, 2025 at 1:59 PM Ian Rogers <irogers@google.com> wrote:
> > > On Wed, Feb 12, 2025 at 1:07 PM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > > > On Wed, Feb 12, 2025 at 10:05:27PM +0100, Arnaldo Carvalho de Melo wrote:
> > > > > On Wed, Feb 05, 2025 at 04:01:37PM -0800, Namhyung Kim wrote:
> > > > > > Sometimes we need to analyze the data in process level but current sort
> > > > > > keys only work on thread level.  Let's add 'tgid' sort key for that as
> > > > > > 'pid' is already taken for thread.
> 
> > > > > > This will look mostly the same, but it only uses tgid instead of tid.
> > > > > > Here's an example of a process with two threads (thloop).
> 
> > > > > >   $ perf record -- perf test -w thloop
> 
> > > > > Unrelated, but when building perf with DEBUG=1 and trying to test the
> > > > > above I noticed:
> 
> > > > > root@number:~# perf record -- perf test -w thloop
> > > > > [ perf record: Woken up 1 times to write data ]
> > > > > [ perf record: Captured and wrote 0.404 MB perf.data (7968 samples) ]
> > > > > perf: util/maps.c:95: check_invariants: Assertion `map__end(prev) <= map__end(map)' failed.
> > > > > Aborted (core dumped)
> > > > > root@number:~# perf record -- perf test -w offcpu
> > > > > [ perf record: Woken up 1 times to write data ]
> > > > > [ perf record: Captured and wrote 0.040 MB perf.data (23 samples) ]
> > > > > perf: util/maps.c:95: check_invariants: Assertion `map__end(prev) <= map__end(map)' failed.
> > > > > Aborted (core dumped)
> > > > > root@number:~#
> 
> > > > > I have:
> 
> > > > > ⬢ [acme@toolbox perf-tools-next]$ git log --oneline perf-tools-next/perf-tools-next..
> > > > > 9de1ed6fa3b73cb1 (HEAD -> perf-tools-next) perf report: Add 'tgid' sort key
> > > > > 23e98ede2a353530 perf trace: Add --summary-mode option
> > > > > e6d6104625a3790b perf tools: Get rid of now-unused rb_resort.h
> > > > > 173ec14e72ef4ed7 perf trace: Convert syscall_stats to hashmap
> > > > > 66edfb5d404e743d perf trace: Allocate syscall stats only if summary is on
> > > > > ca6637e1ea08e6f4 perf parse-events filter: Use evsel__find_pmu()
> > > > > bd1ac4a678f7f2c8 perf bench evlist-open-close: Reduce scope of 2 variables
> > > > > cd59081880e89df8 perf test: Add direct off-cpu test
> > > > > 56cbd794c0c46ba9 perf record --off-cpu: Add --off-cpu-thresh option
> > > > > 28d9b19c5455556f perf record --off-cpu: Dump the remaining samples in BPF's stack trace map
> > > > > 2bc05b02743b50a7 perf script: Display off-cpu samples correctly
> > > > > bfa457a621596947 perf record --off-cpu: Disable perf_event's callchain collection
> > > > > eca732cc42d20266 perf evsel: Assemble offcpu samples
> > > > > 74ce50e40c569e90 perf record --off-cpu: Dump off-cpu samples in BPF
> > > > > e75f8ce63bfa6cb9 perf record --off-cpu: Preparation of off-cpu BPF program
> > > > > 0ffab9d26971c91c perf record --off-cpu: Parse off-cpu event
> > > > > efc3fe2070853b7d perf evsel: Expose evsel__is_offcpu_event() for future use
> > > > > ⬢ [acme@toolbox perf-tools-next]$
> 
> > > > > locally, that is the stuff I've been testing lately, doubt it is related
> > > > > to these patches, I'll investigate later, have to go AFK, so FWIW as a
> > > > > heads up.
> 
> > > > Had time to extract this, now going really AFK:
> 
> > > > [New Thread 0x7fffdf24c6c0 (LWP 580622)]
> > > > [ perf record: Woken up 1 times to write data ]
> > > > [ perf record: Captured and wrote 0.403 MB perf.data (7948 samples) ]
> > > > [Thread 0x7fffdf24c6c0 (LWP 580622) exited]
> > > > perf: util/maps.c:95: check_invariants: Assertion `map__end(prev) <= map__end(map)' failed.
> 
> > > > Thread 1 "perf" received signal SIGABRT, Aborted.
> > > > Downloading 4.06 K source file /usr/src/debug/glibc-2.39-37.fc40.x86_64/nptl/pthread_kill.c
> > > > __pthread_kill_implementation (threadid=<optimized out>, signo=signo@entry=6, no_tid=no_tid@entry=0) at pthread_kill.c:44
> > > > 44            return INTERNAL_SYSCALL_ERROR_P (ret) ? INTERNAL_SYSCALL_ERRNO (ret) : 0;
> > > > (gdb) bt
> > > > #0  __pthread_kill_implementation (threadid=<optimized out>, signo=signo@entry=6, no_tid=no_tid@entry=0) at pthread_kill.c:44
> > > > #1  0x00007ffff6ea80a3 in __pthread_kill_internal (threadid=<optimized out>, signo=6) at pthread_kill.c:78
> > > > #2  0x00007ffff6e4ef1e in __GI_raise (sig=sig@entry=6) at ../sysdeps/posix/raise.c:26
> > > > #3  0x00007ffff6e36902 in __GI_abort () at abort.c:79
> > > > #4  0x00007ffff6e3681e in __assert_fail_base (fmt=0x7ffff6fc3bb8 "%s%s%s:%u: %s%sAssertion `%s' failed.\n%n", assertion=assertion@entry=0x7bef08 "map__end(prev) <= map__end(map)",
> > > >     file=file@entry=0x7bedf8 "util/maps.c", line=line@entry=95, function=function@entry=0x7bf1c0 <__PRETTY_FUNCTION__.6> "check_invariants") at assert.c:96
> > > > #5  0x00007ffff6e47047 in __assert_fail (assertion=0x7bef08 "map__end(prev) <= map__end(map)", file=0x7bedf8 "util/maps.c", line=95,
> > > >     function=0x7bf1c0 <__PRETTY_FUNCTION__.6> "check_invariants") at assert.c:105
> > > > #6  0x00000000006347a1 in check_invariants (maps=0xf987e0) at util/maps.c:95
> > > > #7  0x0000000000635ae2 in maps__remove (maps=0xf987e0, map=0xf98a80) at util/maps.c:538
> > > > #8  0x000000000062afd2 in machine__destroy_kernel_maps (machine=0xf98178) at util/machine.c:1176
> > > > #9  0x000000000062b32b in machines__destroy_kernel_maps (machines=0xf98178) at util/machine.c:1238
> > > > #10 0x00000000006388af in perf_session__destroy_kernel_maps (session=0xf97f60) at util/session.c:105
> > > > #11 0x0000000000638df0 in perf_session__delete (session=0xf97f60) at util/session.c:248
> > > > #12 0x0000000000431f18 in __cmd_record (rec=0xecace0 <record>, argc=4, argv=0x7fffffffde60) at builtin-record.c:2888
> > > > #13 0x00000000004351fb in cmd_record (argc=4, argv=0x7fffffffde60) at builtin-record.c:4286
> > > > #14 0x00000000004bd4d4 in run_builtin (p=0xecddc0 <commands+288>, argc=6, argv=0x7fffffffde60) at perf.c:351
> > > > #15 0x00000000004bd77b in handle_internal_command (argc=6, argv=0x7fffffffde60) at perf.c:404
> > > > #16 0x00000000004bd8d4 in run_argv (argcp=0x7fffffffdc4c, argv=0x7fffffffdc40) at perf.c:448
> > > > #17 0x00000000004bdc1d in main (argc=6, argv=0x7fffffffde60) at perf.c:556
> > > > (gdb)
> 
> > > So my guess would be that something modified a map and broke the
> > > invariants of the maps_by_addresss/maps_by_name. It should be possible
> > > to add more check_invariants to work out where this happens.
>  
> > I also suspect this is a regression. If you could bisect to find the
> 
> I bisected it to:
> 
> ⬢ [acme@toolbox perf-tools-next]$ git bisect good
> 876e80cf83d10585df6ee1e353cfbf562f9a930e is the first bad commit
> commit 876e80cf83d10585df6ee1e353cfbf562f9a930e
> Author: Namhyung Kim <namhyung@kernel.org>
> Date:   Wed Dec 18 14:04:53 2024 -0800
> 
>     perf tools: Fixup end address of modules
>     
>     In machine__create_module(), it reads /proc/modules to get a list of
>     modules in the system.  The file shows the start address (of text) and
>     the size of the module so it uses the info to reconstruct system memory
>     maps for symbol resolution.
>     
>     But module memory consists of multiple segments and they can be
>     scaterred.  Currently perf tools assume they are contiguous and see some
>     overlaps.  This can confuse the tool when it finds a map containing a
>     given address.
>     
>     As we mostly care about the function symbols in the text segment, it can
>     fixup the size or end address of modules when there's an overlap.  We
>     can use maps__fixup_end() which updates the end address using the start
>     address of the next map.
>     
>     Ideally it should be able to track other segments (like data/rodata),
>     but that would require some changes in /proc/modules IMHO.
>     
>     Reported-by: Blake Jones <blakejones@google.com>
>     Signed-off-by: Namhyung Kim <namhyung@kernel.org>
>     Acked-by: Ian Rogers <irogers@google.com>
>     Cc: Adrian Hunter <adrian.hunter@intel.com>
>     Cc: Daniel Gomez <da.gomez@samsung.com>
>     Cc: Ingo Molnar <mingo@kernel.org>
>     Cc: Jiri Olsa <jolsa@kernel.org>
>     Cc: Kan Liang <kan.liang@linux.intel.com>
>     Cc: Luis Chamberlain <mcgrof@kernel.org>
>     Cc: Peter Zijlstra <peterz@infradead.org>
>     Cc: Petr Pavlu <petr.pavlu@suse.com>
>     Cc: Sami Tolvanen <samitolvanen@google.com>
>     Link: https://lore.kernel.org/r/20241218220453.203069-1-namhyung@kernel.org
>     Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
>  tools/perf/util/machine.c | 2 ++
>  1 file changed, 2 insertions(+)
> ⬢ [acme@toolbox perf-tools-next]$
> 
> If we simply revert this it gets back working:
> 
> ⬢ [acme@toolbox perf-tools-next]$ git revert 876e80cf83d10585df6ee1e353cfbf562f9a930e
> Auto-merging tools/perf/util/machine.c
> [perf-tools-next 1ab31115859a0944] Revert "perf tools: Fixup end address of modules"
>  1 file changed, 2 deletions(-)
> # rm -rf build dir, rebuild it
> 
> root@number:~# perf record -- perf test -w thloop
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.403 MB perf.data (7960 samples) ]
> root@number:~# 
> 
> No time today to try to dig deeper, so just reporting the bisection
> result.

So, using 'perf probe' + 'perf trace' to trace 'perf record':

root@number:~# perf probe -x ~/bin/perf maps__insert maps 'map->dso->name:string'
Target program is compiled without optimization. Skipping prologue.
Probe on address 0x634e4e to force probing at the function entry.

Added new event:
  probe_perf:maps_insert (on maps__insert in /home/acme/bin/perf with maps name=map->dso->name:string)

You can now use it in all perf tools, such as:

	perf record -e probe_perf:maps_insert -aR sleep 1

root@number:~# perf probe -x ~/bin/perf maps__fixup_end maps 
Target program is compiled without optimization. Skipping prologue.
Probe on address 0x636c14 to force probing at the function entry.

Added new event:
  probe_perf:maps_fixup_end (on maps__fixup_end in /home/acme/bin/perf with maps)

You can now use it in all perf tools, such as:

	perf record -e probe_perf:maps_fixup_end -aR sleep 1

root@number:~# perf probe -l
  probe_perf:maps_fixup_end (on maps__fixup_end:1@util/maps.c in /home/acme/bin/perf with maps)
  probe_perf:maps_insert (on maps__insert:1@util/maps.c in /home/acme/bin/perf with maps name)
root@number:~# perf trace -e probe_perf:maps* perf record sleep 1
     0.000 perf/1346602 probe_perf:maps_insert(__probe_ip: 6508126, maps: 155203024, name: "[kernel.kallsyms]")
     0.040 perf/1346602 probe_perf:maps_insert(__probe_ip: 6508126, maps: 155203024, name: "[overlay]")
     0.053 perf/1346602 probe_perf:maps_insert(__probe_ip: 6508126, maps: 155203024, name: "[rfcomm]")
<SNIP>
     2.736 perf/1346602 probe_perf:maps_insert(__probe_ip: 6508126, maps: 155203024, name: "[nvme_auth]")
     2.757 perf/1346602 probe_perf:maps_insert(__probe_ip: 6508126, maps: 155203024, name: "[video]")
     2.773 perf/1346602 probe_perf:maps_insert(__probe_ip: 6508126, maps: 155203024, name: "[wmi]")
     2.789 perf/1346602 probe_perf:maps_insert(__probe_ip: 6508126, maps: 155203024, name: "[pinctrl_alderlake]")
     2.804 perf/1346602 probe_perf:maps_insert(__probe_ip: 6508126, maps: 155203024, name: "[ip6_tables]")
     2.821 perf/1346602 probe_perf:maps_insert(__probe_ip: 6508126, maps: 155203024, name: "[ip_tables]")
     2.838 perf/1346602 probe_perf:maps_insert(__probe_ip: 6508126, maps: 155203024, name: "[fuse]")
    66.799 perf/1346602 probe_perf:maps_insert(__probe_ip: 6508126, maps: 155203024, name: "[kernel.kallsyms]")
   192.465 perf/1346602 probe_perf:maps_fixup_end(__probe_ip: 6515745, maps: 155203024)
[ perf record: Woken up 1 times to write data ]
  1327.967 perf/1346602 probe_perf:maps_insert(__probe_ip: 6508126, maps: 155203024, name: "bpf_prog_e8932b6bae2b9745_restrict_filesystems")
  1328.015 perf/1346602 probe_perf:maps_insert(__probe_ip: 6508126, maps: 155203024, name: "bpf_prog_40ddf486530245f5_sd_devices")
  1328.025 perf/1346602 probe_perf:maps_insert(__probe_ip: 6508126, maps: 155203024, name: "bpf_prog_6deef7357e7b4530_sd_fw_egress")
<SNIP>
  1328.296 perf/1346602 probe_perf:maps_insert(__probe_ip: 6508126, maps: 155203024, name: "bpf_prog_6deef7357e7b4530_sd_fw_egress")
  1328.308 perf/1346602 probe_perf:maps_insert(__probe_ip: 6508126, maps: 155203024, name: "bpf_prog_6deef7357e7b4530_sd_fw_ingress")
  1328.320 perf/1346602 probe_perf:maps_insert(__probe_ip: 6508126, maps: 155203024, name: "bpf_prog_6deef7357e7b4530_sd_fw_egress")
  1328.331 perf/1346602 probe_perf:maps_insert(__probe_ip: 6508126, maps: 155203024, name: "bpf_prog_6deef7357e7b4530_sd_fw_ingress")
  1328.343 perf/1346602 probe_perf:maps_insert(__probe_ip: 6508126, maps: 155203024, name: "bpf_prog_be31ae23198a0378_sd_devices")
  1328.354 perf/1346602 probe_perf:maps_insert(__probe_ip: 6508126, maps: 155203024, name: "bpf_trampoline_6442522522")
[ perf record: Captured and wrote 0.036 MB perf.data (19 samples) ]
perf: util/maps.c:95: check_invariants: Assertion `map__end(prev) <= map__end(map)' failed.
root@number:~#


So the call to maps_fixup_end() will set maps->end_broken to false,
since it fixed up the map ends, etc, but then we insert more maps with
broken ends:

#6  0x0000000000633d52 in check_invariants (maps=0xf967c0) at util/maps.c:95
95						assert(map__end(prev) <= map__end(map));
(gdb) p prev->dso->name
$1 = 0xfc47ab "bpf_trampoline_6442522522"
(gdb) p map->dso->name
$2 = 0xfe5dcb "bpf_prog_40ddf486530245f5_sd_devices"
(gdb) p /x prev->start
$3 = 0xffffffffc0147640
(gdb) p /x map->start
$4 = 0xffffffffc014774c
(gdb) p /x prev->end
$5 = 0xffffffffc0148640
(gdb) p /x map->end
$6 = 0xffffffffc014788b
(gdb) p prev->start < map->start
$7 = 1
(gdb) p prev->end < map->start
$8 = 0
(gdb)

If we ask for backtraces we see where maps are added after fixup_end:

    59.088 perf/1448114 probe_perf:maps_insert(__probe_ip: 6508126, maps: 267654608, name: "[kernel.kallsyms]")
                                       maps__insert (/home/acme/bin/perf)
                                       machine__update_kernel_mmap (/home/acme/bin/perf)
                                       machine__create_kernel_maps (/home/acme/bin/perf)
                                       perf_session__create_kernel_maps (/home/acme/bin/perf)
                                       __perf_session__new (/home/acme/bin/perf)
                                       perf_session__new (/home/acme/bin/perf)
                                       __cmd_record (/home/acme/bin/perf)
                                       cmd_record (/home/acme/bin/perf)
   185.548 perf/1448114 probe_perf:maps_fixup_end(__probe_ip: 6515745, maps: 267654608)
                                       maps__fixup_end (/home/acme/bin/perf)
                                       machine__create_kernel_maps (/home/acme/bin/perf)
                                       perf_session__create_kernel_maps (/home/acme/bin/perf)
                                       __perf_session__new (/home/acme/bin/perf)
                                       perf_session__new (/home/acme/bin/perf)
                                       __cmd_record (/home/acme/bin/perf)
                                       cmd_record (/home/acme/bin/perf)
                                       run_builtin (/home/acme/bin/perf)
sleep: missing operand
Try 'sleep --help' for more information.
[ perf record: Woken up 1 times to write data ]
   320.675 perf/1448114 probe_perf:maps_insert(__probe_ip: 6508126, maps: 267654608, name: "bpf_prog_e8932b6bae2b9745_restrict_filesystems")
                                       maps__insert (/home/acme/bin/perf)
                                       machine__process_ksymbol_register (/home/acme/bin/perf)
                                       machine__process_ksymbol (/home/acme/bin/perf)
                                       perf_event__process_ksymbol (/home/acme/bin/perf)
                                       machines__deliver_event (/home/acme/bin/perf)
                                       perf_session__deliver_event (/home/acme/bin/perf)
                                       perf_session__process_event (/home/acme/bin/perf)
                                       process_simple (/home/acme/bin/perf)


Now looking at machine__process_ksymbol_register()...

- Arnaldo
