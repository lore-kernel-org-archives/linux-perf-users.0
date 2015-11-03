From: Alex Bagehot <ceeaspb@gmail.com>
Subject: Re: Re: perf probe Argument list too long
Date: Tue, 3 Nov 2015 11:22:17 +0000
Message-ID: <CAHeneC8iDAXym-JEr5idsAyDciekpgFCOq6rJPJs-vQK59E2fA@mail.gmail.com>
References: <CAHeneC-iMpy4tx35UXdSkLz7WYKx8epajgEpnS=NbfxvnxewTg@mail.gmail.com>
	<20151103010026.GF21609@kernel.org>
	<50399556C9727B4D88A595C8584AAB37525F9F23@GSjpTKYDCembx32.service.hitachi.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-ob0-f175.google.com ([209.85.214.175]:33583 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751016AbbKCLWS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 3 Nov 2015 06:22:18 -0500
Received: by obbwb3 with SMTP id wb3so9743439obb.0
        for <linux-perf-users@vger.kernel.org>; Tue, 03 Nov 2015 03:22:18 -0800 (PST)
In-Reply-To: <50399556C9727B4D88A595C8584AAB37525F9F23@GSjpTKYDCembx32.service.hitachi.net>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: =?UTF-8?B?5bmz5p2+6ZuF5bezIC8gSElSQU1BVFXvvIxNQVNBTUk=?= <masami.hiramatsu.pt@hitachi.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

On Tue, Nov 3, 2015 at 3:20 AM, =E5=B9=B3=E6=9D=BE=E9=9B=85=E5=B7=B3 / =
HIRAMATU=EF=BC=8CMASAMI
<masami.hiramatsu.pt@hitachi.com> wrote:
> From: Arnaldo Carvalho de Melo [mailto:acme@kernel.org]
>>Em Tue, Nov 03, 2015 at 12:50:46AM +0000, Alex Bagehot escreveu:
>>> Hello,
>>>
>>> I get this error with perf probe, :
>>>
>>> perf probe  -vvv -x /opt/jdk1.8.0_60/jre/lib/amd64/server/libjvm.so
>>> '_ZN13CollectedHeap24common_mem_allocate_initE11KlassHandlemP6Threa=
d'
>
> Ah, I've never thought that the symbol name gets so long :(

no problem. thanks for looking at this.

> BTW, is that oracle's jdk package? I'd like to reproduce the bug.

yes, openjdk should be the same/similar

>
>>>
>>> probe-definition(0):
>>> _ZN13CollectedHeap24common_mem_allocate_initE11KlassHandlemP6Thread
>>> symbol:_ZN13CollectedHeap24common_mem_allocate_initE11KlassHandlemP=
6Thread
>>> file:(null) line:0 offset:0 return:0 lazy:(null)
>>> 0 arguments
>>> Opening /sys/kernel/debug/tracing/uprobe_events write=3D1
>>> Added new event:
>>> snprintf() failed: -7
>>>   Error: Failed to add events. Reason: Argument list too long (Code=
: -7)
>>>
>>>
>>> it looks like it's failing here: ./util/probe-event.c
>>> probe_trace_event__set_name
>>>
>>>         /* Get an unused new event name */
>>>         ret =3D get_new_event_name(buf, 64, event,
>>>                                  namelist, allow_suffix);
>>
>>Masami, do we really need to cap it at 64 bytes? And would it be
>>possible to improve that error reporting? I.e. this isn't an "argumen=
t
>>list", right?
>
> No, but it is used for event name whose maximum length is 63+\0.
> There is actually no reason for 64, but we need a limitation for even=
t name.
>
> And, yeah, the error message comes from E2BIG.
>
> #define E2BIG            7      /* Argument list too long */
>
> So, the "argument" means argument of snprintf.
>
>>> It works with a function 63 chars long not 64.
>>> Knowing it is the event name erroring, It also works if I give the
>>> event a short name eg. 'a'. I don't understand why it creates 3 pro=
bes
>>> though?
>>
>>Masami? You gave this explanation at some point, but I forgot, aliase=
s?
>>Inlining?
>
> Yes, I guess it is because of inlined function. If there are several =
different
> instances at different addresses, perf probe tries to define probes f=
or each
> address.
>
>>
>>Would be interesting to warn the user why multiple probes are being
>>created, no?
>
> Hmm, ok. it is usually done by probing inlined function, or the targe=
t line
> has multiple instructions. It may be better to show the reason why.

If the information is there yes that would be useful to the user.

>
>
>>Alex, you can try using wildcards in this case, i.e.:
>>
>>  perf record -e probe_libjvm:a* your-workload
>>
>>That if you don't have other probes in place starting with the same
>>prefix :-\

Thanks

>>
>>- Arnaldo
>>
>>
>>> objdump -t /opt/jdk1.8.0_60/jre/lib/amd64/server/libjvm.so|grep
>>> \.text|awk 'length($NF) =3D=3D 63 {print length($NF)" "$NF}'|head -=
1
>>>
>>> 63 _ZL34bulk_revoke_or_rebias_at_safepointP7oopDescbbP10JavaThread
>>>
>>>
>>>
>>> perf probe  -vvv -x /opt/jdk1.8.0_60/jre/lib/amd64/server/libjvm.so
>>> '_ZL34bulk_revoke_or_rebias_at_safepointP7oopDescbbP10JavaThread'
>>>
>>> probe-definition(0):
>>> _ZL34bulk_revoke_or_rebias_at_safepointP7oopDescbbP10JavaThread
>>> symbol:_ZL34bulk_revoke_or_rebias_at_safepointP7oopDescbbP10JavaThr=
ead
>>> file:(null) line:0 offset:0 return:0 lazy:(null)
>>> 0 arguments
>>> Opening /sys/kernel/debug/tracing/uprobe_events write=3D1
>>> Added new event:
>>> Writing event: p:probe_libjvm/_ZL34bulk_revoke_or_rebias_at_safepoi=
ntP7oopDescbbP10JavaThread
>>> /opt/jdk1.8.0_60/jre/lib/amd64/server/libjvm.so:0x325a20
>>>   probe_libjvm:_ZL34bulk_revoke_or_rebias_at_safepointP7oopDescbbP1=
0JavaThread
>>> (on _ZL34bulk_revoke_or_rebias_at_safepointP7oopDescbbP10JavaThread=
 in
>>> /opt/jdk1.8.0_60/jre/lib/amd64/server/libjvm.so)
>>>
>>> You can now use it in all perf tools, such as:
>>>
>>> perf record -e probe_libjvm:_ZL34bulk_revoke_or_rebias_at_safepoint=
P7oopDescbbP10JavaThread
>>> -aR sleep 1
>>>
>>>
>>>
>>> perf probe  -vvv -x /opt/jdk1.8.0_60/jre/lib/amd64/server/libjvm.so
>>> 'a=3D_Z17do_write_prologueIP17GlobalTraceBufferEvR15JfrBufferWriter=
T_'
>>>
>>> probe-definition(0):
>>> a=3D_Z17do_write_prologueIP17GlobalTraceBufferEvR15JfrBufferWriterT=
_
>>> symbol:_Z17do_write_prologueIP17GlobalTraceBufferEvR15JfrBufferWrit=
erT_
>>> file:(null) line:0 offset:0 return:0 lazy:(null)
>>> 0 arguments
>>> Opening /sys/kernel/debug/tracing/uprobe_events write=3D1
>>> Added new events:
>>> Writing event: p:probe_libjvm/a
>>> /opt/jdk1.8.0_60/jre/lib/amd64/server/libjvm.so:0x8ca940
>>>   probe_libjvm:a       (on
>>> _Z17do_write_prologueIP17GlobalTraceBufferEvR15JfrBufferWriterT_ in
>>> /opt/jdk1.8.0_60/jre/lib/amd64/server/libjvm.so)
>>> Writing event: p:probe_libjvm/a_1
>>> /opt/jdk1.8.0_60/jre/lib/amd64/server/libjvm.so:0x9c07fe
>>>   probe_libjvm:a_1     (on
>>> _Z17do_write_prologueIP17GlobalTraceBufferEvR15JfrBufferWriterT_ in
>>> /opt/jdk1.8.0_60/jre/lib/amd64/server/libjvm.so)
>>> Writing event: p:probe_libjvm/a_2
>>> /opt/jdk1.8.0_60/jre/lib/amd64/server/libjvm.so:0x9c25c1
>>>   probe_libjvm:a_2     (on
>>> _Z17do_write_prologueIP17GlobalTraceBufferEvR15JfrBufferWriterT_ in
>>> /opt/jdk1.8.0_60/jre/lib/amd64/server/libjvm.so)
>>>
>>> You can now use it in all perf tools, such as:
>>>
>>> perf record -e probe_libjvm:a_2 -aR sleep 1
>>>
>>>
>>> perf probe -l
>>>
>>>   probe_libjvm:a       (on
>>> _Z17do_write_prologueIP17GlobalTraceBufferEvR15JfrBufferWriterT_ in
>>> /opt/jdk1.8.0_60/jre/lib/amd64/server/libjvm.so)
>>>   probe_libjvm:a_1     (on
>>> _Z17do_write_prologueIP17GlobalTraceBufferEvR15JfrBufferWriterT_ in
>>> /opt/jdk1.8.0_60/jre/lib/amd64/server/libjvm.so)
>>>   probe_libjvm:a_2     (on
>>> _Z17do_write_prologueIP17GlobalTraceBufferEvR15JfrBufferWriterT_ in
>>> /opt/jdk1.8.0_60/jre/lib/amd64/server/libjvm.so)
>>>
>>>
>>>
>>> uname -a
>>>
>>> Linux vagrant-ubuntu-trusty-64 4.3.0-999-generic #201510112200 SMP =
Mon
>>> Oct 12 02:01:41 UTC 2015 x86_64 x86_64 x86_64 GNU/Linux
>>>
>>>
>>> Thanks,
>>>
>>> Alex
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-per=
f-users" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-perf-=
users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
