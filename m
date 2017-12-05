From: Michael Petlan <mpetlan@redhat.com>
Subject: Re: [PATCH] perf test shell: Fix check open filename arg using 'perf
 trace'
Date: Wed, 6 Dec 2017 00:18:59 +0100 (CET)
Message-ID: <alpine.LRH.2.20.1712060007430.9416@Diego>
References: <alpine.LRH.2.20.1711291656270.9416@Diego> <84d4a40a-dfbf-6d9b-9eb2-6912dc6f57e4@linux.vnet.ibm.com> <20171130155642.GA2893@redhat.com> <20171201023314.GC30867@sejong> <20171201151628.GB3298@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44457 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752734AbdLEXTD (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 5 Dec 2017 18:19:03 -0500
In-Reply-To: <20171201151628.GB3298@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Arnaldo de Melo <acme@redhat.com>, Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@redhat.com>, kernel-team@lge.com

On Fri, 1 Dec 2017, Arnaldo Carvalho de Melo wrote:
> Em Fri, Dec 01, 2017 at 11:33:14AM +0900, Namhyung Kim escreveu:
[...]
>  
> > > What differs from x86 to others is that x86 uses syscalltbl, not requiring
> > > audit-libs to map syscall numbers to names, so perhaps it is something in there...
>  
> > If it only needs to consider open or openat, why not specifying the
> > both directly?
>  
> >   # perf trace -e open -e openat touch /etc/passwd
> 
> Same effect, works with other perf trace versions, but one suggestion to
> make it shorter:
> 
> 	perf trace -e open,openat touch /etc/passwd
> 
> Does the same thing :-)

Well, do I understand it correctly, that we prefer the "-e open,openat" over
the "-e 'open*'" because there are issues with the globbing feature on some
architectures?

I see a disadvantage of "-e open,openat" concept in that it does not work
in case any of them is unavailable. So in case some kernel does not contain
e.g. open in favor of openat, perf-trace fails to trace them. This can be
easily simulated like `perf trace -e open,openit`:

event syntax error: 'openit'
                     \___ Cannot find PMU `openit'. Missing kernel support?
Run 'perf list' for a list of valid events

Since it is possible that open is not even supported, having both of them
there is fragile. The "-e 'open*'" approach should expand only to supported
syscalls.

The '' are necessary there, since just open* can expand to some filename.

.....

I also see problems with globbing on my aarch64 with 4.14, so that makes
the "-e 'open*'" fragile too...

Ideas?

> 
> Michael, can you please take that into account and resubmit the patch?
> 
> - Arnaldo
> --
> To unsubscribe from this list: send the line "unsubscribe linux-perf-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
