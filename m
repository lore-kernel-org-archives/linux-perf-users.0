From: =?iso-2022-jp?B?GyRCSj8+PjJtTCYbKEIgLyBISVJBTUFUVRskQiEkGyhCTUFTQU1J?=
	<masami.hiramatsu.pt@hitachi.com>
Subject: RE: [PATCH perf/core  00/22] perf refcnt debugger API and fixes
Date: Thu, 10 Dec 2015 11:04:27 +0000
Message-ID: <50399556C9727B4D88A595C8584AAB375264FB48@GSjpTKYDCembx32.service.hitachi.net>
References: <20151209021047.10245.8918.stgit@localhost.localdomain>
 <20151209134138.GB15864@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail7.hitachi.co.jp ([133.145.228.42]:35405 "EHLO
	mail7.hitachi.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751740AbbLJLEb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 10 Dec 2015 06:04:31 -0500
In-Reply-To: <20151209134138.GB15864@kernel.org>
Content-Language: ja-JP
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: 'Arnaldo Carvalho de Melo' <acme@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, Adrian Hunter <adrian.hunter@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@redhat.com>, Wang Nan <wangnan0@huawei.com>, Alexei Starovoitov <ast@plumgrid.com>

>From: Arnaldo Carvalho de Melo [mailto:acme@kernel.org]
>
>Em Wed, Dec 09, 2015 at 11:10:48AM +0900, Masami Hiramatsu escreveu:
>> Hi Arnaldo,
>>
>> Here is a series of patches for perf refcnt debugger and
>> some fixes.
>>
>> In this series I've replaced all atomic reference counters
>> with the refcnt interface, including dso, map, map_groups,
>> thread, cpu_map, comm_str, cgroup_sel, thread_map, and
>> perf_mmap.
>>
>>   refcnt debugger (or refcnt leak checker)
>>   ===============
>>
>> At first, note that this change doesn't affect any compiled
>> code unless building with REFCNT_DEBUG=1 (see macros in
>> refcnt.h). So, this feature is only enabled in the debug binary.
>> But before releasing, we can ensure that all objects are safely
>> reclaimed before exit in -rc phase.
>
>That helps and is finding bugs and is really great stuff, thank you!
>
>But I wonder if we couldn't get the same results on an unmodified binary
>by using things like 'perf probe', the BPF code we're introducing, have
>you thought about this possibility?

That's possible, but it will require pre-analysis of the binary, because
refcnt interface is not fixed API like a "systemcall" (moreover, it could
be just a non-atomic variable).

Thus we need a kind of "annotation" event by source code level.

>
>I.e. trying to use 'perf probe' to do this would help in using the same
>technique in other code bases where we can't change the sources, etc.
>
>For perf we could perhaps use a 'noinline' on the __get/__put
>operations, so that we could have the right places to hook using
>uprobes, other codebases would have to rely in the 'perf probe'
>infrastructure that knows where inlines were expanded, etc.
>
>Such a toold could work like:
>
>   perf dbgrefcnt ~/bin/perf thread

This works only for the binary which is coded as you said.
I actually doubt that this is universal solution. We'd better introduce
librefcnt.so if you need more general solution, so that we can fix the
refcnt API and we can also hook the interface easily.

But with this way, we don't need ebpf/uprobes anymore, since we've already
have LD_PRELOAD (like valgrind does). :(

So, IMHO, using ebpf and perf probe for this issue sounds like using
a sledge‐hammer...

Thanks,

>
>And it would look up thread__get and thread__put(), create an eBPF map
>where to store the needed tracking data structures, and use the same
>techniques you used, asking for backtraces using the perf
>infrastructure, etc.
>
>We would be using this opportunity to improve the 'perf probe' and the
>eBPF infrastructures we're putting in place, and having something that
>could be used in other codebases, not just perf.
>
