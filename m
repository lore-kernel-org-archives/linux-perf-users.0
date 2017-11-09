From: Vince Weaver <vincent.weaver@maine.edu>
Subject: Re: perf utility question: "Sky high iTLB-load-misses"
Date: Thu, 9 Nov 2017 14:37:46 -0500 (EST)
Message-ID: <alpine.DEB.2.20.1711091434560.27723@macbook-air>
References: <20171108163440.GA10004@redhat.com> <alpine.DEB.2.20.1711081152280.1975@macbook-air> <20171109135325.GJ4333@kernel.org> <20171109143838.GY2482@two.firstfloor.org> <20171109185047.GC10004@redhat.com>
 <CABYXEkuMqU=EXZ8h7x7BK+_rX-fB7SHMNHm4LBV+V7kH2kcQng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-it0-f41.google.com ([209.85.214.41]:46629 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752824AbdKITh7 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 9 Nov 2017 14:37:59 -0500
Received: by mail-it0-f41.google.com with SMTP id f187so12721061itb.1
        for <linux-perf-users@vger.kernel.org>; Thu, 09 Nov 2017 11:37:59 -0800 (PST)
In-Reply-To: <CABYXEkuMqU=EXZ8h7x7BK+_rX-fB7SHMNHm4LBV+V7kH2kcQng@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Bram Stolk <b.stolk@gmail.com>
Cc: =?ISO-8859-15?Q?Jan_Pokorn=FD?= <poki@redhat.com>, Andi Kleen <andi@firstfloor.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Peter Zijlstra <peterz@infradead.org>, linux-perf-users@vger.kernel.org

On Thu, 9 Nov 2017, Bram Stolk wrote:

> Vince mentioned that two values are compared which do not relate well.
> I would say the two possible approaches would then be:
> (1) report absolute numbers only, no percentage.
> (2) don't report it.

Well they possibly don't relate well.  You would need an advanced degree 
in computer architecture and/or an NDA with Intel to know for sure what's 
really going on.

On modern procesors any event more complicated than "cycles" and 
"instructions" can be nearly impossible to understand, and even cycles has 
a lot of corner cases.

Vince
