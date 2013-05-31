From: David Ahern <dsahern@gmail.com>
Subject: Re: Getting started with perf; a couple of questions
Date: Thu, 30 May 2013 23:41:56 -0600
Message-ID: <51A83824.1090907@gmail.com>
References: <CAJLXCZTs4i0P3wA78u25aCt-rfcsBNQ8t0QSsbWazQyoV-XdLA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178]:35163 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750962Ab3EaFmF (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 31 May 2013 01:42:05 -0400
Received: by mail-pd0-f178.google.com with SMTP id w11so1609270pde.9
        for <linux-perf-users@vger.kernel.org>; Thu, 30 May 2013 22:42:04 -0700 (PDT)
In-Reply-To: <CAJLXCZTs4i0P3wA78u25aCt-rfcsBNQ8t0QSsbWazQyoV-XdLA@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Andrew Davidoff <davidoff@qedmf.net>
Cc: linux-perf-users@vger.kernel.org

On 5/30/13 11:26 PM, Andrew Davidoff wrote:
> Hi,
>
> I am getting started with perf and have a couple of questions.
>
> * Does the version of perf being used need to be built from the source
> for the running kernel, or is it supported to use a build from a newer
> kernel source? I am currently running perf built from 3.9.4 kernel
> sources on a machine running kernel 2.6.32.

In general, perf userspace from upstream can work with any kernel 
version. The only problem I can recall is 2.6.31 -- ie., upstream does 
not work with 2.6.31 and prior.

>
> * I am getting event output with a specific `perf stat` invocation,
> but when I run the same invocation under `perf record`, `perf report`
> complains "The perf.data file has no samples". Why would that be? The
> invocation looks like this:
>
> perf record -e cache-misses,page-faults,minor-faults,major-faults,cpu-migrations,L1-dcache-load-misses,L1-dcache-store-misses,L1-icache-load-misses,LLC-load-misses,LLC-store-misses,dTLB-load-misses,dTLB-store-misses,iTLB-load-misses
> -- {program} {arg} {arg} ... {arg}

add a -v and see if more info comes out.

perf script can be used to dump events.

David
