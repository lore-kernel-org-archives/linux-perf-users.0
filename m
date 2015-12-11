From: "Wangnan (F)" <wangnan0@huawei.com>
Subject: Re: [PATCH perf/core  00/22] perf refcnt debugger API and fixes
Date: Fri, 11 Dec 2015 10:22:00 +0800
Message-ID: <566A3348.4090001@huawei.com>
References: <20151209021047.10245.8918.stgit@localhost.localdomain> <20151209134138.GB15864@kernel.org> <50399556C9727B4D88A595C8584AAB375264FB48@GSjpTKYDCembx32.service.hitachi.net> <56697572.90701@huawei.com> <20151210151239.GB17996@kernel.org> <566A2CA0.8070608@huawei.com> <50399556C9727B4D88A595C8584AAB37526515DD@GSjpTKYDCembx32.service.hitachi.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:8741 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751526AbbLKCW3 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 10 Dec 2015 21:22:29 -0500
In-Reply-To: <50399556C9727B4D88A595C8584AAB37526515DD@GSjpTKYDCembx32.service.hitachi.net>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: =?UTF-8?B?5bmz5p2+6ZuF5bezIC8gSElSQU1BVFXvvIxNQVNBTUk=?= <masami.hiramatsu.pt@hitachi.com>, 'Arnaldo Carvalho de Melo' <acme@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, Adrian Hunter <adrian.hunter@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@redhat.com>, Alexei Starovoitov <ast@plumgrid.com>



On 2015/12/11 10:08, =E5=B9=B3=E6=9D=BE=E9=9B=85=E5=B7=B3 / HIRAMATU=EF=
=BC=8CMASAMI wrote:
> From: Wangnan (F) [mailto:wangnan0@huawei.com]
>> On 2015/12/10 23:12, 'Arnaldo Carvalho de Melo' wrote:
>>
>> [SNIP]
>>> But this requires having these special refcnt__ routines, that will=
 make
>>> tools/perf/ code patterns for reference counts look different that =
the
>>> refcount patterns in the kernel :-\
>>>
>>> And would be a requirement to change the observed workload :-\
>>>
>>> Is this _strictly_ required?
>> No. The requirement should be:
>>
>>   1. The create/get/put/delete functions are non-inline (because dwa=
rf info
>>      is not as reliable as symbol);
>>   2. From their argument list, we can always get the variable we nee=
d (the
>>      pointer of objects, the value of refcnt, etc.)
> However, we have to customize it for each application. Perf itself mi=
ght be OK
> but others might have different implementation.

If limited to pairwise operations ({{m,c}alloc,strdup} vs free, open vs=
=20
close),
I think it is possible to abstract a uniformed pattern.

Thank you.
