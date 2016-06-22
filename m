From: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Subject: Re: perf segfault in docker container
Date: Thu, 23 Jun 2016 03:05:39 +0530
Message-ID: <576B04AB.1090801@linux.vnet.ibm.com>
References: <CAE40pdfWpz6rreOCMJCs1P8WXfOXO_B5zZoeOyC_5usYGp8xRQ@mail.gmail.com>
 <575A9660.4070907@linux.vnet.ibm.com>
 <CAE40pdccu3HnO3PdEX1fUEQk40jBrmteHs9hKA9+aboRUJz1sA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57225 "EHLO
	mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751325AbcFVVfr (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 22 Jun 2016 17:35:47 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id u5MLYCC2002130
	for <linux-perf-users@vger.kernel.org>; Wed, 22 Jun 2016 17:35:47 -0400
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
	by mx0a-001b2d01.pphosted.com with ESMTP id 23q9nc1b3h-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <linux-perf-users@vger.kernel.org>; Wed, 22 Jun 2016 17:35:46 -0400
Received: from localhost
	by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-perf-users@vger.kernel.org> from <aravinda@linux.vnet.ibm.com>;
	Wed, 22 Jun 2016 17:35:46 -0400
In-Reply-To: <CAE40pdccu3HnO3PdEX1fUEQk40jBrmteHs9hKA9+aboRUJz1sA@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Brendan Gregg <brendan.d.gregg@gmail.com>
Cc: "linux-perf-use." <linux-perf-users@vger.kernel.org>, Wang Nan <wangnan0@huawei.com>, Hari Bathini <hbathini@linux.vnet.ibm.com>, Ananth M <ananth@linux.vnet.ibm.com>, "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>

Hi Brendan,

On Wednesday 22 June 2016 04:02 AM, Brendan Gregg wrote:
> G'Day Aravinda,
> 
> Sorry for the delay; answers inline:
> 
> On Fri, Jun 10, 2016 at 3:28 AM, Aravinda Prasad
> <aravinda@linux.vnet.ibm.com> wrote:
>>
>> Hi Brendan,
>>
>> I though of replying to your mail as I saw you running perf inside a
>> docker container. I believe you would be interested in events specific
>> to the container context as you are using "perf record -a".
>>
>> We are working on supporting "container-aware tracing" i.e., whenever
>> you run "perf record -a" inside a container it should report
>> container-wide events rather than system-wide events. Towards that goal,
>> we posted an RFC patch in LKML [1] last year and also discussed possible
>> ways to restrict events within a container in Plumbers (Container
>> Microconf) [2].
> 
> Sounds great.
> 
>>
>>
>> Based on the discussion in Container Microconf, we are coming up with a
>> new prototype which should be ready for review by next week. The new
>> prototype introduces a new namespace "perf-namespace" (namespace name is
>> just a placeholder. Suggestions welcome). If the container is created
>> with perf-namespace, then "perf record -a" inside the container reports
>> only those events that are triggered within the container.
> 
> I'd think that this restriction should be the default, rather than
> needing to create a container with a perf-namespace. Why wouldn't it
> make use of the existing pid namespace?

Our initial prototype (lkml.org/lkml/2015/7/15/192) was based on
pid-namespace. However, during the discussion in Plumbers, it was
mentioned that the requirement of PID namespace is insufficient for
containers that need access to the host PID namespace as these
containers are created without a PID namespace. Hence, we thought of
introducing perf-namespace.

We have posted the RFC patches for perf-namespace prototype:
https://lkml.org/lkml/2016/6/14/547

> 
>>
>> We would like to know if you are looking for "container-aware tracing"
>> and also like to know the scenarios/problems you are trying to debug by
>> running perf inside a container.
> 
> Yes, perf needs to be container-aware.
> 
> To start with, we'd like to profile apps running inside Docker
> containers, either by running perf in the container, or by running
> perf from the host. As in, "perf record -F49 -a -g -- sleep 30". I've
> tried both and had both approaches work, with some wrestling of
> /tmp/perf-PID.map files and things.

We are also working on enabling running perf from host with a container
ID as an argument. This is in addition to enabling perf inside a container.

> 
> If perf was container-aware, then running it in the container should
> be the easiest way to profile an app, if it's only sampling that
> container.
> 
> Also, from within a container, I'd expect to be able to sample kernel
> stacks that are running for the container processes (eg, syscalls),
> but not asynchronous kernel threads that are running host-wide (eg,
> background fsflush).

Our current and previous prototypes sample kernel events which are
triggered from the container context. And yes, they do not include
events from asynchronous kernel threads.

> 
> More advanced things would involve tracing syscall latency and using
> BPF for latency histograms, from within a container. That should be
> allowed.

Sure. Noted.

> 
> What about tracepoints? Should a container be able to use the block
> I/O tracepoints and see disk I/O latency histograms? Filtering this to
> be just the container's block I/O would be tricky. Doing it
> system-wide may be allowable, depending on a setting in
> perf_event_paranoid. I think in some environments, having a container
> trace all tracepoints (disk, tcp, etc) is ok, provided to data is
> leaked from another container; whereas in other environments tracing
> non-container events would not be ok. Hence setting this in
> perf_event_paranoid.

Yes, filtering such tracepoints to just the container's instance is
tricky and we have not yet figured out any solution for that.

Regards,
Aravinda

> 
> Brendan
> 

-- 
Regards,
Aravinda
