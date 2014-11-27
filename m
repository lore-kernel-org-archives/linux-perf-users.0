From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: Size of perf data files
Date: Thu, 27 Nov 2014 09:56:21 +0900
Message-ID: <87oarto40a.fsf@sejong.aot.lge.com>
References: <1601237.BEhNSa8l6d@milian-kdab2>
	<20141126160617.GD30226@kernel.org> <1439400.fEBkspRaxp@milian-kdab2>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from LGEMRELSE6Q.lge.com ([156.147.1.121]:51488 "EHLO
	lgemrelse6q.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753218AbaK0A43 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 26 Nov 2014 19:56:29 -0500
In-Reply-To: <1439400.fEBkspRaxp@milian-kdab2> (Milian Wolff's message of
	"Wed, 26 Nov 2014 19:11:01 +0100")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <mail@milianw.de>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, linux-perf-users <linux-perf-users@vger.kernel.org>

Hi Milian,

On Wed, 26 Nov 2014 19:11:01 +0100, Milian Wolff wrote:
> I tried this on a benchmark of mine:
>
> before:
> [ perf record: Woken up 196 times to write data ]
> [ perf record: Captured and wrote 48.860 MB perf.data (~2134707 samples) ]
>
> after, with dwarf,512
> [ perf record: Woken up 18 times to write data ]
> [ perf record: Captured and wrote 4.401 MB perf.data (~192268 samples) ]
>
> What confuses me though is the number of samples. When the workload is equal, 
> shouldn't the number of samples stay the same? Or what does this mean? The 
> resulting reports both look similar enough.

It's bogus - it just calculates the number of samples based on the file
size (with fixed sample size).  I think we should either show the correct
number as we post-process samples for build-id detection or simply
remove it.

Thanks,
Namhyung
