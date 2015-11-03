From: Alex Bagehot <ceeaspb@gmail.com>
Subject: perf probe Argument list too long
Date: Tue, 3 Nov 2015 00:50:46 +0000
Message-ID: <CAHeneC-iMpy4tx35UXdSkLz7WYKx8epajgEpnS=NbfxvnxewTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-ob0-f180.google.com ([209.85.214.180]:33345 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752703AbbKCAur (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 2 Nov 2015 19:50:47 -0500
Received: by obbwb3 with SMTP id wb3so1132822obb.0
        for <linux-perf-users@vger.kernel.org>; Mon, 02 Nov 2015 16:50:47 -0800 (PST)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hello,

I get this error with perf probe, :

perf probe  -vvv -x /opt/jdk1.8.0_60/jre/lib/amd64/server/libjvm.so
'_ZN13CollectedHeap24common_mem_allocate_initE11KlassHandlemP6Thread'

probe-definition(0):
_ZN13CollectedHeap24common_mem_allocate_initE11KlassHandlemP6Thread
symbol:_ZN13CollectedHeap24common_mem_allocate_initE11KlassHandlemP6Thread
file:(null) line:0 offset:0 return:0 lazy:(null)
0 arguments
Opening /sys/kernel/debug/tracing/uprobe_events write=1
Added new event:
snprintf() failed: -7
  Error: Failed to add events. Reason: Argument list too long (Code: -7)


it looks like it's failing here: ./util/probe-event.c
probe_trace_event__set_name

        /* Get an unused new event name */
        ret = get_new_event_name(buf, 64, event,
                                 namelist, allow_suffix);


It works with a function 63 chars long not 64.
Knowing it is the event name erroring, It also works if I give the
event a short name eg. 'a'. I don't understand why it creates 3 probes
though?



objdump -t /opt/jdk1.8.0_60/jre/lib/amd64/server/libjvm.so|grep
\.text|awk 'length($NF) == 63 {print length($NF)" "$NF}'|head -1

63 _ZL34bulk_revoke_or_rebias_at_safepointP7oopDescbbP10JavaThread



perf probe  -vvv -x /opt/jdk1.8.0_60/jre/lib/amd64/server/libjvm.so
'_ZL34bulk_revoke_or_rebias_at_safepointP7oopDescbbP10JavaThread'

probe-definition(0):
_ZL34bulk_revoke_or_rebias_at_safepointP7oopDescbbP10JavaThread
symbol:_ZL34bulk_revoke_or_rebias_at_safepointP7oopDescbbP10JavaThread
file:(null) line:0 offset:0 return:0 lazy:(null)
0 arguments
Opening /sys/kernel/debug/tracing/uprobe_events write=1
Added new event:
Writing event: p:probe_libjvm/_ZL34bulk_revoke_or_rebias_at_safepointP7oopDescbbP10JavaThread
/opt/jdk1.8.0_60/jre/lib/amd64/server/libjvm.so:0x325a20
  probe_libjvm:_ZL34bulk_revoke_or_rebias_at_safepointP7oopDescbbP10JavaThread
(on _ZL34bulk_revoke_or_rebias_at_safepointP7oopDescbbP10JavaThread in
/opt/jdk1.8.0_60/jre/lib/amd64/server/libjvm.so)

You can now use it in all perf tools, such as:

perf record -e probe_libjvm:_ZL34bulk_revoke_or_rebias_at_safepointP7oopDescbbP10JavaThread
-aR sleep 1



perf probe  -vvv -x /opt/jdk1.8.0_60/jre/lib/amd64/server/libjvm.so
'a=_Z17do_write_prologueIP17GlobalTraceBufferEvR15JfrBufferWriterT_'

probe-definition(0):
a=_Z17do_write_prologueIP17GlobalTraceBufferEvR15JfrBufferWriterT_
symbol:_Z17do_write_prologueIP17GlobalTraceBufferEvR15JfrBufferWriterT_
file:(null) line:0 offset:0 return:0 lazy:(null)
0 arguments
Opening /sys/kernel/debug/tracing/uprobe_events write=1
Added new events:
Writing event: p:probe_libjvm/a
/opt/jdk1.8.0_60/jre/lib/amd64/server/libjvm.so:0x8ca940
  probe_libjvm:a       (on
_Z17do_write_prologueIP17GlobalTraceBufferEvR15JfrBufferWriterT_ in
/opt/jdk1.8.0_60/jre/lib/amd64/server/libjvm.so)
Writing event: p:probe_libjvm/a_1
/opt/jdk1.8.0_60/jre/lib/amd64/server/libjvm.so:0x9c07fe
  probe_libjvm:a_1     (on
_Z17do_write_prologueIP17GlobalTraceBufferEvR15JfrBufferWriterT_ in
/opt/jdk1.8.0_60/jre/lib/amd64/server/libjvm.so)
Writing event: p:probe_libjvm/a_2
/opt/jdk1.8.0_60/jre/lib/amd64/server/libjvm.so:0x9c25c1
  probe_libjvm:a_2     (on
_Z17do_write_prologueIP17GlobalTraceBufferEvR15JfrBufferWriterT_ in
/opt/jdk1.8.0_60/jre/lib/amd64/server/libjvm.so)

You can now use it in all perf tools, such as:

perf record -e probe_libjvm:a_2 -aR sleep 1


perf probe -l

  probe_libjvm:a       (on
_Z17do_write_prologueIP17GlobalTraceBufferEvR15JfrBufferWriterT_ in
/opt/jdk1.8.0_60/jre/lib/amd64/server/libjvm.so)
  probe_libjvm:a_1     (on
_Z17do_write_prologueIP17GlobalTraceBufferEvR15JfrBufferWriterT_ in
/opt/jdk1.8.0_60/jre/lib/amd64/server/libjvm.so)
  probe_libjvm:a_2     (on
_Z17do_write_prologueIP17GlobalTraceBufferEvR15JfrBufferWriterT_ in
/opt/jdk1.8.0_60/jre/lib/amd64/server/libjvm.so)



uname -a

Linux vagrant-ubuntu-trusty-64 4.3.0-999-generic #201510112200 SMP Mon
Oct 12 02:01:41 UTC 2015 x86_64 x86_64 x86_64 GNU/Linux


Thanks,

Alex
