Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572E52054F4;
	Tue, 25 Feb 2025 19:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740512940; cv=none; b=gHnY87A2wu7drktAvwpdwWVG8W/5QnBUlANQU5BS1vUPFCNDCEil3uu2bpjw1rkdWX2UBXLJBNmFXE9Xxj4OllIfuYREiOGsALCttafOpeEbVtr7rOu7IdUK7M2TMQvuAvXRZ3Bu3h5oxVVS/tc92POgYK77XzIcIZFjtLuJSZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740512940; c=relaxed/simple;
	bh=Ltv58kxzfsYfdSmJzVewji73ROqlz2/+qZiGcPEyrFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HvWN+4g5k3vg4+d9RcdoXC+k8NCV7ipgWXJ0S7vlxQogqWC/imXDyqcRkVandDtZZqHc7dRMB+p5O/rH9iKCfCdhpm7aQA1qkbIxVNc4SsaLW/+hS0qhiR06zMs2vXQEzbd8QbrQ+mUxIZeSFh1tWRl/o1FDOsjmPFvTTl4gGV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=okDOmcI5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="okDOmcI5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 823F3C4CEDD;
	Tue, 25 Feb 2025 19:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740512939;
	bh=Ltv58kxzfsYfdSmJzVewji73ROqlz2/+qZiGcPEyrFY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=okDOmcI58syu/ratG7CF2XVJqdTfqzCxI8D119C5coBGV0YRtaGyuhW+fLbBITLv4
	 rNMETrMLgL61v5T5apWHWe8i1gaVzszUDs/MdjmMMhGqMiGDU7fESUxfrtUa5BGhrB
	 Rg5hdxze3OazbzKpbYjpdMYTDbbPRClLUarNPr875YIu6AreNlKlHGy3sfatP2O5sV
	 M4i884eERaPGnuNoE0oYErYpOdo+G/fQGUmvWNuxQXQHyMTTjwNusgGUeFhRJRJdOO
	 TZ9Gzcgz7jwgPdrU5QJKnE8CUzMcDkpcwbWYObzl7Qm8EB8U8H4qT2WFYDGTNXRD3p
	 2JzuzIHibS03A==
Date: Tue, 25 Feb 2025 20:48:56 +0100
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
Message-ID: <Z74eqEiyrzuoL6uz@x1>
References: <Z7ZIqpwffQbibwL2@google.com>
 <CAP-5=fWZXPjD3Ok5XmMwwaYt+9mL+V8t8fNSUdf-F5PPiEAvrg@mail.gmail.com>
 <Z7gllQZeg6U2OvZE@google.com>
 <CAP-5=fXEEMFgPF2aZhKsfrY_En+qoqX20dWfuE_ad73Uxf0ZHQ@mail.gmail.com>
 <Z70wHEl6Sp0H0c-3@google.com>
 <CAP-5=fUosOVUKi5tQ3gVtHhfApk0oH3r2zHDW7-i+_qASKm+Cg@mail.gmail.com>
 <Z712hzvv22Ni63f1@google.com>
 <Z74U5s7Yf0f6I7Mo@x1>
 <Z74V0hZXrTLM6VIJ@x1>
 <Z74ZL6SUwWL_a5EK@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z74ZL6SUwWL_a5EK@x1>

On Tue, Feb 25, 2025 at 08:25:35PM +0100, Arnaldo Carvalho de Melo wrote:
> On Tue, Feb 25, 2025 at 08:11:17PM +0100, Arnaldo Carvalho de Melo wrote:
> > On Tue, Feb 25, 2025 at 08:07:18PM +0100, Arnaldo Carvalho de Melo wrote:
> > > On Mon, Feb 24, 2025 at 11:51:35PM -0800, Namhyung Kim wrote:
> > > > On Mon, Feb 24, 2025 at 08:40:37PM -0800, Ian Rogers wrote:
> > > > > On Mon, Feb 24, 2025 at 6:51 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > > > > > On Mon, Feb 24, 2025 at 10:18:37AM -0800, Ian Rogers wrote:
> > > > [SNIP]
> > > > > > > I thought the real-time processing had to use
> > > > > > > maps__fixup_overlap_and_insert (rather than maps__insert) as mmap
> > > > > > > events only give us VMA data and two mmaps may have been merged.
> > > > > > > Shouldn't doing this change be the simplest fix?
> > 
> > > > > > Make sense.  How about this?
> > 
> > > > > Lgtm, I have no way to test the issue. Why does maps__fixup_end need
> > > > > to get pushed later?
> > 
> > > > I just noticed it would add extra kernel maps after modules.  I think it
> > > > should fixup end address of the kernel maps after adding all maps first.
> > 
> > > > Arnaldo, can you please test this?
> >  
> > > Trying it now.
> > 
> > Now we have something different:
> > 
> > root@number:~# perf record sleep
> > sleep: missing operand
> > Try 'sleep --help' for more information.
> > [ perf record: Woken up 1 times to write data ]
> > perf: util/maps.c:80: check_invariants: Assertion `RC_CHK_EQUAL(map__kmap(map)->kmaps, maps)' failed.
> > Aborted (core dumped)
> > root@number:~#
> 
> __maps__insert() does:
> 
>         if (dso && dso__kernel(dso)) {
>                 struct kmap *kmap = map__kmap(new);
> 
>                 if (kmap)
>                         kmap->kmaps = maps;
>                 else
>                         pr_err("Internal error: kernel dso with non kernel map\n");
>         }
> 
> while maps__fixup_overlap_and_insert() doesn't.
> 
> It calls __maps__insert_sorted() that probably should do what
> __maps__insert() does?

Ok, so I did the following patch but this case fails:

@@ -910,6 +928,7 @@ static int __maps__fixup_overlap_and_insert(struct maps *maps, struct map *new)
                                 */
                                map__put(maps_by_address[i]);
                                maps_by_address[i] = map__get(new);
+                               map__set_kmap(new, maps);
                                check_invariants(maps);
                                return err;
                        }

With:

perf: util/maps.c:110: check_invariants: Assertion `refcount_read(map__refcnt(map)) > 1' failed.

As:

106				/*
107				 * Maps by name maps should be in maps_by_address, so
108				 * the reference count should be higher.
109				 */
110				assert(refcount_read(map__refcnt(map)) > 1);

Since it is just replacing the map in the maps_by_address and not
touching on the maps_by_name? Thus the refcount is just 1:

[ perf record: Woken up 1 times to write data ]
perf: util/maps.c:110: check_invariants: Assertion `refcount_read(map__refcnt(map)) > 1' failed.

Thread 1 "perf" received signal SIGABRT, Aborted.
__pthread_kill_implementation (threadid=<optimized out>, signo=signo@entry=6, no_tid=no_tid@entry=0) at pthread_kill.c:44
44	      return INTERNAL_SYSCALL_ERROR_P (ret) ? INTERNAL_SYSCALL_ERRNO (ret) : 0;
(gdb) bt
#0  __pthread_kill_implementation (threadid=<optimized out>, signo=signo@entry=6, no_tid=no_tid@entry=0) at pthread_kill.c:44
#1  0x00007ffff6ea80a3 in __pthread_kill_internal (threadid=<optimized out>, signo=6) at pthread_kill.c:78
#2  0x00007ffff6e4ef1e in __GI_raise (sig=sig@entry=6) at ../sysdeps/posix/raise.c:26
#3  0x00007ffff6e36902 in __GI_abort () at abort.c:79
#4  0x00007ffff6e3681e in __assert_fail_base (fmt=0x7ffff6fc3bb8 "%s%s%s:%u: %s%sAssertion `%s' failed.\n%n", assertion=assertion@entry=0x7bcdd0 "refcount_read(map__refcnt(map)) > 1", 
    file=file@entry=0x7bcc53 "util/maps.c", line=line@entry=110, function=function@entry=0x7bd010 <__PRETTY_FUNCTION__.6> "check_invariants") at assert.c:96
#5  0x00007ffff6e47047 in __assert_fail (assertion=0x7bcdd0 "refcount_read(map__refcnt(map)) > 1", file=0x7bcc53 "util/maps.c", line=110, 
    function=0x7bd010 <__PRETTY_FUNCTION__.6> "check_invariants") at assert.c:105
#6  0x0000000000633e3b in check_invariants (maps=0xf947c0) at util/maps.c:110
#7  0x00000000006362b2 in __maps__fixup_overlap_and_insert (maps=0xf947c0, new=0xfc27e0) at util/maps.c:932
#8  0x000000000063636c in maps__fixup_overlap_and_insert (maps=0xf947c0, new=0xfc27e0) at util/maps.c:954
#9  0x000000000062920a in machine__process_ksymbol_register (machine=0xf94158, event=0x7ffff7fbaba8, sample=0x7fffffffa860) at util/machine.c:715
#10 0x00000000006294ca in machine__process_ksymbol (machine=0xf94158, event=0x7ffff7fbaba8, sample=0x7fffffffa860) at util/machine.c:779
#11 0x00000000005ce2fd in perf_event__process_ksymbol (tool=0xec6ce0 <record>, event=0x7ffff7fbaba8, sample=0x7fffffffa860, machine=0xf94158) at util/event.c:296
#12 0x000000000063b76c in machines__deliver_event (machines=0xf94158, evlist=0xf501f0, event=0x7ffff7fbaba8, sample=0x7fffffffa860, tool=0xec6ce0 <record>, file_offset=35752, 
    file_path=0xf94850 "perf.data") at util/session.c:1334
#13 0x000000000063b951 in perf_session__deliver_event (session=0xf93f40, event=0x7ffff7fbaba8, tool=0xec6ce0 <record>, file_offset=35752, file_path=0xf94850 "perf.data")
    at util/session.c:1367
#14 0x000000000063c745 in perf_session__process_event (session=0xf93f40, event=0x7ffff7fbaba8, file_offset=35752, file_path=0xf94850 "perf.data") at util/session.c:1626
#15 0x000000000063dec5 in process_simple (session=0xf93f40, event=0x7ffff7fbaba8, file_offset=35752, file_path=0xf94850 "perf.data") at util/session.c:2203
#16 0x000000000063db7c in reader__read_event (rd=0x7fffffffafa0, session=0xf93f40, prog=0x7fffffffaf70) at util/session.c:2132
#17 0x000000000063dd76 in reader__process_events (rd=0x7fffffffafa0, session=0xf93f40, prog=0x7fffffffaf70) at util/session.c:2181
#18 0x000000000063e013 in __perf_session__process_events (session=0xf93f40) at util/session.c:2226
#19 0x000000000063ea10 in perf_session__process_events (session=0xf93f40) at util/session.c:2390
#20 0x000000000042d98b in process_buildids (rec=0xec6ce0 <record>) at builtin-record.c:1475
#21 0x000000000042e963 in record__finish_output (rec=0xec6ce0 <record>) at builtin-record.c:1798
#22 0x0000000000431c46 in __cmd_record (rec=0xec6ce0 <record>, argc=2, argv=0x7fffffffde80) at builtin-record.c:2841
#23 0x000000000043513f in cmd_record (argc=2, argv=0x7fffffffde80) at builtin-record.c:4260
#24 0x00000000004bcf65 in run_builtin (p=0xec9d60 <commands+288>, argc=3, argv=0x7fffffffde80) at perf.c:351
#25 0x00000000004bd20c in handle_internal_command (argc=3, argv=0x7fffffffde80) at perf.c:404
#26 0x00000000004bd365 in run_argv (argcp=0x7fffffffdc6c, argv=0x7fffffffdc60) at perf.c:448
#27 0x00000000004bd6ae in main (argc=3, argv=0x7fffffffde80) at perf.c:556
(gdb)
#6  0x0000000000633e3b in check_invariants (maps=0xf947c0) at util/maps.c:110
110				assert(refcount_read(map__refcnt(map)) > 1);
(gdb) p map
$2 = (struct map *) 0xfe6060
(gdb) p map->dso
$3 = (struct dso *) 0xfe5ea0
(gdb) p map->dso->name
$4 = 0xfe602b "bpf_prog_6deef7357e7b4530_sd_fw_ingress"
(gdb) p refcount_read(map__refcnt(map))
$5 = 1
(gdb) fr 7
#7  0x00000000006362b2 in __maps__fixup_overlap_and_insert (maps=0xf947c0, new=0xfc27e0) at util/maps.c:932
932					check_invariants(maps);
(gdb) p next
$6 = (struct map *) 0xfe4bc0
(gdb) p next->dso
$7 = (struct dso *) 0xfe4a00
(gdb) p next->dso->name
$8 = 0xfe4b8b "bpf_prog_6deef7357e7b4530_sd_fw_egress"
(gdb) 
(gdb) p new->dso->name
$9 = 0xfc27ab "bpf_trampoline_6442522521"
(gdb) p /x map__start(next)
$12 = 0xffffffffc012b158
(gdb) p /x map__start(new)
$13 = 0xffffffffc0129640
(gdb) p /x map__end(next)
$14 = 0xffffffffc012b198
(gdb) p /x map__end(new)
$15 = 0xffffffffc012a640
(gdb) 

So its again that case of overlapping maps...

Ah, the patch below is on top of Namhyungs.

- Arnaldo

diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
index 09c9cc326c08d435..e413602afaeb2e83 100644
--- a/tools/perf/util/maps.c
+++ b/tools/perf/util/maps.c
@@ -428,11 +428,29 @@ static unsigned int maps__by_name_index(const struct maps *maps, const struct ma
 	return -1;
 }
 
+static void map__set_kmap(struct map *map, struct maps *maps)
+{
+	struct dso *dso;
+
+	if (map == NULL)
+		return;
+
+	dso = map__dso(map);
+
+	if (dso && dso__kernel(dso)) {
+                struct kmap *kmap = map__kmap(map);
+
+                if (kmap)
+                        kmap->kmaps = maps;
+                else
+                        pr_err("Internal error: kernel dso with non kernel map\n");
+        }
+}
+
 static int __maps__insert(struct maps *maps, struct map *new)
 {
 	struct map **maps_by_address = maps__maps_by_address(maps);
 	struct map **maps_by_name = maps__maps_by_name(maps);
-	const struct dso *dso = map__dso(new);
 	unsigned int nr_maps = maps__nr_maps(maps);
 	unsigned int nr_allocate = RC_CHK_ACCESS(maps)->nr_maps_allocated;
 
@@ -483,14 +501,9 @@ static int __maps__insert(struct maps *maps, struct map *new)
 	}
 	if (map__end(new) < map__start(new))
 		RC_CHK_ACCESS(maps)->ends_broken = true;
-	if (dso && dso__kernel(dso)) {
-		struct kmap *kmap = map__kmap(new);
 
-		if (kmap)
-			kmap->kmaps = maps;
-		else
-			pr_err("Internal error: kernel dso with non kernel map\n");
-	}
+	map__set_kmap(new, maps);
+
 	return 0;
 }
 
@@ -784,7 +797,12 @@ static int __maps__insert_sorted(struct maps *maps, unsigned int first_after_ind
 			maps_by_name[nr_maps + 1] = map__get(new2);
 	}
 	RC_CHK_ACCESS(maps)->nr_maps = nr_maps + to_add;
+
 	maps__set_maps_by_name_sorted(maps, false);
+
+	map__set_kmap(new1, maps);
+	map__set_kmap(new2, maps);
+
 	check_invariants(maps);
 	return 0;
 }
@@ -910,6 +928,7 @@ static int __maps__fixup_overlap_and_insert(struct maps *maps, struct map *new)
 				 */
 				map__put(maps_by_address[i]);
 				maps_by_address[i] = map__get(new);
+				map__set_kmap(new, maps);
 				check_invariants(maps);
 				return err;
 			}
