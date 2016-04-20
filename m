From: Andi Kleen <andi@firstfloor.org>
Subject: Re: Ability for classifying of measurements\
Date: Wed, 20 Apr 2016 10:47:24 -0700
Message-ID: <20160420174724.GP9407@two.firstfloor.org>
References: <1461099117-21401-1-git-send-email-leonardo.boquillon@tallertechnologies.com>
 <87ega0whpq.fsf@tassilo.jf.intel.com>
 <CAF5HaEXOwn0_b=an2RR2FT++ktRXLpAP2WHPE7O=kdVKVRYKVQ@mail.gmail.com>
 <CAF5HaEW29wA6ZtNkGhTdFQGwoZp=QWaxEgt3n_7Ph+iA2YVyxQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from one.firstfloor.org ([193.170.194.197]:46554 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752055AbcDTRr2 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 20 Apr 2016 13:47:28 -0400
Content-Disposition: inline
In-Reply-To: <CAF5HaEW29wA6ZtNkGhTdFQGwoZp=QWaxEgt3n_7Ph+iA2YVyxQ@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Daniel Gutson <daniel.gutson@tallertechnologies.com>
Cc: Andi Kleen <andi@firstfloor.org>, Leonardo Boquillon <leonardo.boquillon@tallertechnologies.com>, linux-perf-users@vger.kernel.org

>  Agree, this was the first step. What we would like to see implemented from
>  this feature is, 1) some dwarf-aided ability to specify watched variables in
>  the perf record command (e.g. perf record --groupby="::var1,
> class1::staticvar2" ),
> and 2) provide an API to the applications so they can
>  communicate with perf_events telling what's going on, such as the example we
>  are showing here (which is *just* an example to fuel this discussion). This
>  API would lead to intrusively mess the code of the app but not more than
>  people already do with debugging printfs; this would be very important for
>  performance-centric applications.

perf probe has an ability to reference variables relative
to a register or in a register, and parse dwarf for it. 

I'm not sure it's a good idea to have a lot of arbitrary memory
accesses in the PMI handler (although there is already some for stack
walking)

One problem with global variables is that they can move
around with ASLR, so it can be difficult to find them.

If the variable is in a register you can already get it from the PEBS
record on Intel CPUs.  There is no good tooling for it currently,
but the information is in perf script output, and can be enabled
for perf record.

An easy way to implement it would be to use a
global register variable (register asm("...") ...).
However you would need to rebuild all your libraries to preserve
the global register.

Best would be to use an unused register. One that comes to
mind on x86-64bit Linux is GS, which is normally only used by the kernel.

With this pending patchkit[1] the application can write to it
using WRGSBASE, previously it needed a syscall.

Currently perf cannot log GS I believe, but that would be fairly
easy to add. Would also need some tooling to make the value
an extra sort key in perf report.

-Andi
