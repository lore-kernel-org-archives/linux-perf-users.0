From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH] perf script: Initialize callchain_param.record_mode
Date: Mon, 17 Aug 2015 10:47:50 -0300
Message-ID: <20150817134750.GA20670@kernel.org>
References: <2045576.NEBzYG4lu7@agathebauer>
 <20150813071724.GA21322@krava.brq.redhat.com>
 <6934587.54gAAgWtJU@agathebauer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:54954 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751427AbbHQNry (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 17 Aug 2015 09:47:54 -0400
Content-Disposition: inline
In-Reply-To: <6934587.54gAAgWtJU@agathebauer>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <milian.wolff@kdab.com>
Cc: Jiri Olsa <jolsa@redhat.com>, Perf Users <linux-perf-users@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, David Ahern <dsahern@gmail.com>, Ingo Molnar <mingo@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>

Em Thu, Aug 13, 2015 at 10:53:36AM +0200, Milian Wolff escreveu:
> On Thursday, August 13, 2015 09:17:24 AM Jiri Olsa wrote:
> > right you are.. does attached patch help?
> 
> <snip>
> 
> Hey Jiri,
> 
> it works a treat!
> 
> Many thanks, much appreciated.

Adding a "Tested-by: Milian", Ok?

- Arnaldo
