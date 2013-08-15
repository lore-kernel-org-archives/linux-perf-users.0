From: Peipei Wang <wangpeipei.90@gmail.com>
Subject: Re: How can I write a script and use perf script to process the
 record data periodically
Date: Thu, 15 Aug 2013 17:19:43 -0400
Message-ID: <CAEuYUepVHp4rh0AJob5JhPPb3R5JeVyRqaCwcAx+Z+V+-=efOA@mail.gmail.com>
References: <CAEuYUep7Ph+QnOonkvEAropiUqCFV9e-DT9ygcP7LDNEyV6SMQ@mail.gmail.com>
	<520D08AA.9000605@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-vb0-f53.google.com ([209.85.212.53]:47237 "EHLO
	mail-vb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751133Ab3HOVTo (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 15 Aug 2013 17:19:44 -0400
Received: by mail-vb0-f53.google.com with SMTP id i3so1032997vbh.26
        for <linux-perf-users@vger.kernel.org>; Thu, 15 Aug 2013 14:19:44 -0700 (PDT)
In-Reply-To: <520D08AA.9000605@gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: David Ahern <dsahern@gmail.com>
Cc: perf group <linux-perf-users@vger.kernel.org>

Hi David,

What I want to do is as this: Unlike using perf record to write
samples to a perf.data,  I want to just read each 100 samples and do
some statistics on them and write down the statistical data rather
than the raw sampling information.

The Man page of Perf script says that :

           'perf script <script> <required-script-args> <command>' to
both  record the events required for <script> and to run the <script>
   using 'live-mode' i.e. without writing anything to disk.

Not writing things down to disk is what I want, because when too many
samples will pose great impact on disks. That's what I try to avoid.



Best wishes.
Yours,
Wang Peipei


On Thu, Aug 15, 2013 at 12:58 PM, David Ahern <dsahern@gmail.com> wrote:
> On 8/14/13 3:19 PM, Peipei Wang wrote:
>>
>> Hi all,
>>
>> I want to use perf script to process the data sampled by "perf record"
>> since it is huge overhead to just write down all the samples.
>> Processing the samples every minute is what I am desperate to do.
>
>
> I don't follow what you are trying to do. perf-script can pretty print each
> sample -- time, cpu, task, pid/tid, etc (that option of perf-script is
> really a misnomer and this should be a perf-dump command).
>
> From there you want to process the samples?
>
> If you know perl or python take a look at the scripts in
> tools/perf/scripts/python. I have not written external scripts, so can't
> offer any suggestions for you.
>
> David
