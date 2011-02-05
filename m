From: Arun Sharma <arun@sharma-home.net>
Subject: Re: [RFC] --dump-sym-trace
Date: Fri, 4 Feb 2011 17:48:40 -0800
Message-ID: <AANLkTi=QdnJ2R-9bn4r+njwAnNewvWvBO2GRw6W4qwnj@mail.gmail.com>
References: <AANLkTin3bp90ybuUDFQijspV0uBw=zTnczcPLBaZvO7p@mail.gmail.com>
	<4D3F871B.3060906@cisco.com>
	<AANLkTinik0+Zp7N54bkh5fBzF1hb2XoubRbuMXwBeYGZ@mail.gmail.com>
	<4D433811.7020904@cisco.com>
	<20110129205050.GH6345@ghostprotocols.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:52733 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752355Ab1BEBsl (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 4 Feb 2011 20:48:41 -0500
Received: by iyj8 with SMTP id 8so319583iyj.19
        for <linux-perf-users@vger.kernel.org>; Fri, 04 Feb 2011 17:48:40 -0800 (PST)
In-Reply-To: <20110129205050.GH6345@ghostprotocols.net>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Cc: David Ahern <daahern@cisco.com>, linux-perf-users@vger.kernel.org

On Sat, Jan 29, 2011 at 12:50 PM, Arnaldo Carvalho de Melo
<acme@ghostprotocols.net> wrote:
> /me too
>
> I have to get back to that, it is definetely a feature we need to have.

There are a couple of more minor nits I found in David's patch:

* perf record --timehist doesn't seem to be doing anything. I used
perf record -T -a.
* Some of the printfs are missing checks along the lines of:

--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -228,6 +228,7 @@ static int perf_session__print_sample(struct
perf_session *session,
                free(syms);

        } else {
+               if (!data || !al || !al->thread || !al->sym ||
!al->map) return 0;
                printf(TIMEHIST_FMT,
                           tstr, data->cpu,
                           al->thread->comm, al->thread->pid, al->addr,

to avoid SIGSEGVs when the information in the sample is incomplete.

 -Arun
