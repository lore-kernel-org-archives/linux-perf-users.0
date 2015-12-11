From: "Wangnan (F)" <wangnan0@huawei.com>
Subject: Re: [PATCH perf/core  00/22] perf refcnt debugger API and fixes
Date: Fri, 11 Dec 2015 09:53:36 +0800
Message-ID: <566A2CA0.8070608@huawei.com>
References: <20151209021047.10245.8918.stgit@localhost.localdomain> <20151209134138.GB15864@kernel.org> <50399556C9727B4D88A595C8584AAB375264FB48@GSjpTKYDCembx32.service.hitachi.net> <56697572.90701@huawei.com> <20151210151239.GB17996@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([119.145.14.66]:55412 "EHLO
	szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751517AbbLKByQ (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 10 Dec 2015 20:54:16 -0500
In-Reply-To: <20151210151239.GB17996@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: 'Arnaldo Carvalho de Melo' <acme@kernel.org>
Cc: =?UTF-8?B?5bmz5p2+6ZuF5bezIC8gSElSQU1BVFXvvIxNQVNBTUk=?= <masami.hiramatsu.pt@hitachi.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Adrian Hunter <adrian.hunter@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@redhat.com>, Alexei Starovoitov <ast@plumgrid.com>



On 2015/12/10 23:12, 'Arnaldo Carvalho de Melo' wrote:

[SNIP]
> But this requires having these special refcnt__ routines, that will make
> tools/perf/ code patterns for reference counts look different that the
> refcount patterns in the kernel :-\
>
> And would be a requirement to change the observed workload :-\
>
> Is this _strictly_ required?

No. The requirement should be:

  1. The create/get/put/delete functions are non-inline (because dwarf info
     is not as reliable as symbol);
  2. From their argument list, we can always get the variable we need (the
     pointer of objects, the value of refcnt, etc.)

We don't have to use this refcnt things.

> Can't we, for a project like perf, where we
> know where some refcount (say, the one for 'struct thread') gets
> initialized, use that (thread__new()) and then hook into thread__get and
> thread__put and then use the destructor, thread__delete() as the place
> to dump leaks?
>

I think it is possible. If we can abstract a common pattern about it,
we can provide a perf subcommand which we can deal with generic alloc/free
pattern. I'll put it on my todo-list. Currently we are focusing on perf
daemonization.

Thank you.
