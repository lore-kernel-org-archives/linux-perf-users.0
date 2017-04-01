From: Benjamin King <benjaminking@web.de>
Subject: Re: How to sample memory usage cheaply?
Date: Sat, 1 Apr 2017 18:27:38 +0200
Message-ID: <20170401162738.GB8989@localhost>
References: <20170330200404.GA1915@localhost>
 <2288291.HPAjuFhd8F@agathebauer>
 <20170401074112.GA8989@localhost>
 <alpine.DEB.2.20.1704010952260.19001@macbook-air>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.17.12]:55801 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751724AbdDAQ1q (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 1 Apr 2017 12:27:46 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1704010952260.19001@macbook-air>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Vince Weaver <vincent.weaver@maine.edu>
Cc: Milian Wolff <milian.wolff@kdab.com>, linux-perf-users@vger.kernel.org

Hi Vince,

>> Also, the 'perf stat' output that I sent does not make much sense to me right
>> now. For example, when I add MAP_POPULATE to the flags for mmap, I only see
>> ~40 minor page faults, which I do not understand at all.
>
>have you tried accessing your file in random order?  I think the kernel is
>likely doing some sort of readahead/prefetching.  I think you can change
>that behavior with the madvise() syscall

No, I did not try that. Just reading in every 4096th byte. I did assume that
any way of populating the page table of my process would show up as a page
fault. I guess, I have to read a bit more on that...

Cheers,
  Benjamin
