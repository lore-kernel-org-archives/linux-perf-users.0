Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F47028628A;
	Tue, 18 Feb 2025 21:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739912497; cv=none; b=nPG/Rqb/7supnUXZ50T90CPWF+yDswBYH32AP6nwR7XkBQ3Iadb4vZmKZoRpxChOopGKAVN7FpHwgYVKEJa2f+wBxkJjUPd6Mb7DXv704+a1RX/EDSu+ZiMkI6fJ+m4X8P9rG46OXCnpA5pc+tLVKm/WLURkh7VDuSQ9nm+ANgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739912497; c=relaxed/simple;
	bh=a/d+Mpc31bvkwLBo74v/bc0NoHtCLlU347PCo0CoFyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aJmgOTXk27x1/EJj9kyJdE+nC5bWrjfS8oCylBYFLJ/QpOZ24kNYmuaUso6MdHKjnealsmRU4OKCuieCmWAVYs285TyN4jhTz1GX6CVfxczysAffb3vSQVOYxo8DwXfaKNzX9c0IH9UR5eTEH3a7uLfgHwVem2iyl3dYhgVgCwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eqTe2+Zs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eqTe2+Zs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DC57C4CEE2;
	Tue, 18 Feb 2025 21:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739912496;
	bh=a/d+Mpc31bvkwLBo74v/bc0NoHtCLlU347PCo0CoFyY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eqTe2+ZsdO5Q1rm9rypco5i4wkX6oh1q2zrPl3TP/AR7EkjlX6tjvaWrPZVwbkfRJ
	 Q1B1tf/PG9U+A5WKbYoyufo+Iwcl5a10TeouZUvLeHeJ+a7e1ipUt/yKmT0eG6CtQ+
	 1g4CMBhpASjAYhX/rX4M73KyibMltRNsruUr7uqu8HVBH26F7p3KlIz2mdXUTQPMl0
	 bV1IqQ+poPDq+wrfir8lcHmjCx7OlI9EtX+YH5lD4NrysZL7qUKd5VSNYxND7NTN8K
	 53jB7ipuDHxemHYpjk/SV9G6jlf+gZB4qJrzkDP8nM6Z1S/uuPjx2C0EUJGOpAU8FU
	 aKXEVwulgjrwQ==
Date: Tue, 18 Feb 2025 22:01:33 +0100
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
Message-ID: <Z7T1LVSLo8EEMmkM@x1>
References: <20250206000137.2026034-1-namhyung@kernel.org>
 <Z60NFEAf2C8cL8Xh@x1>
 <Z60Ndm8VVI4Ao31U@x1>
 <CAP-5=fXw09MM5XyozJMM3FjMANJei1aNVmBghSEQFiCKAtJmXw@mail.gmail.com>
 <CAP-5=fUqcykMdApHVweETg9bp2EVPJhJOj_PR8cByOOA6OyQGw@mail.gmail.com>
 <Z6_CL0RpUUvw0lR7@x1>
 <Z7TvZGjVix2asYWI@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7TvZGjVix2asYWI@x1>

On Tue, Feb 18, 2025 at 09:36:52PM +0100, Arnaldo Carvalho de Melo wrote:
> So the call to maps_fixup_end() will set maps->end_broken to false,
> since it fixed up the map ends, etc, but then we insert more maps with
> broken ends:
 
> #6  0x0000000000633d52 in check_invariants (maps=0xf967c0) at util/maps.c:95
> 95						assert(map__end(prev) <= map__end(map));
> (gdb) p prev->dso->name
> $1 = 0xfc47ab "bpf_trampoline_6442522522"

So the above map is created overlapping a previously existing map:

root@number:~# perf probe -l
  probe_perf:maps_fixup_end (on maps__fixup_end:1@util/maps.c in /home/acme/bin/perf with maps)
  probe_perf:maps_insert (on maps__insert:1@util/maps.c in /home/acme/bin/perf with maps name start end)
root@number:~# 

root@number:~# perf trace --lib -e probe_perf:maps* perf record sleep
<SNIP>
   319.791 perf/1732173 probe_perf:maps_insert((634e5e) maps=0x2d9715d0 name="bpf_prog_6deef7357e7b4530_sd_fw_egress" start=0xffffffffc0160788 end=0xffffffffc01607c8)
   319.810 perf/1732173 probe_perf:maps_insert((634e5e) maps=0x2d9715d0 name="bpf_prog_6deef7357e7b4530_sd_fw_ingress" start=0xffffffffc01647b8 end=0xffffffffc01647f8)
   319.822 perf/1732173 probe_perf:maps_insert((634e5e) maps=0x2d9715d0 name="bpf_prog_6deef7357e7b4530_sd_fw_egress" start=0xffffffffc016482c end=0xffffffffc016486c)
   319.834 perf/1732173 probe_perf:maps_insert((634e5e) maps=0x2d9715d0 name="bpf_prog_6deef7357e7b4530_sd_fw_ingress" start=0xffffffffc01648ac end=0xffffffffc01648ec)
   319.845 perf/1732173 probe_perf:maps_insert((634e5e) maps=0x2d9715d0 name="bpf_prog_be31ae23198a0378_sd_devices" start=0xffffffffc0186388 end=0xffffffffc01864b2)
   319.857 perf/1732173 probe_perf:maps_insert((634e5e) maps=0x2d9715d0 name="bpf_trampoline_6442522522" start=0xffffffffc0147640 end=0xffffffffc0148640)
[ perf record: Captured and wrote 0.035 MB perf.data (7 samples) ]
perf: util/maps.c:95: check_invariants: Assertion `map__end(prev) <= map__end(map)' failed.
root@number:~# 

So a PERF_RECORD_KSYMBOL processing will add a map for
"bpf_trampoline_6442522522" that has its start after before the
"bpf_prog_40ddf486530245f5_sd_devices" start, ok, but ends after
"bpf_prog_40ddf486530245f5_sd_devices", overlapping it.

machine__process_ksymbol_register() does:

713			map__set_start(map, event->ksymbol.addr);
714			map__set_end(map, map__start(map) + event->ksymbol.len);
715			err = maps__insert(machine__kernel_maps(machine), map);

And:

(gdb) p /x event->ksymbol.addr
$2 = 0xffffffffc0147a2c
(gdb) p event->ksymbol.len
$3 = 306

Thread 1 "perf" hit Breakpoint 1, machine__process_ksymbol_register (machine=0xf96158, event=0x7ffff7fb9aa0, sample=0x7fffffffa860) at util/machine.c:688
688	{
(gdb) bt
#0  machine__process_ksymbol_register (machine=0xf96158, event=0x7ffff7fb9aa0, sample=0x7fffffffa860) at util/machine.c:688
#1  0x00000000006294ca in machine__process_ksymbol (machine=0xf96158, event=0x7ffff7fb9aa0, sample=0x7fffffffa860) at util/machine.c:779
#2  0x00000000005ce2fd in perf_event__process_ksymbol (tool=0xec8ce0 <record>, event=0x7ffff7fb9aa0, sample=0x7fffffffa860, machine=0xf96158) at util/event.c:296
#3  0x000000000063b6e4 in machines__deliver_event (machines=0xf96158, evlist=0xf521f0, event=0x7ffff7fb9aa0, sample=0x7fffffffa860, tool=0xec8ce0 <record>, file_offset=31392, 
    file_path=0xf96850 "perf.data") at util/session.c:1334
#4  0x000000000063b8c9 in perf_session__deliver_event (session=0xf95f40, event=0x7ffff7fb9aa0, tool=0xec8ce0 <record>, file_offset=31392, file_path=0xf96850 "perf.data")
    at util/session.c:1367
#5  0x000000000063c6bd in perf_session__process_event (session=0xf95f40, event=0x7ffff7fb9aa0, file_offset=31392, file_path=0xf96850 "perf.data") at util/session.c:1626
#6  0x000000000063de3d in process_simple (session=0xf95f40, event=0x7ffff7fb9aa0, file_offset=31392, file_path=0xf96850 "perf.data") at util/session.c:2203
#7  0x000000000063daf4 in reader__read_event (rd=0x7fffffffafa0, session=0xf95f40, prog=0x7fffffffaf70) at util/session.c:2132
#8  0x000000000063dcee in reader__process_events (rd=0x7fffffffafa0, session=0xf95f40, prog=0x7fffffffaf70) at util/session.c:2181
#9  0x000000000063df8b in __perf_session__process_events (session=0xf95f40) at util/session.c:2226
#10 0x000000000063e988 in perf_session__process_events (session=0xf95f40) at util/session.c:2390
#11 0x000000000042d98b in process_buildids (rec=0xec8ce0 <record>) at builtin-record.c:1475
#12 0x000000000042e963 in record__finish_output (rec=0xec8ce0 <record>) at builtin-record.c:1798
#13 0x0000000000431c46 in __cmd_record (rec=0xec8ce0 <record>, argc=2, argv=0x7fffffffde80) at builtin-record.c:2841
#14 0x000000000043513f in cmd_record (argc=2, argv=0x7fffffffde80) at builtin-record.c:4260
#15 0x00000000004bcf65 in run_builtin (p=0xecbd60 <commands+288>, argc=3, argv=0x7fffffffde80) at perf.c:351
#16 0x00000000004bd20c in handle_internal_command (argc=3, argv=0x7fffffffde80) at perf.c:404
#17 0x00000000004bd365 in run_argv (argcp=0x7fffffffdc6c, argv=0x7fffffffdc60) at perf.c:448
#18 0x00000000004bd6ae in main (argc=3, argv=0x7fffffffde80) at perf.c:556
(gdb)


So, this one liner "refixes" the "modules" ends when processing the
records to find the build ids, unsure if it is the best solution tho:

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 5db1aedf48df92d2..5c4603d08ab5f2cb 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1797,6 +1797,8 @@ record__finish_output(struct record *rec)
 	if (!rec->no_buildid) {
 		process_buildids(rec);
 
+		maps__fixup_end(machine__kernel_maps(&rec->session->machines.host));
+
 		if (rec->buildid_all)
 			perf_session__dsos_hit_all(rec->session);
 	}


