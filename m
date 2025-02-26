Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E02625B66D;
	Wed, 26 Feb 2025 21:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740606575; cv=none; b=cMJGNL/Sszs5T6MqnbHsNMvN345KIEOq8nc57Agj93/YD2NeaDu+l5UYZ+ThdhTl/mpLOqDMmbRxBN9+k2J47T3UMDgzbdxtmB727o5lsoQOuqOOSVQCdoiuiO0BdEbRsQS277LzMHfmG+LnQxZz8kvyTKRod0fEhcZXNPP15Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740606575; c=relaxed/simple;
	bh=SIVxiIwvfp9ZJ8G8IKu5oxR2qJtID9NQ4GULZO/ubn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AqAKOHjNdL0lhOrviGf8ofQNGrjsI053vvis4HXX3bHTQvCJEsTR3rwq1PBvvy8CnSymDFPYAEzMkJ6ZwoG2RWMJsVz/GR139/nR2khMaD5kb6F3ciOumHMa9zAXnoqBXKdhXR+Bkfl/YOxo9y2PyOhEM4ReVpNcrfC0aV6gBYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GJmd7OKm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GJmd7OKm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E93A4C4CED6;
	Wed, 26 Feb 2025 21:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740606574;
	bh=SIVxiIwvfp9ZJ8G8IKu5oxR2qJtID9NQ4GULZO/ubn0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GJmd7OKmr1w1aFhul5MRyFDAU/TjkMP1nrAQv2mp6Xk6hFxS1SbDx1xlDYEbWBUUh
	 tJ3hEWF2HuiUF4etAMB7RVWb/2a+0xrBYv+pTz0Un1Qh5DUWc7f5Y+r1eL84bgLXxH
	 uCee/6HzUrGGUyjTrHGBtDOFYslYp1zAOJ3rrb6+SBV2KMKowZ3URwAQwTM7UE/QRu
	 OtyNnHqFVle6d+2thx94fdkjYkjpDYcThiHlQM64ZWxoxVghB1wdSpJyhul+DWCE5n
	 3uF3h4tn0/9TH/Xpk/JsA+BMqVl0HJoTg+ukYnDrRtp9o5/nTcOATdNeSlBf2KRfvw
	 w1NNWyIu1d5aA==
Date: Wed, 26 Feb 2025 18:49:31 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH] perf report: Add 'tgid' sort key
Message-ID: <Z7-May5w9VQd5QD0@x1>
References: <CAP-5=fUosOVUKi5tQ3gVtHhfApk0oH3r2zHDW7-i+_qASKm+Cg@mail.gmail.com>
 <Z712hzvv22Ni63f1@google.com>
 <Z74U5s7Yf0f6I7Mo@x1>
 <Z74V0hZXrTLM6VIJ@x1>
 <Z74ZL6SUwWL_a5EK@x1>
 <Z74eqEiyrzuoL6uz@x1>
 <Z79std66tPq-nqsD@google.com>
 <Z7-Jte2ImGa93VUD@x1>
 <Z7-J5vHqHF4kc1HB@x1>
 <Z7-KSRttQLImuWtJ@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z7-KSRttQLImuWtJ@x1>

On Wed, Feb 26, 2025 at 06:40:29PM -0300, Arnaldo Carvalho de Melo wrote:
> On Wed, Feb 26, 2025 at 06:38:50PM -0300, Arnaldo Carvalho de Melo wrote:
> > On Wed, Feb 26, 2025 at 06:38:00PM -0300, Arnaldo Carvalho de Melo wrote:
> > > On Wed, Feb 26, 2025 at 11:34:13AM -0800, Namhyung Kim wrote:
> > > > On Tue, Feb 25, 2025 at 08:48:56PM +0100, Arnaldo Carvalho de Melo wrote:
> > > > > On Tue, Feb 25, 2025 at 08:25:35PM +0100, Arnaldo Carvalho de Melo wrote:
> > > > > > On Tue, Feb 25, 2025 at 08:11:17PM +0100, Arnaldo Carvalho de Melo wrote:
> > > > > > > On Tue, Feb 25, 2025 at 08:07:18PM +0100, Arnaldo Carvalho de Melo wrote:
> > > > > > > > On Mon, Feb 24, 2025 at 11:51:35PM -0800, Namhyung Kim wrote:
> > > > > > > > > On Mon, Feb 24, 2025 at 08:40:37PM -0800, Ian Rogers wrote:
> > > > > > > > > > On Mon, Feb 24, 2025 at 6:51 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > > > > > > > > > > On Mon, Feb 24, 2025 at 10:18:37AM -0800, Ian Rogers wrote:
> > > > > > > > > [SNIP]
> > > > > > > > > > > > I thought the real-time processing had to use
> > > > > > > > > > > > maps__fixup_overlap_and_insert (rather than maps__insert) as mmap
> > > > > > > > > > > > events only give us VMA data and two mmaps may have been merged.
> > > > > > > > > > > > Shouldn't doing this change be the simplest fix?
> > > > > > > 
> > > > > > > > > > > Make sense.  How about this?
> > > > > > > 
> > > > > > > > > > Lgtm, I have no way to test the issue. Why does maps__fixup_end need
> > > > > > > > > > to get pushed later?
> > > > > > > 
> > > > > > > > > I just noticed it would add extra kernel maps after modules.  I think it
> > > > > > > > > should fixup end address of the kernel maps after adding all maps first.
> > > > > > > 
> > > > > > > > > Arnaldo, can you please test this?
> > > > > > >  
> > > > > > > > Trying it now.
> > > > > > > 
> > > > > > > Now we have something different:
> > > > > > > 
> > > > > > > root@number:~# perf record sleep
> > > > > > > sleep: missing operand
> > > > > > > Try 'sleep --help' for more information.
> > > > > > > [ perf record: Woken up 1 times to write data ]
> > > > > > > perf: util/maps.c:80: check_invariants: Assertion `RC_CHK_EQUAL(map__kmap(map)->kmaps, maps)' failed.
> > > > > > > Aborted (core dumped)
> > > > > > > root@number:~#
> > > > > > 
> > > > > > __maps__insert() does:
> > > > > > 
> > > > > >         if (dso && dso__kernel(dso)) {
> > > > > >                 struct kmap *kmap = map__kmap(new);
> > > > > > 
> > > > > >                 if (kmap)
> > > > > >                         kmap->kmaps = maps;
> > > > > >                 else
> > > > > >                         pr_err("Internal error: kernel dso with non kernel map\n");
> > > > > >         }
> > > > > > 
> > > > > > while maps__fixup_overlap_and_insert() doesn't.
> > > > > > 
> > > > > > It calls __maps__insert_sorted() that probably should do what
> > > > > > __maps__insert() does?
> > > > > 
> > > > > Ok, so I did the following patch but this case fails:
> > > > > 
> > > > > @@ -910,6 +928,7 @@ static int __maps__fixup_overlap_and_insert(struct maps *maps, struct map *new)
> > > > >                                  */
> > > > >                                 map__put(maps_by_address[i]);
> > > > >                                 maps_by_address[i] = map__get(new);
> > > > > +                               map__set_kmap(new, maps);
> > > > >                                 check_invariants(maps);
> > > > >                                 return err;
> > > > >                         }
> > > > > 
> > > > > With:
> > > > > 
> > > > > perf: util/maps.c:110: check_invariants: Assertion `refcount_read(map__refcnt(map)) > 1' failed.
> > > > > 
> > > > > As:
> > > > > 
> > > > > 106				/*
> > > > > 107				 * Maps by name maps should be in maps_by_address, so
> > > > > 108				 * the reference count should be higher.
> > > > > 109				 */
> > > > > 110				assert(refcount_read(map__refcnt(map)) > 1);
> > > > > 
> > > > > Since it is just replacing the map in the maps_by_address and not
> > > > > touching on the maps_by_name? Thus the refcount is just 1:

> > > > Sounds like it.  Can you add this on top?

> > > Trying, but somehow its not applying cleanly, checking:

> > > ⬢ [acme@toolbox perf-tools]$ patch -p1 < ~/wb/1.patch 
> > > patching file tools/perf/util/maps.c
> > > Hunk #1 succeeded at 815 (offset 18 lines).
> > > Hunk #2 succeeded at 826 (offset 18 lines).
> > > Hunk #3 succeeded at 846 (offset 18 lines).
> > > Hunk #4 succeeded at 893 (offset 18 lines).
> > > Hunk #5 succeeded at 919 (offset 18 lines).
> > > Hunk #6 FAILED at 923.
> > > 1 out of 6 hunks FAILED -- saving rejects to file tools/perf/util/maps.c.rej
> > > ⬢ [acme@toolbox perf-tools]$

> > > ⬢ [acme@toolbox perf-tools]$ git log --oneline -5
> > > 4a9f5d76130b707f (HEAD -> perf-tools) wip: acme
> > > d5ba0f5af35937c7 wip: namhyung
> > > 42367eca7604e16e (perf-tools/tmp.perf-tools, perf-tools/perf-tools) tools: Remove redundant quiet setup
> > > 293f324ce96d7001 tools: Unify top-level quiet infrastructure
> > > 9fae5884bb0e3480 (tag: perf-tools-fixes-for-v6.14-2025-01-30) perf cpumap: Fix die and cluster IDs
> > > ⬢ [acme@toolbox perf-tools]$

> > ⬢ [acme@toolbox perf-tools]$ cat tools/perf/util/maps.c.rej
> > --- tools/perf/util/maps.c
> > +++ tools/perf/util/maps.c
> > @@ -923,6 +936,10 @@ static int __maps__fixup_overlap_and_insert(struct maps *maps, struct map *new)
> >  				 */
> >  				map__put(maps_by_address[i]);
> >  				maps_by_address[i] = map__get(new);
> > +				if (maps_by_name) {
> > +					map__put(maps_by_name[ni]);
> > +					maps_by_name[ni] = map__get(new);
> > +				}
> >  				check_invariants(maps);
> >  				return err;
> >  			}
> > ⬢ [acme@toolbox perf-tools]$

> > Fixing this up by hand
 
> I see, I had tried this after sending that patch:
 
>      map__set_kmap(new, maps);
 
> Before check_invariants(), but that doesn't make sense, I should've
> dropped that, doing it now.

Nope, it still triggers:

 930                 } else {
 931                         struct map *next = NULL;
 932 
 933                         if (i + 1 < maps__nr_maps(maps))
 934                                 next = maps_by_address[i + 1];
 935 
 936                         if (!next  || map__start(next) >= map__end(new)) {
 937                                 /*
 938                                  * Replace existing mapping and end knowing
 939                                  * there aren't later overlapping or any
 940                                  * mappings.
 941                                  */
 942                                 map__put(maps_by_address[i]);
 943                                 maps_by_address[i] = map__get(new);
 944                                 if (maps_by_name) {
 945                                         map__put(maps_by_name[ni]);
 946                                         maps_by_name[ni] = map__get(new);
 947                                 }
 948                                 check_invariants(maps);
 949                                 return err;
 950                         }
 951                         __maps__remove(maps, pos);
 952                         check_invariants(maps);
 953                         /*
 954                          * Maps are ordered but no need to increase `i` as the
 955                          * later maps were moved down.
 956                          */
 957                 }


perf: util/maps.c:80: check_invariants: Assertion `RC_CHK_EQUAL(map__kmap(map)->kmaps, maps)' failed.

Thread 1 "perf" received signal SIGABRT, Aborted.
__pthread_kill_implementation (threadid=<optimized out>, signo=signo@entry=6, no_tid=no_tid@entry=0) at pthread_kill.c:44
44	      return INTERNAL_SYSCALL_ERROR_P (ret) ? INTERNAL_SYSCALL_ERRNO (ret) : 0;
(gdb) bt
#0  __pthread_kill_implementation (threadid=<optimized out>, signo=signo@entry=6, no_tid=no_tid@entry=0) at pthread_kill.c:44
#1  0x00007ffff6ea80a3 in __pthread_kill_internal (threadid=<optimized out>, signo=6) at pthread_kill.c:78
#2  0x00007ffff6e4ef1e in __GI_raise (sig=sig@entry=6) at ../sysdeps/posix/raise.c:26
#3  0x00007ffff6e36902 in __GI_abort () at abort.c:79
#4  0x00007ffff6e3681e in __assert_fail_base (fmt=0x7ffff6fc3bb8 "%s%s%s:%u: %s%sAssertion `%s' failed.\n%n", assertion=assertion@entry=0x7bfd08 "RC_CHK_EQUAL(map__kmap(map)->kmaps, maps)", 
    file=file@entry=0x7bfc53 "util/maps.c", line=line@entry=80, function=function@entry=0x7c0010 <__PRETTY_FUNCTION__.6> "check_invariants") at assert.c:96
#5  0x00007ffff6e47047 in __assert_fail (assertion=0x7bfd08 "RC_CHK_EQUAL(map__kmap(map)->kmaps, maps)", file=0x7bfc53 "util/maps.c", line=80, 
    function=0x7c0010 <__PRETTY_FUNCTION__.6> "check_invariants") at assert.c:105
#6  0x0000000000633c74 in check_invariants (maps=0xf977c0) at util/maps.c:80
#7  0x00000000006363a6 in __maps__fixup_overlap_and_insert (maps=0xf977c0, new=0xfc57e0) at util/maps.c:948
#8  0x0000000000636460 in maps__fixup_overlap_and_insert (maps=0xf977c0, new=0xfc57e0) at util/maps.c:970
#9  0x000000000062920a in machine__process_ksymbol_register (machine=0xf97158, event=0x7ffff7fbaba8, sample=0x7fffffffa860) at util/machine.c:715
#10 0x00000000006294ca in machine__process_ksymbol (machine=0xf97158, event=0x7ffff7fbaba8, sample=0x7fffffffa860) at util/machine.c:779
#11 0x00000000005ce2fd in perf_event__process_ksymbol (tool=0xec9ce0 <record>, event=0x7ffff7fbaba8, sample=0x7fffffffa860, machine=0xf97158) at util/event.c:296
#12 0x000000000063b860 in machines__deliver_event (machines=0xf97158, evlist=0xf531f0, event=0x7ffff7fbaba8, sample=0x7fffffffa860, tool=0xec9ce0 <record>, file_offset=35752, 
    file_path=0xf97850 "perf.data") at util/session.c:1334
#13 0x000000000063ba45 in perf_session__deliver_event (session=0xf96f40, event=0x7ffff7fbaba8, tool=0xec9ce0 <record>, file_offset=35752, file_path=0xf97850 "perf.data")
    at util/session.c:1367
#14 0x000000000063c839 in perf_session__process_event (session=0xf96f40, event=0x7ffff7fbaba8, file_offset=35752, file_path=0xf97850 "perf.data") at util/session.c:1626
#15 0x000000000063dfb9 in process_simple (session=0xf96f40, event=0x7ffff7fbaba8, file_offset=35752, file_path=0xf97850 "perf.data") at util/session.c:2203
#16 0x000000000063dc70 in reader__read_event (rd=0x7fffffffafa0, session=0xf96f40, prog=0x7fffffffaf70) at util/session.c:2132
#17 0x000000000063de6a in reader__process_events (rd=0x7fffffffafa0, session=0xf96f40, prog=0x7fffffffaf70) at util/session.c:2181
#18 0x000000000063e107 in __perf_session__process_events (session=0xf96f40) at util/session.c:2226
#19 0x000000000063eb04 in perf_session__process_events (session=0xf96f40) at util/session.c:2390
#20 0x000000000042d98b in process_buildids (rec=0xec9ce0 <record>) at builtin-record.c:1475
#21 0x000000000042e963 in record__finish_output (rec=0xec9ce0 <record>) at builtin-record.c:1798
#22 0x0000000000431c46 in __cmd_record (rec=0xec9ce0 <record>, argc=2, argv=0x7fffffffde80) at builtin-record.c:2841
#23 0x000000000043513f in cmd_record (argc=2, argv=0x7fffffffde80) at builtin-record.c:4260
#24 0x00000000004bcf65 in run_builtin (p=0xeccd60 <commands+288>, argc=3, argv=0x7fffffffde80) at perf.c:351
#25 0x00000000004bd20c in handle_internal_command (argc=3, argv=0x7fffffffde80) at perf.c:404
#26 0x00000000004bd365 in run_argv (argcp=0x7fffffffdc6c, argv=0x7fffffffdc60) at perf.c:448
#27 0x00000000004bd6ae in main (argc=3, argv=0x7fffffffde80) at perf.c:556
(gdb)

humm, it seems that thing I removed may be needed after all...

Yeah, please check if adding this, on top of your latest (second) patch,
makese sense:

diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
index a710720e8bcfd305..776bbdaafdb32269 100644
--- a/tools/perf/util/maps.c
+++ b/tools/perf/util/maps.c
@@ -945,6 +945,7 @@ static int __maps__fixup_overlap_and_insert(struct maps *maps, struct map *new)
                                        map__put(maps_by_name[ni]);
                                        maps_by_name[ni] = map__get(new);
                                }
+                               map__set_kmap(new, maps);
                                check_invariants(maps);
                                return err;
                        }
⬢ [acme@toolbox perf-tools]$


With your two patches and my two patches finally I get:

root@number:~# perf record sleep 1
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.035 MB perf.data (14 samples) ]
root@number:~#

on a perf-tools/perf-tools build with DEBUG=1

- Arnaldo
