From: Brendan Gregg <brendan.d.gregg@gmail.com>
Subject: Re: perf segfault in docker container
Date: Tue, 21 Jun 2016 15:43:01 -0700
Message-ID: <CAE40pdcLugg+pEdWku-Kmf7YN4D-QNkhTzPF+HPoskzBj0Y=6Q@mail.gmail.com>
References: <CAE40pdfWpz6rreOCMJCs1P8WXfOXO_B5zZoeOyC_5usYGp8xRQ@mail.gmail.com>
 <575A9660.4070907@linux.vnet.ibm.com> <CAE40pdccu3HnO3PdEX1fUEQk40jBrmteHs9hKA9+aboRUJz1sA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-io0-f171.google.com ([209.85.223.171]:35526 "EHLO
	mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752132AbcFUWnc (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 21 Jun 2016 18:43:32 -0400
Received: by mail-io0-f171.google.com with SMTP id f30so29402008ioj.2
        for <linux-perf-users@vger.kernel.org>; Tue, 21 Jun 2016 15:43:31 -0700 (PDT)
In-Reply-To: <CAE40pdccu3HnO3PdEX1fUEQk40jBrmteHs9hKA9+aboRUJz1sA@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Cc: "linux-perf-use." <linux-perf-users@vger.kernel.org>, Wang Nan <wangnan0@huawei.com>, Hari Bathini <hbathini@linux.vnet.ibm.com>, Ananth M <ananth@linux.vnet.ibm.com>, "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>

On Tue, Jun 21, 2016 at 3:32 PM, Brendan Gregg
<brendan.d.gregg@gmail.com> wrote:
> G'Day Aravinda,
>
[...]
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
>
> If perf was container-aware, then running it in the container should
> be the easiest way to profile an app, if it's only sampling that
> container.
>
> Also, from within a container, I'd expect to be able to sample kernel
> stacks that are running for the container processes (eg, syscalls),
> but not asynchronous kernel threads that are running host-wide (eg,
> background fsflush).
>
> More advanced things would involve tracing syscall latency and using
> BPF for latency histograms, from within a container. That should be
> allowed.
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
>
> Brendan

An addition for container-aware tracing: perf from the host should be
able to find the correct /tmp/perf-PID.map files, even though they are
in the container /tmp's.

Brendan
