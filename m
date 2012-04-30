From: Namhyung Kim <namhyung.kim@lge.com>
Subject: Re: LLC-* events not working on sandybridge
Date: Mon, 30 Apr 2012 17:43:02 +0900
Message-ID: <87ehr5sj8p.fsf@sejong.aot.lge.com>
References: <sa7r4v7foi5.fsf@wragg.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from LGEMRELSE6Q.lge.com ([156.147.1.121]:63824 "EHLO
	LGEMRELSE6Q.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753828Ab2D3IoD (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 30 Apr 2012 04:44:03 -0400
In-Reply-To: <sa7r4v7foi5.fsf@wragg.org> (David Wragg's message of "Sun, 29
	Apr 2012 00:03:14 +0100")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: David Wragg <david@wragg.org>
Cc: linux-perf-users@vger.kernel.org

Hi,

On Sun, 29 Apr 2012 00:03:14 +0100, David Wragg wrote:
> Hi,
>
> I've run into a problem with perf on an Intel Sandybridge machine: The
> LLC-* events never seem to trigger.
>
> For example:
>
> $ perf stat -e LLC-load-misses ls /
> [...]
>                  0 LLC-load-misses
>
>        0.001082639 seconds time elapsed
>
> Non-LLC events work fine:
>
> $ perf stat -e cache-misses ls /
> [...]
>              4,272 cache-misses
>
>        0.002945606 seconds time elapsed
>
> This is on a Intel i5 machine (i5-2520M), running a fully updated Fedora
> 16 ('perf --version': 3.3.2-6.fc16.x86_64, 'uname -r':
> 3.3.2-6.fc16.x86_64).
>
> Any ideas?
>
> David

I have a same problem on my i7-3930K machine. I guess it's because of
lacking of extra register (MSP_OFFCORE_RSP_X) settings. But I have no
idea of how I can set it properly :(.

Thanks,
Namhyung
