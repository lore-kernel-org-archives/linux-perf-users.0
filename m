From: "Wangnan (F)" <wangnan0@huawei.com>
Subject: Re: perf bpf examples
Date: Thu, 7 Jul 2016 09:49:01 +0800
Message-ID: <577DB50D.3040204@huawei.com>
References: <CAE40pdfDNi-+80az4YNa9asLGyOJc2e5RcPgFxz5FK9VwgRUtw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:60890 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755627AbcGGBtd (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 6 Jul 2016 21:49:33 -0400
In-Reply-To: <CAE40pdfDNi-+80az4YNa9asLGyOJc2e5RcPgFxz5FK9VwgRUtw@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Brendan Gregg <brendan.d.gregg@gmail.com>, "linux-perf-use." <linux-perf-users@vger.kernel.org>



On 2016/7/7 4:29, Brendan Gregg wrote:
> G'Day,
>
> Are perf bpf examples shared anywhere? I've seen many posted to lkml
> (by Wang Nan), but don't see them in the linux source, or
> documentation. Would be very handy to throw them all up somewhere for
> searching/learning, if that hasn't already happened, eg, github.
>
> I was also looking to see if perf bpf supports sampling yet, but I
> don't think it does. Eg, imagine a:
>
> perf record -F 99 -e bpf_process_samples.c -a -- sleep 10
>
> which would require BPF attaching to perf_swevent_hrtimer()/etc, and
> also emitting a map (eg, sampled instruction pointer counts). I don't
> think perf currently does either, but was hoping for a collection of
> examples to double check.

Currently perf-bpf doesn't support dumpping resuling maps, but
we are working on it. I think you have read our uBPF approach:

http://article.gmane.org/gmane.linux.kernel/2203717

and

http://article.gmane.org/gmane.linux.kernel/2253579

in them we embeded a uBPF virtual machine to perf and give it
the ability to operate the result in maps.

Now we are trying another approach, introduce LLVM to perf,
compile data analysis and report to code. It would be much
powerful.

Thank you.

> Brendan
