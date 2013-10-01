From: Vince Weaver <vincent.weaver@maine.edu>
Subject: Re: 'annotate' confusingly reports 'add' instruction as taking most
 CPU time
Date: Tue, 1 Oct 2013 08:53:40 -0400 (EDT)
Message-ID: <alpine.DEB.2.10.1310010850260.11671@vincent-weaver-1.um.maine.edu>
References: <CAK-tuPbbbWcbJxk88xO_urj2ktk861xnG+tkOs0cZBjnowjMeA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-qc0-f175.google.com ([209.85.216.175]:58392 "EHLO
	mail-qc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753179Ab3JAMqQ (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 1 Oct 2013 08:46:16 -0400
Received: by mail-qc0-f175.google.com with SMTP id v2so4590527qcr.20
        for <linux-perf-users@vger.kernel.org>; Tue, 01 Oct 2013 05:46:15 -0700 (PDT)
In-Reply-To: <CAK-tuPbbbWcbJxk88xO_urj2ktk861xnG+tkOs0cZBjnowjMeA@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Johan Tibell <johan.tibell@gmail.com>
Cc: linux-perf-users@vger.kernel.org

On Mon, 30 Sep 2013, Johan Tibell wrote:

> I'm trying to use 'perf record' to find the hotspot inside a function.
> The results I'm seeing are confusing. 'annotate' claims that a simple
> 'add' instruction is the main CPU time consumer"
> 
>         0.00 :          408246:       mov    0x8(%rbp),%rsi
>                                                                0.31 :
>         40824a:       mov    0x10(%rbp),%rcx
>                                               0.00 :          40824e:
>      lea    0x4(%rcx),%rdi
>                                 0.81 :          408252:       mov
> 0x6(%rbx),%rbx
>                   0.00 :          408256:       mov
> 0x18(%rbx,%rax,8),%r8
>      --->   27.58 :          40825b:       add    $0x20,%rbp
> 
> 0.00 :          40825f:       jmpq   408338 <Main_zdwpolyzugo_info>
>                                              0.00 :          408264:
>     mov    $0x7b9609,%ebx
>                            0.00 :          408269:       add
> $0x20,%rbp
>                     0.00 :          40826d:       jmpq   *0x0(%rbp)
> 
>         5.41 :          408270:       mov    0xd(%rbx),%rax
> 
> How shall I interpret this? Is it really the following jump that is to blame?

It looks like you're noticing "skid" which means the PC returned by the 
profiling is a little beyond the problem instruction because it is hard 
for the CPU to stop in exactly the right place.

Typically the problem instruction will be a few before, not after.  I
wouldn't think an unconditional branch would have much performance impact.

What CPU do you have?  What event are you measuring?  If you have a new 
enough system you can look into using the (I think) ":p" flags to try to 
get more precise results, if you aren't already.

Vince
