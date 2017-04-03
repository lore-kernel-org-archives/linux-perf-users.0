From: Benjamin King <benjaminking@web.de>
Subject: Re: How to sample memory usage cheaply?
Date: Mon, 3 Apr 2017 21:09:50 +0200
Message-ID: <20170403190950.GA29118@localhost>
References: <20170330200404.GA1915@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.17.12]:50604 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751282AbdDCTJx (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 3 Apr 2017 15:09:53 -0400
Received: from localhost ([31.19.65.168]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0McnuP-1cdrSQ17g1-00Hyo8 for
 <linux-perf-users@vger.kernel.org>; Mon, 03 Apr 2017 21:09:51 +0200
Content-Disposition: inline
In-Reply-To: <20170330200404.GA1915@localhost>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

On Thu, Mar 30, 2017 at 10:04:04PM +0200, Benjamin King wrote:

Hi,

I learned a bit more about observing memory with perf. If this is not the
right place to discuss this any more, just tell me to shut up :-)

wrapping this up a bit:
>I'd like to get a big picture of where a memory hogging process uses physical
>memory. I'm interested in call graphs, [...] I'd love to
>analyze page faults

I have learned that first use of a physical page is called "page allocation",
which can be traced via the event kmem:mm_page_alloc. This is the pyhsical
analogue of and different from "page faults" that happen in virtual memory.

Maping a file with MAP_POPULATE after dropping filesystem caches (sysctl -w
vm.drop_caches=3) will show the right number in kmem:mm_page_alloc, namely
the size/4K. 4K is the page size on my system.

If I do the same again without dropping caches in between, mm_page_alloc does
not show the same number, but rather the number of pages it takes to hold the
page table entries. This is nice and fairly complete, but I still hope to
find a way to observe when a page from the filesystem cache is referenced for
the first time from my process. This would allow me to do without the cache
dropping.

Page faults from virtual memory are more opaque to me. They only seem to be
counted when the system did not prepare the process via prefetching. For
example, MAP_POPULATE'd mappings will not count towards page faults, neither
minor nor major ones.

To control some of the prefetching, there is a debugfs knob called
/sys/kernel/debug/fault_around_bytes, but reducing this to the minimum on my
machine does not produce a page fault number that I could easily explain, at
least not in the MAP_POPULATE case. It might work better when actually
reading data from the mapped file.

Anticipating page faults and preventing them proactively is a nice service
from the OS, but I would be delighted if there was a way to trace this as
well, similar to how mm_page_alloc will count each and every pyhsical
allocation.  This would make page faults more useful as a poor man's memory
tracker.

Cheers,
  Benjamin
