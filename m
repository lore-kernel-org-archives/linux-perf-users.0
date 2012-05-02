From: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Subject: Re: [BUG] perf top -G is broken
Date: Wed, 2 May 2012 13:02:50 -0300
Message-ID: <20120502160250.GB5745@infradead.org>
References: <87pqanmh2y.fsf@sejong.aot.lge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:58741 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756091Ab2ECO0B (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 3 May 2012 10:26:01 -0400
Received: by vcqp1 with SMTP id p1so1287952vcq.19
        for <linux-perf-users@vger.kernel.org>; Thu, 03 May 2012 07:26:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <87pqanmh2y.fsf@sejong.aot.lge.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Namhyung Kim <namhyung.kim@lge.com>
Cc: linux-perf-users@vger.kernel.org

Em Wed, May 02, 2012 at 11:50:45AM +0900, Namhyung Kim escreveu:
> 
> Hi,
> 
> Some guy reported me that perf top -G is broken with segment fault. I
> can reproduce it on my system easily but the time is vary - few seconds
> to 30 minutes. I ran it with --stdio to get a core file:

Does it help to increase --mmap-pages from its default, 128, to
something like 512 or more?

Also try running with -r 90.

- Arnaldo
