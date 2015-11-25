From: =?iso-2022-jp?B?GyRCSj8+PjJtTCYbKEIgLyBISVJBTUFUVRskQiEkGyhCTUFTQU1J?=
	<masami.hiramatsu.pt@hitachi.com>
Subject: RE: Re: bogus values of variables in userspace probes
Date: Wed, 25 Nov 2015 06:32:27 +0000
Message-ID: <50399556C9727B4D88A595C8584AAB375262FAC4@GSjpTKYDCembx32.service.hitachi.net>
References: <1448363902.24573.18.camel@redhat.com>
 <20151124145424.GC18140@kernel.org> <20151124161345.GH18140@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail7.hitachi.co.jp ([133.145.228.42]:39401 "EHLO
	mail7.hitachi.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753863AbbKYGca convert rfc822-to-8bit (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 25 Nov 2015 01:32:30 -0500
In-Reply-To: <20151124161345.GH18140@kernel.org>
Content-Language: ja-JP
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: 'Arnaldo Carvalho de Melo' <acme@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, David Ahern <dsahern@gmail.com>, Wang Nan <wangnan0@huawei.com>, Michael Petlan <mpetlan@redhat.com>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

>From: Arnaldo Carvalho de Melo [mailto:acme@kernel.org]

>Em Tue, Nov 24, 2015 at 11:54:24AM -0300, Arnaldo Carvalho de Melo escreveu:
>> Em Tue, Nov 24, 2015 at 12:18:22PM +0100, Michael Petlan escreveu:
>> > I have been playing with perf-probe tool and I found out that some bogus
>> > values of a function argument are obtained by perf-record.
>
>> > How to reproduce:
>
>> > gcc -O0 -g -o dummy dummy.c
>> > perf probe -x ./dummy --add 'isprime a'
>> > perf record -e probe_dummy:isprime ./dummy
>> > perf script
>
>> Checking this here, but as non root I get:
>
>> [acme@zoo ~]$ gcc -O0 -g -o isprime isprime.c
>> [acme@zoo ~]$ perf probe -x ./isprime --add 'isprime a'
>> Mapping for the register number 4113 missing on this architecture.
>> Sorry, we don't support this variable location yet.
>>   Error: Failed to add events.
>> [acme@zoo ~]$
>
>Bisected it down to:
>
>[acme@zoo linux]$ git bisect good
>05c8d802fa52ef17dbcce21c38b72b4a313eb036 is the first bad commit
>commit 05c8d802fa52ef17dbcce21c38b72b4a313eb036
>Author: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
>Date:   Wed Nov 18 15:40:12 2015 +0900
>
>    perf probe: Fix to free temporal Dwarf_Frame
>
>    Since dwarf_cfi_addrframe returns malloc'd Dwarf_Frame object, it has to
>    be freed after it is used.
>
>    Signed-off-by: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
>    Cc: Adrian Hunter <adrian.hunter@intel.com>
>    Cc: Jiri Olsa <jolsa@redhat.com>
>    Cc: Namhyung Kim <namhyung@kernel.org>
>    Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
>    Link: http://lkml.kernel.org/r/20151118064011.30709.65674.stgit@localhost.localdomain
>    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
>

Ah, OK. I miss understood. The dwarf_frame_cfa can return a part of
Dwarf_Frame(afaics libdw source code), so it should be freed right after
the Dwarf_Op (pf->fb_ops) is used.

OK, I'll fix that.

Thanks!
