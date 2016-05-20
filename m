From: Brendan Gregg <brendan.d.gregg@gmail.com>
Subject: Re: Getting PEBS to work
Date: Thu, 19 May 2016 17:19:28 -0700
Message-ID: <CAE40pdehnoK4yO-050=0cfbw8viegNmiXKUZYxw8nMXgi6TGzg@mail.gmail.com>
References: <CAE40pdfx+LMiwXMZNaLVkT_XsaYFmQQqW5iOr63JnCfOhkFBmQ@mail.gmail.com>
 <CAPAnC4NObR7Fe-fZr9z5tdD0cyyVhd6WojN-aWst2Z2rtxQ6SQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-ig0-f195.google.com ([209.85.213.195]:35612 "EHLO
	mail-ig0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754590AbcETAT6 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 19 May 2016 20:19:58 -0400
Received: by mail-ig0-f195.google.com with SMTP id jn6so9131567igb.2
        for <linux-perf-users@vger.kernel.org>; Thu, 19 May 2016 17:19:58 -0700 (PDT)
In-Reply-To: <CAPAnC4NObR7Fe-fZr9z5tdD0cyyVhd6WojN-aWst2Z2rtxQ6SQ@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: jim mauro <jim.mauro@gmail.com>
Cc: "linux-perf-use." <linux-perf-users@vger.kernel.org>

On Thu, May 19, 2016 at 5:09 PM, jim mauro <jim.mauro@gmail.com> wrote:
> Hey Brendan - This seems to be working:
>
> # perf stat -e r4301c0:pp -a -- sleep 10
>
>  Performance counter stats for 'system wide':
>
>           80845274      r4301c0:pp
>
>       10.001588491 seconds time elapsed
>
> It's this event:
>
> INST_RETIRED.PREC_DIST:Precise instruction retired event with HW to reduce
> effect of PEBS shadow in IP distribution
> cpu/umask=0x01,event=0xC0,name=INST_RETIRED.PREC_DIST/

Woah, you typed r4301c0. :) Dunno what that is. Doesn't work for me anyway:

# perf stat -e r4301c0:pp -a -- sleep 10
^Csleep: Interrupt

 Performance counter stats for 'system wide':

   <not supported> r4301c0:pp

       2.297987255 seconds time elapsed

Nor did r01c0. But pretty interesting you got PEBS output, and on
Linux 3.8. So maybe my 3.13 isn't the problem...

Brendan
