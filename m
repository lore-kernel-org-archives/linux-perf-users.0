From: Benjamin King <benjaminking@web.de>
Subject: Re: Re: perf tracepoints for regular user?
Date: Mon, 25 Jan 2016 16:43:43 +0100
Message-ID: <20160125154343.GA11166@localhost>
References: <20160115210516.GA6329@localhost>
 <4927145.OUESRpdSEU@agathebauer>
 <20160119050244.GA13183@localhost>
 <20160119221858.GK27085@kernel.org>
 <trinity-4241dafc-74f5-4560-80af-3b9ba8eefece-1453290633763@3capp-webde-bs16>
 <20160121140505.GB2312@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.15.14]:58479 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754225AbcAYPnx (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 25 Jan 2016 10:43:53 -0500
Content-Disposition: inline
In-Reply-To: <20160121140505.GB2312@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-perf-users <linux-perf-users@vger.kernel.org>

On Thu, Jan 21, 2016 at 11:05:05AM -0300, Arnaldo Carvalho de Melo wrote:
>Not having tracefs, if that is indeed the case, only means that the
>remount isn't needed, as what is in tracefs is what, before its
>existence, lived in a debugfs directory, /sys/kernel/debug/tracing, i.e.
>remounting just /sys/kernel/debug/ would then be enough.

I could not make /sys/kernel/debug/tracing available to a regular users even
after upgrading to kernel 4.4, so I just did a desperate system upgrade and -
lo and behold - it now works, by which I mean
 1) tracefs is mounted and when remounted world readable...
 2) ...regular users can read /sys/kernel/debug/tracing/uprobe_events and...
 3) ...see the probes in perf and...
 4) ...use them for tracing.

So it was all my fault, being too lazy to upgrade, thanks for the help and
sorry for the noise!

Cheers,
  Benjamin
