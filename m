From: Brendan Gregg <brendan.d.gregg@gmail.com>
Subject: Re: perf segfault in docker container
Date: Tue, 21 Jun 2016 15:32:27 -0700
Message-ID: <CAE40pdccu3HnO3PdEX1fUEQk40jBrmteHs9hKA9+aboRUJz1sA@mail.gmail.com>
References: <CAE40pdfWpz6rreOCMJCs1P8WXfOXO_B5zZoeOyC_5usYGp8xRQ@mail.gmail.com>
 <575A9660.4070907@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-io0-f180.google.com ([209.85.223.180]:35428 "EHLO
	mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751626AbcFUWdU (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 21 Jun 2016 18:33:20 -0400
Received: by mail-io0-f180.google.com with SMTP id f30so29232407ioj.2
        for <linux-perf-users@vger.kernel.org>; Tue, 21 Jun 2016 15:32:57 -0700 (PDT)
In-Reply-To: <575A9660.4070907@linux.vnet.ibm.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Cc: "linux-perf-use." <linux-perf-users@vger.kernel.org>, Wang Nan <wangnan0@huawei.com>, Hari Bathini <hbathini@linux.vnet.ibm.com>, Ananth M <ananth@linux.vnet.ibm.com>, "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>

G'Day Aravinda,

Sorry for the delay; answers inline:

On Fri, Jun 10, 2016 at 3:28 AM, Aravinda Prasad
<aravinda@linux.vnet.ibm.com> wrote:
>
> Hi Brendan,
>
> I though of replying to your mail as I saw you running perf inside a
> docker container. I believe you would be interested in events specific
> to the container context as you are using "perf record -a".
>
> We are working on supporting "container-aware tracing" i.e., whenever
> you run "perf record -a" inside a container it should report
> container-wide events rather than system-wide events. Towards that goal,
> we posted an RFC patch in LKML [1] last year and also discussed possible
> ways to restrict events within a container in Plumbers (Container
> Microconf) [2].

Sounds great.

>
>
> Based on the discussion in Container Microconf, we are coming up with a
> new prototype which should be ready for review by next week. The new
> prototype introduces a new namespace "perf-namespace" (namespace name is
> just a placeholder. Suggestions welcome). If the container is created
> with perf-namespace, then "perf record -a" inside the container reports
> only those events that are triggered within the container.

I'd think that this restriction should be the default, rather than
needing to create a container with a perf-namespace. Why wouldn't it
make use of the existing pid namespace?

>
> We would like to know if you are looking for "container-aware tracing"
> and also like to know the scenarios/problems you are trying to debug by
> running perf inside a container.

Yes, perf needs to be container-aware.

To start with, we'd like to profile apps running inside Docker
containers, either by running perf in the container, or by running
perf from the host. As in, "perf record -F49 -a -g -- sleep 30". I've
tried both and had both approaches work, with some wrestling of
/tmp/perf-PID.map files and things.

If perf was container-aware, then running it in the container should
be the easiest way to profile an app, if it's only sampling that
container.

Also, from within a container, I'd expect to be able to sample kernel
stacks that are running for the container processes (eg, syscalls),
but not asynchronous kernel threads that are running host-wide (eg,
background fsflush).

More advanced things would involve tracing syscall latency and using
BPF for latency histograms, from within a container. That should be
allowed.

What about tracepoints? Should a container be able to use the block
I/O tracepoints and see disk I/O latency histograms? Filtering this to
be just the container's block I/O would be tricky. Doing it
system-wide may be allowable, depending on a setting in
perf_event_paranoid. I think in some environments, having a container
trace all tracepoints (disk, tcp, etc) is ok, provided to data is
leaked from another container; whereas in other environments tracing
non-container events would not be ok. Hence setting this in
perf_event_paranoid.

Brendan
