From: Vince Weaver <vincent.weaver@maine.edu>
Subject: Re: How to sample memory usage cheaply?
Date: Sat, 1 Apr 2017 09:54:02 -0400 (EDT)
Message-ID: <alpine.DEB.2.20.1704010952260.19001@macbook-air>
References: <20170330200404.GA1915@localhost> <2288291.HPAjuFhd8F@agathebauer> <20170401074112.GA8989@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-it0-f65.google.com ([209.85.214.65]:34053 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751478AbdDANyK (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 1 Apr 2017 09:54:10 -0400
Received: by mail-it0-f65.google.com with SMTP id e75so4461367itd.1
        for <linux-perf-users@vger.kernel.org>; Sat, 01 Apr 2017 06:54:10 -0700 (PDT)
In-Reply-To: <20170401074112.GA8989@localhost>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Benjamin King <benjaminking@web.de>
Cc: Milian Wolff <milian.wolff@kdab.com>, linux-perf-users@vger.kernel.org


On Sat, 1 Apr 2017, Benjamin King wrote:
> Also, the 'perf stat' output that I sent does not make much sense to me right
> now. For example, when I add MAP_POPULATE to the flags for mmap, I only see
> ~40 minor page faults, which I do not understand at all.

have you tried accessing your file in random order?  I think the kernel is 
likely doing some sort of readahead/prefetching.  I think you can change 
that behavior with the madvise() syscall

Vince
