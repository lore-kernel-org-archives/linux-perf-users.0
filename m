From: Brendan Gregg <brendan.d.gregg@gmail.com>
Subject: Re: perf bpf examples
Date: Thu, 7 Jul 2016 10:54:17 -0700
Message-ID: <CAE40pdc7+gv2L7u+7CfFjmDQUv3rsV13XkAGDSrCq_FSOqLFdA@mail.gmail.com>
References: <CAE40pdfDNi-+80az4YNa9asLGyOJc2e5RcPgFxz5FK9VwgRUtw@mail.gmail.com>
 <577DB50D.3040204@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-it0-f51.google.com ([209.85.214.51]:33926 "EHLO
	mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752496AbcGGRys (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 7 Jul 2016 13:54:48 -0400
Received: by mail-it0-f51.google.com with SMTP id j185so3017916ith.1
        for <linux-perf-users@vger.kernel.org>; Thu, 07 Jul 2016 10:54:47 -0700 (PDT)
In-Reply-To: <577DB50D.3040204@huawei.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "Wangnan (F)" <wangnan0@huawei.com>
Cc: "linux-perf-use." <linux-perf-users@vger.kernel.org>

On Wed, Jul 6, 2016 at 6:49 PM, Wangnan (F) <wangnan0@huawei.com> wrote:
>
>
>
> On 2016/7/7 4:29, Brendan Gregg wrote:
>>
>> G'Day,
>>
>> Are perf bpf examples shared anywhere? I've seen many posted to lkml
>> (by Wang Nan), but don't see them in the linux source, or
>> documentation. Would be very handy to throw them all up somewhere for
>> searching/learning, if that hasn't already happened, eg, github.
>>
>> I was also looking to see if perf bpf supports sampling yet, but I
>> don't think it does. Eg, imagine a:
>>
>> perf record -F 99 -e bpf_process_samples.c -a -- sleep 10
>>
>> which would require BPF attaching to perf_swevent_hrtimer()/etc, and
>> also emitting a map (eg, sampled instruction pointer counts). I don't
>> think perf currently does either, but was hoping for a collection of
>> examples to double check.
>
>
> Currently perf-bpf doesn't support dumpping resuling maps, but
> we are working on it. I think you have read our uBPF approach:
>
> http://article.gmane.org/gmane.linux.kernel/2203717
>
> and
>
> http://article.gmane.org/gmane.linux.kernel/2253579
>
> in them we embeded a uBPF virtual machine to perf and give it
> the ability to operate the result in maps.
>
> Now we are trying another approach, introduce LLVM to perf,
> compile data analysis and report to code. It would be much
> powerful.


Great, thanks!

But what about a set of examples covering the existing perf+bpf
capabilities so far? I know you've emailed them to lkml, but has
someone put them all in one place yet? If not, I can go through lkml
and at least put them on github so we can search and learn from them.

Brendan
