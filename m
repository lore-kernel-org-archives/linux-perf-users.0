From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: perf probe Argument list too long
Date: Mon, 2 Nov 2015 22:00:26 -0300
Message-ID: <20151103010026.GF21609@kernel.org>
References: <CAHeneC-iMpy4tx35UXdSkLz7WYKx8epajgEpnS=NbfxvnxewTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:44232 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752609AbbKCBAb (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 2 Nov 2015 20:00:31 -0500
Content-Disposition: inline
In-Reply-To: <CAHeneC-iMpy4tx35UXdSkLz7WYKx8epajgEpnS=NbfxvnxewTg@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Cc: Alex Bagehot <ceeaspb@gmail.com>, linux-perf-users@vger.kernel.org

Em Tue, Nov 03, 2015 at 12:50:46AM +0000, Alex Bagehot escreveu:
> Hello,
> 
> I get this error with perf probe, :
> 
> perf probe  -vvv -x /opt/jdk1.8.0_60/jre/lib/amd64/server/libjvm.so
> '_ZN13CollectedHeap24common_mem_allocate_initE11KlassHandlemP6Thread'
> 
> probe-definition(0):
> _ZN13CollectedHeap24common_mem_allocate_initE11KlassHandlemP6Thread
> symbol:_ZN13CollectedHeap24common_mem_allocate_initE11KlassHandlemP6Thread
> file:(null) line:0 offset:0 return:0 lazy:(null)
> 0 arguments
> Opening /sys/kernel/debug/tracing/uprobe_events write=1
> Added new event:
> snprintf() failed: -7
>   Error: Failed to add events. Reason: Argument list too long (Code: -7)
> 
> 
> it looks like it's failing here: ./util/probe-event.c
> probe_trace_event__set_name
> 
>         /* Get an unused new event name */
>         ret = get_new_event_name(buf, 64, event,
>                                  namelist, allow_suffix);

Masami, do we really need to cap it at 64 bytes? And would it be
possible to improve that error reporting? I.e. this isn't an "argument
list", right?
 
> It works with a function 63 chars long not 64.
> Knowing it is the event name erroring, It also works if I give the
> event a short name eg. 'a'. I don't understand why it creates 3 probes
> though?

Masami? You gave this explanation at some point, but I forgot, aliases?
Inlining?

Would be interesting to warn the user why multiple probes are being
created, no?

Alex, you can try using wildcards in this case, i.e.:

  perf record -e probe_libjvm:a* your-workload

That if you don't have other probes in place starting with the same
prefix :-\

- Arnaldo

 
> objdump -t /opt/jdk1.8.0_60/jre/lib/amd64/server/libjvm.so|grep
> \.text|awk 'length($NF) == 63 {print length($NF)" "$NF}'|head -1
> 
> 63 _ZL34bulk_revoke_or_rebias_at_safepointP7oopDescbbP10JavaThread
> 
> 
> 
> perf probe  -vvv -x /opt/jdk1.8.0_60/jre/lib/amd64/server/libjvm.so
> '_ZL34bulk_revoke_or_rebias_at_safepointP7oopDescbbP10JavaThread'
> 
> probe-definition(0):
> _ZL34bulk_revoke_or_rebias_at_safepointP7oopDescbbP10JavaThread
> symbol:_ZL34bulk_revoke_or_rebias_at_safepointP7oopDescbbP10JavaThread
> file:(null) line:0 offset:0 return:0 lazy:(null)
> 0 arguments
> Opening /sys/kernel/debug/tracing/uprobe_events write=1
> Added new event:
> Writing event: p:probe_libjvm/_ZL34bulk_revoke_or_rebias_at_safepointP7oopDescbbP10JavaThread
> /opt/jdk1.8.0_60/jre/lib/amd64/server/libjvm.so:0x325a20
>   probe_libjvm:_ZL34bulk_revoke_or_rebias_at_safepointP7oopDescbbP10JavaThread
> (on _ZL34bulk_revoke_or_rebias_at_safepointP7oopDescbbP10JavaThread in
> /opt/jdk1.8.0_60/jre/lib/amd64/server/libjvm.so)
> 
> You can now use it in all perf tools, such as:
> 
> perf record -e probe_libjvm:_ZL34bulk_revoke_or_rebias_at_safepointP7oopDescbbP10JavaThread
> -aR sleep 1
> 
> 
> 
> perf probe  -vvv -x /opt/jdk1.8.0_60/jre/lib/amd64/server/libjvm.so
> 'a=_Z17do_write_prologueIP17GlobalTraceBufferEvR15JfrBufferWriterT_'
> 
> probe-definition(0):
> a=_Z17do_write_prologueIP17GlobalTraceBufferEvR15JfrBufferWriterT_
> symbol:_Z17do_write_prologueIP17GlobalTraceBufferEvR15JfrBufferWriterT_
> file:(null) line:0 offset:0 return:0 lazy:(null)
> 0 arguments
> Opening /sys/kernel/debug/tracing/uprobe_events write=1
> Added new events:
> Writing event: p:probe_libjvm/a
> /opt/jdk1.8.0_60/jre/lib/amd64/server/libjvm.so:0x8ca940
>   probe_libjvm:a       (on
> _Z17do_write_prologueIP17GlobalTraceBufferEvR15JfrBufferWriterT_ in
> /opt/jdk1.8.0_60/jre/lib/amd64/server/libjvm.so)
> Writing event: p:probe_libjvm/a_1
> /opt/jdk1.8.0_60/jre/lib/amd64/server/libjvm.so:0x9c07fe
>   probe_libjvm:a_1     (on
> _Z17do_write_prologueIP17GlobalTraceBufferEvR15JfrBufferWriterT_ in
> /opt/jdk1.8.0_60/jre/lib/amd64/server/libjvm.so)
> Writing event: p:probe_libjvm/a_2
> /opt/jdk1.8.0_60/jre/lib/amd64/server/libjvm.so:0x9c25c1
>   probe_libjvm:a_2     (on
> _Z17do_write_prologueIP17GlobalTraceBufferEvR15JfrBufferWriterT_ in
> /opt/jdk1.8.0_60/jre/lib/amd64/server/libjvm.so)
> 
> You can now use it in all perf tools, such as:
> 
> perf record -e probe_libjvm:a_2 -aR sleep 1
> 
> 
> perf probe -l
> 
>   probe_libjvm:a       (on
> _Z17do_write_prologueIP17GlobalTraceBufferEvR15JfrBufferWriterT_ in
> /opt/jdk1.8.0_60/jre/lib/amd64/server/libjvm.so)
>   probe_libjvm:a_1     (on
> _Z17do_write_prologueIP17GlobalTraceBufferEvR15JfrBufferWriterT_ in
> /opt/jdk1.8.0_60/jre/lib/amd64/server/libjvm.so)
>   probe_libjvm:a_2     (on
> _Z17do_write_prologueIP17GlobalTraceBufferEvR15JfrBufferWriterT_ in
> /opt/jdk1.8.0_60/jre/lib/amd64/server/libjvm.so)
> 
> 
> 
> uname -a
> 
> Linux vagrant-ubuntu-trusty-64 4.3.0-999-generic #201510112200 SMP Mon
> Oct 12 02:01:41 UTC 2015 x86_64 x86_64 x86_64 GNU/Linux
> 
> 
> Thanks,
> 
> Alex
> --
> To unsubscribe from this list: send the line "unsubscribe linux-perf-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
