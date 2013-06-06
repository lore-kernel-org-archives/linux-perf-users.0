From: David Ahern <dsahern@gmail.com>
Subject: Re: Getting started with perf; a couple of questions
Date: Thu, 06 Jun 2013 08:01:23 -0600
Message-ID: <51B09633.2040204@gmail.com>
References: <CAJLXCZTs4i0P3wA78u25aCt-rfcsBNQ8t0QSsbWazQyoV-XdLA@mail.gmail.com> <51A83824.1090907@gmail.com> <CAJLXCZTzRdLYmcRVTO_AeRawmZ55AtdABcKpu5T5A-Z89iHnbA@mail.gmail.com> <CAJLXCZTN1xLXk79kh5i8WbJBB+4sh0Qs1v+PndhLKSrPPvZ2wQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pb0-f47.google.com ([209.85.160.47]:52987 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750870Ab3FFOB1 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 6 Jun 2013 10:01:27 -0400
Received: by mail-pb0-f47.google.com with SMTP id rr13so642416pbb.34
        for <linux-perf-users@vger.kernel.org>; Thu, 06 Jun 2013 07:01:26 -0700 (PDT)
In-Reply-To: <CAJLXCZTN1xLXk79kh5i8WbJBB+4sh0Qs1v+PndhLKSrPPvZ2wQ@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Andrew Davidoff <davidoff@qedmf.net>
Cc: linux-perf-users@vger.kernel.org

On 5/31/13 2:35 PM, Andrew Davidoff wrote:
> On Fri, May 31, 2013 at 1:09 AM, Andrew Davidoff <davidoff@qedmf.net> wrote:
>> I will play with this more tomorrow but any further advice is
>> appreciated. I feel like I'm probably just missing a switch or
>> something that's not entirely obvious from the scant documentation I
>> have found.
>
> After struggling a bit more with this on the original host:
>
> Ubuntu 10.04.4 LTS
> kernel 2.6.32-47-server
> perf versions 3.9.4 and 3.8.13
>
> with no change in results, I gave it a shot on a CentOS 6 virtual
> machine on my Mac:
>
> CentOS release 6.4 (Final)
> kernel 3.9.4 AND kernel 2.6.32-358.2.1.el6.x86_64
> perf version 3.9.4
>
> And perf record is working as I'd expect it to. To be clear about the
> description above, under CentOS,  perf record 3.9.4 is recording
> samples whether I'm running kernel 3.9.4 or 2.6.32-358.2.1.el6.x86_64.

It's a VM and not running on KVM so there is no PMU which means the -e 
cycles is most likely falling back to -e cpu-clock. You should see this 
in a message with the -v flag on record. perf-script should dump out the 
events and show cpu-clock versus cycles.

Based on that I suggest trying -e cpu-clock on your original host. If 
that works then something is messed up with the pmu config on the host.

David
>
> So...Ubuntu thing? Or maybe just a 10.04 thing (yeah, I know it's old).
>
> Maybe this'll help someone.
>
> Thanks all.
> Andy
>
