Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CC3254AED;
	Wed, 19 Feb 2025 21:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739999404; cv=none; b=XSOhpjQhclvW2Ydv8FxhvqYoO/45LOSG+Tgm0wzPv68+nUqJWbinEzvNkA+PT9ardn6KCsp6cdJA83Ag4bDmSnOxljJ7fJUdbaRt2EOmQ80KlSAVh87tgSOJV6V9iOlKLfoHR6Bkak0KsRgreiuIi1A7Ph1wrR//Iz7ccTn0QO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739999404; c=relaxed/simple;
	bh=XIfDI3xkyKsEflXvOSBGCgnD2+6YMPf/DLjYjie8Jn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F+eYATBgmDUZZp3ry/xGaUINtCxBAHsAi5yj/zXQ/r49GulgzURaZfASKhUhHf1UcuB1kmOjP3C8MVyfYtJUh6329Nc4ChnTWi6fOq1s6Ivoxu6yoUj8R3iQoZKTSaO9HKvHa8h4wWfeFhL+H/cCVhomEujJZE5F3EVQWgDkQ7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pWoHgoLR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pWoHgoLR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDC3CC4CEE0;
	Wed, 19 Feb 2025 21:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739999404;
	bh=XIfDI3xkyKsEflXvOSBGCgnD2+6YMPf/DLjYjie8Jn0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pWoHgoLRVcsfNIgiKBQV8b0kl5AeF5xj9GO/5ay1o5HSjNG6FGD4cXIm92SLZ6uwc
	 +QmAhK2tuPgKp7yDowm+vYcbXhysD03/C2gSb4JHMkvrpmsQaCudQTMtBAdjyIbXV0
	 Nuc/JF6W6+EsdG2GTHUFW/OWusKvbCyQGYfxGLw6sjNNVewIzoz1Xbdm49JOo+4SaS
	 EhYrEYy8OoAFgPtFRoOb+6mGaA/snGGS5iAoU93/MGh1eVPz8dsdxrSCYSIcq7mY1M
	 6/cEJvGxuRg+Mg5F+czHsr7sLKuUR+s2uJRdtzzoaDRsP5j0Um08Xlt+r8dKay+7om
	 2EL2Tsdw1rjqw==
Date: Wed, 19 Feb 2025 13:10:02 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH] perf report: Add 'tgid' sort key
Message-ID: <Z7ZIqpwffQbibwL2@google.com>
References: <Z60NFEAf2C8cL8Xh@x1>
 <Z60Ndm8VVI4Ao31U@x1>
 <CAP-5=fXw09MM5XyozJMM3FjMANJei1aNVmBghSEQFiCKAtJmXw@mail.gmail.com>
 <CAP-5=fUqcykMdApHVweETg9bp2EVPJhJOj_PR8cByOOA6OyQGw@mail.gmail.com>
 <Z6_CL0RpUUvw0lR7@x1>
 <Z7TvZGjVix2asYWI@x1>
 <Z7T1LVSLo8EEMmkM@x1>
 <Z7UDlZKnqXRqNqQa@google.com>
 <Z7XsltyqUWrdKma0@x1>
 <Z7XvEFEZtCRZKG7Y@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z7XvEFEZtCRZKG7Y@x1>

On Wed, Feb 19, 2025 at 03:47:44PM +0100, Arnaldo Carvalho de Melo wrote:
> On Wed, Feb 19, 2025 at 03:37:10PM +0100, Arnaldo Carvalho de Melo wrote:
> > On Tue, Feb 18, 2025 at 02:03:01PM -0800, Namhyung Kim wrote:
> > > On Tue, Feb 18, 2025 at 10:01:33PM +0100, Arnaldo Carvalho de Melo wrote:
> > > > On Tue, Feb 18, 2025 at 09:36:52PM +0100, Arnaldo Carvalho de Melo wrote:
> > > > > So the call to maps_fixup_end() will set maps->end_broken to false,
> > > > > since it fixed up the map ends, etc, but then we insert more maps with
> > > > > broken ends:
> > > >  
> > > > > #6  0x0000000000633d52 in check_invariants (maps=0xf967c0) at util/maps.c:95
> > > > > 95						assert(map__end(prev) <= map__end(map));
> > > > > (gdb) p prev->dso->name
> > > > > $1 = 0xfc47ab "bpf_trampoline_6442522522"
> > > > 
> > > > So the above map is created overlapping a previously existing map:
> > > > 
> > > > root@number:~# perf probe -l
> > > >   probe_perf:maps_fixup_end (on maps__fixup_end:1@util/maps.c in /home/acme/bin/perf with maps)
> > > >   probe_perf:maps_insert (on maps__insert:1@util/maps.c in /home/acme/bin/perf with maps name start end)
> > > > root@number:~# 
> > > > 
> > > > root@number:~# perf trace --lib -e probe_perf:maps* perf record sleep
> > > > <SNIP>
> > > >    319.791 perf/1732173 probe_perf:maps_insert((634e5e) maps=0x2d9715d0 name="bpf_prog_6deef7357e7b4530_sd_fw_egress" start=0xffffffffc0160788 end=0xffffffffc01607c8)
> > > >    319.810 perf/1732173 probe_perf:maps_insert((634e5e) maps=0x2d9715d0 name="bpf_prog_6deef7357e7b4530_sd_fw_ingress" start=0xffffffffc01647b8 end=0xffffffffc01647f8)
> > > >    319.822 perf/1732173 probe_perf:maps_insert((634e5e) maps=0x2d9715d0 name="bpf_prog_6deef7357e7b4530_sd_fw_egress" start=0xffffffffc016482c end=0xffffffffc016486c)
> > > >    319.834 perf/1732173 probe_perf:maps_insert((634e5e) maps=0x2d9715d0 name="bpf_prog_6deef7357e7b4530_sd_fw_ingress" start=0xffffffffc01648ac end=0xffffffffc01648ec)
> > > >    319.845 perf/1732173 probe_perf:maps_insert((634e5e) maps=0x2d9715d0 name="bpf_prog_be31ae23198a0378_sd_devices" start=0xffffffffc0186388 end=0xffffffffc01864b2)
> > > >    319.857 perf/1732173 probe_perf:maps_insert((634e5e) maps=0x2d9715d0 name="bpf_trampoline_6442522522" start=0xffffffffc0147640 end=0xffffffffc0148640)
> > > > [ perf record: Captured and wrote 0.035 MB perf.data (7 samples) ]
> > > > perf: util/maps.c:95: check_invariants: Assertion `map__end(prev) <= map__end(map)' failed.
> > > > root@number:~# 
> > > > 
> > > > So a PERF_RECORD_KSYMBOL processing will add a map for
> > > > "bpf_trampoline_6442522522" that has its start after before the
> > > > "bpf_prog_40ddf486530245f5_sd_devices" start, ok, but ends after
> > > > "bpf_prog_40ddf486530245f5_sd_devices", overlapping it.
> > > > 
> > > > machine__process_ksymbol_register() does:
> > > > 
> > > > 713			map__set_start(map, event->ksymbol.addr);
> > > > 714			map__set_end(map, map__start(map) + event->ksymbol.len);
> > > > 715			err = maps__insert(machine__kernel_maps(machine), map);
> > > > 
> > > > And:
> > > > 
> > > > (gdb) p /x event->ksymbol.addr
> > > > $2 = 0xffffffffc0147a2c
> > > > (gdb) p event->ksymbol.len
> > > > $3 = 306
> > > 
> > > Hmm.. so I think the situation is like below.
> > > 
> > >                    (bpf_trampoline_6442522522)
> > >             +---------------------------------------+   
> > > 	    |                                       |
> > > 	    |       +------------------------+      |
> > > 	    |       | (bpf_prog_40ddf486...) | <----+----  adding this
> > > 	    |       |                        |      |
> > > 	    |       |                        |      |
> > > 	    |   c0147a2c                            |
> > > 	    |                                       |
> > >         c0147640                                 c0148640
> > > 
> > > And it failed to add bpf_prog_40ddf486... in check_invariants() because
> > > the end address is smaller than the previous map.
> > 
> > No, it didn't fail to add, it managed to do it which left the kernel
> > maps in a broken state, with overlappings while it had a cleared
> > ends_broken, then, later, when the checks_invariant is finally called at
> > perf record exit time:
> 
> Nope, __maps__insert() should notice that the ends are broken and set
> it:
> 
>         if (nr_maps == 1) {
>                 /* If there's just 1 entry then maps are sorted. */
>                 maps__set_maps_by_address_sorted(maps, true);
>                 maps__set_maps_by_name_sorted(maps, maps_by_name != NULL);
>         } else {
>                 /* Sorted if maps were already sorted and this map starts after the last one. */
>                 maps__set_maps_by_address_sorted(maps,
>                         maps__maps_by_address_sorted(maps) &&
>                         map__end(maps_by_address[nr_maps - 2]) <= map__start(new));
>                 maps__set_maps_by_name_sorted(maps, false);
>         }
>         if (map__end(new) < map__start(new))
>                 RC_CHK_ACCESS(maps)->ends_broken = true;
> 
> 
> humm, RC_CHK_ACCESS(maps)->ends_broken should be set for the case we
> have and I think it isn't being... Then the bpf trampoline map that is
> the last entry to be added is before the last entry and thus
> maps_by_address_sorted is set to false, ends_broken continues false and
> at the end maps_by_address_sorted is set to true and the last
> check_invariants triggerrs the asserts...

Right, probably it needs to set the ends_broken when the end address of
the new map is smaller than the previous (but the start address is
bigger) and fixup the end address when it sorts the maps by address.

Thanks,
Namhyung

>  
> > > > > > #4  0x00007ffff6e3681e in __assert_fail_base (fmt=0x7ffff6fc3bb8 "%s%s%s:%u: %s%sAssertion `%s' failed.\n%n", assertion=assertion@entry=0x7bef08 "map__end(prev) <= map__end(map)",
> > > > > >     file=file@entry=0x7bedf8 "util/maps.c", line=line@entry=95, function=function@entry=0x7bf1c0 <__PRETTY_FUNCTION__.6> "check_invariants") at assert.c:96
> > > > > > #5  0x00007ffff6e47047 in __assert_fail (assertion=0x7bef08 "map__end(prev) <= map__end(map)", file=0x7bedf8 "util/maps.c", line=95,
> > > > > >     function=0x7bf1c0 <__PRETTY_FUNCTION__.6> "check_invariants") at assert.c:105
> > > > > > #6  0x00000000006347a1 in check_invariants (maps=0xf987e0) at util/maps.c:95
> > > > > > #7  0x0000000000635ae2 in maps__remove (maps=0xf987e0, map=0xf98a80) at util/maps.c:538
> > > > > > #8  0x000000000062afd2 in machine__destroy_kernel_maps (machine=0xf98178) at util/machine.c:1176
> > > > > > #9  0x000000000062b32b in machines__destroy_kernel_maps (machines=0xf98178) at util/machine.c:1238
> > > > > > #10 0x00000000006388af in perf_session__destroy_kernel_maps (session=0xf97f60) at util/session.c:105
> > > > > > #11 0x0000000000638df0 in perf_session__delete (session=0xf97f60) at util/session.c:248
> > > > > > #12 0x0000000000431f18 in __cmd_record (rec=0xecace0 <record>, argc=4, argv=0x7fffffffde60) at builtin-record.c:2888
> > 
> > is when we detect the problem, but I see what you mean, I'm trying to
> > figure out why this isn't caught here:
> > 
> > machine__process_ksymbol_register() ->
> > 	int maps__insert(struct maps *maps, struct map *map)
> > 	{       
> > 		int ret;
> > 
> > 		down_write(maps__lock(maps));
> > 		ret = __maps__insert(maps, map);
> > 		check_invariants(maps);
> > 		up_write(maps__lock(maps));
> > 		return ret;
> > 	}
> > 
> > Some more tracing:
> > 
> > root@number:~# perf probe -d probe_perf:* ; perf probe -qx ~/bin/perf check_invariants maps 'maps->maps_by_address_sorted' ; perf probe -qx ~/bin/perf maps__insert maps 'map->dso->name:string' 'map->start' 'map->end' ; perf probe -qx ~/bin/perf maps__fixup_end maps ; perf probe -l
> > Removed event: probe_perf:check_invariants
> > Removed event: probe_perf:maps_fixup_end
> > Removed event: probe_perf:maps_insert
> >   probe_perf:check_invariants (on check_invariants:1@util/maps.c in /home/acme/bin/perf with maps maps_by_address_sorted)
> >   probe_perf:maps_fixup_end (on maps__fixup_end:1@util/maps.c in /home/acme/bin/perf with maps)
> >   probe_perf:maps_insert (on maps__insert:1@util/maps.c in /home/acme/bin/perf with maps name start end)
> > root@number:~#
> > 
> > And then:
> > 
> > root@number:~# perf trace --lib -e probe_perf:maps_*,probe_perf:check_invariants/max-stack=32/ perf record sleep
> > <SNIP>
> >    316.283 perf/1882053 probe_perf:maps_insert((634e64) maps=0x342785d0 name="bpf_prog_6deef7357e7b4530_sd_fw_ingress" start=0xffffffffc01648ac end=0xffffffffc01648ec)
> >    316.284 perf/1882053 probe_perf:check_invariants((633b0f) maps=0x342785d0 maps_by_address_sorted=0x0)
> >                                        check_invariants (/home/acme/bin/perf)
> >                                        maps__insert (/home/acme/bin/perf)
> >                                        machine__process_ksymbol_register (/home/acme/bin/perf)
> >                                        machine__process_ksymbol (/home/acme/bin/perf)
> >                                        perf_event__process_ksymbol (/home/acme/bin/perf)
> >                                        machines__deliver_event (/home/acme/bin/perf)
> >                                        perf_session__deliver_event (/home/acme/bin/perf)
> >                                        perf_session__process_event (/home/acme/bin/perf)
> >                                        process_simple (/home/acme/bin/perf)
> >                                        reader__read_event (/home/acme/bin/perf)
> >                                        reader__process_events (/home/acme/bin/perf)
> >                                        __perf_session__process_events (/home/acme/bin/perf)
> >                                        perf_session__process_events (/home/acme/bin/perf)
> >                                        process_buildids (/home/acme/bin/perf)
> >                                        record__finish_output (/home/acme/bin/perf)
> >                                        __cmd_record (/home/acme/bin/perf)
> >                                        cmd_record (/home/acme/bin/perf)
> >                                        run_builtin (/home/acme/bin/perf)
> >                                        handle_internal_command (/home/acme/bin/perf)
> >                                        run_argv (/home/acme/bin/perf)
> >                                        main (/home/acme/bin/perf)
> >                                        __libc_start_call_main (/usr/lib64/libc.so.6)
> >                                        __libc_start_main@@GLIBC_2.34 (/usr/lib64/libc.so.6)
> >                                        _start (/home/acme/bin/perf)
> >    316.296 perf/1882053 probe_perf:maps_insert((634e64) maps=0x342785d0 name="bpf_prog_be31ae23198a0378_sd_devices" start=0xffffffffc0186388 end=0xffffffffc01864b2)
> >    316.298 perf/1882053 probe_perf:check_invariants((633b0f) maps=0x342785d0 maps_by_address_sorted=0x0)
> >                                        check_invariants (/home/acme/bin/perf)
> >                                        maps__insert (/home/acme/bin/perf)
> >                                        machine__process_ksymbol_register (/home/acme/bin/perf)
> >                                        machine__process_ksymbol (/home/acme/bin/perf)
> >                                        perf_event__process_ksymbol (/home/acme/bin/perf)
> >                                        machines__deliver_event (/home/acme/bin/perf)
> >                                        perf_session__deliver_event (/home/acme/bin/perf)
> >                                        perf_session__process_event (/home/acme/bin/perf)
> >                                        process_simple (/home/acme/bin/perf)
> >                                        reader__read_event (/home/acme/bin/perf)
> >                                        reader__process_events (/home/acme/bin/perf)
> >                                        __perf_session__process_events (/home/acme/bin/perf)
> >                                        perf_session__process_events (/home/acme/bin/perf)
> >                                        process_buildids (/home/acme/bin/perf)
> >                                        record__finish_output (/home/acme/bin/perf)
> >                                        __cmd_record (/home/acme/bin/perf)
> >                                        cmd_record (/home/acme/bin/perf)
> >                                        run_builtin (/home/acme/bin/perf)
> >                                        handle_internal_command (/home/acme/bin/perf)
> >                                        run_argv (/home/acme/bin/perf)
> >                                        main (/home/acme/bin/perf)
> >                                        __libc_start_call_main (/usr/lib64/libc.so.6)
> >                                        __libc_start_main@@GLIBC_2.34 (/usr/lib64/libc.so.6)
> >                                        _start (/home/acme/bin/perf)
> >    316.310 perf/1882053 probe_perf:maps_insert((634e64) maps=0x342785d0 name="bpf_trampoline_6442522522" start=0xffffffffc0147640 end=0xffffffffc0148640)
> >    316.311 perf/1882053 probe_perf:check_invariants((633b0f) maps=0x342785d0 maps_by_address_sorted=0x0)
> >                                        check_invariants (/home/acme/bin/perf)
> >                                        maps__insert (/home/acme/bin/perf)
> >                                        machine__process_ksymbol_register (/home/acme/bin/perf)
> >                                        machine__process_ksymbol (/home/acme/bin/perf)
> >                                        perf_event__process_ksymbol (/home/acme/bin/perf)
> >                                        machines__deliver_event (/home/acme/bin/perf)
> >                                        perf_session__deliver_event (/home/acme/bin/perf)
> >                                        perf_session__process_event (/home/acme/bin/perf)
> >                                        process_simple (/home/acme/bin/perf)
> >                                        reader__read_event (/home/acme/bin/perf)
> >                                        reader__process_events (/home/acme/bin/perf)
> >                                        __perf_session__process_events (/home/acme/bin/perf)
> >                                        perf_session__process_events (/home/acme/bin/perf)
> >                                        process_buildids (/home/acme/bin/perf)
> >                                        record__finish_output (/home/acme/bin/perf)
> >                                        __cmd_record (/home/acme/bin/perf)
> >                                        cmd_record (/home/acme/bin/perf)
> >                                        run_builtin (/home/acme/bin/perf)
> >                                        handle_internal_command (/home/acme/bin/perf)
> >                                        run_argv (/home/acme/bin/perf)
> >                                        main (/home/acme/bin/perf)
> >                                        __libc_start_call_main (/usr/lib64/libc.so.6)
> >                                        __libc_start_main@@GLIBC_2.34 (/usr/lib64/libc.so.6)
> >                                        _start (/home/acme/bin/perf)
> >    316.369 perf/1882053 probe_perf:check_invariants((633b0f) maps=0x342a6950 maps_by_address_sorted=0x1)
> >                                        check_invariants (/home/acme/bin/perf)
> >                                        __maps__insert_sorted (/home/acme/bin/perf)
> >                                        __maps__fixup_overlap_and_insert (/home/acme/bin/perf)
> >                                        maps__fixup_overlap_and_insert (/home/acme/bin/perf)
> >                                        thread__insert_map (/home/acme/bin/perf)
> >                                        machine__process_mmap2_event (/home/acme/bin/perf)
> >                                        perf_event__process_mmap2 (/home/acme/bin/perf)
> >                                        build_id__process_mmap2 (/home/acme/bin/perf)
> >                                        machines__deliver_event (/home/acme/bin/perf)
> >                                        perf_session__deliver_event (/home/acme/bin/perf)
> >                                        ordered_events__deliver_event (/home/acme/bin/perf)
> >                                        do_flush (/home/acme/bin/perf)
> >                                        __ordered_events__flush (/home/acme/bin/perf)
> >                                        ordered_events__flush (/home/acme/bin/perf)
> >                                        __perf_session__process_events (/home/acme/bin/perf)
> >                                        perf_session__process_events (/home/acme/bin/perf)
> >                                        process_buildids (/home/acme/bin/perf)
> >                                        record__finish_output (/home/acme/bin/perf)
> >                                        __cmd_record (/home/acme/bin/perf)
> >                                        cmd_record (/home/acme/bin/perf)
> >                                        run_builtin (/home/acme/bin/perf)
> >                                        handle_internal_command (/home/acme/bin/perf)
> >                                        run_argv (/home/acme/bin/perf)
> >                                        main (/home/acme/bin/perf)
> >                                        __libc_start_call_main (/usr/lib64/libc.so.6)
> >                                        __libc_start_main@@GLIBC_2.34 (/usr/lib64/libc.so.6)
> >                                        _start (/home/acme/bin/perf)
> > <SNIP>
> > [ perf record: Captured and wrote 0.035 MB perf.data (7 samples) ]
> >   1195.433 perf/1882053 probe_perf:check_invariants((633b0f) maps=0x342785d0 maps_by_address_sorted=0x1)
> >                                        check_invariants (/home/acme/bin/perf)
> >                                        maps__remove (/home/acme/bin/perf)
> >                                        machine__destroy_kernel_maps (/home/acme/bin/perfperf: util/maps.c:95: check_invariants: Assertion `map__end(prev) <= map__end(map)' failed.
> > )
> >                                        machines__destroy_kernel_maps (/home/acme/bin/perf)
> >                                        perf_session__destroy_kernel_maps (/home/acme/bin/perf)
> >                                        perf_session__delete (/home/acme/bin/perf)
> >                                        __cmd_record (/home/acme/bin/perf)
> >                                        cmd_record (/home/acme/bin/perf)
> >                                        run_builtin (/home/acme/bin/perf)
> >                                        handle_internal_command (/home/acme/bin/perf)
> >                                        run_argv (/home/acme/bin/perf)
> >                                        main (/home/acme/bin/perf)
> >                                        __libc_start_call_main (/usr/lib64/libc.so.6)
> >                                        __libc_start_main@@GLIBC_2.34 (/usr/lib64/libc.so.6)
> >                                        _start (/home/acme/bin/perf)
> > root@number:~#
> > 
> > check_invariants() doesn't check the ends because the
> > maps_byh_address_sorted is not set, I'll soon disappear into a call, but
> > the above should help as a checkpoint, I'll be back.
> > 
> > - Arnaldo
> > 
> >  
> > > > Thread 1 "perf" hit Breakpoint 1, machine__process_ksymbol_register (machine=0xf96158, event=0x7ffff7fb9aa0, sample=0x7fffffffa860) at util/machine.c:688
> > > > 688	{
> > > > (gdb) bt
> > > > #0  machine__process_ksymbol_register (machine=0xf96158, event=0x7ffff7fb9aa0, sample=0x7fffffffa860) at util/machine.c:688
> > > > #1  0x00000000006294ca in machine__process_ksymbol (machine=0xf96158, event=0x7ffff7fb9aa0, sample=0x7fffffffa860) at util/machine.c:779
> > > > #2  0x00000000005ce2fd in perf_event__process_ksymbol (tool=0xec8ce0 <record>, event=0x7ffff7fb9aa0, sample=0x7fffffffa860, machine=0xf96158) at util/event.c:296
> > > > #3  0x000000000063b6e4 in machines__deliver_event (machines=0xf96158, evlist=0xf521f0, event=0x7ffff7fb9aa0, sample=0x7fffffffa860, tool=0xec8ce0 <record>, file_offset=31392, 
> > > >     file_path=0xf96850 "perf.data") at util/session.c:1334
> > > > #4  0x000000000063b8c9 in perf_session__deliver_event (session=0xf95f40, event=0x7ffff7fb9aa0, tool=0xec8ce0 <record>, file_offset=31392, file_path=0xf96850 "perf.data")
> > > >     at util/session.c:1367
> > > > #5  0x000000000063c6bd in perf_session__process_event (session=0xf95f40, event=0x7ffff7fb9aa0, file_offset=31392, file_path=0xf96850 "perf.data") at util/session.c:1626
> > > > #6  0x000000000063de3d in process_simple (session=0xf95f40, event=0x7ffff7fb9aa0, file_offset=31392, file_path=0xf96850 "perf.data") at util/session.c:2203
> > > > #7  0x000000000063daf4 in reader__read_event (rd=0x7fffffffafa0, session=0xf95f40, prog=0x7fffffffaf70) at util/session.c:2132
> > > > #8  0x000000000063dcee in reader__process_events (rd=0x7fffffffafa0, session=0xf95f40, prog=0x7fffffffaf70) at util/session.c:2181
> > > > #9  0x000000000063df8b in __perf_session__process_events (session=0xf95f40) at util/session.c:2226
> > > > #10 0x000000000063e988 in perf_session__process_events (session=0xf95f40) at util/session.c:2390
> > > > #11 0x000000000042d98b in process_buildids (rec=0xec8ce0 <record>) at builtin-record.c:1475
> > > > #12 0x000000000042e963 in record__finish_output (rec=0xec8ce0 <record>) at builtin-record.c:1798
> > > > #13 0x0000000000431c46 in __cmd_record (rec=0xec8ce0 <record>, argc=2, argv=0x7fffffffde80) at builtin-record.c:2841
> > > > #14 0x000000000043513f in cmd_record (argc=2, argv=0x7fffffffde80) at builtin-record.c:4260
> > > > #15 0x00000000004bcf65 in run_builtin (p=0xecbd60 <commands+288>, argc=3, argv=0x7fffffffde80) at perf.c:351
> > > > #16 0x00000000004bd20c in handle_internal_command (argc=3, argv=0x7fffffffde80) at perf.c:404
> > > > #17 0x00000000004bd365 in run_argv (argcp=0x7fffffffdc6c, argv=0x7fffffffdc60) at perf.c:448
> > > > #18 0x00000000004bd6ae in main (argc=3, argv=0x7fffffffde80) at perf.c:556
> > > > (gdb)
> > > 
> > > > So, this one liner "refixes" the "modules" ends when processing the
> > > > records to find the build ids, unsure if it is the best solution tho:
> > 
> > > I think it "fixes" the problem by not clearing maps->ends_broken during
> > > the sample processing.  So check_invariants() will not check the end
> > > addresses of overlapping bpf_trampoline and bpf_prog.
> > 
> > You mean my one-liner?
> > 
> > I meant "refixes" as in maps__fixup_end() will fixup the overlapping of
> > the bpf_trampoline and bpf_prog and will re-clear maps->ends_broken
> > (needlessly, it was already cleared by the first call to
> > maps__fixup_end() after loading modules, at the start of the session).
> > 
> > Then check_invariants() _will_, check again, because maps->ends_broken
> > is cleared (was cleared twice even), the end addresses and there will
> > not be any overlapping, no?
> > 
> > - Arnaldo
> >  
> > > I'm curious how other commands (like perf report) are affected.  I think
> > > the original concern was the output of `perf buildid-list -m`.
> > > 
> > > Thanks,
> > > Namhyung
> > > 
> > > > 
> > > > diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> > > > index 5db1aedf48df92d2..5c4603d08ab5f2cb 100644
> > > > --- a/tools/perf/builtin-record.c
> > > > +++ b/tools/perf/builtin-record.c
> > > > @@ -1797,6 +1797,8 @@ record__finish_output(struct record *rec)
> > > >  	if (!rec->no_buildid) {
> > > >  		process_buildids(rec);
> > > >  
> > > > +		maps__fixup_end(machine__kernel_maps(&rec->session->machines.host));
> > > > +
> > > >  		if (rec->buildid_all)
> > > >  			perf_session__dsos_hit_all(rec->session);
> > > >  	}
> > > > 
> > > > 
