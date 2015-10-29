From: Stephane Eranian <eranian@google.com>
Subject: Re: perf script branch stack output
Date: Thu, 29 Oct 2015 10:59:40 -0700
Message-ID: <CABPqkBQ98pZATj9hgTT=-FRjSrGBGoT-4cgbDHk=M_9Gvc6H2g@mail.gmail.com>
References: <CAJh9x3ocJtpNf7+ZNcRkB4=68im0mr-aYmZ=jTnWqrcsnu=7Vg@mail.gmail.com>
	<20151029153307.GC2923@kernel.org>
	<20151029153525.GD2923@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:37964 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756914AbbJ2R7m (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 29 Oct 2015 13:59:42 -0400
Received: by wicll6 with SMTP id ll6so49913402wic.1
        for <linux-perf-users@vger.kernel.org>; Thu, 29 Oct 2015 10:59:41 -0700 (PDT)
In-Reply-To: <20151029153525.GD2923@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Yuanfang Chen <cyfmxc@gmail.com>, linux-perf-users@vger.kernel.org

On Thu, Oct 29, 2015 at 8:35 AM, Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
> Em Thu, Oct 29, 2015 at 12:33:07PM -0300, Arnaldo Carvalho de Melo escreveu:
>> Em Thu, Oct 29, 2015 at 10:14:49AM -0400, Yuanfang Chen escreveu:
>> > There is a patch to output branch stack here.
>> > https://lkml.org/lkml/2015/8/31/315. Any reason it is still not
>> > committed? I'm going to use the patch on my machine. Just want to make
>> > sure. Thank you.
>>
>> Read the thread, Stephane said he would send a v2, probably I saw that I
>> refrained from applying it, waiting for such v2, I'm checking if it
>> applies cleanly now, if it does I'll apply it as-is.
>
> It does, applied to my perf/core branch, will go upstream in my next
> pull request to Ingo, thanks for pointing this out!
>
I posted V2 a long time ago. Glad to see it eventually made it!
