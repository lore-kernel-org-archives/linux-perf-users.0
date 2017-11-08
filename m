From: Vince Weaver <vincent.weaver@maine.edu>
Subject: Re: perf utility question: "Sky high iTLB-load-misses"
Date: Wed, 8 Nov 2017 11:55:02 -0500 (EST)
Message-ID: <alpine.DEB.2.20.1711081152280.1975@macbook-air>
References: <20171108163440.GA10004@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="-1463802360-2003161943-1510160105=:1975"
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-io0-f172.google.com ([209.85.223.172]:52521 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751763AbdKHQzH (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 8 Nov 2017 11:55:07 -0500
Received: by mail-io0-f172.google.com with SMTP id f20so6634047ioj.9
        for <linux-perf-users@vger.kernel.org>; Wed, 08 Nov 2017 08:55:07 -0800 (PST)
In-Reply-To: <20171108163440.GA10004@redhat.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: =?ISO-8859-15?Q?Jan_Pokorn=FD?= <poki@redhat.com>
Cc: linux-perf-users@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463802360-2003161943-1510160105=:1975
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Wed, 8 Nov 2017, Jan Pokorný wrote:

> Is iTLB-load-misses > 100% reported because of some deficiency
> of the platform, a bug in perf, or an expected behaviour?

If you look into the kernel, the two events being measured are
	[ C(RESULT_ACCESS) ] = 0x2085,  /* ITLB_MISSES.STLB_HIT */
	[ C(RESULT_MISS)   ] = 0xe85,   /* ITLB_MISSES.WALK_COMPLETED */

If you look this up in Intel Vol3b you can see that the "access" metric
measures First level ITLB misses that hit in the Second-level TLB

Wheras the miss metric is a list of accesses from any level that caused a 
walk of the page tables.

So the events don't necessarily sound like they match up very well, so 
it's beleivable you will get odd results when trying to calculate 
percentages based on them.

Vince
---1463802360-2003161943-1510160105=:1975--
