From: "Wangnan (F)" <wangnan0@huawei.com>
Subject: Re: [PATCH perf/core  00/22] perf refcnt debugger API and fixes
Date: Fri, 11 Dec 2015 10:53:38 +0800
Message-ID: <566A3AB2.2020700@huawei.com>
References: <20151209021047.10245.8918.stgit@localhost.localdomain> <20151209134138.GB15864@kernel.org> <50399556C9727B4D88A595C8584AAB375264FB48@GSjpTKYDCembx32.service.hitachi.net> <56697572.90701@huawei.com> <20151210151239.GB17996@kernel.org> <50399556C9727B4D88A595C8584AAB37526515F5@GSjpTKYDCembx32.service.hitachi.net> <566A3823.9080503@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:36923 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753722AbbLKC6a (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 10 Dec 2015 21:58:30 -0500
In-Reply-To: <566A3823.9080503@huawei.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: =?UTF-8?B?5bmz5p2+6ZuF5bezIC8gSElSQU1BVFXvvIxNQVNBTUk=?= <masami.hiramatsu.pt@hitachi.com>, 'Arnaldo Carvalho de Melo' <acme@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, Adrian Hunter <adrian.hunter@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@redhat.com>, Alexei Starovoitov <ast@plumgrid.com>



On 2015/12/11 10:42, Wangnan (F) wrote:
>
>
> On 2015/12/11 10:15, =E5=B9=B3=E6=9D=BE=E9=9B=85=E5=B7=B3 / HIRAMATU=EF=
=BC=8CMASAMI wrote:
>> From: 'Arnaldo Carvalho de Melo' [mailto:acme@kernel.org]
>>> But this requires having these special refcnt__ routines, that will=
=20
>>> make
>>> tools/perf/ code patterns for reference counts look different that =
the
>>> refcount patterns in the kernel :-\
>> BTW, I think even without the refcnt debugger, we'd better introduce=
=20
>> this
>> kind API to unify the refcnt operation in perf code. As I said, we=20
>> have many
>> miscodings on current implementation. Unifying the API can enforce=20
>> developers
>> to avoid such miscodings.
>>
>> Thank you,
>>
>
> I tried this problem in another way, I'd like to share it here.
>
> First: create two uprobes:
>
> # ./perf probe --exec /home/wangnan/perf dso__new%return %ax
> Added new event:
>   probe_perf:dso__new  (on dso__new%return in /home/wangnan/perf with=
=20
> %ax)
>
> You can now use it in all perf tools, such as:
>
>     perf record -e probe_perf:dso__new -aR sleep 1
>
> # ./perf probe --exec /home/wangnan/perf dso__delete dso
> Added new event:
>   probe_perf:dso__delete (on dso__delete in /home/wangnan/perf with d=
so)
>
> You can now use it in all perf tools, such as:
>
>     perf record -e probe_perf:dso__delete -aR sleep 1
>
>
> Then start test:
>
> # ./perf record -g -e probe_perf:dso__new -e probe_perf:dso__delete=20
> ./perf probe vfs_read
> Added new event:
>   probe:vfs_read       (on vfs_read)
>
> You can now use it in all perf tools, such as:
>
>     perf record -e probe:vfs_read -aR sleep 1
>
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.048 MB perf.data (178 samples) ]
>
>
> From the perf report result I know two dso objects are leak:
>
> 90 probe_perf:dso__new `
> 88 probe_perf:dso__delete
>

The above result is gotten from yesterday's perf/core. I also tried
today's perf/core and get:

90 probe_perf:dso__new `
90 probe_perf:dso__delete

So we fix these leak.

Thank you.
